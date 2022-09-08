ESX = nil
local PLT = plt_farmer
local PlayerData = {}
local balyaOnRomorkCoord = {{x =  0.6, y =  1.75 , z = 0.7,  used = false, offx =  3.9, offy =  1.75 , offz = -1.0, head = 90},	{x = -0.6, y =  1.75 , z = 0.7,  used = false, offx = -3.9, offy =  1.75 , offz = -1.0, head = 270},	{x =  0.6, y = -0.10 , z = 0.7,  used = false, offx =  3.9, offy = -0.10 , offz = -1.0, head = 90},	{x = -0.6, y = -0.10 , z = 0.7,  used = false, offx = -3.9, offy = -0.10 , offz = -1.0, head = 270},	{x =  0.6, y =  0.8  , z = 2.25, used = false, offx =  3.9, offy = 0.8  ,  offz = -1.0, head = 90},	{x = -0.6, y =  0.8  , z = 2.25, used = false, offx = -3.9, offy = 0.8  ,  offz = -1.0, head = 270},	{x =  0.6, y = -1.95 , z = 0.7,  used = false, offx =  3.9, offy = -1.95 , offz = -1.0, head = 90},	{x = -0.6, y = -1.95 , z = 0.7,  used = false, offx = -3.9, offy = -1.95 , offz = -1.0, head = 270},	{x =  0.6, y = -1.05, z = 2.25,  used = false, offx =  3.9, offy = -1.05,  offz = -1.0, head = 90},	{x = -0.6, y = -1.05, z = 2.25,  used = false, offx = -3.9, offy = -1.05,  offz = -1.0, head = 270},	{x =  0.6, y = -3.80 , z = 0.7,  used = false, offx =  3.9, offy = -3.80 , offz = -1.0, head = 90},	{x = -0.6, y = -3.80 , z = 0.7,  used = false, offx = -3.9, offy = -3.80 , offz = -1.0, head = 270},	{x =  0.6, y = -2.9 , z = 2.25,  used = false, offx =  3.9, offy = -2.9 ,  offz = -1.0, head = 90},	{x = -0.6, y = -2.9 , z = 2.25,  used = false, offx = -3.9, offy = -2.9 ,  offz = -1.0, head = 270},} 
local balyaOnDorseCoord = {{x =-0.6,y = 1.20, z = 1.33, used = false, offx = -3.0, offy = 1.20 , offz = -2.0},	{x = 0.6,y = 1.20, z = 1.33, used = false, offx =  3.0, offy = 1.20 , offz = -2.0},	{x =-0.6,y =-0.70, z = 1.33, used = false, offx = -3.0, offy =-0.70 , offz = -2.0},	{x = 0.6,y =-0.70, z = 1.33, used = false, offx =  3.0, offy =-0.70 , offz = -2.0},	{x =-0.6,y = 0.25, z = 2.88, used = false, offx = -3.0, offy = 0.25 , offz = -2.0},	{x = 0.6,y = 0.25, z = 2.88, used = false, offx =  3.0, offy = 0.25 , offz = -2.0},	{x =-0.6,y =-2.60, z = 1.33, used = false, offx = -3.0, offy =-2.60 , offz = -2.0},	{x = 0.6,y =-2.60, z = 1.33, used = false, offx =  3.0, offy =-2.60 , offz = -2.0},	{x =-0.6,y =-1.65, z = 2.88, used = false, offx = -3.0, offy =-1.65 , offz = -2.0},	{x = 0.6,y =-1.65, z = 2.88, used = false, offx =  3.0, offy =-1.65 , offz = -2.0},	{x =-0.6,y =-4.50, z = 1.33, used = false, offx = -3.0, offy =-4.50 , offz = -2.0},	{x = 0.6,y =-4.50, z = 1.33, used = false, offx =  3.0, offy =-4.50 , offz = -2.0},	{x =-0.6,y =-3.55, z = 2.88, used = false, offx = -3.0, offy =-3.55 , offz = -2.0},	{x = 0.6,y =-3.55, z = 2.88, used = false, offx =  3.0, offy =-3.55 , offz = -2.0},} 
local balyaAttaching = {{x = 1.00,  y = 1.00,   z = 11},	{x = 2.00,  y = 2.00,   z = 22},	{x = 3.00,  y = 3.00,   z = 33},	{x = 4.00,  y = 4.00,   z = 43},	{x = 6.00,  y = 6.00,   z = 53},	{x = 8.00,  y = 8.00,   z = 62},	{x = 10.0,  y = 10.0,   z = 71},	{x = 12.0,  y = 12.0,   z = 70},	{x = 15.0,  y = 15.0,   z = 78},	{x = 18.0,  y = 18.0,   z = 86},	{x = 21.0,  y = 21.0,   z = 94},	{x = 25.0,  y = 25.0,   z = 101},	{x = 29.0,  y = 29.0,   z = 108},	{x = 33.0,  y = 33.0,   z = 114},	{x = 38.0,  y = 38.0,   z = 120},	{x = 43.0,  y = 43.0,   z = 125},	{x = 49.0,  y = 49.0,   z = 130},	{x = 56.0,  y = 56.0,   z = 134},	{x = 63.0,  y = 63.0,   z = 134},	{x = 70.0,  y = 70.0,   z = 130},	{x = 77.0,  y = 77.0,   z = 125},	{x = 80.0,  y = 80.0,   z = 120},	{x = 84.0,  y = 84.0,   z = 115},	{x = 87.0,  y = 87.0,   z = 110},	{x = 91.0,  y = 91.0,   z = 105},	{x = 94.0,  y = 94.0,   z = 100},	{x = 98.0,  y = 98.0,   z = 100},}
local canIHarvester = false
local myArea = false
local balyaOrani = nil
local bicerDover = false
local traktor = false
local romork = false
local tir = false
local dorse = false
local waitSV1 = false
local waitSV2 = false
local bekleamk = false
local fixWait = false
local sayi = 0
local balya = 0
local workStage = 0
local arpaTable = {}
local balyaTable = {}
local balyaonRomork = {}
local balyablip = {}
local arpaBlip = {}
local blipID  = false
local DeliveryBlip = false
local npcID = false
local iptalEdiyorum = false
local inAnyVeh = false
local index1 = math.random(0, 160)
local index2 = math.random(0, 160)
local pedID = PlayerPedId()
local playerPed = GetPlayerPed(-1)
local playerToDelVeh = 1000
local playerCoord = GetEntityCoords(playerPed)
local playerToAction = GetDistanceBetweenCoords(playerCoord,PLT.ActionCoord,false)
local playerTo2Action = GetDistanceBetweenCoords(playerCoord,PLT.CloakRoomCoord,false)


TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
Citizen.CreateThread(function()
	while ESX == nil do TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end) Citizen.Wait(0) end
	while ESX.GetPlayerData().job == nil do Citizen.Wait(10) end
	PlayerData = ESX.GetPlayerData()
	refrehPedBlip()
end)

