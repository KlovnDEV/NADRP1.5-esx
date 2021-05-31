TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT identifier,firstname,lastname,dateofbirth,sex,height FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]
		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
		}
	else
		return nil
	end
end


--[[ COMMANDS ]]--

RegisterCommand('clear', function(source, args, rawCommand)
    TriggerClientEvent('chat:client:ClearChat', source)
end, false)

--[[RegisterCommand('clearall', function(source, args, rawCommand)
    TriggerClientEvent('chat:client:ClearChat', -1)
end, false)]]

--[[RegisterCommand('ooc', function(source, args, rawCommand)
	local msg = rawCommand:sub(4)
	local name = getIdentity(source)
	TriggerClientEvent('chat:AttemptChat', source, msg, name)
end, false)]]