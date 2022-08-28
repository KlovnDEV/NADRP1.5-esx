ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('house:enterhouse')
AddEventHandler('house:enterhouse', function(house_id, house_model, forced)
    local src = source
    local user = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll('SELECT locked,owner,furniture FROM houses WHERE house_id=@house_id AND house_model=@house_model', { -- Add furniture shit
        ['@house_id'] = house_id,
        ['@house_model'] = house_model
    },  function(result)
        if result[1] ~= nil then
            local furniture = json.decode(result[1].furniture)
            if forced == false then
                if result[1].locked == 0 or result[1].owner == user.identifier then
                    TriggerClientEvent('house:entersuccess', user.source, house_id, house_model, furniture)
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', user.source, {type = 'error', text = 'This door is locked!.'})
                end
            else
                if furniture ~= nil or furniture == "[]" then
                    TriggerClientEvent('house:entersuccess', user.source, house_id, house_model, furniture)
                else
                    TriggerClientEvent('house:entersuccess', user.source, house_id, house_model, {})
                end
            end
        elseif forced then
            TriggerClientEvent('house:entersuccess', user.source, house_id, house_model, {})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', user.source, {type = 'error', text = 'This door is locked!.'})
        end
    end)
end)

RegisterServerEvent('house:enterhousebackdoor')
AddEventHandler('house:enterhousebackdoor', function(house_id,house_model,forced,x,y,z,h)
    local src = source
    local user = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll('SELECT owner,furniture FROM houses WHERE house_id=@house_id AND house_model=@house_model ', {
        ['@house_id'] = house_id,
        ['@house_model'] = house_model
    }, function(result)
        if result[1] ~= nil then
            if result[1].owner == user.identifier or forced then
                local furniture = json.decode(result[1].furniture)
                TriggerClientEvent('house:entersuccessbackdoor', user.source, house_id,house_model,furniture,x,y,z,h)
            else
                MySQL.Async.fetchAll('SELECT identifier FROM playerhousing_keys WHERE house_id=@house_id AND house_model=@house_model', {
                    ['@house_id'] = house_id,
                    ['@house_model'] = house_model
                }, function(result2)
                    if result2[1] ~= nil then
                        local furniture = json.decode(result[1].furniture)
                        TriggerClientEvent('house:entersuccessbackdoor', user.source, house_id,house_model,furniture,x,y,z,h)
                    else
                        TriggerClientEvent('mythic_notify:client:SendAlert', user.source, {type = 'error', text = 'You dont have keys to enter!.'})
                    end
                end)
            end
        end
    end)
end)

RegisterServerEvent('housing:unlock')
AddEventHandler('housing:unlock', function(house_id, house_model, isRealtor)
    local src = source
    if isRealtor then
        ToggleLock(house_id, 0)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, {type = 'inform', text = 'Door unlocked.'})
    else
        MySQL.Async.fetchAll('SELECT house_id FROM playerhousing_keys WHERE house_id=@house_id AND house_model=@house_model', {
            ['house_id'] = house_id,
            ['@house_model'] = house_model
        }, function(result)
            if result[1] ~= nil then
                if result[1].house_id == house_id then
                    ToggleLock(house_id, 0)
                    TriggerClientEvent('mythic_notify:client:SendAlert', src, {type = 'inform', text = 'Door unlocked.'})
                end
            end
        end)
    end
end)

