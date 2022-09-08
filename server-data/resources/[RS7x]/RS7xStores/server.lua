ESX = nil

TriggerEvent('tac:getSharedObject', function (obj) ESX = obj end)

local stores = {
    [1] =  { ['x'] = 24.18,['y'] = -1347.35,['z'] = 29.5,['h'] = 271.32, ["recent"] = false,["reg"] = 0, ["safe"] = true , ["started"] = false, ["lastRobbed"] = os.time() + math.random(1000, 3000), ["beingHit"] = false},
    [2] =  { ['x'] = -46.56,['y'] = -1757.98,['z'] = 29.43,['h'] = 48.68, ["recent"] = false,["reg"] = 0, ["safe"] = true ,["started"] = false, ["lastRobbed"] = os.time() + math.random(1000, 3000), ["beingHit"] = false},
    [3] =  { ['x'] = -706.02,['y'] = -913.61,['z'] = 19.22,['h'] = 85.61, ["recent"] = false,["reg"] = 0, ["safe"] = true ,["started"] = false, ["lastRobbed"] = os.time() + math.random(1000, 3000), ["beingHit"] = false},
    [4] =  { ['x'] = -1221.97,['y'] = -908.42,['z'] = 12.33,['h'] = 31.1, ["recent"] = false,["reg"] = 0, ["safe"] = true ,["started"] = false, ["lastRobbed"] = os.time() + math.random(1000, 3000), ["beingHit"] = false},
    [5] =  { ['x'] = 1164.99,['y'] = -322.78,['z'] = 69.21,['h'] = 96.91, ["recent"] = false,["reg"] = 0, ["safe"] = true ,["started"] = false, ["lastRobbed"] = os.time() + math.random(1000, 3000), ["beingHit"] = false},
    [6] =  { ['x'] = 372.25,['y'] = 326.43,['z'] = 103.57,['h'] = 252.9,  ["recent"] = false,["reg"] = 0, ["safe"] = true ,["started"] = false, ["lastRobbed"] = os.time() + math.random(1000, 3000), ["beingHit"] = false},
    [7] =  { ['x'] = -1819.98,['y'] = 794.57,['z'] = 138.09,['h'] = 126.56, ["recent"] = false,["reg"] = 0, ["safe"] = true,["started"] = false, ["lastRobbed"] = os.time() + math.random(1000, 3000), ["beingHit"] = false},
    [8] =  { ['x'] = -2966.24,['y'] = 390.94,['z'] = 15.05,['h'] = 84.58, ["recent"] = false,["reg"] = 0, ["safe"] = true ,["started"] = false, ["lastRobbed"] = os.time() + math.random(1000, 3000), ["beingHit"] = false},
    [9] =  { ['x'] = -3038.92,['y'] = 584.21,['z'] = 7.91,['h'] = 19.43,  ["recent"] = false,["reg"] = 0, ["safe"] = true ,["started"] = false, ["lastRobbed"] = os.time() + math.random(1000, 3000), ["beingHit"] = false},
    [10] =  { ['x'] = -3242.48,['y'] = 999.79,['z'] = 12.84,['h'] = 351.35,["recent"] = false,["reg"] = 0, ["safe"] = true ,["started"] = false, ["lastRobbed"] = os.time() + math.random(1000, 3000), ["beingHit"] = false},
    [11] =  { ['x'] = 2557.14,['y'] = 380.64,['z'] = 108.63,['h'] = 353.01,["recent"] = false,["reg"] = 0, ["safe"] = true ,["started"] = false, ["lastRobbed"] = os.time() + math.random(1000, 3000), ["beingHit"] = false},
    [12] =  { ['x'] = 1166.02,['y'] = 2711.15,['z'] = 38.16,['h'] = 175.0, ["recent"] = false,["reg"] = 0, ["safe"] = true ,["started"] = false, ["lastRobbed"] = os.time() + math.random(1000, 3000), ["beingHit"] = false}, -- finish reg below
    [13] =  { ['x'] = 549.32,['y'] = 2671.3,['z'] = 42.16,['h'] = 94.96, ["recent"] = false,["reg"] = 0, ["safe"] = true ,["started"] = false, ["lastRobbed"] = os.time() + math.random(1000, 3000), ["beingHit"] = false},
    [14] =  { ['x'] = 1959.96,['y'] = 3739.99,['z'] = 32.35,['h'] = 296.38, ["recent"] = false,["reg"] = 0, ["safe"] = true ,["started"] = false, ["lastRobbed"] = os.time() + math.random(1000, 3000), ["beingHit"] = false},
    [15] =  { ['x'] = 2677.98,['y'] = 3279.28,['z'] = 55.25,['h'] = 327.81, ["recent"] = false,["reg"] = 0, ["safe"] = true ,["started"] = false, ["lastRobbed"] = os.time() + math.random(1000, 3000), ["beingHit"] = false},
    [16] =  { ['x'] = 1392.88,['y'] = 3606.7,['z'] = 34.99,['h'] = 201.69, ["recent"] = false,["reg"] = 0, ["safe"] = false ,["started"] = false, ["lastRobbed"] = os.time() + math.random(1000, 3000), ["beingHit"] = false}, -- no safe
    [17] =  { ['x'] = 1697.8,['y'] = 4922.69,['z'] = 42.07,['h'] = 322.95, ["recent"] = false,["reg"] = 0, ["safe"] = true ,["started"] = false, ["lastRobbed"] = os.time() + math.random(1000, 3000), ["beingHit"] = false},
    [18] =  { ['x'] = 1728.82,['y'] = 6417.38,['z'] = 35.04,['h'] = 233.94, ["recent"] = false,["reg"] = 0, ["safe"] = true ,["started"] = false, ["lastRobbed"] = os.time() + math.random(1000, 3000), ["beingHit"] = false},
}

