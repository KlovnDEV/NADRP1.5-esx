RegisterNetEvent('rcore_gangs:notifyIncreasedLoyalty')
AddEventHandler('rcore_gangs:notifyIncreasedLoyalty', function(zoneName)
    PlaySound(-1, 'PICK_UP', 'HUD_FRONTEND_DEFAULT_SOUNDSET')

    ShowAdvancedNotification(_U('label_territory'), Config.GangZones[zoneName]['label'], 'loyalty_increased', 'CHAR_DEFAULT', 8)
end)

RegisterNetEvent('rcore_gangs:notifyDecreasedLoyalty')
AddEventHandler('rcore_gangs:notifyDecreasedLoyalty', function(zoneName, reason)
    PlaySound(-1, 'Enemy_Deliver', 'HUD_FRONTEND_MP_COLLECTABLE_SOUNDS')

    ShowAdvancedNotification(_U('label_territory'), Config.GangZones[zoneName]['label'], ('loyalty_decreased_%s'):format(string.lower(reason)), 'CHAR_DEFAULT', 8)
end)

RegisterNetEvent('rcore_gangs:notifyRivalryAttacking')
AddEventHandler('rcore_gangs:notifyRivalryAttacking', function(zoneName)
    ShowAdvancedNotification(_U('label_territory'), Config.GangZones[zoneName]['label'], _U('rivalry_started_attack'), 'CHAR_DEFAULT', 8)
end)

RegisterNetEvent('rcore_gangs:notifyRivalryDefending')
AddEventHandler('rcore_gangs:notifyRivalryDefending', function(zoneName)
    ShowAdvancedNotification(_U('label_territory'), Config.GangZones[zoneName]['label'], _U('rivalry_started_defend'), 'CHAR_DEFAULT', 8)
end)

CreateThread(function()
    local locale = Locales[Config.Language] or Locales['EN']

    for entry, text in pairs(locale) do
        if string.find(text, 'loyalty_') then
            AddTextEntry(entry, text)
        end
    end
end)