ESX = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

local repayTime = 168 * 60 -- hours * 60

local carTable = {
	[1] = { ["model"] = "pcj", ["baseprice"] = 3000, ["commission"] = 10 }, 
	[2] = { ["model"] = "AKUMA", ["baseprice"] = 510000, ["commission"] = 15 },
	[3] = { ["model"] = "hexer", ["baseprice"] = 510000, ["commission"] = 20 },
	[4] = { ["model"] = "nemesis", ["baseprice"] = 401000, ["commission"] = 15 },
	[5] = { ["model"] = "manchez", ["baseprice"] = 362000, ["commission"] = 20 },
	[6] = { ["model"] = "defiler", ["baseprice"] = 100000, ["commission"] = 15 },
	[7] = { ["model"] = "sanctus", ["baseprice"] = 200000, ["commission"] = 15 },
}

--local carTable = {}

-- Update car table to server
RegisterServerEvent('bikeshop:table')
AddEventHandler('bikeshop:table', function(table)
    if table ~= nil then
        carTable = table
        TriggerClientEvent('bikeshop:returnTable', -1, carTable)
        updateDisplayVehicles()
    end
end)

-- Enables finance for 60 seconds
RegisterServerEvent('finance_bikeshop:enable')
AddEventHandler('finance_bikeshop:enable', function(plate)
    local src = source
    local ident = ESX.GetPlayerFromId(src).identifier
    if plate ~= nil then 
        MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier=@identifier', {
            ['@identifier'] = ident
        },function (result)
            if result ~= nil then
                local name = result[1].firstname..', '..result[1].lastname
                TriggerClientEvent('finance_bikeshop:enableOnClient', -1, plate, name)
            else
                TriggerClientEvent('finance_bikeshop:enableOnClient', -1, plate, 'error')
            end
        end)
    end
end)

RegisterServerEvent('bikeshop:buyEnable')
AddEventHandler('bikeshop:buyEnable', function(plate)
    local src = source
    local ident = ESX.GetPlayerFromId(src).identifier
    if plate ~= nil then
        MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier=@identifier', {
            ['@identifier'] = ident
        },function (result)
            if result ~= nil then
                local name = result[1].firstname..', '..result[1].lastname
                TriggerClientEvent('bikeshop:enableBuyOnClient', -1, plate, name)
            else
                TriggerClientEvent('bikeshop:enableBuyOnClient', -1, plate, 'error')
            end
        end)
    else
        TriggerClientEvent('mythic_notify:client:DoLongHudText', src, {type = 'error', text = 'There was an error getting the plate'})
    end
end)

-- return table
-- TODO (return db table)
RegisterServerEvent('bikeshop:requesttable')
AddEventHandler('bikeshop:requesttable', function()
    local user = ESX.GetPlayerFromId(source)
    local displays = MySQL.Sync.fetchAll('SELECT * FROM vehicles_display_bikeshop')
    for k,v in pairs(displays) do
        carTable[v.ID] = v
        v.price = carTable[v.ID].baseprice
    end
    TriggerClientEvent('veh_shop_bikeshop:returnTable', user.source, carTable)
end)

-- Check if player has enough money
RegisterServerEvent('bikeshop:CheckMoneyForVeh')
AddEventHandler('bikeshop:CheckMoneyForVeh', function(name, model,price,financed, commission)
	local user = ESX.GetPlayerFromId(source)
    local money = user.getMoney()
    if financed then
        local financedPrice = math.ceil(price / 4)
        if money >= financedPrice then
            user.removeMoney(financedPrice)
            TriggerClientEvent('bikeshop:FinishMoneyCheckForVeh', user.source, name, model, price, financed, commission)
        else
            TriggerClientEvent('mythic_notify:client:DoLongHudText', user.source, {type = 'error', text = 'You dont have enough money on you'})
            TriggerClientEvent('bikeshop:failedpurchase', user.source)
        end
    else
        if money >= price then
            user.removeMoney(price)
            TriggerClientEvent('bikeshop:FinishMoneyCheckForVeh',user.source, name, model, price, financed, commission)
        else
            TriggerClientEvent('mythic_notify:client:DoLongHudText', user.source, {type = 'error', text = 'You dont have enough money on you'})
            TriggerClientEvent('bikeshop:failedpurchase', user.source)
        end
    end
end)

