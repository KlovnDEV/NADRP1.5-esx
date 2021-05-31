ESX               = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

----
--[[ESX.RegisterUsableItem('gauze', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('gauze', 1)
	TriggerClientEvent('mythic_hospital:items:gauze', source)
end)]]

ESX.RegisterUsableItem('bandage', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('mythic_hospital:items:bandage', source)
    TriggerClientEvent('mythic_hospital:client:FieldTreatLimbs', source)
end)

ESX.RegisterUsableItem('firstaid', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("mythic_hospital:items:medkit", source)
end)

ESX.RegisterUsableItem('medkit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('mythic_hospital:items:medkit', source)
end)

ESX.RegisterUsableItem('oxy', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('mythic_hospital:items:oxy', source)
end)

ESX.RegisterUsableItem('ifak', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('mythic_hospital:items:ifak', source)
end)

--[[ESX.RegisterUsableItem('hydrocodone', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('mythic_hospital:items:hydrocodone', source)
end)

ESX.RegisterUsableItem('morphine', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('mythic_hospital:items:morphine', source)
end)]]

RegisterServerEvent('removeHealItem')
AddEventHandler('removeHealItem', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	if item ~= nil then
		xPlayer.removeInventoryItem(item, 1)
	end
end)