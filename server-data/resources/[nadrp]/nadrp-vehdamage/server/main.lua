ESX = nil 

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('veh.updateVehicleDegredationServer')
AddEventHandler('veh.updateVehicleDegredationServer', function(plate,br,ax,rad,cl,tra,elec,fi,ft)
    local user = ESX.GetPlayerFromId(source)
    local pPlate = plate
    local data = {
        brakes = br,
        axle = ax,
        radiator = rad,
        clutch = cl,
        transmission = tra,
        electronics = elec,
        fuel_injector = fi,
        fuel_tank = ft
    }
    --print(json.encode(data))
    if pPlate ~= nil then
        MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
            ['@plate'] = pPlate
        }, function(result)
            if result.plate == pPlate then
                print('plate matched')
                MySQL.Async.execute("UPDATE owned_vehicles SET health=@health WHERE plate=@plate",{
                    ['@health'] = json.encode(data),
                    ['@plate'] = pPlate
                },function(result2)
                    if result2 then
                        print('Setting owned bro')
                        TriggerClientEvent('veh.PlayerOwned', user.source)
                        TriggerClientEvent('veh.getSQL', user.source, result2)
                    end
                end)
            end
        end)
    end
end)

RegisterServerEvent('veh.callDegredation')
AddEventHandler('veh.callDegredation', function(plate, check)
    local user = ESX.GetPlayerFromId(source)
    if not check then 
        MySQL.Async.fetchAll('SELECT health FROM owned_vehicles WHERE plate = @plate', {
            ['@plate'] = plate
        }, function(results)
            TriggerClientEvent('veh.getSQL', user.source, results)
        end)
    else
        MySQL.Async.fetchAll('SELECT health FROM owned_vehicles WHERE plate = @plate', {
            ['@plate'] = plate
        }, function(results)
            if results[1] ~= nil then
                TriggerClientEvent('chat:addMessage', user.source, {
                    template = '<div class="chat-message nonemergency">Vehicle Health <br> {0} <br> {1} <br> {2} <br> {3} <br> {4} <br> {5} <br> {6} <br> {7} <br> </div>',
                    args = {results[1].brakes, results[1].axle, results[1].radiator, results[1].clutch, results[1].transmission, results[1].electronics, results[1].fuel_injector, results[1].fuel_tank}
                })
                --print(json.encode(results))
            end
        end)
    end
end)

--[[RegisterServerEvent('veh.setNewDegredation')
AddEventHandler('veh.setNewDegredation', function(plate)
    local user = ESX.GetPlayerFromId(source)
    local pPlate = plate
    local data = {
        brakes = 100,
        axle = 100,
        radiator = 100,
        clutch = 100,
        transmission = 100,
        electronics = 100,
        fuel_injector = 100,
        fuel_tank = 100
    }
    MySQL.Async.execute("UPDATE owned_vehicles SET health=@health WHERE plate=@plate",{
        ['@health'] = json.encode(data),
        ['@plate'] = pPlate
    },function(result)
        if result then
            print('Setting max deg')
            TriggerClientEvent('veh.PlayerOwned', user.source)
        end
    end)
end)]]

RegisterServerEvent('NetworkNos')
AddEventHandler('NetworkNos', function(plate)
    if plate ~= nil then 
        TriggerClientEvent('NetworkNos', -1, plate)
    end
end)

RegisterServerEvent('nadrp-vehdamage:applyHarness')
AddEventHandler('nadrp-vehdamage:applyHarness', function(plt,dur)
    local src = source
    local plate = string.gsub(plt, "%s+", "")
    local isOwned = MySQL.Sync.fetchAll('SELECT harnessDurability FROM owned_vehicles WHERE plate=@plate', {['@plate'] = plate})
    if isOwned[1] ~= nil and isOwned[1] ~= "[]" then
        MySQL.Async.execute('UPDATE owned_vehicles SET harnessDurability=@duribility WHERE plate=@plate', {
            ['@plate'] = plate,
            ['@duribility'] = dur + 0.0
        }, function(result)
            TriggerClientEvent('nadrp-vehdamage:setHarness', src, 1.0, true)
        end)
    else
        TriggerClientEvent('nadrp-vehdamage:setHarness', src, false, true)
    end
end)

RegisterServerEvent('nadrp-vehdamage:getHarness')
AddEventHandler('nadrp-vehdamage:getHarness', function(plate)
    local src = source
    if plate == nil then return end
    local plate = string.gsub(plate, "%s+", "")
    MySQL.Async.fetchAll('SELECT harnessDurability FROM owned_vehicles WHERE plate=@plate', {
        ['@plate'] = plate
    }, function(result)
        if result[1] ~= nil and result[1] ~= "[]" then
            local harDur = result[1].harnessDurability
            TriggerClientEvent('nadrp-vehdamage:setHarness', src, harDur + 0.0, false)
        else
            TriggerClientEvent('nadrp-vehdamage:setHarness', src, false, false)
        end
    end)
end)

RegisterServerEvent('nadrp-vehdamage:updateHarness')
AddEventHandler('nadrp-vehdamage:updateHarness', function(plt, harnessDurability)
    local src = source
    local plate = string.gsub(plt, "%s+", "")
    local isOwned = MySQL.Sync.fetchAll('SELECT owner FROM owned_vehicles WHERE plate=@plate', {['@plate'] = plate})
    if isOwned[1] ~= nil and isOwned[1] ~= "[]" then
        MySQL.Async.execute('UPDATE owned_vehicles SET harnessDurability=@harnessDurability WHERE plate=@plate', {
            ['@plate'] = plate,
            ['@harnessDurability'] = harnessDurability + 0.0,
        }, function()
        end)
    end
end)

RegisterServerEvent('baseevents:enteredVehicle')
AddEventHandler('baseevents:enteredVehicle', function(veh)
    local user = ESX.GetPlayerFromId(source)
    TriggerClientEvent('nadrp-vehdamage:EnteredVehicle', user.source)
end)