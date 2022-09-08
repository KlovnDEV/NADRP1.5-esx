local ffrp = ffrp_fleeca


function ffrp:Start(...)
  while not ESX do Citizen.Wait(0); end
  while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
  self.PlayerData = ESX.GetPlayerData()
  ESX.TriggerServerCallback('ffrp_fleeca:GetBankData', function(usedActions,cops) 
    self.PoliceOnline = cops or 0
    self.UsedActions = usedActions
    if self.dS and self.cS then self:Update(); end
  end)
end

local bankingBanks = {
  [1] = {["x"] = 150.266, ["y"] = -1040.203, ["z"] = 29.374},
  [2] = {["x"] = -1212.980, ["y"] = -330.841, ["z"] = 37.787},
  [3] = {["x"] = -2962.582, ["y"] = 482.627, ["z"] = 15.703},
  [4] = {["x"] = -112.202, ["y"] = 6469.295, ["z"] = 31.626},
  [5] = {["x"] = 314.187, ["y"] = -278.621, ["z"] = 54.170},
  [6] = {["x"] = -351.534, ["y"] = -49.529, ["z"] = 49.042},
  [7] = {["x"] = 241.727, ["y"] = 220.706, ["z"] = 106.286},
  [8] = {["x"] = 1176.0833740234, ["y"] = 2706.3386230469, ["z"] = 37.157722473145}
}

function ffrp:Update()
  local tick = 0
  local lastPolCheck = GetGameTimer()
  while self.dS and self.cS do
    local waitTime = 0

    tick = tick + 1
    local plyPed = GetPlayerPed(-1)
    local plyPos = GetEntityCoords(plyPed)
    local closestKey,closestVal,closestDist = self:GetClosestBank(plyPos)
    if closestDist < self.LoadDist then
      if self.PoliceOnline and self.PoliceOnline >= self.MinPoliceOnline then
        if not self.CurBank or self.CurBank.key ~= closestKey then
          self.CurBank = { key = closestKey, val = closestVal }
          ESX.TriggerServerCallback('ffrp_fleeca:GetPolCount', function(count) self.PoliceOnline = count; end)
        end

        local actKey,actVal,actDist = self:GetClosestAction(plyPos,closestKey)
        if actDist < self.ActionDist then
          if not self.CurAction or self.CurAction.key ~= actKey then
            if actVal ~= "LootVault" or (actVal == "LootVault" and self.SafeOpen) then
              self.CurAction = { key = actKey, val = actVal }
              if actVal ~= "OpenVault" then
                self.CurText = "Press [ ~r~E~s~ ] to " .. self.TextAddons[actVal]
              end
            end
          end
          if not self.UsedActions[actKey] and not self.Interacting then
            if actVal ~= "OpenVault" then
              Utils:DrawText3D(actKey.x, actKey.y, actKey.z, self.CurText)
              if Utils:GetKeyPressed(self.InteractKey) then
                self:Interact(self.CurAction)
              end
            end
          end
        end
      else
        waitTime = 1000
      end
    else
      self.CurBank = false
      self.SafeOpen = false
      waitTime = 1000
    end

    if self.MovedDoors then
      for k,v in pairs(self.MovedDoors) do
        local plyPos = GetEntityCoords(GetPlayerPed(-1))
        local dist = Utils:GetVecDist(plyPos, GetEntityCoords(v))
        if dist > 50.0 then
          DeleteObject(v)
          table.remove(self.MovedDoors, k)
        end
      end
    end
    Citizen.Wait(waitTime)
  end
end

function ffrp:GetClosestBank(plyPos)
  local closestKey,closestVal,closestDist
  for k,v in pairs(self.Banks) do
    local dist = Utils:GetVecDist(plyPos, v)
    if not closestDist or dist < closestDist then
      closestKey = k
      closestVal = v
      closestDist = dist
    end
  end
  if not closestDist then return false,false,999999
  else return closestKey,closestVal,closestDist
  end
end

