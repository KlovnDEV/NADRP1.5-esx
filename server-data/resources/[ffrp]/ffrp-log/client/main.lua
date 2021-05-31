ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

function AddLog(table, name, identifier, type, log, business)
    if log == nil then return end
    if table == nil then return end
    if table == 'Admin' then
        TriggerServerEvent('ffrp-log:AdminLog', name, identifier, type, log)
    elseif table == 'exploiter' then
        TriggerServerEvent('ffrp-log:ExploiterLog', name, identifier, type, log)
    elseif table == 'business' then
        TriggerServerEvent('ffrp-log:BusinessLog', name, identifier, type, log, business)
    end
end