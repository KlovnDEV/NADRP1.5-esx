local currentPlate = ""
local currentType = 0

local job = ""
local grade = 0
local callsign = "TBD"

local unitCooldown = false
local alertsToggled = true
local unitBlipsToggled = true
local callBlipsToggled = true

local callBlips = {}
local blips = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("tac:getSharedObject",function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    Citizen.Wait(2000)

    local jobInfo = {}
    jobInfo[Config.JobOne.job] = {
        color = Config.JobOne.color,
        column = 1,
        label = Config.JobOne.label,
        canRequestLocalBackup = Config.JobOne.canRequestLocalBackup,
        canRequestOtherJobBackup = Config.JobOne.canRequestOtherJobBackup,
        forwardCall = Config.JobOne.forwardCall,
        canRemoveCall = Config.JobOne.canRemoveCall
    }
    jobInfo[Config.JobTwo.job] = {
        color = Config.JobTwo.color,
        column = 2,
        label = Config.JobTwo.label,
        canRequestLocalBackup = Config.JobTwo.canRequestLocalBackup,
        canRequestOtherJobBackup = Config.JobTwo.canRequestOtherJobBackup,
        forwardCall = Config.JobTwo.forwardCall,
        canRemoveCall = Config.JobTwo.canRemoveCall
    }
    jobInfo[Config.JobThree.job] = {
        color = Config.JobThree.color,
        column = 3,
        label = Config.JobThree.label,
        canRequestLocalBackup = Config.JobThree.canRequestLocalBackup,
        canRequestOtherJobBackup = Config.JobThree.canRequestOtherJobBackup,
        forwardCall = Config.JobThree.forwardCall,
        canRemoveCall = Config.JobThree.canRemoveCall
    }

    ESX.TriggerServerCallback("core_dispatch:getPersonalInfo", function(firstname, lastname)
        SendNUIMessage({
            type = "Init",
            firstname = firstname,
            lastname = lastname,
            jobInfo = jobInfo
        })
    end)
end)

RegisterKeyMapping(Config.OpenMenuCommand, "Open Disptach using " .. Config.OpenMenuKey, "keyboard", Config.OpenMenuKey)
RegisterCommand(Config.OpenMenuCommand, function() 
    openDisptach()
end,false)

RegisterCommand(Config.JobOne.callCommand,function(source, args, rawCommand)
    local msg = rawCommand:sub(5)
    local cord = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("core_dispatch:addMessage",msg,{cord[1], cord[2], cord[3]},Config.JobOne.job,5000,Config.callCommandSprite,Config.callCommandColor)
end,false)

RegisterCommand(Config.JobTwo.callCommand, function(source, args, rawCommand)
    local msg = rawCommand:sub(5)
    local cord = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("core_dispatch:addMessage",msg,{cord[1], cord[2], cord[3]},Config.JobTwo.job,5000,Config.callCommandSprite,Config.callCommandColor)
end,false)

RegisterCommand(Config.JobThree.callCommand, function(source, args, rawCommand)
    local msg = rawCommand:sub(5)
    local cord = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("core_dispatch:addMessage",msg,{cord[1], cord[2], cord[3]},Config.JobThree.job,5000,Config.callCommandSprite,Config.callCommandColor)
end,false)

function addBlipForCall(sprite, color, coords, text)
    local alpha = 250
    local radius = AddBlipForRadius(coords, 40.0)
    local blip = AddBlipForCoord(coords)

    SetBlipSprite(blip, sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 1.3)
    SetBlipColour(blip, color)
    SetBlipAsShortRange(blip, false)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(tostring(text))
    EndTextCommandSetBlipName(blip)

    SetBlipHighDetail(radius, true)
    SetBlipColour(radius, color)
    SetBlipAlpha(radius, alpha)
    SetBlipAsShortRange(radius, true)

    table.insert(callBlips, blip)
    table.insert(callBlips, radius)

    while alpha ~= 0 do
        Citizen.Wait(Config.CallBlipDisappearInterval)
        alpha = alpha - 1
        SetBlipAlpha(radius, alpha)

        if alpha == 0 then
            RemoveBlip(radius)
            RemoveBlip(blip)
         
            return
        end
    end
end

