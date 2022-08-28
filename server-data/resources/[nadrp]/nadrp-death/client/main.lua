ESX = nil

RegisterNetEvent('nadrp-death:healTarget')
AddEventHandler('nadrp-death:healplayer', function(type)
    local health = GetEntityHealth(PlayerPedId())
    if type == 'small' then
        local rand = math.random(5,10)
        SetEntityHealth(PlayerPedId(), health + rand)
        TriggerEvent('mythic_hospital:client:FieldTreatBleed')
    elseif type == 'big' then
        local rand = math.random(10,20)
        SetEntityHealth(PlayerPedId(), health + rand)
        TriggerClientEvent('mythic_hospital:client:FieldTreatLimbs', source)
        TriggerEvent('mythic_hospital:client:FieldTreatBleed')
    end
end)