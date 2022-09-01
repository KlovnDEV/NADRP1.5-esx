ESX = nil
myKeys = {}
latestveh = nil
factor = 0
local searchedVehs = {}
local hotwiredVehs = {}
local isActive = false
local haskeys = {}
local Time = 10 * 1000 -- Time for each stage (ms)
local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
local anim = "machinic_loop_mechandplayer"
local flags = 49
local trackedVehicles = {}
local hassearched = {}
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('tac:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)


RegisterNetEvent('tac:setJob')
AddEventHandler('tac:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterCommand("givekeys", function(source,args,raw)
    arg = args[1]
    vehicle = VehicleInFront()
    plate = GetVehicleNumberPlateText(vehicle)
    ped = GetPlayerPed(-1)
    if GetVehiclePedIsIn(ped, false) == 0 and DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
        local t, distance = GetClosestPlayer()
        if trackedVehicles[plate] ~= nil then
            if trackedVehicles[plate].canTurnOver == true then
                if (distance ~= -1 and distance < 3) then
                    if plate ~= nil then
                        TriggerServerEvent("ARPF:GiveKeys", GetPlayerServerId(t),vehicle,plate)
                        exports['mythic_notify']:SendAlert('success', 'You gave your keys to [ '..plate..' ]', 5000)
                    else
                        exports['mythic_notify']:SendAlert('error', 'You were unable to pass keys because the cars plate # was unable to be found ¯\\_(ツ)_/¯', 5000)
                    end
                else
                    exports['mythic_notify']:SendAlert('error', 'No one near you to give your keys to have them get closer', 5000)
                end
            else
                exports['mythic_notify']:SendAlert('error', 'You dont have keys to this car', 5000)
            end
        end
    elseif IsPedInAnyVehicle(ped, false) then
        veh = GetVehiclePedIsIn(ped, false)
        plate = GetVehicleNumberPlateText(veh)
        local t, distance = GetClosestPlayer()
        if trackedVehicles[plate] ~= nil then
            if trackedVehicles[plate].canTurnOver == true then
                if (distance ~= -1 and distance < 3) then
                    if plate ~= nil then
                        TriggerServerEvent("ARPF:GiveKeys", GetPlayerServerId(t),veh,plate)
                        exports['mythic_notify']:SendAlert('success', 'You gave your keys to'.. GetPlayerName(GetPlayerServerId(t)), 5000)
                    else
                        exports['mythic_notify']:SendAlert('error', 'You need to be outside looking at your car to give your keys OR be sitting in the car', 6000)
                    end
                else
                    exports['mythic_notify']:SendAlert('error', 'You were unable to pass keys because the cars plate # was unable to be found ¯\\_(ツ)_/¯', 5000)
                end
            else
                exports['mythic_notify']:SendAlert('error', 'You dont have keys to this car', 5000)
            end
        end
    else
        exports['mythic_notify']:SendAlert('error', 'No one near you to give your keys to have them get closer', 5000)
    end
end, false)

RegisterNetEvent('x-hotwire:givekeys')
AddEventHandler('x-hotwire:givekey', function()
    arg = args[1]
    vehicle = VehicleInFront()
    plate = GetVehicleNumberPlateText(vehicle)
    ped = GetPlayerPed(-1)
    if GetVehiclePedIsIn(ped, false) == 0 and DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
        local t, distance = GetClosestPlayer()
        if trackedVehicles[plate] ~= nil then
            if trackedVehicles[plate].canTurnOver == true then
                if (distance ~= -1 and distance < 3) then
                    if plate ~= nil then
                        TriggerServerEvent("ARPF:GiveKeys", GetPlayerServerId(t),vehicle,plate)
                        exports['mythic_notify']:SendAlert('success', 'You gave your keys to [ '..plate..' ]', 5000)
                    else
                        exports['mythic_notify']:SendAlert('error', 'You were unable to pass keys because the cars plate # was unable to be found ¯\\_(ツ)_/¯', 5000)
                    end
                else
                    exports['mythic_notify']:SendAlert('error', 'No one near you to give your keys to have them get closer', 5000)
                end
            else
                exports['mythic_notify']:SendAlert('error', 'You dont have keys to this car', 5000)
            end
        end
    elseif IsPedInAnyVehicle(ped, false) then
        veh = GetVehiclePedIsIn(ped, false)
        plate = GetVehicleNumberPlateText(veh)
        local t, distance = GetClosestPlayer()
        if trackedVehicles[plate] ~= nil then
            if trackedVehicles[plate].canTurnOver == true then
                if (distance ~= -1 and distance < 3) then
                    if plate ~= nil then
                        TriggerServerEvent("ARPF:GiveKeys", GetPlayerServerId(t),veh,plate)
                        exports['mythic_notify']:SendAlert('success', 'You gave your keys to'.. GetPlayerName(GetPlayerServerId(t)), 5000)
                    else
                        exports['mythic_notify']:SendAlert('error', 'You need to be outside looking at your car to give your keys OR be sitting in the car', 6000)
                    end
                else
                    exports['mythic_notify']:SendAlert('error', 'You were unable to pass keys because the cars plate # was unable to be found ¯\\_(ツ)_/¯', 5000)
                end
            else
                exports['mythic_notify']:SendAlert('error', 'You dont have keys to this car', 5000)
            end
        end
    else
        exports['mythic_notify']:SendAlert('error', 'No one near you to give your keys to have them get closer', 5000)
    end
end)

-- Shows a notification on the player's screen
function ShowNotification( text )
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(false, false)
end

local loading = false
local waiting = 0
RegisterNetEvent('x-hotwire:spawncar')
AddEventHandler('x-hotwire:spawncar', function(args)
    local car = args[1]
    if car == nil then
        exports['mythic_notify']:SendAlert('error', 'Model not found spawing adder instead (prevting crash)')
        car = "adder"
    end

    if loading then
        waiting = 10
        return
    end

    local coords = GetEntityCoords(PlayerPedId())
    vehiclehash = GetHashKey(car)
    RequestModel(vehiclehash)

    while not HasModelLoaded(vehiclehash) do
        loading = true
        Citizen.Wait(1000)
        waiting = waiting + 1
        if waiting > 10 then
            loading = false
            waiting = 0
            print("Could not load the vehicle model in time, a crash was prevented.")
            break
        end
    end
    if HasModelLoaded(vehiclehash) then
        veh = CreateVehicle(vehiclehash, coords.x, coords.y, coords.z, GetEntityHeading(PlayerPedId()), 1, 0)
        plate = GetVehicleNumberPlateText(veh)
        TriggerEvent('chopshop:setSpawnPlate', plate)
        TrackVehicle(plate, veh)
        TaskEnterVehicle(GetPlayerPed(-1), veh, 100, -1, 2, 16, 0)
        TriggerEvent("ARPF:spawn:recivekeys", veh,plate)
        loading = false
        waiting = 0
    end
end)

RegisterNetEvent('ARPF:spawn:recivekeys')
AddEventHandler('ARPF:spawn:recivekeys', function(vehicle,plate)
    ped = GetPlayerPed(-1)
    if vehicle ~= nil or plate ~= nil then
        vehicle = GetVehiclePedIsIn(ped, false)
        TrackVehicle(plate, vehicle)
        trackedVehicles[plate].canTurnOver = true
    end
end)

RegisterNetEvent('ARPF:recivekeys')
AddEventHandler('ARPF:recivekeys', function(name,vehicle,plates)
    ped = GetPlayerPed(-1)
    plypos = GetEntityCoords(ped, false)
    if IsPedInAnyVehicle(ped, 0) then
        veh = GetVehiclePedIsIn(ped, false)
        local plate = GetVehicleNumberPlateText(veh)
        if plates == plate then
            TrackVehicle(plate, veh)
            trackedVehicles[plate].canTurnOver = true
            exports['mythic_notify']:SendAlert('error', 'You recived keys from'..name.."for the vehicle with plate:"..plate, 6000)
        else
            print("[Debug - Error]: The vehicle plates did not match!")
        end
    else
        veh = VehicleInFront()
        local plate = GetVehicleNumberPlateText(veh)
        if plates == plate then 
            TrackVehicle(plate, veh)
            trackedVehicles[plate].canTurnOver = true
            exports['mythic_notify']:SendAlert('error', 'You recived keys from'..name.."for the vehicle with plate:"..plate, 6000)
        else
            print("[Debug - Error]: The vehicle plates did not match!")
        end
    end
end)

RegisterNetEvent('disc-hotwire:forceTurnOver')
AddEventHandler('disc-hotwire:forceTurnOver', function(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    TrackVehicle(plate, vehicle)
    trackedVehicles[plate].canTurnOver = true
end)

RegisterNetEvent('disc-hotwire:hotwire')
AddEventHandler('disc-hotwire:hotwire', function(useditem)
    local ped = GetPlayerPed(-1)
    local playerPed = GetPlayerPed(-1)
    local vehicle = VehicleInFront()
    state = GetVehicleDoorLockStatus(vehicle)
    Citizen.Wait(500)
    if GetVehiclePedIsIn(ped, false) == 0 and DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) and state == 2 and useditem then
        if isActive then
            return
        end

        local playerPed = GetPlayerPed(-1)
        local plate = GetVehicleNumberPlateText(vehicle)

        if GetIsVehicleEngineRunning(vehicle) or IsVehicleEngineStarting(vehicle) then
            return
        end
        if state ~= 2 then
            return
        end
        isActive = true
        chance = math.random(1,7)
        time = 10000
        local finished = exports['nadrp-skillbar']:taskBar(5000, math.random(5,15))
        if finished ~= 100 then
            exports['mythic_notify']:SendAlert('error', 'failed')
            lockpicking = false
        else
            local finished2 = exports['nadrp-skillbar']:taskBar(4000, math.random(5,15))
            if finished2 ~= 100 then
                exports['mythic_notify']:SendAlert('error', 'failed')
                lockpicking = false
            else
                local finished3 = exports['nadrp-skillbar']:taskBar(2000, math.random(5,15))
                if finished3 ~= 100 then
                    exports['mythic_notify']:SendAlert('error', 'failed')
                    lockpicking = false
                else
                    lockpicking = true
                    exports['mythic_notify']:SendAlert('success', 'Doors Unlocked!')
                end
            end
        end
        TriggerEvent("animation:lockpickinvtestoutside")
        SetVehicleDoorsShut(vehicle, true)

        if chance == 2 then
            TriggerServerEvent('ARPF:removeKit')
            exports['mythic_notify']:SendAlert('inform', 'Your lockpick broke.')
        end
            alarmChance = math.random(100)
        if alarmChance <= 55 then
            local pPed = GetPlayerPed(-1)
            local pPos = GetEntityCoords(pPed)
            local sPlates = GetVehicleNumberPlateText(vehicle)
            Citizen.Wait(2000)
            SetVehicleAlarm(vehicle, true)
            SetVehicleAlarmTimeLeft(vehicle, 30 * 1000)
            SetVehicleDoorsLocked(vehicle, 1)
            SetVehicleDoorsLockedForAllPlayers(vehicle, false)
        else
            SetVehicleDoorsLocked(vehicle, 1)
            SetVehicleDoorsLockedForAllPlayers(vehicle, false)
        end
            SetVehicleDoorsLocked(vehicle, 1)
            lockpicking = false
            Citizen.Wait(1000)
        isActive = false
    elseif useditem and IsPedInAnyVehicle(playerPed) then

        if isActive then
            return
        end

        local playerPed = GetPlayerPed(-1)

        local veh = GetVehiclePedIsIn(playerPed)
        local plate = GetVehicleNumberPlateText(veh)

        if GetIsVehicleEngineRunning(veh) or IsVehicleEngineStarting(veh) then
            return
        end

        if trackedVehicles[plate].canTurnOver then
            return
        end
        isActive = true
        TriggerEvent("animation:repaircar", 28)
        local finished = exports['nadrp-skillbar']:taskBar(5000,math.random(5,15))
        if finished ~= 100 then
            exports["mythic_notify"]:SendAlert('error', 'Failed...')
            giveKeysHotwire(false, veh, true)
        else
            local finished2 = exports['nadrp-skillbar']:taskBar(4000,math.random(5,15))
            if finished2 ~= 100 then
                exports["mythic_notify"]:SendAlert('error', 'Failed...')
                giveKeysHotwire(false, veh, true)
            else
                local finished3 = exports['nadrp-skillbar']:taskBar(3000,math.random(5,15))
                if finished3 ~= 100 then
                    exports["mythic_notify"]:SendAlert('error', 'Failed...')
                    giveKeysHotwire(false, veh, true)
                else
                    local finished4 = exports['nadrp-skillbar']:taskBar(1500,math.random(5,15))
                    if finished4 ~= 100 then
                        exports["mythic_notify"]:SendAlert('error', 'Failed...')
                        giveKeysHotwire(false, veh, true)
                    else
                        exports["mythic_notify"]:SendAlert('inform', 'Success')
                        giveKeysHotwire(true, veh, true)
                    end
                end
            end
            isActive = false
        end
    elseif not useditem and IsPedInAnyVehicle(GetPlayerPed(-1)) then
        if isActive then
            return
        end

        local playerPed = GetPlayerPed(-1)

        if not IsPedInAnyVehicle(playerPed) then
            return
        end

        veh = GetVehiclePedIsIn(playerPed)
        plate = GetVehicleNumberPlateText(veh)

        if GetIsVehicleEngineRunning(veh) or IsVehicleEngineStarting(veh) then
            return
        end

        if trackedVehicles[plate].canTurnOver then
            return
        end

        isActive = true
        TriggerEvent("animation:repaircar", 40)
        local finished = exports['nadrp-taskbar']:taskBar(30000, 'Attempting hotwire')
        if finished == 100 then
            local chance = math.random(1,100)
            if chance <= 75 then 
                exports["mythic_notify"]:SendAlert('error', 'Failed...')
                giveKeysHotwire(false, veh, false)
            else
                exports["mythic_notify"]:SendAlert('error', 'Failed...')
                giveKeysHotwire(true, veh, false)
            end
        else
            inanimation = false
            giveKeysHotwire(false, veh, false)
        end
    end
end)

function giveKeysHotwire(complete, veh, lockpick)
    local playerPed = PlayerPedId()
    local pPos = GetEntityCoords(pPed)
    local plate = GetVehicleNumberPlateText(veh)
    if not complete then
        inanimation = false
        
        local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
        local inVeh = {plate, '', vehicleLabel}
        local vehicleLabel = GetLabelText(vehicleLabel)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local streetName,street2 = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
        local streetName = GetStreetNameFromHashKey(streetName)..' | '..GetStreetNameFromHashKey(street2)
        TriggerServerEvent('tac_outlawalert:carJackInProgress', playerCoords)
        Citizen.Wait(1000)
        ClearPedTasks(PlayerPedId())
        SetVehicleAlarm(veh, true)
        SetVehicleAlarmTimeLeft(veh, 25 * 1000)
        SetVehicleDoorsLocked(veh, 1)
        SetVehicleDoorsLockedForAllPlayers(veh, false)
        trackedVehicles[plate].canTurnOver = false
        trackedVehicles[plate].failedHotwire = true
    else
        inanimation = false
        local chance = math.random(1,10)
        if chance == 2 and lockpick then
            TriggerServerEvent('ARPF:removeKit')
            exports['mythic_notify']:SendAlert('inform', 'Your lockpick bent out of shape.')
        end
        Citizen.Wait(1000)
        ClearPedTasks(PlayerPedId())
        trackedVehicles[plate].canTurnOver = true
    end
    isActive = false
    ClearPedTasks(PlayerPedId())
end

function searchvehicle()
    local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
    plate = GetVehicleNumberPlateText(veh)
    if  trackedVehicles[plate].canTurnOver == false then

        if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            exports['mythic_notify']:SendAlert('error', 'You are not in a car?')
            return
        end
        exports["t0sic_loadingbar"]:StartDelayedFunction("Searching...", 5000, function()
            Citizen.Wait(100)
            local luck = math.random(50,69)

            if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                exports['mythic_notify']:SendAlert('error', 'You are not in a car?')
                return
            end
            if luck >= 68 then
                exports["t0sic_loadingbar"]:StartDelayedFunction("Found Keys", 2000, function()
                    trackedVehicles[plate].canTurnOver = true
                end)
            elseif luck <= 55 then
                exports["t0sic_loadingbar"]:StartDelayedFunction("Found cash...", 2000, function()
                    cashreward = math.random(80,150)
                    TriggerServerEvent('disc-hotwire:givecash', cashreward)
                    exports['mythic_notify']:SendAlert('inform', 'Found $'..cashreward)
                end)
            elseif luck >= 56 and luck < 68 then
                maths = math.random(1,4)
                if maths == 1 then 
                    item = "hamburger"
                    count = 2
                    exports["t0sic_loadingbar"]:StartDelayedFunction("Found burger", 2000, function()
                        exports['mythic_notify']:SendAlert('inform', 'Found '..count.." "..item)
                        TriggerEvent('player:receiveItem', item, count)
                    end)
                elseif maths == 2 then
                    item = "bandage"
                    count = 2
                    exports["t0sic_loadingbar"]:StartDelayedFunction("Found "..item, 2000, function()
                        exports['mythic_notify']:SendAlert('inform', 'Found '..count.." "..item)
                        TriggerEvent('player:receiveItem', item, count)
                    end)
                elseif maths == 3 then
                    item = "water"
                    count = 1
                    exports["t0sic_loadingbar"]:StartDelayedFunction("Found water", 2000, function()
                        exports['mythic_notify']:SendAlert('inform', 'Found '..count.." "..item)
                        TriggerEvent('player:receiveItem', item, count)
                    end)
                elseif maths == 4 then
                    item = "lockpick"
                    count = 1
                    exports["t0sic_loadingbar"]:StartDelayedFunction("Found lockpick", 2000, function()
                        exports['mythic_notify']:SendAlert('inform', 'Found '..count.." "..item)
                        TriggerEvent('player:receiveItem', item, count)
                    end)
                end
            else
                exports['mythic_notify']:SendAlert('inform', 'You did not find anything in the car!')
            end
        end)
        hassearched[plate] = true
    end
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local playerPed = GetPlayerPed(-1)
    local coords = GetEntityCoords(playerPed)
    local veh = GetVehiclePedIsIn(playerPed)
    local plate = GetVehicleNumberPlateText(veh)
    seat = GetPedInVehicleSeat(veh, index)
    if not isActive and IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1) then
        if trackedVehicles[plate] == nil then
            TrackVehicle(plate,veh)
        end
        if not trackedVehicles[plate].canTurnOver then
            if IsPedOnAnyBike(playerPed) then
                vehPos = GetOffsetFromEntityInWorldCoords(veh, 0.0, 1.5, 0.5)
            else
                vehPos = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "bonnet"))
            end
            if hassearched[plate] == false or hassearched[plate] == nil then
                DrawText3Ds(vehPos.x, vehPos.y, vehPos.z, "Press [H] to hotwire / [G] to search for keys")
            elseif hassearched[plate] == true and not trackedVehicles[plate].failedHotwire then
                DrawText3Ds(vehPos.x, vehPos.y, vehPos.z, "Press [H] to hotwire")
            end
            if IsControlJustPressed(0, 304) then
                if trackedVehicles[plate].failedHotwire ~= true then
                    useds = false
                    TriggerEvent("disc-hotwire:hotwire", useds)
                else
                    exports["mythic_notify"]:SendAlert('error', 'You attempted to hotwire this and failed, move on')
                end
            end
            if IsControlJustPressed(0, 47) and not hassearched[plate] == true then
                searchvehicle()
            end
        end
    end
  end
