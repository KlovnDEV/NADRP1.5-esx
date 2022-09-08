ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

-- OLD INVENTORY CRAFTING

--[[local craftTable = {
    [1] = {["name"] = 'lockpick', ["recipe"] = {["item1"] = {["name"] = 'aluminum', ["amount"] = 10}, ["item2"] = {["name"] = 'rubber', ["amount"] = 5}}, ["craftTime"] = 15000},
    [2] = {["name"] = 'handcuffs', ["recipe"] = {["item1"] = {["name"] = 'scrap-metal', ["amount"] = 10}, ["item2"] = {["name"] = 'scrap-metal', ["amount"] = 10}}, ["craftTime"] = 20000},
    [3] = {["name"] = 'repairkit', ["recipe"] = {["item1"] = {["name"] = 'scrap-metal', ["amount"] = 7}, ["item2"] = {["name"] = 'aluminum', ["amount"] = 5}}, ["craftTime"] = 25000},
    [4] = {["name"] = 'advrepairkit', ["recipe"] = {["item1"] = {["name"] = 'plastic', ["amount"] = 5}, ["item2"] = {["name"] = 'aluminum', ["amount"] = 10}}, ["craftTime"] = 30000}
}

local itemfound = false
local isCrafting = false
RegisterServerEvent('RS7x:recipe')
AddEventHandler('RS7x:recipe', function(item) --// chat message for Recipe when command is used
    if item == nil then
        TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'error', text = 'Invalid Item' })
        return
    else
        if item == 'lockpick' then
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div class="chat-message nonemergency">Recipe: (' .. firstToUpper(item) ..') | {0} </div>',
                args = {"10x Aluminum, 5x Rubber"}
            })
        elseif item == 'handcuffs' then
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div class="chat-message nonemergency">Recipe: (' .. firstToUpper(item) ..') | {0} </div>',
                args = {"20x Scrap-Metal"}
            })
        elseif item == 'repairkit' then
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div class="chat-message nonemergency">Recipe: (' .. firstToUpper(item) ..') | {0} </div>',
                args = {"7x Scrap-Metal 5x Aluminum"}
            })
        elseif item == 'advrepairkit' then
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div class="chat-message nonemergency">Recipe: (' .. firstToUpper(item) ..') | {0} </div>',
                args = {"5x Plastic 10x Aluminum"}
            })
        end
    end
end)

RegisterServerEvent('RS7x:craft')
AddEventHandler('RS7x:craft', function(item)
    if item == nil then
        TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'error', text = 'Invalid Item' })
        return
    else
        if isCrafting then
            TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'error', text = 'Already Crafting' })
            return
        end

        local xPlayer = ESX.GetPlayerFromId(source)
        isCrafting = true
        for i=1, #craftTable, 1 do
            if item == craftTable[i]["name"] then
                local recipe = craftTable[i]["recipe"]
                local item1 = recipe["item1"]["name"]
                local item2 = recipe["item2"]["name"]

                if xPlayer.getInventoryItem(item1).count >= recipe["item1"]["amount"] and xPlayer.getInventoryItem(item2).count >= recipe["item2"]["amount"] then
                    TriggerClientEvent('progBar', source, 'Crafting ' .. craftTable[i]["name"], craftTable[i]["craftTime"])
                    Citizen.Wait(craftTable[i]["craftTime"])
                    xPlayer.removeInventoryItem(item1, recipe["item1"]["amount"])
                    xPlayer.removeInventoryItem(item2, recipe["item2"]["amount"])
                    xPlayer.addInventoryItem(craftTable[i]["name"], 1)
                    isCrafting = false
                else
                    TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'error', text = 'You dont have the right materials to craft this' })
                    isCrafting = false
                end
            else
                isCrafting = false
            end
        end
    end
end)

RegisterServerEvent('removeRepairkit')
AddEventHandler('removeRepairkit', function(adv)
    local xPlayer = ESX.GetPlayerFromId(source)
    if adv then
        xPlayer.removeInventoryItem('advrepairkit', 1)
    else
        local chance = math.random(1,10)
        if chance == 7 then
            xPlayer.removeInventoryItem('repairkit', 1)
        end
    end
end)

local items = {}
RegisterCommand('listCraft', function(source, args, raw)
    for i=1, #craftTable do
        local name = ' [' .. i .. '] : ' .. craftTable[i]["name"] .. ' '
        table.insert(items, name)
    end

    TriggerClientEvent('chat:addMessage', source, {
        template = '<div class="chat-message nonemergency">Name: | {0} </div>',
        args = {items}
    })
    items = nil
end)]]

RegisterCommand('hire', function(source, args, raw)
    local PlayerData = ESX.GetPlayerFromId(source)
    if PlayerData.job.name == 'mechanic' and PlayerData.job.grade_name == 'boss' then
        if tonumber(args[1]) then
            local xPlayer = ESX.GetPlayerFromId(args[1])
  
            if xPlayer then
                if ESX.DoesJobExist('mechanic', 0) then
                    xPlayer.setJob('mechanic', 0)
                end
            end
        end
    end
end)

RegisterCommand('promote', function(source, args, raw)
    local PlayerData = ESX.GetPlayerFromId(source)
    if PlayerData.job.name == 'mechanic' and PlayerData.job.grade_name == 'boss' then
        if tonumber(args[1]) and tonumber(args[2]) then
            local xPlayer = ESX.GetPlayerFromId(args[1])
            if xPlayer then
                if ESX.DoesJobExist('mechanic', args[2]) then
                    xPlayer.setJob('mechanic', args[2])
                end
            end
        end
    end
end)


RegisterCommand('hireEMS', function(source, args, raw)
    local PlayerData = ESX.GetPlayerFromId(source)
    if PlayerData.job.name == 'ambulance' and PlayerData.job.grade_name == 'boss' then
        if tonumber(args[1]) then
            local xPlayer = ESX.GetPlayerFromId(args[1])
  
            if xPlayer then
                if ESX.DoesJobExist('ambulance', 0) then
                    xPlayer.setJob('ambulance', 0)
                end
            end
        end
    end
end)

RegisterCommand('promoteEMS', function(source, args, raw)
    local PlayerData = ESX.GetPlayerFromId(source)
    if PlayerData.job.name == 'ambulance' and PlayerData.job.grade_name == 'boss' then
        if tonumber(args[1]) and tonumber(args[2]) then
            local xPlayer = ESX.GetPlayerFromId(args[1])
            if xPlayer then
                if ESX.DoesJobExist('ambulance', args[2]) then
                    xPlayer.setJob('ambulance', args[2])
                end
            end
        end
    end
end)

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end