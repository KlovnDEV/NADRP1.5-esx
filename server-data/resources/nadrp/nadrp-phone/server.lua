MySQL.ready(function ()
    TriggerEvent('deleteAllYP')
end)

ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

local callID = nil

Citizen.CreateThread(function()
	local uptimeMinute, uptimeHour, uptime = 0, 0, ''

	while true do
		Citizen.Wait(1000 * 60) -- every minute
		uptimeMinute = uptimeMinute + 1

		if uptimeMinute == 60 then
			uptimeMinute = 0
			uptimeHour = uptimeHour + 1
		end

		uptime = string.format("%02dh %02dm", uptimeHour, uptimeMinute)
        --SetConvarServerInfo('Uptime', uptime)
        TriggerClientEvent('phone:setServerTime', -1, uptime)
	end
end)

--[[ Twitter Stuff ]]
RegisterNetEvent('GetTweets')
AddEventHandler('GetTweets', function(onePlayer)
    local source = source
    -- MySQL.Async.fetchAll('SELECT * FROM tweets', {}, function(tweets)
    MySQL.Async.fetchAll('SELECT * FROM (SELECT * FROM tweets ORDER BY `time` DESC LIMIT 50) sub ORDER BY time ASC', {}, function(tweets) -- Get most recent 100 tweets
        if onePlayer then
            TriggerClientEvent('Client:UpdateTweets', source, tweets)
        else
            TriggerClientEvent('Client:UpdateTweets', source, tweets)
        end
    end)
end)

RegisterNetEvent('Tweet')
AddEventHandler('Tweet', function(handle, data, time)
    local handle = handle
    local src = source

    MySQL.Async.execute('INSERT INTO tweets (handle, message, time) VALUES (@handle, @message, @time)', {
        ['@handle'] = handle,
        ['@message'] = data,
        ['@time'] = time
    }, function(result)
        TriggerClientEvent('Client:UpdateTweet', -1, data, handle)
        TriggerEvent('GetTweets', true, src)
    end)
end)

RegisterNetEvent('Server:GetHandle')
AddEventHandler('Server:GetHandle', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = xPlayer.identifier
    local name = getIdentity(src)	
    fal = "@" .. name.firstname .. "_" .. name.lastname
    local handle = fal
    TriggerClientEvent('givemethehandle', src, handle)
end)

function getIdentity(target)
	local identifier = GetPlayerIdentifiers(target)[1]
	local result = MySQL.Sync.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
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

--[[ Contacts stuff ]]

RegisterNetEvent('phone:addContact')
AddEventHandler('phone:addContact', function(name, number)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.execute('INSERT INTO phone_contacts (identifier, name, number) VALUES (@identifier, @name, @number)', {
        ['@identifier'] = xPlayer.getIdentifier(),
        ['@name'] = name,
        ['@number'] = number
    }, function(result)
        TriggerClientEvent('refreshContacts', xPlayer.source)
    end)
end)

RegisterNetEvent('getContacts')
AddEventHandler('getContacts', function(myPhone, pSrc)
    local src = source
    if src ~= nil then
        local xPlayer = ESX.GetPlayerFromId(src)
        MySQL.Async.fetchAll('SELECT * FROM phone_contacts WHERE identifier = @identifier', { ['@identifier'] = xPlayer.identifier }, function(contacts)
            TriggerClientEvent('phone:loadContacts', src, contacts)
        end)
    end
end)

RegisterNetEvent('deleteContact')
AddEventHandler('deleteContact', function(name, number)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.execute('DELETE FROM phone_contacts WHERE identifier = @identifier AND name = @name AND number = @number LIMIT 1', {
        ['@identifier'] = xPlayer.identifier,
        ['@name'] = name,
        ['@number'] = number
    }, function(result)
        TriggerClientEvent('phone:deleteContact', src, name, number)
    end)
end)

--[[ Phone calling stuff ]]

function getNumberPhone(identifier)
    local result = MySQL.Sync.fetchAll("SELECT users.phone_number FROM users WHERE users.identifier = @identifier", {
        ['@identifier'] = identifier
    })
    if result[1] ~= nil then
        return result[1].phone_number
    end
    return nil
end

function getIdentifierByPhoneNumber(phone_number)
    local result = MySQL.Sync.fetchAll("SELECT users.identifier FROM users WHERE users.phone_number = @phone_number", {
        ['@phone_number'] = phone_number
    })
    if result[1] ~= nil then
        return result[1].identifier
    end
    return nil
end

RegisterNetEvent('phone:callContact')
AddEventHandler('phone:callContact', function(targetnumber, toggle, isPayphone)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local targetIdentifier = getIdentifierByPhoneNumber(targetnumber)
    local xPlayers = ESX.GetPlayers()
    local srcIdentifier = xPlayer.getIdentifier()
    local srcPhone = getNumberPhone(srcIdentifier)
    local playerID = 0
    if isPayphone then
        xPlayer.removeMoney(25)
    end
    TriggerClientEvent('phone:initiateCall', src, src)

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer then
          if xPlayer.identifier == targetIdentifier then
            playerID = xPlayer.source
          end
        end
    end
    if playerID > 0 and playerID ~= nil then
        TriggerClientEvent('phone:receiveCall', playerID, targetnumber, src, srcPhone, isPayphone)
    end
end)

RegisterNetEvent('phone:getSMS')
AddEventHandler('phone:getSMS', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local mynumber = getNumberPhone(xPlayer.identifier)
    local result = MySQL.Sync.fetchAll("SELECT * FROM phone_messages WHERE receiver = @mynumber OR sender = @mynumber ORDER BY id DESC", {['@mynumber'] = mynumber})

    local numbers ={}
    local convos = {}
    local valid

    for k, v in pairs(result) do
        valid = true
        if v.sender == mynumber then
            for i=1, #numbers, 1 do
                if v.receiver == numbers[i] then
                    valid = false
                end
            end
            if valid then
                table.insert(numbers, v.receiver)
            end
        elseif v.receiver == mynumber then
            for i=1, #numbers, 1 do
                if v.sender == numbers[i] then
                    valid = false
                end
            end
            if valid then
                table.insert(numbers, v.sender)
            end
        end
    end
    
    for i, j in pairs(numbers) do
        for g, f in pairs(result) do
            if j == f.sender or j == f.receiver then
                table.insert(convos, {
                    id = f.id,
                    sender = f.sender,
                    receiver = f.receiver,
                    message = f.message,
                    date = f.date
                })
                break
            end
        end
    end
    
    local data = ReverseTable(convos)
    TriggerClientEvent('phone:loadSMS', src, data, mynumber)
end)

function ReverseTable(t)
    local reversedTable = {}
    local itemCount = #t
    for k, v in ipairs(t) do
        reversedTable[itemCount + 1 - k] = v
    end
    return reversedTable
end

RegisterNetEvent('phone:sendSMS')
AddEventHandler('phone:sendSMS', function(receiver, message)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local mynumber = getNumberPhone(xPlayer.identifier)
    local target = getIdentifierByPhoneNumber(receiver)

    local xPlayers = ESX.GetPlayers()
    if receiver ~= mynumber then
        MySQL.Async.execute('INSERT INTO phone_messages (sender, receiver, message) VALUES (@sender, @receiver, @message)', {
            ['@sender'] = mynumber,
            ['@receiver'] = receiver,
            ['@message'] = message
        }, function(result)
        end)
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer then
                if xPlayer.identifier == target then
                    local receiverID = xPlayer.source
                    TriggerClientEvent('phone:newSMS', receiverID, 1, mynumber)
                    TriggerClientEvent('refreshSMS', receiverID)
                end
            end
        end
    else
        exports['mythic_notify']:SendAlert('error', 'You cannot text yourself')
    end
end)

RegisterNetEvent('phone:serverGetMessagesBetweenParties')
AddEventHandler('phone:serverGetMessagesBetweenParties', function(sender, receiver, displayName)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local mynumber = getNumberPhone(xPlayer.identifier)
    local result = MySQL.Sync.fetchAll("SELECT * FROM phone_messages WHERE (sender = @sender AND receiver = @receiver) OR (sender = @receiver AND receiver = @sender) ORDER BY id ASC", {['@sender'] = sender, ['@receiver'] = receiver})

    TriggerClientEvent('phone:clientGetMessagesBetweenParties', src, result, displayName, mynumber)
end)

RegisterNetEvent('phone:StartCallConfirmed')
AddEventHandler('phone:StartCallConfirmed', function(mySourceID)
    local channel = tonumber(math.random(1000, 9000))
    local src = source

    TriggerClientEvent('phone:callFullyInitiated', mySourceID, mySourceID, src)
    TriggerClientEvent('phone:callFullyInitiated', src, src, mySourceID)

    -- After add them to the same channel or do it from server.
    TriggerClientEvent('phone:addToCall', source, channel)
    TriggerClientEvent('phone:addToCall', mySourceID, channel)

    TriggerClientEvent('phone:id', src, channel)
    TriggerClientEvent('phone:id', mySourceID, channel)
end)

RegisterNetEvent('phone:EndCall')
AddEventHandler('phone:EndCall', function(mySourceID, stupidcallnumberidk, somethingextra)
    local src = source
    TriggerClientEvent('phone:removefromToko', src, stupidcallnumberidk)

    if mySourceID > 0 and mySourceID ~= nil then
        TriggerClientEvent('phone:removefromToko', mySourceID, stupidcallnumberidk)
        TriggerClientEvent('phone:otherClientEndCall', mySourceID)
    end

    if somethingextra then
        TriggerClientEvent('phone:otherClientEndCall', src)
    end
end)

RegisterCommand("a", function(source, args, rawCommand)
    TriggerClientEvent('phone:answercall', source)
end, false)

RegisterCommand("h", function(source, args, rawCommand)
    TriggerClientEvent('phone:endCalloncommand', source)
end, false)


RegisterCommand("ph", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()
    local srcPhone = getNumberPhone(identifier)
    TriggerClientEvent('sendMessagePhoneN', source, srcPhone)
end, false)

function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end
function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end

AddEventHandler('tac:playerLoaded',function(source)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    getOrGeneratePhoneNumber(sourcePlayer, identifier, function (pPhoneNumber)
        myPhoneNumber = pPhoneNumber
    end)
end)

function getOrGeneratePhoneNumber (sourcePlayer, identifier, cb)
    local sourcePlayer = sourcePlayer
    local identifier = identifier
    local myPhoneNumber = getNumberPhone(identifier)
    if myPhoneNumber == '0' or myPhoneNumber == nil then
        repeat
            myPhoneNumber = getPhoneRandomNumber()
            local id = getIdentifierByPhoneNumber(myPhoneNumber)
        until id == nil
        MySQL.Async.insert("UPDATE users SET phone_number = @myPhoneNumber WHERE identifier = @identifier", {
            ['@myPhoneNumber'] = myPhoneNumber,
            ['@identifier'] = identifier
        }, function ()
            cb(myPhoneNumber)
        end)
    else
        cb(myPhoneNumber)
    end
end

function getPhoneRandomNumber()
    local numBase0 = 4
    local numBase1 = math.random(10,99)
    local numBase2 = math.random(100,999)
    local numBase3 = math.random(1000,9999)
    local num = string.format(numBase0 .. "" .. numBase1 .. "" .. numBase2 .. "" .. numBase3)
    return num
end

RegisterNetEvent('message:inDistanceZone')
AddEventHandler('message:inDistanceZone', function(somethingsomething, messagehueifh)
    local src = source
    local first = messagehueifh:sub(1, 3)
    local second = messagehueifh:sub(4, 6)
    local third = messagehueifh:sub(7, 11)

    local msg = first .. "-" .. second .. "-" .. third
    TriggerClientEvent('chat:addMessage', somethingsomething, {
        template = '<div class="chat-message"><b>Phone</b>: #{1}</div>',
        args = { fal, msg }
    })
end)

RegisterNetEvent('message:tome')
AddEventHandler('message:tome', function(messagehueifh)
    local src = source
    local first = messagehueifh:sub(1, 3)
    local second = messagehueifh:sub(4, 6)
    local third = messagehueifh:sub(7, 11)

    local msg = first .. "-" .. second .. "-" .. third
	TriggerClientEvent('chat:addMessage', src, {
		template = '<div style = "display: inline-block !important;padding: 0.6vw;padding-top: 0.6vw;padding-bottom: 0.7vw;margin: 0.1vw;margin-left: 0.4vw;border-radius: 10px;background-color: #be6112d9;width: fit-content;max-width: 100%;overflow: hidden;word-break: break-word;"><b>Phone</b>: #{1}</div>',
		args = { fal, msg }
	})
end)


RegisterNetEvent('phone:getServerTime')
AddEventHandler('phone:getServerTime', function()
    local hours, minutes, seconds = Citizen.InvokeNative(0x50C7A99057A69748, Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt())
    TriggerClientEvent('timeheader', -1, hours, minutes)
end)

function getIdentity(target)
	local identifier = GetPlayerIdentifiers(target)[1]
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

--[[ Others ]]

RegisterNetEvent('getAccountInfo')
AddEventHandler('getAccountInfo', function()
    local src = source
    local player = ESX.GetPlayerFromId(source)

    local money = player.getMoney()
    local inbank = player.getBank()
    local licenceTable = {}

    TriggerEvent('tac_license:getLicenses', source, function(licenses)
        licenceTable = licenses
    end)

    Citizen.Wait(100)

    TriggerClientEvent('getAccountInfo', src, money, inbank, licenceTable)
end)


--[[ Yellow Pages ]]

RegisterNetEvent('getYP')
AddEventHandler('getYP', function()
    local source = source
    MySQL.Async.fetchAll('SELECT * FROM phone_yp LIMIT 30', {}, function(yp)
        local deorencoded = json.encode(yp)
        TriggerClientEvent('YellowPageArray', source, yp)
    end)
end)

RegisterNetEvent('phone:updatePhoneJob')
AddEventHandler('phone:updatePhoneJob', function(advert)
    --local handle = handle
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local mynumber = getNumberPhone(xPlayer.identifier)
    local name = getIdentity(src)

    fal = name.firstname .. " " .. name.lastname

    MySQL.Async.execute('INSERT INTO phone_yp (name, advert, phoneNumber) VALUES (@name, @advert, @phoneNumber)', {
        ['@name'] = fal,
        ['@advert'] = advert,
        ['@phoneNumber'] = mynumber
    }, function(result)
        TriggerClientEvent('refreshYP', src)
    end)
end)

RegisterNetEvent('phone:foundLawyer')
AddEventHandler('phone:foundLawyer', function(name, phoneNumber)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style = "display: inline-block !important;padding: 0.6vw;padding-top: 0.6vw;padding-bottom: 0.7vw;margin: 0.1vw;margin-left: 0.4vw;border-radius: 10px;background-color: #1e2dff9c;width: fit-content;max-width: 100%;overflow: hidden;word-break: break-word;"><b>YP</b>: ⚖️ {0} ☎️ {1}</div>',
        args = { name, phoneNumber }
    })
