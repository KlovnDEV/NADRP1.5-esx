--[[
    Notes {
        Fix: Door Heading -- Done
        Add: Restart timer -- Done
        Add: Police Check -- Done
        Add: Loot Items ? Dirty Notes / Cards -- Done
        > Bug test -- Done
    } 
]]

ESX = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

local powerHit = false
local headingSet = true
local firstGate = 0
local CopsNeeded = 5

local doorCoords = {
    [1] = {["x"] = -104.8828, ["y"] = 6472.442, ["z"] = 30.727, ["doorNum"] = 145, ["disabled"] = false}, -- firstGate
    [2] = {["x"] = -106.424, ["y"] = 6475.046, ["z"] = 30.727, ["doorNum"] = 146, ["disabled"] = false}, -- secondGate
}
local powerStations = {
    [1] = {["x"] = 1351.957, ["y"] = 6381.956, ["z"] = 33.209, ["disabled"] = false},
    [2] = {["x"] = 2585.862, ["y"] = 5065.903, ["z"] = 44.919, ["disabled"] = false},
    [3] = {["x"] = -288.504, ["y"] = 6027.606, ["z"] = 31.491, ["disabled"] = false},
}
local lootSpots = {
    [1] = {["x"] = -103.054, ["y"] = 6475.795, ["z"] = 30.727, ["disabled"] = false},
    [2] = {["x"] = -103.635, ["y"] = 6477.81, ["z"] = 30.727, ["disabled"] = false},
    [3] = {["x"] = -105.525, ["y"] = 6478.377, ["z"] = 30.727, ["disabled"] = false},
}

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        for i=1, #doorCoords do
            local dist = #(vector3(doorCoords[i].x, doorCoords[i].y,doorCoords[i].z) - GetEntityCoords(ped))
            if dist < 10.0 then
                if dist < 3.5 then
                    found = true
                    if not doorCoords[i].disabled then
                        DrawMarker(27, doorCoords[i].x, doorCoords[i].y,doorCoords[i].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 50, 50, 255, false, false, 0, 0)
                    else
                        DrawMarker(27, doorCoords[i].x, doorCoords[i].y,doorCoords[i].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 50, 255, 50, 255, false, false, 0, 0)
                    end
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

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        for i=1, #powerStations do
            if #(vector3(powerStations[i].x, powerStations[i].y,powerStations[i].z) - GetEntityCoords(ped)) < 5.0 then
                found = true
                if not powerStations[i].disabled then
                    DrawMarker(27, powerStations[i].x, powerStations[i].y,powerStations[i].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 50, 50, 255, false, false, 0, 0)
                else
                    DrawMarker(27, powerStations[i].x, powerStations[i].y,powerStations[i].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 50, 255, 50, 255, false, false, 0, 0)
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

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        for i=1, #lootSpots do
            local dist = #(vector3(lootSpots[i].x, lootSpots[i].y,lootSpots[i].z) - GetEntityCoords(ped))
            if dist < 1.5 then
                found = true
                if not lootSpots[i].disabled then
                    DrawMarker(27, lootSpots[i].x, lootSpots[i].y,lootSpots[i].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 255, 50, 50, 255, false, false, 0, 0)
                else
                    DrawMarker(27, lootSpots[i].x, lootSpots[i].y,lootSpots[i].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.6, 50, 255, 50, 255, false, false, 0, 0)
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

