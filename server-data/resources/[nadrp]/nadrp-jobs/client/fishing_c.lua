ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

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

local fishing = false
local lastInput = 0
local pause = false
local pausetimer = 0
local correct = 0
local CX = -1071.064
local CY = -2003.503
local CZ = 15.786

local PX = -1071.064  
local PY = -2003.503
local PZ = 15.786

local PX2 = -104.20  
local PY2 = 6206.45
local PZ2 = 33.02


local CX2 = -100.64   
local CY2 = 6202.30
local CZ2 = 33.02


FishTime = {a = 20000, b = 44000}
	
FishPrice = {a = 80, b = 145} --Will get clean money THIS PRICE IS FOR EVERY 5 FISH ITEMS (5 kg)
TurtlePrice = {a = 128, b = 220} --Will get dirty money
SharkPrice = {a = 325, b = 422} --Will get dirty money

SellFish = {x = -1096.102, y = -324.94, z = 37.824} --Place where players can sell their fish
SellTurtle = {x = 3804.0, y = 4443.3, z = 3.0} --Place where players can sell their turtles 
SellShark = {x = 2517.6 , y = 4218.0, z = 38.8} --Place where players can sell their sharks


MarkerZones = { 	
    {x = -3426.7   ,y = 955.66 ,z = 7.35, xs = -3426.2  , ys = 942.4, zs = 1.1 },
	{x = -732.9     ,y = -1309.7 ,z = 4.0, xs = -725.7    , ys = -1351.5, zs = 0.5 },  
	{x = -1607.6      ,y =  5252.8 ,z = 3.0, xs = -1590.2      , ys = 5278.8, zs = 1.0 },
	{x = 3855.0        ,y =  4463.7 ,z = 1.6, xs = 3885.2       , ys =  4507.2, zs = 1.0 },
	{x = 1330.8        ,y =  4226.6 ,z = 32.9, xs = 1334.2         , ys =  4192.4, zs = 30.0 },	
}

local bait = "none"

