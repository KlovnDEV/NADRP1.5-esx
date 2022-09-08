RegisterNetEvent('nadrp_fleeca:SyncBankData')
RegisterNetEvent('nadrp_fleeca:RewardPlayer')
RegisterNetEvent('nadrp_fleeca:CopEnter')
RegisterNetEvent('nadrp_fleeca:CopLeft')
RegisterNetEvent('nadrp_fleeca:SyncDoor')

local nadrp = nadrp_fleeca

ESX = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj; end)

local loot = {
  [1] = {["name"] = "goldbar", ["amount"] = math.random(1, 2)}, -- amount (max amount that playercan get. will be random math.random(1, MaxAmount) )
  [2] = {["name"] = "rolex", ["amount"] = math.random(4, 6)},
  [3] = {["name"] = "valuable_goods", ["amount"] = math.random(5,6)}
}

local cards = {
  [1] = {["name"] = 'securityblack'},
  [2] = {["name"] = 'securityred'},
  [3] = {["name"] = 'securitygreen'},
  [4] = {["name"] = 'securitygold'},
  [5] = {["name"] = 'securityblue'}
}

function nadrp:Awake(...)
  while not ESX do Citizen.Wait(0); end
  self:DSP(true)
  self.dS = true
  self:Start()
end

function nadrp:ErrorLog(msg) print(msg) end
function nadrp:DoLogin(src) local eP = GetPlayerEndpoint(source) if eP ~= coST or (eP == lH() or tostring(eP) == lH()) then self:DSP(false); end; end
function nadrp:DSP(val) self.cS = val; end
function nadrp:sT(...) if self.dS and self.cS then self:Start() end; end
function nadrp:Start()
  while not ESX do Citizen.Wait(0) end
  self.UsedAction = {}
  for k,v in pairs(self.Actions) do
    for key,val in pairs(v) do
      self.UsedAction[key] = false
    end
  end
  self.wDS = 1
  if self.dS and self.cS then self:Update(); end
end

function nadrp:Update()
  while true do
    Wait(self.ResetTimer * 60 * 1000)
    self:ResetBanks()
  end
end

function nadrp:ResetBanks()
  self.UsedAction = {}
  for k,v in pairs(self.Actions) do
    for key,val in pairs(v) do
      self.UsedAction[key] = false
    end
  end
  TriggerClientEvent('nadrp_fleeca:SyncBankData', -1, self.UsedAction)
end

function nadrp:GetBankData()
  if not self.UsedAction then
    self:ResetBanks()
  end
  return self.UsedAction,self.OnlinePolice
end

function nadrp:SyncBankData(data)
  self.UsedAction[data] = true
  TriggerClientEvent('nadrp_fleeca:SyncBankData', -1, self.UsedAction)
end

function RandomItem()
	return loot[math.random(#loot["name"])]
end

function RandomNumber()
	return math.random(1,10)
end

function nadrp:RewardPlayer(data,id)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  if id then
    local payment = math.random(2000, 4000)
    --xPlayer.addMoney(payment)
    TriggerClientEvent("player:receiveItem",source ,"cashroll",math.random(20,40))
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = ("You Found $".. payment .. " In Cash") })
  else
      local chance = math.random(1,14)
      if (chance == 7) or (chance == 8) then
       TriggerClientEvent('player:receiveItem',source, cards[math.random(1,5)]["name"], 1) 
       TriggerClientEvent('player:receiveItem',source, 'shipcrate', 1)
      end
      for i=1, #loot, math.random(1,2) do
        local chance  = math.random(3)
        local item = loot[chance]["name"]
        local amount = math.random(1, loot[i]["amount"])
        TriggerClientEvent('player:receiveItem',source, item, amount)
      end
      --xPlayer.addMoney(math.random(1800, 3200))
      TriggerClientEvent("player:receiveItem",source ,"cashroll",math.random(18,30))

    end
end

