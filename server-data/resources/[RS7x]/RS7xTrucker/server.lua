ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('RS7xTrucker:PayPlayer')
AddEventHandler('RS7xTrucker:PayPlayer', function(amount, runCount)
    local src = source
    local user = ESX.GetPlayerFromId(src)
    local payment = (Config.Payout * runCount)
    if amount == 1500 and runCount <= 5 and payment < 20000 then
        user.addMoney(payment)
    else
        local data = {
			name = GetPlayerName(user.source),
			reason = 'Attempted Lua injection (RS7xTrucking)',
			identifiers = GetPlayerIdentifiers(user.source),
			info = string.format("Payment: **%s** | Amount Detected: **%s** | Runs Detected: **%s**",payment,amount,runCount)
		}
		exports['ffrp-log']:DiscordLog(data)
    end
end)