ESX = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

local cachedData = {}

ESX.RegisterServerCallback("nadrp_garages:isPlayerOwned", function(source, callback, plate)
	local player = ESX.GetPlayerFromId(source)
	local plt = plate
	if player ~= nil then
		local result = MySQL.Sync.fetchAll("SELECT plate FROM owned_vehicles WHERE plate=@plate",{['@plate'] = plt})
		if result[1] then
			callback(true)
		else
			callback(false)
		end
	else
		callback(false)
	end
end)

RegisterServerEvent('nadrp_garages:pay')
AddEventHandler('nadrp_garages:pay', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(200)
end)

RegisterServerEvent('nadrp_garages:modifystate')
AddEventHandler('nadrp_garages:modifystate', function(vehicleProps, state, garage)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local plate = vehicleProps.plate

	if garage == nil then
		MySQL.Sync.execute("UPDATE owned_vehicles SET garage=@garage WHERE plate=@plate",{['@garage'] = "OUT" , ['@plate'] = plate})
		MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle=@vehicle WHERE plate=@plate",{['@vehicle'] = json.encode(vehicleProps), ['@plate'] = plate})
		MySQL.Sync.execute("UPDATE owned_vehicles SET state=@state WHERE plate=@plate",{['@state'] = state, ['@plate'] = plate})
	else
		MySQL.Sync.execute("UPDATE owned_vehicles SET garage=@garage WHERE plate=@plate",{['@garage'] = garage , ['@plate'] = plate})
		MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle=@vehicle WHERE plate=@plate",{['@vehicle'] = json.encode(vehicleProps), ['@plate'] = plate})
		MySQL.Sync.execute("UPDATE owned_vehicles SET state=@state WHERE plate=@plate",{['@state'] = state , ['@plate'] = plate})
	end
end)

RegisterNetEvent("garages:CheckForVeh")
AddEventHandler("garages:CheckForVeh", function()
	local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	local identifier = xPlayer.identifier
	local data = {}
	MySQL.Async.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @identifier', { ['@identifier'] = identifier }, function(plates)
		if plates[1] ~= nil then
			for i=1, #plates, 1 do
				table.insert(data, {
					plate = plates[i]
				})
			end
			TriggerClientEvent('garages:StoreVehicle', src, data)
		end
	end)
end)

RegisterServerEvent('garages:CheckForSpawnVeh')
AddEventHandler('garages:CheckForSpawnVeh', function(id, carCount, impound, curGarage, free)
	local _source = source
	local user = ESX.GetPlayerFromId(_source)
	if id ~= nil then
		MySQL.Async.fetchAll('SELECT vehicle,state,garage FROM owned_vehicles WHERE id = @id', { ['@id'] = id }, function(result)
			if result[1] ~= nil then
				local vehicle = result[1].vehicle
				local state = result[1].state
				local garage = result[1].garage
				local cash = user.getMoney()
				if state == 'Standard Impound' then
					if garage == curGarage then
						if cash >= 100 then
							TriggerClientEvent('garages:SpawnVehicle', _source, vehicle, state)
							user.removeMoney(500)
						else
							TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = 'You dont have enough money on you'})
						end
					else
						TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = 'This vehicle is stored at Garage: '..garage..''})
					end
				elseif state == 'Police Impound' then
					if garage == curGarage then
						if cash >= 1500 then
							TriggerClientEvent('garages:SpawnVehicle', _source, vehicle, state)
							user.removeMoney(1500)
						else
							TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = 'You dont have enough money on you'})
						end
					else
						TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = 'This vehicle is stored at Garage: '..garage..''})
					end
				elseif garage ~= 'OUT' and tonumber(state) == 1 then
					if garage == curGarage then
						TriggerClientEvent('garages:SpawnVehicle', _source, vehicle, state)
					else
						TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = 'This vehicle is stored at Garage: '..garage..''})
					end
				elseif tonumber(state) == 0 then
					if garage == curGarage then
						if cash >= 100 then
							TriggerClientEvent('garages:SpawnVehicle', _source, vehicle, state)
							user.removeMoney(100)
						else
							TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = 'You dont have enough money on you'})
						end
					else
						TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = 'This vehicle is stored at Garage: '..garage..''})
					end
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = 'This vehicle is already out.'})
				end
			end
		end)
	end
end)

RegisterServerEvent('nadrp_garages:resetOutVehicles')
AddEventHandler('nadrp_garages:resetOutVehicles', function()
	MySQL.Async.execute('UPDATE owned_vehicles SET garage=@newGarage WHERE garage=@garage', {['@newGarage'] = 'Impound Lot', ['@garage'] = 'OUT'})
end)

MySQL.ready(function()
    MySQL.Async.execute('UPDATE owned_vehicles SET garage=@newGarage WHERE garage=@garage', {['@newGarage'] = 'Impound Lot', ['@garage'] = 'OUT'})
end)

