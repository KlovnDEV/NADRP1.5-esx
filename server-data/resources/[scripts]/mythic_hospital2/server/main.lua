local beds = {
    { x = -252.359, y = 6323.174, z = 33.342, h = 315.862, taken = false, model = 2117668672 },
    { x = -255.823, y = 6315.555, z = 33.355, h = 135.707, taken = false, model = 2117668672 },
    { x = -254.33, y = 6313.817, z = 33.342, h = 135.707, taken = false, model = 2117668672 },
    { x = -252.66, y = 6311.948, z = 33.342, h = 135.707, taken = false, model = 2117668672 },
    {x = -250.727, y = 6310.692, z = 33.342, h = 135.707, taken = false, model = 2117668672 },
    { x = -245.334, y = 6316.428, z = 33.342, h = 134.135, taken = false, model = 2117668672 },
    { x = -247.162, y = 6317.642, z = 33.342, h = 134.135,  taken = false, model = 2117668672 },
   
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

RegisterServerEvent('mythic_hospital2:server:RequestBed')
AddEventHandler('mythic_hospital2:server:RequestBed', function()
    for k, v in pairs(beds) do
        if not v.taken then
            v.taken = true
            bedsTaken[source] = k
            TriggerClientEvent('mythic_hospital2:client:SendToBed', source, k, v)
            return
        end
    end

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'No Beds Available' })
end)

RegisterServerEvent('mythic_hospital2:server:RPRequestBed')
AddEventHandler('mythic_hospital2:server:RPRequestBed', function(plyCoords)
    local foundbed = false
    for k, v in pairs(beds) do
        local distance = #(vector3(v.x, v.y, v.z) - plyCoords)
        if distance < 3.0 then
            if not v.taken then
                v.taken = true
                foundbed = true
                TriggerClientEvent('mythic_hospital2:client:RPSendToBed', source, k, v)
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

RegisterServerEvent('mythic_hospital2:server:EnteredBed')
AddEventHandler('mythic_hospital2:server:EnteredBed', function()
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
    TriggerClientEvent('mythic_hospital2:client:FinishServices', src)
end)

RegisterServerEvent('mythic_hospital2:server:LeaveBed')
AddEventHandler('mythic_hospital2:server:LeaveBed', function(id)
    beds[id].taken = false
end)
