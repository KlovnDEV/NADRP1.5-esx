ESX   = nil
local PlayerData = {}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('tac:getSharedObject', function(obj) 
			ESX = obj
		end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('tac:playerLoaded')
AddEventHandler('tac:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('tac:setJob')
AddEventHandler('tac:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if NetworkIsSessionStarted() then
			TriggerServerEvent('nadrp-admin:AddPlayer')
		   	TriggerServerEvent("nadrp-scoreboard:AddPlayer")
			TriggerEvent("kashactersC:SetupCharacters")
			Citizen.Wait(5000)
			TriggerEvent("kashactersC:WelcomePage")
			break
		end
    end
end)

-- local IsChoosing = true
-- Citizen.CreateThread(function ()
--     while true do
--         Citizen.Wait(0)
-- 		if IsChoosing then
-- 			TriggerScreenblurFadeIn(0)
-- 		end

-- 		for i=1, #Config.Logouts, 1 do
-- 			local player = GetPlayerPed(-1)
-- 			local playerloc = GetEntityCoords(player, 0)
-- 			local logoutspot = Config.Logouts[i]
-- 			local logoutdistance = GetDistanceBetweenCoords(logoutspot['x'], logoutspot['y'], logoutspot['z'], playerloc['x'], playerloc['y'], playerloc['z'], true)
-- 			if logoutdistance <= 8 then
-- 				DrawText3Ds(logoutspot.x,logoutspot.y,logoutspot.z + 0.10, "[~b~/logout~s~] - Swap Characters")
-- 			end
-- 		end
-- 	end
-- end)

-- Citizen.CreateThread(function()

-- 	for i=1, #Config.Logouts, 1 do
-- 		local logoutspot = Config.Logouts[i]
-- 		local blip = AddBlipForCoord(logoutspot)

-- 		SetBlipSprite(blip, 480)
-- 		SetBlipDisplay(blip, 4)
-- 		SetBlipScale(blip, 0.7)
-- 		SetBlipColour(blip, 4)
-- 		SetBlipAsShortRange(blip, true)
-- 		BeginTextCommandSetBlipName("STRING")
-- 		AddTextComponentString("Logout")
-- 		EndTextCommandSetBlipName(blip)
-- 	end
-- end)

local cam = nil
local cam2 = nil
RegisterNetEvent('kashactersC:SetupCharacters')
AddEventHandler('kashactersC:SetupCharacters', function()
    SetTimecycleModifier('hud_def_blur')

	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 55.356, 497.884, 262.432, 0.00,0.00,10.00, 72.00, false, 0)
    SetCamActive(cam, true)
	RenderScriptCams(true, false, 1, true, true)
	TriggerServerEvent('nadrp-login:GetSpawnPos')
end)

RegisterNetEvent('kashactersC:WelcomePage')
AddEventHandler('kashactersC:WelcomePage', function()
    SetNuiFocus(true, true)
	SendNUIMessage({
        action = "openwelcome"
	})
end)

RegisterNetEvent('kashactersC:SetupUI')
AddEventHandler('kashactersC:SetupUI', function(Characters)
	IsChoosing = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "openui",
        characters = Characters,
    })
end)

RegisterNetEvent('kashactersC:SpawnCharacter')
AddEventHandler('kashactersC:SpawnCharacter', function(spawn, isnew)
	TriggerServerEvent('es:firstJoinProper')
	TriggerEvent('es:allowedToSpawn')
	Citizen.Wait(3700)
	if isnew then
		IsChoosing = false
		TriggerScreenblurFadeOut(0)
		TriggerEvent('tac_identity:showRegisterIdentity')
		SendNUIMessage({
        	action = "displayback"
		})
		SetTimecycleModifier('default')
		cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 55.356, 497.884, 262.432, 0.00,0.00,10.00, 72.00, false, 0)
		SetCamActive(cam, true)
		RenderScriptCams(true, false, 1, true, true)
	else
		SetTimecycleModifier('default')
		local pos = spawn
		Citizen.Wait(900)
		exports.spawnmanager:setAutoSpawn(false)
		TriggerEvent('tac_ambulancejob:multicharacter', source)
		--TriggerEvent("spawnselector:setNui")
		IsChoosing = false
		TriggerEvent('nadrp-login:SetStates')
		TriggerScreenblurFadeOut(0)
		DestroyCam(cam, false)
	end
	SetNuiFocus(false,false)
end)

RegisterNetEvent('kashactersC:ReloadCharacters')
AddEventHandler('kashactersC:ReloadCharacters', function()
    TriggerServerEvent("kashactersS:SetupCharacters", true)
    TriggerEvent("kashactersC:SetupCharacters")
end)

RegisterNUICallback("CharacterChosen", function(data, cb)
    SetNuiFocus(false,false)
    TriggerServerEvent('kashactersS:CharacterChosen', data.charid, data.ischar, data.spawnid or "1")
    cb("ok")
end)

RegisterNUICallback("DeleteCharacter", function(data, cb)
    SetNuiFocus(false,false)
    TriggerServerEvent('kashactersS:DeleteCharacter', data.charid)
    cb("ok")
end)

RegisterNUICallback("ShowSelection", function(data, cb)
	TriggerServerEvent("kashactersS:SetupCharacters")
end)

RegisterNetEvent('nadrp-login:SetStates')
AddEventHandler('nadrp-login:SetStates', function()
	TriggerServerEvent("nadrp-clothes:get_character_current")
	TriggerServerEvent("nadrp-clothes:get_character_face")
	TriggerServerEvent("nadrp-clothes:retrieve_tats")
	TriggerServerEvent('housing:RequestHouseInfo')
	TriggerServerEvent('nadrp-login:GetSpawnPos')
	TriggerServerEvent('nadrp-weapons:getAmmo')
	TriggerServerEvent('inventory:updateCash')
	TriggerServerEvent('nadrp-motels:GetHotel')
	TriggerServerEvent('Server:GetHandle')
	TriggerServerEvent('ReturnHouseKeys')
	TriggerEvent('x-hotwire:resetKeys')
	TriggerServerEvent('GarageData')
end)