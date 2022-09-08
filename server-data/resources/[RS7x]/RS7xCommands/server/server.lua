ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

--[[ESX.RegisterUsableItem('binoculars', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('binoculars:Activate2', source)
end)

ESX.RegisterUsableItem('idcard', function(source)
    TriggerClientEvent('RS7x:showid', source)
end)

ESX.RegisterUsableItem('repairkit', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local chance = math.random(1,10)
   --if chance >= 7 then
   --    xPlayer.removeInventoryItem('repairkit',1)
   --end
    TriggerClientEvent('RS7x:OnRepair', source, false)
end)

ESX.RegisterUsableItem('repairkit1', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local chance = math.random(1,10)
    --if chance >= 7 then
    --    xPlayer.removeInventoryItem('repairkit1',1)
    --end
    TriggerClientEvent('RS7x:OnRepair', source, false)
end)

ESX.RegisterUsableItem('advrepairkit', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    --xPlayer.removeInventoryItem('advrepairkit',1)
    TriggerClientEvent('RS7x:OnRepair', source, true)
end)]]


--/////////////////////////
---  Server Events
--///////////////////////

RegisterNetEvent('RS7x:GiveJoints')
AddEventHandler('RS7x:GiveJoints', function(boj)
    local xPlayer = ESX.GetPlayerFromId(source)

    if boj == 'joints' then
        xPlayer.removeInventoryItem('trimmedweed', 5)
        xPlayer.addInventoryItem('joint', 10)
    elseif boj == 'blunts'  then
        xPlayer.removeInventoryItem('trimmedweed', 10)
        xPlayer.addInventoryItem('blunt', 5)
    end
end)

--[[RegisterServerEvent('RS7x:GetCuffs')
AddEventHandler('RS7x:GetCuffs', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = exports['nadrp-inventory']:hasEnoughOfItem('handcuffs', 1)
    if item then
        TriggerClientEvent('menu:hasCuffs', source, true)
    else
        TriggerClientEvent('menu:hasCuffs', source,false)
    end
end)]]

--[[RegisterServerEvent('RS7x:number_sv')
AddEventHandler('RS7x:number_sv', function(number, Players)
    if Players < 5.0 then
        if number ~= nil then
            TriggerClientEvent('chat:addMessage', Players, {
                template = '<div class="chat-message nonemergency">Phone Number : {0} </div>',
                args = { number }
            })
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div class="chat-message nonemergency">Phone Number : {0} </div>',
                args = { number }
            })
        end
    end
end)]]

RegisterServerEvent('RS7x:showid_sv')
AddEventHandler('RS7x:showid_sv', function(data, pPlayer)
    cunt = data
    name = cunt.Name
    dob = cunt.dateofbirth
    job = firstToUpper(cunt.job)
    sex = cunt.sex
    cid = cunt.cid
    if sex == 'm' then
        sex = 'Male'
    else
        sex = 'Female'
    end
    TriggerClientEvent('chat:addMessage', pPlayer, {
        template = '<div class="chat-message nonemergency">Citizen Card | Name : {0} | DOB : {1} | Job : {2}  | Sex : {3} : | CitizenID (CID) : {4} </div>',
        args = {name, dob, job, sex, cid}
    })
end)

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

RegisterServerEvent('RS7x:canBuyID')
AddEventHandler('RS7x:canBuyID', function()
    local user = ESX.GetPlayerFromId(source)
    local amount = user.getMoney()
    if amount >= 500 then
        user.removeMoney(500)
        TriggerClientEvent('player:receiveItem',user.source,'idcard', 1)
    else
        TriggerClientEvent('mythic_notify:client:DoLongHudText', user.source, { type = 'error', text = "You don't have enough money for this"})
    end
end)

--//////////////////////////////
--         Commands
--/////////////////////////////

--RegisterCommand('pn', function (source, args, raw)
--    TriggerClientEvent('RS7x:number', source)
--end, false)

function getPrint(target)
    local identifier = GetPlayerIdentifiers(target)[1]
    local result = MySQL.Sync.fetchAll("SELECT identifier,name,firstname,lastname,dateofbirth,sex,height,job,group FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
    if result[1] ~= nil then
        local identity = result[1]

        return {
            identifier = identity['identifier'],
            name = identity['name'],
            firstname = identity['firstname'],
            lastname = identity['lastname'],
            dateofbirth = identity['dateofbirth'],
            sex = identity['sex'],
            height = identity['height'],
            job = identity['job'],
            group = identity['group']
        }
    else
        return nil
    end
end

ESX.RegisterServerCallback('RS7x:ident', function(source, cb)
    local identifier = GetPlayerIdentifiers(source)[1]
    local result = MySQL.Sync.fetchAll("SELECT identifier,name,firstname,lastname,dateofbirth,sex,height,job,group FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
    if result[1] ~= nil then
        local identity = result[1]
        if identity['sex'] == 'M' then
            sex = 'Male'
        else
            sex = 'Female'
        end
        cb({
            identifier = identity['identifier'],
            name = identity['name'],
            firstname = identity['firstname'],
            lastname = identity['lastname'],
            dateofbirth = identity['dateofbirth'],
            sex = sex,
            height = identity['height'],
            job = identity['job'],
            group = identity['group']
        })
    else
        return cb(nil)
    end
end)