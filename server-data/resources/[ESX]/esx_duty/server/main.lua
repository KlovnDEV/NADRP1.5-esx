ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('duty:onoff')
AddEventHandler('duty:onoff', function(job)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    local labal = xPlayer.job.label

    local name = getIdentity(_source)
    fal = name.firstname .. " " .. name.lastname
    
    if job == 'police' or job == 'ambulance' or job == 'mecano' then
        xPlayer.setJob('off' ..job, grade)
        TriggerClientEvent('tac:showNotification', _source, _U('offduty'))

        TriggerClientEvent('chat:addMessage', _source, { template = '<div class="chat-message system"><b>Services {0} : </b> {1}</div>', args = { fal, "is now Off Duty as "..labal  } })

    elseif job == 'offpolice' then
        xPlayer.setJob('police', grade)
        TriggerClientEvent('tac:showNotification', _source, _U('onduty'))

        TriggerClientEvent('chat:addMessage', _source, { template = '<div class="chat-message system"><b>Services {0} : </b> {1}</div>', args = { fal, "is now On Duty as LSPD" } })
    elseif job == 'offambulance' then
        xPlayer.setJob('ambulance', grade)
        TriggerClientEvent('tac:showNotification', _source, _U('onduty'))

        TriggerClientEvent('chat:addMessage', _source, { template = '<div class="chat-message system"><b>Services {0} : </b> {1}</div>', args = { fal, "is now On Duty as Paramedic" } })
    elseif job == 'offmecano' then
        xPlayer.setJob('mecano', grade)
        TriggerClientEvent('tac:showNotification', _source, _U('onduty'))

        TriggerClientEvent('chat:addMessage', _source, { template = '<div class="chat-message system"><b>Services {0} : </b> {1}</div>', args = { fal, "is now On Duty as AA Mechanic" } })
    end
end)

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