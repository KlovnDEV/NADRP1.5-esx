ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

function AddLog(table, name, identifier, type, log, business)
    if log == nil then return end
    if table == nil then return end
    if table == 'Admin' then
        TriggerServerEvent('nadrp-log:AdminLog', name, identifier, type, log)
    elseif table == 'exploiter' then
        TriggerServerEvent('nadrp-log:ExploiterLog', name, identifier, type, log)
    elseif table == 'business' then
        TriggerServerEvent('nadrp-log:BusinessLog', name, identifier, type, log, business)
    end
end