end)

RegisterNetEvent('phone:foundLawyerC')
AddEventHandler('phone:foundLawyerC', function(name, phoneNumber)
    local src = source
    TriggerClientEvent('chat:addMessage', src, {
        template = '<div style = "display: inline-block !important;padding: 0.6vw;padding-top: 0.6vw;padding-bottom: 0.7vw;margin: 0.1vw;margin-left: 0.4vw;border-radius: 10px;background-color: #1e2dff9c;width: fit-content;max-width: 100%;overflow: hidden;word-break: break-word;"><b>YP</b>: ⚖️ {0} ☎️ {1}</div>',
        args = { name, phoneNumber }
    })
end)

RegisterNetEvent('deleteAllYP')
AddEventHandler('deleteAllYP', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local src = source
    MySQL.Async.execute('DELETE FROM phone_yp', {}, function (result) end)
end)

RegisterServerEvent('phone:RemoveYP')
AddEventHandler('phone:RemoveYP', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local mynumber = getNumberPhone(xPlayer.identifier)
    MySQL.Async.execute('DELETE FROM phone_yp WHERE phoneNumber=@phoneNumber', {
        ['@phoneNumber'] = mynumber
    }, function(result)
        TriggerClientEvent('refreshYP', src)
    end)
end)

RegisterServerEvent('phone:checkPhoneCount')
AddEventHandler('phone:checkPhoneCount', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('phone').count >= 1 then
		TriggerClientEvent('phone:heHasPhone', _source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You dont have a phone, Buy one at your local store', length = 7000})
	end
end)

RegisterServerEvent('car:Outstanding')
AddEventHandler('car:Outstanding', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local data = {}
    local sel = 'ov.finance,ov.plate,ov.financetimer,ov.lastpayment,ov.owner,u.firstname,u.lastname,u.phone_number,ov.shop'
    MySQL.Async.fetchAll("SELECT "..sel.." FROM owned_vehicles ov INNER JOIN users u on ov.owner = u.identifier WHERE ov.finance > @finance", {
        ['@finance'] = 0
    }, function(result)
        if result[1] ~= nil then
            for i=1, #result, 1 do
                local lastpayment = result[i].lastpayment
                if lastpayment ~= nil then
                    local daysfrom = os.difftime(os.time(), lastpayment) / (24 * 60 * 60)
                    local wholedays = math.floor(daysfrom)
                    if wholedays >= 7 then
                        table.insert(data, {
                            firstname = result[i].firstname,
                            lastname = result[i].lastname,
                            phonenumber = result[i].phone_number,
                            finance = result[i].finance,
                            plate = result[i].plate,
                            shop = result[i].shop,
                            financetimer = result[i].financetimer
                        })
                    end
                end
            end
            TriggerClientEvent('phone:listunpaid', _source, data)
        else
            TriggerClientEvent('phone:listunpaid', _source, false)
        end
    end)
end)

RegisterServerEvent('group:pullinformation')
AddEventHandler('group:pullinformation', function(job)
    local src = source
    local user = ESX.GetPlayerFromId(src)
    local identifier = user.identifier
    local employees = {}
    if job ~= nil then
        MySQL.Async.fetchAll("SELECT id,firstname,lastname, job, job_grade FROM users WHERE job = @job", {
            ['@job'] = job
        }, function(result)
            if result[1] ~= nil then
                local groupMoney = MySQL.Sync.fetchAll("SELECT money FROM addon_account_data WHERE account_name = @job", {['@job'] = result[1].job})
                for i=1, #result, 1 do
                    table.insert(employees,{
                        name = result[i].firstname .. ', '..result[i].lastname,
                        cid = result[i].id,
                        rank = result[i].job_grade,
                        job = result[i].job
                    })
                end
                TriggerClientEvent('group:fullList', src, employees, groupMoney[1].money, employees.rank, employees.job)
            end
        end)
    end
end)

--[[RegisterServerEvent('group:fireEmployee')
AddEventHandler('group:fireEmployee', function()
    print('group:fireEmployee')
end)]]

RegisterServerEvent('server:promoteGroup')
AddEventHandler('server:promoteGroup', function(groupid,rank,id)
    if id ~= nil and rank ~= nil then
        if tonumber(rank) > 0 then
            MySQL.Async.execute("UPDATE users SET job_grade=@rank WHERE id = @cid", {['@cid'] = id, ['@rank'] = rank})
            TriggerClientEvent('group:refresh', source)
        else
            MySQL.Async.execute("UPDATE users SET job=@job WHERE id = @cid", {['@cid'] = id, ['@job'] = 'unemployed'})
            MySQL.Async.execute("UPDATE users SET job_grade=@rank WHERE id = @cid", {['@cid'] = id, ['@rank'] = 0})
            TriggerClientEvent('group:refresh', source)
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'There was a error promoting this id, if this persists please contact a staff :('})
    end
