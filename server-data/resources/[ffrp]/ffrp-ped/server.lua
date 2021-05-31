
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('tac:playerLoaded', function(source)
	TriggerEvent("playerSpawned", source)
end)

RegisterServerEvent('ffrp:setMetaData')
AddEventHandler('ffrp:setMetaData', function(data)
  local src = source
  local user = ESX.GetPlayerFromId(src)
  local ident = user.identifier
  MySQL.Async.execute('UPDATE users SET metaData=@metaData WHERE identifier=@ident', {
    ['@ident'] = ident,
    ['@metaData'] = json.encode(data)
  })
end)

RegisterServerEvent('ffrp:GetMetaData')
AddEventHandler('ffrp:GetMetaData', function()
  local src = source
  local user = ESX.GetPlayerFromId(src)
  local ident = user.identifier
  MySQL.Async.fetchAll('SELECT metaData FROM users WHERE identifier=@identifier', {
    ['@identifier'] = ident
  }, function(result)
    if result ~= nil then
      local data = json.decode(result[1].metaData)
      TriggerClientEvent('ffrp:LoadMetaData', user.source, data)
    end
  end)
end)

RegisterServerEvent('CheckMyLicense')
AddEventHandler('CheckMyLicense', function()
  local _src = source
  local player = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM user_licenses WHERE owner = @owner', {
      ['@owner'] = player.identifier
    }, function (result)
      if result[1] ~= nil then
        if result[1].type == 'weapon'then
          TriggerClientEvent('wtflols',_src, player.getMoney(), 1)
        end
      end
    end)
end)


RegisterServerEvent('CheckMyCallSign')
AddEventHandler('CheckMyCallSign', function()
  local _src = source
  local player = ESX.GetPlayerFromId(_src)
  MySQL.Async.fetchAll('SELECT callsign FROM characters WHERE identifier=@ident', {
    ['@ident'] = player.identifier
  }, function(result)
    if result[1] ~= nil then
      local callsign = result[1].callsign
      if callsign ~= nil then
        TriggerClientEvent('ffrp-dispatch:myCallsign', player.source, tostring(callsign))
      end
    end
  end)
end)

exports('GetMyCid', function(identifier)
  MySQL.Async.fetchAll('SELECT id FROM users WHERE identifier=@identifier', {
    ['@identifier'] = identifier
  }, function(result)
    if result ~= nil then
      if result[1].id ~= nil then
        local cid = result[1].id
        return cid
      else
        return false
      end
    end 
  end)
end)