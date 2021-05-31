ESX = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('ffrp-casino:buyChips')
AddEventHandler('ffrp-casino:buyChips', function(amount)
    local user = ESX.GetPlayerFromId(source)
    local cash = user.getMoney()
    if cash >= amount then
        user.removeMoney(amount)
        user.addChips(amount)
        TriggerClientEvent('ffrp-notify:ShowAlert', user.source, {text = 'Purchased '..amount.. ' chip(s)', type="success", duration=2500})
    else
        TriggerClientEvent('ffrp-notify:ShowAlert', user.source, {text = 'You dont have enough money! ($1 per chip)', type="error", duration=2500})
    end
end)

RegisterNetEvent('ffrp-casino:sellChips')
AddEventHandler('ffrp-casino:sellChips', function(amount)
    local user = ESX.GetPlayerFromId(source)
    local chips = user.getChips()
    if chips >= amount then
        user.removeChips(amount)
        user.addMoney(amount)
        TriggerClientEvent('ffrp-notify:ShowAlert', user.source, {text = 'You sold '..amount.. ' chip(s)', type="success", duration=2500})
    else
        TriggerClientEvent('ffrp-notify:ShowAlert', user.source, {text = 'You dont have enough chips!', type="error", duration=2500})
    end
end)

RegisterCommand('givechips', function(source, args)
    local user = ESX.GetPlayerFromId(source)
    local chips = user.addChips(tonumber(args[1]))
    print(user.getChips())
end)