end)

RegisterServerEvent('server:givepayGroup')
AddEventHandler('server:givepayGroup', function(job,amount,cid)
    local user = ESX.GetPlayerFromId(source)
    if job == user.job.name then
        if cid ~= nil and amount ~= nil then
            local groupMoney = MySQL.Sync.fetchAll("SELECT money FROM addon_account_data WHERE account_name = @job", {['@job'] = job})
            local bankSlip = MySQL.Sync.fetchAll("SELECT bank,payslip FROM users WHERE id = @id", {['@id'] = cid})
            if tonumber(groupMoney[1].money) >= tonumber(amount) then
                local curAmount = groupMoney[1].money

                MySQL.Async.execute("UPDATE addon_account_data SET money=@money WHERE account_name = @accountName", {['@accountName'] = job, ['@money'] = curAmount - amount})
                MySQL.Async.execute("UPDATE users SET payslip=@payslip WHERE id = @cid", {['@cid'] = cid, ['@payslip'] = bankSlip[1].payslip + amount})
                --TriggerClientEvent('Yougotpaid', -1, 1, 1)
            end
        end
    end
end)

RegisterServerEvent('server:bankGroup')
AddEventHandler('server:bankGroup', function(job, amount)
    local user = ESX.GetPlayerFromId(source)
    if job ~= nil and amount ~= nil then
        local groupMoney = MySQL.Sync.fetchAll("SELECT money FROM addon_account_data WHERE account_name = @job", {['@job'] = job})
        local pMoney = user.getMoney()

        if tonumber(pMoney) >= tonumber(amount) then
            user.removeMoney(amount)
            MySQL.Async.execute("UPDATE addon_account_data SET money=@money WHERE account_name = @accountName", {['@accountName'] = job, ['@money'] = groupMoney[1].money + amount})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You dont have enough money on you (Need the money in your pockets)', length = 7000})
        end
    end
end)

