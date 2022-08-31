local pin = 0

function openGui()
    SetNuiFocus(true,true)
    SendNUIMessage({open = true})
end

function CloseGui()
    SetNuiFocus(false,false)
    SendNUIMessage({open = false})
end

RegisterNUICallback('close', function(data, cb)
    CloseGui()
    cb('ok')
end)

RegisterNUICallback('complete', function(data, cb)
    if tonumber(pin) == tonumber(data.pin) then
        TriggerServerEvent("nadrp-doors:alterlockstate",doorid)
        doorid = 0
        pin = 0
    end
    CloseGui()
    cb('ok')
end)

RegisterNetEvent('keypad:attempt')
AddEventHandler('keypad:attempt', function(pinSent, dooridSent)
    pin = pinSent
    doorid = dooridSent
    openGui()
end)