local registers = {
    [1] = {["x"] = 24.451, ["y"] = -1347.4, ["z"] = 29.497, ["h"] = 268.138,  ["Robbed"] = false, ["beingHit"] = false},
    [2] = {["x"] = 24.422, ["y"] = -1345.033, ["z"] = 29.497, ["h"] = 279.993,  ["Robbed"] = false, ["beingHit"] = false},
    [3] = {["x"] = -47.861, ["y"] = -1759.348, ["z"] = 29.421, ["h"] = 60.246,  ["Robbed"] = false, ["beingHit"] = false},
    [4] = {["x"] = -46.753, ["y"] = -1758.096, ["z"] = 29.421, ["h"] = 52.583,  ["Robbed"] = false, ["beingHit"] = false},
    [5] = {["x"] = -706.036, ["y"] = -915.436, ["z"] = 19.216, ["h"] = 90.733,  ["Robbed"] = false, ["beingHit"] = false},
    [6] = {["x"] = -706.003, ["y"] = -913.698, ["z"] = 19.216, ["h"] = 90.895,  ["Robbed"] = false, ["beingHit"] = false},
    [7] = {["x"] = -1222.056, ["y"] = -908.334, ["z"] = 12.326, ["h"] = 33.048,  ["Robbed"] = false, ["beingHit"] = false},
    [8] = {["x"] = 1165.017, ["y"] = -324.523, ["z"] = 69.205, ["h"] = 100.675,  ["Robbed"] = false, ["beingHit"] = false},
    [9] = {["x"] = 1164.814, ["y"] = -322.743, ["z"] = 69.205, ["h"] = 96.523,  ["Robbed"] = false, ["beingHit"] = false},
    [10] = {["x"] = 373.009, ["y"] = 328.669, ["z"] = 103.566, ["h"] = 250.414,  ["Robbed"] = false, ["beingHit"] = false},
    [11] = {["x"] = 372.428, ["y"] = 326.414, ["z"] = 103.566, ["h"] = 252.695,  ["Robbed"] = false, ["beingHit"] = false},
    [12] = {["x"] = -1818.816, ["y"] = 792.946, ["z"] = 138.081, ["h"] = 136.773,  ["Robbed"] = false, ["beingHit"] = false},
    [13] = {["x"] = -1820.104, ["y"] = 794.329, ["z"] = 138.088, ["h"] = 134.89,  ["Robbed"] = false, ["beingHit"] = false},
    [14] = {["x"] = -2966.281, ["y"] = 390.905, ["z"] = 15.043, ["h"] = 86.769,  ["Robbed"] = false, ["beingHit"] = false},
    [15] = {["x"] = -3038.996, ["y"] = 584.394, ["z"] = 7.909, ["h"] = 15.447,  ["Robbed"] = false, ["beingHit"] = false},
    [16] = {["x"] = -3041.035, ["y"] = 583.729, ["z"] = 7.909, ["h"] = 1.64,  ["Robbed"] = false, ["beingHit"] = false},
    [17] = {["x"] = -3242.48, ["y"] = 999.844, ["z"] = 12.831, ["h"] = 346.842,  ["Robbed"] = false, ["beingHit"] = false},
    [18] = {["x"] = -3244.845, ["y"] = 1000.119, ["z"] = 12.831, ["h"] = 338.975,  ["Robbed"] = false, ["beingHit"] = false},
    [19] = {["x"] = 2557.1, ["y"] = 380.617, ["z"] = 108.623, ["h"] = 1.091,  ["Robbed"] = false, ["beingHit"] = false},
    [20] = {["x"] = 2555.234, ["y"] = 380.692, ["z"] = 108.623, ["h"] = 345.982,  ["Robbed"] = false, ["beingHit"] = false},
    [21] = {["x"] = 1166.054, ["y"] = 2711.017, ["z"] = 38.158, ["h"] = 180.56,  ["Robbed"] = false, ["beingHit"] = false},
    [22] = {["x"] = 549.381, ["y"] = 2668.983, ["z"] = 42.157, ["h"] = 82.964,  ["Robbed"] = false, ["beingHit"] = false},
    [23] = {["x"] = 549.127, ["y"] = 2671.415, ["z"] = 42.157, ["h"] = 86.024,  ["Robbed"] = false, ["beingHit"] = false},
    [24] = {["x"] = 1958.892, ["y"] = 3742.014, ["z"] = 32.344, ["h"] = 292.649,  ["Robbed"] = false, ["beingHit"] = false},
    [25] = {["x"] = 1960.118, ["y"] = 3739.953, ["z"] = 32.344, ["h"] = 297.317,  ["Robbed"] = false, ["beingHit"] = false},
    [26] = {["x"] = 2675.975, ["y"] = 3280.497, ["z"] = 55.241, ["h"] = 323.621,  ["Robbed"] = false, ["beingHit"] = false},
    [27] = {["x"] = 2678.032, ["y"] = 3279.4, ["z"] = 55.241, ["h"] = 325.015,  ["Robbed"] = false, ["beingHit"] = false},
    [28] = {["x"] = 1392.863, ["y"] = 3606.412, ["z"] = 34.981, ["h"] = 190.913,  ["Robbed"] = false, ["beingHit"] = false},
    [29] = {["x"] = 1698.179, ["y"] = 4922.873, ["z"] = 42.064, ["h"] = 319.478,  ["Robbed"] = false, ["beingHit"] = false},
    [30] = {["x"] = 1696.552, ["y"] = 4923.884, ["z"] = 42.064, ["h"] = 331.393,  ["Robbed"] = false, ["beingHit"] = false},
    [31] = {["x"] = 1728.837, ["y"] = 6417.242, ["z"] = 35.037, ["h"] = 240.913,  ["Robbed"] = false, ["beingHit"] = false},
    [32] = {["x"] = 1727.803, ["y"] = 6415.25, ["z"] = 35.037, ["h"] = 241.09,  ["Robbed"] = false, ["beingHit"] = false},
}

