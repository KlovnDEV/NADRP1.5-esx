ESX = nil

TriggerEvent('tac:getSharedObject', function(obj)
    ESX = obj
end)

RegisterServerEvent('nadrp-death:cpr')
AddEventHandler('nadrp-death:cpr', function(toPlayer)
    local user = ESX.GetPlayerFromId(source)
    if toPlayer ~= nil then
        if user.getMoney() >= 1500 then
            user.removeMoney(1500)
            TriggerClientEvent('nadrp-death:revive', toPlayer)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Do you really think this is free, come back when you have something to offer'})
        end
    end
end)