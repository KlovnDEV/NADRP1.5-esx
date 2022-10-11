if AK4Y.Framework == "esx" then
    ESX = nil
    TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
elseif AK4Y.Framework == "newEsx" then 
    ESX = exports["es_extended"]:getSharedObject()
end

ESX.RegisterServerCallback('ak4y-dailyTasks:selectTask', function(source, cb, data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local citizenId = xPlayer.identifier
    local selectedTask = {}
    local callbackData = false
    local kayit = false
    local currentBank = xPlayer.getAccount('bank').money
    for k, v in pairs(AK4Y.Tasks) do
        if v.taskId == data.itemDetails.taskId then 
            selectedTask.taskId = v.taskId
            selectedTask.reward = v.reward
            selectedTask.neededPlayTime = v.neededPlayTime
            if currentBank >= v.taskPrice then 
                kayit = true
                xPlayer.removeAccountMoney('bank', tonumber(v.taskPrice))
            end
            break
        end
    end
    if selectedTask and kayit then 
        ExecuteSql("INSERT INTO ak4y_dailytasks SET citizenid = '"..citizenId.."', selectedTask = '"..json.encode(selectedTask).."', playTime = '"..selectedTask.neededPlayTime.."', taskResetTime = (CURDATE() + INTERVAL "..AK4Y.StandartTaskDay.." DAY)")
        callbackData = true
    end
    cb(callbackData)
end)

ESX.RegisterServerCallback('ak4y-dailyTasks:cancelTask', function(source, cb, data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local citizenId = xPlayer.identifier
    ExecuteSql("DELETE FROM ak4y_dailytasks WHERE citizenid = '"..citizenId.."'")
    cb(true)
end)

ESX.RegisterServerCallback('ak4y-dailyTasks:getReward', function(source, cb, data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local citizenId = xPlayer.identifier
    local result = ExecuteSql("SELECT * FROM ak4y_dailytasks WHERE citizenid = '"..citizenId.."'")
    if result[1] ~= nil then
        if result[1].done then 
            local money = tonumber(json.decode(result[1].selectedTask).reward)
            xPlayer.addAccountMoney('bank', money)
            ExecuteSql("DELETE FROM ak4y_dailytasks WHERE citizenid = '"..citizenId.."'")
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('ak4y-dailyTasks:playTimeCheck', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local citizenId = xPlayer.identifier
    local selectedTask = nil
    local callbackData = nil
    local result = ExecuteSql("SELECT * FROM ak4y_dailytasks WHERE citizenid = '"..citizenId.."'")
    if result[1] ~= nil then 
        callbackData = result[1]
    end
    cb(callbackData)
end)

RegisterNetEvent('ak4y-dailyTasks:updateTime')
AddEventHandler('ak4y-dailyTasks:updateTime', function(count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local citizenId = xPlayer.identifier
    ExecuteSql("UPDATE ak4y_dailytasks SET playTime = '"..tonumber(count).."' WHERE citizenid = '"..citizenId.."'")
end)

RegisterNetEvent('ak4y-dailyTasks:setDone')
AddEventHandler('ak4y-dailyTasks:setDone', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local citizenId = xPlayer.identifier
    ExecuteSql("UPDATE ak4y_dailytasks SET done = '1', playTime = '0' WHERE citizenid = '"..citizenId.."'")
end)

Citizen.CreateThread(function()
    while true do
        ExecuteSql("DELETE FROM ak4y_dailytasks WHERE (taskResetTime <= CURDATE() AND done = 0)") 
        Wait(5*60000)
    end
end)

function ExecuteSql(query)
    local IsBusy = true
    local result = nil
    if AK4Y.Mysql == "oxmysql" then
        if MySQL == nil then
            exports.oxmysql:execute(query, function(data)
                result = data
                IsBusy = false
            end)
        else
            MySQL.query(query, {}, function(data)
                result = data
                IsBusy = false
            end)
        end
    elseif AK4Y.Mysql == "ghmattimysql" then
        exports.ghmattimysql:execute(query, {}, function(data)
            result = data
            IsBusy = false
        end)
    elseif AK4Y.Mysql == "mysql-async" then   
        MySQL.Async.fetchAll(query, {}, function(data)
            result = data
            IsBusy = false
        end)
    end
    while IsBusy do
        Citizen.Wait(0)
    end
    return result
end