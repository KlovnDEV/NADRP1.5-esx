ESX = nil
local holdingBody = false
local carrying = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('carry:command')
AddEventHandler('carry:command', function()
	if not carrying then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	
		if closestPlayer ~= -1 and closestDistance <= 3.0 then
			TriggerServerEvent('carry:sync', GetPlayerServerId(closestPlayer))
		end
	else
		exports['mythic_notify']:SendAlert('error', 'You are already carrying someone.')
	end
end,false)

RegisterNetEvent('carry:syncTarget')
AddEventHandler('carry:syncTarget', function(target)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	carrying = true
	exports['mythic_notify']:SendAlert('error', 'Press E to release carry.')

	while carrying do
		AttachEntityToEntity(GetPlayerPed(-1), targetPed, 1, -0.68, -0.2, 0.94, 180.0, 180.0, 60.0, 1, 1, 0, 1, 0, 1)

		DisableControlAction(1, 19, true)
		DisableControlAction(0, 34, true)
		DisableControlAction(0, 9, true)
	
		DisableControlAction(0, 288, true)
		DisableControlAction(0, 289, true)
		DisableControlAction(0, 170, true)
		DisableControlAction(0, 73, true)
		DisableControlAction(0, 79, true)
		DisableControlAction(0, 305, true)
		DisableControlAction(0, 82, true)
		DisableControlAction(0, 182, true)

		DisableControlAction(0, 32, true)
		DisableControlAction(0, 8, true)
		DisableControlAction(2, 31, true)
		DisableControlAction(2, 32, true)
		DisableControlAction(1, 33, true)
		DisableControlAction(1, 34, true)
		DisableControlAction(1, 35, true)
		DisableControlAction(1, 21, true)  -- space
		DisableControlAction(1, 22, true)  -- space
		DisableControlAction(1, 23, true)  -- F
		DisableControlAction(1, 24, true)  -- F
		DisableControlAction(1, 25, true)  -- F
	
	
		DisableControlAction(1, 106, true) -- VehicleMouseControlOverride
		DisableControlAction(1, 140, true) --Disables Melee Actions
		DisableControlAction(1, 141, true) --Disables Melee Actions
		DisableControlAction(1, 142, true) --Disables Melee Actions 
		DisableControlAction(1, 37, true) --Disables INPUT_SELECT_WEAPON (tab) Actions
		DisablePlayerFiring(playerPed, true) -- Disable weapon firing

		if not IsEntityPlayingAnim(playerPed, "amb@world_human_bum_slumped@male@laying_on_left_side@base", "base", 3) then
			loadAnim("amb@world_human_bum_slumped@male@laying_on_left_side@base")
			TaskPlayAnim(playerPed, "amb@world_human_bum_slumped@male@laying_on_left_side@base", "base", 8.0, 8.0, -1, 1, 999.0, 0, 0, 0)
		end

		if IsControlJustPressed(0, 38) then
			carrying = false
			ClearPedTasks(GetPlayerPed(-1))
			DetachEntity(GetPlayerPed(-1), true, false)
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 3.0 then
				TriggerServerEvent("carry:stop",GetPlayerServerId(closestPlayer))
			end
		end
		Wait(1)
	end
end)

