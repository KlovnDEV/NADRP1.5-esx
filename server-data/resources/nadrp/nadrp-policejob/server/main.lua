ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
end)

RegisterServerEvent('nadrp-policejob:reference')
AddEventHandler('nadrp-policejob:reference', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent("nadrp-policejob:addBlip", -1, tonumber(_source))
	else
        TriggerClientEvent('mythic_notify:client:DoLongHudText', xPlayer.source, {type = 'error', text = 'You are not police'})
	end
end)

RegisterNetEvent('nadrp-policejob:drag')
AddEventHandler('nadrp-policejob:drag', function(target)
	TriggerClientEvent('nadrp-policejob:drag', target, source)
end)

RegisterServerEvent('nadrp-policejob:resetDrag')
AddEventHandler('nadrp-policejob:resetDrag', function(target)
	TriggerClientEvent('nadrp-policejob:resetDrag', target, source)
end)

RegisterServerEvent('nadrp-policejob:handcuff')
AddEventHandler('nadrp-policejob:handcuff', function(target)
    TriggerClientEvent('nadrp-policejob:handcuff', target)
end)

RegisterServerEvent('nadrp-policejob:requestarrest')
AddEventHandler('nadrp-policejob:requestarrest', function(isCommand, targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    if not isCommand then
        TriggerClientEvent('nadrp-policejob:getarrested', targetid, false,playerheading, playerCoords, playerlocation)
        TriggerClientEvent('nadrp-policejob:doarrested', _source)
    else
        if GetPlayerName(targetid) ~= nil then
            TriggerClientEvent('nadrp-policejob:getarrested', targetid, true)
        else
            TriggerClientEvent('mythic_notify:client:DoLongHudText', _source, {type = 'error', text = 'Invalid playerid'})
        end
    end
end)

RegisterServerEvent('nadrp-policejob:requestrelease')
AddEventHandler('nadrp-policejob:requestrelease', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('nadrp-policejob:getuncuffed', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('nadrp-policejob:douncuffing', _source)
end)

RegisterServerEvent('nadrp-policejob:sc')
AddEventHandler('nadrp-policejob:sc', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('nadrp-policejob:loose', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('nadrp-policejob:douncuffing', _source)
end)

RegisterServerEvent('nadrp-policejob:requesthard')
AddEventHandler('nadrp-policejob:requesthard', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('nadrp-policejob:getarrestedhard', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('nadrp-policejob:doarrested', _source)
end)