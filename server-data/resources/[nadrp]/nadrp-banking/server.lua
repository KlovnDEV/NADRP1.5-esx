ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

local balances = {}
local timer = ((60 * 1000) * 25)
local closedBanks = {
    [1] = {["x"] = 150.266, ["y"] = -1040.203, ["z"] = 29.374, ["closed"] = false, ["timer"] = timer},
    [2] = {["x"] = -1212.980, ["y"] = -330.841, ["z"] = 37.787, ["closed"] = false, ["timer"] = timer},
    [3] = {["x"] = -2962.582, ["y"] = 482.627, ["z"] = 15.703, ["closed"] = false, ["timer"] = timer},
    [4] = {["x"] = -112.202, ["y"] = 6469.295, ["z"] = 31.626, ["closed"] = false, ["timer"] = timer},
    [5] = {["x"] = 314.187, ["y"] = -278.621, ["z"] = 54.170, ["closed"] = false, ["timer"] = timer},
    [6] = {["x"] = -351.534, ["y"] = -49.529, ["z"] = 49.042, ["closed"] = false, ["timer"] = timer},
    [7] = {["x"] = 241.727, ["y"] = 220.706, ["z"] = 106.286, ["closed"] = false, ["timer"] = timer},
    [8] = {["x"] = 1176.083, ["y"] = 2706.338, ["z"] = 37.157, ["closed"] = false, ["timer"] = timer}
}

RegisterServerEvent('nadrp-banking:updateClosedBank')
AddEventHandler('nadrp-banking:updateClosedBank', function(bankid)
    closedBanks[bankid]["closed"] = true
    TriggerClientEvent('nadrp-banking:updateClosedBank', -1, closedBanks)
end)

RegisterServerEvent('nadrp-banking:resetClosedBank')
AddEventHandler('nadrp-banking:resetClosedBank', function(bankid)
    closedBanks[bankid]["closed"] = false
    closedBanks[bankid]["timer"] = timer
    Wait(1000)
    TriggerClientEvent('nadrp-banking:updateClosedBank', -1, closedBanks)
end)


AddEventHandler('es:playerLoaded', function(source, user)
    balances[source] = user.getBank()
    TriggerClientEvent('nadrp-banking:updateBalance', source, user.getBank())
end)

--[[RegisterServerEvent('playerSpawned')
AddEventHandler('playerSpawned', function(src)
    local user = ESX.GetPlayerFromId(src)
    --TriggerEvent('es:getPlayerFromId', source, function(user)
        balances[source] = user.getBank()
        TriggerClientEvent('nadrp-banking:updateBalance', source, user.getBank())
    --end)
end)]]

AddEventHandler('playerDropped', function()
    balances[source] = nil
end)

RegisterCommand('cash', function(source, args, raw)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('nadrp-banking:viewCash', source, xPlayer.getMoney())
end)

-- HELPER FUNCTIONS
function bankBalance(player)
    return exports.essentialmode:getPlayerFromId(player).getBank()
end

function deposit(player, amount)
    local bankbalance = bankBalance(player)
    local new_balance = bankbalance + math.abs(amount)
    balances[player] = new_balance

    local user = exports.essentialmode:getPlayerFromId(player)
    TriggerClientEvent("nadrp-banking:updateBalance", source, new_balance)
    user.addBank(math.abs(amount))
    user.removeMoney(math.abs(amount))
end

function withdraw(player, amount)
    local bankbalance = bankBalance(player)
    local new_balance = bankbalance - math.abs(amount)
    balances[player] = new_balance

    local user = exports.essentialmode:getPlayerFromId(player)
    TriggerClientEvent("nadrp-banking:updateBalance", source, new_balance)
    user.removeBank(math.abs(amount))
    user.addMoney(math.abs(amount))
end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.abs(math.floor(num * mult + 0.5) / mult)
end

local notAllowedToDeposit = {}

AddEventHandler('nadrp-bank:addNotAllowed', function(pl)
  notAllowedToDeposit[pl] = true

  local savedSource = pl
  SetTimeout(300000, function()
    notAllowedToDeposit[savedSource] = nil
  end)
end)

-- Bank Deposit

