local vendingMachines = {
	[1] = 690372739,
	[2] = 1114264700,
	[3] = 690372739, 
	[4] = -2015792788,
	[5] = -1318035530,
	[6] = 73774428, 
	[7] = -1317235795, 
	[8] = -654402915,
}

local methlocation = { ['x'] = 1763.75,['y'] = 2499.44,['z'] = 50.43,['h'] = 213.58, ['info'] = ' cell1' }
------------------------------
--FONCTIONS
-------------------------------
local cellcoords = { 
	[1] = {["x"] = 1784.09, ["y"] = 2582.086, ["z"] = 45.708, ["h"] = 99.223},
	[2] = { ["x"] = 1783.738, ["y"] = 2586.218, ["z"] = 45.706, ["h"] = 91.084 },
	[3] = {["x"] = 1783.561, ["y"] = 2573.708, ["z"] = 45.713, ["h"] = 84.382 },
	[4] = { ["x"] = 1783.434, ["y"] = 2569.991, ["z"] = 45.715, ["h"] = 85.102 },
	[5] = {["x"] = 1768.233, ["y"] = 2568.811, ["z"] = 45.729, ["h"] = 298.252 },
	[6] = { ["x"] = 1768.139, ["y"] = 2572.952, ["z"] = 45.727, ["h"] = 305.843 },
	[7] = { ["x"] = 1768.056, ["y"] = 2577.141, ["z"] = 45.725, ["h"] = 264.677 },
	[8] = { ["x"] = 1768.24, ["y"] = 2581.185, ["z"] = 45.722, ["h"] = 264.428 },
	[9] = { ["x"] = 1768.019, ["y"] = 2585.247, ["z"] = 45.721, ["h"] = 263.91 },
	[10] = { ["x"] = 1783.738, ["y"] = 2586.218, ["z"] = 45.706, ["h"] = 91.084 },
}

local tool_shops = {
	{ ['x'] = 44.838947296143, ['y'] = -1748.5364990234, ['z'] = 29.549386978149 },
	{ ['x'] = 2749.2309570313, ['y'] = 3472.3308105469, ['z'] = 55.679393768311 },
	{ ["x"] = -1273.013, ["y"] = -1411.996, ["z"] = 4.374 },
}

local twentyfourseven_shops = {
	{ ['x'] = 1961.1140136719, ['y'] = 3741.4494628906, ['z'] = 32.34375 },
	{ ['x'] = 1392.4129638672, ['y'] = 3604.47265625, ['z'] = 34.980926513672 },
	{ ['x'] = 546.98962402344, ['y'] = 2670.3176269531, ['z'] = 42.156539916992 },
	{ ['x'] = 2556.2534179688, ['y'] = 382.876953125, ['z'] = 108.62294769287 },
	{ ['x'] = -1821.9542236328, ['y'] = 792.40191650391, ['z'] = 138.13920593262 },
	{ ['x'] = -1223.6690673828, ['y'] = -906.67517089844, ['z'] = 12.326356887817 },
	{ ['x'] = -708.19256591797, ['y'] = -914.65264892578, ['z'] = 19.215591430664 },
	{ ['x'] = 26.419162750244, ['y'] = -1347.5804443359, ['z'] = 29.497024536133 },
	{ ["x"] = 439.431, ["y"] = -978.823, ["z"] = 30.69 },
	{ ['x'] = -45.4649, ['y'] = -1754.41, ['z'] = 29.421 },
	{ ['x'] = 24.5889, ['y'] = -1342.32, ['z'] = 29.497 },
	{ ['x'] = -707.394, ['y'] = -910.114, ['z'] = 19.2156 },
	{ ['x'] = 1162.87, ['y'] = -319.218, ['z'] = 69.2051 },
	{ ['x'] = 373.872, ['y'] = 331.028, ['z'] = 103.566 },
	{ ['x'] = 2552.47, ['y'] = 381.031, ['z'] = 108.623 },
	{ ['x'] = -1823.67, ['y'] = 796.291, ['z'] = 138.126 },
	{ ['x'] = 2673.91, ['y'] = 3281.77, ['z'] = 55.2411 },
	{ ['x'] = 1957.64, ['y'] = 3744.29, ['z'] = 32.3438 },
	{ ['x'] = 1701.97, ['y'] = 4921.81, ['z'] = 42.0637 },
	{ ['x'] = 1730.06, ['y'] = 6419.63, ['z'] = 35.0372 },
	{ ['x'] = 1841.32,['y'] = 2591.35,['z'] = 46.02 },
	{ ['x'] = -442.685,['y'] = 6009.501,['z'] = 31.742}, -- paletopd
	{ ["x"] = 310.542, ["y"] = -586.192, ["z"] = 43.284},
	{["x"] = -347.708, ["y"] = -130.206, ["z"] = 39.01},
	{["x"] = -1988.892, ["y"] = 3327.522, ["z"] = 32.96},	
	{["x"] = -1254.056, ["y"] = -1443.452, ["z"] = 4.374},--Beach
}