end)

Citizen.CreateThread( function()
    while true do
        Citizen.Wait(1)
        local robbing = false
        if GetVehiclePedIsTryingToEnter(GetPlayerPed(-1)) ~= nil and GetVehiclePedIsTryingToEnter(GetPlayerPed(-1)) ~= 0 then
            robbing = true
            local curveh = GetVehiclePedIsTryingToEnter(GetPlayerPed(-1))
            local plate = GetVehicleNumberPlateText(curveh)
            TrackVehicle(plate,curveh)
            if trackedVehicles[plate].canTurnOver == false then
                local pedDriver = GetPedInVehicleSeat(curveh, -1)
                if pedDriver ~= 0 and (not IsPedAPlayer(pedDriver) or IsEntityDead(pedDriver)) then
                    if IsEntityDead(pedDriver) then
                        -- add your alert
                        local finished = exports['nadrp-taskbar']:taskBar(3000, 'Taking Keys')
                        if finished == 100 then 
                            --Citizen.Wait(4500)
                            exports['mythic_notify']:SendAlert('inform', 'You got the keys to the car')
                            trackedVehicles[plate].canTurnOver = true
                        end
                    else
                    if GetEntityModel(curveh) ~= GetHashKey("taxi") then

                        if math.random(100) > 95 then
                            -- add your alert
                            local finished = exports['nadrp-taskbar']:taskBar(3000, 'Taking Keys')
                            if finished == 100 then
                                --Citizen.Wait(4500)
                                exports['mythic_notify']:SendAlert('inform', 'You got the keys to the car')
                                trackedVehicles[plate].canTurnOver = true
                            end
                        else
                            SetVehicleDoorsLocked(curveh, 2)
                            Citizen.Wait(1000)
                            TriggerEvent("civilian:alertPolice",20.0,"lockpick",targetVehicle)
                            TaskReactAndFleePed(pedDriver, GetPlayerPed(-1))
                            SetPedKeepTask(pedDriver, true)
                            ClearPedTasksImmediately(GetPlayerPed(-1))
                            Citizen.Wait(2000)
                        end
                    else
                        SetPedIntoVehicle(GetPlayerPed(-1), curveh, 2) -- if taxi get into back seat
                        SetPedIntoVehicle(GetPlayerPed(-1), curveh, 1) -- if taxi get into back seat
                    end
                end
                end
            end
        end
        if not robbing then
            Wait(100)
        end
    end
end)

