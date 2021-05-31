ESX = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

local repayTime = 168 * 60 -- hours * 60
local timer = ((60 * 1000) * 10) -- 10 minute timer
local requesting = false
local carTable = {
	[1] = { ["model"] = "gauntlet", ["baseprice"] = 100000, ["commission"] = 15 }, 
	[2] = { ["model"] = "dubsta3", ["baseprice"] = 100000, ["commission"] = 15 },
	[3] = { ["model"] = "landstalker", ["baseprice"] = 100000, ["commission"] = 15 },
	[4] = { ["model"] = "bobcatxl", ["baseprice"] = 100000, ["commission"] = 15 },
	[5] = { ["model"] = "surfer", ["baseprice"] = 100000, ["commission"] = 15 },
	[6] = { ["model"] = "glendale", ["baseprice"] = 100000, ["commission"] = 15 },
	[7] = { ["model"] = "washington", ["baseprice"] = 100000, ["commission"] = 15 },
}

-- Update car table to server
RegisterServerEvent('carshop:table')
AddEventHandler('carshop:table', function(table)
    if table ~= nil then
        carTable = table
        TriggerClientEvent('veh_shop:returnTable', -1, carTable)
        updateDisplayVehicles()
    end
end)

-- Enables finance for 60 seconds
RegisterServerEvent('finance:enable')
AddEventHandler('finance:enable', function(plate)
    local src = source
    local user = ESX.GetPlayerFromId(src)
    local ident = user.identifier
    if plate ~= nil then 
        MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier=@identifier', {
            ['@identifier'] = ident
        },function (result)
            if result ~= nil then
                local name = result[1].firstname..', '..result[1].lastname
                TriggerClientEvent('finance:enableOnClient', -1, plate, name)
            else
                TriggerClientEvent('finance:enableOnClient', -1, plate, 'error')
            end
        end)
    end
end)

RegisterServerEvent('buy:enable')
AddEventHandler('buy:enable', function(plate)
    local src = source
    local user = ESX.GetPlayerFromId(src)
    local ident = user.identifier
    if plate ~= nil then
        MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier=@identifier', {
            ['@identifier'] = ident
        },function (result)
            if result ~= nil then
                local name = result[1].firstname..', '..result[1].lastname
                TriggerClientEvent('buy:enableOnClient', -1, plate, name)
            else
                TriggerClientEvent('buy:enableOnClient', -1, plate, 'error')
            end
        end)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', src, {type = 'error', text = 'There was an error getting the plate'})
    end
end)

-- return table
-- TODO (return db table)
RegisterServerEvent('carshop:requesttable')
AddEventHandler('carshop:requesttable', function()
    local user = ESX.GetPlayerFromId(source)
    if not requesting then
        requesting = true
        local display = MySQL.Sync.fetchAll('SELECT * FROM vehicles_display')
        local carTable = {}
        for k,v in pairs(display) do
            carTable[v.ID] = v
            v.price = carTable[v.ID].baseprice
        end
        TriggerClientEvent('veh_shop:returnTable', user.source, carTable)
        requesting = false
    end
end)

-- Check if player has enough money
RegisterServerEvent('CheckMoneyForVeh')
AddEventHandler('CheckMoneyForVeh', function(name, model,price,financed, commission)
	local user = ESX.GetPlayerFromId(source)
    local money = user.getMoney()
    local plate = GeneratePlate()
    if financed then
        local financedPrice = math.ceil(price / 4)
        if money >= financedPrice then
            user.removeMoney(financedPrice)
            TriggerClientEvent('FinishMoneyCheckForVeh', user.source, name, model, price, financed,commission)
            TriggerClientEvent('carshop:newPlate', user.source, plate)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', user.source, {type = 'error', text = 'You dont have enough money on you'})
            TriggerClientEvent('carshop:failedpurchase', user.source)
        end
    else
        if money >= price then
            user.removeMoney(price)
            TriggerClientEvent('FinishMoneyCheckForVeh', user.source, name, model, price, financed,commission)
            TriggerClientEvent('carshop:newPlate', user.source, plate)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', user.source, {type = 'error', text = 'You dont have enough money on you'})
            TriggerClientEvent('carshop:failedpurchase', user.source)
        end
    end
end)