Citizen.CreateThread(function()
	Citizen.CreateThread(function()
		while true do 
			pedID = PlayerPedId()
			playerPed = GetPlayerPed(-1)
			playerCoord = GetEntityCoords(playerPed)
			inAnyVeh = IsPedInAnyVehicle(pedID, false)
			Citizen.Wait(1000)
		end
	end)
	Citizen.CreateThread(function()
		while true do Citizen.Wait(0)
			if canIHarvester and not iptalEdiyorum then
				if workStage == 0 then Citizen.Wait(250)
					playerCoord = GetEntityCoords(playerPed)
					playerToAction = GetDistanceBetweenCoords(playerCoord,PLT.ActionCoord,false)
					if PLT.EnableJobClothe then
						playerTo2Action = GetDistanceBetweenCoords(playerCoord,PLT.CloakRoomCoord,false)
					end
				elseif  workStage == 1 then 
					playerCoord = GetEntityCoords(playerPed)
					if bicerDover == false then 
						if traktor and romork then
							traktorFx = GetOffsetFromEntityInWorldCoords(traktor, 0.0, -2.5, -0.5)
							romork1Fx = GetOffsetFromEntityInWorldCoords(romork, 0.0, 4.5, -1.3)
							tractorToRomork =GetDistanceBetweenCoords(traktorFx,romork1Fx,false)
							 if not IsPedInVehicle(pedID,traktor,false) then
								bekleamk = true
								bildir(PLT.U["getin_tractor"])  
								traktorCoord = GetEntityCoords(traktor)
								DrawMarker(20, traktorCoord.x ,traktorCoord.y,traktorCoord.z + 3, 0, 0.50, 0, 0, 0, 0, 2.5,2.5,2.5, 255, 255, 255, 255, true, 0.10, 0, 1, 0, 0.0, 0)
							elseif tractorToRomork > 1.2 then 
								bekleamk = true
								bildir(PLT.U["tractor_to_romork"])
								DrawMarker(20, traktorFx.x ,traktorFx.y,traktorFx.z,    0, 0.50, 0, 0, 0, 0,     0.5,0.5,0.5, 255, 0, 0, 255, true, 0.10, 0, 1, 0, 0.0, 0)  
								DrawMarker(20, romork1Fx.x , romork1Fx.y,  romork1Fx.z, 0, 0.50, 0, 180.0, 0, 0, 0.5,0.5,0.5, 255, 0, 0, 255, true, 0.10, 0, 1, 0, 0.0, 0)  
							else
								bekleamk = true
								bildir(PLT.U["trctor_go_newpoint"])  
								SetNewWaypoint(PLT.Area[myArea][1].x,PLT.Area[myArea][1].y) 
							end 
						end
					else
						bicerDoverCoord = GetEntityCoords(bicerDover)
						if IsPedInVehicle(pedID,traktor,false) then
							bekleamk = true
							bildir(PLT.U["traktor_park"])
						elseif not IsPedInVehicle(pedID,bicerDover,false) then
							bekleamk = true
							bildir(PLT.U["getin_harvester"])
							DrawMarker(20, bicerDoverCoord.x ,bicerDoverCoord.y,bicerDoverCoord.z + 5, 0, 0.50, 0, 0, 0, 0, 2.5,2.5,2.5, 255, 255, 255, 255, 0.0, 0.10, 0, 1, 0, 0.0, 0)  
						else 
							bekleamk = false
							Citizen.Wait(1000)
						end
					end
				elseif  workStage == 2 then 
					if traktor and romork then
						playerCoord = GetEntityCoords(playerPed)
						traktorFx = GetOffsetFromEntityInWorldCoords(traktor, 0.0, -2.5, -0.5)
						romork1Fx = GetOffsetFromEntityInWorldCoords(romork, 0.0, 4.5, -1.3)
						tractorToRomork =GetDistanceBetweenCoords(traktorFx,romork1Fx,false)
						playerToArea = GetDistanceBetweenCoords(playerCoord,PLT.Area[myArea][1].x,PLT.Area[myArea][1].y,PLT.Area[myArea][1].z ,false)
					 	if not IsPedInVehicle(pedID,traktor,false) and not balyaTable[1] then
							bekleamk = true
							bildir(PLT.U["getin_tractor"])  
							traktorCoord = GetEntityCoords(traktor)
							DrawMarker(20, traktorCoord.x ,traktorCoord.y,traktorCoord.z + 3, 0, 0.50, 0, 0, 0, 0, 2.5,2.5,2.5, 255, 255, 255, 255, true, 0.10, 0, 1, 0, 0.0, 0)
						elseif tractorToRomork > 1.2 then 
							bekleamk = true
							bildir(PLT.U["tractor_to_romork"])
							DrawMarker(20, traktorFx.x ,traktorFx.y,traktorFx.z,    0, 0.50, 0, 0, 0, 0,     0.5,0.5,0.5, 255, 0, 0, 255, true, 0.10, 0, 1, 0, 0.0, 0)  
							DrawMarker(20, romork1Fx.x , romork1Fx.y,  romork1Fx.z, 0, 0.50, 0, 180.0, 0, 0, 0.5,0.5,0.5, 255, 0, 0, 255, true, 0.10, 0, 1, 0, 0.0, 0)  
						else
							bekleamk = false
							Citizen.Wait(1000)
						end 
					end
				elseif  workStage == 3 then 
					if traktor ~= false  and (IsPedInVehicle(pedID,traktor,false)) and dorse ~= false then
						bildir(PLT.U["traktortodorce"])
						bekleamk = true
						romork3Fx1 = GetOffsetFromEntityInWorldCoords(romork, 0.0, -3.3, -1.7)
						romork3Fx2 = GetOffsetFromEntityInWorldCoords(romork, 0.0, -0.3, -1.6)
						romork3Fx3 = GetOffsetFromEntityInWorldCoords(romork, 0.0, 2.7, -1.5)
						dorse3Fx1 = GetOffsetFromEntityInWorldCoords(dorse, 0.0,  -7.5, -1.0)
						dorse3Fx2 = GetOffsetFromEntityInWorldCoords(dorse, 0.0, -10.5, -0.9)
						dorse3Fx3 = GetOffsetFromEntityInWorldCoords(dorse, 0.0, -13.5, -0.8)
						local g =  math.floor( 255 - (GetDistanceBetweenCoords(dorse3Fx1,romork3Fx1,false) * 20) )
						local r = 255- g
						local b = 0

						DrawMarker(6,romork3Fx1.x,romork3Fx1.y,romork3Fx1.z,0.0, 0.0, 0.0, -90,-90,-90, 5.0,5.0,5.0,255,0.0,0.0,100,false, true, 2, false, false, false, false) 
						DrawMarker(6,romork3Fx1.x,romork3Fx1.y,romork3Fx1.z,0.0, 0.0, 0.0, -90, -90, -90, 5.0, 5.0, 5.0, r, g, b,255,    false, false, 2, false, false, false, false) 
						DrawMarker(6,romork3Fx2.x,romork3Fx2.y,romork3Fx2.z,0.0, 0.0, 0.0, -90, -90, -90, 4.0, 4.0, 4.0, r, g, b,255,false, false, 2, false, false, false, false) 
						DrawMarker(6,romork3Fx3.x,romork3Fx3.y,romork3Fx3.z,0.0, 0.0, 0.0, -90, -90, -90, 3.0, 3.0, 3.0, r, g, b,255,false, false, 2, false, false, false, false) 
						DrawMarker(6,dorse3Fx1.x,dorse3Fx1.y,dorse3Fx1.z,   0.0, 0.0, 0.0, -90, -90, -90, 5.0, 5.0, 5.0, r, g, b,255,    false, false, 2, false, false, false, false) 
						DrawMarker(6,dorse3Fx2.x,dorse3Fx2.y,dorse3Fx2.z,   0.0, 0.0, 0.0, -90, -90, -90, 4.0, 4.0, 4.0, r, g, b,255,false, false, 2, false, false, false, false) 
						DrawMarker(6,dorse3Fx3.x,dorse3Fx3.y,dorse3Fx3.z,   0.0, 0.0, 0.0, -90, -90, -90, 3.0, 3.0, 3.0, r, g, b,255,false, false, 2, false, false, false, false) 
					else
						bekleamk = false
						Citizen.Wait(1000)
					end
				elseif  workStage == 4 then 
					playerCoord = GetEntityCoords(playerPed)
					tirFx = GetOffsetFromEntityInWorldCoords(tir, 0.0, -3.3, 0.5)
					dorse1Fx = GetOffsetFromEntityInWorldCoords(dorse, 0.0, 4.75, -0.4)
					tirToDorse = GetDistanceBetweenCoords(tirFx,dorse1Fx,false)
					if not IsPedInVehicle(pedID,tir,false) then
						if GetDistanceBetweenCoords(playerCoord,PLT.DeliveryCoords,false) > 75.0 then 
							bekleamk = true
							bildir(PLT.U["getin_truck"])  
							tirCoord = GetEntityCoords(tir)
							DrawMarker(20, tirCoord.x ,tirCoord.y,tirCoord.z + 4.5, 0, 0.50, 0, 0, 0, 0, 2.5,2.5,2.5, 255, 255, 255, 255, true, 0.10, 0, 1, 0, 0.0, 0)
						end
					elseif tirToDorse > 1.2 then 
						bekleamk = true
						bildir(PLT.U["dorcetotruck"])
						DrawMarker(20, tirFx.x ,tirFx.y,tirFx.z,    0, 0.50, 0, 0, 0, 0,     0.5,0.5,0.5, 255, 0, 0, 255, true, 0.10, 0, 1, 0, 0.0, 0)  
						DrawMarker(20, dorse1Fx.x , dorse1Fx.y,  dorse1Fx.z, 0, 0.50, 0, 180.0, 0, 0, 0.5,0.5,0.5, 255, 0, 0, 255, true, 0.10, 0, 1, 0, 0.0, 0)  
					else
						bekleamk = false
						Citizen.Wait(1000)
					end 
				elseif  workStage == 5 then 
					playerCoord = GetEntityCoords(playerPed)
					tirFx = GetOffsetFromEntityInWorldCoords(tir, 0.0, -3.3, 0.5)
					dorse1Fx = GetOffsetFromEntityInWorldCoords(dorse, 0.0, 4.75, -0.4)
					tirToDorse = GetDistanceBetweenCoords(tirFx,dorse1Fx,false)
					if not IsPedInVehicle(pedID,tir,false) then
						bekleamk = true
						bildir(PLT.U["getin_truck"])  
						tirCoord = GetEntityCoords(tir)
						DrawMarker(20, tirCoord.x ,tirCoord.y,tirCoord.z + 4.5, 0, 0.50, 0, 0, 0, 0, 2.5,2.5,2.5, 255, 255, 255, 255, true, 0.10, 0, 1, 0, 0.0, 0)
					elseif tirToDorse > 1.2 then 
						bekleamk = true
						bildir(PLT.U["dorcetotruck"])
						DrawMarker(20, tirFx.x ,tirFx.y,tirFx.z,    0, 0.50, 0, 0, 0, 0,     0.5,0.5,0.5, 255, 0, 0, 255, true, 0.10, 0, 1, 0, 0.0, 0)  
						DrawMarker(20, dorse1Fx.x , dorse1Fx.y,  dorse1Fx.z, 0, 0.50, 0, 180.0, 0, 0, 0.5,0.5,0.5, 255, 0, 0, 255, true, 0.10, 0, 1, 0, 0.0, 0)  
					else
						bekleamk = false
						Citizen.Wait(1000)
					end 
				end
			else
				Citizen.Wait(1000)
			end
		end
	end)
	while true do Citizen.Wait(1000)
		if canIHarvester then
			while workStage == 0 and not bekleamk and not iptalEdiyorum do Citizen.Wait(0)
				if playerToAction < 1 then 
					bildir(PLT.U["for_action"])
					DrawMarker(27, PLT.ActionCoord.x,PLT.ActionCoord.y,PLT.ActionCoord.z - 0.95, 0, 0.50, 0, 0, 0, 0, 1.5,1.5,1.5, 255, 0, 0, 255, 0.0, 0.10, 0, 0.0, 0, 0.0, 0)  
					DrawText3Ds(PLT.ActionCoord.x,PLT.ActionCoord.y,PLT.ActionCoord.z, 0.35, 0.35,  "~b~(~y~-~g~E~y~-~b~) ~b~[~y~- ~y~ "..PLT.U["start_job"].." ~y~-~b~]")
					DrawText3Ds(PLT.PedCoord.x,PLT.PedCoord.y,PLT.PedCoord.z + 1 , 0.35, 0.35,  "~b~[~y~- ~g~ "..PLT.U["ped_text"].." ~y~-~b~]")
					if PLT.EnableJobClothe then
						DrawMarker(27, PLT.CloakRoomCoord.x,PLT.CloakRoomCoord.y,PLT.CloakRoomCoord.z - 0.95, 0, 0.50, 0, 0, 0, 0, 1.5,1.5,1.5, 255, 0, 0, 255, 0.0, 0.10, 0, 0.0, 0, 0.0, 0)  
						DrawText3Ds(PLT.CloakRoomCoord.x,PLT.CloakRoomCoord.y,PLT.CloakRoomCoord.z, 0.35, 0.35,  "~w~[~o~- ~b~ "..PLT.U["clothe_action"].." ~o~-~w~]")
					end
					if IsControlPressed(0,46) then
						waitSV1 = true
						ESX.TriggerServerCallback('plt_farmer:CheckAvailableArea', function(cb) 
							local canIdo = OpenMenu(cb) 
							if canIdo == false then
								exports['mythic_notify']:DoCustomHudText('error', PLT.U["canceled"] ,5000)
							else
								waitSV2 = true
								ESX.TriggerServerCallback('plt_farmer:CanISelecetThis', function(cb) 
									if cb == true then 
										if spawnTraktor(canIdo) then 
											workStage = 1
											sayi = 0
											balya = 0
											myArea = canIdo
											spawnHarvesterProp()
										else
											TriggerServerEvent("plt_farmer:CancelWork")
											workStage = 0
											myArea = false
											exports['mythic_notify']:DoCustomHudText('error', PLT.U["cleararea"],10000)
										end
									end
									waitSV2 = false
								end,canIdo)
								while waitSV2 do Citizen.Wait(100) end
							end
							waitSV1 = false
						end)	
						while waitSV1 do Citizen.Wait(100) end
						break
					end
				elseif PLT.EnableJobClothe and playerTo2Action < 1 then 
					DrawMarker(27, PLT.ActionCoord.x,PLT.ActionCoord.y,PLT.ActionCoord.z - 0.95, 0, 0.50, 0, 0, 0, 0, 1.5,1.5,1.5, 255, 0, 0, 255, 0.0, 0.10, 0, 0.0, 0, 0.0, 0)  
					DrawText3Ds(PLT.ActionCoord.x,PLT.ActionCoord.y,PLT.ActionCoord.z, 0.35, 0.35,  "~w~[~o~- ~b~ "..PLT.U["job_action"].." ~o~-~w~]")
					if PLT.EnableJobClothe then
						bildir(PLT.U["for_action"])
						DrawMarker(27, PLT.CloakRoomCoord.x,PLT.CloakRoomCoord.y,PLT.CloakRoomCoord.z - 0.95, 0, 0.50, 0, 0, 0, 0, 1.5,1.5,1.5, 255, 0, 0, 255, 0.0, 0.10, 0, 0.0, 0, 0.0, 0)  
						DrawText3Ds(PLT.CloakRoomCoord.x,PLT.CloakRoomCoord.y,PLT.CloakRoomCoord.z, 0.35, 0.35,  "~b~(~y~-~g~E~y~-~b~) ~b~[~y~- ~y~ "..PLT.U["change_clothe"].." ~y~-~b~]")
						if IsControlPressed(0,46) then
							OpenCloakroomMenu()
						end
					end
				elseif playerToAction > 100 then  
					Citizen.Wait(2500) 
				elseif playerToAction > 20 then  
					Citizen.Wait(1000) 
					break
				elseif playerToAction > 1 then
					DrawMarker(27, PLT.ActionCoord.x,PLT.ActionCoord.y,PLT.ActionCoord.z - 0.95, 0, 0.50, 0, 0, 0, 0, 1.5,1.5,1.5, 255, 0, 0, 255, 0.0, 0.10, 0, 0.0, 0, 0.0, 0)  
					DrawText3Ds(PLT.ActionCoord.x,PLT.ActionCoord.y,PLT.ActionCoord.z, 0.35, 0.35,  "~w~[~o~- ~b~ "..PLT.U["job_action"].." ~o~-~w~]")
					if PLT.EnableJobClothe then
						DrawMarker(27, PLT.CloakRoomCoord.x,PLT.CloakRoomCoord.y,PLT.CloakRoomCoord.z - 0.95, 0, 0.50, 0, 0, 0, 0, 1.5,1.5,1.5, 255, 0, 0, 255, 0.0, 0.10, 0, 0.0, 0, 0.0, 0)  
						DrawText3Ds(PLT.CloakRoomCoord.x,PLT.CloakRoomCoord.y,PLT.CloakRoomCoord.z, 0.35, 0.35,  "~w~[~o~- ~b~ "..PLT.U["clothe_action"].." ~o~-~w~]")
					end
				end 
			end
			while workStage == 1 and not bekleamk and not iptalEdiyorum do Citizen.Wait(0)
				if arpaTable[1] ~= nil then 
					bildir(PLT.U["hartoaction"],nil,false)
					playerCoord = GetEntityCoords(playerPed)
					arpa1Coord = GetEntityCoords(arpaTable[1])
					arpa2Coord = GetEntityCoords(arpaTable[3])
					arpa3Coord = GetEntityCoords(arpaTable[5])
					bicerDover1Fx = GetOffsetFromEntityInWorldCoords(bicerDover, 0.0, 2.0, -0.8)
					DrawMarker(1, arpa1Coord.x , arpa1Coord.y,  arpa1Coord.z - 1, 0, 0.50, 0, 0.0, 0, 0, 4.5,4.5,1.50, 0, 100, 0, 255, 0.0, 0.10, 0, 1, 0, 0.0, 0)
					DrawMarker(1, arpa2Coord.x , arpa2Coord.y,  arpa2Coord.z - 1, 0, 0.50, 0, 0.0, 0, 0, 2.5,2.5,1.40, 0, 100, 0, 150, 0.0, 0.10, 0, 1, 0, 0.0, 0)
					DrawMarker(1, arpa3Coord.x , arpa3Coord.y,  arpa3Coord.z - 1, 0, 0.50, 0, 0.0, 0, 0, 1.5,2.5,1.35, 0, 100, 0, 100, 0.0, 0.10, 0, 1, 0, 0.0, 0)
					local uzaklik = GetDistanceBetweenCoords(bicerDover1Fx,arpa1Coord,false)
					if uzaklik < 1.45 then 
						Citizen.Wait(100)
						DeleteEntity(arpaTable[1])
						table.remove(arpaTable,1)
						sayi = sayi + 1
						if balyaOrani and sayi >= balyaOrani and balya < #balyaOnRomorkCoord then 
							balya = balya + 1 
							sayi = sayi - balyaOrani
							Citizen.CreateThread(function()
								local balyaVikCoord = arpa1Coord
								if arpaTable[5] then 
									local sonrakiBalya = arpaTable[5]
									while DoesEntityExist(sonrakiBalya) do Citizen.Wait(100) end
								end
								while GetDistanceBetweenCoords(playerCoord,balyaVikCoord,false) < 10.0  and not iptalEdiyorum  do Citizen.Wait(100) end
								if not iptalEdiyorum then 
									local retval =	CreateObject(GetHashKey("prop_haybale_03"), balyaVikCoord.x,balyaVikCoord.y,balyaVikCoord.z-1.0, true , false, false)
									TriggerServerEvent("plt_farmer:AddEntity", NetworkGetNetworkIdFromEntity(retval),myArea)
									FreezeEntityPosition(retval,true)
									table.insert(balyaTable,{objeId = retval, coord = GetEntityCoords(retval) })
									createBlipforBale(retval)
								end
							end)
						end
					elseif uzaklik > 25 then 
						DrawMarker(20, arpa1Coord.x ,arpa1Coord.y,arpa1Coord.z + 4, 0, 0.50, 0, 0, 0, 0, 2.5,2.5,2.5, 100, 0, 0, 255,true, 0.10, 0, 1, 0, 0.0, 0)  
					end
				elseif balya > 9 then 
					DoScreenFadeOut(1000)
					Citizen.Wait(1000)
					ESX.Game.DeleteVehicle(bicerDover)
					bicerDover = false
					Citizen.Wait(250)
					DoScreenFadeIn(1000)
					balya1Coord = balyaTable[1].coord
					workStage = 2
				else
					bildir(PLT.U["gonewaypoint"])
					SetNewWaypoint(PLT.Area[myArea][1].x,PLT.Area[myArea][1].y)
				end
			end  
			while workStage == 2 and not bekleamk and not iptalEdiyorum do Citizen.Wait(0) 
				if balyaTable[1] then 
					bildir(PLT.U["takebale"],nil,false)
					for Pkt,Pvt in pairs(balyaTable) do
						playerCoord = GetEntityCoords(playerPed)
						balya1Coord = Pvt.coord
						playerToBalya = GetDistanceBetweenCoords(balya1Coord,playerCoord,false)
						DrawMarker(20, balya1Coord.x ,balya1Coord.y,balya1Coord.z + 2, 0, 0.50, 0, 0, 0, 0, 1.5,1.5,1.5, 0, 0, 250, 255, true, 0.10, 0, 1, 0, 0.0, 0)
						if playerToBalya < 1.75 then
							for k,v in pairs(balyaOnRomorkCoord) do 
								if v.used == false then 
									SetEntityNoCollisionEntity(Pvt.objeId, v.used, true)
									SetEntityNoCollisionEntity(Pvt.objeId, v.used, true)
									SetEntityNoCollisionEntity(Pvt.objeId, v.used, true)
									SetEntityNoCollisionEntity(Pvt.objeId, v.used, true)
									SetEntityHeading(pedID, GetHeadingFromVector_2d(balya1Coord.x-playerCoord.x,balya1Coord.y-playerCoord.y))
									RequestAnimSet( "move_ped_crouched" )	while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do Citizen.Wait( 100 )end 
									SetPedMovementClipset( playerPed, "move_ped_crouched", 0.45 )
									Citizen.Wait(500)	
									local boneIndex = GetPedBoneIndex(playerPed, 57005)
									ResetPedMovementClipset( playerPed, 0.45 )
									Citizen.Wait(222)	
									AttachEntityToEntity(Pvt.objeId, playerPed, boneIndex, 0.75, 0.75, 0.0, 0.0, 0.0, 100.0, true, true, false, true, 1, true)
									loadAnimDict('anim@heists@box_carry@')Citizen.Wait(50)
									TaskPlayAnim(pedID, "anim@heists@box_carry@", "walk", 1.0, 1.0, -1, 1 | 16 | 32, 0.0, 0, 0, 0)
									RequestAnimSet( "move_ped_crouched" )	while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do Citizen.Wait( 100 )end 
									romork2Fx = GetOffsetFromEntityInWorldCoords(romork, v.offx, v.offy, v.offz)
									local goanim = true
									Citizen.CreateThread(function()
										while goanim do 
											if not IsEntityPlayingAnim(playerPed, "anim@heists@box_carry@", "walk", 3) then 
												loadAnimDict('anim@heists@box_carry@')
												TaskPlayAnim(pedID, "anim@heists@box_carry@", "walk", 1.0, 1.0, -1, 1 | 16 | 32, 0.0, 0, 0, 0)
											end
											Citizen.Wait(10)
										end
									end)
									while GetDistanceBetweenCoords(playerCoord, romork2Fx, false) > 3.5 and not iptalEdiyorum do Citizen.Wait(0) 
										bildir(PLT.U["outbale"],nil,false)
										DrawMarker(20, romork2Fx.x ,romork2Fx.y,romork2Fx.z, 0, 0.50, 0, 0, 0, 0, 1.5,1.5,1.5, 255, 0, 0, 255, true, 0.10, 0, 1, 0, 0.0, 0)
										playerCoord = GetEntityCoords(playerPed) 
										romork2Fx = GetOffsetFromEntityInWorldCoords(romork, v.offx, v.offy, v.offz)
									end
									local new  = GetOffsetFromEntityInWorldCoords(romork, v.x, v.y, v.z)
									local heading = GetEntityHeading(romork) + v.head
									TaskGoStraightToCoord(playerPed, romork2Fx.x ,romork2Fx.y,romork2Fx.z, 2.0, 3000, heading, 0.5)
									while GetDistanceBetweenCoords(playerCoord, romork2Fx, false) > 1.0 do Citizen.Wait(0) playerCoord = GetEntityCoords(playerPed) romork2Fx = GetOffsetFromEntityInWorldCoords(romork, v.offx, v.offy, v.offz) end
									SetEntityHeading(pedID, heading)
									goanim = false
									TaskJump(GetPlayerPed(-1), false, true, false)
									RequestAnimDict('amb@prop_human_movie_bulb@exit')
									while not HasAnimDictLoaded("amb@prop_human_movie_bulb@exit") do RequestAnimDict("amb@prop_human_movie_bulb@exit");Citizen.Wait(0); end
									TaskPlayAnim(pedID, 'amb@prop_human_movie_bulb@exit', 'exit', 8.0, 8.0, -1, 48, 1, false, false, false)
									Citizen.Wait(100)
									DetachEntity(Pvt.objeId)
									local ex = GetEntityCoords(Pvt.objeId)
									local pltX =  new.x - ex.x
									local pltY =  new.y - ex.y
									local pltZ =  new.z - ex.z
									if pltZ < 0.7 then pltZ = 0.7 end
									local heyding = GetEntityHeading(Pvt.objeId)
									local headingekle = (GetEntityHeading(romork) - heyding) / #balyaAttaching
									for k2,v2 in pairs(balyaAttaching) do Citizen.Wait(20)
										SetEntityCoords(Pvt.objeId, ex.x + ((pltX / 100) * v2.x), ex.y + ((pltY / 100) * v2.y), ex.z + ((pltZ / 100) * v2.z), false, false, false, false)
										SetEntityHeading(Pvt.objeId, heyding + (headingekle * k2))
									end	
									AttachEntityToEntity(Pvt.objeId, romork, 0, v.x, v.y, v.z, 0.0, 0.0, 0.0, false, false, true, false, 0, true)
									v.used = Pvt.objeId
									table.remove(balyaTable,Pkt)
									ClearPedTasks(playerPed)
									ClearPedTasksImmediately(playerPed)
									Citizen.Wait(1000)
									break
								end
							end
						end	
					end
				else
					traktorCoord = GetEntityCoords(traktor)
					if GetDistanceBetweenCoords(traktorCoord,PLT.ActionCoord,false) < 75.0 then 
						spawnTir()
						workStage = 3
					else
						bildir(PLT.U["getbalewaypoint"])
						SetNewWaypoint(PLT.ActionCoord.x,PLT.ActionCoord.y)
					end
				end	
			end 
			while workStage == 3 and not bekleamk and not iptalEdiyorum do Citizen.Wait(0) 
				sBalyaOnRmrk = balyaOnRomorkCoord[#balyaOnRomorkCoord]
				if sBalyaOnRmrk then 
					bildir(PLT.U["getdorcetoromork"],nil,false)
					playerCoord = GetEntityCoords(playerPed)
					balyaSonCoord = GetEntityCoords(sBalyaOnRmrk.used)
					if sBalyaOnRmrk.z < 1 then 
						balyaSonCoord2 = GetOffsetFromEntityInWorldCoords(romork,sBalyaOnRmrk.x, sBalyaOnRmrk.y - 1, sBalyaOnRmrk.z)
					else
						balyaSonCoord2 = GetOffsetFromEntityInWorldCoords(romork,sBalyaOnRmrk.x, sBalyaOnRmrk.y - 2, 0.7)
					end
					playerToBalya = GetDistanceBetweenCoords(balyaSonCoord2,playerCoord,true)
					DrawMarker(20, balyaSonCoord2.x ,balyaSonCoord2.y,balyaSonCoord2.z , 0, 0.50, 0, 0, 0, 0, 1.5,1.5,1.5, 0, 0, 250, 255, true, 0.10, 0, 1, 0, 0.0, 0)
					if playerToBalya < 1.0 then
						for k,v in pairs(balyaOnDorseCoord) do 
							if v.used == false then Citizen.Wait(250)
								SetEntityNoCollisionEntity(tir, sBalyaOnRmrk.used, true)
								SetEntityNoCollisionEntity(dorse, sBalyaOnRmrk.used, true)
								SetEntityNoCollisionEntity(traktor, sBalyaOnRmrk.used, true)
								SetEntityNoCollisionEntity(romork, sBalyaOnRmrk.used, true)
								if sBalyaOnRmrk.z < 1 then
									SetEntityHeading(pedID, GetHeadingFromVector_2d(balyaSonCoord.x-playerCoord.x,balyaSonCoord.y-playerCoord.y))
									RequestAnimSet( "move_ped_crouched" )	while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do Citizen.Wait( 100 )end 
									SetPedMovementClipset( playerPed, "move_ped_crouched", 0.45 )
									Citizen.Wait(650)	
									ResetPedMovementClipset( playerPed, 0.45 )
									local boneIndex = GetPedBoneIndex(playerPed, 57005)
									AttachEntityToEntity(sBalyaOnRmrk.used, playerPed, boneIndex, 0.75, 0.75, 0.0, 0.0, 0.0, 100.0, false, false, false, true, 1, true)
									loadAnimDict('anim@heists@box_carry@')Citizen.Wait(50)
									TaskPlayAnim(pedID, "anim@heists@box_carry@", "walk", 1.0, 1.0, -1, 1 | 16 | 32, 0.0, 0, 0, 0)
								else
									local slmheading = GetHeadingFromVector_2d(balyaSonCoord.x-playerCoord.x,balyaSonCoord.y-playerCoord.y)
									SetEntityHeading(pedID, slmheading) Citizen.Wait(25)	
									RequestAnimDict("missminuteman_1ig_2") while not HasAnimDictLoaded("missminuteman_1ig_2") do Citizen.Wait(0) end
									TaskPlayAnim(pedID, "missminuteman_1ig_2", "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
									Citizen.Wait(444)
									local boneIndex = GetPedBoneIndex(playerPed, 57005)
									AttachEntityToEntity(sBalyaOnRmrk.used, playerPed, boneIndex, 0.9, 0.1, -0.75, 0.0, 91.0, 0.0, false, false, false, true, 1, true)
									TaskAchieveHeading(pedID, slmheading - 180, 1000)
									Citizen.Wait(1000)
									StopAnimTask(pedID, 'missminuteman_1ig_2', 'handsup_enter', 1.0)
									Citizen.Wait(400)	
									loadAnimDict('anim@heists@box_carry@')Citizen.Wait(50)
									TaskPlayAnim(pedID, "anim@heists@box_carry@", "walk", 1.0, 1.0, -1, 1 | 16 | 32, 0.0, 0, 0, 0)
									DetachEntity(sBalyaOnRmrk.used)	
									AttachEntityToEntity(sBalyaOnRmrk.used, playerPed, boneIndex, 0.75, 0.75, 0.0, 0.0, 0.0, 100.0, false, false, false, true, 1, true)
								end
								dorse2Fx = GetOffsetFromEntityInWorldCoords(dorse, v.x, v.y, v.z)
								if v.z < 2 then
									dorse2MarkFx = GetOffsetFromEntityInWorldCoords(dorse, v.x,v.y -1.3, v.z)
								else
									dorse2MarkFx = GetOffsetFromEntityInWorldCoords(dorse, v.x,v.y -3.0, 1.33)
								end
								local goanim = true
								Citizen.CreateThread(function()
									while goanim do 
										if not IsEntityPlayingAnim(playerPed, "anim@heists@box_carry@", "walk", 3) then 
											loadAnimDict('anim@heists@box_carry@')
											TaskPlayAnim(pedID, "anim@heists@box_carry@", "walk", 1.0, 1.0, -1, 1 | 16 | 32, 0.0, 0, 0, 0)
										end
										Citizen.Wait(0)
									end
									StopAnimTask(pedID, 'anim@heists@box_carry@', 'walk', 1.0)
								end)
								while GetDistanceBetweenCoords(playerCoord, dorse2MarkFx, true) > 1.5 do Citizen.Wait(0) 
									bildir(PLT.U["baletodorce"],nil,false)
									DrawMarker(20, dorse2MarkFx.x ,dorse2MarkFx.y  ,dorse2MarkFx.z, 0, 0.50, 0, 0, 0, 0, 1.5,1.5,1.5, 255, 0, 0, 255, true, 0.10, 0, 1, 0, 0.0, 0)
									playerCoord = GetEntityCoords(playerPed) 
								end
								TaskGoStraightToCoord(playerPed, dorse2MarkFx.x ,dorse2MarkFx.y ,dorse2MarkFx.z, 1.4, 1000, GetEntityHeading(dorse), 0.5)
								while GetDistanceBetweenCoords(playerCoord, dorse2MarkFx.x ,dorse2MarkFx.y,dorse2MarkFx.z, false) > 1.0 do Citizen.Wait(10) playerCoord = GetEntityCoords(playerPed) end
								Citizen.Wait(50)
								SetEntityHeading(pedID, GetEntityHeading(dorse))
								if v.z < 2 then
									RequestAnimSet( "move_ped_crouched" )	while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do Citizen.Wait( 0 )end 
									SetPedMovementClipset( playerPed, "move_ped_crouched", 0.45 )
									Citizen.Wait(800)	
									DetachEntity(sBalyaOnRmrk.used)	
									goanim = false
								else
									goanim = false
									RequestAnimDict('amb@prop_human_movie_bulb@exit')
									while not HasAnimDictLoaded("amb@prop_human_movie_bulb@exit") do RequestAnimDict("amb@prop_human_movie_bulb@exit");Citizen.Wait(0); end
									TaskPlayAnim(pedID, 'amb@prop_human_movie_bulb@exit', 'exit', 8.0, 8.0, -1, 48, 1, false, false, false)
									Citizen.Wait(100)
									DetachEntity(sBalyaOnRmrk.used)
									local new  = GetOffsetFromEntityInWorldCoords(dorse, v.x, v.y, v.z)
									local ex = GetEntityCoords(sBalyaOnRmrk.used)
									local pltX =  new.x - ex.x
									local pltY =  new.y - ex.y
									local pltZ =  new.z - ex.z
									if pltZ < 0.7 then pltZ = 0.7 end
									local heyding = GetEntityHeading(sBalyaOnRmrk.used)
									local headingekle = (GetEntityHeading(dorse) - heyding) / #balyaAttaching
									for k2,v2 in pairs(balyaAttaching) do Citizen.Wait(20)
										SetEntityCoords(sBalyaOnRmrk.used, ex.x + ((pltX / 100) * v2.x), ex.y + ((pltY / 100) * v2.y), ex.z + ((pltZ / 100) * v2.z), false, false, false, false)
										SetEntityHeading(sBalyaOnRmrk.used, heyding + (headingekle * k2))
									end	
								end
								v.used = sBalyaOnRmrk.used
								AttachEntityToEntity(sBalyaOnRmrk.used, dorse, 0, v.x, v.y , v.z , 0.0, 0.0, 0.0, false, false, true, false, 0, true)
								ResetPedMovementClipset( playerPed, 0.45 )
								table.remove(balyaOnRomorkCoord,#balyaOnRomorkCoord)
								Citizen.Wait(1000)								
								break
							end
						end
					end
				else
					workStage = 4
					TriggerServerEvent('plt_farmer:Tarlabitti')
					DoScreenFadeOut(1000)
					Citizen.Wait(1000)
					ESX.Game.DeleteVehicle(traktor)
					traktor = false
					ESX.Game.DeleteVehicle(romork)
					romork = false
					DoScreenFadeIn(1000)
					createBlipforDelivery()
					tirCoord = GetEntityCoords(traktor)
				 	while GetDistanceBetweenCoords(tirCoord,PLT.DeliveryPoints[1].x,PLT.DeliveryPoints[1].y,PLT.DeliveryPoints[1].z,false) > 75.0 and not iptalEdiyorum do Citizen.Wait(25)
						while bekleamk and not iptalEdiyorum do Citizen.Wait(1000) end
						bildir(PLT.U["getdelivery"])
						tirCoord = GetEntityCoords(tir)
						SetNewWaypoint(PLT.DeliveryPoints[1].x,PLT.DeliveryPoints[1].y)
					end
					 Citizen.CreateThread(function()
						for k,v in pairs(PLT.DeliveryPoints) do 
							while GetDistanceBetweenCoords(tirCoord,v,false) > 10  and not iptalEdiyorum do Citizen.Wait(0)
								while bekleamk and not iptalEdiyorum do Citizen.Wait(1000) end
								bildir(PLT.U["followtomarker"],nil,false)
								tirCoord = GetEntityCoords(tir)
								DrawMarker(1, PLT.DeliveryPoints[k].x , PLT.DeliveryPoints[k].y,  PLT.DeliveryPoints[k].z -       1, 0, 0.50, 0, 0.0, 0, 0, 4.5,4.5,1.33, 0, 0,150, 255, true, 0.10, 0, 1, 0, 0.0, 0)
								if PLT.DeliveryPoints[k+1] then 
								DrawMarker(1, PLT.DeliveryPoints[k+1].x , PLT.DeliveryPoints[k+1].y,  PLT.DeliveryPoints[k+1].z - 1, 0, 0.50, 0, 0.0, 0, 0, 2.5,2.5,1.0,  0, 0, 150, 200, 0.0, 0.10, 0, 1, 0, 0.0, 0)
								end
								if PLT.DeliveryPoints[k+2] then 
								DrawMarker(1, PLT.DeliveryPoints[k+2].x , PLT.DeliveryPoints[k+2].y,  PLT.DeliveryPoints[k+2].z - 1, 0, 0.50, 0, 0.0, 0, 0, 1.5,1.5,0.66, 0, 0, 150, 150, 0.0, 0.10, 0, 1, 0, 0.0, 0)
								end
							end
						end
					end)
				end
			end
			while workStage == 4 and not bekleamk and not iptalEdiyorum do Citizen.Wait(0) 
				sBalyaOnDorse = balyaOnDorseCoord[#balyaOnDorseCoord]
				if sBalyaOnDorse then 
					bildir(PLT.U["balefromdorce"],nil,false)
					playerCoord = GetEntityCoords(playerPed)
					dorse4Mark = GetOffsetFromEntityInWorldCoords(dorse, sBalyaOnDorse.offx,sBalyaOnDorse.offy, sBalyaOnDorse.offz)
					balyaSonCoord = GetEntityCoords(sBalyaOnDorse.used)
					playerToBalya = GetDistanceBetweenCoords(dorse4Mark,playerCoord,true)
					DrawMarker(20, dorse4Mark.x ,dorse4Mark.y,dorse4Mark.z + 2, 0, 0.50, 0, 0, 0, 0, 1.5,1.5,1.5, 0, 0, 250, 255, true, 0.10, 0, 1, 0, 0.0, 0)
					if playerToBalya < 2.0 then Citizen.Wait(500)
						local slmheading = GetHeadingFromVector_2d(balyaSonCoord.x-playerCoord.x,balyaSonCoord.y-playerCoord.y)
						SetEntityHeading(pedID, slmheading) Citizen.Wait(25)	
						RequestAnimDict("missminuteman_1ig_2") while not HasAnimDictLoaded("missminuteman_1ig_2") do Citizen.Wait(0) end
						TaskPlayAnim(pedID, "missminuteman_1ig_2", "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
						Citizen.Wait(444)
						local boneIndex = GetPedBoneIndex(playerPed, 57005)
						AttachEntityToEntity(sBalyaOnDorse.used, playerPed, boneIndex, 0.9, 0.1, -0.75, 0.0, 91.0, 0.0, false, false, false, true, 1, true)
						TaskAchieveHeading(pedID, slmheading - 180, 1000)
						Citizen.Wait(1000)
						StopAnimTask(pedID, 'missminuteman_1ig_2', 'handsup_enter', 1.0)
						Citizen.Wait(400)				
						loadAnimDict('anim@heists@box_carry@')Citizen.Wait(50)
						TaskPlayAnim(pedID, "anim@heists@box_carry@", "walk", 1.0, 1.0, -1, 1 | 16 | 32, 0.0, 0, 0, 0)
						DetachEntity(sBalyaOnDorse.used)
						AttachEntityToEntity(sBalyaOnDorse.used, playerPed, boneIndex, 0.75, 0.75, 0.0, 0.0, 0.0, 100.0, false, false, false, true, 1, true)
						local goanim = true
						Citizen.CreateThread(function()
							while goanim do 
								if not IsEntityPlayingAnim(playerPed, "anim@heists@box_carry@", "walk", 3) then 
									loadAnimDict('anim@heists@box_carry@')
									TaskPlayAnim(pedID, "anim@heists@box_carry@", "walk", 1.0, 1.0, -1, 1 | 16 | 32, 0.0, 0, 0, 0)
								end
								Citizen.Wait(0)
							end
							StopAnimTask(pedID, 'anim@heists@box_carry@', 'walk', 1.0)
						end)
						while GetDistanceBetweenCoords(playerCoord, PLT.DeliveryCoords, true) > 2.0 do Citizen.Wait(0) 
							bildir(PLT.U["outbalemark"],nil,false)
							DrawMarker(20, PLT.DeliveryCoords.x ,PLT.DeliveryCoords.y ,PLT.DeliveryCoords.z, 0, 0.50, 0, 0, 0, 0, 1.5,1.5,1.5, 255, 0, 0, 255, true, 0.10, 0, 1, 0, 0.0, 0)
							playerCoord = GetEntityCoords(playerPed) 
						end
						TaskGoStraightToCoord(playerPed, PLT.DeliveryCoords.x ,PLT.DeliveryCoords.y,PLT.DeliveryCoords.z, 1.4, 5000, 0, 0.5)
						while GetDistanceBetweenCoords(playerCoord, PLT.DeliveryCoords.x ,PLT.DeliveryCoords.y ,PLT.DeliveryCoords.z, false) > 1.0 do Citizen.Wait(10) playerCoord = GetEntityCoords(playerPed) end
						goanim = false
						DeleteObject(sBalyaOnDorse.used)
						ClearPedTasks(pedID)
						table.remove(balyaOnDorseCoord,#balyaOnDorseCoord)
						Citizen.Wait(100)
					end
				else
					RemoveBlip(DeliveryBlip)
					DeliveryBlip = false
					workStage = 5
				end
			end
			while workStage == 5 and not bekleamk and not iptalEdiyorum do Citizen.Wait(0) 
				bildir(PLT.U["movetruckback"])
				tirCoord = GetEntityCoords(tir)

				if GetDistanceBetweenCoords(tirCoord,PLT.VehicleDelete,false) < 30.0 then 
					DrawMarker(6,PLT.VehicleDelete.x,PLT.VehicleDelete.y,PLT.VehicleDelete.z-1,0.0, 0.0, 0.0,-90,-90,-90, 5.0,5.0,5.0,255,0.0,0.0,100,false, true, 2, false, false, false, false) 
					if GetDistanceBetweenCoords(tirCoord,PLT.VehicleDelete,false) < 3 then
						DoScreenFadeOut(1000)
						Citizen.Wait(1000)
						ESX.Game.DeleteVehicle(tir)
						tir = false
						ESX.Game.DeleteVehicle(dorse)
						dorse = false
						DoScreenFadeIn(1000)
						Citizen.Wait(250)
						iptalEt()
						TriggerServerEvent('plt_farmer:MissionComplate')
						break
					end
				else
					SetNewWaypoint(PLT.VehicleDelete.x,PLT.VehicleDelete.y)
				end
			end
		else
			Citizen.Wait(1000)
		end 
	end
end)

Citizen.CreateThread(function()	-- prohibition of getting into occupational vehicles
	local curveh
	local plate 
	while true do Citizen.Wait(500)
		curveh = GetVehiclePedIsTryingToEnter(playerPed)
		if curveh ~= nil and curveh ~= 0 then
			plate = GetVehicleNumberPlateText(curveh)
			if plate:sub(1, 5) == "HRVTR" then 
				if myArea then 
					if plate:sub(1, 6) == "HRVTR"..myArea then
						Citizen.Wait(1000)
					else
						exports['mythic_notify']:DoCustomHudText('error', PLT.U["not_yours"] ,7500)
						ClearPedTasks(playerPed)
					end
				else
					exports['mythic_notify']:DoCustomHudText('error', PLT.U["not_yours_cant"] ,7500)
					ClearPedTasks(playerPed)
				end
			else
				Citizen.Wait(2500)
			end
		elseif inAnyVeh then
			Citizen.Wait(2500)
		end
	end
end) 

Citizen.CreateThread(function() -- if too many away from area cancel events
	local min = 300
	local max = 375
	while true do Citizen.Wait(1000)
		while workStage ~= 0 and not iptalEdiyorum do Citizen.Wait(1000)
			playerPed = GetPlayerPed(-1)
			playerCoord = GetEntityCoords(playerPed)
			if bicerDover ~= false then 
				playerToBiverdover = GetDistanceBetweenCoords(playerCoord,GetEntityCoords(bicerDover),true)
				if playerToBiverdover > max then 
					exports['mythic_notify']:DoCustomHudText('error', PLT.U["canceled_harvester"] ,25000)
					iptalEt()
					break
				elseif playerToBiverdover > min then
					bildir(PLT.U["warning__harvester"])  
				end
			end
			if traktor ~= false then 
				playerToTraktor = GetDistanceBetweenCoords(playerCoord,GetEntityCoords(traktor),true)
				if playerToTraktor > max then 
					exports['mythic_notify']:DoCustomHudText('error', PLT.U["canceled_tractor"] ,25000)
					iptalEt()
					break
				elseif playerToTraktor > min then
					bildir(PLT.U["warning__tractor"])  
				end
			end
			if romork ~= false then 
				playerToRomork = GetDistanceBetweenCoords(playerCoord,GetEntityCoords(romork),true)
				if playerToRomork > max then 
					exports['mythic_notify']:DoCustomHudText('error', PLT.U["canceled_romork"] ,25000)
					iptalEt()
					break
				elseif playerToRomork > min then
					bildir(PLT.U["warning__romork"])  
				end
			end
			if tir ~= false then 
				playerToTir = GetDistanceBetweenCoords(playerCoord,GetEntityCoords(tir),true)
				if playerToTir > max then 
					exports['mythic_notify']:DoCustomHudText('error', PLT.U["canceled_tir"] ,25000)
					iptalEt()
					break
				elseif playerToTir > min then
					bildir(PLT.U["warning__tir"])  
				end
			end
			if dorse ~= false then 
				playerToDorse = GetDistanceBetweenCoords(playerCoord,GetEntityCoords(dorse),true)
				if playerToDorse > max then 
					exports['mythic_notify']:DoCustomHudText('error', PLT.U["canceled_dorce"] ,25000)
					iptalEt()
					break
				elseif playerToDorse > min then
					bildir(PLT.U["warning__dorce"])  
				end
			end
			for k,v in pairs(arpaTable) do
				playerToArpa = GetDistanceBetweenCoords(playerCoord,GetEntityCoords(v),true)
				if playerToArpa > max then 
					exports['mythic_notify']:DoCustomHudText('error', PLT.U["canceled_area"] ,25000)
					iptalEt()
					break
				elseif playerToArpa > min then
					bildir(PLT.U["warning__area"])  
				end
			end
			for k,v in pairs(arpaTable) do
				playerToArpa = GetDistanceBetweenCoords(playerCoord,GetEntityCoords(v),true)
				if playerToArpa > max then 
					exports['mythic_notify']:DoCustomHudText('error', PLT.U["canceled_area"] ,25000)
					iptalEt()
					break
				elseif playerToArpa > min then
					bildir(PLT.U["warning__area"])  
				end
			end
			for k,v in pairs(balyaTable) do
				playerToBalya = GetDistanceBetweenCoords(playerCoord,v.coord,true)
				if playerToBalya > max then 
					exports['mythic_notify']:DoCustomHudText('error', PLT.U["canceled_area"] ,25000)
					iptalEt()
					break
				elseif playerToBalya > min then
					bildir(PLT.U["warning__area"])  
				end
			end
		end
	end
end) 

Citizen.CreateThread(function()
	while true do Citizen.Wait(1000)
		if workStage ~= 0 then	
			playerPed = GetPlayerPed(-1)
			playerCoord = GetEntityCoords(playerPed)
			for k,v in pairs(balyaTable) do Citizen.Wait(100)
				if v.objeId ~= false and not iptalEdiyorum then 
					local playerToBalya = GetDistanceBetweenCoords(playerCoord,GetEntityCoords(v.objeId),true)
					if playerToBalya > 75 and not iptalEdiyorum then 
						DeleteEntity(v.objeId)
						TriggerServerEvent("plt_farmer:DeleteEntity",NetworkGetNetworkIdFromEntity(v.objeId))
						v.objeId = false
						Citizen.CreateThread(function()
							while not iptalEdiyorum do Citizen.Wait(1000)
								playerCoord = GetEntityCoords(playerPed)
								local playerToBalya = GetDistanceBetweenCoords(playerCoord,v.coord,true)
								if  playerToBalya < 75 and not iptalEdiyorum then
									local retval =	CreateObject(GetHashKey("prop_haybale_03"), v.coord.x,v.coord.y,v.coord.z - 1, true , false, false)
									TriggerServerEvent("plt_farmer:AddEntity", NetworkGetNetworkIdFromEntity(retval),myArea)
									FreezeEntityPosition(retval,true)
									v.objeId = retval
									createBlipforBale(retval)
									break
								end
							end	
						end)
					end
				end
			end
		else
			Citizen.Wait(2500)
		end
	end
end)

function spawnHarvesterProp()
	Citizen.CreateThread(function()
		local basarili = false
		local bekle = true
		local blip = AddBlipForCoord(PLT.Area[myArea][1].x,PLT.Area[myArea][1].y,PLT.Area[myArea][1].z)
		SetBlipSprite (blip, 1)
		SetBlipColour (blip, 81)
		SetBlipScale  (blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(PLT.U["Blip_Crop"])
		EndTextCommandSetBlipName(blip)
		SetNewWaypoint(PLT.Area[myArea][1].x,PLT.Area[myArea][1].y)
		while GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),PLT.Area[myArea][1].x,PLT.Area[myArea][1].y,PLT.Area[myArea][1].z,false) > 300  and not iptalEdiyorum  do Citizen.Wait(500)	end
		RemoveBlip(blip)
		if not iptalEdiyorum then 
			for k,v in pairs(PLT.Area[myArea]) do 
				if ESX.Game.IsSpawnPointClear(vector3(v.x, v.y, v.z), 7.0) then
					ESX.Game.SpawnVehicle("tractor3", vector3(v.x, v.y, v.z),v.w, function(vehicle)
						SetVehicleFuelLevel(vehicle, 99.0)
						SetEntityRotation(vehicle, 0, 0, 180)
						SetVehicleNumberPlateText(vehicle, "HRVTR"..myArea.."H")
						TriggerServerEvent("ARPF:GiveKeys",GetVehicleNumberPlateText(vehicle))
						bicerDover = vehicle
						basarili = true
						bekle = false
						SetVehicleColours(vehicle, index1, index2)
						TriggerServerEvent("plt_farmer:AddEntity", NetworkGetNetworkIdFromEntity(vehicle),myArea)
					end)
					break
				end
			end	
		else
			bekle = false
		end
		while bekle == true do Citizen.Wait(100)end
		if basarili then	
			if not iptalEdiyorum then 
				for k,v in pairs(PLT.Area[myArea]) do
					while GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),v.x,v.y,v.z,false) > 300  and not iptalEdiyorum  do Citizen.Wait(0)	end
					local baleObject = GetClosestObjectOfType(v.x, v.y, v.z, 3.0, GetHashKey("prop_haybale_03"))
					if DoesEntityExist(baleObject) then
						TriggerServerEvent("plt_farmer:DeleteEntity",NetworkGetNetworkIdFromEntity(baleObject))
						DeleteEntity(baleObject)
					end
				end
				local polatmak = CreateObject(GetHashKey("prop_veg_crop_04"), PLT.Area[myArea][5].x,PLT.Area[myArea][5].y,PLT.Area[myArea][5].z - 2.5, false , false, false)
				Citizen.Wait(1000)
				DeleteEntity(polatmak)
				arpaTable = {}
				for k,v in pairs(PLT.Area[myArea]) do Citizen.Wait(0)
					while GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),v.x,v.y,v.z,false) > 200  and not iptalEdiyorum  do Citizen.Wait(100)	end
					local retval =	CreateObject(GetHashKey("prop_veg_crop_04"), v.x,v.y,v.z - 2.5, false , false, false)
					FreezeEntityPosition(retval,true)
					table.insert(arpaTable,retval)
					createArpaBlip(retval) 
				end
				balyaOrani = (#arpaTable / (#balyaOnRomorkCoord+0.5))
			end 
		end
	end)
end

if PLT.HarvesterVehicleWheelEasyMode then 
	local deger = 0
	local ekle = 0.05
	local pltTersteker = false
	Citizen.CreateThread(function()
		while true do Citizen.Wait(1000)
			if canIHarvester then
				if workStage == 1 then
					if (IsPedInVehicle(pedID,bicerDover,false)) then
						pltTersteker = true
					else
						pltTersteker = false
					end	
				elseif 	pltTersteker then 
					pltTersteker = false	
				end
			elseif pltTersteker then
				pltTersteker = false
			else
				Citizen.Wait(2500)
			end
		end
	end)
	Citizen.CreateThread(function()
		while true do Citizen.Wait(0)
			if pltTersteker then
				DisableControlAction(0, 59, true )
				if IsControlPressed( 0, 34 )   then
					deger = deger - ekle
				elseif deger < 0.0 then 
					deger = 0.0
				end

				if IsControlPressed( 0, 30 ) then
					deger = deger + ekle
				elseif deger > 0.0 then 
					deger = 0.0
				end 

				if deger < -1.0 then deger =  -1.0 elseif  deger > 1.0 then  deger = 1.0 end
				SetVehicleSteerBias(bicerDover, deger)
			else
				Citizen.Wait(1000)
			end
		end
	end)
end

function spawnTraktor(canIdo)
	DoScreenFadeOut(1000)
    Citizen.Wait(1000)
	index1 = math.random(0, 160)
	index2 = math.random(0, 160)
	local basarili1 = false
	local basarili2 = false
 	local bekle = true
	for k,v in pairs(PLT.VehicleSpawn) do 
		if ESX.Game.IsSpawnPointClear(vector3(v.x, v.y, v.z), 7.0) then
			ESX.Game.SpawnVehicle(PLT.TractorName, vector3(v.x, v.y, v.z),v.w, function(vehicle)
				SetVehicleFuelLevel(vehicle, 99.0)
				SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
				SetVehicleNumberPlateText(vehicle, "HRVTR"..canIdo.."T")
				TriggerServerEvent("ARPF:GiveKeys", GetVehicleNumberPlateText(vehicle))
				traktor = vehicle
				bekle = false
				TaskEnterVehicle(GetPlayerPed(-1), vehicle, -1, 1, 2.0001, 1)
				SetVehicleColours(vehicle, index1, index2)
				basarili1 = true
				TriggerServerEvent("plt_farmer:AddEntity", NetworkGetNetworkIdFromEntity(traktor),canIdo)
			end)
			break
		end
	end	
	while bekle == true do Citizen.Wait(100)end 
	bekle = true
	if basarili1 then 
		for k,v in pairs(PLT.VehicleSpawn) do 
			if ESX.Game.IsSpawnPointClear(vector3(v.x, v.y, v.z), 7.0) then
				ESX.Game.SpawnVehicle("baletrailer", vector3(v.x, v.y, v.z),v.w, function(vehicle)
					SetVehicleNumberPlateText(vehicle, "HRVTR"..canIdo.."R")
					romork = vehicle
					bekle = false
					SetVehicleColours(vehicle, index1, index2)
					basarili2 = true
					TriggerServerEvent("plt_farmer:AddEntity", NetworkGetNetworkIdFromEntity(romork),canIdo)
				end)
				break
			end
		end	
	end
	while bekle == true do Citizen.Wait(100)end
	if basarili2 == false then
		ESX.Game.DeleteVehicle(traktor)
		traktor = false
	end
	DoScreenFadeIn(1000)
	return basarili2
end

function spawnTir()
	 local bekle = true
	for k,v in pairs(PLT.VehicleSpawn) do 
		if ESX.Game.IsSpawnPointClear(vector3(v.x, v.y, v.z), 7.0) then
			ESX.Game.SpawnVehicle(PLT.TruckName, vector3(v.x, v.y, v.z),v.w, function(vehicle)
				SetVehicleFuelLevel(vehicle, 99.0)
				SetVehicleNumberPlateText(vehicle, "HRVTR"..myArea.."P")
				TriggerServerEvent("ARPF:GiveKeys", GetVehicleNumberPlateText(vehicle))
				tir = vehicle
				bekle = false
				SetVehicleColours(vehicle, index1, index2)
				TriggerServerEvent("plt_farmer:AddEntity", NetworkGetNetworkIdFromEntity(vehicle),myArea)
			end)
			break
		end
	end	
	while bekle == true do Citizen.Wait(100)end 
	bekle = true
	for k,v in pairs(PLT.VehicleSpawn) do 
		if ESX.Game.IsSpawnPointClear(vector3(v.x, v.y, v.z), 7.0) then
			ESX.Game.SpawnVehicle("trflat", vector3(v.x, v.y, v.z),v.w, function(vehicle)
				dorse = vehicle
				bekle = false
				SetVehicleNumberPlateText(vehicle, "HRVTR"..myArea.."D")
				SetVehicleColours(vehicle, index1, index2)
				TriggerServerEvent("plt_farmer:AddEntity", NetworkGetNetworkIdFromEntity(vehicle),myArea)
			end)
			break
		end
	end	
	while bekle == true do Citizen.Wait(100)end
end

function OpenMenu(info)
	local cevap = "wait"
      ESX.UI.Menu.CloseAll()
      local elemanlar = {}
      for k,v in pairs(info) do 
          if v.source == nil then 
            table.insert(elemanlar, {label = ('[<span style="color:green;"> ') .. PLT.U["area"]..v.number.. ('</span> ]'), value = k})
          else
            table.insert(elemanlar, {label = ('[<span style="color:red;"> ') ..PLT.U["area"]..v.number.. ('</span> ]'), value = false})
          end
      end
      table.insert(elemanlar, {label = "iptal", value = "iptal"})
    ESX.UI.Menu.Open('default', "plt_farmer", 'selecet', {
      title    = PLT.U["canable_area"],
      align    = 'top-left',
      elements = elemanlar
    }, function(data, menu)
        
        if data.current.value == 'iptal' then
			menu.close()
			cevap = false
        elseif data.current.value == false then
			exports['mythic_notify']:DoCustomHudText('error', PLT.U["selecet_correct"]  ,10000)
		else
			menu.close()
			cevap = data.current.value
        end

    end, function(data, menu)
		menu.close()
		cevap = false
    end)

	while cevap == "wait" do Citizen.Wait(100) end
	return cevap
end

function refrehPedBlip()
	if DoesEntityExist(npcID) then  DeletePed(npcID)  npcID = false end
	if blipID then RemoveBlip(blipID) bliID = false end
	if workStage ~= 0 then iptalEt()	end
	iptalEdiyorum = true bekleamk = true workStage = nil
	if PLT.jobRequired then 
		if PlayerData.job.name == PLT.jobName then
			canIHarvester = true
			createPedBlip()
		else
			canIHarvester = false
		end
	else
		canIHarvester = true
		createPedBlip()
	end
	Citizen.Wait(1000)
	iptalEdiyorum = false bekleamk = false workStage = 0
end

function createPedBlip()
	local hash = GetHashKey("a_m_m_farmer_01")
	RequestModel(hash) while not HasModelLoaded(hash) do  Wait(1) end
	local ped = CreatePed(2, hash, PLT.PedCoord.x, PLT.PedCoord.y, PLT.PedCoord.z - 1, PLT.PedCoord.w, false, true)
	npcID = ped
	Citizen.Wait(1000)
	SetEntityHeading(ped, PLT.PedCoord.w)
	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	local blip = AddBlipForEntity(npcID)
	SetBlipSprite (blip, PLT.JobBlipSprite)
	SetBlipColour (blip, PLT.JobBlipColor)
	SetBlipScale  (blip, 0.75)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(PLT.U["Blip_Name"])
	EndTextCommandSetBlipName(blip)
	blipID = blip
	TaskStartScenarioInPlace(npcID, "PROP_HUMAN_PARKING_METER", 0, true)
end

function createArpaBlip(id)
	local blip = AddBlipForEntity(id)
	SetBlipSprite (blip, 391)
	SetBlipColour (blip, 46)
	SetBlipScale  (blip, 0.5)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(PLT.U["Blip_Crop"])
	EndTextCommandSetBlipName(blip)
	table.insert(arpaBlip,blip)
end

function createBlipforBale(objeid)
	local blip = AddBlipForEntity(objeid)
	SetBlipSprite (blip, 501)
	SetBlipColour (blip, 81)
	SetBlipScale  (blip, 0.8)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(PLT.U["Blip_Bale"])
	EndTextCommandSetBlipName(blip)
	table.insert(balyablip,blip)
end

function  createBlipforDelivery()
	local blip = AddBlipForCoord(PLT.DeliveryCoords)
	SetBlipSprite (blip, PLT.DeliveryBlipSprite)
	SetBlipColour (blip, PLT.DeliveryBlipColor)
	SetBlipScale  (blip, 0.8)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(PLT.U["Blip_Delivery"])
	EndTextCommandSetBlipName(blip)
	SetNewWaypoint(PLT.DeliveryPoints.x,PLT.DeliveryPoints.y)
	DeliveryBlip = blip
end

function iptalEt()
	iptalEdiyorum = true bekleamk = true workStage = nil Citizen.Wait(1000) 
	goanim = false
	TriggerServerEvent("plt_farmer:CancelWork")
	ESX.UI.Menu.CloseAll() myArea = false balyaOrani = nil
	if DoesEntityExist(bicerDover) then ESX.Game.DeleteVehicle(bicerDover) end bicerDover = false
	if DoesEntityExist(traktor)  then ESX.Game.DeleteVehicle(traktor) end traktor = false
	if DoesEntityExist(romork)  then ESX.Game.DeleteVehicle(romork) end romork = false
	if DoesEntityExist(tir)  then ESX.Game.DeleteVehicle(tir) end tir = false
	if DoesEntityExist(dorse)  then ESX.Game.DeleteVehicle(dorse) end dorse = false
	waitSV1 = false waitSV2 = false sayi = 0 balya = 0
	for k,v in pairs(arpaTable) do if DoesEntityExist(v) then DeleteEntity(v) end end arpaTable = {}
	for k,v in pairs(balyaTable) do Citizen.Wait(10) Citizen.Wait(10) if DoesEntityExist(v.objeId) then   DeleteEntity(v.objeId)  TriggerServerEvent("plt_farmer:DeleteEntity",NetworkGetNetworkIdFromEntity(v.objeId)) end end balyaTable = {}
	for k,v in pairs(balyablip) do Citizen.Wait(10) RemoveBlip(v) end balyablip = {}
	for k,v in pairs(arpaBlip) do Citizen.Wait(10) RemoveBlip(v)	end	arpaBlip = {}
	for k,v in pairs(balyaOnRomorkCoord) do Citizen.Wait(10) if DoesEntityExist(v.used) then DeleteEntity(v.used) TriggerServerEvent("plt_farmer:DeleteEntity",NetworkGetNetworkIdFromEntity(v.used))  end end
	for k,v in pairs(balyaOnDorseCoord) do Citizen.Wait(10) if DoesEntityExist(v.used) then DeleteEntity(v.used) TriggerServerEvent("plt_farmer:DeleteEntity",NetworkGetNetworkIdFromEntity(v.used))   end	end
	for k,v in pairs(balyaOnDorseCoord) do Citizen.Wait(10) if DoesEntityExist(v.used) then DeleteEntity(v.used) TriggerServerEvent("plt_farmer:DeleteEntity",NetworkGetNetworkIdFromEntity(v.used)) end end 
	if DeliveryBlip then RemoveBlip(DeliveryBlip) DeliveryBlip = false end
	balyaOnRomorkCoord = {		{x =  0.6, y =  1.75 , z = 0.7,  used = false, offx =  3.9, offy =  1.75 , offz = -1.0, head = 90},		{x = -0.6, y =  1.75 , z = 0.7,  used = false, offx = -3.9, offy =  1.75 , offz = -1.0, head = 270},		{x =  0.6, y = -0.10 , z = 0.7,  used = false, offx =  3.9, offy = -0.10 , offz = -1.0, head = 90},		{x = -0.6, y = -0.10 , z = 0.7,  used = false, offx = -3.9, offy = -0.10 , offz = -1.0, head = 270},		{x =  0.6, y =  0.8  , z = 2.25, used = false, offx =  3.9, offy = 0.8  , offz = -1.0, head = 90},		{x = -0.6, y =  0.8  , z = 2.25, used = false, offx = -3.9, offy = 0.8  , offz = -1.0, head = 270},		{x =  0.6, y = -1.95 , z = 0.7,  used = false, offx =  3.9, offy = -1.95 , offz = -1.0, head = 90},		{x = -0.6, y = -1.95 , z = 0.7,  used = false, offx = -3.9, offy = -1.95 , offz = -1.0, head = 270},		{x =  0.6, y = -1.05, z = 2.25, used = false, offx =  3.9, offy = -1.05, offz = -1.0, head = 90},		{x = -0.6, y = -1.05, z = 2.25, used = false, offx = -3.9, offy = -1.05, offz = -1.0, head = 270},		{x =  0.6, y = -3.80 , z = 0.7,  used = false, offx =  3.9, offy = -3.80 , offz = -1.0, head = 90},		{x = -0.6, y = -3.80 , z = 0.7,  used = false, offx = -3.9, offy = -3.80 , offz = -1.0, head = 270},		{x =  0.6, y = -2.9 , z = 2.25, used = false, offx =  3.9, offy = -2.9 , offz = -1.0, head = 90},		{x = -0.6, y = -2.9 , z = 2.25, used = false, offx = -3.9, offy = -2.9 , offz = -1.0, head = 270},	} 
	balyaOnDorseCoord = {		{x =-0.6,y = 1.20, z = 1.33, used = false, offx = -3.0, offy = 1.20 , offz = -2.0},		{x = 0.6,y = 1.20, z = 1.33, used = false, offx =  3.0, offy = 1.20 , offz = -2.0},		{x =-0.6,y =-0.70, z = 1.33, used = false, offx = -3.0, offy =-0.70 , offz = -2.0},		{x = 0.6,y =-0.70, z = 1.33, used = false, offx =  3.0, offy =-0.70 , offz = -2.0},		{x =-0.6,y = 0.25, z = 2.88, used = false, offx = -3.0, offy = 0.25 , offz = -2.0},		{x = 0.6,y = 0.25, z = 2.88, used = false, offx =  3.0, offy = 0.25 , offz = -2.0},		{x =-0.6,y =-2.60, z = 1.33, used = false, offx = -3.0, offy =-2.60 , offz = -2.0},		{x = 0.6,y =-2.60, z = 1.33, used = false, offx =  3.0, offy =-2.60 , offz = -2.0},		{x =-0.6,y =-1.65, z = 2.88, used = false, offx = -3.0, offy =-1.65 , offz = -2.0},		{x = 0.6,y =-1.65, z = 2.88, used = false, offx =  3.0, offy =-1.65 , offz = -2.0},		{x =-0.6,y =-4.50, z = 1.33, used = false, offx = -3.0, offy =-4.50 , offz = -2.0},		{x = 0.6,y =-4.50, z = 1.33, used = false, offx =  3.0, offy =-4.50 , offz = -2.0},		{x =-0.6,y =-3.55, z = 2.88, used = false, offx = -3.0, offy =-3.55 , offz = -2.0},		{x = 0.6,y =-3.55, z = 2.88, used = false, offx =  3.0, offy =-3.55 , offz = -2.0},	} 
	balyaAttaching = {			{x = 1.00,  y = 1.00,   z = 11},		{x = 2.00,  y = 2.00,   z = 22},		{x = 3.00,  y = 3.00,   z = 33},		{x = 4.00,  y = 4.00,   z = 43},		{x = 6.00,  y = 6.00,   z = 53},		{x = 8.00,  y = 8.00,   z = 62},		{x = 10.0,  y = 10.0,   z = 71},		{x = 12.0,  y = 12.0,   z = 70},		{x = 15.0,  y = 15.0,   z = 78},		{x = 18.0,  y = 18.0,   z = 86},		{x = 21.0,  y = 21.0,   z = 94},		{x = 25.0,  y = 25.0,   z = 101},		{x = 29.0,  y = 29.0,   z = 108},		{x = 33.0,  y = 33.0,   z = 114},		{x = 38.0,  y = 38.0,   z = 120},		{x = 43.0,  y = 43.0,   z = 125},		{x = 49.0,  y = 49.0,   z = 130},		{x = 56.0,  y = 56.0,   z = 134},		{x = 63.0,  y = 63.0,   z = 134},		{x = 70.0,  y = 70.0,   z = 130},		{x = 77.0,  y = 77.0,   z = 125},		{x = 80.0,  y = 80.0,   z = 120},		{x = 84.0,  y = 84.0,   z = 115},		{x = 87.0,  y = 87.0,   z = 110},		{x = 91.0,  y = 91.0,   z = 105},		{x = 94.0,  y = 94.0,   z = 100},		{x = 98.0,  y = 98.0,   z = 100},	}
	iptalEdiyorum = false bekleamk = false workStage = 0
end

function DrawText3Ds(x,y,z, sx, sy, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(sx, sy)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 500
	DrawRect(_x,_y+0.0125, 0.0002+ factor, 0.025, 0, 0, 0, 50)
end

function OpenCloakroomMenu()
	ESX.UI.Menu.CloseAll()
    local elements = {
        { label = PLT.U["citizen_clothe"], value = 'citizen_wear' },
		{ label = PLT.U["work_clothe"], value = 'job_wear' },
		{ label = PLT.U["cancel"], value = 'cancel' },
    }
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom_actions',
        {
            css = 'unknownstory',
            title = PLT.U["gardrope"],
            align = 'top-left',
            elements = elements
        }, function(data, _)
            if data.current.value == 'citizen_wear' then
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    TriggerEvent('skinchanger:loadSkin', skin)
                end)
            elseif data.current.value == 'job_wear' then
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, PLT.Uniforms["male"])
					else
						TriggerEvent('skinchanger:loadClothes', skin, PLT.Uniforms["female"])
					end
				end)
            end
			_.close()
        end, function(_, menu)
        	menu.close()
    end)
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
	return true
