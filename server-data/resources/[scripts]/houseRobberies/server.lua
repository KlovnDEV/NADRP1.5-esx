local ESX = nil

--//////////////////////////////////
--  MAKE SURE ITEMS ARE ADDED
--  IN ORDER ADD ITEMS FROM
--  THE BOTTOM DOWN "[1] [2] [3]"
--//////////////////////////////////

local robbableItems = {
    [1] = {chance = 2, id = 0, name = 'Cash', quantity = math.random(1, 2000)}, -- really common
    [2] = {chance = 7, id = "453432689", name = "Pistol", isWeapon = true}, -- rare
    [3] = {chance = 5, id = "bandage", name = 'Bandage', quantity = math.random(1, 25)}, -- common
    [4] = {chance = 5, id = "beer", name = 'beer', quantity = math.random(1, 2)}, -- common
    [5] = {chance = 4, id = "lockpick", name = 'lockpick', quantity = math.random(1, 2)}, -- rare
    [6] = {chance= 9, id = "advlockpick", name = 'Multi-pick', quantity = 1}, -- rare
    [7] = {chance = 7, id = "cuffs", name = 'handcuffs', quantity = 1}, -- rare
    [8] = {chance = 7, id = "armor", name = 'Lottery Ticket', quantity = math.random(1, 5)}, -- common
    [9] = {chance = 7, id = "weedq", name = 'Bag of Weed', quantity = math.random(1, 3)},
    [10] = {chance = 5, id = "rollingpaper", name = 'Rolling Papers', quantity =  math.random(1, 3)},
    [11] = {chance = 5, id = "rolexwatch", name = 'Rolex', quantity = math.random(1, 5)},
    [12] = {chance = 6, id = "maleseed", name = 'Weed Seed Low Male', quantity = math.random(1,15)},
    [13] = {chance = 6, id = "2578778090", name = 'Combat knife', quantity = 1},
    [14] = {chance = 6, id = "femaleseed", name = 'Weed Seed Low Female', quantity = math.random(1,15)},
    [15] = {chance = 5, id = "decrypterenzo", name = 'Decrypter', quantity = 1},
    [16] = {chance = 9, id = "electronickit", name = 'Electronic Kit', quantity = 1},
    [17] = {chance = 4, id = "pistolammo", name = 'Pistol Ammo', quantity = math.random(1,3) },
    [18] = {chance = 6, id = "shotgunammo", name = 'Shotgun Ammo', quantity = math.random(1,3) },
    [19] = {chance = 4, id = "aluminium", name = 'Aluminium', quantity = math.random(5,15) },
    [20] = {chance = 4, id = "rubber", name = 'Rubber', quantity = math.random(5,15) },
    [21] = {chance = 4, id = "glass", name = 'Glass', quantity = math.random(5,15) },
    [22] = {chance = 4, id = "steel", name = 'Steel', quantity = math.random(5,15) },
    [23] = {chance = 4, id = "scrapmetal", name = 'Scrap Metal', quantity = math.random(5,15) },
    [24] = {chance = 4, id = "carbattery", name = 'Car Battery', quantity = math.random(10,15) },
    [25] = {chance = 10, id = "Gruppe6Card", name = 'Security Card', quantity = 1 },
    [26] = {chance = 7, id = "cashroll", name = 'Dirty Mular', math.random(1,5)},
    [27] = {chance = 9, id = "advrepairkit", name = 'Advanced Repair Kit', math.random(1,2)},
    [28] = {chance = 9, id = "1gcocaine", name = 'Cocaine', math.random(1,2)},
    [29] = {chance = 7, id = "weedoz", name = 'Weed Oz', math.random(1,2)},
    [30] = {chance = 5, id = "joint", name = 'Joints', math.random(1,5)},
    [31] = {chance = 5, id = "stolenraybans", name = 'Ray Bans', math.random(1,2)},
    [32] = {chance = 5, id = "stolens8", name = 'S8', math.random(1,2)},
    [33] = {chance = 5, id = "stolennokia", name = 'Nokia', math.random(1,2)},
    [34] = {chance = 5, id = "stoleniphone", name = 'Iphone', math.random(1,2)},
    [35] = {chance = 5, id = "stolengameboy", name = 'Gameboy', math.random(1,2)},
    [36] = {chance = 5, id = "stolencasiowatch", name = 'Casio', math.random(1,2)},
    [37] = {chance = 9, id = "stolen8ctchain", name = '8ct Chain', quantity = 1},
    [38] = {chance = 9, id = "stolen5ctchain", name = '5ct Chain',quantity = 1},
    [39] = {chance = 8, id = "stolen2ctchain", name = '2ct Chain',quantity = 1},
    [40] = {chance = 10, id = "stolen10ctchain", name = '10ctChain', quantity = 1},
    [41] = {chance = 5, id = "stoleffrpsp", name = 'PSP', quantity = 1},
    [42] = {chance = 10, id = "heavycutters", name = 'Heavy Cutters', quantity = 1},
    [43] = {chance = 9, id = "usbdevice", name = 'Usb', math.random(1,4)},
}

--[[chance = 1 is very common, the higher the value the less the chance]]--
-- 10 is max

TriggerEvent('tac:getSharedObject', function(obj)
    ESX = obj
end)

local CopsNeeded = 3
function CountCops()
	local xPlayers = ESX.GetPlayers()
	CopsConnected = 0
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            CopsConnected = CopsConnected + 1
        end
    end
    return CopsConnected
end

RegisterServerEvent('houseRobberies:attempt')
AddEventHandler('houseRobberies:attempt', function()
    local source = tonumber(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Cops = CountCops()
    if Cops >= CopsNeeded then
        TriggerClientEvent('houseRobberies:attempt', source)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "Not enough police" })
    end
end)

RegisterServerEvent('houseRobberies:removeLockpick')
AddEventHandler('houseRobberies:removeLockpick', function()
    local source = tonumber(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('inventory:removeItem',source, "lockpick", 1) 
    TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'The lockpick bent out of shape.'})
end)

RegisterServerEvent('houseRobberies:giveMoney')
AddEventHandler('houseRobberies:giveMoney', function()
    local source = tonumber(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local cash = math.random(500, 3000)
    xPlayer.addMoney(cash)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = 'You found $'..cash})
end)

function RandomItem()
    return robbableItems[math.random(#robbableItems)]
end

RegisterServerEvent('houseRobberies:searchItem')
AddEventHandler('houseRobberies:searchItem', function()
    local source = tonumber(source)
    local item = {}
    local xPlayer = ESX.GetPlayerFromId(source)
    local gotID = {}

    for i=1, math.random(1, 2) do
        item = RandomItem()

        if math.random(1, 10) >= item.chance then
            if item.id == 0 and not gotID[item.id] then
                gotID[item.id] = true
                xPlayer.addMoney(math.random(1, 2000))
                TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = 'You found $'..item.quantity})
            elseif item.isWeapon and not gotID[item.id] then
                gotID[item.id] = true
                TriggerClientEvent('player:receiveItem',source, item.id, item.quantity) 
                TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = 'Item Added!'})
            elseif not gotID[item.id] then
                gotID[item.id] = true
                TriggerClientEvent('player:receiveItem',source, item.id, item.quantity) 
                TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = 'Item Added!'})
            elseif gotID[item.id] then
                TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = "You didn't find anything here"})
            end
        end
    end
end)
