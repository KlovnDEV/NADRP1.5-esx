ESX = nil

TriggerEvent('tac:getSharedObject', function(obj)
    ESX = obj
end)

RegisterServerEvent('ffrp-death:cpr')
AddEventHandler('ffrp-death:cpr', function(toPlayer)
    local user = ESX.GetPlayerFromId(source)
    if toPlayer ~= nil then
        if user.getMoney() >= 1500 then
            user.removeMoney(1500)
            TriggerClientEvent('ffrp-death:revive', toPlayer)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Do you really think this is free, come back when you have something to offer'})
        end
    end
end)