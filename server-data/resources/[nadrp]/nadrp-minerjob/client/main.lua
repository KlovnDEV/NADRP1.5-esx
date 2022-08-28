local PlayerData                = {}
ESX                             = nil

local blip1 = {}
local blips = false
local blipActive = false
local mineActive = false
local washingActive = false
local remeltingActive = false
local firstspawn = false
local trading = false
local impacts = 0
local timer = 0
local locations = {
    { ['x'] = -591.47,  ['y'] = 2076.52,  ['z'] = 131.37},
    { ['x'] = -590.35,  ['y'] = 2071.76,  ['z'] = 131.29},
    { ['x'] = -589.61,  ['y'] = 2069.3,  ['z'] = 131.19},
    { ['x'] = -588.6,  ['y'] = 2064.03,  ['z'] = 130.96},
}

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
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
RegisterNetEvent('esx_miner:timer')
AddEventHandler('esx_miner:timer', function()
    local timer = 0
    local ped = PlayerPedId()
    
    Citizen.CreateThread(function()
		while timer > -1 do
			Citizen.Wait(150)

			if timer > -1 then
				timer = timer + 1
            end
            if timer == 100 then
                break
            end
		end
    end) 

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.WashingX, Config.WashingY, Config.WashingZ, true) < 5 then
                DT( Config.WashingX, Config.WashingY, Config.WashingZ+0.5 -1.400, ('Washing stones in progress ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ, true) < 5 then
                DT( Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ+0.5 -1.400, ('Remelting stones in progress ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if timer == 100 then
                timer = 0
                break
            end
        end
    end)
end)

RegisterNetEvent('esx_miner:createblips')
AddEventHandler('esx_miner:createblips', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            --if blips == true and blipActive == false then
            blip1 = AddBlipForCoord(-597.01, 2091.42, 131.41)
            blip2 = AddBlipForCoord(Config.WashingX, Config.WashingY, Config.WashingZ)
            blip3 = AddBlipForCoord(Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ)
            blip4 = AddBlipForCoord(Config.SellX, Config.SellY, Config.SellZ)
            SetBlipSprite(blip1, 365)
            SetBlipColour(blip1, 5)
            SetBlipAsShortRange(blip1, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Mine")
            EndTextCommandSetBlipName(blip1)   
            SetBlipSprite(blip2, 365)
            SetBlipColour(blip2, 5)
            SetBlipAsShortRange(blip2, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Washing stones")
            EndTextCommandSetBlipName(blip2)   
            SetBlipSprite(blip3, 365)
            SetBlipColour(blip3, 5)
            SetBlipAsShortRange(blip3, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Remelting stones")
            EndTextCommandSetBlipName(blip3)
            SetBlipSprite(blip4, 272)
            SetBlipColour(blip4, 5)
            SetBlipAsShortRange(blip4, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Selling items")
            EndTextCommandSetBlipName(blip4)
            blipActive = true
        end
    end)
end)

Citizen.CreateThread(function() 
    blip1 = AddBlipForCoord(-597.01, 2091.42, 131.41)
    blip2 = AddBlipForCoord(Config.WashingX, Config.WashingY, Config.WashingZ)
    blip3 = AddBlipForCoord(Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ)
    blip4 = AddBlipForCoord(Config.SellX, Config.SellY, Config.SellZ)
    blip5 = AddBlipForCoord(Config.SellGX, Config.SellGY, Config.SellGZ)
    blip6 = AddBlipForCoord(Config.SellCX, Config.SellCY, Config.SellCZ)
    blip7 = AddBlipForCoord(Config.SellIX, Config.SellIY, Config.SellIZ)
    SetBlipSprite(blip1, 365)
    SetBlipColour(blip1, 5)
    SetBlipAsShortRange(blip1, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Mine")
    EndTextCommandSetBlipName(blip1)   
    SetBlipSprite(blip2, 365)
    SetBlipColour(blip2, 5)
    SetBlipAsShortRange(blip2, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Washing stones")
    EndTextCommandSetBlipName(blip2)   
    SetBlipSprite(blip3, 365)
    SetBlipColour(blip3, 5)
    SetBlipAsShortRange(blip3, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Remelting stones")
    EndTextCommandSetBlipName(blip3)
    SetBlipSprite(blip4, 272)
    SetBlipColour(blip4, 5)
    SetBlipAsShortRange(blip4, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Selling Diamonds")
    EndTextCommandSetBlipName(blip4)
    SetBlipSprite(blip5, 272)
    SetBlipColour(blip5, 5)
    SetBlipAsShortRange(blip5, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Selling Gold")
    EndTextCommandSetBlipName(blip5)
    SetBlipSprite(blip6, 272)
    SetBlipColour(blip6, 5)
    SetBlipAsShortRange(blip6, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Selling Copper")
    EndTextCommandSetBlipName(blip6)
    SetBlipSprite(blip7, 272)
    SetBlipColour(blip7, 5)
    SetBlipAsShortRange(blip7, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Selling Iron")
    EndTextCommandSetBlipName(blip7)

end)


Citizen.CreateThread(function()
    local sleep = 1000
    while true do
        for i=1, #locations, 1 do
            if #(vector3(locations[i].x, locations[i].y, locations[i].z) - GetEntityCoords(PlayerPedId())) < 25 and mineActive == false then
                DrawMarker(20, locations[i].x, locations[i].y, locations[i].z, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
                sleep = 0
                if #(vector3(locations[i].x, locations[i].y, locations[i].z) - GetEntityCoords(PlayerPedId())) < 1 then
                    if IsControlJustReleased(1, 51) then
                        Animation()
                        mineActive = true
                    end
                end
            end
        end
        Citizen.Wait(sleep)
        sleep = 1000
    end
end)

Citizen.CreateThread(function()
    local ped = PlayerPedId()
    local recent = false
    while true do
        if #(vector3(Config.WashingX, Config.WashingY, Config.WashingZ) - GetEntityCoords(PlayerPedId()))  < 25 and washingActive == false then
            Citizen.Wait(1)
            DrawMarker(20, Config.WashingX, Config.WashingY, Config.WashingZ, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
            if #(vector3(Config.WashingX, Config.WashingY, Config.WashingZ) - GetEntityCoords(PlayerPedId())) < 1 then
                -- ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to wash the stones.")
                if IsControlJustReleased(1, 51) and exports['nadrp-inventory']:hasEnoughOfItem('stone', 10) and not recent then
                    recent = true
                    local finished = exports['nadrp-taskbar']:taskBar(10000, 'Washing stone')
                    local cid = exports['nadrp-ped']:isPed('steamid')
                    if finished == 100 then
                        TriggerEvent('inventory:removeItem',"stone", 10) 
                        TriggerEvent("player:receiveItem","washedstone",10)
                        Wait(2000)
                        TriggerServerEvent("sendingItemstoClient", cid, PlayerId())
                        recent = false
                    end
                end
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local randomChance = math.random(1, 100)
        if #(vector3(Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ) - GetEntityCoords(PlayerPedId())) < 25 and remeltingActive == false then
            Citizen.Wait(1)
            DrawMarker(20, Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
            if #(vector3(Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ) - GetEntityCoords(PlayerPedId())) < 1 then
                if IsControlJustReleased(1, 51) and exports['nadrp-inventory']:hasEnoughOfItem('washedstone', 10) then
                    local finished = exports['nadrp-taskbar']:taskBar(10000, 'Smelting')
                    if finished == 100 then
                        local cid = exports['nadrp-ped']:isPed('steamid')
                        if randomChance < 10 then
                            TriggerEvent('inventory:removeItem',"washedstone", 10) 
                            TriggerEvent("player:receiveItem","diamond",1)
                            Wait(2000)
                            TriggerServerEvent("sendingItemstoClient", cid, PlayerId())
                        elseif randomChance > 9 and randomChance < 25 then
                            TriggerEvent('inventory:removeItem',"washedstone", 10) 
                            TriggerEvent("player:receiveItem","gold",5)
                            Wait(2000)
                            TriggerServerEvent("sendingItemstoClient", cid, PlayerId())
                        elseif randomChance > 24 and randomChance < 50 then
                            TriggerEvent('inventory:removeItem',"washedstone", 10) 
                            TriggerEvent("player:receiveItem","iron",10)
                            Wait(2000)
                            TriggerServerEvent("sendingItemstoClient", cid, PlayerId())
                        elseif randomChance > 49 then
                            TriggerEvent('inventory:removeItem',"washedstone", 10) 
                            TriggerEvent("player:receiveItem","copper",10)
                            Wait(2000)
                            TriggerServerEvent("sendingItemstoClient", cid, PlayerId())
                        end
                    end
                end
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    local ped = PlayerPedId()
    local sleep = 1000
    while true do

        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local dist =  #(plyCoords - vector3(Config.SellX, Config.SellY, Config.SellZ))
		if dist <= 10.0 then
            DrawMarker(27, Config.SellX, Config.SellY, Config.SellZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
            sleep = 0
		else
            Citizen.Wait(1500)
            sleep = 1000
		end
		
		if dist <= 2.5 then
            DT(Config.SellX, Config.SellY, Config.SellDZ, "~b~[E]~w~ To Sell Diamonds ~r~[10 a time]")
		end
		if dist <= 2.5 then
			if IsControlJustPressed(1, 51) then
                local itemCount = exports["nadrp-inventory"]:getQuantity("diamond")
                local cid = exports['nadrp-ped']:isPed('steamid')
                if itemCount > 0 and not trading then
                    trading = true
                    exports['t0sic_loadingbar']:StartDelayedFunction('Trading Diamonds', (math.random(40, 60) * 1000), function()
                        TriggerServerEvent('Ford:Trade', itemCount)
                        TriggerEvent('inventory:removeItem',"diamond", itemCount) 
                        Wait(2000)
                        TriggerServerEvent("sendingItemstoClient", cid, PlayerId())
                        trading = false
                    end)
                else
                    exports['mythic_notify']:SendAlert('error', 'You dont have enough diamonds or you are currently selling')
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    local ped = PlayerPedId()
    local sleep = 1000
    while true do
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local dist =  #(plyCoords - vector3(Config.SellGX, Config.SellGY, Config.SellGZ))
		if dist <= 20.0 then
		    DrawMarker(27, Config.SellGX, Config.SellGY, Config.SellGZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
            sleep = 0
        else
            sleep = 1000
        end
		
		if dist <= 2.5 then
            DT(Config.SellGX, Config.SellGY, Config.SellGTZ, "~b~[E]~w~ To Sell Gold")
		end

		if dist <= 2.5 then
			if IsControlJustPressed(1, 51) then
                local itemCount = exports["nadrp-inventory"]:getQuantity("gold")
                local cid = exports['nadrp-ped']:isPed('steamid')
                if itemCount > 0 and not trading then
                    trading = true
                    exports['t0sic_loadingbar']:StartDelayedFunction('Trading Gold', (math.random(40, 60) * 1000), function()
                        TriggerServerEvent('Ford:Gold', itemCount)
                        TriggerEvent('inventory:removeItem',"gold", itemCount) 
                        Wait(2000)
                        TriggerServerEvent("sendingItemstoClient", cid, PlayerId())
                        trading = false
                    end)
                else
                    exports['mythic_notify']:SendAlert('error', 'You dont have enough gold or you are currently selling')
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    local ped = PlayerPedId()
    local sleep = 1000
    while true do

        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local dist =  #(plyCoords - vector3(Config.SellCX, Config.SellCY, Config.SellCTZ))
		if dist <= 20.0 then
		    DrawMarker(27, Config.SellCX, Config.SellCY, Config.SellCTZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
            sleep = 0
        else
            sleep = 1500
        end

		if dist <= 2.5 then
            DT(Config.SellCX, Config.SellCY, Config.SellCTZ, "~b~[E]~w~ To Sell Copper")
		end

		if dist <= 2.5 then
            if IsControlJustPressed(1, 51) then
                local cid = exports['nadrp-ped']:isPed('steamid')
                local itemCount = exports["nadrp-inventory"]:getQuantity("copper")
                if itemCount > 0 and not trading then
                    trading = true
                    exports['t0sic_loadingbar']:StartDelayedFunction('Trading Copper', (math.random(40, 60) * 1000), function()
                        TriggerServerEvent('Ford:Copper', itemCount)
                        TriggerEvent('inventory:removeItem',"copper", itemCount) 
                        Wait(2000)
                        TriggerServerEvent("sendingItemstoClient", cid, PlayerId())
                        trading = false
                    end)
                else
                    exports['mythic_notify']:SendAlert('error', 'You dont have enough copper or you are currently selling')
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    local ped = PlayerPedId()
    while true do

        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local dist =  #(plyCoords - vector3(Config.SellIX, Config.SellIY, Config.SellIZ))
		if dist <= 10.0 then
		    DrawMarker(27, Config.SellIX, Config.SellIY, Config.SellIZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
            Citizen.Wait(0)
        else
            Citizen.Wait(1500)
        end
		
		if dist <= 2.5 then
            DT(Config.SellIX, Config.SellIY, 19.7087, "~b~[E]~w~ To Sell Iron")
		end

		if dist <= 2.5 then
			if IsControlJustPressed(1, 51) then
                local itemCount = exports["nadrp-inventory"]:getQuantity("iron")
                local cid = exports['nadrp-ped']:isPed('steamid')
                if itemCount > 0 and not trading then
                    trading = true
                    exports['t0sic_loadingbar']:StartDelayedFunction('Trading Iron', (math.random(40, 60) * 1000), function()
                        TriggerServerEvent('Ford:Iron', itemCount)
                        TriggerEvent('inventory:removeItem',"iron", itemCount) 
                        Wait(2000)
                        TriggerServerEvent("sendingItemstoClient", cid, PlayerId())
                        trading = false
                    end)
                else
                    exports['mythic_notify']:SendAlert('error', 'You dont have enough gold or you are currently selling')
                end
            end
        end
    end
end)

function Animation()
    Citizen.CreateThread(function()
        local ped = PlayerPedId()
        while impacts < 5 do
            Citizen.Wait(1)
            RequestAnimDict("melee@large_wpn@streamed_core")
            Citizen.Wait(100)
            TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
            SetEntityHeading(ped, 270.0)
            TriggerServerEvent('InteractSound_SV:PlayOnSource', 'pickaxe', 0.5)
            if impacts == 0 then
                pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true) 
                AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
            end  
            Citizen.Wait(2500)
            ClearPedTasks(ped)
            impacts = impacts+1
            if impacts == 5 then
                DetachEntity(pickaxe, 1, true)
                DeleteEntity(pickaxe)
                DeleteObject(pickaxe)
                mineActive = false
                impacts = 0
                --TriggerServerEvent("esx_miner:givestone")
                TriggerEvent("player:receiveItem","stone",5)
                exports['mythic_notify']:DoHudText('inform', 'You received stones.')
                break
            end
        end
    end)
end

function Washing()
    local ped = PlayerPedId()
    RequestAnimDict("amb@prop_human_bum_bin@idle_a")
    washingActive = true
    Citizen.Wait(100)
    FreezeEntityPosition(ped, true)
    TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    TriggerEvent("esx_miner:timer")
    Citizen.Wait(15900)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    washingActive = false
end

function Remelting()
    local ped = PlayerPedId()
    RequestAnimDict("amb@prop_human_bum_bin@idle_a")
    remeltingActive = true
    Citizen.Wait(100)
    FreezeEntityPosition(ped, true)
    TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    TriggerEvent("esx_miner:timer")
    Citizen.Wait(15900)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    remeltingActive = false
end


function DT(x,y,z)
	local text = "Press ~r~[E]~w~ to sell!"
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