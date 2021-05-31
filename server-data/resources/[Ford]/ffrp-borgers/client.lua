ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local isCooking = false
local isPacking = false
local isSelling = false
local sleep = 2000
local isInMarker = false
local isInMarker2 = false
local blip = false
local whitelisted = {
    --27, -- Reece
    505,
    2659,
    1103,
    2073,
    1986,
    1124,
    1115,
    1098,
    2100,
    1091,
    1951,
    
 }
function DrawText3D(x, y, z, text)
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
        if #((GetEntityCoords(GetPlayerPed(-1)) - vector3(-1194.571, -892.789, 13.994))) < 1.5 then
            Citizen.Wait(0)
            DrawText3D(-1194.571, -892.789, 13.994, '[E] Counter')
            if IsControlJustReleased(0, 38) then
                TriggerEvent("server-inventory-open", "1", "counter-burgershot")
            end
        else
            Citizen.Wait(500)
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        if #((GetEntityCoords(GetPlayerPed(-1)) - vector3(-1193.64, -907.686, 12.777))) < 2.5 then
            Citizen.Wait(0)
            DrawText3D(-1193.64, -907.2, 14.2, '[E] Counter')
            if IsControlJustReleased(0, 38) then
                TriggerEvent("server-inventory-open", "1", "drivethru-burgershot")
            end
        else
            Citizen.Wait(500)
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        local sleep = 2000

        local player = PlayerPedId()
        local coords = GetBlipInfoIdCoord(blip)
        local playercoords = GetEntityCoords(player)
        local distance = GetDistanceBetweenCoords(playercoords, Config.CookingLocation.x, Config.CookingLocation.y, Config.CookingLocation.z, true)
        local distance2 = GetDistanceBetweenCoords(playercoords, -1202.528, -896.599, 13.995, true)
        local distance3 = GetDistanceBetweenCoords(playercoords, -1198.918, -901.8821, 13.9953 + 0.4, true)
        local distance5 = GetDistanceBetweenCoords(playercoords, coords[1], coords[2], coords[3], true)
        local distance6 = GetDistanceBetweenCoords(playercoords, Config.Fridge.x, Config.Fridge.y, Config.Fridge.z, true)
        local distance7 = GetDistanceBetweenCoords(playercoords, Config.CookFries.x, Config.CookFries.y, Config.CookFries.z, true)

      
        if distance < 0.5 then
            sleep = 7
            DrawText3D(Config.CookingLocation.x, Config.CookingLocation.y, Config.CookingLocation.z + 0.4, '~r~[E]~s~ - Cook Meat')
            if IsControlJustReleased(0, 38)  and isBsWhitelist() then
                MeatBurger()
            end
        end
        if distance2 < 0.5 then
            sleep = 7
            DrawText3D(-1202.528, -896.599, 13.995 + 0.4, '~r~[E]~s~ - Cook Veggie')
            if IsControlJustReleased(0, 38)  and isBsWhitelist() then
                VeggieBurger()
            end
        end
    
        if distance6 < 1 then
            sleep = 7
            DrawText3D(Config.Fridge.x, Config.Fridge.y, Config.Fridge.z + 0.4, '~r~[E]~s~ Fridge')
            if IsControlJustReleased(0, 38)  and isBsWhitelist() then
                fridge()
            end
        end

        if distance7 < 1 then
            sleep = 7
            DrawText3D(Config.CookFries.x, Config.CookFries.y, Config.CookFries.z + 0.4, '~r~[E]~s~ - Cook Fries')
            if IsControlJustReleased(0, 38)  and isBsWhitelist() then
                Fries()
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function() 
    while true do
        if #((GetEntityCoords(PlayerPedId()) - vector3(-1198.918, -901.8821, 13.99531))) < 1.0 then
            Citizen.Wait(0)
            DrawText3D(-1198.918, -901.8821, 13.99531, '~r~[E]~s~ Make Burgers')
            if IsControlJustReleased(0, 38) and isBsWhitelist() then
                TriggerEvent("server-inventory-open", "12", "Craft")
            end
        else
            Citizen.Wait(100)
         end
    end
end)


