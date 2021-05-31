ESX   = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

local crops = {}

RegisterServerEvent('ffrp-weed:createplant')
AddEventHandler('ffrp-weed:createplant', function(pX,pY,pZ,strain,seed)
    local src = source
    local coords = {x = pX, y = pY, z = pZ}
    local user = ESX.GetPlayerFromId(src)
    local ident = user.identifier

    if coords ~= nil then
        MySQL.Async.fetchAll('SELECT id FROM weed_plants WHERE identifier=@ident', {
            ['@ident'] = ident
        }, function(result0)
            if result0 ~= nil then
                if #result0 < 10 then
                    MySQL.Async.execute('INSERT INTO weed_plants (identifier, coords, strain, growth, status) VALUES (@ident,@coords,@strain, @growth,@status)', {
                        ['@ident'] = ident,
                        ['@coords'] = json.encode(coords),
                        ['@strain'] = strain,
                        ['@growth'] = 0,
                        ['@status'] = 1,
                    }, function (result)
                        if tonumber(result) == 1 then
                            MySQL.Async.fetchAll('SELECT id,coords,strain,growth,status FROM weed_plants', {
                                ['@identifier'] = ident
                            }, function(result2)
                                if result2 ~= nil then
                                    TriggerClientEvent('ffrp-weed:currentcrops', -1, result2)
                                    TriggerClientEvent('ffrp-weed:removeItems', user.source, seed)
                                end
                            end)
                        end
                    end)
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', user.source, {type = 'error', text = 'You have already reached the max number of crops (10)'})
                end
            end
        end)
    end
end)

RegisterServerEvent('ffrp-weed:UpdateWeedGrowth')
AddEventHandler('ffrp-weed:UpdateWeedGrowth', function(id,percent, status)
    local src = source
    local user = ESX.GetPlayerFromId(src)
    local ident = user.identifier

    if id ~= nil then
        MySQL.Async.execute('UPDATE weed_plants SET growth=@growth WHERE identifier=@ident AND id=@id', {
            ['@id'] = id,
            ['@ident'] = ident,
            ['@growth'] = percent,
            ['@status'] = status
        }, function(result)
            if tonumber(result) == 1 then
                TriggerClientEvent('ffrp-weed:updateplantwithID',user.source, id,percent, "alter")
                for i=1, #crops do 
                    if crops[i]['dbID'] == id then
                        crops[i]['growth'] = percent
                        crops[i]['status'] = status
                    end
                end
            end
        end)
    end
end)

RegisterServerEvent('ffrp-weed:killplant')
AddEventHandler('ffrp-weed:killplant', function(id)
    local src = source
    local user = ESX.GetPlayerFromId(src)

    if id ~= nil then
        MySQL.Async.execute('DELETE FROM weed_plants WHERE id=@id', {
            ['@id'] = id
        }, function(result)
            if tonumber(result) == 1 then
                TriggerClientEvent('ffrp-weed:updateplantwithID', -1,id,0,'remove')
                for i=1, #crops do
                    if crops[i]['dbID'] == id then
                        table.remove(crops, i)
                    end
                end
            end
        end)
    end
end)

RegisterServerEvent('ffrp-weed:RequestWeedPlants')
AddEventHandler('ffrp-weed:RequestWeedPlants', function()
    local src = source
    local user = ESX.GetPlayerFromId(src)
    local ident = user.identifier

    MySQL.Async.fetchAll('SELECT id,coords,strain,growth,status FROM weed_plants', {
    }, function(result)
        if result ~= nil then
            TriggerClientEvent('ffrp-weed:currentcrops', user.source, result)
        end
    end)
end)

RegisterServerEvent('ffrp-weed:updatePlants')
AddEventHandler('ffrp-weed:updatePlants', function(pCrops)
    local src = source
    local user = ESX.GetPlayerFromId(src)
    local ident = user.identifier
    if pCrops ~= nil then
        for i=1, #pCrops do
            MySQL.Async.execute('UPDATE weed_plants SET growth=@growth, status=@status WHERE id=@id', {
                ['@growth'] = pCrops[i]['growth'],
                ['@status'] = pCoords[i]['status'],
                ['@id'] = pCrops[i]['dbID']
            })
        end
    end
end)

RegisterServerEvent('ffrp-weed:convert')
AddEventHandler('ffrp-weed:convert', function(id)
    local src = source
    local user = ESX.GetPlayerFromId(src)

    if id ~= nil then
        MySQL.Async.execute('UPDATE weed_plants SET strain=@strain WHERE id=@id', {
            ['@id'] = id,
            ['@strain'] = 'seeded'
        })
        TriggerClientEvent('ffrp-weed:updateplantwithID', -1, { id }, 0, 'convert')
    end
end)

local checkStates = {
    10, 20, 30, 40, 50, 60, 70, 80, 90
}

function updateCrops()
    MySQL.Async.fetchAll('SELECT * FROM weed_plants', {}, function(result)
        if result ~= nil then
            for i=1, #result do
                result[i].growth = result[i].growth + 3
                for index=1, #checkStates do
                    if result[i].growth == checkStates[index] then
                        if result[i].strain == 'Seeded' or result[i].strain == 'seeded' then
                            result[i].status = 3
                        else
                            result[i].status = 2
                        end
                    end
                end
                MySQL.Async.execute('UPDATE weed_plants SET growth=@growth, status=@status WHERE id=@id', {
                    ['@id'] = result[i].id,
                    ['@growth'] = result[i].growth,
                    ['@status'] = result[i].status
                })
                TriggerClientEvent('ffrp-weed:updateplantwithID', -1, result[i].id, result[i].growth, 'alter')
            end
        end
    end)
    SetTimeout((60 * 1000) * 10, updateCrops)
end

updateCrops()

AddEventHandler('onResourceStart', function(res)
    if res == GetCurrentResourceName() then 
        MySQL.Async.execute('DELETE FROM weed_plants WHERE growth > @growth', {
            ['@growth'] = 600
        })
    end
end)