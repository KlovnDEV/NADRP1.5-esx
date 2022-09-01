ESX = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_moneywash:withdraw')
AddEventHandler('esx_moneywash:withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	amount = tonumber(amount)
	local accountMoney = 0
	accountMoney = xPlayer.getAccount('black_money').money
	if amount == nil or amount <= 0 or amount > accountMoney then
		TriggerClientEvent('esx:showNotification', _source, _U('invalid_amount'))
	else
		xPlayer.removeAccountMoney('black_money', amount)
		xPlayer.addMoney(amount)
		TriggerClientEvent('esx:showNotification', _source, _U('wash_money') .. amount .. '~s~.')
		TriggerClientEvent('esx_moneywash:closeWASH', _source)
	end
end)



RegisterServerEvent('Ford:Wash')
AddEventHandler('Ford:Wash', function(itemCount, payout)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local payment  = (itemCount * payout)
    if itemCount and itemCount > 0 then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You washed ' .. itemCount .. ' rolls of dirty cash For $' .. payment })
        xPlayer.addMoney(payment)
    else
        Citizen.Wait(5000)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You dont have enough dirty money'})
    end
end)