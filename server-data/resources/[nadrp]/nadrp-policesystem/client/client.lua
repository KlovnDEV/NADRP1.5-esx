ESX = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

local ACTIVE = false
local ACTIVE_EMERGENCY_PERSONNEL = {}

Citizen.CreateThread(function()
	while true do 
		if IsPedArmed(PlayerPedId(), 6) then
			Citizen.Wait(0)
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        else
			Citizen.Wait(500)
		end
	end
end)

RegisterCommand('svhelp', function(source, args, raw)
	local pData = ESX.GetPlayerData()
	if pData.job.name == 'police' then
		TriggerEvent('chat:addMessage', {
			template = [[<div class="chat-message popo">
			SV HELP: <br>
			/sv 1 = Crown vic<br>
			/sv 2 = Crown Vic 2 <br>
			/sv 3 = Taurus <br>
			/sv 4 = 2015 Charger <br>
			/sv 5 = Tahoe <br>
			/sv 6 = Raptor <br>
			/sv 7 = Boat <br>
			/sv 8 = Explorer <br>
			/sv 9 = Mustang <br>
			/sv 10 = ASU <br>
			/sv 11 = Bike <br> 
			/sv 12 = 2018 charger <br>
			/sv 13 = Prison Bus <br> 
			/sv 14 = Police Pedal Bike <br>
			/sv 15 = Police Transport Van </div>]],
			args = {}
		})
	elseif pData.job.name == 'ambulance' then
		TriggerEvent('chat:addMessage', {
			template = [[<div class="chat-message popo">
			SV HELP: <br>
			/sv 1 = Ambulance<br>
			/sv 2 = EMS Heli <br>
			/sv 3 = EMS F350 <br>
			/sv 4 = EMS Tahoe <br>
			/sv 5 = EMS Charger <br>
			/sv 6 = LS Coroner <br>]],
			args = {}
		})
	else
		exports['mythic_notify']:DoHudText('error', 'You dont have permissions')
	end
end)


RegisterNetEvent('fine:Anim')
AddEventHandler('fine:Anim', function()
	RequestAnimDict('mp_common')
    while not HasAnimDictLoaded('mp_common') do
        Citizen.Wait(5)
    end
    TaskPlayAnim(PlayerPedId(), "mp_common", "givetake1_a", 8.0, -8, -1, 12, 1, 0, 0, 0)
end)

function IsNearAuthLocation()
	for i=1, #Config.AuthLocations do
		local coords = GetEntityCoords(PlayerPedId())
		if #(Config.AuthLocations[i] - coords) <= 60 then 
			return true
		end
	end
	return false
end

RegisterCommand('sv', function(pSource, pArgs, pRaw)
	local NearAuth = IsNearAuthLocation()
	local ped = PlayerPedId()
	if NearAuth then
		local pData = ESX.GetPlayerData()
		local args = tonumber(pArgs[1])
		if pArgs[1] == nil then
			return
		else
			if pData.job.name == "police" then
				if Config.VehList[args] == nil then
					return
				end
				local model = GetHashKey(Config.VehList[args])
				local coords    = GetOffsetFromEntityInWorldCoords(ped, 1.5, 0.0, 0.0)
				local heading = GetEntityHeading(ped)
				ESX.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					TriggerEvent("ARPF:spawn:recivekeys", vehicle, plate)
				end)
			elseif pData.job.name == "ambulance" then
				if Config.VehListEMS[args] == nil then
					return
				end
				local model = GetHashKey(Config.VehListEMS[args])
				local coords    = GetOffsetFromEntityInWorldCoords(ped, 1.5, 0.0, 0.0)
				local heading = GetEntityHeading(ped)
				ESX.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					TriggerEvent("ARPF:spawn:recivekeys", vehicle, plate)
				end)
			end
		end
	end
end)

RegisterCommand('tint', function(source, args, raw)
	for i=1, #Config.AuthLocations, 1  do
		local player = GetPlayerPed(-1)
		local coords = GetEntityCoords(player, 0)
        local AuthLocations = Config.AuthLocations[i]
		local Auth = GetDistanceBetweenCoords(AuthLocations, coords, true)
		if Auth <= 60 then
			local PlayerData = ESX.GetPlayerData()
			if PlayerData.job.name == 'police' or PlayerData.job.name == 'mechanic' or PlayerData.job.name == 'offmechanic'  then
				local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
				SetVehicleModKit(vehicle, 0)
				SetVehicleWindowTint(vehicle, tonumber(args[1]))
			end
		end
	end
end)

