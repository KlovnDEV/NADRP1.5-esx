ESX = nil
local timing, isPlayerWhitelisted = math.ceil(1 * 60000), false

local Device
local copsOnline
local RobbingATM = false
local HackingATM = false

local streetName
local _

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	PlayerData = ESX.GetPlayerData()
	isPlayerWhitelisted = refreshPlayerWhitelisted()
end)

RegisterNetEvent('tac:playerLoaded')
AddEventHandler('tac:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('tac:setJob')
AddEventHandler('tac:setJob', function(job)
	ESX.PlayerData.job = job
	isPlayerWhitelisted = refreshPlayerWhitelisted()
end)


-- Refresh police online:
function refreshPlayerWhitelisted()	
	if not ESX.PlayerData then
		return false
	end
	if not ESX.PlayerData.job then
		return false
	end
	if Config.PoliceDatabaseName == ESX.PlayerData.job.name then
		return true
	end
	return false
end

-- Core Thread Function:
Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(PlayerPedId())
		if not RobbingATM or not HackingATM then
			for k,v in pairs(Config.ATMs) do
				if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true) <= 1.5 then
					found = true
					-- DrawText3Ds(v.x,v.y,v.z, "Press ~g~[G]~s~ to ~r~Rob~s~ the ~y~ATM~s~")
					if IsControlJustPressed(0, 47) then
						startRobbingATM()
						break;
					end
				end
			end
		end
		if found then
			Citizen.Wait(1)
		else
			Citizen.Wait(1000)
		end
		found = false
	end
end)

-- Starting ATM Robbery:
function startRobbingATM()
	ESX.TriggerServerCallback("esx_atmRobbery:isRobbingPossible", function(cooldownATM)
		if not cooldownATM and not IsPedInAnyVehicle(PlayerPedId(), false) then
			ESX.TriggerServerCallback('esx_atmRobbery:getOnlinePoliceCount', function(policeCount)
				if policeCount then
					local lol = 1
					local hasItem = exports['ffrp-inventory']:hasEnoughOfItem("usbdevice", 1, false)
					if hasItem then
						local luck = math.random(1,3)
						if luck == 4 then
							TriggerEvent("inventory:removeItem", "usbdevice", 1)
							exports['mythic_notify']:DoHudText('error', 'You have fried your USB!')
							TriggerEvent('civilian:alertPolice', 90.0, 'atmrob', 0,0,0)
						end
						if luck ~= 3 then
							RobbingATM = true
							TriggerServerEvent("esx_atmRobbery:CooldownATM")
							FreezeEntityPosition(player,true)
							local player = PlayerPedId()
							local playerPos = GetEntityCoords(player)
							-- animation 1:
							local animDict = "random@atmrobberygen@male"
							local animName = "idle_a"

							RequestAnimDict(animDict)
							while not HasAnimDictLoaded(animDict) do
								Citizen.Wait(0)
							end
							local chance = math.random(1,2)
							if chance == 2 then
								TriggerEvent('civilian:alertPolice', 90.0, 'atmrob', 0,0,0)
							end
							exports["ffrp-taskbar"]:taskBar(20000,"Connecting Device",false,false)
							-- exports['progressBars']:startUI(12000, "CONNECTING DEVICE")
							Citizen.Wait(100)
							TaskPlayAnim(player,animDict,animName,3.0,0.5,-1,31,1.0,0,0)
							TaskStartScenarioInPlace(player, 'WORLD_HUMAN_STAND_MOBILE', 0, true)
							TriggerEvent("mhacking:show")
							TriggerEvent("mhacking:start",4,20,hackingEvent)
							HackingATM = true
						else
							RobbingATM = false
						end
					else
						exports['mythic_notify']:DoHudText('error', 'You need a certain device to do this!')
					end
				else
					RobbingATM = false
				end
			end)
		else
			RobbingATM = false
		end
	end)
end


-- Hacking Event:
function hackingEvent(success)
	local player = PlayerPedId()
    FreezeEntityPosition(player,false)
    TriggerEvent('mhacking:hide')
	if success then
		local finished = exports["ffrp-skillbar"]:taskBar(math.random(1000,1500),math.random(15,20))
		if finished == 100 then
			TriggerServerEvent("esx_atmRobbery:success")	
		else
			print("COME BACK LATER")
		end
		TriggerEvent("DoLongHudText","You Successfully Hacked he ATM",2)
        -- ESX.ShowNotification("You ~g~successfully~s~ hacked the ~y~ATM~s~")
	else
		TriggerEvent("DoLongHudText","You Failed To Hack The ATM",2)
		TriggerEvent('civilian:alertPolice', 90.0, 'atmrob', 0,0,0)
		-- ESX.ShowNotification("You ~r~failed~s~ to hack the ~y~ATM~s~!")
	end
	ClearPedTasks(player)
	ClearPedSecondaryTask(player)	
	RobbingATM = false
	HackingATM = false
end
