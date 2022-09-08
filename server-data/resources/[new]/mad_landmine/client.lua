local LastZone                = nil
local CurrentAction           = nil
local hasAlreadyEnteredMarker = false
local ox_inventory = exports.ox_inventory
local landmine
Citizen.CreateThread(function()
	while true do
		local playerCoords, isInZone, currentZone, letSleep = GetEntityCoords(PlayerPedId()), false, nil, true
		local sleep = 2000
        local mycoords = GetEntityCoords(PlayerPedId())
        landmine = GetClosestObjectOfType(mycoords, 1.0, GetHashKey('v_res_harddrive'), 0, 0, 0)
        if DoesEntityExist(landmine) then
            sleep = 0
            isInZone, currentZone = true, k
        end

		if (isInZone and not hasAlreadyEnteredMarker) or (isInZone and LastZone ~= currentZone) then
			hasAlreadyEnteredMarker, LastZone = true, currentZone
			CurrentAction     = 'triggerDigz'
            exports.mythic_notify:popIN(nil, 'You stepped on a landmine.')
    	end

		if not isInZone and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			sleep = 1000
			TriggerEvent('ruined_kits:hasExitedMarker', LastZone)
		end

		Citizen.Wait(sleep)
	end
end)

AddEventHandler('ruined_kits:hasExitedMarker', function(zone)
	CurrentAction = nil
    exports.mythic_notify:popOUT()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if CurrentAction ~= nil then
            if CurrentAction == 'triggerDigz' then
                while (not HasAnimDictLoaded("amb@medic@standing@kneel@base")) do
                    RequestAnimDict("amb@medic@standing@kneel@base")
                    Citizen.Wait(5)
                end
                TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
                Citizen.Wait(5)
                while (not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@")) do
                    RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
                    Citizen.Wait(5)
                end
                TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
                local finished = exports["nadrp-skillbar"]:taskBar(30000)
                if finished then
                    local finished2 = exports["nadrp-skillbar"]:taskBar(3000)
                    if finished2 then
                        ClearPedTasks(PlayerPedId())
                        exports['mythic_notify']:DoHudText('inform','You managed to undetonate landmine', 3000)
						--exports.mythic_notify:inform('success', 'You managed to undetonate landmine', 3000)
                        CurrentAction = nil
						DeleteEntity(landmine)
                        exports.mythic_notify:popOUT()
                    else
                        ClearPedTasks(PlayerPedId())
                        local vCoords = GetEntityCoords(PlayerPedId())
                        AddExplosion(vCoords.x, vCoords.y, vCoords.z, 5, 50.0, true, false, true)
                        CurrentAction = nil
						DeleteEntity(landmine)
                        exports.mythic_notify:popOUT()
                    end
                else
                    ClearPedTasks(PlayerPedId())
                    local vCoords = GetEntityCoords(PlayerPedId())
                    AddExplosion(vCoords.x, vCoords.y, vCoords.z, 5, 50.0, true, false, true)
                    CurrentAction = nil
					DeleteEntity(landmine)
                    exports.mythic_notify:popOUT()
                end
            end
		end
	end
end)
local x,y,z =nil,nil,nil
RegisterNetEvent('ruined_kits:landmine')
AddEventHandler('ruined_kits:landmine', function()
	while (not HasAnimDictLoaded("amb@medic@standing@kneel@base")) do
		RequestAnimDict("amb@medic@standing@kneel@base")
		Citizen.Wait(5)
	end
	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
	Citizen.Wait(5)
	while (not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@")) do
		RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
		Citizen.Wait(5)
	end
	TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
	Citizen.Wait(3000)
	local PedCoords = GetEntityCoords(PlayerPedId())
	x,y,z=PedCoords.x,PedCoords.y,PedCoords.z
	--exports.mythic_notify:inform('success', 'Successfully planted landmine, move far', 3000)
	exports['mythic_notify']:DoHudText('inform', 'Successfully planted landmine, move far', 3000)
	ClearPedTasks(PlayerPedId())
	TriggerServerEvent('player:removeItem', 'landmine', 1)
	Citizen.Wait(3000)
	--local finished = exports.nadrp-taskbar:taskBar(2000,'Activating..')
	local finished = exports['t0sic_loadingbar']:StartDelayedFunction('Activating..', 2000, function()

	if (finished == 100) then
		local landmineprop = CreateObject(GetHashKey('v_res_harddrive'),x,y,z-0.95, true, true, true)
		PlaceObjectOnGroundProperly(landmineprop)
		x,y,z =nil,nil,nil
	end
end)
end)