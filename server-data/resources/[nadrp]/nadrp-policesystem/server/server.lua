ESX                = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('fine', function(source, args, raw)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer["job"]["name"] == "police" then
        local bitchId = args[1]
        local moneytake = tonumber(args[2])
        local xSource = ESX.GetPlayerFromId(bitchId)
        if args ~= nil then

            if moneytake ~= nil then
               -- TriggerClientEvent('DoLongHudText',source, 'You have fined ID - [' .. bitchId .. '] for $' .. moneytake .. '.')
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You have fined ID - [' .. bitchId .. '] for $' .. moneytake .. '.'})
                TriggerClientEvent('mythic_notify:client:SendAlert', bitchId, { type = 'inform', text = 'You have been sent a Fine for $' .. moneytake .. '.'})

                --TriggerClientEvent('DoLongHudText',bitchId, 'You have been sent a Fine for $' .. moneytake .. '.')
                TriggerClientEvent('drp-fines:Anim', source)
                xSource.removeAccountMoney('bank', moneytake)
            else
                --TriggerClientEvent('DoLongHudText',source, 'Incorrect Amount')
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Incorrect Amount'})
            end
        end
    end
end)


function getPrint(target)
    local identifier = GetPlayerIdentifiers(target)[1]
    local result = MySQL.Sync.fetchAll("SELECT identifier,name,firstname,lastname,dateofbirth,sex,height,job FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
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
            job = identity['job']
        }
    else
        return nil
    end
end


RegisterCommand('paytow', function(source, args, raw)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer["job"]["name"]
    if job == "police" or job == "ambulance" then
        local dumbass = args[1]
        local xSource = ESX.GetPlayerFromId(dumbass)

        if args ~= nil then
            xSource.addMoney(500)

            TriggerClientEvent('chat:addMessage', source, {
                template = '<div class="chat-message nonemergency">SYSTEM:  Tow {0} Paid $500 </div>',
                args = { dumbass }
            })

            TriggerClientEvent('chat:addMessage', dumbass, {
                template = '<div class="chat-message nonemergency">SYSTEM: You have been paid $500 for your Tow </div>',
                args = { }
            })
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'No Player Found'})
        end
    end
end)

RegisterCommand('fingerprint', function(source, args, raw)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer["job"]["name"] == "police" then
        local bitchId = args[1]
        local xSource = ESX.GetPlayerFromId(bitchId)

        if GetPlayerName(bitchId) ~= nil then
            local gotcha = getPrint(bitchId)

            local first = 'First Name'
            local first = 'First Name'
              local Last = 'Last Name:'
              local Job = 'Job'
              local phone = 'Phone Number'
              fuck = gotcha.firstname 
              fuck2 = gotcha.lastname
              job2 = gotcha.job
              TriggerClientEvent('chat:addMessage', source, {
                template = '<div class="chat-message nonemergency"> Finger Print : {0} : {1} | {2} : {3} | Job: {4} </div>',
                args = { first, fuck, Last, fuck2 , job2 }
            })
        else
            TriggerClientEvent('DoLongHudText',source, 'No Player')
        end
    end
end)


ESX.RegisterServerCallback('SB-VehInfo', function(source, cb, plate)
    MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = plate
    }, function(result)
        local retrivedInfo = {plate = plate}

        if result[1] then
            local xPlayer = ESX.GetPlayerFromIdentifier(result[1].owner)


            -- is the owner online?
            if xPlayer then
                MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = result[1].owner }, function(result2)
                    if result2[1] then
                        retrivedInfo.owner = ('%s %s'):format(result2[1].firstname, result2[1].lastname)
                        cb(retrivedInfo)
                    else
                        cb(retrivedInfo)
                    end
                end)
            end
        else
            cb(retrivedInfo)
        end
    end)
end)