-- PING STUFF

RegisterServerEvent('requestPing')
AddEventHandler('requestPing', function(target, x,y,z)
    local src = source
    local user = ESX.GetPlayerFromId(src)
    local targ = ESX.GetPlayerFromId(target)
    if target ~= nil and target > 0 then
        local hasName = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier=@ident', {['@ident'] = user.identifier})
        local name = hasName[1].firstname..','..hasName[1].lastname
        TriggerClientEvent('allowedPing', targ.source, x,y,z,src,name)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'This player is not online (double check the id)', length = 4000})
    end
end)

RegisterServerEvent('pingAccepted')
AddEventHandler('pingAccepted', function(targ)
    if targ > 0 then
        TriggerClientEvent('mythic_notify:client:SendAlert', targ, {type = 'inform', text = 'Your ping was accepted!'})
    end
end)

-- END OF PING

RegisterCommand("payphone", function(source, args, raw)
    local src = source
    local pnumber = args[1]
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.get('money') >= 25 then
        TriggerClientEvent('phone:makepayphonecall', src, pnumber, true)
        --xPlayer.removeMoney(25)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You dont have $25 for the payphone', length = 7000})
    end
end, false)

--- Racing
local customMaps = {}
local currentRaces = {}

RegisterServerEvent('racing-save-map')
AddEventHandler('racing-save-map', function(map, track_name, description,dist)
    if map ~= nil then
        MySQL.Async.execute('INSERT INTO `racing-maps` (track_name,description,distance,checkpoints) VALUES (@track_name,@desc,@dist,@checkpoints)', {
            ['@track_name'] = track_name,
            ['@desc'] = description,
            ['@dist'] = dist,
            ['@checkpoints'] = json.encode(map)
        })
    end
end)