function ffrp:GetClosestAction(plyPos,key)
  local closestKey,closestVal,closestDist
  for k,v in pairs(self.Actions[key]) do
    local dist = Utils:GetVecDist(plyPos, k)
    if not closestDist or dist < closestDist then
      closestKey = k
      closestVal = v
      closestDist = dist
    end
  end
  if not closestDist then return false,false,999999
  else return closestKey,closestVal,closestDist
  end
end
local justHacked = false
function ffrp:Interact(closest, card)
  if self.Interacting then return; end
  self.Interacting = closest
  local playerCoords = GetEntityCoords(GetPlayerPed(-1))
  streetName,street2 = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
  streetName = GetStreetNameFromHashKey(streetName)..' | '..GetStreetNameFromHashKey(street2)
  if closest.val == "LockpickDoor" then
    if exports['nadrp-inventory']:hasEnoughOfItem("advlockpick", 1, false) then
      TriggerEvent('civilian:alertPolice', 90.0, 'fleeca', 0,0,0)
      TriggerEvent('MF_LockPicking:StartMinigame')
    else
      self.Interacting = false
      exports['mythic_notify']:SendAlert('error', 'The Cashier is on holiday')
    end
  elseif closest.val == "LootID" then
    self:LootHandler(closest,true)
  elseif closest.val == "OpenVault" then
    TriggerEvent('civilian:alertPolice', 90.0, 'fleeca', 0,0,0)
    local pass = PassCard(card)
    if pass then
      self:HandleVaultDoor(closest)
    end
  elseif closest.val == "LootVault" then
      local hasItem = exports['nadrp-inventory']:hasEnoughOfItem("electronickit", 1)
      if hasItem then
        if not justHacked then
          justHacked = true
          self:LootHandler(closest,false)
          TriggerEvent('fleeca:startHacking', true, closest)
          TriggerEvent('civilian:alertPolice', 90.0, 'fleeca', 0,0,0)
        end
        Wait(500)
        justHacked = false
      else
        exports['mythic_notify']:DoHudText('error', 'You need a electronic-kit to open this open.')
        self.Interacting = false
      end
  end
end

function ffrp:LootHandler(closest,idcard)
  ESX.TriggerServerCallback('ffrp_fleeca:TryLoot',function(isLooted)
    if not isLooted then
      local plyPed = GetPlayerPed(-1)

      TaskTurnPedToFaceCoord(plyPed, closest.key.x, closest.key.y, closest.key.z, -1)
      Wait(2000)

      FreezeEntityPosition(plyPed,true)
      if idcard then
        TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, true)
        exports['t0sic_loadingbar']:StartDelayedFunction('Searching', self.InteractTimer * 1000, function()
        end)
      else
        --TaskStartScenarioInPlace(plyPed, "WORLD_HUMAN_WELDING", 0, true)
      end
      Wait(self.InteractTimer * 1000)

      if idcard then
        TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, false)
        Wait(1500)

        TriggerServerEvent('ffrp_fleeca:RewardPlayer', closest.key,idcard)

        ClearPedTasksImmediately(plyPed)
        FreezeEntityPosition(plyPed,false)
        self.Interacting = false
      end

      Wait(100)
      local obj = ESX.Game.GetClosestObject({},GetEntityCoords(plyPed))
      if GetEntityModel(obj)% 0x100000000 == 3284676632 then
        SetEntityAsMissionEntity(obj,false)
        DeleteObject(obj)
      end
    else
      exports['mythic_notify']:DoHudText('error', 'Somebody else it looting this already!')
      self.Interacting = false
    end
  end,closest)
end

