ESX               = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("tinoki-qualityjob:sell")
AddEventHandler("tinoki-qualityjob:sell", function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local money = math.random(80,500)
      xPlayer.addMoney(money)
      TriggerClientEvent("pNotify:SendNotification", source, {text = "paycheck: " ..money.. " cash!", timeout = 3000})
      end)