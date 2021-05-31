
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if IsControlPressed(0, 21) then
            if IsControlJustPressed(0,38) then
				if not IsPedRagdoll(PlayerPedId()) then
                	TryTackle()
				end
            end
        end
    end
end)

local holdingBody = false
local TimerEnabled = false

RegisterNetEvent('playerTackled')
AddEventHandler('playerTackled', function()
	SetPedToRagdoll(PlayerPedId(), math.random(8500), math.random(8500), 0, 0, 0, 0) 
	TimerEnabled = true
	Citizen.Wait(15000)
	TimerEnabled = false
end)

function TryTackle()
	if not TimerEnabled then
		local inCuffs = exports['ffrp-ped']:isPed("handcuffed")
		if not IsPedRagdoll(PlayerPedId()) and not inCuffs then
			t, distance = ESX.Game.GetClosestPlayer()
			if(distance ~= -1 and distance < 2) then
				local maxheading = (GetEntityHeading(PlayerPedId()) + 15.0)
				local minheading = (GetEntityHeading(PlayerPedId()) - 15.0)
				local theading = (GetEntityHeading(t))

				TriggerServerEvent('server:tackle',GetPlayerServerId(t))
				TriggerEvent("animation:tackle")

				TimerEnabled = true
				Citizen.Wait(30000)
				TimerEnabled = false
			else
				TimerEnabled = true
				Citizen.Wait(1000)
				TimerEnabled = false
			end
		end
    end
end

RegisterNetEvent('animation:tackle')
AddEventHandler('animation:tackle', function()
    if not handCuffed and not IsPedRagdoll(PlayerPedId()) then
        local lPed = PlayerPedId()

        RequestAnimDict("swimming@first_person@diving")
        while not HasAnimDictLoaded("swimming@first_person@diving") do
            Citizen.Wait(1)
        end

        if IsEntityPlayingAnim(lPed, "swimming@first_person@diving", "dive_run_fwd_-45_loop", 3) then
            ClearPedSecondaryTask(lPed)

        else
            TaskPlayAnim(lPed, "swimming@first_person@diving", "dive_run_fwd_-45_loop", 8.0, -8, -1, 49, 0, 0, 0, 0)
            seccount = 3
            while seccount > 0 do
                Citizen.Wait(100)
                seccount = seccount - 1

            end
            ClearPedSecondaryTask(lPed)
            SetPedToRagdoll(PlayerPedId(), 150, 150, 0, 0, 0, 0) 
        end
    end
end)

RegisterNetEvent('police:forceEnter')
AddEventHandler('police:forceEnter', function()

	ped, distance, t = GetClosestPedIgnoreCar()
	if(distance ~= -1 and distance < 3) then

		local isInVeh = IsPedInAnyVehicle(ped, true)
		if not isInVeh then
			playerped = PlayerPedId()
	        coordA = GetEntityCoords(playerped, 1)
	        coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
	        v = getVehicleInDirection(coordA, coordB)

			local netid = NetworkGetNetworkIdFromEntity(v)
			TriggerServerEvent("police:forceEnterAsk", GetPlayerServerId(t), netid)
			TriggerServerEvent('ffrp-policejob:resetDrag', GetPlayerServerId(t))
		else
			TriggerEvent("unseatPlayer")
		end
	else
		TriggerEvent("DoLongHudText", "No player near you (maybe get closer)!",2)
	end
end)

RegisterNetEvent('police:forcedEnteringVeh')
AddEventHandler('police:forcedEnteringVeh', function(sender)

	local vehicleHandle = NetworkGetEntityFromNetworkId(sender)
    if vehicleHandle ~= nil then
      if IsEntityAVehicle(vehicleHandle) then
      	TriggerEvent("respawn:sleepanims")
      	Citizen.Wait(1000)
        for i=1,GetVehicleMaxNumberOfPassengers(vehicleHandle) do
          if IsVehicleSeatFree(vehicleHandle,i) then
		 	--TriggerEvent("unEscortPlayer")
			Citizen.Wait(100)
            SetPedIntoVehicle(PlayerPedId(),vehicleHandle,i)
            return true
          end
        end
	    if IsVehicleSeatFree(vehicleHandle,0) then
	    	--TriggerEvent("unEscortPlayer")
			Citizen.Wait(100)
	        SetPedIntoVehicle(PlayerPedId(),vehicleHandle,0)
	    end
      end
    end
end)

RegisterNetEvent('unseatPlayer')
AddEventHandler('unseatPlayer', function()
	t, distance = GetClosestPlayerIgnoreCar()
	if(distance ~= -1 and distance < 10) then
		local ped = PlayerPedId()
		pos = GetEntityCoords(ped,  true)

		TriggerServerEvent('unseatAccepted',GetPlayerServerId(t),pos["x"], pos["y"], pos["z"])
		Citizen.Wait(1000)
	else
		exports['mythic_notify']:SendAlert('error', 'No Player Found')
	end
end)

RegisterNetEvent('unseatPlayerFinish')
AddEventHandler('unseatPlayerFinish', function(x,y,z)
	local ped = PlayerPedId()
	ClearPedTasksImmediately(ped)
	local veh = GetVehiclePedIsIn(ped, false)
    TaskLeaveVehicle(ped, veh, 256)
	SetEntityCoords(ped, x, y, z)
end)

function GetClosestPedIgnoreCar()
	local players = GetActivePlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local closestPlayerId = -1
	local ply = PlayerPedId()
	local plyCoords = GetEntityCoords(ply, 0)
	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
			if(closestDistance == -1 or closestDistance > distance) then
				closestPlayer = target
				closestPlayerId = value
				closestDistance = distance
			end
		end
	end
	return closestPlayer, closestDistance, closestPlayerId
end

function GetClosestPlayerIgnoreCar()
	local players = GetActivePlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = PlayerPedId()
	local plyCoords = GetEntityCoords(ply, 0)
	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
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
	if distance > 3000 then vehicle = nil end
    return vehicle ~= nil and vehicle or 0
end