local weashop_locations = {
	{entering = {811.973572,-2155.33862,28.8189938}, inside = {811.973572,-2155.33862,28.8189938}, outside = {811.973572,-2155.33862,28.8189938},delay = 900},
	{entering = { 1692.54, 3758.13, 34.71}, inside = { 1692.54, 3758.13, 34.71}, outside = { 1692.54, 3758.13, 34.71},delay = 600},
	{entering = {252.915,-48.186,69.941}, inside = {252.915,-48.186,69.941}, outside = {252.915,-48.186,69.941},delay = 600},
	{entering = {844.352,-1033.517,28.094}, inside = {844.352,-1033.517,28.194}, outside = {844.352,-1033.517,28.194},delay = 780},
	{entering = {-331.487,6082.348,31.354}, inside = {-331.487,6082.348,31.454}, outside = {-331.487,6082.348,31.454},delay = 600},
	{entering = {-664.268,-935.479,21.729}, inside = {-664.268,-935.479,21.829}, outside = {-664.268,-935.479,21.829},delay = 600},
	{entering = {-1305.427,-392.428,36.595}, inside = {-1305.427,-392.428,36.695}, outside = {-1305.427,-392.428,36.695},delay = 600},
	{entering = {-1119.1, 2696.92, 18.56}, inside = {-1119.1, 2696.92, 18.56}, outside = {-1119.1, 2696.92, 18.56},delay = 600},
	{entering = {2569.978,294.472,108.634}, inside = {2569.978,294.472,108.734}, outside = {2569.978,294.472,108.734},delay = 800},
	{entering = {-3172.584,1085.858,20.738}, inside = {-3172.584,1085.858,20.838}, outside = {-3172.584,1085.858,20.838},delay = 600},
	{entering = {20.0430,-1106.469,29.697}, inside = {20.0430,-1106.469,29.797}, outside = {20.0430,-1106.469,29.797},delay = 600},
}


local weashop_blips = {}

