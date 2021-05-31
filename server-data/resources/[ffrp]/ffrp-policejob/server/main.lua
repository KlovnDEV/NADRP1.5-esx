ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
end)

RegisterServerEvent('ffrp-policejob:reference')
AddEventHandler('ffrp-policejob:reference', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent("ffrp-policejob:addBlip", -1, tonumber(_source))
	else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error', text = 'You are not police'})
	end
end)

RegisterNetEvent('ffrp-policejob:drag')
AddEventHandler('ffrp-policejob:drag', function(target)
	TriggerClientEvent('ffrp-policejob:drag', target, source)
end)

RegisterServerEvent('ffrp-policejob:resetDrag')
AddEventHandler('ffrp-policejob:resetDrag', function(target)
	TriggerClientEvent('ffrp-policejob:resetDrag', target, source)
end)

RegisterServerEvent('ffrp-policejob:handcuff')
AddEventHandler('ffrp-policejob:handcuff', function(target)
    TriggerClientEvent('ffrp-policejob:handcuff', target)
end)

RegisterServerEvent('ffrp-policejob:requestarrest')
AddEventHandler('ffrp-policejob:requestarrest', function(isCommand, targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    if not isCommand then
        TriggerClientEvent('ffrp-policejob:getarrested', targetid, false,playerheading, playerCoords, playerlocation)
        TriggerClientEvent('ffrp-policejob:doarrested', _source)
    else
        if GetPlayerName(targetid) ~= nil then
            TriggerClientEvent('ffrp-policejob:getarrested', targetid, true)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = 'Invalid playerid'})
        end
    end
end)

RegisterServerEvent('ffrp-policejob:requestrelease')
AddEventHandler('ffrp-policejob:requestrelease', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('ffrp-policejob:getuncuffed', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('ffrp-policejob:douncuffing', _source)
end)

RegisterServerEvent('ffrp-policejob:sc')
AddEventHandler('ffrp-policejob:sc', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('ffrp-policejob:loose', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('ffrp-policejob:douncuffing', _source)
end)

RegisterServerEvent('ffrp-policejob:requesthard')
AddEventHandler('ffrp-policejob:requesthard', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('ffrp-policejob:getarrestedhard', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('ffrp-policejob:doarrested', _source)
end)