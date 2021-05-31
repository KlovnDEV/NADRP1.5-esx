ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

-- Oxy Run
RegisterServerEvent('oxydelivery:server')
AddEventHandler('oxydelivery:server', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= Config.StartOxyPayment then
		xPlayer.removeMoney(Config.StartOxyPayment)
		TriggerClientEvent("oxydelivery:startDealing", source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, {type = 'error',  text='You don\'t have enough money to start an oxy run'})
	end
end)

RegisterServerEvent('oxydelivery:HexGetPlayerIP')
AddEventHandler('oxydelivery:HexGetPlayerIP', function(identifier, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	if type == 'steam' and identifier > 0 then
		xPlayer.addMoney(Config.Payment / 2)
	elseif identifier > 0 then
		xPlayer.addMoney(Config.Payment)
	end
end)

local recent = false
RegisterServerEvent('oxydelivery:receivemoney')
AddEventHandler('oxydelivery:receivemoney', function(amount)
	local user = ESX.GetPlayerFromId(source)
	local Payment = Config.Payment
	if amount <= 410 then
		if not recent then
			user.addMoney(Payment)
			recent = true
			Citizen.Wait(5000)
			recent = false
		end
	else
		local data = {
			name = GetPlayerName(user.source),
			reason = 'Attempted to exploit oxy',
			identifiers = GetPlayerIdentifiers(user.source),
			info = string.format("Payment: **%s** | Amount Detected: **%s** ", Payment, amount)
		}
		exports['ffrp-log']:DiscordLog(data)
	end
end)