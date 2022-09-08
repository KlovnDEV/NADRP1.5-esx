ESX.RegisterUsableItem('joint', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem('joint')
    if item.count > 0 then
        TriggerClientEvent('RS7x:Smokeweed', source, false)
        xPlayer.removeInventoryItem('joint', 1)
        TriggerClientEvent('status:setState', source, 4, 400)
        TriggerClientEvent('status:setState', source, 3, 400)
        TriggerClientEvent('tac_status:remove','stress', 200000)
    else
        TriggerClientEvent('mythic_notify:client:DoLongHudText', xPlayer.source, { type = 'error', text = 'You dont have this item on you ?'})
    end
end)

ESX.RegisterUsableItem('blunt', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem('blunt')
    if item.count > 0 then
        TriggerClientEvent('RS7x:Smokeweed', source, true)
        xPlayer.removeInventoryItem('blunt', 1)
        TriggerClientEvent('status:setState', source, 4, 400)
        TriggerClientEvent('status:setState', source, 3, 400)
        TriggerClientEvent('tac_status:remove','stress', 400000)
    else
        TriggerClientEvent('mythic_notify:client:DoLongHudText', xPlayer.source, { type = 'error', text = 'You dont have this item on you ?'})
    end
end)

ESX.RegisterUsableItem('papers', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem('papers').count
    local item2 = xPlayer.getInventoryItem('trimmedweed').count
    if item >= 1 and item2 >= 1 then
        TriggerClientEvent('RS7x:Rolljoints', source, 'joints')
    else
        TriggerClientEvent('mythic_notify:client:DoLongHudText', xPlayer.source, { type = 'error', text = 'You dont have the items to do this ?'})
    end
end)

ESX.RegisterUsableItem('bread', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bread', 1)
	TriggerClientEvent('tac_status:add', source, 'hunger', 200000)
    TriggerClientEvent('RS7x:EatBread', source)
    TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'inform', text = 'You feel less hungry'})

end)

ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('water', 1)
	TriggerClientEvent('tac_status:add', source, 'thirst', 200000)
	TriggerClientEvent('RS7x:Drinkwater', source)
	TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'inform', text = 'You feel less thirsty' })
end)

ESX.RegisterUsableItem('beer', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('beer', 1)
	TriggerClientEvent('tac_status:add', source, 'drunk', 250000)
    TriggerClientEvent('RS7x:DrinkBeer', source)
    TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'inform', text = 'You feel less thirsty' })
end)

ESX.RegisterUsableItem('donut', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('donut', 1)
    TriggerClientEvent('tac_status:add', source, 'hunger', 200000)
    TriggerClientEvent('RS7x:EatDonut', source)
    TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'inform', text = 'You feel less hungry' })
end)

ESX.RegisterUsableItem('vodka', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('vodka', 1)
	TriggerClientEvent('tac_status:add', source, 'thirst', 200000)
    TriggerClientEvent('RS7x:DrinkVodka', source)
    TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'inform', text = 'You feel less thirsty' })
end)

ESX.RegisterUsableItem('coffee', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('coffee', 1)
	TriggerClientEvent('tac_status:add', source, 'thirst', 200000)
	TriggerClientEvent('RS7x:DrinkCoffee', source)
	TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'inform', text = 'You feel less thirsty' })

end)

ESX.RegisterUsableItem('cigarette', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local smoke = xPlayer.getInventoryItem('cigarette')

    xPlayer.removeInventoryItem('cigarette', 1)
    TriggerClientEvent('tac_cigarette:startSmoke', source)
    TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'inform', text = 'You feel less stressed' })
    --TriggerClientEvent('status:setState', source, 4, 400)
    --TriggerClientEvent('status:setState', source, 3, 400)
    TriggerClientEvent('tac_status:remove','stress', 400000)
end)

ESX.RegisterUsableItem('repairkit', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local chance = math.random(1,10)
    --if chance >= 7 then
    --    xPlayer.removeInventoryItem('repairkit',1)
    --end
    TriggerClientEvent('RS7x:OnRepair', source, false)
end)

ESX.RegisterUsableItem('repairkit1', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local chance = math.random(1,10)
    --if chance >= 7 then
    --    xPlayer.removeInventoryItem('repairkit1',1)
    --end
    TriggerClientEvent('RS7x:OnRepair', source, false)
end)

ESX.RegisterUsableItem('advrepairkit', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    --xPlayer.removeInventoryItem('advrepairkit',1)
    TriggerClientEvent('RS7x:OnRepair', source, true)
end)

ESX.RegisterUsableItem('securityblue', function(source)
    TriggerClientEvent('securitycard:OnUse', source, 'securityblue')
end)

ESX.RegisterUsableItem('securityblack', function(source)
    TriggerClientEvent('securitycard:OnUse', source, 'securityblack')
end)

ESX.RegisterUsableItem('securitygreen', function(source)
    TriggerClientEvent('securitycard:OnUse', source, 'securitygreen')
end)

ESX.RegisterUsableItem('securityred', function(source)
    TriggerClientEvent('securitycard:OnUse', source, 'securityred')
end)

ESX.RegisterUsableItem('securitygold', function(source)
    TriggerClientEvent('securitycard:OnUse', source, 'securitygold')
end)

ESX.RegisterUsableItem('decrypterred', function(source)
    TriggerClientEvent('fleeca:canDecrypt', source)
end)

ESX.RegisterUsableItem('advancedlockpick', function(source)
    TriggerClientEvent('stores:onUse', source)
end)

ESX.RegisterUsableItem('coke', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem('coke', 1)
    TriggerClientEvent('hadcocaine', _source)
end)

ESX.RegisterUsableItem('radio', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('Radio.Set', source, true)
	TriggerClientEvent('Radio.Toggle', source)
end)

ESX.RegisterUsableItem('coke_pooch', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem('coke_pooch', 1)
    TriggerClientEvent('hadcocaine', _source)
end)
