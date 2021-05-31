
ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

local found = false
local locations = {
    [1] = { ["x"] = 976.904, ["y"] = -103.915, ["z"] = 74.845, ["h"] = 216.988,  ["info"] = 'stash'},
}
local whitelisted = { 27, 1675, 2054, 1042, 2592 }

Citizen.CreateThread(function()
    while true do
        local pos = GetEntityCoords(PlayerPedId())
        if #(vector3(locations[1]["x"], locations[1]["y"],locations[1]["z"]) - pos) < 2.0 then
            found = true
            DrawText3D(locations[1]["x"], locations[1]["y"],locations[1]["z"], "~r~[E]~w~ - Stash")
            if IsControlJustPressed(1, 38) then
                if IsLmcWhitelisted() then
                    TriggerEvent("server-inventory-open", "1", "lmc-storage");
                    Wait(1000)
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

function IsLmcWhitelisted()
    local cid = exports['ffrp-ped']:isPed('cid')
    for i=1, #whitelisted do
        if whitelisted[i] == cid then
            return true
        end
    end
    return false
end