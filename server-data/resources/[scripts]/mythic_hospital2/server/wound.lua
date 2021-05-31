local playerInjury = {}

function GetCharsInjuries(source)
    return playerInjury[source]
end

RegisterServerEvent('mythic_hospital2:server:SyncInjuries')
AddEventHandler('mythic_hospital2:server:SyncInjuries', function(data)
    playerInjury[source] = data
end)