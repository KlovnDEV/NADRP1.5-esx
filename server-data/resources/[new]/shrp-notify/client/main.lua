
-- Different types: 
-- info,success,warning,error

--[[
    -- // TEMPLATE //--

    -- EVENTS
    TriggerEvent('nadrp-notify:ShowPersistAlert', {text = '', type = '', state = ''})
    TriggerEvent('nadrp-notify:ShowAlert', {text = '', type = '', duration = 3000})

    -- EXPORTS
    exports['nadrp-notify']:ShowAlert('text', 'type', 3000)
    exports['nadrp-notify']:ShowPersistAlert('text', 'type', 'state')
]]

function ShowAlert(text,type,duration)
    if duration == nil then duration = 3000 end
    if type == nil then type = 'info' end
    if text == nil then return end
    --print(text,type,duration)
    SendNUIMessage({
        event = "ShowAlert",
        text = text,
        duration = duration,
        type = type
    })
end

-- Used for calling on server side
RegisterNetEvent('nadrp-notify:ShowAlert')
AddEventHandler('nadrp-notify:ShowAlert', function(data)
    ShowAlert(data.text,data.type,data.duration)
end)
exports('ShowAlert', ShowAlert)


-- Persistant Alerts
local cachedAlert = {}
function ShowPersistAlert(text,type,state)
    if text == nil then return end
    if type == nil then type = 'info' end
    if state == nil then
        print('[nadrp-notify]: State not defined')
        return
    elseif state == "show" then
        cachedAlert = {
            text = text,
            type = type
        }
        SendNUIMessage({
            event = "persistAlert",
            text = text,
            type = type,
            show = state
        })
    elseif state == "hide" then
        SendNUIMessage({
            event = "persistAlert",
            text = cachedAlert.text,
            type = cachedAlert.type,
            show = "hide"
        })
    end
end

-- Used for calling on server side
RegisterNetEvent('nadrp-notify:ShowPersistAlert')
AddEventHandler('nadrp-notify:ShowPersistAlert', function(data)
    ShowPersistAlert(data.text,data.type,data.state)
end)

exports('ShowPersistAlert', ShowPersistAlert)