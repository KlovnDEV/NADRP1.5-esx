local timerStarted = false
local timer = ((60 * 1000) * 45)

RegisterServerEvent('ffrp-paletorob:updateStates')
AddEventHandler('ffrp-paletorob:updateStates', function(type,id,state)
    if not timerStarted then 
        StartResetTimer()
    end
    TriggerClientEvent('ffrp-paletorob:updateStates', -1, type, id, state)
end)

function StartResetTimer()
    timerStarted = true
    Citizen.SetTimeout(timer, function()
        timerStarted = false
        TriggerClientEvent('ffrp-paletorob:resetBank', -1)
    end)
end