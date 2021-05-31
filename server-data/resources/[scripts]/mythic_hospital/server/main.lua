local beds = {
    { x = 324.224, y = -582.74, z = 44.204, h = 340.63, taken = false, model = 1631638868 },
    { x = 319.187, y = -580.799, z = 44.204, h = 335.18, taken = false, model = -1091386327 },
    { x = 313.944, y = -578.876, z = 44.204, h = 339.47, taken = false, model = 1631638868 },
    { x = 309.348, y = -577.33, z = 44.204, h = 338.82, taken = false, model = -1091386327 },
    {x = 307.704, y = -581.832, z = 44.204, h = 159.5, taken = false, model = -1091386327 },
    { x = 310.943, y = -583.075, z = 44.204, h = 160.18, taken = false, model = -1091386327 },
    { x = 314.676, y = -584.43, z = 44.204, h = 159.23,  taken = false, model = -1091386327 },
    { x = 317.684, y = -585.604, z = 44.204, h = 158.61, taken = false, model = -1091386327 },
    { x = 322.832, y = -587.276, z = 44.204, h = 157.53, taken = false, model = 2117668672 },
    --{ x = 357.34, y = -594.45, z = 43.11, h = 160.0, taken = false, model = 2117668672 },
   -- { x = 350.80, y = -591.72, z = 43.11, h = 160.0, taken = false, model = 2117668672 },
    --{ x = 346.89, y = -591.01, z = 42.58, h = 160.0, taken = false, model = 2117668672 },
}

local bedsTaken = {}
local injuryBasePrice = 100
ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('playerDropped', function()
    if bedsTaken[source] ~= nil then
        beds[bedsTaken[source]].taken = false
    end
end)

AddEventHandler('playerDropped', function()
    if bedsTaken[source] ~= nil then
        beds[bedsTaken[source]].taken = false
    end
end)

RegisterServerEvent('mythic_hospital:server:RequestBed')
AddEventHandler('mythic_hospital:server:RequestBed', function()
    for k, v in pairs(beds) do
        if not v.taken then
            v.taken = true
            bedsTaken[source] = k
            TriggerClientEvent('mythic_hospital:client:SendToBed', source, k, v)
            return
        end
    end

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'No Beds Available' })
end)

RegisterServerEvent('mythic_hospital:server:RPRequestBed')
AddEventHandler('mythic_hospital:server:RPRequestBed', function(plyCoords)
    local foundbed = false
    for k, v in pairs(beds) do
        local distance = #(vector3(v.x, v.y, v.z) - plyCoords)
        if distance < 3.0 then
            if not v.taken then
                v.taken = true
                foundbed = true
                TriggerClientEvent('mythic_hospital:client:RPSendToBed', source, k, v)
                return
            else
                TriggerClientEvent('tac:showNotification', source, '~r~That Bed Is Taken')
            end
        end
    end

    if not foundbed then
        TriggerClientEvent('tac:showNotification', source, '~r~Not Near A Hospital Bed')
    end
end)

RegisterServerEvent('mythic_hospital:server:EnteredBed')
AddEventHandler('mythic_hospital:server:EnteredBed', function()
    local src = source
    local injuries = GetCharsInjuries(src)

    local totalBill = injuryBasePrice

    if injuries ~= nil then
        for k, v in pairs(injuries.limbs) do
            if v.isDamaged then
                totalBill = totalBill + (injuryBasePrice * v.severity)
            end
        end

        if injuries.isBleeding > 0 then
            totalBill = totalBill + (injuryBasePrice * injuries.isBleeding)
        end
    end

    -- YOU NEED TO IMPLEMENT YOUR FRAMEWORKS BILLING HERE
	local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.removeBank(totalBill)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You were billed for $' .. totalBill ..'.' })
    TriggerClientEvent('mythic_hospital:client:FinishServices', src)
end)

RegisterServerEvent('mythic_hospital:server:LeaveBed')
AddEventHandler('mythic_hospital:server:LeaveBed', function(id)
    beds[id].taken = false
end)