function ffrp:LockpickComplete(result)
  Notify = false
  local plyPed = GetPlayerPed(-1)
  FreezeEntityPosition(plyPed,false)

  if result then
    local closest,closestDist
    local allObjs = ESX.Game.GetObjects()
    for k,v in pairs(allObjs) do
      local modelHash = GetEntityModel(v)
      local revHash = modelHash % 0x100000000
      if self.DoorHashes[modelHash] or self.DoorHashes[modelHash] then
        print(self.Interacting)
        local dist = Utils:GetVecDist(self.Interacting.key,GetEntityCoords(v))
        if not closestDist or dist < closestDist then
          closest = v
          closestDist = dist
        end
      end
    end

    if not closest or closestDist > self.LoadDist then
      self.Interacting = false
      return
    end

    local players = ESX.Game.GetPlayersInArea(self.Interacting.key,self.LoadDist)
    for k,v in pairs(players) do
      local newV = GetPlayerServerId(v)
      TriggerServerEvent('ffrp_fleeca:SyncDoor', newV, self.Interacting.key)
    end

    TriggerServerEvent('ffrp_fleeca:SyncBankData', self.Interacting.key)
    timer = GetGameTimer()
    Citizen.CreateThread(function()
      while (GetGameTimer() - timer) < 500 do
        Citizen.Wait(0)
        DisableControlAction(0,18,true) -- disable attack
        DisableControlAction(0,24,true) -- disable attack
        DisableControlAction(0,25,true) -- disable aim
        DisableControlAction(0,47,true) -- disable weapon
        DisableControlAction(0,58,true) -- disable weapon
        DisableControlAction(0,69,true) -- disable weapon
        DisableControlAction(0,92,true) -- disable weapon
        DisableControlAction(0,106,true) -- disable weapon
        DisableControlAction(0,122,true) -- disable weapon
        DisableControlAction(0,135,true) -- disable weapon
        DisableControlAction(0,142,true) -- disable weapon
        DisableControlAction(0,144,true) -- disable weapon
        DisableControlAction(0,176,true) -- disable weapon
        DisableControlAction(0,223,true) -- disable melee
        DisableControlAction(0,229,true) -- disable melee
        DisableControlAction(0,237,true) -- disable melee
        DisableControlAction(0,257,true) -- disable melee
        DisableControlAction(0,263,true) -- disable melee
        DisableControlAction(0,264,true) -- disable melee
        DisableControlAction(0,257,true) -- disable melee
        DisableControlAction(0,140,true) -- disable melee
        DisableControlAction(0,141,true) -- disable melee
        DisableControlAction(0,142,true) -- disable melee
        DisableControlAction(0,143,true) -- disable melee
        DisableControlAction(0,329,true) -- disable melee
        DisableControlAction(0,347,true) -- disable melee
      end
    end)
    Citizen.Wait(200)
    self.Interacting = false
  else
    self.Interacting = false
    Notify = false
  end
end

function ffrp:Awake(...)
    while not ESX do Citizen.Wait(0); end
    while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
    ESX.TriggerServerCallback('ffrp_fleeca:GetStartData', function(retVal) self.dS = true; self.cS = retVal; self:Start(); end)
end

function ffrp:HandleVaultDoor(closest)
  local plyPed = GetPlayerPed(-1)

  TaskTurnPedToFaceCoord(plyPed, closest.key.x, closest.key.y, closest.key.z, -1)
  Wait(2000)

  FreezeEntityPosition(plyPed,true)
  TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_ATM", 0, true)
  closeBank()
  exports['t0sic_loadingbar']:StartDelayedFunction("Requesting Access", self.InteractTimer * 1000, function ()
    TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_ATM", 0, false)
    Wait(1500)

    self.UsedActions[closest.key] = true
    TriggerServerEvent('ffrp_fleeca:SyncBankData', closest.key)

    ClearPedTasksImmediately(plyPed)
    FreezeEntityPosition(plyPed,false)
    Wait(100)

    ffrp:LockpickComplete(true)
    self.SafeOpen = true
  end)
end

function ffrp:SyncDoor(location)
  if not location then return; end
  Citizen.CreateThread(function(...)
    local isaVault = false
    self.MovedDoors = self.MovedDoors or {}
    local closest,closestDist
    local allObjs = ESX.Game.GetObjects()
    for k,v in pairs(allObjs) do
      local modelHash = GetEntityModel(v)
      local revHash = modelHash % 0x100000000

      if self.DoorHashes[modelHash] or self.DoorHashes[revHash] then
        local dist = Utils:GetVecDist(location,GetEntityCoords(v))
        if not closestDist or dist < closestDist then
          if modelHash == 2121050683 or revHash == 2121050683 then isaVault = true; else isaVault = false; end
          closest = v
          closestDist = dist
        end
      end
    end

    if not closest or closestDist > self.LoadDist then 
      self.Interacting = false
      return
    end

    SetEntityAsMissionEntity(closest,false)
    local heading = GetEntityHeading(closest)
    local tick = 0
    while ((heading - 100.0) < GetEntityHeading(closest)) and tick < 350 do
      Citizen.Wait(0)
      tick = tick + 1
      local heading = GetEntityHeading(closest)
      SetEntityHeading(closest, heading - 0.3)
    end
    if isaVault then self.SafeOpen = true; end
    table.insert(self.MovedDoors, closest)
  end)
