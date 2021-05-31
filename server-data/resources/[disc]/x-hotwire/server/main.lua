ESX = nil

TriggerEvent('tac:getSharedObject', function(obj)
    ESX = obj
end)

RegisterServerEvent('baseevents:enteringVehicle')
AddEventHandler('baseevents:enteringVehicle', function()
    local player = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT id FROM owned_vehicles WHERE owner = @identifier AND plate = @plate', {
        ['@identifier'] = player.identifier,
        ['@plate'] = plate
    }, function(results)
        if results == 1 then 
            local xPlayer = ESX.GetPlayerFromId(source)
            local veh = GetVehiclePedIsIn(xPlayer, false)
            TriggerClientEvent("ARPF:spawn:recivekeys", source, veh,veh.plate)
        end
    end)
end)

RegisterNetEvent('ARPF:removeKit')
AddEventHandler('ARPF:removeKit', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    --xPlayer.removeInventoryItem('lockpick', 1)
    TriggerClientEvent('inventory:removeItem',source, "lockpick", 1) 
end)

RegisterServerEvent('disc-hotwire:givecash')
AddEventHandler('disc-hotwire:givecash', function(cashreward)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addMoney(cashreward)
end)

RegisterServerEvent('disc-hotwire:giveitem')
AddEventHandler('disc-hotwire:giveitem', function(itemreward, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('player:receiveItem',source, itemreward, count) 
end)

RegisterNetEvent('ARPF:GiveKeys')
AddEventHandler('ARPF:GiveKeys', function(closestplayer,veh,plate)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    nameplayer = GetName(xPlayer.identifier)
    local name = nameplayer.firstname..','..nameplayer.lastname
    TriggerClientEvent("ARPF:recivekeys", closestplayer,name,veh,plate)
end)


ESX.RegisterServerCallback('disc-hotwire:checkOwner', function(source, cb, plate)
    local player = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT id FROM owned_vehicles WHERE owner = @identifier AND plate = @plate', {
        ['@identifier'] = player.identifier,
        ['@plate'] = plate
    },  function(results)
        cb(#results == 1)
    end)
end)

function GetName(identifier)
    local result = MySQL.Sync.fetchAll("SELECT firstname,lastname FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
    if result[1] ~= nil then
        local identity = result[1]
        return {
            firstname = identity['firstname'],
            lastname = identity['lastname'],
        }
    else
        return nil
    end
end

--[[ESX.RegisterUsableItem('lockpick', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer ~= nil then
        --if IsPedInAnyVehicle(PlayerPedId(), false) then 
        TriggerClientEvent('disc-hotwire:hotwire', source, true)
    else
        print('xPlayer nil ?')
    end
end)]]