ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

local license = 0

local licenseArray = {}

RegisterServerEvent('sec:checkRobbed')
AddEventHandler('sec:checkRobbed', function(license)
    local _source = source

    if licenseArray[#licenseArray] ~= nil then
        for k, v in pairs(licenseArray) do
            if v == license then
            print('Bitch')
            return
            end
        end
    end

    licenseArray[#licenseArray+1] = license

    TriggerClientEvent('sec:AllowHeist', _source)
end)

RegisterServerEvent('nadrp-securityheists:banktstart')
AddEventHandler('nadrp-securityheists:banktstart', function(license)
    local copcount = 0
    local Players = ESX.GetPlayers()

    for i = 1, #Players, 1 do
        local xPlayer = ESX.GetPlayerFromId(Players[i])

        if xPlayer.job.name == "police" then
            copcount = copcount + 1
        end
    end
    if copcount >= 3     then
	    local xPlayer = ESX.GetPlayerFromId(source)
        TriggerClientEvent('sec:usegroup6card', source)
        TriggerClientEvent('inventory:removeItem', source, 'bluesec', 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source ,{type = 'inform', text = 'There is not enough police on duty!'})
    end
end)