ESX               = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

----
--[[ESX.RegisterUsableItem('gauze', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('gauze', 1)
	TriggerClientEvent('mythic_hospital2:items:gauze', source)
end)]]

ESX.RegisterUsableItem('bandage', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('mythic_hospital2:items:bandage', source)
    TriggerClientEvent('mythic_hospital2:client:FieldTreatLimbs', source)
end)

ESX.RegisterUsableItem('firstaid', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("mythic_hospital2:items:medkit", source)
end)

ESX.RegisterUsableItem('medkit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('mythic_hospital2:items:medkit', source)
end)

ESX.RegisterUsableItem('oxy', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('mythic_hospital2:items:oxy', source)
end)

ESX.RegisterUsableItem('ifak', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('mythic_hospital2:items:ifak', source)
end)

--[[ESX.RegisterUsableItem('hydrocodone', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('mythic_hospital2:items:hydrocodone', source)
end)

ESX.RegisterUsableItem('morphine', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('mythic_hospital2:items:morphine', source)
end)]]

RegisterServerEvent('removeHealItem')
AddEventHandler('removeHealItem', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	if item ~= nil then
		xPlayer.removeInventoryItem(item, 1)
	end
end)