RegisterNetEvent("garages:CheckGarageForVeh")
AddEventHandler("garages:CheckGarageForVeh", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = xPlayer.identifier

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier', { ['@identifier'] = identifier }, function(vehicles)
		for i=1, #vehicles do
			if vehicles[i].lastpayment ~= nil then
				local lastpayment = vehicles[i].lastpayment
				local daysfrom = os.difftime(os.time(), lastpayment) / (24 * 60 * 60)
				local wholedays = math.floor(daysfrom)
				vehicles[i].lastpayment = wholedays
			end
		end
		TriggerClientEvent('phone:Garage', src, vehicles)
		TriggerClientEvent('garages:getVehicles', src, vehicles)
    end)
end)


-- SELL VEHICLE STUFF

RegisterCommand('sellcar', function (source, args, raw)
	local target = args[1]
	local plate = args[2]
	local price = args[3]
	local user = ESX.GetPlayerFromId(source)
	if target ~= nil then
		if plate ~= nil then
			local hasCar = MySQL.Sync.fetchAll('SELECT owner FROM owned_vehicles WHERE plate=@plate', {['@plate'] = plate})
			if hasCar ~= nil then
				local carOwner = hasCar[1].owner
				if carOwner == user.identifier then
					TriggerClientEvent('garages:SellToPlayer', user.source, target, plate, tonumber(price))
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', user.source, {type = 'error', text = 'You dont own this car.'})
				end
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', user.source, {type = 'error', text = "Plate doesn't exist?."})
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', user.source, {type = 'error', text = 'Invalid plate.'})
		end
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', user.source, {type = 'error', text = 'Player not online.'})
	end
end)

RegisterServerEvent('garages:askRequest')
AddEventHandler('garages:askRequest', function(player, price)
	local user = ESX.GetPlayerFromId(source)
	local targ = ESX.GetPlayerFromId(player)
	if targ ~= nil then
		TriggerClientEvent('garages:askingForVeh', targ.source, user.source, targ.source, price)
	end
end)

RegisterServerEvent('garages:askResult')
AddEventHandler('garages:askResult', function(src, targ, result)
	local user = ESX.GetPlayerFromId(source)
	if result then
		TriggerClientEvent('garages:clientResult', src, result)
		TriggerClientEvent('garages:clientResult', targ, result)
	else
		TriggerClientEvent('garages:clientResult', src, result)
		TriggerClientEvent('garages:clientResult', targ, result)
	end
end)

RegisterServerEvent('garages:SellToPlayerEnd')
AddEventHandler('garages:SellToPlayerEnd', function(plate,player,price)
	local user = ESX.GetPlayerFromId(source)
	local targ = ESX.GetPlayerFromId(player)
	if plate ~= nil and player ~= nil then
		MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate=@plate AND owner=@owner ', {
			['@owner'] = user.identifier,
			["plate"] = plate
		}, function(result)
			if result ~= nil then
				if targ.getMoney() >= tonumber(price) then
					targ.removeMoney(price)
					user.addAccountMoney('bank', price)
					MySQL.Async.execute('UPDATE owned_vehicles SET owner=@owner WHERE plate=@plate', {['@plate'] = plate, ['@owner'] = targ.identifier})
					TriggerClientEvent('garages:ClientEnd', targ.source)
					TriggerClientEvent('garages:PlayerEnd', user.source)
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', targ.source, {type = 'error', text = "You don't have enough money on you."})
				end
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', user.source, {type = 'error', text = "You don't own this vehicle?."})
			end
		end)
	end
end)

-- Rental 

RegisterServerEvent('nadrp-garages:attemptRent')
AddEventHandler('nadrp-garages:attemptRent', function(bike)
	local src = source
	local user = ESX.GetPlayerFromId(src)
	local cash = user.getMoney()
	if bike == 'bmx' then
		print(cash)
		if cash >= 200 then
			user.removeMoney(200)
			TriggerClientEvent('nadrp-garages:SpawnRental', src, bike)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', src, {type = 'error', text = 'You dont have enough money on you!'})
		end
	elseif bike == 'scorcher' then
		if cash >= 300 then
			user.removeMoney(300)
			TriggerClientEvent('nadrp-garages:SpawnRental', src, bike)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', src, {type = 'error', text = 'You dont have enough money on you!'})
		end
	end
end)

RegisterServerEvent('nadrp-garages:returnRental')
AddEventHandler('nadrp-garages:returnRental', function()
	local src = source
	local user = ESX.GetPlayerFromId(src)
	if not recent then 
		recent = true
		user.addMoney(20)
		TriggerClientEvent('mythic_notify:client:SendAlert', src, {type = 'inform', text = 'Thank you for returning the bike here is your deposit.'})
		Citizen.Wait(2000)
		recent = false
	else
		local data = {
			identifiers = GetPlayerIdentifiers(src),
			name = GetPlayerName(src),
			reason = 'Attempted Lua injection (BikeRental)',
			info = 'Event called to many times'
		}
		exports["nadrp-log"]:DiscordLog(data)
	end
end)

RegisterCommand('resetGarage', function(source, args, raw)
	local user = ESX.GetPlayerFromId(source)
	local group = user.getGroup()
	local plate = args[1]
	if plate ~= nil then 
		if group ~= "user" and "" then
			MySQL.Async.fetchAll('UPDATE owned_vehicles SET garage=@garage WHERE plate=@plate', {
				['@garage'] = 'T',
				['@plate'] = plate
			})
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'No permissions'})
		end
	else
		if source > 0 then
			TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Invalid plate'})
		end
	end
end)