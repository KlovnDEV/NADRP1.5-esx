local timerStarted = false
local timer = ((60 * 1000) * 45)

RegisterServerEvent('nadrp-paletorob:updateStates')
AddEventHandler('nadrp-paletorob:updateStates', function(type,id,state)
    if not timerStarted then 
        StartResetTimer()
    end
    TriggerClientEvent('nadrp-paletorob:updateStates', -1, type, id, state)
end)

function StartResetTimer()
    timerStarted = true
    Citizen.SetTimeout(timer, function()
        timerStarted = false
        TriggerClientEvent('nadrp-paletorob:resetBank', -1)
    end)
end