ESX = nil
TriggerEvent("tac:getSharedObject",function(obj) ESX = obj end)

RegisterNUICallback("dataPost", function(data, cb)
    SetNuiFocus(false)
    TriggerEvent(data.event, data.args)
    cb('ok')
end)

RegisterNUICallback("cancel", function(data, cb)
    SetNuiFocus(false)
    cb('ok')
end)

RegisterNetEvent('shrp-ui:sendMenu')
AddEventHandler('shrp-ui:sendMenu', function(data)
    if not data then return end
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "OPEN_MENU",
        data = data
    })
end)

--// MINI GAME //--
local game_state = nil
RegisterNetEvent('shrp-ui:StartMiniGame')
AddEventHandler('shrp-ui:StartMiniGame', function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "startMinigame",
    })
end)

function StartMiniGame(cb)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "startMinigame",
    })
    while game_state == nil do 
        Citizen.Wait(500)
    end
    return cb(game_state)
end
exports('StartMiniGame',StartMiniGame)

RegisterNUICallback('completeMinigame', function(data, cb)
    SetNuiFocus(false, false)
    if data.state == "won" then 
        game_state = true
    elseif data.state == "lost" then 
        game_state = false
    end
    Wait(500)
    game_state = nil
    cb('ok')
end)

RegisterCommand('StartMiniGame', function(...)
    local minigame = StartMiniGame()
    print(minigame)
end)