RegisterServerEvent('house:purchasehouse')
AddEventHandler('house:purchasehouse', function(house_id,house_model,price,house_name,trap)
    local src = source
    local user = ESX.GetPlayerFromId(src)
    local ident = user.identifier
    if ident ~= nil then
        MySQL.Async.fetchAll('SELECT owner FROM houses WHERE house_id=@house_id AND house_model=@house_model',{
            ['@house_id'] = house_id,
            ['@house_model'] = house_model,
        }, function(result)
            local timestamp = os.time()
            if result[1] ~= nil and result[1] ~= '[]' then
                if result[1].owner ~= ident then
                    TriggerClientEvent('mythic_notify:client:SendAlert', src, {type = 'error', text = 'The residents of this house have not been evicted?'})
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', src, {type = 'error', text = 'You already owns this house?'})
                end
            else
                MySQL.Async.fetchAll('SELECT id FROM houses WHERE owner=@owner', {
                    ['@owner'] = ident
                }, function(result2)
                    if #result2 < 2 then
                        local upfront = math.ceil(price * 0.5) / 2
                        if user.getMoney() >= upfront then
                            local cols = 'owner,house_name,house_id,house_model,locked,lastpayment,price,amountOwed'
                            local vals = '@owner,@house_name,@house_id,@house_model,@locked,@lastpayment,@price,@amountOwed'
                            MySQL.Async.execute('INSERT INTO houses ('..cols..') VALUES ('..vals..')', {
                                ['@owner'] = ident,
                                ['@house_name'] = house_name,
                                ['@house_id'] = house_id,
                                ['@house_model'] = house_model,
                                ['@locked'] = 1,
                                ['@price'] = price,
                                ['@lastpayment'] = timestamp,
                                ['@amountOwed'] = price - upfront
                            }, function(result)
                                if result ~= nil then
                                    AddKey(ident, house_id, house_model,house_name, 0)
                                    user.removeMoney(upfront)
                                    local curSociety = MySQL.Sync.fetchAll('SELECT money FROM addon_account_data WHERE account_name=@name', {['@name'] = 'realestateagent'})
                                    if curSociety[1].money ~= nil then
                                        local curBalance = curSociety[1].money
                                        MySQL.Sync.execute('UPDATE addon_account_data SET money=@money WHERE account_name=@name', {
                                            ['@name'] = 'realestateagent',
                                            ['@money'] = curBalance + upfront
                                        })
                                    else
                                        print('^1['..GetCurrentResourceName()..']: ^0 Failed to get current society [Upfront]: '..upfront)
                                    end
                                end
                            end)
                        else
                            TriggerClientEvent('mythic_notify:client:SendAlert', user.source, {type = 'error', text = 'You dont have enough money on you!.'})
                        end
                    else
                        TriggerClientEvent('mythic_notify:client:SendAlert', user.source, {type = 'error', text = 'You cant hold anymore keys!.'})
                    end
                end)
            end
        end)
    end
end)

RegisterServerEvent('house:dopayment')
AddEventHandler('house:dopayment', function(house_id,house_model)
    local src = source
    local user = ESX.GetPlayerFromId(src)
    if house_id ~= nil then 
        MySQL.Async.fetchAll('SELECT price,lastpayment,amountOwed FROM houses WHERE house_id=@house_id AND house_model=@house_model', {
            ['@house_id'] = house_id,
            ['@house_model'] = house_model,
        }, function(result)
            if result[1] ~= nil then
                local lastpayment = result[1].lastpayment
                local daysfrom = os.difftime(os.time(), lastpayment) / (24 * 60 * 60)
                local wholedays = math.floor(daysfrom)
                if wholedays >= 7 then
                    local price = result[1].price
                    local amountOwed = result[1].amountOwed
                    local payment = ((price / 2 ) / 10)
                    local timestamp = os.time()

                    if amountOwed > 0 and (amountOwed - payment) <= 0 then
                        if user.getMoney() >= payment then
                            MySQL.Async.execute('UPDATE houses SET amountOwed=@amountOwed, lastpayment=@lastpayment WHERE house_id=@house_id AND house_model=@house_model', {
                                ['@house_id'] = house_id,
                                ['@house_model'] = house_model,
                                ['@amountOwed'] = 0,
                                ['@lastpayment'] = timestamp
                            }, function()
                                user.removeMoney(payment)
                            end)
                        else
                            TriggerClientEvent('mythic_notify:client:SendAlert', user.source, {type = 'error', text = 'You dont have enough money on you!.'})
                        end
                    elseif (amountOwed - payment > 0) then
                        if user.getMoney() >= payment then
                            MySQL.Async.execute('UPDATE houses SET amountOwed=@amountOwed, lastpayment=@lastpayment WHERE house_id=@house_id AND house_model=@house_model', {
                                ['@house_id'] = house_id,
                                ['@house_model'] = house_model,
                                ['@amountOwed'] = amountOwed - payment,
                                ['@lastpayment'] = timestamp
                            }, function()
                                user.removeMoney(payment)
                            end)
                        else
                            TriggerClientEvent('mythic_notify:client:SendAlert', user.source, {type = 'error', text = 'You dont have enough money on you!.'})
                        end
                    else
                        if user.getMoney() >= 1500 then
                            MySQL.Async.execute('UPDATE houses SET amountOwed=@amountOwed, lastpayment=@lastpayment WHERE house_id=@house_id AND house_model=@house_model',{
                                ['@house_id'] = house_id,
                                ['@house_model'] = house_model,
                                ['@amountOwed'] = 0,
                                ['@lastpayment'] = timestamp
                            }, function()
                                user.removeMoney(1500)
                            end)
                        else
                            TriggerClientEvent('mythic_notify:client:SendAlert', user.source, {type = 'error', text = 'You dont have enough money on you!.'})
                        end
                    end
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', user.source, {type = 'error', text = 'Your payment is not due yet.'})
                end
            end
        end)
    end
end)

