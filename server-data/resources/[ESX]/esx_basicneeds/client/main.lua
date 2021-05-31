ESX          = nil
local IsDead = false
local IsAnimated = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('tac_basicneeds:resetStatus', function()
	TriggerEvent('tac_status:set', 'hunger', 500000)
	TriggerEvent('tac_status:set', 'thirst', 500000)
end)

RegisterNetEvent('tac_basicneeds:healPlayer')
AddEventHandler('tac_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('tac_status:set', 'hunger', 1000000)
	TriggerEvent('tac_status:set', 'thirst', 1000000)
	-- remove bleeding
    TriggerEvent('mythic_hospital:client:ResetLimbs')
    TriggerEvent('mythic_hospital:client:RemoveBleed')
	-- restore hp

	SetEntityHealth(GetPlayerPed(-1), GetEntityMaxHealth(GetPlayerPed(-1)))
end)

AddEventHandler('tac:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	if IsDead then
		TriggerEvent('tac_basicneeds:resetStatus')
	end
	IsDead = false
end)

AddEventHandler('tac_status:loaded', function(status)
	print('tac_status:loaded')
	TriggerEvent('tac_status:registerStatus', 'hunger', 1000000, '#CFAD0F', function(status)
		return true
	end, function(status)
		status.remove(math.random(650,850))
	end)

	TriggerEvent('tac_status:registerStatus', 'thirst', 1000000, '#0C98F1', function(status)
		return true
	end, function(status)
		status.remove(math.random(550,750))
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)

			local playerPed  = PlayerPedId()
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth

			TriggerEvent('tac_status:getStatus', 'hunger', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			TriggerEvent('tac_status:getStatus', 'thirst', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			if health ~= prevHealth then
				SetEntityHealth(playerPed, health)
			end
		end
	end)
end)

AddEventHandler('tac_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('tac_cigarette:startSmoke')
AddEventHandler('tac_cigarette:startSmoke', function(source)
	SmokeAnimation()
end)

function SmokeAnimation()
	local playerPed = GetPlayerPed(-1)
	
	Citizen.CreateThread(function()
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING", 0, true)
	end)
end


RegisterNetEvent('tac_basicneeds:onEat')
AddEventHandler('tac_basicneeds:onEat', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_cs_burger_01'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
            TriggerEvent('status:setState', 25, 500)
			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)

				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)