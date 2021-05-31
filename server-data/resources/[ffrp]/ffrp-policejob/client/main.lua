ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
end)

local DragStatus = {}
local IsHandcuffed = false
local IsShackles = false
local job
DragStatus.IsDragged = false
DragStatus.draganim = false

local Drag = {
	Distance = 3,
	Dragging = false,
	Dragger = -1,
	Dragged = false,
}

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()

        if IsHandcuffed then
            Citizen.Wait(1)
			--DisableControlAction(0, 1, true) -- Disable pan
			--DisableControlAction(0, 2, true) -- Disable tilt
            DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, 137, true) -- Melee Attack 1
			--DisableControlAction(0, Keys['W'], true) -- W
			--DisableControlAction(0, Keys['A'], true) -- A
			--DisableControlAction(0, 31, true) -- S (fault in Keys table!)
			--DisableControlAction(0, 30, true) -- D (fault in Keys table!)
			DisableControlAction(0, 170, true)  --F3
			DisableControlAction(0, 289, true)  --F2
			DisableControlAction(0, 288, true)  --F1
			DisableControlAction(0, 38, true)  --E
			DisableControlAction(0, 137, true)  --Caps
			
			

			
			
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288, true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job
            DisableControlAction(0, 37, true) -- TAB

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

            DisableControlAction(0,24) -- INPUT_ATTACK
            DisableControlAction(0,69) -- INPUT_VEH_ATTACK
            DisableControlAction(0,70) -- INPUT_VEH_ATTACK2
            DisableControlAction(0,92) -- INPUT_VEH_PASSENGER_ATTACK
            DisableControlAction(0,114) -- INPUT_VEH_FLY_ATTACK
            DisableControlAction(0,257) -- INPUT_ATTACK2
            DisableControlAction(0,68) -- AIM_VEH
            DisableControlAction(0,91) -- AIM_PASSENGER

			if not IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1000)
		if IsHandcuffed then
			if IsPedVaulting(PlayerPedId()) or IsPlayerClimbing(PlayerPedId()) then 
				SetPedToRagdoll(PlayerPedId(), 1000, 1000, 3, 0, 0, 0)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()

        if IsShackles then
            Citizen.Wait(0)
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D
			DisableControlAction(0, 22, true) -- Jump
            DisableControlAction(0, 44, true) -- Cover
            DisableControlAction(0, 137, true)
            DisableControlAction(0, 47, true)
			DisableControlAction(0, 38, true)
			DisableControlAction(0, 170, true)  --F3
			DisableControlAction(0, 289, true)  --F2
			DisableControlAction(0, 288, true)  --F1
			DisableControlAction(0, 38, true)  --E
			DisableControlAction(0, 137, true)  --Caps

			if not IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) then
                ESX.Streaming.RequestAnimDict('mp_arresting', function()
                  TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
                end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
        if Drag.Dragging then
            Citizen.Wait(0)
            local PlayerPed = PlayerPedId()

            Drag.Dragged = true
            AttachEntityToEntity(PlayerPed, GetPlayerPed(GetPlayerFromServerId(Drag.Dragger)), 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        elseif Drag.Dragged then
            Citizen.Wait(0)
            local PlayerPed = PlayerPedId()
            if not IsPedInParachuteFreeFall(PlayerPed) then
                Drag.Dragged = false
                DetachEntity(PlayerPed, true, false)
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do

		--if IsHandcuffed then
			playerPed = PlayerPedId()

			if DragStatus.IsDragged then
                Citizen.Wait(1)
				targetPed = GetPlayerPed(GetPlayerFromServerId(DragStatus.CopId))

				-- undrag if target is in an vehicle
                if not IsPedSittingInAnyVehicle(targetPed) then
                    if IsPedDeadOrDying(targetPed, false) then
                        AttachEntityToEntity(playerPed, targetPed, 11816, -0.60, 0.85, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                    else
                        AttachEntityToEntity(playerPed, targetPed, 11816, -0.50, 0.65, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                    end
				else
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

				if IsPedDeadOrDying(targetPed, true) then
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end
			else
                DetachEntity(playerPed, true, false)
                Citizen.Wait(1000)
			end
		--else
			--Citizen.Wait(500)
		--end
	end
end)

Citizen.CreateThread(function()
    while true do
		if IsControlPressed(0, 21) and job == 'police' then
			Citizen.Wait(0)
			if IsControlJustPressed(0,27) then
				TriggerEvent('ffrp-policejob:hotkeys', 1)
			elseif IsControlJustPressed(0,173) then
				TriggerEvent('ffrp-policejob:hotkeys', 2)
			elseif IsControlJustPressed(0,174) then
				TriggerEvent('ffrp-policejob:hotkeys', 3)
			elseif IsControlJustPressed(0,175) then
				TriggerEvent('ffrp-policejob:hotkeys', 4)
			end
		else
			Citizen.Wait(500)
		end
    end
end)

RegisterNetEvent('ffrp-policejob:hotkeys')
AddEventHandler('ffrp-policejob:hotkeys', function(key)
    local inVeh = IsPedInAnyVehicle(PlayerPedId())
    if job == 'police' and not IsHandcuffed and not inVeh then
        if not inAction then
            if key ~= nil then
                if key == 1 then
                    TriggerEvent('ffrp-policejob:softcuff')
                    inAction = true
                elseif key == 2 then
                    TriggerEvent('ffrp-policejob:uncuff')
                    inAction = true
                elseif key == 3 then
                    TriggerEvent('police:forceEnter')
                    --inAction = true
                elseif key == 4 then
                    TriggerEvent('unseatPlayer')
                    --inAction = true
                end
            end
        end
    end
end)

RegisterNetEvent('ffrp-policejob:getarrested')
AddEventHandler('ffrp-policejob:getarrested', function(isCommand, playerheading, playercoords, playerlocation)
	playerPed = PlayerPedId()
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
    local isDead = exports['ffrp-death']:GetDeath()
	if not isDead and not isCommand then
		local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
		SetEntityCoords(PlayerPedId(), x, y, z)
		SetEntityHeading(PlayerPedId(), playerheading)
		Citizen.Wait(250)
		LoadAnimDict('mp_arrest_paired')
		TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
        local finished = exports['ffrp-skillbar']:taskBar(1000, math.random(10,15))
        if finished ~= 100 then
            exports["mythic_notify"]:SendAlert('error', 'Failed...')
            IsHandcuffed = true
            IsShackles = false
            TriggerEvent('ffrp-policejob:handcuff')
            LoadAnimDict('mp_arresting')
			TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
        else
            exports["mythic_notify"]:SendAlert('inform', 'Success')
            IsHandcuffed = false
            IsShackles = false
			ClearPedTasks(PlayerPedId())
        end
    else
        IsHandcuffed = true
        IsShackles = false
        TriggerEvent('ffrp-policejob:handcuff')
        LoadAnimDict('mp_arresting')
		TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
    end
end)

RegisterNetEvent('ffrp-policejob:doarrested')
AddEventHandler('ffrp-policejob:doarrested', function()
	Citizen.Wait(250)
	LoadAnimDict('mp_arrest_paired')
	TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
    Citizen.Wait(3000)
    inAction = false
end)

RegisterNetEvent('ffrp-policejob:douncuffing')
AddEventHandler('ffrp-policejob:douncuffing', function()
	Citizen.Wait(250)
	LoadAnimDict('mp_arresting')
	TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
    ClearPedTasks(PlayerPedId())
    inAction = false
end)

RegisterNetEvent('ffrp-policejob:getuncuffed')
AddEventHandler('ffrp-policejob:getuncuffed', function(playerheading, playercoords, playerlocation)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(PlayerPedId(), x, y, z)
	SetEntityHeading(PlayerPedId(), playerheading)
	Citizen.Wait(250)
	LoadAnimDict('mp_arresting')
    TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
    Citizen.Wait(3000)
    IsHandcuffed = false
	IsShackles = false
    Citizen.Wait(2500)
	ClearPedTasksImmediately(PlayerPedId())
	TriggerEvent('ffrp-policejob:HandCuffedState', false, false)
end)

RegisterNetEvent('ffrp-policejob:loose')
AddEventHandler('ffrp-policejob:loose', function(playerheading, playercoords, playerlocation)
	local x,y,z  = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(PlayerPedId(), x, y, z)
	SetEntityHeading(PlayerPedId(), playerheading)
	Citizen.Wait(250)
	LoadAnimDict('mp_arresting')
	TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
    IsHandcuffed = true
    IsShackles = false
    TriggerEvent('ffrp-policejob:handcuff')
	ClearPedTasks(PlayerPedId())
	TriggerEvent('ffrp-policejob:HandCuffedState', true, true)
end)

RegisterNetEvent('ffrp-policejob:getarrestedhard')
AddEventHandler('ffrp-policejob:getarrestedhard', function(playerheading, playercoords, playerlocation)
	playerPed = PlayerPedId()
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(PlayerPedId(), x, y, z)
	SetEntityHeading(PlayerPedId(), playerheading)
	Citizen.Wait(250)
	LoadAnimDict('mp_arrest_paired')
    TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
    local isDead = exports['ffrp-death']:GetDeath()

    if not isDead then
        local finished = exports['ffrp-skillbar']:taskBar(1000,math.random(5,15))
        if finished ~= 100 then
            exports["mythic_notify"]:SendAlert('error', 'Failed...')
            IsHandcuffed = true
            IsShackles = true
            TriggerEvent('ffrp-policejob:hardcuff')
            LoadAnimDict('mp_arresting')
			TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
        else
            exports["mythic_notify"]:SendAlert('inform', 'Success')
            IsHandcuffed = false
            IsShackles = false
			ClearPedTasks(PlayerPedId())
	
        end
    else
        IsHandcuffed = true
        IsShackles = true
        TriggerEvent('ffrp-policejob:handcuff')
        LoadAnimDict('mp_arresting')
		TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
    end
end)

RegisterNetEvent('ffrp-policejob:hardcuff')
AddEventHandler('ffrp-policejob:hardcuff', function()
	local playerPed = PlayerPedId()
	Citizen.CreateThread(function()
		if IsShackles then
			if Config.EnableHandcuffTimer then
				if HandcuffTimer.active then
					ESX.ClearTimeout(HandcuffTimer.task)
				end
				StartHandcuffTimer()
			end
		else
			if Config.EnableHandcuffTimer and HandcuffTimer.active then
				ESX.ClearTimeout(HandcuffTimer.task)
			end
		end
	end)
end)

RegisterNetEvent('ffrp-policejob:drag')
AddEventHandler('ffrp-policejob:drag', function(copID)
	DragStatus.IsDragged = not DragStatus.IsDragged
	DragStatus.CopId     = tonumber(copID)
end)

RegisterNetEvent('ffrp-policejob:resetDrag')
AddEventHandler('ffrp-policejob:resetDrag', function(copID)
	DragStatus.IsDragged = false
	DragStatus.CopId     = tonumber(copID)
end)

RegisterCommand("ref", function (src, args, raw)
	if job == 'police' then
		TriggerServerEvent("eblips:add", {name = "Police", src = src, color = 38})
		exports['mythic_notify']:SendAlert('success','Your reference has been activated.')
	elseif job == 'ambulance' then
		TriggerServerEvent("eblips:add", {name = "EMS", src = src, color = 59})
		exports['mythic_notify']:SendAlert('success','Your reference has been activated.')
	end
end, false)

RegisterCommand("refoff", function (src, args, raw)
	if job == 'police' then
		TriggerServerEvent("eblips:remove", src)
		exports['mythic_notify']:SendAlert('error','Your reference has been deactivated.')
	elseif job == 'ambulance' then
		TriggerServerEvent("eblips:remove", src)
		exports['mythic_notify']:SendAlert('error','Your reference has been deactivated.')
	end
end, false)

RegisterNetEvent('ffrp:playerBecameJob')
AddEventHandler('ffrp:playerBecameJob', function(jobpassed)
	job = jobpassed.name
end)


function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end



--- Config ---

maxTaserCarts = 2 -- The amount of taser cartridges a person can have.
longerTazeTime = false -- Want longer taze times? true/false
longerTazeSecTime = 20 -- Time in SECONDS to extend the longer taze time.

--- Code ---

local taserCartsLeft = maxTaserCarts

RegisterNetEvent('ford:tazer')
AddEventHandler('ford:tazer', function()
	taserCartsLeft = maxTaserCarts
end)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local taserModel = GetHashKey("WEAPON_STUNGUN")

        if GetSelectedPedWeapon(ped) == taserModel then
            if IsPedShooting(ped) then
                taserCartsLeft = taserCartsLeft - 1
            end
        end

        if taserCartsLeft <= 0 then
            if GetSelectedPedWeapon(ped) == taserModel then
                SetPlayerCanDoDriveBy(ped, false)
                DisablePlayerFiring(ped, true)
            end
        end

        if longerTazeTime then
            SetPedMinGroundTimeForStungun(ped, longerTazeSecTime * 1000)
        end
    end
end)

RegisterNetEvent('pd:radio')
AddEventHandler('pd:radio', function ()
	local radio = exports["ffrp-inventory"]:hasEnoughOfItem("radio",1,false)
	if job == "police" or job == "ambulance" then
		if radio then
			exports['ffrp-voice']:removePlayerFromRadio()
			exports["ffrp-voice"]:addPlayerToRadio(1)
		else
			exports['mythic_notify']:SendAlert('error','You do not have a radio for this')
		end
	end
end)

RegisterNetEvent('pd90:radio')
AddEventHandler('pd90:radio', function ()
	local radio = exports["ffrp-inventory"]:hasEnoughOfItem("radio",1,false)
	if job == "police" or job == "ambulance" then
		if radio then 
			exports["ffrp-voice"]:addPlayerToRadio(2)
		else
			exports['mythic_notify']:SendAlert('error','You do not have a radio for this')
		end
	end
end)



RegisterNetEvent('ptransport:radio')
AddEventHandler('ptransport:radio', function ()
	local radio = exports["ffrp-inventory"]:hasEnoughOfItem("radio",1,false)
	if job == "police" or job == "ambulance" then
		if radio then 
			exports["ffrp-voice"]:addPlayerToRadio(3)
		else
			exports['mythic_notify']:SendAlert('error','You do not have a radio for this')
		end
	end
end)

RegisterNetEvent('holdout:radio')
AddEventHandler('holdout:radio', function ()
	local radio = exports["ffrp-inventory"]:hasEnoughOfItem("radio",1,false)
	if job == "police" or job == "ambulance" then
		if radio then 
			exports["ffrp-voice"]:addPlayerToRadio(4)
		else
			exports['mythic_notify']:SendAlert('error','You do not have a radio for this')
		end
	end
end)


RegisterNetEvent('pd:ems-radio')
AddEventHandler('pd:ems-radio', function ()
	local radio = exports["ffrp-inventory"]:hasEnoughOfItem("radio",1,false)
	if job == "police" or job == "ambulance" then
		if radio then
			exports['ffrp-voice']:removePlayerFromRadio()
			exports["ffrp-voice"]:addPlayerToRadio(5)
		else
			exports['mythic_notify']:SendAlert('error','You do not have a radio for this')
		end
	end
end)



RegisterNetEvent('Mechanic:radio')
AddEventHandler('Mechanic:radio', function ()
	local radio = exports["ffrp-inventory"]:hasEnoughOfItem("radio",1,false)
	if job == "police" or job == "ambulance" then
		if radio then 
			exports['ffrp-voice']:removePlayerFromRadio()
			exports["ffrp-voice"]:addPlayerToRadio(10)
		else
			exports['mythic_notify']:SendAlert('error','You do not have a radio for this')
		end
	end
end)