RegisterServerEvent('house:updatespawns')
AddEventHandler('house:updatespawns', function(table, wipedGarages, startingGarages)
    local house_id = table["house_id"]
    local house_model = table["house_model"]
    local storage = table["storage"]
    local wardrobe = table["wardrobe"]
    local backdoorinside = table["backdoorinside"]
    local backdooroutside = table["backdooroutside"]
    local garage = table["garages"]
    if house_id ~= nil then
        MySQL.Async.execute('UPDATE houses SET storage=@storage WHERE house_id=@house_id AND house_model=@house_model', {['@house_model'] = house_model, ['@house_id'] = house_id, ['@storage'] = json.encode(storage)})
        MySQL.Async.execute('UPDATE houses SET wardrobe=@wardrobe WHERE house_id=@house_id AND house_model=@house_model', {['@house_model'] = house_model, ['@house_id'] = house_id, ['@wardrobe'] = json.encode(wardrobe)})
        MySQL.Async.execute('UPDATE houses SET garage=@garage WHERE house_id=@house_id AND house_model=@house_model', {['@house_model'] = house_model, ['@house_id'] = house_id, ['@garage'] = json.encode(garage)})
        MySQL.Async.execute('UPDATE houses SET backdoorinside=@backdoorinside WHERE house_id=@house_id AND house_model=@house_model', {['@house_model'] = house_model, ['@house_id'] = house_id, ['@backdoorinside'] = json.encode(backdoorinside)})
        MySQL.Async.execute('UPDATE houses SET backdooroutside=@backdooroutside WHERE house_id=@house_id AND house_model=@house_model', {['@house_model'] = house_model, ['@house_id'] = house_id, ['@backdooroutside'] = json.encode(backdooroutside)})
        --TriggerClientEvent('UpdateCurrentHouseSpawns', -1, table["info"])
    end
end)

RegisterServerEvent('ReturnHouseKeys')
AddEventHandler('ReturnHouseKeys', function()
    local src = source
    local user = ESX.GetPlayerFromId(src)
    local ownedKeys = {}
    local sharedKeys = {}
    local keysIDS = {}
    MySQL.Async.fetchAll('SELECT (h.id) as id, h.price, h.lastpayment, h.amountOwed, h.house_id, h.house_model, h.house_name, pk.shared FROM playerhousing_keys pk INNER JOIN houses h on pk.house_id=h.house_id AND pk.house_model=h.house_model WHERE pk.identifier=@identifier', {
        ['@identifier'] = user.identifier
    }, function(result)
        for i=1, #result do
            local lastpayment = result[i].lastpayment
            local daysfrom = os.difftime(os.time(), lastpayment) / (24 * 60 * 60)
            local days = math.floor(daysfrom)
            result[i].days = days
            if result[i].shared == 1 then
                table.insert(sharedKeys, result[i])
            else
                table.insert(ownedKeys, result[i])
            end
            table.insert(keysIDS, result[i].id)
        end
        TriggerClientEvent('returnPlayerKeys', user.source, ownedKeys,sharedKeys, keysIDS)
    end)
end)