end

local RobberyTimers = {}

RegisterNetEvent('securitycard:OnUse')
AddEventHandler('securitycard:OnUse', function(card)
  ffrp:cardUse(card)
  
end)

function ffrp:cardUse(card)
  local plyPos = GetEntityCoords(GetPlayerPed(-1))
  local closestKey,closestVal,closestDist = self:GetClosestBank(plyPos)
  local actKey,actVal,actDist = self:GetClosestAction(plyPos,closestKey)
  if closestDist < self.LoadDist then
    if self.PoliceOnline and self.PoliceOnline >= self.MinPoliceOnline then
      if not self.CurBank or self.CurBank.key ~= closestKey then
        self.CurBank = { key = closestKey, val = closestVal }
        ESX.TriggerServerCallback('ffrp_fleeca:GetPolCount', function(count)
          self.PoliceOnline = count
        end)
      end
    end
    if not self.UsedActions[actKey] and not self.Interacting then
      if actVal ~= "LootVault" or (actVal == "LootVault" and self.SafeOpen) then
        if (self.CurAction ~= nil) then
          ffrp:Interact(self.CurAction, card)
        end
      end
    end
  end
end

RegisterNetEvent('fleeca:startHacking')
AddEventHandler('fleeca:startHacking', function(cb)
  cb = true
  exports['t0sic_loadingbar']:StartDelayedFunction('Connecting Electronic-Kit', 5 * 1000, function()
    TriggerEvent('mhacking:seqstart', 6, 12, cb1)
  end)
end)

function ffrp:cb2(success, timeremaining)
  local plyPos = GetEntityCoords(GetPlayerPed(-1))
  local closestKey,closestVal,closestDist = self:GetClosestBank(plyPos)
  local actKey,actVal,actDist = self:GetClosestAction(plyPos,closestKey)
  self.Interacting = false

  if success then
    if actDist < self.ActionDist then
      self.CurAction = { key = actKey, val = actVal }
      if not self.UsedActions[actKey] and not self.Interacting then
        self.UsedActions[closestKey] = true
        TriggerServerEvent('ffrp_fleeca:SyncBankData', closestKey)
        TriggerServerEvent('ffrp_fleeca:RewardPlayer', closestKey,false)
      end
    end
    Hacking = false
  else
    self.CurAction = { key = actKey, val = actVal }
    self.UsedActions[closestKey] = true
    TriggerServerEvent('ffrp_fleeca:SyncBankData', closestKey)
    exports['mythic_notify']:SendAlert('error', 'You Failed to hack this safe, Move on to the next one')
    TriggerEvent('civilian:alertPolice', 90.0, 'fleeca', 0,0,0)
  end
  FreezeEntityPosition(PlayerPedId(),false)
  ClearPedTasksImmediately(PlayerPedId())
end

function cb1(success, timeremaining)
  ffrp:cb2(success, timeremaining)
end

function closeBank()
  for i=1, #bankingBanks do 
    if #(vector3(bankingBanks[i]["x"], bankingBanks[i]["y"], bankingBanks[i]["z"]) - GetEntityCoords(PlayerPedId())) <= 20.0 then 
      TriggerServerEvent('banking:updateClosedBank', i)
      return
    end
  end
end