function Fries()
    local itemCount = exports["ffrp-inventory"]:getQuantity("frozenfries")
    if exports["ffrp-inventory"]:hasEnoughOfItem("frozenfries",1,false) and isBsWhitelist() then
        isCooking = true
        local player = PlayerPedId()
        TaskStartScenarioInPlace(player, 'PROP_HUMAN_BBQ', 0, true)
        local finished = exports["ffrp-skillbar"]:taskBar(5000,math.random(5,15))
        if finished ~= 100 then
            isCooking = false
            ClearPedTasksImmediately(player)
            exports['mythic_notify']:SendAlert('error', 'Be a better Chef 4Head')
        else
            local finished2 = exports["ffrp-skillbar"]:taskBar(4750,math.random(5,15))
            if finished2 ~= 100 then
                isCooking = false
                ClearPedTasksImmediately(player)
                exports['mythic_notify']:SendAlert('error', 'Be a better Chef 4Head')
            else
                local finished3 = exports["ffrp-skillbar"]:taskBar(4500,math.random(5,15))
                if finished3 ~= 100 then
                    isCooking = false
                    ClearPedTasksImmediately(player)
                    exports['mythic_notify']:SendAlert('error', 'Be a better Chef 4Head')
                else
                    TriggerEvent('inventory:removeItem',"frozenfries", 1) 
                    TriggerEvent("player:receiveItem","fries",1)
                    isCooking = false
                    ClearPedTasksImmediately(player)
                end
            end
        end
    end
end


function MeatBurger()
        local ped = PlayerPedId()
        local itemCount = exports["ffrp-inventory"]:getQuantity("patty")
        if exports["ffrp-inventory"]:hasEnoughOfItem("patty",1,false) then
            isCooking = true
            local player = PlayerPedId()
            TaskStartScenarioInPlace(player, 'PROP_HUMAN_BBQ', 0, true)
            local finished = exports["ffrp-skillbar"]:taskBar(5000,math.random(5,15))
            if finished ~= 100 then
                isCooking = false
                ClearPedTasksImmediately(player)
                exports['mythic_notify']:SendAlert('error', 'Be a better Chef 4Head')
            else
                local finished2 = exports["ffrp-skillbar"]:taskBar(4750,math.random(5,15))
                if finished2 ~= 100 then
                    isCooking = false
                    ClearPedTasksImmediately(player)
                    exports['mythic_notify']:SendAlert('error', 'Be a better Chef 4Head')
                else
                    local finished3 = exports["ffrp-skillbar"]:taskBar(4500,math.random(5,15))
                    if finished3 ~= 100 then
                        isCooking = false
                        ClearPedTasksImmediately(player)
                        exports['mythic_notify']:SendAlert('error', 'Be a better Chef 4Head')
                    else
                    -- local finished = exports['ffrp-taskbar']:taskBar(10000, 'Cooking')
                    -- if finished ==  100 then
                        TriggerEvent('inventory:removeItem',"patty", 1) 
                        TriggerEvent("player:receiveItem","cookedpatty",1)
                        isCooking = false
                        ClearPedTasksImmediately(player)
                        --end
                end
            end
        end
    end
end

function VeggieBurger()
    local ped = PlayerPedId()
    local itemCount = exports["ffrp-inventory"]:getQuantity("patty")
    if exports["ffrp-inventory"]:hasEnoughOfItem("patty",1,false) then
        isCooking = true
        local player = PlayerPedId()
        TaskStartScenarioInPlace(player, 'PROP_HUMAN_BBQ', 0, true)
        local finished = exports["ffrp-skillbar"]:taskBar(5000,math.random(5,15))
        if finished ~= 100 then
            isCooking = false
            ClearPedTasksImmediately(player)
            exports['mythic_notify']:SendAlert('error', 'Be a better Chef 4Head')
        else
            local finished2 = exports["ffrp-skillbar"]:taskBar(4750,math.random(5,15))
            if finished2 ~= 100 then
                isCooking = false
                ClearPedTasksImmediately(player)
                exports['mythic_notify']:SendAlert('error', 'Be a better Chef 4Head')
            else
                local finished3 = exports["ffrp-skillbar"]:taskBar(4500,math.random(5,15))
                if finished3 ~= 100 then
                    isCooking = false
                    ClearPedTasksImmediately(player)
                    exports['mythic_notify']:SendAlert('error', 'Be a better Chef 4Head')
                else
                -- local finished = exports['ffrp-taskbar']:taskBar(10000, 'Cooking')
                -- if finished ==  100 then
                    TriggerEvent('inventory:removeItem',"patty", 1) 
                    TriggerEvent("player:receiveItem","cookedvpatty",1)
                    isCooking = false
                    ClearPedTasksImmediately(player)
                    --end
            end
        end
    end
end
end

-- function Package()
--     local itemCount = exports["ffrp-inventory"]:getQuantity("frozenfries")
--     if exports["ffrp-inventory"]:hasEnoughOfItem("frozenfries",1,false) then
--         TriggerEvent('inventory:removeItem',"frozenfries", 1) 
--         TriggerEvent("player:receiveItem","fries",1)
--         ClearPedTasksImmediately(player)
--     end
-- end



