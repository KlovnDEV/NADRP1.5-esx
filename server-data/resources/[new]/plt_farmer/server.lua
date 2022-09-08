local PLT = plt_farmer
ESX = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
Citizen.CreateThread(function(...) while not ESX do Citizen.Wait(10)TriggerEvent('tac:getSharedObject', function(obj) ESX = obj; end) end end)

local Info = {}
local Objeler = {}
Citizen.CreateThread(function()
  for k,v in pairs(PLT.Area) do 
    table.insert(Info,{number = k , source = nil })
    Objeler[k] = {}
  end
end)

ESX.RegisterServerCallback('plt_farmer:CheckAvailableArea', function(source, cb, arg) 
  cb(Info)
end) 

ESX.RegisterServerCallback('plt_farmer:CanISelecetThis', function(source, cb, arg) 
  local src = source
  for k,v in pairs(Info) do 
    if v.number == arg then
      if v.source == nil then 
        v.source = src
        cb(true)
      else
        TriggerClientEvent('mythic_notify:client:DoLongHudText', src, { type = 'error', text = PLT.U["cant_select"]})
        cb(false)
      end
      break
    end
  end
end) 

RegisterNetEvent("plt_farmer:CancelWork")
AddEventHandler("plt_farmer:CancelWork", function()
  local src = source
  for k,v in pairs(Info) do 
    if v.source == src then 
      Entitydeleter(k)
      v.source = nil
      break 
    end
  end
end)

RegisterNetEvent("plt_farmer:Tarlabitti")
AddEventHandler("plt_farmer:Tarlabitti", function()
  local src = source
  for k,v in pairs(Info) do 
    if v.source == src then 
      v.source = nil
      break 
    end
  end
end)

RegisterNetEvent("plt_farmer:MissionComplate")
AddEventHandler("plt_farmer:MissionComplate", function(id)
  local src = source
  local xPlayer = ESX.GetPlayerFromId(src)
  if PLT.PaymentMethodWithBank  then 
    xPlayer.addAccountMoney('bank', PLT.EarnedMoney)
  else
    xPlayer.addMoney(PLT.EarnedMoney)
  end      
  --TriggerEvent('plt_soygunlog',xPlayer.source,"meslekloglari","Çiftçilik",PLT.EarnedMoney,"1")
  TriggerClientEvent('mythic_notify:client:DoLongHudText', xPlayer.source, { type = 'inform', text = PLT.EarnedMoney..PLT.U["won"]})
  for k,v in pairs(Info) do 
    if v.source == src then 
      Entitydeleter(k)
      v.source = nil
      break 
    end
  end
end)

AddEventHandler("playerDropped", function()
  local src = source
  for k,v in pairs(Info) do 
    if v.source == src then 
      Entitydeleter(k)
      v.source = nil
      break 
    end
  end
end)

 function Entitydeleter(area)
  for k,v in pairs(Objeler[area]) do 
    if DoesEntityExist(v) then 
      DeleteEntity(v)
    end
  end
  Objeler[area] = {}
end

RegisterNetEvent("plt_farmer:AddEntity")
AddEventHandler("plt_farmer:AddEntity", function(arg1,arg2)
  local objeaydi = arg1
  local area = arg2
	for i = 1, 10, 1 do Citizen.Wait(0)
    if NetworkGetEntityFromNetworkId(objeaydi) ~= 0 then
      table.insert(Objeler[area], NetworkGetEntityFromNetworkId(objeaydi))
      break 
    end
    Citizen.Wait(100)
  end
end)

RegisterServerEvent("plt_farmer:DeleteEntity", function(id)
  local ent = NetworkGetEntityFromNetworkId(id)
  if DoesEntityExist(ent) then
      DeleteEntity(ent)
  end
end)