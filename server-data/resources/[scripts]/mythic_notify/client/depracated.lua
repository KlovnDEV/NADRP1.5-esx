RegisterNetEvent('mythic_notify:client:PersistentHudText')
AddEventHandler('mythic_notify:client:PersistentHudText', function(data)
    PersistentAlert(data.action, data.id, data.type, data.text, data.style)
end)

function DoShortHudText(type, text, style)
    DoLongHudText(type, text, 1000, style)
end

function DoHudText(type, text, style)
    DoLongHudText(type, text, 2500, style)
end

function DoLongHudText(type, text, style)
    DoLongHudText(type, text, 5000, style)
end

function DoCustomHudText(type, text, length, style)
    DoLongHudText(type, text, length, style)
end

function PersistentHudText(action, id, type, text, style)
    PersistentAlert(action, id, type, text, style)
end