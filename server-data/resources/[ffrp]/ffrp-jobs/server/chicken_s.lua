ESX = nil

TriggerEvent('tac:getSharedObject', function(obj)
	ESX = obj
end)
RegisterServerEvent('Ford:Trade2')
AddEventHandler('Ford:Trade2', function(itemCount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local payment  = (itemCount * math.random(155,170))
    if itemCount and itemCount > 0 then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Traded ' .. itemCount .. ' Chicken For $' .. payment })
        xPlayer.addMoney(payment)
    else
        Citizen.Wait(5000)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You dont have enough Chicken'})
    end
end)