function addBlipsForUnits()
    ESX.TriggerServerCallback("core_dispatch:getUnits", function(units)
        local id = callsign

        for _, z in pairs(blips) do
            RemoveBlip(z)
        end

        blips = {}

        for k, v in pairs(units) do
            if k ~= id and (Config.JobOne.job == v.job or Config.JobTwo.job == v.job or Config.JobThree.job == v.job) then
                local color = 0
                local title = ""
                if Config.JobOne.job == v.job then
                    color = Config.JobOne.blipColor
                    title = Config.JobOne.label
                end
                if Config.JobTwo.job == v.job then
                    color = Config.JobTwo.blipColor
                    title = Config.JobTwo.label
                end
                if Config.JobThree.job == v.job then
                    color = Config.JobThree.blipColor
                    title = Config.JobThree.label
                end

                local new_blip = AddBlipForEntity(NetworkGetEntityFromNetworkId(v.netId))

                SetBlipSprite(new_blip, Config.Sprite[v.type])
                ShowHeadingIndicatorOnBlip(new_blip, true)
                HideNumberOnBlip(new_blip)
                SetBlipScale(new_blip, 0.7)
                SetBlipCategory(new_blip, 7)
                SetBlipColour(new_blip, color)
                SetBlipAsShortRange(new_blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("(" .. title .. ") " .. v.firstname .. " " .. v.lastname)
                EndTextCommandSetBlipName(new_blip)
                blips[k] = new_blip
            end
        end
    end)
end

function openDisptach()
    if Config.JobOne.job == job or Config.JobTwo.job == job or Config.JobThree.job == job then
        SetNuiFocus(false, false)
        ESX.TriggerServerCallback("core_dispatch:getInfo", function(units, calls, ustatus)
            SetNuiFocus(true, true)
            SendNUIMessage({
                type = "open",
                units = units,
                calls = calls,
                ustatus = ustatus,
                job = job,
                id = callsign
            })
        end)
    end
end

RegisterNetEvent("core_dispatch:callAdded")
AddEventHandler("core_dispatch:callAdded", function(id, call, j, cooldown, sprite, color)
    if job == j and alertsToggled then
        SendNUIMessage({
            type = "call",
            id = id,
            call = call,
            cooldown = cooldown
        })
        if Config.AddCallBlips then
            addBlipForCall(sprite, color, vector3(call.coords[1], call.coords[2], call.coords[3]), id)
        end
    end
end)

RegisterNetEvent('shrp-dispatch:myCallsign')
AddEventHandler('shrp-dispatch:myCallsign', function(pCallsign)
    callsign = pCallsign
end)

RegisterNUICallback("dismissCall",function(data)
    local id = data["id"]:gsub("call_", "")
    TriggerServerEvent("core_dispatch:unitDismissed", id, callsign)
    DeleteWaypoint()
end)

RegisterNUICallback("updatestatus",function(data)
    local id = data["id"]
    local status = data["status"]
    TriggerServerEvent("core_dispatch:changeStatus", id, status)
end)

RegisterNUICallback("sendnotice",function(data)
    local caller = data["caller"]
    if Config.EnableUnitArrivalNotice then
        TriggerServerEvent("core_dispatch:arrivalNotice", caller)
    end
end)

RegisterNetEvent("core_dispatch:arrivalNotice")
AddEventHandler("core_dispatch:arrivalNotice",function()
    if not unitCooldown then
        SendTextMessage(Config.Text["someone_is_reacting"])
        unitCooldown = true
        Citizen.Wait(20000)
        unitCooldown = false
    end
end)

RegisterNUICallback("reqbackup",function(data)
    local j = data["job"]
    local req = data["requester"]
    local firstname = data["firstname"]
    local lastname = data["lastname"]
    SendTextMessage(Config.Text["backup_requested"])
    local cord = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("core_dispatch:addCall","00-00",req .. " is requesting help",{
        {icon = "fa-user-friends", info = firstname .. " " .. lastname}
    },{cord[1], cord[2], cord[3]},j)
end)

RegisterNUICallback("toggleoffduty",function(data)
    ToggleDuty()
end)

RegisterNUICallback("togglecallblips",function(data)
    callBlipsToggled = not callBlipsToggled
    if callBlipsToggled then
        for _, z in pairs(callBlips) do
            SetBlipDisplay(z, 4)
        end
        SendTextMessage(Config.Text["call_blips_turned_on"])
    else
        for _, z in pairs(callBlips) do
            SetBlipDisplay(z, 0)
        end

        SendTextMessage(Config.Text["call_blips_turned_off"])
    end
end)

RegisterNUICallback("toggleunitblips",function(data)
    unitBlipsToggled = not unitBlipsToggled
    if unitBlipsToggled then
        addBlipsForUnits()
        SendTextMessage(Config.Text["unit_blips_turned_on"])
    else
        for _, z in pairs(blips) do
            RemoveBlip(z)
        end

        blips = {}
        SendTextMessage(Config.Text["unit_blips_turned_off"])
    end
end)

RegisterNUICallback("togglealerts",function(data)
    alertsToggled = not alertsToggled

    if alertsToggled then
        SendTextMessage(Config.Text["alerts_turned_on"])
    else
        SendTextMessage(Config.Text["alerts_turned_off"])
    end
end)

RegisterNUICallback("copynumber",function(data)
    SendTextMessage(Config.Text["phone_number_copied"])
end)

RegisterNUICallback("forwardCall",function(data)
    local id = data["id"]:gsub("call_", "")

    SendTextMessage(Config.Text["call_forwarded"])
    TriggerServerEvent("core_dispatch:forwardCall", id, data["job"])
end)

RegisterNUICallback("acceptCall",function(data)
    local id = data["id"]:gsub("call_", "")
    SetNewWaypoint(tonumber(data["x"]), tonumber(data["y"]))
    TriggerServerEvent("core_dispatch:unitResponding", id, job, callsign)
end)

RegisterNUICallback("removeCall",function(data)
    local id = data["id"]:gsub("call_", "")
    SendTextMessage(Config.Text["call_removed"])
    TriggerServerEvent("core_dispatch:removeCall", id)
end)

RegisterNUICallback("close",function(data)
    SetNuiFocus(false, false)
end)

--Shots in area
Citizen.CreateThread(function()
    while Config.EnableShootingAlerts do
        local ped = PlayerPedId()

        if not armed then
            if IsPedArmed(ped, 7) and not IsPedArmed(ped, 1) then
                armed = true
            end
        end

        if armed then
            Citizen.Wait(10)
            local playerPos = GetEntityCoords(ped)
            local veh = IsPedInAnyVehicle(ped, false)
            for _, v in ipairs(Config.ShootingZones) do
                local distance = #(playerPos - v.coords)
                if distance < v.radius then
                    whithin = true
                end
            end
            if IsPedShooting(ped) and math.random(1, 2) == 1 then
                local gender = "unknown"
                local model = GetEntityModel(ped)
                if IsPedMale(ped) then
                    gender = "male"
                else
                    gender = "female"
                end
                local location = GetStreetName()
                if veh then
                    local vehicleData = GetVehicleDescription()
                    TriggerServerEvent( "core_dispatch:addCall", "10-71", "Shots fired from vehicle", {
                        {icon = "fas fa-car", info = "Model: "..vehicleData.model},
                        {icon = "fas fa-map-marker-alt", info = "Location: "..location},
                        {icon = "fas fa-id-card", info = "Plate: "..vehicleData.plate},
                        {icon = "fas fa-palette", info = "Color: "..vehicleData.firstColor}
                    }, {playerPos[1], playerPos[2], playerPos[3]}, "police", 5000, 156, 1)
                else
                    TriggerServerEvent( "core_dispatch:addCall", "10-71", "Shots in area", {
                        {icon = "fa-venus-mars", info = gender},
                        {icon = "fas fa-map-marker-alt", info = "Location: "..location}
                    }, {playerPos[1], playerPos[2], playerPos[3]}, "police", 5000, 156, 1)
                end
                Citizen.Wait(20000)
            end
        else
            Citizen.Wait(1000)
        end
        armed = false
    end
end)

Citizen.CreateThread(function()
    while Config.EnableMapBlipsForUnits do
        if Config.JobOne.job == job or Config.JobTwo.job == job or Config.JobThree.job == job then
            if unitBlipsToggled then
                addBlipsForUnits()
            end
        end
        Citizen.Wait(5000)
    end
end)

RegisterNetEvent('baseevents:enteredVehicle')
AddEventHandler('baseevents:enteredVehicle', function(currentVehicle)
    if job ~= "police" and job ~= "ambulance" and job ~= "mechanic" then
        return 
    end
    currentPlate = GetVehicleNumberPlateText(currentVehicle)
    currentType = GetVehicleClass(currentVehicle)
    local ped = PlayerPedId()
    while true do
        if not IsPedInAnyVehicle(PlayerPedId(), false) then 
            currentPlate = ""
            return
        end
        status = {
            carPlate = currentPlate,
            type = currentType,
            job = job,
            netId = NetworkGetNetworkIdFromEntity(PlayerPedId())
        }
        TriggerServerEvent("core_dispatch:playerStatus", status)
        Citizen.Wait(2000)
    end
end)

--EXPORTS

exports("addCall",function(code, title, extraInfo, coords, job, cooldown, sprite, color)
    TriggerServerEvent("core_dispatch:addCall", code, title, extraInfo, coords, job, cooldown or 5000, sprite or 11, color or 5)
end)

exports("addMessage",function(message, coords, job, cooldown, sprite, color)
    TriggerServerEvent("core_dispatch:addMessage", message, coords, job, sprite, cooldown or 5000, sprite or 11, color or 5)
end)

RegisterCommand('setcallsign', function(source, args, raw)
	local callSign = tonumber(args[1])
	local PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'police' then
		if callSign ~= nil then
			if type(callSign) == 'number' then
				if tonumber(callSign) < 99 or tonumber(callSign) > 999 then
					exports['mythic_notify']:DoLongHudText('error', 'Invalid callsign')
				else	
					TriggerServerEvent('shrp-dispatch:setCallSign', callSign)
				end
			else
				exports['mythic_notify']:DoLongHudText('error', 'Your callsign must be a number')
			end
		end
	end
end)

--[[RegisterCommand('clearblips', function(source,args,raw)
    
end)]]

AddEventHandler('onResourceStart', function(resource) -- Remove After test
    if resource == GetCurrentResourceName() then
        TriggerServerEvent('CheckMyCallSign')
    end
end)

RegisterNetEvent('shrp:playerBecameJob')
AddEventHandler('shrp:playerBecameJob', function(jobPassed)
    job = jobPassed.name
end)