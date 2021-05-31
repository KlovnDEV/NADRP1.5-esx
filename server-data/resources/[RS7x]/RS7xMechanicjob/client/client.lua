ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

local CurrentlyTowedVehicle = nil
local inZone = false
local HasTruckOut = false
local benches = { ["x"] = 963.21, ["y"] = -978.93, ["z"] = 39.5 }
local mechanicBench = {["x"] = -1415.33, ["y"] = -451.5862, ["z"] = 35.9}

Citizen.CreateThread(function()
    while true do
        if job == 'tuner' then
            if #((GetEntityCoords(GetPlayerPed(-1)) - vector3(950.75, -969.6, 39.507))) < 3.0 then
                Citizen.Wait(0)
                DrawText3Ds(950.75, -969.6, 39.507, '[E] Stash')
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("server-inventory-open", "1", "tuner-shop")
                end
            else
                Citizen.Wait(1000)
            end
        else
            Citizen.Wait(100)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if job == 'mechanic' then
            if #((GetEntityCoords(GetPlayerPed(-1)) - vector3(-1418.501,-454.4369, 35.90971))) < 3.0 then
                Citizen.Wait(0)
                DrawText3Ds(-1418.501,-454.4369, 35.90971, '[E] Stash')
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("server-inventory-open", "1", "house-mechanicshop")
                end
            else
                Citizen.Wait(1000)
            end
        else
            Citizen.Wait(100)
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        if job == 'mechanic' then
            if #((GetEntityCoords(GetPlayerPed(-1)) - vector3(177.432,-929.834,  24.088))) < 3.0 then
                Citizen.Wait(0)
                DrawText3Ds(177.432,-929.834,  24.088, '[E] Stash')
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("server-inventory-open", "1", "house-mechanicshop2")
                end
            else
                Citizen.Wait(1000)
            end
        else
            Citizen.Wait(100)
        end
    end
end)


Citizen.CreateThread(function() -- Tuner
    while true do
        if job == 'tuner' then 
            if #((GetEntityCoords(PlayerPedId()) - vector3(benches["x"], benches["y"], benches["z"]))) < 3.0 then
                Citizen.Wait(0)
                DrawText3Ds(benches["x"], benches["y"], benches["z"], '[E] Crafting bench')
                if IsControlJustReleased(0, 38) then 
                    TriggerEvent("server-inventory-open", "55", "Craft")
                end
            else
                Citizen.Wait(1000)
            end
        else
            Citizen.Wait(100)
        end
    end
end)

Citizen.CreateThread(function() -- Mech
    while true do
        if job == 'mechanic' then
            if #((GetEntityCoords(PlayerPedId()) - vector3(mechanicBench["x"], mechanicBench["y"], mechanicBench["z"]))) < 3.0 then
                Citizen.Wait(0)
                DrawText3Ds(mechanicBench["x"], mechanicBench["y"] - 0.6, mechanicBench["z"], '[E] Crafting bench')
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("server-inventory-open", "56", "Craft")
                end
            else
                Citizen.Wait(1000)
            end
        else
            Citizen.Wait(100)
        end
    end
end)

Citizen.CreateThread(function() -- Mech
    while true do
        if job == 'mechanic' then
            if #((GetEntityCoords(PlayerPedId()) - vector3(193.585, -953.218, 24.136))) < 3.0 then
                Citizen.Wait(0)
                DrawText3Ds(193.585, -953.218, 24.136, '[E] Crafting bench')
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("server-inventory-open", "56", "Craft")
                end
            else
                Citizen.Wait(1000)
            end
        else
            Citizen.Wait(100)
        end
    end
end)







Citizen.CreateThread(function()
    while true do
        if #((GetEntityCoords(GetPlayerPed(-1)) - vector3(-1404.538, -459.0421, 34.48))) < 3.0 then
            Citizen.Wait(0)
            if DoesEntityExist(truck) then 
                HasTruckOut = true
            else
                HasTruckOut = false
            end
            if not HasTruckOut then
                DrawText3Ds(-1404.538, -459.0421, 34.48, '[E] Take out a company tow truck')
                if IsControlJustPressed(0,38) then
                    TriggerEvent('RS7x:SpawnTowTruck')
                end
            else
                DrawText3Ds(-1404.538, -459.0421, 34.48, '[E] ~r~Return~w~ the company truck')
                if IsControlJustPressed(0,38) then
                    DeleteVehicle(GetVehiclePedIsIn(PlayerPedId(), false))
                    HasTruckOut = false
                end
            end
        else
            Citizen.Wait(1000)
        end
    end
end)


