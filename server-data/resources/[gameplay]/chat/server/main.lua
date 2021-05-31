-- StarBlazt Chat

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)


function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT identifier,name,firstname,lastname,dateofbirth,sex,height,job FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]
		return {
			identifier = identity['identifier'],
			name = identity['name'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height'],
			job = identity['job'],
		}
	else
		return nil
	end
end



AddEventHandler("chatMessage", function(source, color, message)
    local src = source
    args = stringsplit(message, " ")
    CancelEvent()
    if string.find(args[1], "/") then
        local cmd = args[1]
        table.remove(args, 1)
    end
end)

RegisterServerEvent('chat:server:ServerPSA')
AddEventHandler('chat:server:ServerPSA', function(message)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message server">SERVER: {0}</div>',
        args = { message }
    })
    CancelEvent()
end)


RegisterServerEvent('911')
AddEventHandler('911', function(source, caller, msg, x, y,z)
    local name = getIdentity(source)
    fal = name.firstname  .. '  ' .. name.lastname
    TriggerClientEvent('chat:EmergencySend911', -1, source, fal, msg, x, y, z)
    TriggerEvent('mdt:newCall', msg, fal, vector3(x,y,z))
end)

RegisterServerEvent('311')
AddEventHandler('311', function(source, caller, msg)
    local name = getIdentity(source)
    fal = name.firstname  .. '  ' .. name.lastname
    TriggerClientEvent('chat:EmergencySend311', -1, source, fal, msg)
end)


RegisterServerEvent('911r')
AddEventHandler('911r', function(target, source, msg)
    local name = getIdentity(source)
    fal = name.firstname  .. '  ' .. name.lastname
    TriggerClientEvent('chat:EmergencySend911r', -1, source, fal, msg)
end)

RegisterServerEvent('311r')
AddEventHandler('311r', function(target, source, msg)
    local name = getIdentity(source)
    fal = name.firstname  .. '  ' .. name.lastname
    TriggerClientEvent('chat:EmergencySend311r', -1, source, fal, msg)
end)

RegisterServerEvent('chat:server:911source')
AddEventHandler('chat:server:911source', function(source, caller, msg)
    local name = getIdentity(source)
	fal = name.firstname .. "  " .. name.lastname
    TriggerClientEvent('chat:addMessage', source, {
        template = '<div class="chat-message emergency">911 {0} ({1}): {2} </div>',
        args = { fal, caller, msg }
    })
    CancelEvent()
end)

RegisterServerEvent('chat:server:911r')
AddEventHandler('chat:server:911r', function(target, caller, msg)
    local name = getIdentity(source)
	fal = name.firstname .. "  " .. name.lastname
    TriggerClientEvent('chat:addMessage', target, {
        template = '<div class="chat-message emergency">911r {0} : {1} </div>',
        args = { fal, msg }
    })
    CancelEvent()
end)

RegisterServerEvent('chat:server:311r')
AddEventHandler('chat:server:311r', function(target, caller, msg)
    local name = getIdentity(source)
	fal = name.firstname .. "  " .. name.lastname
    TriggerClientEvent('chat:addMessage', target, {
        template = '<div class="chat-message nonemergency">311r {0}: {1} </div>',
        args = { fal, msg }
    })
    CancelEvent()
end)


RegisterServerEvent('chat:server:311source')
AddEventHandler('chat:server:311source', function(source, caller, msg)
    local name = getIdentity(source)
	fal = name.firstname .. "  " .. name.lastname
    TriggerClientEvent('chat:addMessage', source, {
        template = '<div class="chat-message nonemergency">311 {0} ({1}): {2} </div>',
        args = { fal, caller, msg }
    })
    CancelEvent()
end)

RegisterServerEvent('mechanic')
AddEventHandler('mechanic', function(source, caller, msg, x, y,z)
    local name = getIdentity(source)
    fal = name.firstname  .. '  ' .. name.lastname
    TriggerClientEvent('chat:EmergencySendMechanic', -1, source, fal, msg, x, y, z)
end)
RegisterServerEvent('mecr')
AddEventHandler('mecr', function(target, source, msg)
    local name = getIdentity(source)
    fal = name.firstname  .. '  ' .. name.lastname
    TriggerClientEvent('chat:EmergencySendmecr', -1, source, fal, msg)
end)

RegisterServerEvent('chat:server:mecsource')
AddEventHandler('chat:server:mecsource', function(source, caller, msg)
    local name = getIdentity(source)
	fal = name.firstname .. "  " .. name.lastname
    TriggerClientEvent('chat:addMessage', source, {
        template = '<div class="chat-message nonemergency">[MECHANIC CALL] {0} ({1}): {2} </div>',
        args = { fal, caller, msg }
    })
    CancelEvent()
end)
RegisterServerEvent('chat:server:mecr')
AddEventHandler('chat:server:mecr', function(target, caller, msg)
    local name = getIdentity(source)
	fal = name.firstname .. "  " .. name.lastname
    TriggerClientEvent('chat:addMessage', target, {
        template = '<div class="chat-message nonemergency">[MECHANIC REPLY]: {0} : {1} </div>',
        args = { fal, msg }
    })
    CancelEvent()
end)

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

RegisterServerEvent('chat:server:ServerPSA')
AddEventHandler('chat:server:ServerPSA', function(message)
    TriggerClientEvent('chat:addMessages', -1, {
        template = '<div class="chat-message server">SERVER: {0}</div>',
        args = { message }
    })
    CancelEvent()
end)

RegisterServerEvent('chat:ooc')
AddEventHandler('chat:ooc', function(msg, name)
    local src = source
    if name ~= nil then
        fal = name.firstname .. "  " .. name.lastname
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div class="chat-message"><b>OOC {0} ['..src..'] : </b> {1}</div>',
            args = {fal, msg}
        })
    end
end)