RegisterNetEvent('animation:repaircar')
AddEventHandler('animation:repaircar', function()
    inanimation = true

    ClearPedTasks(PlayerPedId())
    if not handCuffed then

        local lPed = GetPlayerPed(-1)

        RequestAnimDict("mini@repair")
        while not HasAnimDictLoaded("mini@repair") do
            Citizen.Wait(0)
        end

        local inAnim = IsEntityPlayingAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 3)

        while inanimation do
            Citizen.Wait(1000)
            if not inAnim then
                ClearPedTasks(PlayerPedId())
                TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
            else
                ClearPedTasks(PlayerPedId())
            end
        end
    end
    ClearPedTasks(PlayerPedId())
    inanimation = false
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

RegisterNetEvent('animation:lockpickinvtestoutside')
AddEventHandler('animation:lockpickinvtestoutside', function()
    local lPed = GetPlayerPed(-1)
    RequestAnimDict("veh@break_in@0h@p_m_one@")
    while not HasAnimDictLoaded("veh@break_in@0h@p_m_one@") do
        Citizen.Wait(0)
    end
    while lockpicking do
        TaskTaskPlayAnim(lPed, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
        Citizen.Wait(2000)
        Citizen.Wait(1)
    end
    ClearPedTasks(lPed)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedGettingIntoAVehicle(playerPed) then
            local vehicle = GetVehiclePedIsTryingToEnter(playerPed)
            local plate = GetVehicleNumberPlateText(vehicle)
            if plate ~= nil then
                TrackVehicle(plate, vehicle)
            end
        end
        --Test In Vehicles (Helps with Spawning Vehicles)
        if IsPedInAnyVehicle(playerPed) then
            local vehicle = GetVehiclePedIsIn(playerPed)
            local plate = GetVehicleNumberPlateText(vehicle)
            if plate ~= nil then
                TrackVehicle(plate, vehicle)
            end
        end
    end
end)


function TrackVehicle(plate, vehicle)
    if trackedVehicles[plate] == nil then
        trackedVehicles[plate] = {}
        trackedVehicles[plate].vehicle = vehicle
        trackedVehicles[plate].canTurnOver = false
    end
end

function VehicleInFront()
  local player = PlayerPedId()
    local pos = GetEntityCoords(player)
    local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, 2.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, player, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
      RequestAnimDict(dict)
      
      Citizen.Wait(1)
    end
end

--Disable All Cars Not tracked or Turned over
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k, v in pairs(trackedVehicles) do
            if not v.canTurnOver or v.state == 0 then
                SetVehicleEngineOn(v.vehicle, false, false)
            elseif v.state == 1 then
                SetVehicleEngineOn(v.vehicle, true, false)
                v.state = -1
            end
            --if IsControlJustPressed(0, 38) then
            --    local vehicle = VehicleInFront()
            --    local vPlate = GetVehicleNumberPlateText(vehicle)
            --    if vPlate == v.plate then
            --        print(vPlate)
            --        TriggerEvent('keys:unlockDoor', vehicle, true)
            --    end
            --end
        end
    end
end)

