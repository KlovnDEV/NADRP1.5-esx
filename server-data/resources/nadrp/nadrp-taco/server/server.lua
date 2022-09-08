ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('nadrp-taco:payTruckBill')
AddEventHandler('nadrp-taco:payTruckBill', function()
    local src = source
    local user = ESX.GetPlayerFromId(src)
    if user.source > 0 then
        if user.getMoney() >= 500 then
            user.removeMoney(500)
            TriggerClientEvent('nadrp-truck:requestTruck', user.source)
        else
            TriggerClientEvent('mythic_notify:client:DoLongHudText', user.source, {type = 'error', text = 'You don\'t have enough for another truck'})
        end
    end
end)