-- Add the car to database when completed purchase
RegisterServerEvent('bikeshop:BuyForVeh')
AddEventHandler('bikeshop:BuyForVeh', function(vehicleProps,name, vehicle, price, financed, seller, commission, commissionbuy)
    local user = ESX.GetPlayerFromId(source)
    local ident = user.identifier
    local isPlateTaken = isPlateTaken(vehicleProps.plate)
    local Buyer = MySQL.Sync.fetchAll("SELECT firstname, lastname FROM users WHERE identifier=@identifier",{['@identifier'] = ident})
    local dateNow = os.time()
    local buyerName = Buyer[1].firstname..', '.. Buyer[1].lastname
    plate = GeneratePlate()
    vehicleProps.plate = plate
    if financed then
        local cols = 'owner, plate, vehicle, buy_price, finance, financetimer, vehiclename, shop'
        local val = '@owner, @plate, @vehicle, @buy_price, @finance, @financetimer, @vehiclename, @shop'
        local downPay = math.ceil(price / 4)
        local data = MySQL.Sync.fetchAll("SELECT money FROM addon_account_data WHERE account_name=@account_name",{['@account_name'] = 'bikedealer'})
        local curSociety = data[1].money
        MySQL.Async.execute('INSERT INTO owned_vehicles ( '..cols..' ) VALUES ( '..val..' )',{
            ['@owner']   = user.identifier,
            ['@plate']   = plate,
            ['@vehicle'] = json.encode(vehicleProps),
            ['@vehiclename'] = vehicle,
            ['@buy_price'] = price,
            ['@finance'] = price - downPay,
            ['@financetimer'] = repayTime,
            ['@lastpayment'] = dateNow,
            ['@shop'] = 'bikeshop'
        })
        MySQL.Sync.execute('UPDATE addon_account_data SET money=@money WHERE account_name=@account_name',{['@money'] = curSociety + commissionbuy,['@account_name'] = 'bikedealer'})
        LogSale(vehicle, plate, price, financed,seller, buyerName, dateNow, commission)
    else
        local data = MySQL.Sync.fetchAll("SELECT money FROM addon_account_data WHERE account_name=@account_name",{['@account_name'] = 'bikedealer'})
        local curSociety = data[1].money
        MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, vehiclename, buy_price, shop) VALUES (@owner, @plate, @vehicle, @vehiclename, @buy_price, @shop)',{
            ['@owner']   = user.identifier,
            ['@plate']   = plate,
            ['@vehicle'] = json.encode(vehicleProps),
            ['@vehiclename'] = vehicle,
            ['@buy_price'] = price,
            ['@lastpayment'] = dateNow,
            ["@shop"] = 'bikeshop'
        })
        MySQL.Sync.execute('UPDATE addon_account_data SET money=@money WHERE account_name=@account_name',{['@money'] = curSociety + commissionbuy,['@account_name'] = 'bikedealer'})
        LogSale(vehicle, plate, price, financed,seller, buyerName, dateNow, commission)
    end
end)

function updateDisplayVehicles()
    for i=1, #carTable do
        MySQL.Sync.execute("UPDATE vehicles_display_bikeshop SET model=@model, commission=@commission, baseprice=@baseprice WHERE ID=@ID",{
            ['@ID'] = i,
            ['@model'] = carTable[i]["model"],
            ['@commission'] = carTable[i]["commission"],
            ['@baseprice'] = carTable[i]["baseprice"]
        })
    end
end

function LogSale(model,plate,buyPrice,financed,seller,buyer,date,commission)
    if model ~= nil then
        MySQL.Async.execute('INSERT INTO vehicles_sold_bikeshop (model, plate, buy_price, financed, soldby, buyer, date,commission) VALUES (@model, @plate, @buy_price, @financed, @soldby, @buyer, @date, @commission)', {
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