local blip = AddBlipForCoord(SellFish.x, SellFish.y, SellFish.z)
SetBlipSprite (blip, 356)
SetBlipDisplay(blip, 4)
SetBlipScale  (blip, 0.6)
SetBlipColour (blip, 17)
SetBlipAsShortRange(blip, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("Fish selling")
EndTextCommandSetBlipName(blip)

local blip2 = AddBlipForCoord(SellTurtle.x, SellTurtle.y, SellTurtle.z)
SetBlipSprite (blip2, 68)
SetBlipDisplay(blip2, 4)
SetBlipScale  (blip2, 0.6)
SetBlipColour (blip2, 49)
SetBlipAsShortRange(blip2, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("Sea Turtle dealer")
EndTextCommandSetBlipName(blip2)

local blip3 = AddBlipForCoord(SellShark.x, SellShark.y, SellShark.z)
SetBlipSprite (blip3, 68)
SetBlipDisplay(blip3, 4)
SetBlipScale  (blip3, 0.6)
SetBlipColour (blip3, 49)
SetBlipAsShortRange(blip3, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("Shark meat dealer")
EndTextCommandSetBlipName(blip3)

local blip4 = AddBlipForCoord(-1071.064, -2003.503,15.786)
SetBlipSprite (blip4, 68)
SetBlipDisplay(blip4, 4)
SetBlipScale  (blip4, 0.6)
SetBlipColour (blip4, 4)
SetBlipAsShortRange(blip4, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("Fish Packing")
EndTextCommandSetBlipName(blip4)

for _, info in pairs(MarkerZones) do
	info.blip = AddBlipForCoord(info.x, info.y, info.z)
	SetBlipSprite(info.blip, 455)
	SetBlipDisplay(info.blip, 4)
	SetBlipScale(info.blip, 0.6)
	SetBlipColour(info.blip, 20)
	SetBlipAsShortRange(info.blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Boat rental")
	EndTextCommandSetBlipName(info.blip)
end
	
Citizen.CreateThread(function()
    while true do
		for k in pairs(MarkerZones) do
			if #(vector3(MarkerZones[k].x, MarkerZones[k].y, MarkerZones[k].z) - GetEntityCoords(PlayerPedId())) < 4.0 then
				Citizen.Wait(0)
				DrawMarker(1, MarkerZones[k].x, MarkerZones[k].y, MarkerZones[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 1.0, 0, 150, 150, 100, 0, 0, 0, 0)
			else
				Citizen.Wait(1000)
			end
		end
    end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
	while true do
		Wait(600)
		if pause and fishing then
			pausetimer = pausetimer + 1
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		if fishing then
			Citizen.Wait(0)
			if IsControlJustPressed(1, 165) or IsDisabledControlJustPressed(1, 165) then
				input = 5
			end
			if IsControlJustPressed(1, 159) or IsDisabledControlJustPressed(1, 159) then
				input = 6
			end
			if IsControlJustPressed(1, 161) or IsDisabledControlJustPressed(1, 161) then
				input = 7
			end
			if IsControlJustPressed(1, 162) or IsDisabledControlJustPressed(1, 162) then
				input = 8
			end
			if IsControlJustPressed(1, 163) or IsDisabledControlJustPressed(1, 163) then
				input = 9
			end
			
			if IsControlJustPressed(0, Keys['E']) or IsDisabledControlJustPressed(0, Keys['E']) then
				fishing = false
				exports['mythic_notify']:DoLongHudText('error', 'Stopped fishing')
				ClearPedTasks(PlayerPedId())
			end

			if fishing then
			
				playerPed = GetPlayerPed(-1)
				local pos = GetEntityCoords(GetPlayerPed(-1))
				if GetWaterHeight(pos.x, pos.y, pos.z-2, pos.z-3.0)  then
					
				else
					fishing = false
					--exports['mythic_notify']:DoLongHudText('error', 'Stopped fishing')
				end
				if IsEntityDead(playerPed) or IsEntityInWater(playerPed) then
					--exports['mythic_notify']:DoLongHudText('error', 'Stopped fishing')
				end
			end

			if pausetimer > 4 then
				input = 99
			end

			if pause and input ~= 0 then

				if input == correct then
					print('CAUGHT')
					TriggerServerEvent('fishing:catch', bait)
				else
					exports['mythic_notify']:DoLongHudText('error', 'Fish got free')
				end
				pause = false
			end
		else
			Citizen.Wait(1000)
		end
	end
end)


local DumbFuckCount = 0
Citizen.CreateThread(function()
    while true do
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, SellFish.x, SellFish.y, SellFish.z)
		if dist <= 3.0 then
			Citizen.Wait(0)
			DrawMarker(27, SellFish.x, SellFish.y, SellFish.z-0.96, 0, 0, 0, 0, 0, 0, 4.20, 4.20, 4.20, 255, 255, 255, 200, 0, 0, 0, 0)
			DrawText3D2(SellFish.x, SellFish.y, SellFish.z+0.1, "[E] Sell Packaged Fish")
			if IsControlJustPressed(0, Keys['E']) then
				local itemCount = exports["nadrp-inventory"]:getQuantity("packagedfish")
				if not selling then
					if exports["nadrp-inventory"]:hasEnoughOfItem("packagedfish",1,false) then
						selling = true
						exports['t0sic_loadingbar']:StartDelayedFunction('Trading Packaged Fish', (math.random(40, 60) * 1000), function()
							selling = false
							if #(GetEntityCoords(PlayerPedId()) - vector3(SellFish.x, SellFish.y, SellFish.z)) < 5.0 then
								if exports["nadrp-inventory"]:hasEnoughOfItem("packagedfish",itemCount,false) then
									TriggerServerEvent('Ford:TradeFish', itemCount)
									Wait(2000)
									TriggerServerEvent("sendingItemstoClient", cid, PlayerId())
								else
									local data = {
										name = GetPlayerName(PlayerId()),
										title ='Player attempted to exploit fish selling',
										reason = 'Player Spammed fish Selling',
										info = 'Player attempted to drop fish while selling'
									}
									TriggerServerEvent('nadrp-log:SendDiscordLog', data)
								end
							else
								exports['mythic_notify']:DoLongHudText('error', 'You moved too far!')
							end
							if DumbFuckCount > 15 then
								local data = {
									name = GetPlayerName(PlayerId()),
									title ='Player attempted to exploit fish selling',
									reason = 'Player Spammed Fish Selling',
									info = 'Amount of times spammed: '..DumbFuckCount
								}
								TriggerServerEvent('nadrp-log:SendDiscordLog', data)
							end
							DumbFuckCount = 0
						end)
					else
						exports['mythic_notify']:DoLongHudText('error', 'You have nothing to sell!')
					end
				else
					DumbFuckCount = DumbFuckCount + 1
				end
			end
		else
			Citizen.Wait(1000)
		end
	end
end)


Citizen.CreateThread(function()
    while true do
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, SellTurtle.x, SellTurtle.y, SellTurtle.z)
		if dist <= 5.0 then
			Citizen.Wait(0)
			DrawMarker(27, SellTurtle.x, SellTurtle.y, SellTurtle.z-0.96, 0, 0, 0, 0, 0, 0, 2.20, 2.20, 2.20, 255, 255, 255, 200, 0, 0, 0, 0)
			DrawText3D2(SellTurtle.x, SellTurtle.y, SellTurtle.z+1.3, "[E] Sell Turtles")
			if IsControlJustPressed(0, Keys['E']) then 
				local itemCount = exports["nadrp-inventory"]:getQuantity("turtle")
				if not selling then
					if exports["nadrp-inventory"]:hasEnoughOfItem("turtle",1,false) then
						selling = true
						exports['t0sic_loadingbar']:StartDelayedFunction('Trading Turtle', (math.random(40, 60) * 1000), function()
							selling = false
							if #(GetEntityCoords(PlayerPedId()) - vector3(SellTurtle.x, SellTurtle.y, SellTurtle.z)) < 5.0 then
								if exports["nadrp-inventory"]:hasEnoughOfItem("turtle",itemCount,false) then 
									TriggerEvent('inventory:removeItem',"turtle", itemCount) 
									TriggerServerEvent('Ford:TradeTurtle', itemCount)
									Wait(2000)
									TriggerServerEvent("sendingItemstoClient", cid, PlayerId())
								else
									local data = {
										name = GetPlayerName(PlayerId()),
										title ='Player attempted to exploit turtle selling',
										reason = 'Player Spammed turtle Selling',
										info = 'Player attempted to drop turtle while selling'
									}
									TriggerServerEvent('nadrp-log:SendDiscordLog', data)
								end
							else
								exports['mythic_notify']:DoLongHudText('error', 'You moved too far!')
							end
							if DumbFuckCount > 15 then
								local data = {
									name = GetPlayerName(PlayerId()),
									title ='Player attempted to exploit turtle selling',
									reason = 'Player Spammed Turtle Selling',
									info = 'Amount of times spammed: '..DumbFuckCount
								}
								TriggerServerEvent('nadrp-log:SendDiscordLog', data)
							end
							DumbFuckCount = 0
						end)
					else
						exports['mythic_notify']:DoLongHudText('error', 'You have nothing to sell!')
					end
				else
					DumbFuckCount = DumbFuckCount + 1
				end
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, SellShark.x, SellShark.y, SellShark.z)
		local itemCount = exports["nadrp-inventory"]:getQuantity("shark")

		if dist <= 2.0 then
			Citizen.Wait(0)
			DrawMarker(27, SellShark.x, SellShark.y, SellShark.z-0.96, 0, 0, 0, 0, 0, 0, 2.20, 2.20, 2.20, 255, 255, 255, 200, 0, 0, 0, 0)
			DrawText3D2(SellShark.x, SellShark.y, SellShark.z+1.5, "[E] Sell Shark")
			if IsControlJustPressed(0, Keys['E']) then
				if not selling then
					if exports["nadrp-inventory"]:hasEnoughOfItem("shark",1,false) then
						selling = true
						exports['t0sic_loadingbar']:StartDelayedFunction('Trading Shark', (math.random(40, 60) * 1000), function()
							selling = false
							if #(GetEntityCoords(PlayerPedId()) - vector3(SellShark.x, SellShark.y, SellShark.z)) < 5.0 then
								if exports["nadrp-inventory"]:hasEnoughOfItem("shark",itemCount,false) then
									TriggerEvent('inventory:removeItem',"shark", itemCount)
									TriggerServerEvent('Ford:TradeShark', itemCount)
									Wait(2000)
									TriggerServerEvent("sendingItemstoClient", cid, PlayerId())
								else
									local data = {
										name = GetPlayerName(PlayerId()),
										title ='Player attempted to exploit shark selling',
										reason = 'Player Spammed shark Selling',
										info = 'Player attempted to drop shark while selling'
									}
									TriggerServerEvent('nadrp-log:SendDiscordLog', data)
								end
							else
								exports['mythic_notify']:DoLongHudText('error', 'You moved too far!')
							end
							if DumbFuckCount > 15 then
								local data = {
									name = GetPlayerName(PlayerId()),
									title ='Player attempted to exploit Shark selling',
									reason = 'Player Spammed Shark Selling',
									info = 'Amount of times spammed: '..DumbFuckCount
								}
								TriggerServerEvent('nadrp-log:SendDiscordLog', data)
							end
							DumbFuckCount = 0
						end)
					else
						exports['mythic_notify']:DoLongHudText('error', 'You have nothing to sell!')
					end
				else
					DumbFuckCount = DumbFuckCount + 1
				end
			end
		else
			Citizen.Wait(1000)
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
			DrawText3D2(CX, CY, CZ, "~g~[E]~w~ To portion the fish")
		end

		if dist <= 0.5 then
			if IsControlJustPressed(0, Keys['E']) then
				if exports["nadrp-inventory"]:hasEnoughOfItem("fish",10,false) then
					PortionFish()
				else
					exports['mythic_notify']:DoLongHudText('error', 'You dont have enough fish.')
				end
			end
		end
		
		if dist2 <= 2.5 then
			sleep = 0
			DrawText3D2(CX2, CY2, CZ2, "~g~[E]~w~ To portion the chicken")
		end

		if dist2 <= 0.5 then
			if IsControlJustPressed(0, Keys['E']) then
				if exports["nadrp-inventory"]:hasEnoughOfItem("fish",10,false) then
					PortionFish()
				else
					exports['mythic_notify']:DoLongHudText('error', 'You dont have enough fish.')
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)




function StopPackingFish(position)
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
			exports['mythic_notify']:DoLongHudText('inform', 'You stored the chickens in the vehicle.')
			LoadDict('anim@heists@narcotics@trash')
			TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@narcotics@trash', "throw_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			Citizen.Wait(900)
			ClearPedTasks(GetPlayerPed(-1))
			DeleteEntity(prop)
		end
	end
end

function PortionFish()
	local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
	LoadDict(dict)
	FreezeEntityPosition(GetPlayerPed(-1),true)
	TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	local PedCoords = GetEntityCoords(GetPlayerPed(-1))
	knife = CreateObject(GetHashKey('prop_knife'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
	AttachEntityToEntity(knife, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0xDEAD), 0.13, 0.14, 0.09, 40.0, 0.0, 0.0, false, false, false, false, 2, true)
	local finished = exports["nadrp-taskbar"]:taskBar(10000,"Chopping fish into fillets",false,false,playerVeh)
	if position == 1 then
		SetEntityHeading(GetPlayerPed(-1), 311.0)
		chicken = CreateObject(GetHashKey('prop_int_cf_chick_01'),-94.87, 6207.008, 30.08, true, true, true)
		SetEntityRotation(chicken,90.0, 0.0, 45.0, 1,true)
	end
	exports['mythic_notify']:DoLongHudText('inform', 'You cut up the fish into fillets!')
	FreezeEntityPosition(GetPlayerPed(-1),false)
	DeleteEntity(chicken)
	DeleteEntity(knife)
	ClearPedTasks(GetPlayerPed(-1))
	if (finished == 100) then
		TriggerEvent('inventory:removeItem',"fish", 10) 
		TriggerEvent("player:receiveItem","packagedfish",20)
	end
end

--[[Citizen.CreateThread(function()
	while true do
		Wait(1)
		
		DrawMarker(27, SellFish.x, SellFish.y, SellFish.z-0.97 , 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 2.0, 255, 255, 255, 200, 0, 0, 0, 0)
		DrawMarker(27, SellTurtle.x, SellTurtle.y, SellTurtle.z-0.97 , 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 2.0, 255, 255, 255, 200, 0, 0, 0, 0)
		DrawMarker(27, SellShark.x, SellShark.y, SellShark.z-0.97, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 2.0, 255, 255, 255, 200, 0, 0, 0, 0)
	end
end)]]




Citizen.CreateThread(function()
	while true do
		local wait = math.random(FishTime.a , FishTime.b)
		Wait(wait)
		if fishing then
			pause = true
			correct = math.random(6,9)
			TriggerEvent("InteractSound_CL:PlayOnOne", 'pinpull', 0.5)
			exports['mythic_notify']:DoLongHudText('inform', 'You feel a bite...', 10000)
			exports['mythic_notify']:DoLongHudText('inform', "Fish is taking the bait \n Press " .. correct .. " to catch it")
			input = 0
			pausetimer = 0
		end
	end
end)

RegisterNetEvent('fishing:message')
AddEventHandler('fishing:message', function(message)
	ESX.ShowNotification(message)
end)
RegisterNetEvent('fishing:break')
AddEventHandler('fishing:break', function()
	fishing = false
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('fishing:spawnPed')
AddEventHandler('fishing:spawnPed', function()
	RequestModel( GetHashKey( "A_C_SharkTiger" ) )
	while ( not HasModelLoaded( GetHashKey( "A_C_SharkTiger" ) ) ) do
		Citizen.Wait( 1 )
	end
	local pos = GetEntityCoords(GetPlayerPed(-1))
	
	local ped = CreatePed(29, 0x06C3F072, pos.x, pos.y, pos.z, 90.0, true, false)
	SetEntityHealth(ped, 0)
	Wait(30000)
	DeleteEntity(ped)
end)

RegisterNetEvent('fishing:setbait')
AddEventHandler('fishing:setbait', function(bool)
	bait = bool
end)

RegisterNetEvent('fishing:fishstart')
AddEventHandler('fishing:fishstart', function()
	playerPed = GetPlayerPed(-1)
	local pos = GetEntityCoords(GetPlayerPed(-1))
	print('started fishing' .. pos)
	if IsPedInAnyVehicle(playerPed) then
		exports['mythic_notify']:DoLongHudText('error', 'You can not fish from a vehicle', 7000)
		--ESX.ShowNotification("~y~You can not fish from a vehicle")
	else
		if GetWaterHeight(pos.x, pos.y, pos.z-2, pos.z-3.0)  then
			exports['mythic_notify']:DoLongHudText('success', 'Fishing started', 7000)
			exports['mythic_notify']:DoLongHudText('inform', 'Press [E] to cancel', 15000)
			--ESX.ShowNotification("~b~Fishing started")
			TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FISHING", 0, true)
			fishing = true
		else
			exports['mythic_notify']:DoLongHudText('error', 'You need to go further away from shore', 12000)
			--ESX.ShowNotification("~y~You need to go further away from the shore")
		end
	end
	
end, false)


Citizen.CreateThread(function()
    while true do
		if fishing == true then
			Citizen.Wait(0)
			DisablePlayerFiring(ped, true) -- Disable weapon firing
			DisableControlAction(0, 24, true) -- disable attack
			DisableControlAction(0, 25, true) -- disable aim
			DisableControlAction(1, 37, true) -- disable weapon select
			DisableControlAction(0, 47, true) -- disable weapon
			DisableControlAction(0, 58, true) -- disable weapon
			DisableControlAction(0, 140, true) -- disable melee
			DisableControlAction(0, 141, true) -- disable melee
			DisableControlAction(0, 142, true) -- disable melee
			DisableControlAction(0, 143, true) -- disable melee
			DisableControlAction(0, 263, true) -- disable melee
			DisableControlAction(0, 264, true) -- disable melee
			DisableControlAction(0, 257, true) -- disable melee
			DisableControlAction(0, 63, true) -- veh turn left
			DisableControlAction(0, 245, true) -- veh turn right
			DisableControlAction(0, 71, true) -- veh forward
			DisableControlAction(0, 72, true) -- veh backwards
			DisableControlAction(0, 75, true) -- disable exit vehicle
			DisableControlAction(0, 30, true) -- disable left/right
			DisableControlAction(0, 31, true) -- disable forward/back
			DisableControlAction(0, 36, true) -- INPUT_DUCK
			DisableControlAction(0, 56, true) -- F9
			DisableControlAction(0, 21, true) -- disable sprint
		else
			Citizen.Wait(1000)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        for k in pairs(MarkerZones) do
        	local ped = PlayerPedId()
            local pedcoords = GetEntityCoords(ped, false)
            local distance = Vdist(pedcoords.x, pedcoords.y, pedcoords.z, MarkerZones[k].x, MarkerZones[k].y, MarkerZones[k].z)
			if distance <= 1.40 then
				Citizen.Wait(0)
				DisplayHelpText('Press E to rent a boat')
				if IsControlJustPressed(0, Keys['E']) and IsPedOnFoot(ped) then
					OpenBoatsMenu(MarkerZones[k].xs, MarkerZones[k].ys, MarkerZones[k].zs)
				end
			elseif distance < 1.45 then
				ESX.UI.Menu.CloseAll()
			else
				Citizen.Wait(1000)
			end
        end
    end
end)

function OpenBoatsMenu(x, y , z)
	local ped = PlayerPedId()
	PlayerData = ESX.GetPlayerData()
	local elements = {}

	table.insert(elements, {label = '<span style="color:green;">Dinghy</span> <span style="color:red;">$250</span>', value = 'boat'})
	--If user has police job they will be able to get free Police Predator boat
	--if PlayerData.job.name == "police" then
		---table.insert(elements, {label = '<span style="color:green;">Police Predator</span>', value = 'police'})
	--end
	
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'client',
    {
		title    = 'Rent a boat',
		align    = 'bottom-right',
		elements = elements,
    },
	
	
	function(data, menu)
		if data.current.value == 'boat' then
			ESX.UI.Menu.CloseAll()
			local plate = GetVehicleNumberPlateText(veh)
			TriggerServerEvent("fishing:lowmoney", 250) 
			exports['mythic_notify']:DoLongHudText('inform', 'You rented a boat for $250', 12000)
			SetPedCoordsKeepVehicle(ped, x, y , z)
			RequestModel(`dinghy`)
			while not HasModelLoaded(`dinghy`) do 
				Citizen.Wait(0)
			end
			local veh = CreateVehicle(GetHashKey('dinghy'), x, y, z, heading, true, false)
			local plate = GetVehicleNumberPlateText(veh)
			SetVehicleOnGroundProperly(veh)
			SetPedIntoVehicle(PlayerPedId(), veh, -1)
			TriggerEvent("ARPF:spawn:recivekeys", veh, plate)
		end
end,
	function(data, menu)
		menu.close()
		end
	)
end