RegisterNetEvent('nadrp-paletorob:useEleckit')
AddEventHandler('nadrp-paletorob:useEleckit', function()
    local ped = PlayerPedId()
    local IsNearStation = IsNearStation()
    local IsNearLoot = IsNearLoot()
    ESX.TriggerServerCallback('GetPoliceOnline', function(CopsConnected)
        if CopsConnected >= CopsNeeded then
            if IsNearStation then
                for i=1, #powerStations do
                    if #(vector3(powerStations[i].x, powerStations[i].y,powerStations[i].z) - GetEntityCoords(ped)) < 1.5 then
                        if not powerStations[i].disabled then
                            if exports["nadrp-inventory"]:hasEnoughOfItem("electronickit",1,false) then
                                TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_STAND_MOBILE', 0, true)
                                TriggerEvent("mhacking:show")
                                TriggerEvent("mhacking:start",5,15,PowerGridCallback)
                            end
                        else
                            exports["mythic_notify"]:DoLongHudText('error', 'This grid is already disabled!')
                        end
                    end
                end
            elseif IsNearLoot then
                local IsPowerDisabled = IsPowerDisabled()
                for i=1, #lootSpots do
                    if #(vector3(lootSpots[i].x, lootSpots[i].y,lootSpots[i].z) - GetEntityCoords(ped)) < 1.5 then
                        if not lootSpots[i].disabled then
                            if IsPowerDisabled then
                                if exports["nadrp-inventory"]:hasEnoughOfItem("electronickit",1,false) then
                                    if not cooldown then
                                        TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_STAND_MOBILE', 0, true)
                                        TriggerEvent("mhacking:show")
                                        TriggerEvent("mhacking:start",6,15,LootSpotCallback)
                                    else
                                        exports["mythic_notify"]:DoLongHudText('inform', 'System Rebooting, Please Wait!')
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            exports["mythic_notify"]:DoLongHudText('error', 'Not Enough Cops.')
        end
    end)
end)

RegisterNetEvent('nadrp-paletorob:useAdvlockpick')
AddEventHandler('nadrp-paletorob:useAdvlockpick', function()
    local ped = PlayerPedId()
    local IsPowerDisabled = IsPowerDisabled()
    ESX.TriggerServerCallback('GetPoliceOnline', function(CopsConnected)
        if CopsConnected >= CopsNeeded then
            for i=1, #doorCoords do
                if #(vector3(doorCoords[i].x, doorCoords[i].y,doorCoords[i].z) - GetEntityCoords(ped)) < 1.5 then
                    if not doorCoords[i].disabled then
                        if IsPowerDisabled then
                            if exports["nadrp-inventory"]:hasEnoughOfItem("advlockpick",1,false) and exports["nadrp-inventory"]:hasEnoughOfItem("heavycutters",1,false) then
                                TriggerEvent('tac-dispatch:PaletoBank')
                                local finished = exports['nadrp-skillbar']:taskBar(3000, math.random(5,15))
                                if finished ~= 100 then
                                    exports['mythic_notify']:DoLongHudText('error', 'failed')
                                else
                                    local finished2 = exports['nadrp-skillbar']:taskBar(2000, math.random(5,15))
                                    if finished2 ~= 100 then
                                        exports['mythic_notify']:DoLongHudText('error', 'failed')
                                    else
                                        local finished3 = exports['nadrp-skillbar']:taskBar(1000, math.random(5,15))
                                        if finished3 ~= 100 then
                                            exports['mythic_notify']:DoLongHudText('error', 'failed')
                                        else
                                            local finished = exports["nadrp-taskbar"]:taskBar(300000, "Unlocking door please wait 🔓")
                                            TriggerEvent('tac-dispatch:PaletoBank')
	                                        if finished == 100 then
                                            exports['mythic_notify']:DoLongHudText('success', 'Door Unlocked!')
                                            TriggerServerEvent('nadrp-paletorob:updateStates', "doors", i, true)
                                            TriggerServerEvent('nadrp-doors:alterlockstate', doorCoords[i].doorNum, 0)
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            exports["mythic_notify"]:DoLongHudText('error', 'Seems to risky, Try find a way to turn the power off.')
                        end
                    end
                end
            end
        else
            exports["mythic_notify"]:DoLongHudText('error', 'Not Enough Cops.')
        end
    end)
end)