RegisterServerEvent('racing-retreive-maps')
AddEventHandler('racing-retreive-maps', function()
    local user = ESX.GetPlayerFromId(source)
    local data = {}
    if user.source > 0 then
        if customMaps ~= nil then
            for k,v in pairs(customMaps) do
                TriggerClientEvent('racing:data:set',user.source, customMaps[k])
            end
        else
            TriggerClientEvent('racing:data:set',user.source, {})
        end
    end
end)

RegisterServerEvent('racing-build-maps')
AddEventHandler('racing-build-maps', function()
    local user = ESX.GetPlayerFromId(source)
    local data = {}
    if user.source > 0 then
        MySQL.Async.fetchAll('SELECT id,track_name,description,distance,checkpoints FROM `racing-maps`',{}, function(result)
            if result ~= nil then
                data.event = "map"
                data.eventId = -1
                data.data = result
                TriggerClientEvent('racing:data:set',user.source, data)
                for i=1, 45 do
                    data.subEvent = 'noNUI'
                    if i ~= user.source then
                        TriggerClientEvent('racing:data:set',i, data)
                    end
                end
            else
                TriggerClientEvent('racing:data:set',user.source, {})
            end
        end)
    end
end)

RegisterServerEvent('racing-global-race')
AddEventHandler('racing-global-race', function(map, laps, counter, reverseTrack, uniqueid, cid, raceName, startTime, mapCreator, mapDistance, mapDescription, street1, street2)
    local src = source
    local data = {}
    customMaps[uniqueid] = {
        event = 'event',
        eventId = uniqueid,
        data = {
            map = map,
            laps = laps,
            counter = counter,
            reverseTrack = reverseTrack,
            uniqueid = uniqueid,
            cid = cid,
            raceName = raceName,
            startTime = startTime,
            mapCreator = mapCreator,
            mapDistance = mapDistance,
            mapDescription = mapDescription,
            street1 = street1,
            street2 = street2,
            eventId = uniqueid,
            open = true,
        }
    }
    TriggerClientEvent('racing:data:set',-1, customMaps[uniqueid])
    Wait(counter * 1000)
    customMaps[uniqueid]["data"].open = false
    customMaps[uniqueid].subEvent = 'close'
    customMaps[uniqueid].eventId = uniqueid
    TriggerClientEvent('racing:data:set',-1, customMaps[uniqueid])
    customMaps[uniqueid].subEvent = nil
end)

RegisterServerEvent('racing-join-race')
AddEventHandler('racing-join-race', function(id)
    local src = source
    local ident = ESX.GetPlayerFromId(src).identifier
    if currentRaces ~= nil then
        local name =  GetName(ident)
        playerName = name.firstname..','..name.lastname
        if customMaps[id]["data"].racers == nil then
            customMaps[id]["data"].racers = {}
            customMaps[id]["data"]["racers"][playerName] = {
                name = playerName,
                fastest = -1,
                total = -1,
            }
        else
            customMaps[id]["data"]["racers"][playerName] = {
                name = playerName,
                fastest = -1,
                total = -1,
            }
        end
    end
end)

RegisterServerEvent('race:completed2')
AddEventHandler('race:completed2', function(fastestlap, overall, sprint,identifier)
    local src = source
    local ident = ESX.GetPlayerFromId(src).identifier
    local name =  GetName(ident)
    local playerName = name.firstname..','..name.lastname
    if identifier ~= nil then
        local racers = customMaps[identifier]["data"]["racers"]
        for k,v in pairs(racers) do
            if k == playerName then
                racers[k].fastest = fastestlap
                racers[k].total = overall
            end
        end
        TriggerClientEvent('racing:data:set',-1, customMaps[identifier])
    end
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