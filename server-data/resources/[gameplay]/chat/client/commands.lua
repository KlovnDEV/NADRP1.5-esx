-- StarBlazt Chat

ESX = nil

displayTime = 60 * 5

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30000)
		PlayerData = ESX.GetPlayerData()
	end
end)

RegisterCommand('callmechanic', function()
    local pData = ESX.GetPlayerData()
    if pData.job.name == 'police' or  pData.job.name == 'ambulance'  then
        TriggerEvent('civilian:alertPolice', 100.0, 'mechanic', 0,0,0)
        exports['mythic_notify']:DoLongHudText('inform', 'Mechanics have been notified!')
    else
        exports['mythic_notify']:DoHudText('error', 'Only for the use of emergency services!')
    end
end)

RegisterCommand('911', function(source, args, rawCommand)
    local source = GetPlayerServerId(PlayerId())
    local name = GetPlayerName(PlayerId())
    local ped = GetPlayerPed(PlayerId())
    local x, y, z = table.unpack(GetEntityCoords(ped, true))
    local caller = GetPlayerServerId(PlayerId())
    local msg = rawCommand:sub(4)
    TriggerServerEvent('chat:server:911source', source, caller, msg)
    TriggerServerEvent('911', source, caller, msg, x, y, z)
    TriggerEvent('phone:call1', source)
end, false)

RegisterCommand('311', function(source, args, rawCommand)
    local source = GetPlayerServerId(PlayerId())
    local name = GetPlayerName(PlayerId())
    local caller = GetPlayerServerId(PlayerId())
    local msg = rawCommand:sub(4)
    TriggerServerEvent(('chat:server:311source'), source, caller, msg)
    TriggerServerEvent('311', source, caller, msg)
    TriggerEvent('phone:call1', source)
end, false)

RegisterNetEvent('chat:EmergencySend911r')
AddEventHandler('chat:EmergencySend911r', function(fal, caller, msg)
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message emergency">911r {0} ({1}): {2} </div>',
        args = {caller, fal, msg}
        });
    end
end)

RegisterNetEvent('chat:EmergencySend311r')
AddEventHandler('chat:EmergencySend311r', function(fal, caller, msg)
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message nonemergency">311r {0} ({1}): {2} </div>',
        args = {caller, fal, msg}
        });
    end
end)

RegisterNetEvent('chat:EmergencySend911')
AddEventHandler('chat:EmergencySend911', function(fal, caller, msg, x, y, z)
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message emergency">911 {0} ({1}): {2} </div>',
        args = {caller, fal, msg}
        });
        TriggerEvent('911:setBlip', x, y, z)
    end
end)

RegisterNetEvent('chat:EmergencySend311')
AddEventHandler('chat:EmergencySend311', function(fal, caller, msg)
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message nonemergency">311 {0} ({1}): {2} </div>',
        args = {caller, fal, msg}
        });
    end
end)

RegisterNetEvent('chat:EmergencySendmecr')
AddEventHandler('chat:EmergencySendmecr', function(fal, caller, msg)
    if PlayerData.job.name == 'mechanic' then
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message nonemergency">Mechanic Reply: {0} ({1}): {2} </div>',
        args = {caller, fal, msg}
        });
    end
end)
RegisterNetEvent('chat:EmergencySendMechanic')
AddEventHandler('chat:EmergencySendMechanic', function(fal, caller, msg, x, y, z)
    if PlayerData.job.name == 'mechanic' then
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message nonemergency">Mechanic Call {0} ({1}): {2} </div>',
        args = {caller, fal, msg}
        });
        TriggerEvent('mec:setBlip', x, y, z)
    end
end)

RegisterCommand('911r', function(target, args, rawCommand)
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
        local source = GetPlayerServerId(PlayerId())
        local target = tonumber(args[1])
        local msg = rawCommand:sub(8)
        TriggerServerEvent(('chat:server:911r'), target, source, msg)
        TriggerServerEvent('911r', target, source, msg)
    end
end, false)

RegisterCommand('311r', function(target, args, rawCommand)
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then 
        local source = GetPlayerServerId(PlayerId())
        local target = tonumber(args[1])
        local msg = rawCommand:sub(8)
        TriggerServerEvent(('chat:server:311r'), target, source, msg)
        TriggerServerEvent('311r', target, source, msg)
    end
end, false)

