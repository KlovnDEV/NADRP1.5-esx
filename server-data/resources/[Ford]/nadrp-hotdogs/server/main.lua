ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)


-- Code

local Bail2 = {}

ESX.RegisterServerCallback('qb-hotdogjob:server:HasMoney', function(source, cb)
    local Player = ESX.GetPlayerFromId(source)

    if Player.getMoney() >= Config.Bail then
        table.insert(Bail2, { PlayerID = Player.identifier, Bail = true})
        Player.removeMoney(Config.Bail)
        cb(true)
    elseif Player.getAccount('bank').money >= Config.Bail then
        table.insert(Bail2, { PlayerID = Player.identifier, Bail = true})
        Player.removeAccountMoney('bank', Config.Bail)
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('qb-hotdogjob:server:BringBack', function(source, cb)
    local Player = ESX.GetPlayerFromId(source)
    local checked = false

    for k,v in pairs(Bail2) do
        if v.PlayerID == Player.identifier then
            Player.addMoney(Config.Bail)
            table.remove(Bail2, k)
            checked = true
        else
            checked = false
        end
    end

    if checked then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('qb-hotdogjob:server:Sell')
AddEventHandler('qb-hotdogjob:server:Sell', function(Amount, Price)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local amount = tonumber(Amount*Price)
    Player.addMoney(amount)
end)

local Reset = false

-- QBCore.Commands.Add("removestand", "", {}, false, function(source, args)
--     TriggerClientEvent('qb-hotdogjob:staff:DeletStand', source)
-- end, 'admin')