--Turnover key
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local inVeh = IsPedInAnyVehicle(GetPlayerPed(-1), false)
        if inVeh then 
            if IsControlJustReleased(1, 244) then
                local playerPed = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(playerPed)
                local isTurned = GetIsVehicleEngineRunning(vehicle)
                local plate = GetVehicleNumberPlateText(vehicle)
                if trackedVehicles[plate] == nil then
                    TrackVehicle(plate, vehicle)
                end

                if isTurned then
                    trackedVehicles[plate].state = 0
                elseif trackedVehicles[plate].canTurnOver then
                    trackedVehicles[plate].state = 1
                elseif trackedVehicles[plate] ~= nil then
                    ESX.TriggerServerCallback('disc-hotwire:checkOwner', function(owner)
                        if owner then
                            trackedVehicles[plate].canTurnOver = true
                            trackedVehicles[plate].state = 1
                        end
                    end, plate)
                end
            end
        end
        --// Door locks
        if IsControlJustPressed(0, 303) then
            TriggerEvent('control:cardoors')
        end
    end
end)

function GetPlayers()
    local players = {}
    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end
    return players
end

function GetClosestPlayer()
  local players = GetPlayers()
  local closestDistance = -1
  local closestPlayer = -1
  local ply = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ply, 0)
  
  for index,value in ipairs(players) do
    local target = GetPlayerPed(value)
    if(target ~= ply) then
      local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
      local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
      if(closestDistance == -1 or closestDistance > distance) then
        closestPlayer = value
        closestDistance = distance
      end
    end
  end

  return closestPlayer, closestDistance