RegisterNetEvent('nadrp-paletorob:updateStates')
AddEventHandler('nadrp-paletorob:updateStates', function(type,id,state)
    if type == "station" then
        powerStations[id].disabled = state
    elseif type == "doors" then 
        doorCoords[id].disabled = state
    elseif type == "loot" then 
        lootSpots[id].disabled = state
    end
end)

RegisterNetEvent('nadrp-paletorob:resetBank')
AddEventHandler('nadrp-paletorob:resetBank', function()
    for i=1, # powerStations do
        powerStations[i].disabled = false
    end
    for i=1, #doorCoords do
        doorCoords[i].disabled = false
    end
    for i=1, #lootSpots do
        lootSpots[i].disabled = false
    end
    GotSecCard = false
    GotShipCrate = false
end)

function StartHeadingCheck()
    Citizen.CreateThread(function()
        while true do
            if firstGate == 0 then
                firstGate = GetClosestObjectOfType(-105.674, 6472.675, 31.627, 3.0, `v_ilev_cbankvaulgate01`, 0, 0, 0)
            else
                SetEntityHeading(firstGate, 45.0)
                headingSet = true
                break
            end
            Citizen.Wait(3000)
        end
    end)
end

function PowerGridCallback(success)
	local ped = PlayerPedId()
    TriggerEvent('mhacking:hide')
	if success then
		local station = GetNearestStation()
        TriggerServerEvent("nadrp-paletorob:updateStates", "station", station, true)
	else
		TriggerEvent('tac-dispatch:powergrid')
	end
	ClearPedTasks(ped)
	ClearPedSecondaryTask(ped)
end

function LootSpotCallback(success)
	local ped = PlayerPedId()
    TriggerEvent('mhacking:hide')
	if success then
		local lootId = GetNearestLootSpot()
        TriggerServerEvent("nadrp-paletorob:updateStates", "loot", lootId, true)
        TriggerEvent('player:receiveItem', 'markedbills', math.random(15,25))
        GiveRareLoot()
    else
        cooldown = true
        exports["mythic_notify"]:DoLongHudText('inform', 'System Rebooting, Please Wait!')
        Citizen.SetTimeout(45000, function()
            cooldown = false
            exports["mythic_notify"]:DoLongHudText('inform', 'System has rebooted, Be careful next time', 5000)
        end)
    end
	ClearPedTasks(ped)
	ClearPedSecondaryTask(ped)
end

function GiveRareLoot()
    local chance = math.random(100)
    if chance < 35 and not GotShipCrate then
        GotShipCrate = true
        TriggerEvent('player:receiveItem','shipcrate', 1)
    end
    if chance > 95 and not GotSecCard then
        GotSecCard = true
        TriggerEvent('player:receiveItem', 'bluesec', 1)
    end
end

function IsPowerDisabled()
    local amount = 0
    for i=1, #powerStations do
        if powerStations[i].disabled then
            amount = amount + 1
        end
    end
    if amount == #powerStations then
        return true
    end
    return false
end

function IsNearStation()
    for i=1, #powerStations do
        if #(vector3(powerStations[i].x, powerStations[i].y,powerStations[i].z) - GetEntityCoords(PlayerPedId())) < 1.5 then
            return true
        end
    end
    return false
end

function IsNearLoot()
    for i=1, #lootSpots do
        if #(vector3(lootSpots[i].x, lootSpots[i].y,lootSpots[i].z) - GetEntityCoords(PlayerPedId())) < 1.5 then
            return true
        end
    end
    return false
end

function GetNearestStation()
    for i=1, #powerStations do
        if #(vector3(powerStations[i].x, powerStations[i].y,powerStations[i].z) - GetEntityCoords(PlayerPedId())) < 2.0 then
            return i
        end
    end
    return 0
end

function GetNearestLootSpot()
    for i=1, #lootSpots do
        if #(vector3(lootSpots[i].x, lootSpots[i].y,lootSpots[i].z) - GetEntityCoords(PlayerPedId())) < 2.0 then
            return i
        end
    end
    return 0
end