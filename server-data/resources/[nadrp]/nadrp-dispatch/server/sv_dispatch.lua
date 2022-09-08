ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('dispatch:svNotify')
AddEventHandler('dispatch:svNotify', function(data)
    TriggerClientEvent('dispatch:clNotify',-1,data)
end)

RegisterServerEvent('dispatch:svNotifyM')
AddEventHandler('dispatch:svNotifyM', function(data)
    TriggerClientEvent('dispatch:clNotifyM',-1,data)
end)

RegisterServerEvent('tac-alerts:policealertA')
AddEventHandler('tac-alerts:policealertA', function(targetCoords)
    TriggerClientEvent('tac-alerts:policealertA',-1, targetCoords)
end)

RegisterServerEvent('tac-alerts:policealertB')
AddEventHandler('tac-alerts:policealertB', function(targetCoords)
    TriggerClientEvent('tac-alerts:policealertB',-1,targetCoords)
end)

RegisterServerEvent('tac-alerts:panic')
AddEventHandler('tac-alerts:panic', function(targetCoords)
    TriggerClientEvent('tac-alerts:panic',-1, targetCoords)
end)

RegisterServerEvent('tac-alerts:tenFourteenB')
AddEventHandler('tac-alerts:tenFourteenB', function(targetCoords)
    TriggerClientEvent('tac-alerts:tenForteenB',-1,targetCoords)
end)

RegisterServerEvent('tac-alerts:tenFourteenA')
AddEventHandler('tac-alerts:tenFourteenA', function(targetCoords)
    TriggerClientEvent('tac-alerts:tenForteenA',-1,targetCoords)
end)

RegisterServerEvent('tac_outlawalert:carJackInProgress')
AddEventHandler('tac_outlawalert:carJackInProgress', function(targetCoords)
	TriggerClientEvent('tac-alerts:vehiclesteal', -1, targetCoords)
end)

RegisterServerEvent('tac_outlawalert:combatInProgress')
AddEventHandler('tac_outlawalert:combatInProgress', function(targetCoords)
	TriggerClientEvent('tac-outlawalert:combatInProgress', -1, targetCoords)
end)


RegisterServerEvent('tac_outlawalert:gunshotInProgress')
AddEventHandler('tac_outlawalert:gunshotInProgress', function(targetCoords)
	TriggerClientEvent('tac-outlawalert:gunshotInProgress', -1, targetCoords)
end)

RegisterServerEvent('tac_outlawalert:VanjelicoInProgress')
AddEventHandler('tac_outlawalert:VanjelicoInProgress', function(targetCoords)
    TriggerClientEvent('tac-alerts:jewelrobbey', -1, targetCoords)
end)

RegisterServerEvent('tac_outlawalert:PaletoBank')
AddEventHandler('tac_outlawalert:PaletoBank', function(targetCoords)
    TriggerClientEvent('tac-alerts:PaletoBank', -1, targetCoords)
end)

RegisterServerEvent('tac_outlawalert:HouseRobInProgress')
AddEventHandler('tac_outlawalert:HouseRobInProgress', function(targetCoords)
    TriggerClientEvent('tac-alerts:houserobbery', -1, targetCoords)
end)

RegisterServerEvent('tac_outlawalert:drugSaleInProgress')
AddEventHandler('tac_outlawalert:drugSaleInProgress', function(targetCoords)
	TriggerClientEvent('tac-alerts:drugsale', -1, targetCoords)
end)

RegisterServerEvent('tac_outlawalert:TressPass')
AddEventHandler('tac_outlawalert:TressPass', function(targetCoords)
	TriggerClientEvent('tac-alerts:trespass', -1, targetCoords)
end)

RegisterServerEvent('tac_outlawalert:1050')
AddEventHandler('tac_outlawalert:1050', function(targetCoords)
	TriggerClientEvent('tac-alerts:1050', -1, targetCoords)
end)

RegisterServerEvent('tac_outlawalert:injured')
AddEventHandler('tac_outlawalert:injured', function(targetCoords)
	TriggerClientEvent('tac-alerts:downalert', -1, targetCoords)
end)

RegisterServerEvent('tac_outlawalert:mechanic')
AddEventHandler('tac_outlawalert:mechanic', function(targetCoords)
	TriggerClientEvent('tac-alerts:mechanic', -1, targetCoords)
end)

RegisterServerEvent('tac_outlawalert:fleecaInProgress')
AddEventHandler('tac_outlawalert:fleecaInProgress', function(targetCoords)
	TriggerClientEvent('tac-dispatch:bankrobbery', -1, targetCoords)
end)


RegisterServerEvent('tac_outlawalert:atmInProgress')
AddEventHandler('tac_outlawalert:atmInProgress', function(targetCoords)
	TriggerClientEvent('tac-dispatch:atmrob', -1, targetCoords)
end)


RegisterServerEvent('tac_outlawalert:StoreInProgress')
AddEventHandler('tac_outlawalert:StoreInProgress', function(targetCoords)
	TriggerClientEvent('tac-alerts:storerobbery', -1, targetCoords)
end)


RegisterServerEvent('tac_outlawalert:powerGridInProgress')
AddEventHandler('tac_outlawalert:powerGridInProgress', function(targetCoords)
	TriggerClientEvent('tac-alerts:powerGrid', -1, targetCoords)
end)

RegisterServerEvent('tac_outlawalert:StoreCamNotif')
AddEventHandler('tac_outlawalert:StoreCamNotif', function(str)
	TriggerClientEvent('tac-alerts:StoreCamNotif', -1, str)
end)

RegisterServerEvent('police:setCallSign')
AddEventHandler('police:setCallSign', function(pCallsign)
	local user = ESX.GetPlayerFromId(source)
	local ident = user.identifier
	if pCallsign ~= nil then
		MySQL.Async.fetchAll('SELECT callsign FROM characters WHERE identifier=@identifier', {
			['@identifier'] = ident
		}, function(result)
			if result[1] ~= nil then
				local callsign = result[1].callsign
				if callsign ~= 0 then
					TriggerClientEvent('ped:callSign', user.source, callsign)
					TriggerClientEvent('mythic_notify:client:DoLongHudText', user.source, {type = 'inform', text = 'Callsing already set (Refreshing Current Callsign)'})
				elseif callsign ~= nil then
					MySQL.Async.execute('UPDATE characters SET callsign=@pCallsign WHERE identifier=@identifier', {
						['@identifier'] = ident,
						['@pCallsign'] = pCallsign
					}, function(res)
						TriggerClientEvent('ped:callSign', user.source, pCallsign)
						TriggerClientEvent('mythic_notify:client:DoLongHudText', user.source, {type = 'inform',text = 'Setting callsing ('..pCallsign..')'})
					end)
				end
			end
		end)
	end
end)