--[[RegisterNetEvent('RS7x:onTow')
AddEventHandler('RS7x:onTow', function()

	local playerped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(playerped, true)

	local towmodel = GetHashKey('flatbed')
	local isVehicleTow = IsVehicleModel(vehicle, towmodel)

    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(0)
    end

    if job ~= 'mechanic' then
        exports['mythic_notify']:SendAlert('error', 'You are not a mechanic?')
        return
    end

	if isVehicleTow then
		local coordA = GetEntityCoords(playerped, 1)
		local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
		local targetVehicle = getVehicleInDirection(coordA, coordB)

		if currentlyTowedVehicle == nil then
			if targetVehicle ~= 0 then
				if not IsPedInAnyVehicle(playerped, true) then
                    if vehicle ~= targetVehicle then
                        if not IsEntityPlayingAnim(playerped, "mini@repair", "fixing_a_player", 3) then
                            ClearPedSecondaryTask(playerped)
                            TaskPlayAnim(playerped, "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
                        end
                        exports['t0sic_loadingbar']:StartDelayedFunction('Towing vehicle', 15000, function()
                            TriggerEvent('InteractSound_CL:PlayOnOne', 'towtruck2', 0.8)
                            AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                            currentlyTowedVehicle = targetVehicle
                            exports['mythic_notify']:SendAlert('inform', 'Vehicle successfully attached to towtruck!')
                            ClearPedTasks(playerped)
                        end)
					else
						exports['mythic_notify']:SendAlert('error', 'You can\'t tow your own vehicle')
					end
				end
			else
				exports['mythic_notify']:SendAlert('error', 'No vehicle found')
			end
        else
            if not IsEntityPlayingAnim(playerped, "mini@repair", "fixing_a_player", 3) then
                ClearPedSecondaryTask(playerped)
                TaskPlayAnim(playerped, "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
            end
            exports['t0sic_loadingbar']:StartDelayedFunction('Detaching Vehicle', 15000, function()
                TriggerEvent('InteractSound_CL:PlayOnOne', 'towtruck2', 0.6)
                AttachEntityToEntity(currentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                DetachEntity(currentlyTowedVehicle, true, true)
                SetVehicleOnGroundProperly(currentlyTowedVehicle)
                currentlyTowedVehicle = nil
                exports['mythic_notify']:SendAlert('inform', 'Vehicle successfully dettached')
                ClearPedTasks(playerped)
            end)
		end
	end
end)]]

RegisterNetEvent('RS7x:onHijack')
AddEventHandler('RS7x:onHijack', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		local chance = math.random(100)
		local alarm  = math.random(100)

		if DoesEntityExist(vehicle) then
			if alarm <= 33 then
				SetVehicleAlarm(vehicle, true)
				StartVehicleAlarm(vehicle)
            end
            lockpicking = true
            TriggerEvent('animation:lockpick')
            exports['t0sic_loadingbar']:StartDelayedFunction('Lockpicking', 10000, function()
				if chance <= 66 then
					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasks(playerPed)
                    exports['mythic_notify']:SendAlert('inform', 'Vehicle unlocked')
                    lockpicking = false
				else
                    exports['mythic_notify']:SendAlert('error', 'Hijack failed')
                    ClearPedTasks(playerPed)
                    lockpicking = false
				end
			end)
		end
	end
end)

RegisterNetEvent('RS7x:OnClean')
AddEventHandler('RS7x:OnClean', function()
    local playerPed = PlayerPedId()
    local vehicle   = ESX.Game.GetVehicleInDirection()
    local coords    = GetEntityCoords(playerPed)

    if IsPedSittingInAnyVehicle(playerPed) then
        exports['mythic_notify']:SendAlert('inform', 'Can\'t do this from inside the vehicle')
        return
    end

    if DoesEntityExist(vehicle) then
        isBusy = true
        TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
        Citizen.CreateThread(function()
            Citizen.Wait(10000)
            SetVehicleDirtLevel(vehicle, 0)
            ClearPedTasksImmediately(playerPed)
            exports['mythic_notify']:SendAlert('inform', 'Vehicle cleaned')
            isBusy = false
        end)
    else
        exports['mythic_notify']:SendAlert('error', 'No vehicle found')
    end
end)

RegisterNetEvent('RS7x:OnRepair')
AddEventHandler('RS7x:OnRepair', function(itemid, advanced)
    playerped = GetPlayerPed(-1)
    coordA = GetEntityCoords(playerped, 1)
    coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
    targetVehicle = getVehicleInDirection(coordA, coordB)
    local pData = ESX.GetPlayerData()

    if targetVehicle ~= 0 then
        local d1,d2 = GetModelDimensions(GetEntityModel(targetVehicle))
        local moveto = GetOffsetFromEntityInWorldCoords(targetVehicle, 0.0,d2["y"]+0.5,0.0)
        local dist = GetDistanceBetweenCoords(moveto["x"],moveto["y"],moveto["z"], GetEntityCoords(GetPlayerPed(-1)))
        local count = 1000

        while dist > 1.0 and count > 0 do
            dist = GetDistanceBetweenCoords(moveto["x"],moveto["y"],moveto["z"], GetEntityCoords(GetPlayerPed(-1)))
            Citizen.Wait(1)
            count = count - 1
            DrawText3Ds(moveto["x"],moveto["y"],moveto["z"],"Move here to repair.")
        end

        if dist < 1.0 then
            TriggerEvent("moveRepair",targetVehicle)
            fixingvehicle = true

            local finished = false
            local repairlength = 10000
            if advanced then
                repairlength = ((3500 - (GetVehicleEngineHealth(targetVehicle) * 3) - (GetVehicleBodyHealth(targetVehicle)) / 2) * 5) + 2000
            else
                repairlength = ((3500 - (GetVehicleEngineHealth(targetVehicle) * 3) - (GetVehicleBodyHealth(targetVehicle)) / 2) * 3) + 2000
            end

            exports['t0sic_loadingbar']:StartDelayedFunction('Repairing', 10000, function()

                finished = true
                if finished == true then

                    if pData.job.name == "mechanic" then
                        SetVehicleEngineHealth(targetVehicle, 1000.0)
                        SetVehicleBodyHealth(targetVehicle, 1000.0)
                    else
                        --TriggerEvent('veh.randomDegredation',30,targetVehicle,3)

                        if advanced then
                            if GetVehicleEngineHealth(targetVehicle) < 900.0 then
                                SetVehicleEngineHealth(targetVehicle, 900.0)
                            end
                            if GetVehicleBodyHealth(targetVehicle) < 945.0 then
                                SetVehicleBodyHealth(targetVehicle, 945.0)
                            end
                            SetVehicleBodyHealth(targetVehicle, 1000.0)
                            SetVehicleFixed(targetVehicle)
                        else
                            if GetVehicleEngineHealth(targetVehicle) < 500.0 then
                                SetVehicleEngineHealth(targetVehicle, 500.0)
                            end
                            if GetVehicleBodyHealth(targetVehicle) < 945.0 then
                                SetVehicleBodyHealth(targetVehicle, 945.0)
                            end
                            if GetEntityModel(targetVehicle) == GetHashKey("BLAZER") then
                                SetVehicleEngineHealth(targetVehicle, 600.0)
                                SetVehicleBodyHealth(targetVehicle, 800.0)
                            end
                        end
                    end
                    for i = 0, 5 do
                        if IsVehicleTyreBurst(targetVehicle, i) then
                            SetVehicleTyreFixed(targetVehicle, i)
                        end
                    end
                end
                ClearPedTasks(playerped)
                fixingvehicle = false
                --TriggerServerEvent('removeRepairkit', advanced)
                TriggerEvent('inventory:removeItem', itemid, 1)
            end)
        end
    else
        while targetVehicle == 0 do
            Citizen.Wait(0)
            playerped = GetPlayerPed(-1)
            coordA = GetEntityCoords(playerped, 1)
            coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
            targetVehicle = getVehicleInDirection(coordA, coordB)
            if targetVehicle ~= 0 then
                break
            end
        end
    end
end)

RegisterNetEvent('moveRepair')
AddEventHandler('moveRepair', function(veh)
    SetVehicleDoorOpen(veh, 4, 0, 0)
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(0)
    end

    TaskTurnPedToFaceEntity(GetPlayerPed(-1), veh, 1.0)
    Citizen.Wait(1000)

    while fixingvehicle do
        local anim = IsEntityPlayingAnim(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 3)
        if not anim then
           TaskPlayAnim(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end
    SetVehicleDoorShut(veh, 4, 1, 1)
end)

RegisterNetEvent('RS7x:Impound')
AddEventHandler('RS7x:Impound', function()
    local playerPed = PlayerPedId()

    if IsPedSittingInAnyVehicle(playerPed) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if GetPedInVehicleSeat(vehicle, -1) == playerPed then
            exports['mythic_notify']:SendAlert('inform', 'Vehicle Impounded')
            ESX.Game.DeleteVehicle(vehicle)
        else
            exports['mythic_notify']:SendAlert('inform', 'Must be in the driver seat')
        end
    else
        local vehicle = ESX.Game.GetVehicleInDirection()
        if DoesEntityExist(vehicle) then
            exports['mythic_notify']:SendAlert('inform', 'Vehicle Impounded')
            ESX.Game.DeleteVehicle(vehicle)
        else
            exports['mythic_notify']:SendAlert('error', 'No vehicle found')
        end
    end
end)

RegisterNetEvent('Ford:Repair')
AddEventHandler('Ford:Repair', function()
    playerped = GetPlayerPed(-1)
    coordA = GetEntityCoords(playerped, 1)
    coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
    targetVehicle = getVehicleInDirection(coordA, coordB)
    local pData = ESX.GetPlayerData()
    local playerPed =  GetPlayerPed(-1)
    TriggerEvent("RS7x:OnRepair")
    Citizen.Wait(10000)
    TaskTurnPedToFaceEntity(GetPlayerPed(-1), targetVehicle, 1.0)
    Citizen.Wait(100)
    TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
    local finished = exports['ffrp-taskbar']:taskBar(5000, 'Repairing Body')
    if finished == 100 then 
        SetVehicleDeformationFixed(targetVehicle)
        SetVehicleFixed(targetVehicle)
    end
end)

RegisterNetEvent('animation:lockpick')
AddEventHandler('animation:lockpick', function()
    local ped = GetPlayerPed(-1)
    RequestAnimDict("veh@break_in@0h@p_m_one@")
    while not HasAnimDictLoaded("veh@break_in@0h@p_m_one@") do
        Citizen.Wait(0)
    end
    while lockpicking do
        TaskPlayAnim(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
        Citizen.Wait(2000)
        Citizen.Wait(1)
    end
    ClearPedTasks(ped)
end)

RegisterNetEvent('animation:crafting')
AddEventHandler('animation:crafting', function()
    local ped = GetPlayerPed(-1)
    RequestAnimDict("mp_car_bomb")
    while not HasAnimDictLoaded("mp_car_bomb") do
        Citizen.Wait(0)
    end
    while crafting do
        TaskPlayAnim(GetPlayerPed(-1),"mp_car_bomb","car_bomb_mechanic",2.0, -8, 180,49, 0, 0, 0, 0)
        Wait(100)
        TaskPlayAnim(GetPlayerPed(-1),"mp_car_bomb","car_bomb_mechanic",2.0, -8, 1800000,49, 0, 0, 0, 0)
        Citizen.Wait(2000)
        Citizen.Wait(1)
    end
    ClearPedTasks(ped)
end)

RegisterNetEvent('RS7x:SpawnTowTruck')
AddEventHandler('RS7x:SpawnTowTruck', function()
    local pData = ESX.GetPlayerData()
    if pData.job.name ~= 'mechanic' then
        return
    end

    if not HasTruckOut then
        if not Requesting then
            local vehicle = GetHashKey('slamtruck')
            Requesting = true

            RequestModel(vehicle)
            while not HasModelLoaded(vehicle) do
                Citizen.Wait(1)
                RequestModel(vehicle)
            end

            truck = CreateVehicle(vehicle, -1404.538, -459.0421, 34.48, 294.92351, true, 0)
            SetVehicleNumberPlateText(truck, 'Kpling'..math.random(100,999))
            local plate = GetVehicleNumberPlateText(truck)
            TriggerEvent("ARPF:spawn:recivekeys", truck, plate)
            TaskWarpPedIntoVehicle(PlayerPedId(), truck, -1)

            Requesting = false
            HasTruckOut = true
        end
    end
end)


local finished = false
RegisterNetEvent('progBar')
AddEventHandler('progBar', function(title, time)
    print(title, time)
    if title ~= nil and time ~= nil then
        crafting = true
        TriggerEvent('animation:crafting')
        exports['t0sic_loadingbar']:StartDelayedFunction(title, time, function()
            finished = true
            crafting = false
            return finished
        end)
    end
end)

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz= table.unpack(GetGameplayCamCoords())
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

RegisterCommand('tow', function(source, args)
    if job == 'mechanic' then
        TriggerEvent("RS7x:onTow")
    else
        exports['mythic_notify']:SendAlert('error', 'You dont have permissions to do this')
    end
end, false)


local currentlyTowedVehicle
local pickUplocation
local mypaytruck = 0

local towVehicles = {
	"towtruck",
	"towtruck2",
	"flatbed",
	"flatbed2",	
	"flatbed3",
    "brickade3",
    "slamtruck",
    "tow"
}

local towingProcess = false
RegisterNetEvent('animation:tow')
AddEventHandler('animation:tow', function()
	towingProcess = true
    local lPed = PlayerPedId()
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(0)
    end
    while towingProcess do

        if not IsEntityPlayingAnim(lPed, "mini@repair", "fixing_a_player", 3) then
            ClearPedSecondaryTask(lPed)
            TaskPlayAnim(lPed, "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end
    ClearPedTasks(lPed)
end)

RegisterNetEvent('RS7x:onTow')
AddEventHandler('RS7x:onTow', function()
	local playerped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerped, true)
	
	local towmodel = `towtruck`
	local isVehicleTow = isTowVehicle(vehicle)

	if isVehicleTow then
		local coordA = GetEntityCoords(playerped, 1)
		local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
		local targetVehicle = getVehicleInDirection2(coordA, coordB)

		if not currentlyTowedVehicle then
			CleanDetachedVehicles()
			local d1,d2 = GetModelDimensions(GetEntityModel(vehicle))
			local back = GetOffsetFromEntityInWorldCoords(vehicle, 0.0,d1["y"]-1.0,0.0)

			local aDist = #(back - GetEntityCoords(targetVehicle))

	        if aDist > 4.5 then
	        	local count = 1000
		        while count > 0 do
		            Citizen.Wait(1)
		            count = count - 1
		            DrawText3Ds(back["x"],back["y"],back["z"],"Move here to tow.")
		        end
		        return
		    end

		    local aDist = #(back - GetEntityCoords(targetVehicle))

		    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'towtruck', 0.5)
		    TaskTurnPedToFaceEntity(PlayerPedId(), vehicle, 1.0)
		    Citizen.Wait(1000)
		    TriggerEvent("animation:tow")
		    local finished = exports["ffrp-taskbar"]:taskBar(15000,"Hooking up vehicle.")
        	if finished == 100 and aDist < 5.0 then
				if targetVehicle ~= 0 then
					TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'towtruck2', 0.5)
					local part2 = exports["ffrp-taskbar"]:taskBar(7000,"Towing Vehicle")
					local driverPed = GetPedInVehicleSeat(targetVehicle, -1)
					if not IsPedInAnyVehicle(playerped, true) and not DoesEntityExist(driverPed) then
						if vehicle ~= targetVehicle and #(GetEntityCoords(targetVehicle) - GetEntityCoords(vehicle)) < 15.0 and GetEntitySpeed(targetVehicle < 3.0) then
		
							SetEntityAsMissionEntity(targetVehicle, true, true)
							NetworkRequestControlOfEntity(targetVehicle)

							local timeout = 0

							while timeout < 1000 and not NetworkHasControlOfEntity(targetVehicle) do
								timeout = timeout + 100
								NetworkRequestControlOfEntity(targetVehicle)
								Citizen.Wait(100)
							end
		
							if isVehicleTow == "flatbed3" then
								AttachEntityToEntity(targetVehicle, vehicle, GetEntityBoneIndexByName(vehicle, 'bodyshell'), 0.0, -3.3, 1.0, 0, 0, 0, 1, 1, 0, 1, 0, 1)
							elseif isVehicleTow == "flatbed2" then
								AttachEntityToEntity(targetVehicle, vehicle, GetEntityBoneIndexByName(vehicle, 'bodyshell'), 0.0, -1.9, 0.5, 0, 0, 0, 1, 1, 0, 1, 0, 1)
							elseif isVehicleTow == "flatbed" then
								AttachEntityToEntity(targetVehicle, vehicle, GetEntityBoneIndexByName(vehicle, 'bodyshell'), -0.25, -2.8, 1.1, 0, 0, 0, 1, 1, 0, 1, 0, 1)
                            elseif isVehicleTow == "brickade3" then
								AttachEntityToEntity(targetVehicle, vehicle, GetEntityBoneIndexByName(vehicle, 'bodyshell'), 0.0, -2.0, 0.9, 0, 0, 0, 1, 1, 0, 1, 0, 1)
                            elseif isVehicleTow == "slamtruck" then
								AttachEntityToEntity(targetVehicle, vehicle, GetEntityBoneIndexByName(vehicle, 'bodyshell'), 0.0, -2.0, 1.0, 3, 0, 0, 1, 1, 0, 1, 0, 1)
						 
                            elseif isVehicleTow == "tow" then
                                AttachEntityToEntity(targetVehicle, vehicle, GetEntityBoneIndexByName(vehicle, 'bodyshell'), 0.0, -2.0, 0.9, 0, 0, 0, 1, 1, 0, 1, 0, 1)
                            end 
								
		
							currentlyTowedVehicle = targetVehicle

							local location = GetEntityCoords(targetVehicle, 0)
							mypaytruck = CalculateTravelDistanceBetweenPoints( location, 408.957, -1638.664, 28.81 )

							if CalculateTravelDistanceBetweenPoints( location, 1732.1655273438,3307.6025390625,41.22350692749 ) < mypaytruck then
								mypaytruck = CalculateTravelDistanceBetweenPoints( location, 1732.1655273438,3307.6025390625,41.22350692749 )
							end

							if CalculateTravelDistanceBetweenPoints( location, -195.68403625488,6219.8081054688,31.491077423096 ) < mypaytruck then
								mypaytruck = CalculateTravelDistanceBetweenPoints( location, -195.68403625488,6219.8081054688,31.491077423096 )
							end
						    mypaytruck = mypaytruck * 0.05
						    mypaytruck = math.ceil(mypaytruck)

					        -- Don't pay people who are towing within the tow truck area
							if (CalculateTravelDistanceBetweenPoints( location, 549.47204589844,-55.185947418213,71.188438415527 ) < 155) then
								mypaytruck = 0
							end
							if (CalculateTravelDistanceBetweenPoints( location, 1732.1655273438,3307.6025390625,41.22350692749 ) < 155) then
								mypaytruck = 0
							end
							if (CalculateTravelDistanceBetweenPoints( location, -195.68403625488,6219.8081054688,31.491077423096 ) < 155) then
								mypaytruck = 0
							end

				            if mypaytruck > 300 then
				                mypaytruck = 300
				            end

						else
                            exports['mythic_notify']:SendAlert('error', 'You can\'t tow that vehicle')
						end
					else
						if DoesEntityExist(driverPed) then
                            exports['mythic_notify']:SendAlert('error', 'It appears someone is in the vehicle, you can not do this.')
						end
					end

				else
                    exports['mythic_notify']:SendAlert('error', 'No vehicle found')
				end
			end
		else
			local d1,d2 = GetModelDimensions(GetEntityModel(vehicle))
			local back = GetOffsetFromEntityInWorldCoords(vehicle, 0.0,d1["y"]-0.5,0.0)
			local drop = GetOffsetFromEntityInWorldCoords(vehicle, 1.5,d1["y"]-5.5,0.0)
			local aDist = #(back - GetEntityCoords(PlayerPedId()))
	        
	        if aDist > 1.5 then
	        	local count = 1500
		        while count > 0 and aDist > 1.5 do
		        	back = GetOffsetFromEntityInWorldCoords(vehicle, 1.5,d1["y"]-0.5,0.0)
		        	aDist = #(GetEntityCoords(PlayerPedId()) - back)
		            Citizen.Wait(1)
		            count = count - 1
		            DrawText3Ds(back["x"],back["y"],back["z"]," Move here to untow the vehicle.")
		        end
		        if count < 1 then
		        	return
		        end
		    end
		    TaskTurnPedToFaceEntity(PlayerPedId(), vehicle, 1.0)
		    Citizen.Wait(1000)
		    TriggerEvent("animation:tow")
		    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'towtruck', 0.5)
		    local finished = exports["ffrp-taskbar"]:taskBar(7000,"Untowing Vehicle")
        	if finished == 100 and aDist < 2.0 then
        		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'towtruck2', 0.5)
        		local part2 = exports["ffrp-taskbar"]:taskBar(7000,"Unhooking Vehicle")
				CleanDetachedVehicles()
				currentlyTowedVehicle = nil

				local location = GetEntityCoords(playerped, 0)
				calc = CalculateTravelDistanceBetweenPoints( location, 549.47204589844,-55.185947418213,71.188438415527 )
				if CalculateTravelDistanceBetweenPoints( location, 1732.1655273438,3307.6025390625,41.22350692749 ) < calc then
					calc = CalculateTravelDistanceBetweenPoints( location, 1732.1655273438,3307.6025390625,41.22350692749 )
				end
				if CalculateTravelDistanceBetweenPoints( location, -195.68403625488,6219.8081054688,31.491077423096 ) < calc then
					calc = CalculateTravelDistanceBetweenPoints( location, -195.68403625488,6219.8081054688,31.491077423096 )
				end

				-- Only pay out if we are within the tow truck area and the pay is more then $0
				if calc < 50 and mypaytruck > 0 then
					if mypaytruck > 0 then
						TriggerServerEvent("server:givepayJob", "Tow Truck Car Delivery Payment 2", mypaytruck) 
					end
					deleteVehicle(currentlyTowedVehicle)
				end
			end
		end
	end
	towingProcess = false
end)

local function deleteVehicle(vehicle)
	if IsAnEntity(vehicle) and IsEntityAVehicle(vehicle) then
		Citizen.CreateThread(function()
			Citizen.Wait(5000)
			SetEntityAsMissionEntity(vehicle,false,true)
			DeleteVehicle(vehicle)
			SetEntityAsNoLongerNeeded(vehicle)
			return
		end)
	end
end

function isTowVehicle(vehicle)
	for k,v in pairs(towVehicles) do
		if IsVehicleModel(vehicle, GetHashKey(v)) then return v end
	end
	return false
end

function getVehicleInDirection2(coordFrom, coordTo)
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
	if distance > 25 then vehicle = nil end
    return vehicle ~= nil and vehicle or 0
end

function CleanDetachedVehicles()
    local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
    local handle, vehicleFound = FindFirstVehicle()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(vehicleFound)
        local distance = #(playerCoords - pos)
        if distance < 15.0 then
      		if IsEntityAttached(vehicleFound) then
        		DetachEntity(vehicleFound, true, true)
				local drop = GetOffsetFromEntityInWorldCoords(vehicleFound, 0.0,-5.5,0.0)
				DetachEntity(vehicleFound, true, true)
				SetEntityCoords(vehicleFound,drop)
			end
        end
        success, vehicleFound = FindNextVehicle(handle)
    until not success
    EndFindVehicle(handle)
end

RegisterNetEvent('ffrp:playerBecameJob')
AddEventHandler('ffrp:playerBecameJob', function(jobpassed)
    job = jobpassed.name
end)