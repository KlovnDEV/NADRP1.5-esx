ESX = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
local ammoTable = {}

RegisterServerEvent('nadrp-weapons:UpdateAmmo')
AddEventHandler('nadrp-weapons:UpdateAmmo', function(ammo, type, ammoTable)
    --print('^2 UPDATE AMMO: ^0', ammo, type, ammoTable)
    local player = ESX.GetPlayerFromId(source)
    local ident = player.identifier
    local aTable = ammoTable
    if table ~= nil then
        MySQL.Async.fetchAll('SELECT ammoTable FROM users WHERE identifier=@identifier', {
           ['@identifier'] = ident
        },function(result)
            if result[1] ~= nil then
                MySQL.Sync.execute("UPDATE users SET ammoTable=@ammoTable WHERE identifier=@ident", {
                    ['@ident'] = ident,
                    ['@ammoTable'] = json.encode(aTable)
                })
                TriggerClientEvent('nadrp-weapons:SetAmmo', player.source, json.decode(ammoTable["ammoTable"]))
            else
                --MySQL.Sync.execute('INSERT INTO users SET identifier=@ident ammo=@ammo type=@type', {['@ammo'] = ammo, ['@type'] = type,['@ident'] = ident})
                MySQL.Sync.execute('INSERT INTO users (identifier, ammoTable) VALUES (@ident, @ammoTable)', {
                    ['@ident'] = ident,
                    ['@ammoTable'] = json.encode(aTable)
                })
            end
        end)
    end
end)

--[[AddEventHandler('onResourceStart', function(res)
    TriggerClientEvent('nadrp-onStart', source)
end)]]

RegisterServerEvent('nadrp-weapons:getAmmo')
AddEventHandler('nadrp-weapons:getAmmo', function()
    --print('^2 GET AMMO: ^0')
    local src = source
    local player = ESX.GetPlayerFromId(src)
    local ident = player.identifier
    MySQL.Async.fetchAll('SELECT ammoTable FROM users WHERE identifier=@identifier', {
        ['@identifier'] = ident
    }, function(pAmmo)
        if pAmmo[1] then
            local aTable = pAmmo[1].ammoTable
            TriggerClientEvent('nadrp-weapons:SetAmmo', src, json.decode(aTable))
        else
            TriggerClientEvent('nadrp-weapons:SetAmmo', src, {})
        end
    end)
end)

RegisterServerEvent('nadrp-weapons:setAmmo')
AddEventHandler('nadrp-weapons:setAmmo', function()
    --print('^2 SET AMMO: ^0')
    if ammoTable ~= nil or ammoTable ~= "{}" then
        TriggerClientEvent('nadrp-weapons:SetAmmo', src, ammoTable)
    else
        TriggerClientEvent('nadrp-weapons:SetAmmo', src, {})
    end
end)

--pAmmo[1].ammoTable
--np-items:SetAmmo