-- Add the car to database when completed purchase
RegisterServerEvent('BuyForVeh')
AddEventHandler('BuyForVeh', function(vehicleProps,name, vehicle, price, financed,seller,commission,commissionbuy)
    local user = ESX.GetPlayerFromId(source)
    local Buyer = MySQL.Sync.fetchAll("SELECT firstname, lastname FROM users WHERE identifier=@identifier",{['@identifier'] = user.identifier})
    local buyerName = Buyer[1].firstname..', '.. Buyer[1].lastname
    local dateNow = os.time()
    local plate = vehicleProps.plate
    if financed then
        local cols = 'owner, plate, vehicle, buy_price, finance, financetimer, vehiclename, shop,lastpayment'
        local val = '@owner, @plate, @vehicle, @buy_price, @finance, @financetimer, @vehiclename, @shop,@lastpayment'
        local downPay = math.ceil(price / 4)
        local data = MySQL.Sync.fetchAll("SELECT money FROM addon_account_data WHERE account_name=@account_name",{['@account_name'] = 'pdm'})
        local curSociety = data[1].money
        MySQL.Async.execute('INSERT INTO owned_vehicles ( '..cols..' ) VALUES ( '..val..' )',{
            ['@owner']   = user.identifier,
            ['@plate']   = plate,
            ['@vehicle'] = json.encode(vehicleProps),
            ['@vehiclename'] = vehicle,
            ['@buy_price'] = price,
            ['@finance'] = price - downPay,
            ['@financetimer'] = repayTime,
            ['@shop'] = 'pdm',
            ['@lastpayment'] = dateNow
        })
        MySQL.Sync.execute('UPDATE addon_account_data SET money=@money WHERE account_name=@account_name',{['@money'] = curSociety + commissionbuy,['@account_name'] = 'pdm'})
        LogSale(vehicle, vehicleProps.plate, price, financed,seller, buyerName, dateNow, commission)
    else
        local data = MySQL.Sync.fetchAll("SELECT money FROM addon_account_data WHERE account_name=@account_name",{['@account_name'] = 'pdm'})
        local curSociety = data[1].money
        MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, vehiclename, shop,lastpayment) VALUES (@owner, @plate, @vehicle, @vehiclename, @shop, @lastpayment)',{
            ['@owner']   = user.identifier,
            ['@plate']   = vehicleProps.plate,
            ['@vehicle'] = json.encode(vehicleProps),
            ['@vehiclename'] = vehicle,
            ['@buy_price'] = price,
            ['@shop'] = 'pdm',
            ['@lastpayment'] = dateNow
        })
        MySQL.Sync.execute('UPDATE addon_account_data SET money=@money WHERE account_name=@account_name',{['@money'] = curSociety + commissionbuy,['@account_name'] = 'pdm'})
        LogSale(vehicle, vehicleProps.plate, price, financed,seller, buyerName, dateNow, commission)
    end
end)

function updateDisplayVehicles()
    for i=1, #carTable do
        MySQL.Sync.execute("UPDATE vehicles_display SET model=@model, commission=@commission, baseprice=@baseprice WHERE ID=@ID",{
            ['@ID'] = i,
            ['@model'] = carTable[i]["model"],
            ['@commission'] = carTable[i]["commission"],
            ['@baseprice'] = carTable[i]["baseprice"]
        })
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        updateDisplayVehicles()
    end
end)