local resetTimer = ((60 * 1000) * 30)

RegisterServerEvent('store:robbery:register')
AddEventHandler('store:robbery:register', function(storeid, regid)
    local user = ESX.GetPlayerFromId(source)

    if not stores[storeid]["recent"] then
        if not registers[regid]["Robbed"] then
            if not registers[regid]["beingHit"] then
                TriggerClientEvent('store:register', user.source, storeid, regid)
                stores[storeid]["started"] = true
                registers[regid]["beingHit"] = true
                --stores[storeid]["lastRobbed"] = os.time()
            else
                TriggerClientEvent('mythic_notify:client:DoLongHudText', user.source, { type = 'inform', text = "Someone is already hitting this safe you, Shitlord fuck."})
            end
        else
            TriggerClientEvent('mythic_notify:client:DoLongHudText', user.source, { type = 'inform', text = 'This register seems to be empt. Almost like it just got hit it. :)'})
        end
    end
end)

RegisterServerEvent('store:robbery:safe')
AddEventHandler('store:robbery:safe', function(storeid)
    local user = ESX.GetPlayerFromId(source)
    if not stores[storeid]["recent"] then
        if stores[storeid]["safe"] == true then
            if stores[storeid]["reg"] == 2 then
                if not stores[storeid]["beingHit"] == true then
                    stores[storeid]["beingHit"] = true
                    TriggerClientEvent('store:dosafe', user.source)
                else
                    TriggerClientEvent('mythic_notify:client:DoLongHudText', user.source, { type = 'inform', text = "Someone is already hitting this safe you, Shitlord fuck."})
                end
            elseif storeid == 4 or storeid == 8 or storeid == 12 or storeid == 16 then
                if stores[storeid]["reg"] == 1 then
                    if not stores[storeid]["beingHit"] == true then
                        stores[storeid]["beingHit"] = true
                        TriggerClientEvent('store:dosafe', user.source)
                    else
                        TriggerClientEvent('mythic_notify:client:DoLongHudText', user.source, { type = 'inform', text = "Someone is already hitting this safe you, Shitlord fuck."})
                    end
                else
                    TriggerClientEvent('mythic_notify:client:DoLongHudText', user.source, { type = 'inform', text = 'You need to finish robbing the front before doing the safe.'})
                end
            else
                TriggerClientEvent('mythic_notify:client:DoLongHudText', user.source, { type = 'inform', text = 'You need to finish robbing the front before doing the safe.'})
            end
        end
    else
        TriggerClientEvent('mythic_notify:client:DoLongHudText', user.source, { type = 'inform', text = 'This safe seems to be empty come back later.'})
    end
end)

