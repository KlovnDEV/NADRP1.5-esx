
local startX = 2388.725  
local startY = 5044.985
local startZ = 46.304
---------------------------------------------
local CX = -96.007   
local CY = 6206.92
local CZ = 31.02
---
local CX2 = -100.64   
local CY2 = 6202.30
local CZ2 = 31.02
---
local PX = -106.44   
local PY = 6204.29
local PZ = 31.02
---
local PX2 = -104.20  
local PY2 = 6206.45
local PZ2 = 31.02
---
local sellX = -1177.17   
local sellY = -890.68
local sellZ = 13.79

local chicken1
local chicken2
local chicken3
local Caught1 = 0
local Caught2 = 0
local Caught3 = 0
local NumberCaught = 0
local start = false
local prop
local packcar = false
local box
local chick
local package = 0
--------------
local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end) 

Citizen.CreateThread(function()
	local chickenfarm = AddBlipForCoord(startX, startY, startZ)
	SetBlipSprite (chickenfarm, 126)
	SetBlipDisplay(chickenfarm, 4)
	SetBlipScale  (chickenfarm, 0.6)
	SetBlipColour (chickenfarm, 46)
	SetBlipAsShortRange(chickenfarm, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Chicken Farm')
	EndTextCommandSetBlipName(chickenfarm)
	
	local slaughterhouse = AddBlipForCoord(CX, CY, CZ)
	SetBlipSprite (slaughterhouse, 273)
	SetBlipDisplay(slaughterhouse, 4)
	SetBlipScale  (slaughterhouse, 0.7)
	SetBlipColour (slaughterhouse, 46)
	SetBlipAsShortRange(slaughterhouse, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Slaughterhouse')
	EndTextCommandSetBlipName(slaughterhouse)

	local chickensell = AddBlipForCoord(sellX, sellY, sellZ)
	SetBlipSprite (chickensell, 478)
	SetBlipDisplay(chickensell, 4)
	SetBlipScale  (chickensell, 0.6)
	SetBlipColour (chickensell, 46)
	SetBlipAsShortRange(chickensell, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Chicken Dealer')
	EndTextCommandSetBlipName(chickensell)
end) 

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawText3D2(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
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
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end
Citizen.CreateThread(function()
    while true do
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, startX, startY, startZ)

		if dist <= 20.0 then
			Citizen.Wait(0)
			DrawMarker(27, startX, startY, startZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
		else
			Citizen.Wait(1500)
		end
		
		if dist <= 2.5 then
			DrawText3D2(startX, startY, startZ, "~b~[E]~w~ To start catching chickens")
		end

		if dist <= 0.5 then
			if IsControlJustPressed(0, Keys['E']) then -- "E"
				spawnchicken()
			end
		end
	end
end)

local sleep = 500
Citizen.CreateThread(function()
	while true do
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, CX, CY, CZ)
		local dist2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, CX2, CY2, CZ2)
		local distP = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, PX, PY, PZ)
		local distP2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, PX2, PY2, PZ2)

		if dist <= 25.0 then
			sleep = 0
			DrawMarker(27, CX, CY, CZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
			DrawMarker(27, CX2, CY2, CZ2-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
			DrawMarker(27, PX, PY, PZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
			DrawMarker(27, PX2, PY2, PZ2-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
		end
		
		if dist <= 2.5 then
			DrawText3D2(CX, CY, CZ, "~b~[E]~w~ To portion the chicken")
		end

		if dist <= 0.5 then
			if IsControlJustPressed(0, Keys['E']) then
				if exports["nadrp-inventory"]:hasEnoughOfItem("alivechicken",1,false) then
					PortionChicken()
				else
					exports['mythic_notify']:SendAlert('error', 'You dont have enough chickens.')
				end
			end
		end
		
		if dist2 <= 2.5 then
			sleep = 0
			DrawText3D2(CX2, CY2, CZ2, "~b~[E]~w~ To portion the chicken")
		end

		if dist2 <= 0.5 then
			if IsControlJustPressed(0, Keys['E']) then
				if	exports["nadrp-inventory"]:hasEnoughOfItem("alivechicken",1,false) then
					PortionChicken()
				else
					exports['mythic_notify']:SendAlert('error', 'You dont have enough chickens.')
				end
			end
		end

		if distP <= 2.5 and package == 0 then
			sleep = 0
			DrawText3D2(PX, PY, PZ, "~b~[E]~w~ To pack chicken")
		elseif distP <= 2.5 and package == 1 then
			sleep = 0
			DrawText3D2(PX, PY, PZ, "~b~[G]~w~ To stop packing")
			DrawText3D2(PX, PY, PZ+0.1, "~b~[E]~w~ To keep packing")
		end

		if distP <= 0.5 then
			sleep = 0
			if IsControlJustPressed(0, Keys['E']) and exports["nadrp-inventory"]:hasEnoughOfItem("slaughteredchicken",1,false) then 
				PackChicken(1)
			elseif IsControlJustPressed(0, Keys['G']) then
				StopPacking(1)
			end
		end
		
		if distP2 <= 2.5 and package == 0 then
			sleep = 0
			DrawText3D2(PX2, PY2, PZ2, "~b~[E]~w~ To pack chicken")
		elseif distP2 <= 2.5 and package == 1 then
			sleep = 0
			DrawText3D2(PX2, PY2, PZ2, "~b~[G]~w~ To stop packing")
			DrawText3D2(PX2, PY2, PZ2+0.1, "~b~[E]~w~ To keep packing")
		end

		if distP2 <= 0.5 then
			sleep = 0
			if IsControlJustPressed(0, Keys['E']) and exports["nadrp-inventory"]:hasEnoughOfItem("slaughteredchicken",1,false) then -- "E"
				PackChicken(2)
			elseif IsControlJustPressed(0, Keys['G']) then
				StopPacking(2)
			end
		end	
		Citizen.Wait(sleep)
	end
end)

function StopPacking(position)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	packcar = true
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
	package = 0
	while packcar do
		Citizen.Wait(250)
		local vehicle   = ESX.Game.GetVehicleInDirection()
		local coords    = GetEntityCoords(GetPlayerPed(-1))
		LoadDict('anim@heists@box_carry@')

		if not IsEntityPlayingAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 3 ) and packcar == true then
			TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		end
	
		if DoesEntityExist(vehicle) then
			packcar = false
			exports['mythic_notify']:SendAlert('inform', 'You stored the chickens in the vehicle.')
			LoadDict('anim@heists@narcotics@trash')
			TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@narcotics@trash', "throw_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			Citizen.Wait(900)
			ClearPedTasks(GetPlayerPed(-1))
			DeleteEntity(prop)
		end
	end
end

function PackChicken(position)
	SetEntityHeading(GetPlayerPed(-1), 40.0)
	local PedCoords = GetEntityCoords(GetPlayerPed(-1))
	chick = CreateObject(GetHashKey('prop_cs_steak'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
	AttachEntityToEntity(chick, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0x49D9), 0.15, 0.0, 0.01, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
	box = CreateObject(GetHashKey('prop_cs_clothes_box'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
	AttachEntityToEntity(box, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.13, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)
	package = 1
	LoadDict("anim@heists@ornate_bank@grab_cash_heels")
	TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
	local finished = exports["nadrp-taskbar"]:taskBar(10000,"Packaging Chicken",false,false,playerVeh)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	--Citizen.Wait(6500)
	if (finished == 100) then
		local hasItem = exports["nadrp-inventory"]:hasEnoughOfItem("slaughteredchicken", 2, false)
		if hasItem then
			TriggerEvent('inventory:removeItem',"slaughteredchicken", 2) 
			TriggerEvent("player:receiveItem","packagedchicken",2)
			exports['mythic_notify']:SendAlert('inform', 'Keep packing the chicken or go to the vehicle and store it.')
			ClearPedTasks(GetPlayerPed(-1))
			DeleteEntity(box)
			DeleteEntity(chick)
		end
	else
		exports['mythic_notify']:SendAlert('error', 'You have nothing to pack!')
	end
end


function PortionChicken()

	local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
	LoadDict(dict)
	FreezeEntityPosition(GetPlayerPed(-1),true)
	TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	local PedCoords = GetEntityCoords(GetPlayerPed(-1))
	knife = CreateObject(GetHashKey('prop_knife'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
	AttachEntityToEntity(knife, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0xDEAD), 0.13, 0.14, 0.09, 40.0, 0.0, 0.0, false, false, false, false, 2, true)
	local finished = exports["nadrp-taskbar"]:taskBar(10000,"Chopping up chicken",false,false,playerVeh)
	if position == 1 then
		SetEntityHeading(GetPlayerPed(-1), 311.0)
		chicken = CreateObject(GetHashKey('prop_int_cf_chick_01'),-94.87, 6207.008, 30.08, true, true, true)
		SetEntityRotation(chicken,90.0, 0.0, 45.0, 1,true)
	elseif position == 2 then
		SetEntityHeading(GetPlayerPed(-1), 222.0)
		chicken = CreateObject(GetHashKey('prop_int_cf_chick_01'),-100.39, 6201.56, 29.99, true, true, true)
		SetEntityRotation(chicken,90.0, 0.0, -45.0, 1,true)
	end
	--Citizen.Wait(5000)
	--ESX.ShowNotification("~b~Poćwiartowałeś chickena.")
	exports['mythic_notify']:SendAlert('inform', 'You slaughtered a chicken!')
	FreezeEntityPosition(GetPlayerPed(-1),false)
	DeleteEntity(chicken)
	DeleteEntity(knife)
	ClearPedTasks(GetPlayerPed(-1))
	if (finished == 100) then
		local hasItem = exports["nadrp-inventory"]:hasEnoughOfItem("alivechicken", 1, false)
		if hasItem then
			TriggerEvent('inventory:removeItem',"alivechicken", 1)
			TriggerEvent("player:receiveItem","slaughteredchicken",2)
		end
	end
end

function Vehicle()
	DoScreenFadeOut(500)
	Citizen.Wait(500)
	SetEntityCoordsNoOffset(GetPlayerPed(-1), startX+2, startY+2, startZ, 0, 0, 1)
	if DoesEntityExist(chicken1) or DoesEntityExist(chicken2) or DoesEntityExist(chicken3) then
		DeleteEntity(chicken1)
		DeleteEntity(chicken2)
		DeleteEntity(chicken3)
	end
	Citizen.Wait(500)
	DoScreenFadeIn(500)

	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
							
	local nearcar = true

	while nearcar do
		Citizen.Wait(250)
		local vehicle   = ESX.Game.GetVehicleInDirection()
		local coords    = GetEntityCoords(GetPlayerPed(-1))
		LoadDict('anim@heists@box_carry@')

		if not IsEntityPlayingAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 3 ) and nearcar == true then
			TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		end
		
		if DoesEntityExist(vehicle) then
			nearcar = false
			exports['mythic_notify']:SendAlert('inform', 'You put the chicken in the vehicle!')
			LoadDict('anim@heists@narcotics@trash')
			TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@narcotics@trash', "throw_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			Citizen.Wait(900)
			ClearPedTasks(GetPlayerPed(-1))
			DeleteEntity(prop)
			TriggerEvent("player:receiveItem","alivechicken",3)
		end
	end
end


function spawnchicken()
	DoScreenFadeOut(500)
	Citizen.Wait(500)
	SetEntityCoordsNoOffset(GetPlayerPed(-1), 2385.963, 5047.333, 46.400, 0, 0, 1)
	RequestModel(GetHashKey('a_c_hen'))
	while not HasModelLoaded(GetHashKey('a_c_hen')) do
		Wait(1)
	end
	chicken1 = CreatePed(26, "a_c_hen", 2370.262, 5052.913, 46.437, 276.351, true, false)

	chicken2 = CreatePed(26, "a_c_hen", 2372.040, 5059.604, 46.444, 223.595, true, false)
	chicken3 = CreatePed(26, "a_c_hen", 2379.192, 5062.992, 46.444, 195.477, true, false)
	TaskReactAndFleePed(chicken1, GetPlayerPed(-1))
	TaskReactAndFleePed(chicken2, GetPlayerPed(-1))
	TaskReactAndFleePed(chicken3, GetPlayerPed(-1))
	Citizen.Wait(500)
	DoScreenFadeIn(500)
	start = true
end

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

Citizen.CreateThread(function()
    while true do
		if start == true then
			local chicken1Coords = GetEntityCoords(chicken1)
			local chicken2Coords = GetEntityCoords(chicken2)
			local chicken3Coords = GetEntityCoords(chicken3)
			local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, chicken1Coords.x, chicken1Coords.y, chicken1Coords.z)
			local dist2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, chicken2Coords.x, chicken2Coords.y, chicken2Coords.z)
			local dist3 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, chicken3Coords.x, chicken3Coords.y, chicken3Coords.z)
			
			if NumberCaught == 3 then
				Caught1 = 0
				Caught2 = 0
				Caught3 = 0
				NumberCaught = 0
				start = false
				exports['mythic_notify']:SendAlert('inform', 'Take the chickens to the vehicle!')
				Vehicle()
			end

			if dist <= 1.0 then
				Citizen.Wait(0)
				DrawText3D2(chicken1Coords.x, chicken1Coords.y, chicken1Coords.z+0.5, "~o~[E]~b~ Catch the chicken")
				if IsControlJustPressed(0, Keys['E']) then 
					Caught1 = 1
					CaughtChicken()
				end	
			elseif dist2 <= 1.0 then
				Citizen.Wait(0)
				DrawText3D2(chicken2Coords.x, chicken2Coords.y, chicken2Coords.z+0.5, "~o~[E]~b~ Catch the chicken")
				if IsControlJustPressed(0, Keys['E']) then 
					Caught2 = 1
					CaughtChicken()
				end	
			elseif dist3 <= 1.0 then
				Citizen.Wait(0)
				DrawText3D2(chicken3Coords.x, chicken3Coords.y, chicken3Coords.z+0.5, "~o~[E]~b~ Catch the chicken")
				if IsControlJustPressed(0, Keys['E']) then 
					Caught3 = 1
					CaughtChicken()
				end
			else
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

local ragdoll = false

function CaughtChicken()
	LoadDict('move_jump')
	TaskPlayAnim(GetPlayerPed(-1), 'move_jump', 'dive_start_run', 8.0, -8.0, -1, 0, 0.0, 0, 0, 0)
	Citizen.Wait(600)
	SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
	Citizen.Wait(1000)
	ragdoll = true
	local Chance = math.random(1,100)
	if Chance <= 60 then
			exports['mythic_notify']:SendAlert('success', 'You managed to catch 1 chicken!')
			if Caught1 == 1 then
				DeleteEntity(chicken1)
				Caught1 = 0
				NumberCaught = NumberCaught +1
			elseif Caught2 == 1 then
				DeleteEntity(chicken2)
				Caught2 = 0
				NumberCaught = NumberCaught +1
			elseif Caught3 == 1 then
				DeleteEntity(chicken3)
				Caught3 = 0
				NumberCaught = NumberCaught +1
			end
		else
		exports['mythic_notify']:SendAlert('error', 'The chicken escaped your arms!')
	end
end

local DumbFuckCount = 0
Citizen.CreateThread(function()
    while true do
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, sellX, sellY, sellZ)
		if dist <= 20.0 then
			Citizen.Wait(0)
			DrawMarker(27, sellX, sellY, sellZ-0.96, 0, 0, 0, 0, 0, 0, 2.20, 2.20, 2.20, 255, 255, 255, 200, 0, 0, 0, 0)
		else
			Citizen.Wait(1000)
		end
	
		if dist <= 2.0 then
			DrawText3D2(sellX, sellY, sellZ+0.1, "[E] Sell Packed Chickens")
			if IsControlJustPressed(0, Keys['E']) then
				local itemCount = exports["nadrp-inventory"]:getQuantity("packagedchicken")
				if not selling then
					if exports["nadrp-inventory"]:hasEnoughOfItem("packagedchicken",1,false) then
						selling = true
						exports['t0sic_loadingbar']:StartDelayedFunction('Trading Chicken', (math.random(40, 60) * 1000), function()
							selling = false
							if #(GetEntityCoords(PlayerPedId()) - vector3(sellX, sellY, sellZ)) < 5.0 then
								if exports["nadrp-inventory"]:hasEnoughOfItem("packagedchicken",itemCount,false) then
									TriggerEvent('inventory:removeItem',"packagedchicken", itemCount) 
									TriggerServerEvent('Ford:Trade2', itemCount)
									Wait(2000)
									TriggerServerEvent("sendingItemstoClient", cid, PlayerId())
								else
									local data = {
										name = GetPlayerName(PlayerId()),
										title ='Player attempted to exploit chicken selling',
										reason = 'Player Spammed Chicken Selling',
										info = 'Player attempted to drop chicken while selling'
									}
									TriggerServerEvent('nadrp-log:SendDiscordLog', data)
								end
							else
								exports['mythic_notify']:SendAlert('error', 'You moved too far!')
							end
							if DumbFuckCount > 7 then
								local data = {
									name = GetPlayerName(PlayerId()),
									title ='Player attempted to exploit chicken selling',
									reason = 'Player Spammed Chicken Selling',
									info = 'Amount of times spammed: '..DumbFuckCount
								}
								TriggerServerEvent('nadrp-log:SendDiscordLog', data)
							end
							DumbFuckCount = 0
						end)
					else
						exports['mythic_notify']:SendAlert('error', 'You have nothing to sell!')
					end
				else
					DumbFuckCount = DumbFuckCount + 1
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
		if start then
			Citizen.Wait(0)
			if ragdoll then
				SetEntityHealth(PlayerPedId(), 200)
				TriggerEvent('mythic_hospital:client:ResetLimbs')
				TriggerEvent('mythic_hospital:client:RemoveBleed')
				ragdoll = false
			end
		else
			Citizen.Wait(500)
		end
	end
end)