RegisterServerEvent('GarageData')
AddEventHandler('GarageData', function()
    local src = source
    local user = ESX.GetPlayerFromId(src)
    local data = {}
    if user.source > 0 then
        MySQL.Async.fetchAll('SELECT house_id,house_model FROM playerhousing_keys WHERE identifier=@identifier',{
            ['@identifier'] = user.identifier
        }, function(result)
            if result[1] ~= nil then
                if result[1].house_id ~= nil then
                    for i=1, #result do 
                        local house_id = result[i].house_id
                        local house_model = result[i].house_model
                        MySQL.Async.fetchAll('SELECT * FROM houses WHERE house_id=@house_id AND house_model=@house_model', {
                            ['@house_id'] = house_id,
                            ['@house_model'] = house_model,
                        }, function(result2)
                            if result2[1] ~= nil then
                                for i=1, #result2 do
                                    local data2 = {
                                        ["table_id"] = result2[i].id,
                                        ["house_id"] = result2[i].house_id,
                                        ["house_model"] = result2[i].house_model,
                                        ["house_name"] = result2[i].house_name,
                                        ["home_owner"] = result2[i].owner,
                                        ["house_poi"] = {
                                            ["storage"] = json.decode(result2[i].storage),
                                            ["wardrobe"] = json.decode(result2[i].wardrobe),
                                            ["garages"] = json.decode(result2[i].garage),
                                            ["backdoorinside"] = json.decode(result2[i].backdoorinside),
                                            ["backdooroutside"] = json.decode(result2[i].backdooroutside),
                                        },
                                    }
                                    table.insert(data, data2)
                                end
                            end
                        end)
                    end
                    Wait(100)
                    TriggerClientEvent('GarageData', user.source, data)
                end
            end
        end)
    end
end)

RegisterServerEvent('house:retrieveKeys')
AddEventHandler('house:retrieveKeys', function(house_id, house_model)
    local src = source
    MySQL.Async.fetchAll('SELECT id,identifier,house_name,house_id FROM playerhousing_keys WHERE house_id=@house_id AND house_model=@house_model AND shared=@shared', {
        ['@house_id'] = house_id,
        ['@house_model'] = house_model,
        ['@shared'] = 1
    }, function(result)
        if result[1] ~= nil then
            local name = GetName(result[1].identifier)
            result[1].sharedName = name.firstname..','..name.lastname
            TriggerClientEvent('house:returnKeys', src, result)
        else
            TriggerClientEvent('house:returnKeys', src, {})
        end
    end)
end)

RegisterServerEvent('house:givekey')
AddEventHandler('house:givekey', function(house_id,house_model,house_name,player)
    local targ = ESX.GetPlayerFromId(player)
    local src = source
    if house_id ~= nil and player ~= nil then
        MySQL.Async.fetchAll('SELECT house_id FROM playerhousing_keys WHERE house_id=@house_id AND house_model=@house_model AND identifier=@identifier', {
            ['@house_id'] = house_id,
            ['@house_model'] = house_model,
            ['@identifier'] = targ.identifier
        },function(result)
            if result[1] == nil then
                MySQL.Async.fetchAll('SELECT id FROM playerhousing_keys WHERE identifier=@identifier', {
                    ['@identifier'] = targ.identifier
                }, function(result2)
                    if #result2 < 3 then 
                        AddKey(targ.identifier, house_id, house_model,house_name,1)
                    else
                        TriggerClientEvent('mythic_notify:client:SendAlert', src, {type = 'error', text = 'The player you are trying to give keys to have reached the max amount.'})
                        TriggerClientEvent('mythic_notify:client:SendAlert', targ.source, {type = 'error', text = 'You cant hold anymore shared keys.'})
                    end
                end)
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', src, {type = 'error', text = 'Player already has keys?.'})
                TriggerClientEvent('mythic_notify:client:SendAlert', targ.source, {type = 'error', text = 'You already have keys?.'})
            end
        end)
    end
end)

RegisterServerEvent('house:removeKey')
AddEventHandler('house:removeKey', function(house_id, house_model,target)
    if target ~= nil then
        MySQL.Async.execute('DELETE FROM playerhousing_keys WHERE house_id=@house_id AND house_model=@house_model AND identifier=@identifier', {
            ['@house_id'] = house_id,
            ['@house_model'] = house_model,
            ['@identifier'] = target
        })
    end
end)