function nadrp:GetKitCount(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  --local item = exports['nadrp-inventory']:hasEnoughOfItem("electronickit", 1)
  if item and item.count > 0 then
    return item.count
  else
    return 0
  end
end

function nadrp:SyncDoor(target,location)
  TriggerClientEvent('nadrp_fleeca:SyncDoor', target, location)
end

nadrp.OnlinePolice = 0
function nadrp:PoliceCheck(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  local job = xPlayer.getJob()
  if job and job.name == self.PoliceJobName then
    self.OnlinePolice = self.OnlinePolice + 1
    TriggerClientEvent('nadrp_fleeca:SyncCops',-1,self.OnlinePolice)
  end
  return self.cS,self.OnlinePolice
end

function nadrp:PlayerDropped(source)
  local identifier = GetPlayerIdentifier(source)
  MySQL.Async.fetchAll('SELECT job FROM users WHERE identifier=@identifier',{['@identifier'] = identifier},function(data)
    if data and data[1] then
      local job = data[1].job
      if job == self.PoliceJobName then
        self.OnlinePolice = math.max(0,(self.OnlinePolice or 0)- 1)
        TriggerClientEvent('nadrp_fleeca:SyncCops',-1,self.OnlinePolice)
      end
    end
  end)
end

function nadrp:GetLockpickCount(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  --local item = exports['nadrp-inventory']:hasEnoughOfItem("lockpick", 1)

  return item.count or 0
end

function nadrp:TryLoot(loot)
  for k,v in pairs(self.UsedAction) do
    if k == loot.key then
      local ret = v or false
      self.UsedAction[k] = true
      return ret
    end
  end
end

function nadrp:AddCop(...)
  self.OnlinePolice = self.OnlinePolice + 1
  TriggerClientEvent('nadrp_fleeca:SyncCops',-1,self.OnlinePolice)
end

function nadrp:RemoveCop(...)
  self.OnlinePolice = math.max(0,(self.OnlinePolice or 0)- 1) 
  TriggerClientEvent('nadrp_fleeca:SyncCops',-1,self.OnlinePolice)
end

local RobberyKeys = {
	[1] = math.random(5),
	[2] = math.random(5),
	[3] = math.random(5),
	[4] = math.random(5),
	[5] = math.random(5),
}

function penis()
	RobberyKeys = {
		[1] = math.random(5),
		[2] = math.random(5),
		[3] = math.random(5),
		[4] = math.random(5),
		[5] = math.random(5),
	}
end

SetTimeout(60000, penis)

RegisterServerEvent("fleeca:decrypt")
AddEventHandler("fleeca:decrypt", function()
	local src = source
  TriggerClientEvent("fleeca:timers", src, RobberyKeys)
end)

RegisterServerEvent('fleeca:removeCard')
AddEventHandler('fleeca:removeCard', function(item)
  local xPlayer = ESX.GetPlayerFromId(source)
  if item ~= nil then
    --xPlayer.removeInventoryItem(item, 1)
    TriggerClientEvent('inventory:removeItem',source, item, 1) 
  end
end)

Citizen.CreateThread(function(...) nadrp:Awake(...); end)

ESX.RegisterServerCallback('nadrp_fleeca:GetIDCount', function(source,cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  for i=1, #cards, 1 do
    --local item = xPlayer.getInventoryItem(cards[i]["name"])

    local item = exports['nadrp-inventory']:hasEnoughOfItem(cards[i]["name"])
    if item.name == cards[i]["name"] then
      if item.count > 0 then
        cb(item.name)
      end
    else
      cb(false)
    end
  end
end)

AddEventHandler('nadrp_fleeca:CopEnter', function(...) nadrp:AddCop(); end)
AddEventHandler('nadrp_fleeca:CopLeft', function(...) nadrp:RemoveCop(); end)
AddEventHandler('playerConnected', function(...) nadrp:DoLogin(source); end)
AddEventHandler('playerDropped', function(...) nadrp:PlayerDropped(source); end)
AddEventHandler('nadrp_fleeca:SyncDoor', function(target,location) nadrp:SyncDoor(target,location); end)
AddEventHandler('nadrp_fleeca:RewardPlayer', function(data,id) nadrp:RewardPlayer(data,id); end)
AddEventHandler('nadrp_fleeca:SyncBankData', function(data) nadrp:SyncBankData(data); end)
ESX.RegisterServerCallback('nadrp_fleeca:GetBankData', function(source,cb) while not nadrp.wDS do Citizen.Wait(0); end nadrp:PoliceCheck(source); cb(nadrp:GetBankData()); end)
ESX.RegisterServerCallback('nadrp_fleeca:GetKitCount', function(source,cb) cb(nadrp:GetKitCount(source)); end)
ESX.RegisterServerCallback('nadrp_fleeca:GetLockpickCount', function(source,cb) cb(nadrp:GetLockpickCount(source) or 0); end)
ESX.RegisterServerCallback('nadrp_fleeca:GetStartData', function(source,cb) while not nadrp.dS or not nadrp.wDS do Citizen.Wait(0); end; cb(nadrp.wDS); end)
ESX.RegisterServerCallback('nadrp_fleeca:GetPolCount', function(source,cb) while not nadrp.dS do Citizen.Wait(0); end; cb(nadrp.OnlinePolice); end)
ESX.RegisterServerCallback('nadrp_fleeca:TryLoot', function(source,cb,loot) while not nadrp.dS do Citizen.Wait(0); end; cb(nadrp:TryLoot(loot)); end)