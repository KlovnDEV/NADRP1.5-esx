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
local PlayerData              = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
		PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local vodka = {
    {x = 903.09,y = -2964.47,z = 5.9},
	{x = 903.09,y = -2964.47,z = 5.0}
}

local tequila = {
    {x = 916.71,y = -2964.47,z = 5.9},
	{x = 916.71,y = -2964.47,z = 5.0}
}

local jagerbomb = {
    {x = 930.71,y = -2964.47,z = 5.9},
	{x = 930.71,y = -2964.47,z = 5.0}
}

local beer = {
    {x = 944.71,y = -2964.47,z = 5.9},
	{x = 944.71,y = -2964.47,z = 5.0}
}

local redbull = {
    {x = 960.71,y = -2964.47,z = 5.9},
	{x = 960.71,y = -2964.47,z = 5.0}
}

local vittvin = {
    {x = 972.4,y = -2977.61,z = 5.9},
	{x = 972.4,y = -2977.61,z = 5.0}
}

local vodkaredbull = {
    {x = 123.27,y = -1279.76,z = 29.27},
	{x = 123.27,y = -1279.76,z = 28.27}
}

-- VODKAREDBULL (START)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(vodkaredbull) do
            -- Marker (START)
            DrawMarker(27, vodkaredbull[k].x, vodkaredbull[k].y, vodkaredbull[k].z, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 0, 255, 50, 200, 0, 0, 0, 0)
			-- Marker (END)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(vodkaredbull) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, vodkaredbull[k].x, vodkaredbull[k].y, vodkaredbull[k].z)

            if dist <= 0.5 then
                hintToDisplay('Press ~INPUT_CONTEXT~ to craft x1 ~r~vodka & redbull')
				
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					if PlayerData.job.name == 'vu' and PlayerData.job.grade_name == 'boss' then
						TriggerServerEvent('esx_unicorn_purchase:makeVodkaredbull')
					else
						NoPermissions()
					end
				end			
            end
        end
    end
end)

-- VODKAREDBULL (END)

------------------------------------------

-- VODKA (START)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(vodka) do
            -- Marker (START)
            DrawMarker(27, vodka[k].x, vodka[k].y, vodka[k].z, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 0, 255, 50, 200, 0, 0, 0, 0)
			-- Marker (END)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(vodka) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, vodka[k].x, vodka[k].y, vodka[k].z)

            if dist <= 0.5 then
                hintToDisplay('Press ~INPUT_CONTEXT~ to import x1 ~r~vodka')
				
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					if PlayerData.job.name == 'vu' and PlayerData.job.grade_name == 'boss' then
						TriggerServerEvent('esx_unicorn_purchase:purchaseVodka')
					else
						NoPermissions()
					end
				end			
            end
        end
    end
end)

-- VODKA (END)

------------------------------------------

-- TEQUILA (START)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(tequila) do
            -- Marker (START)
            DrawMarker(27, tequila[k].x, tequila[k].y, tequila[k].z, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 0, 255, 50, 200, 0, 0, 0, 0)
			-- Marker (END)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(tequila) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, tequila[k].x, tequila[k].y, tequila[k].z)

            if dist <= 0.5 then
                hintToDisplay('Press ~INPUT_CONTEXT~ to import x1 ~r~tequila')
				
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					if PlayerData.job.name == 'vu' and PlayerData.job.grade_name == 'boss' then
						TriggerServerEvent('esx_unicorn_purchase:purchaseTequila')
					else
						NoPermissions()
					end
				end			
            end
        end
    end
end)

-- TEQUILA (END)

------------------------------------------

-- JAGERBOMB (START)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(jagerbomb) do
            -- Marker (START)
            DrawMarker(27, jagerbomb[k].x, jagerbomb[k].y, jagerbomb[k].z, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 0, 255, 50, 200, 0, 0, 0, 0)
			-- Marker (END)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(jagerbomb) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, jagerbomb[k].x, jagerbomb[k].y, jagerbomb[k].z)

            if dist <= 0.5 then
                hintToDisplay('Press ~INPUT_CONTEXT~ to import x1 ~r~jagerbomb')
				
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					if PlayerData.job.name == 'vu' and PlayerData.job.grade_name == 'boss' then
						TriggerServerEvent('esx_unicorn_purchase:purchaseJagerbomb')
					else
						NoPermissions()
					end
				end			
            end
        end
    end
end)

-- JAGERBOMB (END)

------------------------------------------

-- BEER (START)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(beer) do
            -- Marker (START)
            DrawMarker(27, beer[k].x, beer[k].y, beer[k].z, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 0, 255, 50, 200, 0, 0, 0, 0)
			-- Marker (END)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(beer) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, beer[k].x, beer[k].y, beer[k].z)

            if dist <= 0.5 then
                hintToDisplay('Press ~INPUT_CONTEXT~ to import x1 ~r~beer')
				
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					if PlayerData.job.name == 'vu' and PlayerData.job.grade_name == 'boss' then
						TriggerServerEvent('esx_unicorn_purchase:purchaseBeer')
					else
						NoPermissions()
					end
				end			
            end
        end
    end
end)

-- BEER (END)

------------------------------------------

-- REDBULL (START)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(redbull) do
            -- Marker (START)
            DrawMarker(27, redbull[k].x, redbull[k].y, redbull[k].z, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 0, 255, 50, 200, 0, 0, 0, 0)
			-- Marker (END)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(redbull) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, redbull[k].x, redbull[k].y, redbull[k].z)

            if dist <= 0.5 then
                hintToDisplay('Press ~INPUT_CONTEXT~ to import x1 ~r~redbull')
				
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					if PlayerData.job.name == 'vu' and PlayerData.job.grade_name == 'boss' then
						TriggerServerEvent('esx_unicorn_purchase:purchaseRedbull')
					else
						NoPermissions()
					end
				end			
            end
        end
    end
end)

-- REDBULL (END)

------------------------------------------

-- VITT VIN (START)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(vittvin) do
            -- Marker (START)
            DrawMarker(27, vittvin[k].x, vittvin[k].y, vittvin[k].z, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 0, 255, 50, 200, 0, 0, 0, 0)
			-- Marker (END)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(vittvin) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, vittvin[k].x, vittvin[k].y, vittvin[k].z)

            if dist <= 0.5 then
                hintToDisplay('Press ~INPUT_CONTEXT~ to import x1 ~r~white wine')
				
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					if PlayerData.job.name == 'vu' and PlayerData.job.grade_name == 'boss' then
						TriggerServerEvent('esx_unicorn_purchase:purchaseVin')
					else
						NoPermissions()
					end
				end			
            end
        end
    end
end)

-- VITT VIN (END)

function NoPermissions()
	ESX.ShowNotification("You are not allowed to ~r~import")
end