-- RealEstateAgent

RegisterServerEvent('housing:requestSpawnTable')
AddEventHandler('housing:requestSpawnTable', function(house_id,house_model)
    local src = source
    if house_id ~= nil then
        MySQL.Async.fetchAll('SELECT * FROM houses WHERE house_id=@house_id AND house_model=@house_model', {
            ['@house_model'] = house_model,
            ['@house_id'] = house_id
        }, function(result)
            if result[1] ~= nil then
                local data = {
                    garages = json.decode(result[1].garage),
                    storage = json.decode(result[1].storage),
                    wardrobe = json.decode(result[1].wardrobe),
                    backdoorinside = json.decode(result[1].backdoorinside),
                    backdooroutside = json.decode(result[1].backdooroutside),
                    house_id = result[1].house_id,
                    house_model = result[1].house_model,
                    info = result[1].house_name
                }
                TriggerClientEvent('house:spawnpoints', src, data)
            end
        end)
    end
end)

RegisterServerEvent('housing:attemptsale')
AddEventHandler('housing:attemptsale', function(cid,price,house_id,house_model)
    if cid ~= nil then
        TriggerClientEvent('housing:findsalecid', -1, cid,price,house_id,house_model)
    end
end)

RegisterServerEvent('house:transferHouse')
AddEventHandler('house:transferHouse', function(house_id,house_model,cid)
    local src = source
    if cid ~= nil then 
        MySQL.Async.fetchAll('SELECT identifier FROM users WHERE id=@id', {
            ['@id'] = cid
        }, function(result)
            if result[1] ~= nil then
                if result[1].identifier ~= nil then
                    MySQL.Async.fetchAll('SELECT owner,house_name FROM houses WHERE house_id=@house_id AND house_model=@house_model', {
                        ['@house_model'] = house_model,
                        ['@house_id'] = house_id
                    },function(result2)
                        if result2[1] ~= nil and result2[1] ~= "[]" then
                            local newOwner = result[1].identifier
                            local oldOwner = result2[1].owner
                            local houses = MySQL.Sync.fetchAll('SELECT id FROM houses WHERE owner=@owner', {['owner'] = newOwner})
                            if #houses < 2 then
                                MySQL.Sync.execute('UPDATE houses SET owner=@owner WHERE house_id=@house_id AND house_model=@house_model AND owner=@identifier', {
                                    ['@owner'] = newOwner,
                                    ['@identifier'] = oldOwner,
                                    ['@house_model'] = house_model,
                                    ['@house_id'] = house_id
                                })
                                MySQL.Async.execute('DELETE FROM playerhousing_keys WHERE house_id=@house_id AND house_model=@house_model', {
                                    ['@house_model'] = house_model,
                                    ['@house_id'] = house_id,
                                }, function()
                                    AddKey(newOwner, house_id, house_model,result2[1].house_name, 0)
                                end)
                                TriggerClientEvent('mythic_notify:client:SendAlert', src, {type = 'inform', text = 'Successfully transferred house'})
                            else
                                TriggerClientEvent('mythic_notify:client:SendAlert', src, {type = 'error', text = 'They cant seem to hold anymore keys!.'})
                            end
                        else
                            TriggerClientEvent('mythic_notify:client:SendAlert', src, {type = 'error', text = 'No one owns this house!.'})
                        end
                    end)
                end
            end
        end)
    end
end)


RegisterServerEvent('house:evictHouse')
AddEventHandler('house:evictHouse', function(house_id,house_model)
    if house_id ~= nil then
        MySQL.Async.fetchAll('SELECT house_name FROM houses WHERE house_id=@house_id AND house_model=@house_model', {
            ['@house_id'] = house_id,
            ['@house_model'] = house_model
        },  function(result)
            if result[1] ~= nil then
                if result[1].house_name ~= nil then
                    local house_name = result[1].house_name
                    MySQL.Sync.execute('DELETE FROM playerhousing_keys WHERE house_id=@house_id AND house_model=@house_model', {['@house_model'] = house_model, ['@house_id'] = house_id})
                    MySQL.Sync.execute('DELETE FROM houses WHERE house_id=@house_id AND house_model=@house_model', {['@house_model'] = house_model, ['@house_id'] = house_id})
                    WipeGarage(house_name)
                end
            end
        end)
    end
end)

