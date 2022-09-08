ESX = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

local repayTime = 168 * 60 -- hours * 60
local requesting = false

local carTable = {
	[1] = { ["model"] = "prototipo", ["baseprice"] = 1400000, ["commission"] = 15 }, 
	[2] = { ["model"] = "thrax", ["baseprice"] = 1350000, ["commission"] = 15 },
	[3] = { ["model"] = "laferrari17", ["baseprice"] = 2000000, ["commission"] = 15 },
	[4] = { ["model"] = "lp700r", ["baseprice"] = 1500000, ["commission"] = 15 },
	[5] = { ["model"] = "p1", ["baseprice"] = 1800000, ["commission"] = 15 },
}

-- Update car table to server
RegisterServerEvent('carshop_imports:table')
AddEventHandler('carshop_imports:table', function(table)
    if table ~= nil then
        carTable = table
        TriggerClientEvent('veh_shop_imports:returnTable', -1, carTable)
        updateDisplayVehicles()
    end
end)

-- Enables finance for 60 seconds
RegisterServerEvent('finance_imports:enable')
AddEventHandler('finance_imports:enable', function(plate)
    local src = source
    local user = ESX.GetPlayerFromId(src)
    local ident = user.identifier
    if plate ~= nil then 
        MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier=@identifier', {
            ['@identifier'] = ident
        },function (result)
            if result ~= nil then
                local name = result[1].firstname..', '..result[1].lastname
                TriggerClientEvent('finance_imports:enableOnClient', -1, plate, name)
            else
                TriggerClientEvent('finance_imports:enableOnClient', -1, plate, 'error')
            end
        end)
    end
end)

RegisterServerEvent('imports:buyEnable')
AddEventHandler('imports:buyEnable', function(plate)
    local src = source
    local user = ESX.GetPlayerFromId(src)
    local ident = user.identifier
    if plate ~= nil then
        MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier=@identifier', {
            ['@identifier'] = ident
        },function (result)
            if result ~= nil then
                local name = result[1].firstname..', '..result[1].lastname
                TriggerClientEvent('finance_imports:enableBuyOnClient', -1, plate, name)
            else
                TriggerClientEvent('finance_imports:enableBuyOnClient', -1, plate, 'error')
            end
        end)
    else
        TriggerClientEvent('mythic_notify:client:DoLongHudText', src, {type = 'error', text = 'There was an error getting the plate'})
    end
end)

-- return table
RegisterServerEvent('carshop_imports:requesttable')
AddEventHandler('carshop_imports:requesttable', function()
    local user = ESX.GetPlayerFromId(source)
    local displays = MySQL.Sync.fetchAll('SELECT * FROM vehicles_display_imports')
    if not requesting then
        requesting = true
        for k,v in pairs(displays) do
            carTable[v.id] = v
            v.price = carTable[v.id].baseprice
        end
        TriggerClientEvent('veh_shop_imports:returnTable', user.source, carTable)
        requesting = false
    end
end)

-- Check if player has enough money
RegisterServerEvent('imports:CheckMoneyForVeh')
AddEventHandler('imports:CheckMoneyForVeh', function(name, model,price,financed, commission)
	local user = ESX.GetPlayerFromId(source)
    local money = user.getMoney()
    if financed then
        local financedPrice = math.ceil(price / 4)
        if money >= financedPrice then
            user.removeMoney(financedPrice)
            TriggerClientEvent('imports:FinishMoneyCheckForVeh', user.source, name, model, price, financed, commission)
        else
            TriggerClientEvent('mythic_notify:client:DoLongHudText', user.source, {type = 'error', text = 'You dont have enough money on you'})
            TriggerClientEvent('carshop_imports:failedpurchase', user.source)
        end
    else
        if money >= price then
            user.removeMoney(price)
            TriggerClientEvent('imports:FinishMoneyCheckForVeh',user.source, name, model, price, financed, commission)
        else
            TriggerClientEvent('mythic_notify:client:DoLongHudText', user.source, {type = 'error', text = 'You dont have enough money on you'})
            TriggerClientEvent('carshop_imports:failedpurchase', user.source)
        end
    end
end)

