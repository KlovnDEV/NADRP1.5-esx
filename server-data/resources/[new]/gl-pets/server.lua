ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)


--	local xPlayer = ESX.GetPlayerFromId(source)



RegisterServerEvent('gl-pets:buyPet')
AddEventHandler('gl-pets:buyPet', function(petType,price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)


	MySQL.Async.fetchAll('SELECT * FROM gl_pets WHERE owner = @owner', {
		['@owner'] = xPlayer.identifier,
	}, function (result)
		local ifOwner = table.unpack(result)
		if ifOwner ~= nil then
			print('You already own a Pet!') -- Add notification here
		else
			if xPlayer.getMoney() > price then
				print('You purchased a Pet!') -- Add notification here
				xPlayer.removeMoney(price)
				MySQL.Async.execute('INSERT INTO gl_pets (owner, modelname) VALUES (@owner, @modelname)',
				{
					['@owner']   = xPlayer.identifier,
					['@modelname']   = petType,
				}, function (rowsChanged)

				end)
			else
				print('You cannot afford this pet') -- Add notification here
			end
		end
	end)
end)

RegisterServerEvent('gl-pets:buyFood')
AddEventHandler('gl-pets:buyFood', function(price)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
	--	xPlayer.addInventoryItem(Config.FoodItem,1)
		TriggerClientEvent('player:receiveItem',source,Config.FoodItem,1)
	end
end)


RegisterServerEvent('gl-pets:getOwnedPet')
AddEventHandler('gl-pets:getOwnedPet',function()

	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM gl_pets WHERE owner = @owner', {
		['@owner'] = xPlayer.identifier,
		['@modelname'] = modelname,
	}, function (result)
		TriggerClientEvent('gl-pets:spawnPet',modelname,health,illness)
	end)

end)

RegisterServerEvent('gl-pets:chargeABitch')
AddEventHandler('gl-pets:chargeABitch',function(fee)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= (Config.HealPrice + fee) then
		xPlayer.removeMoney((Config.HealPrice + fee))
	end
end)

RegisterServerEvent('gl-pets:returnBall')
AddEventHandler('gl-pets:returnBall',function()
	local xPlayer = ESX.GetPlayerFromId(source)
--	xPlayer.addInventoryItem('tennisball',1)
	TriggerClientEvent('player:receiveItem',source,'tennisball',1)
end)

RegisterServerEvent('gl-pets:removeBall')
AddEventHandler('gl-pets:removeBall',function()
	local xPlayer = ESX.GetPlayerFromId(source)
	--xPlayer.removeInventoryItem('tennisball',1)
	TriggerClientEvent('inventory:removeItem',source, 'tennisball',1) 
end)




function getPet(identifier)

	MySQL.Async.fetchAll('SELECT * FROM gl_pets WHERE owner = @owner', {
		['@owner'] = identifier,
	}, function (result)
		id = result[1].id
		owner = result[1].owner
		modelname = result[1].modelname
		health = result[1].health
		illnesses = result[1].illnesses
		cb(id,owner,modelname,health,illnesses)
	end)


end

ESX.RegisterServerCallback("gl-pets:getPetSQL", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    --cb(getPet(xPlayer.identifier))
    	MySQL.Async.fetchAll('SELECT * FROM gl_pets WHERE owner = @owner', {
		['@owner'] = xPlayer.identifier,
	}, function (result)
		cb(result)
	end)
end)


RegisterServerEvent('gl-pets:updatePet')
AddEventHandler('gl-pets:updatePet',function(health,illness)
    local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE gl_pets SET health = @health, illnesses = @illness WHERE owner = @owner', {
		['@health'] = health,
		['@illness'] = illness,				
		['@owner']   = xPlayer.identifier,
	}, function(rowsChanged)

	end)

end)

RegisterServerEvent('gl-pets:buyTennisBall')
AddEventHandler('gl-pets:buyTennisBall',function(price)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
	--	xPlayer.addInventoryItem('tennisball',1)
		TriggerClientEvent('player:receiveItem',source,'tennisball',1)
	end	
end)


RegisterServerEvent('gl-pets:updatePetName')
AddEventHandler('gl-pets:updatePetName',function(name)
    local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE gl_pets SET name = @name WHERE owner = @owner', {
		['@name'] = name,		
		['@owner']   = xPlayer.identifier,
	}, function(rowsChanged)

	end)

end)



RegisterServerEvent('gl-pets:removePet')
AddEventHandler('gl-pets:removePet',function()
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute('DELETE FROM gl_pets WHERE owner = @owner', {
		['@owner'] = xPlayer.identifier
	})

end)


RegisterNetEvent('gl-pets:k9Search')
AddEventHandler('gl-pets:k9Search',function(ID,targetID)
	print('Im here')
	local itemFound = false
	local source = source
	local targetPlayer = ESX.GetPlayerFromId(targetID)
	        for k, v in pairs(Config.SearchableItems.IllegalItems) do
            	if targetPlayer.getInventoryItem(k).count >= v then
            		itemFound = true
            	end
        	end

		TriggerClientEvent('gl-pets:k9ItemCheck', source, itemFound)

end)
    