end

function bildir(msg, thisFrame, beep, duration)
	AddTextEntry('pltHarvesterNotify', msg)
	if thisFrame then
		DisplayHelpTextThisFrame('pltHarvesterNotify', false)
	else
		if beep == nil then beep = true end
		BeginTextCommandDisplayHelp('pltHarvesterNotify')
		EndTextCommandDisplayHelp(0, false, beep, duration or -1)
	end
end

RegisterCommand(PLT.CommandFixVehicle, function(source, args, rawCommand)
	if PLT.jobRequired == false or  PlayerData.job.name == PLT.jobName then
		if fixWait == false then  
			if workStage ~= 0 then 
				local vehicle22 = GetVehiclePedIsIn(playerPed, false)
				if vehicle22 == traktor or vehicle22 == tir or vehicle22 == bicerDover then
					fixWait = true
					local vehicle22Coord = GetEntityCoords(vehicle22)
					SetEntityCoords(vehicle22, vehicle22Coord.x + math.random(-3, 3), vehicle22Coord.y + math.random(-3, 3), vehicle22Coord.z + 2, false, false, false, true)
					SetEntityHeading(vehicle22,GetEntityHeading(vehicle22) + 90)
					Citizen.CreateThread(function()
						Citizen.Wait(PLT.CommandFixVehicleWait*1000)
						fixWait = false
					end)
				else
					exports['mythic_notify']:DoCustomHudText('error', PLT.U["cant_this_veh"] ,10000)
				end
			else
				exports['mythic_notify']:DoCustomHudText('error', PLT.U["can_workout"] ,10000)
			end
		else
			exports['mythic_notify']:DoCustomHudText('error', PLT.U["wait_some"] ,10000)
		end
	else
		exports['mythic_notify']:DoCustomHudText('error', PLT.U["only_farmer"] ,10000)
	end
end,false)



RegisterCommand(PLT.CommandCancelJob, function(source, args, rawCommand)
	if PLT.jobRequired == false or  PlayerData.job.name == PLT.jobName then
		iptalEt()
	else
		exports['mythic_notify']:DoCustomHudText('error', PLT.U["only_farmer"] ,10000)
	end
end,false)



AddEventHandler('esx:onPlayerDeath', function(data)
	if workStage ~= 0 then
		exports['mythic_notify']:DoCustomHudText('error', PLT.U["cancelfordead"] ,10000)
		iptalEt()
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
	refrehPedBlip()
end)

RegisterNetEvent('plt_farmer:SetCancelJob')
AddEventHandler('plt_farmer:SetCancelJob', function()
	if workStage ~= 0 then
		iptalEt()
	end
end)
