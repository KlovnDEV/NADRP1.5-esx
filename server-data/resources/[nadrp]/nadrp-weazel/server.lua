--[[RegisterCommand("cam", function(source, args, raw)
    local src = source
    TriggerClientEvent("Cam:ToggleCam", src)
end)

RegisterCommand("bmic", function(source, args, raw)
    local src = source
    TriggerClientEvent("Mic:ToggleBMic", src)
end)

RegisterCommand("mic", function(source, args, raw)
    local src = source
    TriggerClientEvent("Mic:ToggleMic", src)
end)]]

RegisterNetEvent('Toggle:cam')
AddEventHandler('Toggle:cam', function()
    local src = source
    TriggerClientEvent("Cam:ToggleCam", src)
end)

RegisterNetEvent('Toggle:bmic')
AddEventHandler('Toggle:bmic', function()
    local src = source
    TriggerClientEvent("Mic:ToggleBMic", src)
end)

RegisterNetEvent('Toggle:mic')
AddEventHandler('Toggle:mic', function()
    local src = source
    TriggerClientEvent("Mic:ToggleMic", src)
end)