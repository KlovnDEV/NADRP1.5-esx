--print("Meth car got loaded, Made by Kuzkay")
	
ESX = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_methcar:start')
AddEventHandler('esx_methcar:start', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer.getInventoryItem('acetone').count >= 5 and xPlayer.getInventoryItem('battery').count >= 2 and xPlayer.getInventoryItem('methlab').count >= 1 then
		if xPlayer.getInventoryItem('meth1g').count >= 300 then
			TriggerClientEvent('esx_methcar:notify', _source, "~r~~h~You cant hold more meth")
		else
			TriggerClientEvent('esx_methcar:startprod', _source)
			xPlayer.removeInventoryItem('acetone', 5)
			xPlayer.removeInventoryItem('battery', 2)
		end
	else
		TriggerClientEvent('esx_methcar:notify', _source, "~r~~h~Not enough supplies to start producing Meth")
	end
end)


RegisterServerEvent('esx_methcar:stopf')
AddEventHandler('esx_methcar:stopf', function(id)
	local _source = source
	TriggerClientEvent('esx_methcar:stopfreeze', -1, id)
end)

RegisterServerEvent('esx_methcar:make')
AddEventHandler('esx_methcar:make', function(posx,posy,posz)
	local _source = source
	TriggerClientEvent('esx_methcar:smoke',-1,posx,posy,posz, 'a') 
end)

RegisterServerEvent('esx_methcar:finish')
AddEventHandler('esx_methcar:finish', function(qualtiy)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	print(qualtiy)
	local rnd = math.random(-5, 5)
	TriggerEvent('KLevels:addXP', _source, 20)
	--xPlayer.addInventoryItem('meth1g', math.floor(qualtiy / 2) + rnd)
	TriggerClientEvent("player:receiveItem",_source,"methbag",math.floor(qualtiy / 2) + rnd)
	TriggerClientEvent("inventory:removeItem",_source,"acetone",5)
	TriggerClientEvent("inventory:removeItem",_source,"carbattery",2)
	TriggerClientEvent('esx_methcar:stop', _source)
end)

RegisterServerEvent('esx_methcar:blow')
AddEventHandler('esx_methcar:blow', function(posx, posy, posz)
	local _source = source
	TriggerClientEvent('esx_methcar:blowup', -1,posx, posy, posz)
end)