-- Add the car to database when completed purchase
RegisterServerEvent('imports:BuyForVeh')
AddEventHandler('imports:BuyForVeh', function(vehicleProps,name, vehicle, price, financed, seller, commission, commissionbuy)
    local user = ESX.GetPlayerFromId(source)
    local ident = user.identifier
    local Buyer = MySQL.Sync.fetchAll("SELECT firstname, lastname FROM users WHERE identifier=@identifier",{['@identifier'] = ident})
    local dateNow = os.time()
    local buyerName = Buyer[1].firstname..', '.. Buyer[1].lastname
    plate = GeneratePlate()
    vehicleProps.plate = plate
    if financed then
        local cols = 'owner, plate, vehicle, buy_price, finance, financetimer, vehiclename, shop,lastpayment'
        local val = '@owner, @plate, @vehicle, @buy_price, @finance, @financetimer, @vehiclename, @shop,@lastpayment'
        local downPay = math.ceil(price / 4)
        local data = MySQL.Sync.fetchAll("SELECT money FROM addon_account_data WHERE account_name=@account_name",{['@account_name'] = 'cardealer'})
        local curSociety = data[1].money
        MySQL.Async.execute('INSERT INTO owned_vehicles ( '..cols..' ) VALUES ( '..val..' )',{
            ['@owner']   = user.identifier,
            ['@plate']   = vehicleProps.plate,
            ['@vehicle'] = json.encode(vehicleProps),
            ['@vehiclename'] = vehicle,
            ['@buy_price'] = price,
            ['@finance'] = price - downPay,
            ['@financetimer'] = repayTime,
            ['@shop'] = 'imports',
            ['@lastpayment'] = dateNow
        })
        MySQL.Sync.execute('UPDATE addon_account_data SET money=@money WHERE account_name=@account_name',{['@money'] = curSociety + commissionbuy,['@account_name'] = 'cardealer'})
        LogSale(vehicle, vehicleProps.plate, price, financed,seller, buyerName, dateNow, commission)
        TriggerClientEvent('carshop:newPlate', user.source, plate)
    else
        local data = MySQL.Sync.fetchAll("SELECT money FROM addon_account_data WHERE account_name=@account_name",{['@account_name'] = 'cardealer'})
        local curSociety = data[1].money
        MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, vehiclename, buy_price, shop,lastpayment) VALUES (@owner, @plate, @vehicle, @vehiclename, @buy_price, @shop,@lastpayment)',{
            ['@owner']   = user.identifier,
            ['@plate']   = vehicleProps.plate,
            ['@vehicle'] = json.encode(vehicleProps),
            ['@vehiclename'] = vehicle,
            ['@buy_price'] = price,
            ["@shop"] = 'imports',
            ['@lastpayment'] = dateNow
        })
        MySQL.Sync.execute('UPDATE addon_account_data SET money=@money WHERE account_name=@account_name',{['@money'] = curSociety + commissionbuy,['@account_name'] = 'cardealer'})
        LogSale(vehicle, vehicleProps.plate, price, financed,seller, buyerName, dateNow, commission)
        TriggerClientEvent('carshop:newPlate', user.source, plate)
    end
end)

function updateDisplayVehicles()
    for i=1, #carTable do
        MySQL.Async.execute("UPDATE vehicles_display_imports SET model=@model, commission=@commission, baseprice=@baseprice WHERE id=@id",{
            ['@id'] = i,
            ['@model'] = carTable[i]["model"],
            ['@commission'] = carTable[i]["commission"],
            ['@baseprice'] = carTable[i]["baseprice"]
        })
    end
end

function LogSale(model,plate,buyPrice,financed,seller,buyer,date,commission)
    if model ~= nil then
        MySQL.Async.execute('INSERT INTO vehicles_sold_imports (model, plate, buy_price, financed, soldby, buyer, date,commission) VALUES (@model, @plate, @buy_price, @financed, @soldby, @buyer, @date, @commission)', {
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

RegisterServerEvent('imports:refreshDisplay')
AddEventHandler('imports:refreshDisplay', function()
    TriggerClientEvent('imports:refreshDisplay', -1)
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        updateDisplayVehicles()
    end
end)


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