RegisterNetEvent("shop:createMeth")
AddEventHandler("shop:createMeth", function()
	methlocation = cellcoords[math.random(#cellcoords)]
end)

RegisterNetEvent("shop:isNearPed")
AddEventHandler("shop:isNearPed", function()
	local pedpos = GetEntityCoords(PlayerPedId())
	local found = false
	for k,v in ipairs(twentyfourseven_shops)do
		local dist = #(vector3(v.x, v.y, v.z) - vector3(pedpos.x,pedpos.y,pedpos.z))
		if(dist < 10 and not found)then
			found = true
			local ident = exports["nadrp-ped"]:isPed('steamid')
			local name = GetPlayerName(PlayerPedId())
			TriggerServerEvent('nadrp-log:ExploiterLog', name, ident, "User sold to a shop keeper at store.")
		end
	end
end)

function setShopBlip()

	for station,pos in pairs(weashop_locations) do
		local loc = pos
		pos = pos.entering
		local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
		-- 60 58 137
		SetBlipSprite(blip,110)
		SetBlipScale(blip, 0.85)
		SetBlipColour(blip, 17)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Ammunation')
		EndTextCommandSetBlipName(blip)
		SetBlipAsShortRange(blip,true)
		SetBlipAsMissionCreatorBlip(blip,true)
		weashop_blips[#weashop_blips+1]= {blip = blip, pos = loc}
	end

	for k,v in ipairs(twentyfourseven_shops)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 52)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Shop")
		EndTextCommandSetBlipName(blip)
	end

	for k,v in ipairs(tool_shops)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 52)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Tool Shop")
		EndTextCommandSetBlipName(blip)
	end	

end
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


Citizen.CreateThread(function()
	
	setShopBlip()

	while true do

		local found = false
		--Citizen.Wait(1)
		local dstscan = 3.0
		local pos = GetEntityCoords(PlayerPedId(), false)

		for i,b in ipairs(weashop_blips) do
			local scanned = #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - pos)
			if scanned < dstscan then
				dstscan = scanned
			end
			if dstscan < 2.5 then
				DrawMarker(27,b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],0,0,0,0,0,0,1.001,1.0001,0.5001,0,155,255,50,0,0,0,0)
				if IsPedInAnyVehicle(PlayerPedId(), true) == false and dstscan < 0.25 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
					if IsControlJustPressed(1, 38) then
						TriggerServerEvent('CheckMyLicense')
						TriggerEvent("server-inventory-open", "5", "Shop");
						Wait(1000)
				    end
				end
			end
		end

		if(Vdist( 1108.45, -2007.2, 30.95, pos.x, pos.y, pos.z) < 20.0)then
			found = true
			DrawMarker(27,  1108.45, -2007.2, 30.95 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist( 1108.45, -2007.2, 30.95, pos.x, pos.y, pos.z) < 2.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~smelter.")
				if IsControlJustPressed(1, 38) then	
					local finished = exports["nadrp-taskbar"]:taskBar(10000,"Readying Smelter")
      				if (finished == 100) then
      					pos = GetEntityCoords(PlayerPedId(), false)
      					if(Vdist( 1108.45, -2007.2, 30.95, pos.x, pos.y, pos.z) < 2.0)then
							TriggerEvent("server-inventory-open", "17", "Craft");
						end
					end
			    end
			end
		end

		if(Vdist( 306.49, -601.31, 43.29, pos.x, pos.y, pos.z) < 20.0)then
			found = true
			DrawMarker(27,  306.49, -601.31, 43.29 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist( 306.49, -601.31, 43.29, pos.x, pos.y, pos.z) < 2.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
				if IsControlJustPressed(1, 38) then
					if (job == "ambulance" or job == "doctor") then
						TriggerEvent("server-inventory-open", "15", "Shop");
					else
						TriggerEvent("server-inventory-open", "29", "Shop");
					end
			    end
			end
		end

		

		if(Vdist(-633.088, 236.032,  81.881, pos.x, pos.y, pos.z) < 20.0)then
			found = true
			DrawMarker(27,-633.088, 236.032,  81.881 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist(-633.088, 236.032,  81.881, pos.x, pos.y, pos.z) < 2.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
				if IsControlJustPressed(1, 38) then
					TriggerEvent("server-inventory-open", "62", "Shop");
					Wait(1000)
			    end
			end
		end



		if(Vdist(470.2286, -988.6339, 24.92082, pos.x, pos.y, pos.z) < 2.0)then
			found = true
			local job = exports["nadrp-ped"]:isPed("myjob")
			if job == 'police' then
				DrawText3Ds( 470.2286, -988.6339, 24.92082, "~r~ [E]~w~ Trash Locker" , 1.0)
				--DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~trash locker.")
				if IsControlJustPressed(1, 38) and job == "police" then
					TriggerEvent("server-inventory-open", "1", "trash");
					Wait(1000)
				end
			end
		end

		if(Vdist(-442.204, 5987.163, 31.716, pos.x, pos.y, pos.z) < 2.0)then --Paleto pd
			found = true
			local job = exports["nadrp-ped"]:isPed("myjob")
			if job == 'police' then
				DrawText3Ds( -442.204, 5987.163, 31.716, "~r~ [E]~w~ Trash Locker" , 1.0)
				--DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~trash locker.")
				if IsControlJustPressed(1, 38) and job == "police" then
					TriggerEvent("server-inventory-open", "1", "trash");
					Wait(1000)
				end
			end
		end

		if(Vdist(-437.712, 5988.386, 30.68956, pos.x, pos.y, pos.z) < 20.0)then   --Paleto pd
			found = true
			DrawMarker(27, 1773.92, 2517.05, 45.83 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist(-437.712, 5988.386, 31.716, pos.x, pos.y, pos.z) < 2.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
				if IsControlJustPressed(1, 38) and job == "police" then
					TriggerEvent("server-inventory-open", "10", "Shop");
					Wait(1000)
			    end
			end
		end



		if(Vdist(-1578.054, -3014.891, -79.006, pos.x, pos.y, pos.z) < 20.0) then   --Bar 1
			found = true
			DrawMarker(27, -1578.054, -3014.891, -79.006 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist(-1578.054, -3014.891, -79.006, pos.x, pos.y, pos.z) < 2.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
				if IsControlJustPressed(1, 38) then
					TriggerEvent("server-inventory-open", "61", "Shop");
					Wait(1000)
			    end
			end
		end
		
		if(Vdist(-1192.73, -894.583, 13.995, pos.x, pos.y, pos.z) < 20.0) then   --BurgerShot
			found = true
			DrawMarker(27, -1192.73, -894.583, 13.995 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist(-1192.73, -894.583, 13.995, pos.x, pos.y, pos.z) < 2.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open  ~g~BurgerShot.")
				if IsControlJustPressed(1, 38) then
					TriggerEvent("server-inventory-open", "580", "BurgerShot");
					Wait(1000)
			    end
			end
		end

		if(Vdist(-1271.919, -1417.128,4.374, pos.x, pos.y, pos.z) < 20.0) then   --Bar beath
			found = true
			DrawMarker(27, -1271.919, -1417.128,4.374 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist(-1271.919, -1417.128,4.374, pos.x, pos.y, pos.z) < 2.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
				if IsControlJustPressed(1, 38) then
					TriggerEvent("server-inventory-open", "61", "Shop");
					Wait(1000)
			    end
			end
		end

		if(Vdist(-1226.74,  -1439.782,  4.374, pos.x, pos.y, pos.z) < 20.0) then   --Bar2 beath
			found = true
			DrawMarker(27, -1226.74,  -1439.782,  4.374 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist(-1226.74,  -1439.782,  4.374, pos.x, pos.y, pos.z) < 2.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
				if IsControlJustPressed(1, 38) then
					TriggerEvent("server-inventory-open", "61", "Shop");
					Wait(1000)
			    end
			end
		end

		if(Vdist(-1249.632, -1448.417, 4.374, pos.x, pos.y, pos.z) < 20.0) then   --Weed2 beath
			found = true
			DrawMarker(27, -1249.632, -1448.417, 4.374 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist(-1249.632, -1448.417, 4.374, pos.x, pos.y, pos.z) < 2.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
				if IsControlJustPressed(1, 38) then
					TriggerEvent("server-inventory-open", "420", "Shop");
					Wait(1000)
			    end
			end
		end

		if(Vdist(-1246.587, -1453.415, 4.374, pos.x, pos.y, pos.z) < 20.0) then   --Coffiee beath
			found = true
			DrawMarker(27, -1246.587, -1453.415, 4.374 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist(-1246.587, -1453.415, 4.374, pos.x, pos.y, pos.z) < 2.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
				if IsControlJustPressed(1, 38) then
					TriggerEvent("server-inventory-open", "62", "Shop");
					Wait(1000)
			    end
			end
		end

		if(Vdist( -629.028, 238.681, 81.899, pos.x, pos.y, pos.z) < 20.0) then   --Coffiee Bean
			found = true
			DrawMarker(27,  -629.028, 238.681, 81.899 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist( -629.028, 238.681, 81.899, pos.x, pos.y, pos.z) < 2.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
				if IsControlJustPressed(1, 38) then
					TriggerEvent("server-inventory-open", "62", "Shop");
					Wait(1000)
			    end
			end
		end

		if(Vdist( 273.927,-833.658, 29.258, pos.x, pos.y, pos.z) < 20.0) then   --Coffiee Ligion
			found = true
			DrawMarker(27,  273.927,-833.658, 29.258 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist( 273.927,-833.658, 29.258, pos.x, pos.y, pos.z) < 2.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
				if IsControlJustPressed(1, 38) then
					TriggerEvent("server-inventory-open", "62", "Shop");
					Wait(1000)
			    end
			end
		end

		

		-- if(Vdist(127.96, -1284.872, 29.28, pos.x, pos.y, pos.z) < 20.0) then   --Bar 2 (VU)
		-- 	found = true
		-- 	DrawMarker(27, 127.96, -1284.872, 29.28 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
		-- 	if(Vdist(127.96, -1284.872, 29.28, pos.x, pos.y, pos.z) < 2.0)then
		-- 		DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
		-- 		if IsControlJustPressed(1, 38) then
		-- 			TriggerEvent("server-inventory-open", "61", "Shop");
		-- 			Wait(1000)
		-- 	    end
		-- 	end
		-- end


		if(Vdist(452.4047, -980.1417, 30.68956, pos.x, pos.y, pos.z) < 20.0)then
			found = true
			DrawMarker(27, 1773.92, 2517.05, 45.83 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist(1773.92, 2517.05, 45.83, pos.x, pos.y, pos.z) < 2.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
				if IsControlJustPressed(1, 38) and job == "police" then
					TriggerEvent("server-inventory-open", "10", "Shop");
					Wait(1000)
			    end
			end
		end

		if(Vdist(312, -592.8, 43.28, pos.x, pos.y, pos.z) < 20.0)then
			found = true
			DrawMarker(27, 312, -592.8, 43.28 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist(312, -592.8, 43.28, pos.x, pos.y, pos.z) < 2.0)then
				--DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
				DrawText3Ds( 312, -592.8, 43.28, "~r~ [E]~w~ Pharmacy" , 1.0)
				if IsControlJustPressed(1, 38) and job == "ambulance" then
					TriggerEvent("server-inventory-open", "15", "Shop");
					Wait(1000)
			    end
			end
		end


		if(Vdist(256.18,-368.91,-44.13, pos.x, pos.y, pos.z) < 20.0)then
			found = true
			DrawMarker(27, 256.18,-368.91,-44.13 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist(256.18,-368.91,-44.13, pos.x, pos.y, pos.z) < 3.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~bar.")
				if IsControlJustPressed(1, 38) then	
					TriggerEvent("server-inventory-open", "14", "Shop");	
					Wait(1000)
			    end
			end
		end

		--[1] =  { ['x'] = 105.2,['y'] = 3600.14,['z'] = 40.73,['h'] = 102.26, ['info'] = ' craft new bikeirsy' },
		--[2] =  { ['x'] = 206.21,['y'] = -1852.54,['z'] = 27.48,['h'] = 10.05, ['info'] = ' wqek' },
		--[2] =  { ['x'] = 885.61,['y'] = -3199.84,['z'] = -98.19,['h'] = 56.8, ['info'] = ' crafting' },
		--[3] =  { ['x'] = 902.21,['y'] = -3182.47,['z'] = -97.05,['h'] = 272.78, ['info'] = ' Storage' },

		for k,v in ipairs(twentyfourseven_shops) do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 20.0)then
				found = true
				DrawMarker(27, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
				if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 3.0)then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
					if IsControlJustPressed(1, 38) then
						TriggerEvent("server-inventory-open", "2", "Shop");
						Wait(1000)

				    end
                end
            end
		end

		if(Vdist(1775.8272705078,2587.4946289063,45.712657928467, pos.x, pos.y, pos.z) < 10.0)then
			found = true
			DrawMarker(27, 1775.8272705078,2587.4946289063,45.712657928467 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist(1775.8272705078,2587.4946289063,45.712657928467, pos.x, pos.y, pos.z) < 2.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to look at food")
				if IsControlJustPressed(1, 38) then
					TriggerEvent("server-inventory-open", "22", "Shop");
					Wait(1000)
			    end
            end
        end

    	if(Vdist(methlocation["x"],methlocation["y"],methlocation["z"], pos.x, pos.y, pos.z) < 10.0)then
			found = true
			if(Vdist(methlocation["x"],methlocation["y"],methlocation["z"], pos.x, pos.y, pos.z) < 5.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ what dis?")
				if IsControlJustPressed(1, 38) then
					local finished = exports["nadrp-taskbar"]:taskBar(60000,"Searching...")
      				if (finished == 100) and Vdist(methlocation["x"],methlocation["y"],methlocation["z"], pos.x, pos.y, pos.z) < 2.0 then
						TriggerEvent("server-inventory-open", "25", "Shop");
						Wait(1000)
					end
			    end
            end
		end

    	if(Vdist(1663.36, 2512.99, 46.87, pos.x, pos.y, pos.z) < 10.0)then
			found = true
			if(Vdist(1663.36, 2512.99, 46.87, pos.x, pos.y, pos.z) < 2.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ what dis?")
				if IsControlJustPressed(1, 38) and (Vdist(1663.36, 2512.99, 46.87, pos.x, pos.y, pos.z) < 2.0) then
					local finished = exports["nadrp-taskbar"]:taskBar(60000,"Searching...")
      				if (finished == 100) then
						TriggerEvent("server-inventory-open", "26", "Shop");
						Wait(1000)
					end
			    end
            end
		end
		
		if(Vdist(1004.805, -3194.967, -38.993, pos.x, pos.y, pos.z) < 20.0) then
            found = true
            DrawMarker(27, 1004.805, -3194.967, -38.993 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0) --- Gun warehouse
            if(Vdist(1004.805, -3194.967, -38.993, pos.x, pos.y, pos.z) < 3.0) then
                DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~ CRAFT.")
                if IsControlJustPressed(1, 38)  then	
                    pos = GetEntityCoords(PlayerPedId(), false)
                    if(Vdist(1004.805, -3194.967, -38.993, pos.x, pos.y, pos.z) < 3.0) then
                       TriggerEvent("server-inventory-open", "130", "Craft");
                       Wait(1000)
                    end
                end
            end
        end




    	if(Vdist(1775.6893310547,2593.6455078125,45.723571777344, pos.x, pos.y, pos.z) < 10.0)then
			found = true
			if(Vdist(1775.6893310547,2593.6455078125,45.723571777344, pos.x, pos.y, pos.z) < 2.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ what dis?")
				if IsControlJustPressed(1, 38) and (Vdist(1775.6893310547,2593.6455078125,45.723571777344, pos.x, pos.y, pos.z) < 2.0) then
					local finished = exports["nadrp-taskbar"]:taskBar(60000,"Making a god slushy...")
      				if (finished == 100) then
						TriggerEvent("server-inventory-open", "27", "Shop");
						Wait(1000)
					end
			    end
            end
		end
		
		if(Vdist(-1600.685, 5204.332, 4.31, pos.x, pos.y, pos.z) < 20.0)then
			found = true
			DrawMarker(27, -1600.685, 5204.332, 4.31 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist(-1600.685, 5204.332, 4.31, pos.x, pos.y, pos.z) < 2.0)then
				local job = exports["nadrp-ped"]:isPed("myjob")
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
				if IsControlJustPressed(1, 38) then
					TriggerEvent("server-inventory-open", "57", "Shop");
					Wait(1000)
			    end
			end
		end


		if(Vdist(-1818.609, -1198.039, 14.47, pos.x, pos.y, pos.z) < 20.0)then
			found = true
			DrawMarker(27, -1818.609, -1198.039, 14.47 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist(-1818.609, -1198.039, 14.47, pos.x, pos.y, pos.z) < 2.0)then
				local job = exports["nadrp-ped"]:isPed("myjob")
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
				if IsControlJustPressed(1, 38) then
					TriggerEvent("server-inventory-open", "131", "Shop");
					Wait(1000)
			    end
			end
		end


		if(Vdist(-1845.143, -1198.026, 14.334, pos.x, pos.y, pos.z) < 20.0)then
			found = true
			DrawMarker(27, -1845.143, -1198.026, 14.334 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist(-1845.143, -1198.026, 14.334, pos.x, pos.y, pos.z) < 2.0)then
				local job = exports["nadrp-ped"]:isPed("myjob")
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
				if IsControlJustPressed(1, 38) then
					TriggerEvent("server-inventory-open", "131", "Shop");
					Wait(1000)
			    end
			end
		end
g


		--BlackMarketg

		if(Vdist(1013.465,  -3195.072,-38.993, pos.x, pos.y, pos.z) < 10.0)then
			found = true
			if(Vdist(1013.465,  -3195.072,-38.993, pos.x, pos.y, pos.z) < 3.0) then
				DrawText3Ds(1013.465,  -3195.072,-38.993, "~r~[E] - ~w~ BlackMarket")
				if IsControlJustPressed(1, 38) then
					TriggerEvent("server-inventory-open", "2022", "shop");
					Wait(1000)
			    end
            end
		end


		
		

		--[[if(Vdist(1777.58, 2565.15, 45.68, pos.x, pos.y, pos.z) < 10.0)then
			found = true
			if(Vdist(1777.58, 2565.15, 45.68, pos.x, pos.y, pos.z) < 2.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ what dis?")
				if IsControlJustPressed(1, 38) then
					local finished = exports["nadrp-taskbar"]:taskBar(60000,"Searching...")
      				if (finished == 100) and (Vdist(1777.58, 2565.15, 45.68, pos.x, pos.y, pos.z) < 2.0) then
						TriggerEvent("server-inventory-open", "23", "Craft");
						Wait(1000)
					end
			    end
            end
        end]]

		--[[if(Vdist(-632.64, 235.25, 81.89, pos.x, pos.y, pos.z) < 10.0)then
			found = true
			DrawMarker(27, -632.64, 235.25, 81.89 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist(-632.64, 235.25, 81.89, pos.x, pos.y, pos.z) < 5.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to purchase Hipster")
				if IsControlJustPressed(1, 38) then
					TriggerEvent("server-inventory-open", "12", "Shop");
					Wait(1000)
			    end
            end
		end]]

		for k,v in ipairs(tool_shops) do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 20.0)then
				found = true
				DrawMarker(27, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
				if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 3.0)then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~tool shop.")
					if IsControlJustPressed(1, 38) then
						TriggerEvent("server-inventory-open", "4", "Shop");
						Wait(1000)
				    end
                end
            end
		end

		
		if(Vdist(-2581.283,  1890.24, 163.724, pos.x, pos.y, pos.z) < 10.0)then
			found = true
			if(Vdist(-2581.283,  1890.24, 163.724, pos.x, pos.y, pos.z) < 3.0) and job == 'realestateagent' then
				DrawText3Ds(-2581.283,  1890.24, 163.724, "[E] - stash")
				if IsControlJustPressed(1, 38) then
					TriggerEvent("server-inventory-open", "1", "house-Buen Vino Rd 1");
					Wait(1000)
			    end
            end
		end

		if(Vdist(992.074, -135.837, 74.074, pos.x, pos.y, pos.z) < 10.0)then
			found = true
			if(Vdist(992.074, -135.837, 74.074, pos.x, pos.y, pos.z) < 3.0) and job == 'lmc' then
				DrawText3Ds(992.074, -135.837, 74.074, "~r~ [E] ~w~- Stash")
				if IsControlJustPressed(1, 38) then
					TriggerEvent("server-inventory-open", "1", "house-LMC");
					Wait(1000)
			    end
            end
		end
		

		if(Vdist(-72.22, -814.002, 243.386, pos.x, pos.y, pos.z) < 10.0)then
			found = true
			if(Vdist(-72.22, -814.002, 243.386, pos.x, pos.y, pos.z) < 3.0) and job == 'realestateagent' then
				DrawText3Ds(-72.22, -814.002, 243.386, "~r~ [E] ~w~- Stash")
				if IsControlJustPressed(1, 38) then
					TriggerEvent("server-inventory-open", "1", "house-RB Office");
					Wait(1000)
			    end
            end
		end

		if(Vdist(-1570.826, -575.074, 108.523, pos.x, pos.y, pos.z) < 10.0)then
			found = true
			if(Vdist(-1570.826, -575.074, 108.523, pos.x, pos.y, pos.z) < 3.0) and job == 'mayor' then
				DrawText3Ds(-1570.826, -575.074, 108.523, "~r~ [E] ~w~- Stash")
				if IsControlJustPressed(1, 38) then
					TriggerEvent("server-inventory-open", "1", "house-Ford Office");
					Wait(1000)
			    end
            end
		end



		if(Vdist(94.377, -1292.564,  29.269, pos.x, pos.y, pos.z) < 2.5)then
			found = true
			if(Vdist(94.377, -1292.564,  29.269, pos.x, pos.y, pos.z) < 0.5) and job == 'vu2' or job == 'mayor' then
				DrawText3Ds(94.377, -1292.564,  29.269, "~r~ [E] ~w~- Stash")
				if IsControlJustPressed(1, 38) then
					TriggerEvent("server-inventory-open", "1", "house-VU");
					Wait(1000)
			    end
            end
		end

		

	





		if(Vdist(1013.465,  -3195.072,-38.993, pos.x, pos.y, pos.z) < 10.0)then
			found = true
			if(Vdist(1013.465,  -3195.072,-38.993, pos.x, pos.y, pos.z) < 3.0) then
				DrawText3Ds(1013.465,  -3195.072,-38.993, "~r~[E] - ~w~ Stash")
				if IsControlJustPressed(1, 38) then
					TriggerEvent("server-inventory-open", "1", "gunwarehouse-8");
					Wait(1000)
			    end
            end
		end

		
		if(Vdist(1004.805, -3194.967, -38.993, pos.x, pos.y, pos.z) < 20.0) then
            found = true
            DrawMarker(27, 1004.805, -3194.967, -38.993 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0) --- Gun warehouse
            if(Vdist(1004.805, -3194.967, -38.993, pos.x, pos.y, pos.z) < 3.0) then
                DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~ CRAFT.")
                if IsControlJustPressed(1, 38)  then	
                    pos = GetEntityCoords(PlayerPedId(), false)
                    if(Vdist(1004.805, -3194.967, -38.993, pos.x, pos.y, pos.z) < 3.0) then
                       TriggerEvent("server-inventory-open", "130", "Craft");
                       Wait(1000)
                    end
                end
            end
        end

		if not found and dstscan > 2.5 then
			Citizen.Wait(1200)
		else
			Citizen.Wait(0)
		end
	end
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
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
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

RegisterNetEvent('nadrp:playerBecameJob')
AddEventHandler('nadrp:playerBecameJob', function(jobpassed)
	job = jobpassed.name
end)