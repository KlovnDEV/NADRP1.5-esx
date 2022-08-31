ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('server-inventory-request-identifier')
AddEventHandler('server-inventory-request-identifier', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local steam = xPlayer.identifier
    TriggerClientEvent('inventory-client-identifier', src, steam)
end)


RegisterCommand('evidence', function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local boxID = args[1]

    if xPlayer.job.name == 'police' or  xPlayer.job.name == 'DA' and boxID and type(tonumber(boxID)) == 'number' then
        TriggerClientEvent("server-inventory-open", src, "1", "Case-" .. boxID)
    end
end)

RegisterServerEvent('inventory:removecash')
AddEventHandler('inventory:removecash', function(pSrc, amount)
    local xPlayer = ESX.GetPlayerFromId(pSrc)
    xPlayer.removeMoney(amount)
    TriggerClientEvent('nadrp-ped:UpdateCash', pSrc, xPlayer.getMoney())
end)

RegisterServerEvent('inventory:updateCash')
AddEventHandler('inventory:updateCash', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local cash = xPlayer.getMoney()
    TriggerClientEvent('nadrp-ped:UpdateCash', src, cash)
end)

--[[TriggerEvent('es:addGroupCommand', 'giveitem', 'admin', function(source, args, user)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(args[1])
	local item    = args[2]
    local count   = (args[3] == nil and 1 or tonumber(args[3]))
	if count ~= nil then
		if xPlayer ~= nil then
            TriggerClientEvent('player:receiveItem', xPlayer.source, ""..item.."", count)
		else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Invalid Item'})
		end
	else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Invalid Amount'})
	end
end, function(source, args, user)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'You dont have permissions'})
end, {help='Spawn a item'})]]