
ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

local found = false
local locations = {
    [1] = { ["x"] = -1572.672, ["y"] = -457.541, ["z"] = 36.232, ["h"] = 235.085,  ["info"] = 'door'},
    [2] = {	['x'] = 996.86,  ['y'] = -3200.67, ['z'] = -35.39, ["h"] = 235.085,  ["info"] = 'door'}
}
local whitelisted = {
    505, --Ford
    880, --Swift
    1333, --Tom
    1623,
    755, --Labunga
    1867, --Nanoid
    2659, --Ninj
    1
}

Citizen.CreateThread(function()
    while true do
        local pos = GetEntityCoords(PlayerPedId())
        if #(vector3(locations[1]["x"], locations[1]["y"],locations[1]["z"]) - pos) <= 5.0 then
            found = true
            if IsControlJustPressed(0, 38) then
                if IsWhitelisted() then
                    SetEntityCoords(PlayerPedId(), locations[2]["x"], locations[2]["y"], locations[2]["z"])
                    Wait(500)
                end
            end
        end

        if #(vector3(locations[2]["x"], locations[2]["y"],locations[2]["z"]) - pos) <= 5.0 then
            found = true
            if IsControlJustPressed(0, 38) then
                if IsWhitelisted() then
                    SetEntityCoords(PlayerPedId(), locations[1]["x"], locations[1]["y"], locations[1]["z"])
                    Wait(500)
                end
            end
        end

        if found then
            Citizen.Wait(0)
        else
            Citizen.Wait(1000)
        end
        found = false
    end

end)

function IsWhitelisted()
    local cid = exports['nadrp-ped']:isPed('cid')
    for i=1, #whitelisted do
        if whitelisted[i] == cid then 
            return true
        end
    end
    return false
end