RegisterServerEvent('nadrp-bank:deposit')
AddEventHandler('nadrp-bank:deposit', function(amount)
    if not amount then return end

    TriggerEvent('es:getPlayerFromId', source, function(user)
        local rounded = math.ceil(tonumber(amount))
        if(string.len(rounded) >= 9) then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = "error", text = "Input too high!"})
        else
            if(rounded <= user.getMoney()) then
                TriggerClientEvent("nadrp-banking:updateBalance", source, (user.getBank() + rounded))
                TriggerClientEvent("nadrp-banking:addBalance", source, rounded)
                
                deposit(source, rounded)
                local new_balance = user.getBank()
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = "error", text = "Input too high!"})
            end
        end
    end)
end)


RegisterServerEvent('nadrp-bank:withdraw')
AddEventHandler('nadrp-bank:withdraw', function(amount)
    if not amount then return end

    TriggerEvent('es:getPlayerFromId', source, function(user)
        local rounded = round(tonumber(amount), 0)
        if(string.len(rounded) >= 9) then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = "error", text = "Input too high!"})
        else
            local bankbalance = user.getBank()
            if(tonumber(rounded) <= tonumber(bankbalance)) then
                TriggerClientEvent("nadrp-banking:updateBalance", source, (user.getBank() - rounded))
                TriggerClientEvent("nadrp-banking:removeBalance", source, rounded)
                withdraw(source, rounded)
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = "error", text = "Not enough money in account!"})
            end
        end
    end)
end)

RegisterServerEvent('nadrp-bank:transfer')
AddEventHandler('nadrp-bank:transfer', function(to, amountt)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromId(to)
	local amount = amountt
	local balance = 0

	if(xTarget == nil or xTarget == -1) then
		TriggerClientEvent('orp:bank:notify', _source, "error", "Recipient not found")
	else
		balance = xPlayer.getAccount('bank').money
		zbalance = xTarget.getAccount('bank').money

		if tonumber(_source) == tonumber(to) then
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = "error", text = "You cannot transfer money to yourself"})
		else
			if balance <= 0 or balance < tonumber(amount) or tonumber(amount) <= 0 then
                TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = "error", text = "You don't have enough money for this transfer"})
			else
				xPlayer.removeAccountMoney('bank', tonumber(amount))
				xTarget.addAccountMoney('bank', tonumber(amount))
                TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = "success", text = "You successfully transfered $" .. amount})
                TriggerClientEvent('mythic_notify:client:SendAlert', to, {type = "success", text = "You have just received $" .. amount .. ' via transfer'})
                TriggerClientEvent('nadrp-banking:viewBalance', to)
			end
		end
	end
end)


RegisterServerEvent('nadrp-bank:givecash')
AddEventHandler('nadrp-bank:givecash', function(toPlayer, amount)
    local user = ESX.GetPlayerFromId(source)
    local recipient = ESX.GetPlayerFromId(toPlayer)
    if tonumber(source) ~= tonumber(toPlayer) then
        if (tonumber(user.getMoney()) >= tonumber(amount)) then
            recipient.addMoney(amount)
            user.removeMoney(amount)
            --TriggerClientEvent('nadrp-banking:updateCash', user.getMoney(), true)
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = "inform", text = "You just gave $" .. amount})
        else
            if (tonumber(user.getMoney()) < tonumber(amount)) then
                TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = "error", text = "Not enough money in wallet!"})
            end
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = "error", text = "You cant give yourself money!"})
    end
end)

AddEventHandler('es:playerLoaded', function(source)
    TriggerEvent('es:getPlayerFromId', source, function(user)
        local bankbalance = user.getBank()
        TriggerClientEvent("nadrp-banking:updateBalance", source, bankbalance)
        user.displayBank(bankbalance)
    end)
end)


ESX.RegisterServerCallback('getCash', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local cash = xPlayer.getMoney()
    if cash ~= nil then
        cb(cash)
    else
        cb(nil)
    end
end)

ESX.RegisterServerCallback('getName', function(source, cb)
    local identifier = GetPlayerIdentifiers(source)[1]
    local result = MySQL.Sync.fetchAll("SELECT firstname,lastname FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
    if result[1] ~= nil then
        local identity = result[1]

        local data = {
            firstname = identity['firstname'],
            lastname = identity['lastname'],
        }
        cb(data)
    else
        cb(nil)
    end
end)