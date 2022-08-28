ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

--local goods = {
--    [1] = {["item"] = 'rolex', ["payment"] = math.random(200, 500)},
--    [2] = {["item"] = 'valuable_goods', ["payment"] = math.random(1000, 2000)},  
--}


RegisterServerEvent('RS7x:RequestRun')
AddEventHandler('RS7x:RequestRun', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= 100 then
        xPlayer.removeMoney(100)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Paid $100 Go await for the gps location'})
        TriggerClientEvent('RS7x:StartRun', source)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You dont have enough money'})
    end
end)

RegisterServerEvent('RS7x:RequestPay')
AddEventHandler('RS7x:RequestPay', function(item)
    TriggerClientEvent('RS7x:DoDropOff', source)
end)


RegisterServerEvent('RS7x:payout')
AddEventHandler('RS7x:payout', function(name, itemCount)
    local xPlayer = ESX.GetPlayerFromId(source)

    if name == 'rolexwatch' then
        itemprice = math.random(320,370)
    elseif name == 'valuablegoods' then
        itemprice = math.random(400,600)
    elseif name == 'stolenraybans' then
        itemprice = math.random(50,75)
    elseif name == 'stolens8' then
        itemprice = math.random(100,125)
    elseif name == 'stolennokia' then
        itemprice = math.random(50,75)
    elseif name == 'stoleniphone' then
        itemprice = math.random(100,125)
    elseif name == 'stolengameboy' then
        itemprice = math.random(65,75)
    elseif name == 'stolencasiowatch' then
        itemprice = math.random(65,75)
    elseif name == 'stolen8ctchain' then
        itemprice = math.random(125,150)
    elseif name == 'stolen5ctchain' then
        itemprice = math.random(100,105)
    elseif name == 'stolen2ctchain' then
        itemprice = math.random(50,75)
    elseif name == 'stolen10ctchain' then
        itemprice = math.random(150,175)
    elseif name == 'stolenadrpsp' then
        itemprice = math.random(60,80)
    end

    local rand = math.random(1,3)
    if tonumber(itemCount) >= tonumber(rand) then
        TriggerClientEvent('inventory:removeItem',source, name, rand)
        xPlayer.addMoney(itemprice * rand)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You just got $' .. itemprice * rand})
    elseif tonumber(itemCount) == 1 then
        TriggerClientEvent('inventory:removeItem',source, name, 1)
        xPlayer.addMoney(itemprice)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You just got $' .. itemprice})
    else
        TriggerClientEvent('RS7x:failed', source, true)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'The drop off failed - You dont have any stolen goods'})
    end
end)

--[[RegisterServerEvent('RS7x:payout')
AddEventHandler('RS7x:payout', function(name)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Iamount = exports['nadrp-inventory']:hasEnoughOfItem(name).count
    if name == 'rolex' then
        itemprice = math.random(320,370)
    elseif name == 'valuable_goods' then
        itemprice = math.random(400,600)
    elseif name == 'jewels' then
        itemprice = math.random(100, 250)
    elseif name == 'goldNecklace' then
        itemprice = math.random(450, 600)
    end

    local amount = math.random(1,3)
    if Iamount >= amount then
       -- xPlayer.removeInventoryItem(name, amount)
        TriggerClientEvent('inventory:removeItem',source, name, amount) 
        xPlayer.addMoney(itemprice * amount)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You just got $' .. itemprice * amount})
    elseif Iamount == 1 then 
       -- xPlayer.removeInventoryItem(name, 1)
        TriggerClientEvent('inventory:removeItem',source, name, 1) 
        xPlayer.addMoney(itemprice)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You just got $' .. itemprice})
    else
        TriggerClientEvent('RS7x:failed', source, true)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'The drop off failed - You dont have any stolen goods'})
    end
end)

RegisterServerEvent('RS7x:ItemCheck')
AddEventHandler('RS7x:ItemCheck', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer ~= nil then
        local rolex = exports['nadrp-inventory']:hasEnoughOfItem("rolex").count
        if rolex >= 1 then
            TriggerClientEvent('RS7x:check', source, 'rolex')
            return
        end

        local valuable_goods = exports['nadrp-inventory']:hasEnoughOfItem("valuablegods").count
        if valuable_goods >= 1 then
            TriggerClientEvent('RS7x:check', source, 'valuablegoods')
            return
        end

        local jewels = exports['nadrp-inventory']:hasEnoughOfItem("jewels").count
        if jewels >= 1 then
            TriggerClientEvent('RS7x:check', source, 'jewels')
            return
        end

        local goldNecklace = exports['nadrp-inventory']:hasEnoughOfItem("goldNecklace").count
        if goldNecklace >= 1 then
            TriggerClientEvent('RS7x:check', source, 'goldNecklace')
            return
        end
        TriggerClientEvent('RS7x:check', source, false)
    end
end)]]