ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("carfill:checkmoney")
AddEventHandler("carfill:checkmoney", function(costs,loc)
    local src = source
    local target = ESX.GetPlayerFromId(src)

    if not costs then
        costs = 0
    end

    if target.getMoney() >= costs then
        target.removeMoney(costs)
        TriggerClientEvent("RefuelCarServerReturn", src)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'You need $' .. costs})
    end
end)