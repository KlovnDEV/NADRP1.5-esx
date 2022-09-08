-- ESX

ESX                             = nil
local PlayerData                = {}
local radioVolume = 0.5
local radioMenu = false
Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
	end
end)

function enableRadio(enable)
  SetNuiFocus(true, true)
  radioMenu = enable
  TriggerEvent('attachItemRadio', 'radio01')
  if not HasAnimDictLoaded("cellphone@") then
    RequestAnimDict("cellphone@")
    while not HasAnimDictLoaded("cellphone@") do
      Citizen.Wait(0)
    end
  end
  TaskPlayAnim(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 2.0, 3.0, -1, 49, 0, 0, 0, 0)

  SendNUIMessage({
    type = "enableui",
    enable = enable
  })
  DisableControl()
end

RegisterNUICallback('joinRadio', function(data, cb)
  local _source = source
  local PlayerData = ESX.GetPlayerData(_source)
  local playerName = GetPlayerName(PlayerId())
  local getPlayerRadioChannel = exports['nadrp-voice']:GetRadioChannel()

  if tonumber(data.channel) ~= tonumber(getPlayerRadioChannel) then
      if tonumber(data.channel) <= Config.RestrictedChannels then
        if(PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'fire'  or PlayerData.job.name == 'mechanic') then
          exports['nadrp-voice']:removePlayerFromRadio()
          exports['nadrp-voice']:addPlayerToRadio(data.channel)
          exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. 'MHz </b>')
          TriggerEvent("InteractSound_CL:PlayOnOne","radioclick",0.6)
        elseif not (PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'fire'  or PlayerData.job.name == 'mechanic') then
          exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
        end
      end
      if tonumber(data.channel) > Config.RestrictedChannels then
        exports['nadrp-voice']:removePlayerFromRadio()
        exports['nadrp-voice']:addPlayerToRadio(data.channel)
        exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. 'MHz </b>')
        TriggerEvent("InteractSound_CL:PlayOnOne","radioclick",0.6)
      end
    else
      exports['mythic_notify']:DoHudText('error', Config.messages['you_on_radio'] .. data.channel .. 'MHz </b>')
    end
  cb('ok')
end)

RegisterNUICallback('leaveRadio', function(data, cb)
   local playerName = GetPlayerName(PlayerId())
   local getPlayerRadioChannel = exports['nadrp-voice']:GetRadioChannel()

    if getPlayerRadioChannel == 0 then
      exports['mythic_notify']:DoHudText('inform', Config.messages['not_on_radio'])
    else
      exports['nadrp-voice']:removePlayerFromRadio()
      TriggerEvent("InteractSound_CL:PlayOnOne","radioclick",0.6)
      exports['mythic_notify']:DoHudText('inform', Config.messages['you_leave'] .. getPlayerRadioChannel .. 'MHz </b>')
    end
  cb('ok')
end)

RegisterNUICallback('volumeup', function(data, cb)
  if radioVolume >= 1.0 then
    exports['mythic_notify']:DoLongHudText('error', "Radio can't go any louder")
    return
  end
  if (radioVolume + 0.1) >= 1.0 then
    radioVolume = 1.0 
    exports['mythic_notify']:DoLongHudText('inform', 'Radio set to '..radioVolume)
  else
    radioVolume = radioVolume + 0.1
    exports['mythic_notify']:DoLongHudText('inform', 'Radio set to '..radioVolume)
  end
  TriggerEvent('nadrp-voice:SetRadioVolume', radioVolume)
  cb('ok')
end)

RegisterNUICallback('volumedown', function(data, cb)
  if radioVolume <= 0.1 then
    exports['mythic_notify']:DoLongHudText('error', "Radio can't go any lower")
    return
  end
  if (radioVolume - 0.1) <= 0.1 then
    radioVolume = 0.1
    exports['mythic_notify']:DoLongHudText('inform', 'Radio set to '..radioVolume)
  else
    radioVolume = radioVolume - 0.1
    exports['mythic_notify']:DoLongHudText('inform', 'Radio set to '..radioVolume)
  end
  TriggerEvent('nadrp-voice:SetRadioVolume', radioVolume)
  cb('ok')
end)

RegisterNUICallback('escape', function(data, cb)
  enableRadio(false)
  SetNuiFocus(false, false)
  TriggerEvent('destroyPropRadio')
  ClearPedTasks(PlayerPedId())
  cb('ok')
end)

RegisterNetEvent('nadrp-radio:use')
AddEventHandler('nadrp-radio:use', function()
  enableRadio(true)
end)

RegisterNetEvent('nadrp-radio:onRadioDrop')
AddEventHandler('nadrp-radio:onRadioDrop', function(source)
  local playerName = GetPlayerName(PlayerId())
  local getPlayerRadioChannel = exports['nadrp-voice']:GetRadioChannel()
  local iDidItAllready = false

  if getPlayerRadioChannel == 0 then
    exports['mythic_notify']:DoHudText('inform', Config.messages['not_on_radio'])
  else
    exports['nadrp-voice']:removePlayerFromRadio()
    exports['mythic_notify']:DoHudText('inform', Config.messages['you_leave'] .. getPlayerRadioChannel .. '.00 MHz </b>')
  end
end)

function DisableControl()
  while radioMenu do
    Citizen.Wait(0)
    DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
    DisableControlAction(0, 2, guiEnabled) -- LookUpDown
    DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate
    DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride
  end
end

RegisterCommand('radio', function()
  if IsControlEnabled(0, 245) then
    local item = exports["nadrp-inventory"]:hasEnoughOfItem('radio', 1, false)
    local item2 = exports["nadrp-inventory"]:hasEnoughOfItem('radio2', 1, false)
    if item or item2 then
      hasItem = true
    else
      hasItem = false
    end
    if hasItem then
      if radioMenu then
        enableRadio(false)
      else
        enableRadio(true)
      end
    end
  end
end)

RegisterKeyMapping('radio', 'Toggle Radio', 'keyboard', 'K')

RegisterNetEvent('nadrp:playerBecameJob')
AddEventHandler('nadrp:playerBecameJob', function(jobPassed)
  job = jobPassed.name
end)