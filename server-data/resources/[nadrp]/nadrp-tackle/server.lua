
ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('server:tackle')
AddEventHandler('server:tackle', function(player)
    TriggerClientEvent('playerTackled', player)
end)

RegisterServerEvent('police:forceEnterAsk')
AddEventHandler('police:forceEnterAsk', function(player, id)
    TriggerClientEvent('police:forcedEnteringVeh', player, id)
end)

RegisterServerEvent('unseatAccepted')
AddEventHandler('unseatAccepted', function(ped, x, y, z)
    TriggerClientEvent('unseatPlayerFinish', ped,x,y,z)
end)