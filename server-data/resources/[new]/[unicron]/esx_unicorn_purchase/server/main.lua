ESX = nil

TriggerEvent('tac:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('esx_unicorn_purchase:purchaseVodka')
AddEventHandler('esx_unicorn_purchase:purchaseVodka', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() < 149 then
		notification('You do not have enough to ~r~purchase~s~ x1 vodka.')
	else	
		xPlayer.removeMoney(150)
		xPlayer.addInventoryItem('vodka', 1)
			
		notification('You purchased ~g~vodka~s~ for ~r~$150')
	end
end)

RegisterServerEvent('esx_unicorn_purchase:purchaseTequila')
AddEventHandler('esx_unicorn_purchase:purchaseTequila', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() < 129 then
		notification('You do not have enough to ~r~purchase~s~ x1 tequila.')
	else
		xPlayer.removeMoney(130)
		xPlayer.addInventoryItem('tequila', 1)
		
		notification('You purchased ~g~tequila~s~ for ~r~$130')
	end
end)

RegisterServerEvent('esx_unicorn_purchase:purchaseJagerbomb')
AddEventHandler('esx_unicorn_purchase:purchaseJagerbomb', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() < 189 then
		notification('You do not have enough to ~r~purchase~s~ x1 jagerbomb.')
	else		
		xPlayer.removeMoney(190)
		xPlayer.addInventoryItem('jagerbomb', 1)
		
		notification('You purchased ~g~jagerbomb~s~ for ~r~$190')
	end
end)

RegisterServerEvent('esx_unicorn_purchase:purchaseBeer')
AddEventHandler('esx_unicorn_purchase:purchaseBeer', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() < 74 then
		notification('You do not have enough to ~r~purchase~s~ x1 beer.')
	else
		xPlayer.removeMoney(75)
		xPlayer.addInventoryItem('beer', 1)
			
		notification('You purchased ~g~beer~s~ for ~r~$190')
	end
end)

RegisterServerEvent('esx_unicorn_purchase:purchaseRedbull')
AddEventHandler('esx_unicorn_purchase:purchaseRedbull', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() < 16 then
		notification('You do not have enough to ~r~purchase~s~ x1 redbull.')
	else
		xPlayer.removeMoney(17)
		xPlayer.addInventoryItem('redbull', 1)
			
		notification('You purchased ~g~redbull~s~ for ~r~$17')
	end
end)

RegisterServerEvent('esx_unicorn_purchase:purchaseVin')
AddEventHandler('esx_unicorn_purchase:purchaseVin', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() < 89 then
		notification('You do not have enough to ~r~purchase~s~ x1 white wine.')
	else
		xPlayer.removeMoney(90)
		xPlayer.addInventoryItem('vittvin', 1)
			
		notification('You purchased ~g~white wine~s~ for ~r~$90')
	end
end)

RegisterServerEvent('esx_unicorn_purchase:makeVodkaredbull')
AddEventHandler('esx_unicorn_purchase:makeVodkaredbull', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	local oneQuantity = xPlayer.getInventoryItem('vodka').count
	local twoQuantity = xPlayer.getInventoryItem('redbull').count
	
	if oneQuantity > 0 then
		if twoQuantity > 0 then
			
			
			xPlayer.removeInventoryItem('vodka', 1)
			xPlayer.removeInventoryItem('redbull', 1)
			xPlayer.addInventoryItem('vodkaredbull', 1)
				
			notification('You crafted x1 ~g~vodka-redbull~s~')
		else
			notification('You do not have enough ~r~redbull')
		end
	else
		notification('You do not have enough ~r~vodka')
	end
end)

function notification(text)
	TriggerClientEvent('mythic_notify:showNotification', source, text)
end