RegisterNetEvent('carry:syncMe')
AddEventHandler('carry:syncMe', function()
    local playerPed = GetPlayerPed(-1)
    exports['mythic_notify']:SendAlert('inform', 'Press E to release carry.')
    carrying = true

    while carrying do
        if not IsEntityPlayingAnim(playerPed, "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 3) then
            loadAnim("missfinale_c2mcs_1")
            TaskPlayAnim(playerPed, "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 1.0, 1.0, -1, 50, 0, 0, 0, 0)
        end

        if IsPedInAnyVehicle(PlayerPedId(), false) then
            cancel = true
        end

        if IsControlJustPressed(0, 38) or cancel then
            carrying = false
            cancel = false
            ClearPedSecondaryTask(GetPlayerPed(-1))
            DetachEntity(GetPlayerPed(-1), true, false)
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= 3.0 then
                TriggerServerEvent("carry:stop",GetPlayerServerId(closestPlayer))
            end
        end
        Wait(1)
    end
end)

RegisterNetEvent('carry:stop')
AddEventHandler('carry:stop', function()
	carrying = false
	ClearPedTasks(PlayerPedId())
	DetachEntity(GetPlayerPed(-1), true, false)
end)


RegisterNetEvent('carryAI')
AddEventHandler('carryAI', function()
	if not holdingBody then
		carryPedNow()
	else
		exports['mythic_notify']:SendAlert('inform', 'You are already carrying someone.')
	end
end)

function carryPedNow()
    local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = #(playerCoords - pos)
        if distance < 2.0 and not IsPedAPlayer(ped) then
            ClearPedTasksImmediately(ped) 
        	carryPed(ped)
        	return
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped

end

function carryPed(ped)
	exports['mythic_notify']:SendAlert('inform', 'Press E to release carry.')

	loadAnim('anim@narcotics@trash')
	TaskPlayAnim(PlayerPedId(),'anim@narcotics@trash', 'drop_front',0.9, -8, 1500, 49, 3.0, 0, 0, 0) 
	TaskTurnPedToFaceEntity(PlayerPedId(), ped, 1.0)

	SetBlockingOfNonTemporaryEvents(ped, true)
	SetPedSeeingRange(ped, 0.0)
	SetPedHearingRange(ped, 0.0)
	SetPedFleeAttributes(ped, 0, false)
	SetPedKeepTask(ped, true)

	loadAnim( "dead" ) 
	TaskPlayAnim(ped, "dead", "dead_f", 8.0, 8.0, -1, 1, 0, 0, 0, 0)

	DetachEntity(ped)
	ClearPedTasks(ped)
	loadAnim( "amb@world_human_bum_slumped@male@laying_on_left_side@base" ) 
	TaskPlayAnim(ped, "amb@world_human_bum_slumped@male@laying_on_left_side@base", "base", 8.0, 8.0, -1, 1, 999.0, 0, 0, 0)
	attachCarryPed(ped)
	holdingBody = true
	ClearPedTasksImmediately(PlayerPedId())
	while (holdingBody) do
		Citizen.Wait(1)
		if not IsEntityPlayingAnim(PlayerPedId(), "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 3) then
			loadAnim( "missfinale_c2mcs_1" ) 
			TaskPlayAnim(PlayerPedId(), "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 1.0, 1.0, -1, 50, 0, 0, 0, 0)
		end

		if IsControlJustPressed(0, 38) or (`WEAPON_UNARMED` ~= GetSelectedPedWeapon(PlayerPedId()))  then
			holdingBody = false
			DetachEntity(ped)
			ClearPedTasks(ped)
		end
	end
	ClearPedTasks(PlayerPedId())
	DetachEntity(ped)
end

function attachCarryPed(ped)
	while holdingBody do
		Citizen.Wait(0)
		AttachEntityToEntity(ped, PlayerPedId(), 1, -0.68, -0.2, 0.94, 180.0, 180.0, 60.0, 1, 1, 0, 1, 0, 1)
	end
	loadAnim( "missfinale_c2mcs_1" )
	TaskPlayAnim(PlayerPedId(), "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 1.0, 1.0, -1, 50, 0, 0, 0, 0)
end

function loadAnim( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function DrawText3DTest(x,y,z, text, dicks,power)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	if dicks > 255 then
		dicks = 255
	end
	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextDropshadow(0, 0, 0, 0, 155)
		SetTextEdge(1, 0, 0, 0, 250)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		SetTextColour(255, 255, 255, dicks)
  
		DrawText(_x,_y)
		local factor = (string.len(text)) / 250
		if dicks < 115 then
			DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 11, 1, 11, dicks)
		else
			DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 11, 1, 11, 115)
		end
	end
end

RegisterCommand('carry', function(source)
    TriggerEvent('carry:command')
end)