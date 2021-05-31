local ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) 
    ESX = obj 
end)

TriggerEvent('es:addGroupCommand', 'tpm', 'admin', function(source, args, user)
	TriggerClientEvent('tac:tpm', source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'tp to waypoint'})