end

function getVehicleInDirection(coordFrom, coordTo)
	local offset = 0
	local rayHandle
	local vehicle

	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		
		offset = offset - 1

		if vehicle ~= 0 then break end
	end
	
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	
	if distance > 250 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

--SetEntityTrafficlightOverride(entity, state)
--SetEntityLights(entity, toggle)

RegisterNetEvent('x-hotwire:resetKeys')
AddEventHandler('x-hotwire:resetKeys', function()
    trackedVehicles = {}
end)

RegisterNetEvent('keys:unlockDoor')
AddEventHandler('keys:unlockDoor', function(targetVehicle, allow)
    if allow then
        local playerped = PlayerPedId()
        inveh = IsPedInAnyVehicle(playerped)
        lockStatus = GetVehicleDoorLockStatus(targetVehicle) 
        TriggerEvent("dooranim")
        if lockStatus == 1 or lockStatus == 0 then
            lockStatus = SetVehicleDoorsLocked(targetVehicle, 2)

            SetVehicleDoorsLockedForPlayer(targetVehicle, PlayerId(), false)
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lock', 0.4)

            if not inveh then
                SetVehicleLights(targetVehicle, 2)

                SetVehicleBrakeLights(targetVehicle, true)
                SetVehicleInteriorlight(targetVehicle, true)
                SetVehicleIndicatorLights(targetVehicle, 0, true)
                SetVehicleIndicatorLights(targetVehicle, 1, true)
                Citizen.Wait(450)

                SetVehicleIndicatorLights(targetVehicle, 0, false)
                SetVehicleIndicatorLights(targetVehicle, 1, false)
                Citizen.Wait(450)

                SetVehicleInteriorlight(targetVehicle, true)
                SetVehicleIndicatorLights(targetVehicle, 0, true)
                SetVehicleIndicatorLights(targetVehicle, 1, true)
                Citizen.Wait(450)

                SetVehicleLights(targetVehicle, 0)
                SetVehicleBrakeLights(targetVehicle, false)
                SetVehicleInteriorlight(targetVehicle, false)
                SetVehicleIndicatorLights(targetVehicle, 0, false)
                SetVehicleIndicatorLights(targetVehicle, 1, false)
            end
        else
            lockStatus = SetVehicleDoorsLocked(targetVehicle, 1)
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'unlock', 0.1)
            
            if not inveh then
                SetVehicleLights(targetVehicle, 2)
                SetVehicleFullbeam(targetVehicle, true)
                SetVehicleBrakeLights(targetVehicle, true)
                SetVehicleInteriorlight(targetVehicle, true)
                SetVehicleIndicatorLights(targetVehicle, 0, true)
                SetVehicleIndicatorLights(targetVehicle, 1, true)
                Citizen.Wait(450)

                SetVehicleIndicatorLights(targetVehicle, 0, false)
                SetVehicleIndicatorLights(targetVehicle, 1, false)
                Citizen.Wait(450)

                SetVehicleInteriorlight(targetVehicle, true)
                SetVehicleIndicatorLights(targetVehicle, 0, true)
                SetVehicleIndicatorLights(targetVehicle, 1, true)
                Citizen.Wait(450)

                SetVehicleLights(targetVehicle, 0)
                SetVehicleFullbeam(targetVehicle, false)
                SetVehicleBrakeLights(targetVehicle, false)
                SetVehicleInteriorlight(targetVehicle, false)
                SetVehicleIndicatorLights(targetVehicle, 0, false)
                SetVehicleIndicatorLights(targetVehicle, 1, false)
            end
        end
    end