RegisterNetEvent('fleeca:canDecrypt')
AddEventHandler('fleeca:canDecrypt', function()
  if #(vector3(GetEntityCoords(PlayerPedId())) - vector3(1275.6, -1710.69, 54.77)) < 3.0 then -- banks
    Decrypting = true
    exports['t0sic_loadingbar']:StartDelayedFunction('Decrypting', 20000, function()
      TriggerServerEvent('fleeca:decrypt')
      Decrypting = false
    end)
  elseif #(vector3(GetEntityCoords(PlayerPedId())) - vector3(1208.732, -3115.057,  5.542)) < 3.0 then -- stores
    Decrypting = true
    exports['t0sic_loadingbar']:StartDelayedFunction('Decrypting', 20000, function()
      TriggerEvent("lucky:storebro")
      Decrypting = false
    end)
  end
end)

RegisterNetEvent("fleeca:timers")
AddEventHandler("fleeca:timers", function(timers)
    RobberyTimers = timers
    local CardIds = ""
    for i = 1, 5 do
        if i ~= 1 then
            CardIds = CardIds .. " | Time Slot " .. i .. " uses Card ID: #" .. RobberyTimers[i]
        else
            CardIds = "Time Slot " .. i .. " uses Card ID: #" .. RobberyTimers[i]
        end
    end
    TriggerEvent("phone:addnotification", "EMAIL ", "The bank time slots are set to these hours, 8-10, 10-12, 12-14, 14-16, 16-18. || " .. CardIds)
end)


function PassCard(cardType)
  local answer = false
    if RobberyTimers[1] ~= nil then
      local timeframe = 0
      local curhrs = GetClockHours()
      if curhrs >= 8 and curhrs < 10 then
        timeframe = 1
      end
      if curhrs >= 10 and curhrs < 12 then
        timeframe = 2
      end
      if curhrs >= 12 and curhrs < 14 then
        timeframe = 3
      end
      if curhrs >= 14 and curhrs < 16 then
        timeframe = 4
      end
      if curhrs >= 16 and curhrs < 18 then
        timeframe = 5
      end
      if cardType == "securityblack" then
        if RobberyTimers[timeframe] == 1 then
          print(RobberyTimers[timeframe])
          answer = true
        end
      end
      if cardType == "securityblue" then
        if RobberyTimers[timeframe] == 2 then
          print(RobberyTimers[timeframe])
          answer = true
        end
      end
      if cardType == "securitygold" then
        if RobberyTimers[timeframe] == 3 then
          print(RobberyTimers[timeframe])
          answer = true
        end
      end
      if cardType == "securitygreen" then
        if RobberyTimers[timeframe] == 4 then
          print(RobberyTimers[timeframe])
          answer = true
        end
      end
      if cardType == "securityred" then
        if RobberyTimers[timeframe] == 5 then
          print(RobberyTimers[timeframe])
          answer = true
        end
      end
    end
    TriggerServerEvent('fleeca:removeCard', cardType)
  return answer
end

--RegisterCommand('BankTimes', function(source,args,raw) 
--TriggerServerEvent('fleeca:decrypt')
--end)

function ffrp.SetJob(source,job)
  local self = ffrp
  local lastData = self.PlayerData
  if lastData.job.name == self.PoliceJobName then
    TriggerServerEvent('ffrp_fleeca:CopLeft')
  elseif lastData.job.name ~= self.PoliceJobName and job.name == self.PoliceJobName then
    TriggerServerEvent('ffrp_fleeca:CopEnter')
  end
  self.PlayerData = ESX.GetPlayerData()
end

RegisterNetEvent('tac:setJob')
AddEventHandler('tac:setJob', function(job) ffrp.SetJob(source,job); end)

RegisterNetEvent('ffrp_fleeca:SyncDoor')
AddEventHandler('ffrp_fleeca:SyncDoor', function(location) ffrp:SyncDoor(location); end)

RegisterNetEvent('ffrp_fleeca:SyncBankData')
AddEventHandler('ffrp_fleeca:SyncBankData', function(data) ffrp.UsedActions = data; end)

RegisterNetEvent('ffrp_fleeca:SyncCops')
AddEventHandler('ffrp_fleeca:SyncCops', function(count) ffrp.PoliceOnline = count; end)

RegisterNetEvent('MF_LockPicking:MinigameComplete')
AddEventHandler('MF_LockPicking:MinigameComplete', function(result) ffrp:LockpickComplete(result); end)

Citizen.CreateThread(function(...) ffrp:Awake(...); end)