RegisterServerEvent('houses:PropertyOutstanding')
AddEventHandler('houses:PropertyOutstanding', function()
    local src = source
    local data = {}
    MySQL.Async.fetchAll('SELECT owner,amountOwed,lastpayment,house_name FROM houses WHERE amountOwed > 0', {
    }, function(result)
        for k,v in pairs(result) do
            if result[k].owner ~= nil then
                local daysfrom = os.difftime(os.time(), result[k].lastpayment) / (24 * 60 * 60)
                local days = math.floor(daysfrom)
                if days > 7 then
                    MySQL.Async.fetchAll("SELECT firstname,lastname FROM users WHERE identifier = @identifier", {
                        ['@identifier'] = result[k].owner
                    },function(pName)
                        if pName[1] ~= nil then
                            result[k].name = pName[1].firstname..','..pName[1].lastname
                            result[k].days = days
                            table.insert(data,result[k])
                        end
                    end)
                end
            end
        end
        Citizen.Wait(50)
        TriggerClientEvent('phone:listREproperties', src, data)
    end)
end)

RegisterServerEvent('UpdateFurniture')
AddEventHandler('UpdateFurniture', function(house_id,house_model,furniture)
    if house_id ~= nil then
        MySQL.Async.execute('UPDATE houses SET furniture=@furniture WHERE house_id=@house_id AND house_model=@house_model', {
            ['@house_id'] = house_id,
            ['@house_model'] = house_model,
            ['@furniture'] = json.encode(furniture),
        })
    end
end)

RegisterServerEvent('house:GetFurniture')
AddEventHandler('house:GetFurniture', function(house_id,house_model)
    local src = source
    if house_id ~= nil then
        MySQL.Async.fetchAll('SELECT furniture FROM houses WHERE house_id=@house_id AND house_model=@house_model', {
            ['@house_id'] = house_id,
            ['@house_model'] = house_model
        }, function(result)
            if result[1] ~= nil then
                if result[1].furniture ~= nil then
                    local furniture = result[1].furniture
                    TriggerClientEvent('openFurnitureConfirm', src, house_id,house_model,json.decode(furniture))
                else
                    TriggerClientEvent('openFurnitureConfirm', src, house_id,house_model,{})
                end
            end
        end)
    end
end)

-- functions

function AddKey(ident, house_id, house_model,house_name,shared)
    local src = source
    local cols = 'identifier,shared,house_id,house_model,house_name'
    local vals = '@identifier,@shared,@house_id,@house_model,@house_name'
    MySQL.Async.execute('INSERT INTO playerhousing_keys ('..cols..') VALUES ('..vals..')', {
        ['@identifier'] = ident,
        ['@shared'] = shared,
        ['@house_id'] = house_id,
        ['@house_model'] = house_model,
        ['@house_name'] = house_name
    }, function(result)
        MySQL.Async.fetchAll('SELECT id FROM houses WHERE house_id=@house_id AND house_model=@house_model', {
            ['@house_id'] = house_id,
            ['@house_model'] = house_model,
        }, function(result)
            if result ~= nil and result ~= "[]" then
                if src ~= nil then
                    TriggerClientEvent('CheckForKeyUpdate', src, result[1].id)
                end
            end
        end)
    end)
end

function WipeGarage(house_name)
    if house_name ~= nil then
        MySQL.Async.execute('UPDATE owned_vehicles SET garage=@newGarage WHERE garage LIKE "%'..house_name..'%"', {
            ['@newGarage'] = 'T'
        })
    end
end

function ToggleLock(house_id, toggle, isRealtor)
    if house_id ~= nil then
        MySQL.Async.execute('UPDATE houses SET locked=@locked WHERE house_id=@house_id', {
            ['@locked'] = toggle,
            ['@house_id'] = house_id,
        }, function()
            Wait(30000)
            MySQL.Async.execute('UPDATE houses SET locked=@locked WHERE house_id=@house_id', {
                ['@locked'] = 1,
                ['@house_id'] = house_id,
            })
        end)
    end
end

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