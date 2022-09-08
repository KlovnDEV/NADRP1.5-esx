
ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('Ford:Trade')
AddEventHandler('Ford:Trade', function(itemCount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local payment  = (itemCount * math.random(180, 250))
    if itemCount and itemCount > 0 then
        TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'inform', text = 'Traded ' .. itemCount .. ' Diamonds For $' .. payment })
        xPlayer.addMoney(payment)
    else
        Citizen.Wait(5000)
        TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'error', text = 'You dont have enough Diamonds'})
    end
end)

RegisterServerEvent('Ford:Gold')
AddEventHandler('Ford:Gold', function(itemCount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local payment  = (itemCount * math.random(125, 250))
    if itemCount and itemCount > 0 then
        TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'inform', text = 'Traded ' .. itemCount .. ' Gold For $' .. payment })
        xPlayer.addMoney(payment)
    else
        Citizen.Wait(5000)
        TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'error', text = 'You dont have enough Gold'})
    end
end)

RegisterServerEvent('Ford:Copper')
AddEventHandler('Ford:Copper', function(itemCount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local payment  = (itemCount * math.random(5, 12))
    if itemCount and itemCount > 0 then
        TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'inform', text = 'Traded ' .. itemCount .. ' Copper For $' .. payment })
        xPlayer.addMoney(payment)
    else
        Citizen.Wait(5000)
        TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'error', text = 'You dont have enough Copper'})
    end
end)

RegisterServerEvent('Ford:Iron')
AddEventHandler('Ford:Iron', function(itemCount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local payment  = (itemCount * math.random(15, 35))
    if itemCount and itemCount > 0 then
        TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'inform', text = 'Traded ' .. itemCount .. ' Iron For $' .. payment })
        xPlayer.addMoney(payment)
    else
        Citizen.Wait(5000)
        TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'error', text = 'You dont have enough Iron'})
    end
end)
