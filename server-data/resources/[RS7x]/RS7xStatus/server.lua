ESX = nil
TriggerEvent('tac:getSharedObject', function (obj) ESX = obj end)


RegisterServerEvent('RS7x:CheckTstate')
AddEventHandler('RS7x:CheckTstate', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    src = xPlayer.source
    if target ~= nil then
        TriggerClientEvent('RS7x:Tcheck', target)
    end
end)

RegisterServerEvent('RS7x:TargetResult')
AddEventHandler('RS7x:TargetResult', function(msg)
    if tonumber(source) ~= tonumber(src) then
        TriggerClientEvent('chat:addMessage', src, {
            template = '<div class="chat-message nonemergency">SUSPECT :: {0} </div>',
            args = {msg}
        })
    end
end)