function isBsWhitelist()
    local cid = exports['ffrp-ped']:isPed('cid')
    for i=1, #whitelisted do
        if whitelisted[i] == cid then
            return true
        end
    end
    return false
end

function cookburger()
	local elements ={  
        { label = 'Meat', value = 'burger'},
        { label = 'Veggie', value = 'veggie'},
        
        }
        
        ESX.UI.Menu.CloseAll() 
        ESX.UI.Menu.Open('default', GetCurrentResourceName(),'burger',{
            title = 'What Patty?', 
            align = 'top-right',
            elements = elements  
        }, function(data, menu)
        
        if data.current.value == 'burger' then 
            menu.close()
        elseif data.current.value == 'veggie' then
            menu.close()
            local ped = PlayerPedId()
            local itemCount = exports["ffrp-inventory"]:getQuantity("patty")
            if exports["ffrp-inventory"]:hasEnoughOfItem("patty",1,false) then
                isCooking = true
                local player = PlayerPedId()
                TaskStartScenarioInPlace(player, 'PROP_HUMAN_BBQ', 0, true)
                local finished = exports["ffrp-skillbar"]:taskBar(5000,math.random(5,15))
                if finished ~= 100 then
                    isCooking = false
                    ClearPedTasksImmediately(player)
                    exports['mythic_notify']:SendAlert('error', 'Be a better Chef 4Head')
                else
                    local finished2 = exports["ffrp-skillbar"]:taskBar(4750,math.random(5,15))
                    if finished2 ~= 100 then
                        isCooking = false
                        ClearPedTasksImmediately(player)
                        exports['mythic_notify']:SendAlert('error', 'Be a better Chef 4Head')
                    else
                        local finished3 = exports["ffrp-skillbar"]:taskBar(4500,math.random(5,15))
                        if finished3 ~= 100 then
                            isCooking = false
                            ClearPedTasksImmediately(player)
                            exports['mythic_notify']:SendAlert('error', 'Be a better Chef 4Head')
                        else
                            TriggerEvent('inventory:removeItem',"patty", 1) 
                            TriggerEvent("player:receiveItem","cookedvpatty",1)
                            isCooking = false
                            ClearPedTasksImmediately(player)
                        end
                    end
                end
            end

        end
    
    end, function(data, menu)
        menu.close()
        TriggerEvent('notification', 'Yapmaktan vazgeçtin!', 2, 2000)
        ClearPedTasks(player)
        FreezeEntityPosition(player,false)
    end, function(data, menu)
    end)
    end
  
function fridge()

	local elements ={  
    { label = 'Bun', value = 'bread'},
    { label = 'Ketchup', value = 'ketchup'},
    { label = 'Mayonnaise', value = 'mayonnaise'},
    { label = 'Lettuce', value = 'lettuce'},
    { label = 'Cheddar', value = 'cheddar'},
    { label = 'Fries', value = 'fries'},
    { label = 'Patty', value = 'patty'},
    { label = 'Ingredients', value = 'ingr'},
	}
	
	ESX.UI.Menu.CloseAll() 
	ESX.UI.Menu.Open('default', GetCurrentResourceName(),'burger',{
		title = 'Which burger do you want to make?', 
		align = 'top-right',
		elements = elements  
	
	}, function(data, menu)
	
	if data.current.value == 'bread' then 
		menu.close()
		local ped = PlayerPedId()
        TriggerEvent("player:receiveItem","bun",1)
    elseif data.current.value == 'ketchup' then
        menu.close()
		local ped = PlayerPedId()
        TriggerEvent("player:receiveItem","ketchup",1)
    elseif data.current.value == 'mayonnaise' then
        menu.close()
        TriggerEvent("player:receiveItem","mayo",1)
    elseif data.current.value == 'lettuce' then
        menu.close()
        TriggerEvent("player:receiveItem","lettuce",1)
    elseif data.current.value == 'cheddar' then
        menu.close()
        TriggerEvent("player:receiveItem","cheddar",1)
    elseif data.current.value == 'fries' then
        menu.close()
		local ped = PlayerPedId()
        TriggerEvent("player:receiveItem","frozenfries",1)
    elseif data.current.value == 'patty' then
        menu.close()
		local ped = PlayerPedId()
        TriggerEvent("player:receiveItem","patty",1)
    elseif data.current.value == 'ingr' then
        menu.close()
		local ped = PlayerPedId()
        TriggerEvent("player:receiveItem","foodingredient",1)
	end

end, function(data, menu)
	menu.close()
	ClearPedTasks(player)
	FreezeEntityPosition(player,false)
end, function(data, menu)
end)
end