--safe:complete
RegisterServerEvent('safe:complete')
AddEventHandler('safe:complete', function(storeid)
    if not stores[storeid]["recent"] then
        stores[storeid]["recent"] = true
        stores[storeid]["started"] = false
    end
end)

RegisterServerEvent('register:complete')
AddEventHandler('register:complete', function(storeid, regid)
    if storeid ~= nil and regid ~= nil then
        stores[storeid]["reg"] = stores[storeid]["reg"] + 1
        registers[regid]["Robbed"] = true
        registers[regid]["beingHit"] = false
    end
end)

RegisterServerEvent('reset:started')
AddEventHandler('reset:started', function(storeid)
    stores[storeid]["started"] = false
    stores[storeid]["beingHit"] = false
end)

RegisterServerEvent('store:pay')
AddEventHandler('store:pay', function(amount)
    local user = ESX.GetPlayerFromId(source)
    if amount ~= nil then
        user.addMoney(amount)
    end
end)

RegisterServerEvent('stores:giveItem')
AddEventHandler('stores:giveItem', function(item, amount)
    local user = ESX.GetPlayerFromId(source)
    if item ~= nil and amount ~= nil then
       --user.addInventoryItem(item, amount)
       TriggerClientEvent('player:receiveItem',source, item.id, item.quantity) 
    end
end)

function resetStores()
    for i=1, #stores do
        if not stores[i]["started"] then
            stores[i]["reg"] = 0
            stores[i]["started"] = false
            stores[i]["recent"] = false
            for ind=1, #registers do
                registers[ind]["Robbed"] = false
            end
        end
    end
    SetTimeout(resetTimer, resetStores)
end
SetTimeout(resetTimer, resetStores)

ESX.RegisterServerCallback('GetPoliceOnline', function(source,cb)
    local xPlayers = ESX.GetPlayers()
    local police = 0
    for i=1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            police = police + 1
        end
    end
    cb(police)
end)