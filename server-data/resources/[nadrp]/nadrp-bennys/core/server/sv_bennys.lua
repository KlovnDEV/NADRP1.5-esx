ESX = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

local RepairCost = 0

RegisterServerEvent('nadrp-bennys:attemptPurchase')
AddEventHandler('nadrp-bennys:attemptPurchase', function(type, upgradelevel)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local IsMechanicJobOnly = false
	if type == 'repair' then
		price = RepairCost
	elseif type == "performance" then
		price = vehicleCustomisationPrices[type].prices[upgradelevel]
	else
		price = vehicleCustomisationPrices[type].price
	end
	if IsMechanicJobOnly then
	 	local societyAccoun
	 	TriggerEvent('tac_addonaccount:getSharedAccount', 'society_mechanic', function(account)
			societyAccount = account
		end)
	 	if price < societyAccount.money then
			TriggerClientEvent("nadrp-bennys:purchaseSuccessful",source)
	 		societyAccount.removeMoney(price)
	 	else
	 		TriggerClientEvent('nadrp-bennys:purchaseFailed', _source)
	 		TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = "error", text = "You don't have enough money for this"})
	 	end
	else
	 	if price < xPlayer.getMoney() then
			TriggerClientEvent("nadrp-bennys:purchaseSuccessful",source)
	 		xPlayer.removeMoney(price)
	 	else
	 		TriggerClientEvent('nadrp-bennys:purchaseFailed', _source)
	 		TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = "error", text = "You don't have enough money for this"})
	 	end
	 end
end)

RegisterServerEvent('nadrp-bennys:updateRepairCost')
AddEventHandler('nadrp-bennys:updateRepairCost', function(RepairCosts)
	RepairCost = RepairCosts
end)

RegisterServerEvent('updateVehicle')
AddEventHandler('updateVehicle', function(vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT vehicle FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = vehicleProps.plate
	}, function(result)
		if result[1] then
			local vehicle = json.decode(result[1].vehicle)

			if vehicleProps.model == vehicle.model then
				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate', {
					['@plate'] = vehicleProps.plate,
					['@vehicle'] = json.encode(vehicleProps)
				})
			else
				print(('esx_lscustom: %s attempted to upgrade vehicle with mismatching vehicle model!'):format(xPlayer.identifier))
			end
		end
	end)
end)

RegisterServerEvent('bennys:setXenon')
AddEventHandler('bennys:setXenon', function(plate, color)
	--print(color)
    --MySQL.Async.execute("UPDATE owned_vehicles SET color =@color WHERE plate=@plate",{['@color'] = color, ['@plate'] = plate})
end)


ESX.RegisterServerCallback("bennys:getXenon", function(source, cb, plate)
    MySQL.Async.fetchScalar('SELECT color FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
    }, function(result)
		cb(result)
	end)

end)

-- ESX.RegisterServerCallback("m3:garage:plateCheck", function(source, cb, plate)
--     MySQL.Async.fetchScalar('SELECT color FROM owned_vehicles WHERE plate = @plate', {
-- 		['@plate'] = plate
--     }, function(result)
-- 		cb(result)
-- 	end)
-- end)