RegisterCommand('callmechanic', function(source, args, rawCommand)
    local pData = ESX.GetPlayerData()
	if pData.job.name == 'police' or pData.job.name == 'ambulance' then
        TriggerEvent("civilian:alertPolice",8.0,"mechanic",0)
    else
        exports['mythic_notify']:DoHudText('error', 'Only emergency services can use this, do /mec (message)!')
    end
end, false)

RegisterCommand('mec', function(source, args, rawCommand)
    local source = GetPlayerServerId(PlayerId())
    local name = GetPlayerName(PlayerId())
    local ped = GetPlayerPed(PlayerId())
    local x, y, z = table.unpack(GetEntityCoords(ped, true))
    local caller = GetPlayerServerId(PlayerId())
    local msg = rawCommand:sub(4)
    TriggerServerEvent('chat:server:mecsource', source, caller, msg)
    TriggerServerEvent('mechanic', source, caller, msg, x, y, z)
    TriggerEvent('phone:call1', source)
end, false)

RegisterCommand('mecr', function(target, args, rawCommand)
    if PlayerData.job.name == 'mechanic'  then
        local source = GetPlayerServerId(PlayerId())
        local target = tonumber(args[1])
        local msg = rawCommand:sub(8)
        TriggerServerEvent(('chat:server:mecr'), target, source, msg)
        TriggerServerEvent('mecr', target, source, msg)
    end
end, false)

RegisterNetEvent('chat:AttemptChat')
AddEventHandler('chat:AttemptChat', function(msg, name)
    local onCooldown = false
    local pCooldown = exports['nadrp-admin']:GetCooldown()

    if pCooldown > 0 then
		onCooldown = true
	end
	if not onCooldown then
        TriggerServerEvent('chat:ooc', msg, name)
	else
		local msg = "[ADMIN]: You are currently on ooc cooldown for: "..pCooldown.." second(s)"
		TriggerEvent('chat:addMessage', {
			template = '<div class="chat-message server"><b> {0} </b></div>',
			args = {msg}
		})
	end
end)


blips = {}
RegisterNetEvent('911:setBlip')
AddEventHandler('911:setBlip', function(x, y, z)
    blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip, 459)
    SetBlipScale(blip, 2.0)
    SetBlipColour(blip, 39)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('911 Call')
    EndTextCommandSetBlipName(blip)
    table.insert(blips, blip)
    Wait(displayTime * 1000)
    for i, blip in pairs(blips) do
        RemoveBlip(blip)
    end
end)

RegisterNetEvent('mec:setBlip')
AddEventHandler('mec:setBlip', function(x, y, z)
    blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip, 459)
    SetBlipScale(blip, 2.0)
    SetBlipColour(blip, 1)
    local caller = GetPlayerServerId(PlayerId())
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Mechanic Call")
    EndTextCommandSetBlipName(blip)
    table.insert(blips, blip)
    Wait(displayTime * 1000)
    for i, blip in pairs(blips) do
        RemoveBlip(blip)
    end
end)

--[[RegisterNetEvent('311:setBlip')
AddEventHandler('311:setBlip', function(x, y, z)
    blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip, 459)
    SetBlipScale(blip, 2.0)
    SetBlipColour(blip, 39)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('911 Call')
    EndTextCommandSetBlipName(blip)
    table.insert(blips, blip)
    Wait(displayTime * 1000)
    for i, blip in pairs(blips) do
        RemoveBlip(blip)
    end
end)]]

RegisterNetEvent('phone:call1')
AddEventHandler('phone:call1', function()
	if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
		while not HasAnimDictLoaded('cellphone@') do
			RequestAnimDict('cellphone@')
			Citizen.Wait(10)
		end
		ClearPedTasksImmediately(GetPlayerPed(-1))
		TaskPlayAnim(GetPlayerPed(-1), 'cellphone@', 'cellphone_call_listen_base', 8.0, 1.0, 3000, 49, 1.0, 0, 0, 0)
	end
end)