end)


RegisterNetEvent('control:cardoors')
AddEventHandler('control:cardoors', function()
    local playerped = PlayerPedId()
    local targetVehicle = GetVehiclePedIsUsing(playerped)
    local plate = GetVehicleNumberPlateText(targetVehicle)

    if not DoesEntityExist(targetVehicle) then
        local coordA = GetEntityCoords(playerped, 1)
        local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 255.0, 0.0)
        targetVehicle = getVehicleInDirection(coordA, coordB)
        plate = GetVehicleNumberPlateText(targetVehicle)
    end

    if DoesEntityExist(targetVehicle) then
        if trackedVehicles[plate] ~= nil then
            if trackedVehicles[plate].canTurnOver == true then
                TriggerEvent("keys:unlockDoor", targetVehicle, true)
            end
        else
            exports['mythic_notify']:SendAlert('inform', "You don't have keys to this vehicle")
        end
    end
    Citizen.Wait(500)
end)

RegisterNetEvent('dooranim')
AddEventHandler('dooranim', function()
 ClearPedSecondaryTask(GetPlayerPed(-1))
 loadAnimDict("anim@heists@keycard@")
 TaskPlayAnim( GetPlayerPed(-1), "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
 Citizen.Wait(850)
 ClearPedTasks(GetPlayerPed(-1))
end)