-- New phone payments
RegisterNetEvent('RS7x:phonePayment')
AddEventHandler('RS7x:phonePayment', function(plate)
    local pPlate = plate
    local xPlayer = ESX.GetPlayerFromId(source)
    if pPlate ~= nil then
        local pData = MySQL.Sync.fetchAll("SELECT buy_price,plate,lastpayment FROM owned_vehicles WHERE plate=@plate", {['@plate'] = pPlate})
        for k,v in pairs(pData) do
            if pData ~= nil then
                if pPlate == v.plate then
                    local price = (v.buy_price / 10)
                    if xPlayer.getMoney() >= price then
                        xPlayer.removeMoney(price)
                        fuck = true
                    else
                        fuck = false
                    end

                    if fuck then
                        local timestamp = os.time()
                        local data = MySQL.Sync.fetchAll("SELECT finance FROM owned_vehicles WHERE plate=@plate",{['@plate'] = plate})
                        if not data or not data[1] then return; end
                        local prevAmount = data[1].finance
                        if prevAmount - price <= 0 or prevAmount - price <= 0.0 then
                            settimer = 0
                        else
                            settimer = repayTime
                        end

                        if prevAmount <= price then
                            MySQL.Sync.execute('UPDATE owned_vehicles SET finance=@finance, lastpayment=@lastpayment WHERE plate=@plate',{['@finance'] = 0, ['@plate'] = plate, ['@lastpayment'] = timestamp})
                            MySQL.Sync.execute('UPDATE owned_vehicles SET financetimer=@financetimer, lastpayment=@lastpayment WHERE plate=@plate',{['@financetimer'] = 0, ['@plate'] = plate, ['@lastpayment'] = timestamp})
                        else
                            MySQL.Sync.execute('UPDATE owned_vehicles SET finance=@finance, lastpayment=@lastpayment WHERE plate=@plate',{['@finance'] = prevAmount - price, ['@plate'] = plate, ['@lastpayment'] = timestamp})
                            MySQL.Sync.execute('UPDATE owned_vehicles SET financetimer=@financetimer, lastpayment=@lastpayment WHERE plate=@plate',{['@financetimer'] = settimer, ['@plate'] = plate, ['@lastpayment'] = timestamp})
                        end
                    end
                end
                return
            end
        end
    end
end)

function LogSale(model,plate,buyPrice,financed,seller,buyer,date,commission)
    if model ~= nil then
        MySQL.Async.execute('INSERT INTO vehicles_sold_pdm (model, plate, buy_price, financed, soldby, buyer, date,commission) VALUES (@model, @plate, @buy_price, @financed, @soldby, @buyer, @date, @commission)', {
            ['@model'] = model,
            ['@plate'] = plate,
            ['@buy_price'] = buyPrice,
            ['@financed'] = financed,
            ['@soldby'] = seller,
            ['@buyer'] = buyer,
            ['@date'] = date,
            ['@commission'] = commission
        })
    end
end

--[[RegisterCommand('rerunPlates', function(source, arsg, raw)
    local user = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT vehicle,plate FROM owned_vehicles',{}, function(result)
        if result ~= nil then
            for i=1, #result do
                local props = json.decode(result[i].vehicle)
                local plate = string.gsub(result[i].plate, "%s+", "")
                local newPlate = GeneratePlate()
                print('OLD PLATE: ',props.plate)
                props.plate = newPlate
                print('NEW PLATE: ',props.plate, i..'/'..#result)
                MySQL.Async.execute('UPDATE owned_vehicles SET plate=@newPlate, vehicle=@vehicle WHERE plate=@plate', {
                    ['@newPlate'] = newPlate,
                    ['@vehicle'] = json.encode(props),
                    ['@plate'] = plate
                }, function()
                    if string.len(plate) == 8 then
                        MySQL.Sync.execute('UPDATE user_inventory2 SET name=@newName WHERE name=@name',{
                            ['@name'] = 'Trunk-'..plate,
                            ['@newName'] = 'Trunk-'..newPlate
                        })
                        MySQL.Sync.execute('UPDATE user_inventory2 SET name=@newName WHERE name=@name',{
                            ['@name'] = 'Glovebox-'..plate,
                            ['@newName'] = 'Glovebox-'..newPlate
                        })
                    else
                        MySQL.Sync.execute('UPDATE user_inventory2 SET name=@newName WHERE name=@name',{
                            ['@name'] = 'Trunk- '..plate,
                            ['@newName'] = 'Trunk-'..newPlate
                        })
                        MySQL.Sync.execute('UPDATE user_inventory2 SET name=@newName WHERE name=@name',{
                            ['@name'] = 'Glovebox- '..plate,
                            ['@newName'] = 'Glovebox-'..newPlate
                        })
                    end
                end)
            end
        end
    end)
end)]]


-- Generate Plates

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
        generatedPlate = string.upper(GetRandomLetter(4) .. GetRandomNumber(3))

        local isPlateTaken = MySQL.Sync.fetchAll('SELECT id FROM owned_vehicles WHERE plate=@plate', {['@plate'] = generatedPlate})
        if isPlateTaken[1] == nil then
            doBreak = true
		end

		if doBreak then
			break
		end
	end
	return generatedPlate
end

function GetRandomNumber(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

function isPlateTaken(plate)
    local taken = MySQL.Sync.fetchAll('SELECT id FROM owned_vehicles WHERE plate=@plate', {['@plate'] = plate})
    if taken[1] == nil then
        return false
    else
        return true
    end
end
