ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('carry:sync')
AddEventHandler('carry:sync', function(target)
	TriggerClientEvent('carry:syncTarget', target, source)
	TriggerClientEvent('carry:syncMe', source)
end)

RegisterServerEvent('carry:stop')
AddEventHandler('carry:stop', function(target)
	TriggerClientEvent('carry:stop', target)
end)