RegisterCommand('extra', function(source, args, rawCommand)
	for i=1, #Config.AuthLocations, 1  do
		local player = GetPlayerPed(-1)
		local coords = GetEntityCoords(player, 0)
        local AuthLocations = Config.AuthLocations[i]
		local Auth = GetDistanceBetweenCoords(AuthLocations, coords, true)
		local PlayerData = ESX.GetPlayerData()
		if Auth <= 60 then

			if PlayerData.job.name == 'police' or  PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offpolice' or PlayerData.job.name == 'offambulance' or PlayerData.job.name == 'mechanic' or PlayerData.job.name == 'offmechanic' then
			    local ped = PlayerPedId()
			    local veh = GetVehiclePedIsIn(ped, false)
			    local extraID = tonumber(args[1])
			    local toggle = tostring(args[2])
			    if toggle == 'true' then
			        toggle = 0
			    end
			    if veh ~= nil and veh ~= 0 and veh ~= 1 then
			        if extraID == all then
			            SetVehicleAutoRepairDisabled(veh, false)
						SetVehicleExtra(veh, 1, toggle)
						SetVehicleExtra(veh, 2, toggle)
						SetVehicleExtra(veh, 3, toggle)
						SetVehicleExtra(veh, 4, toggle)
						SetVehicleExtra(veh, 5, toggle)
						SetVehicleExtra(veh, 6, toggle)
						SetVehicleExtra(veh, 7, toggle)
						SetVehicleExtra(veh, 8, toggle)
						SetVehicleExtra(veh, 9, toggle)
						SetVehicleExtra(veh, 10, toggle)
						SetVehicleExtra(veh, 11, toggle)
						SetVehicleExtra(veh, 12, toggle)
						SetVehicleExtra(veh, 13, toggle)
						SetVehicleExtra(veh, 14, toggle)
						SetVehicleExtra(veh, 15, toggle)
						SetVehicleExtra(veh, 16, toggle)
						SetVehicleExtra(veh, 17, toggle)
						SetVehicleExtra(veh, 18, toggle)
						SetVehicleExtra(veh, 19, toggle)
						SetVehicleExtra(veh, 20, toggle)
						SetVehicleExtra(veh, 21, toggle)
			        else
			            SetVehicleAutoRepairDisabled(Vehicle, false)
			            SetVehicleExtra(veh, extraID, toggle)
			        end
			    end
			end
		end
	end
end, false)

RegisterCommand('livery', function(source, args, rawCommand)
	for i=1, #Config.AuthLocations, 1  do
		local player = GetPlayerPed(-1)
		local coords = GetEntityCoords(player, 0)
        local AuthLocations = Config.AuthLocations[i]
		local Auth = GetDistanceBetweenCoords(AuthLocations, coords, true)
		local PlayerData = ESX.GetPlayerData()
		if Auth <= 60 then

			if PlayerData.job.name == 'police' or  PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offpolice' or PlayerData.job.name == 'offambulance'  then
				local Veh = GetVehiclePedIsIn(GetPlayerPed(-1))
				local livery = tonumber(args[1])
				SetVehicleLivery(Veh, livery)
			end
		end
	end
end)


--[[RegisterCommand('impound', function(source)
	if PlayerData.job.name == 'police' or  PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offpolice' or PlayerData.job.name == 'offambulance'  then
		TriggerEvent('impoundVeh', source)
	end
end)]]

--[[RegisterCommand('fix', function(source)
	for i=1, #Config.AuthLocations, 1 do
		local player = GetPlayerPed(-1)
		local coords = GetEntityCoords(player, 0)
        local AuthLocations = Config.AuthLocations[i]
		local Auth = GetDistanceBetweenCoords(AuthLocations, coords, true)
		if Auth <= 60 then
			if PlayerData.job.name == 'police' or  PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offpolice' or PlayerData.job.name == 'offambulance'  or PlayerData.job.name == 'cardealer'  then
				TriggerEvent('veh:fixVehicle')
            end
        end
	end
end)]]

RegisterNetEvent('impoundVeh')
AddEventHandler('impoundVeh', function()
	local vehicle, attempt = ESX.Game.GetVehicleInDirection(), 0
	while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
		Citizen.Wait(100)
		NetworkRequestControlOfEntity(vehicle)
		attempt = attempt + 1
	end

	if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
		local timer = 1500
	    local finished = exports["nadrp-taskbar"]:taskBar(timer,"Impounding Vehicle")

	    if finished == 100 then
			ESX.Game.DeleteVehicle(vehicle)
	    end
	end
end)

RegisterNetEvent('veh:fixVehicle')
AddEventHandler('veh:fixVehicle', function()
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    if veh ~= nil then 
        exports['t0sic_loadingbar']:StartDelayedFunction('Repairing Vehicle', 15000, function()
            SetVehicleFixed(veh)
            FreezeEntityPosition(veh, false)
        end)
    end
end)

-- Testing RunPlate

RegisterNetEvent('PolRunPlate')
AddEventHandler('PolRunPlate', function()
	local vehicle = wow()
	local vehicleData = daddy(vehicle)
	if vehicleData == nil then
  		TriggerEvent('DoLongHudText','Too far from vehicle',1, 4000)
  	else
  		BitchWhat(vehicleData)
  	end
end)


RegisterCommand('runplate', function(vehicleData)
	local PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'police' or PlayerData.job.name == 'mechanic' then
		TriggerEvent('PolRunPlate')
	end
end)