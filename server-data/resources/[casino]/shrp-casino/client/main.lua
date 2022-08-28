ESX = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

local showingUI = false
-- code

local mainDesk = BoxZone:Create(vector3(1115.85, 220.16, -49.44), 3, 2.0, {
    name="cashier",
    heading=358,
    --debugPoly=true
})

local NearDesk = false
mainDesk:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        NearDesk = true
        KeyPressThread()
        exports["shrp-notify"]:ShowPersistAlert('[E] - Buy/Sell Chips', 'info', 'show')
    else
        NearDesk = false
        exports["shrp-notify"]:ShowPersistAlert('[E] - Buy/Sell Chips', 'info', 'hide')
    end
end)

function KeyPressThread()
    Citizen.CreateThread(function()
        while NearDesk do
            Citizen.Wait(1)
            if IsControlJustPressed(0, 38) then
                openUI()
            end
        end
    end)
end

function openUI()
    if not showingUI then
        showingUI = true
        SendNUIMessage({
            event = 'open-ui',
        })
        SetNuiFocus(true, true)
    else
        showingUI = false
        SendNUIMessage({
            event = 'close-ui',
        })
        SetNuiFocus(false, false)
    end
end

-- Create Ped

local peds = {
    [1] = {["x"] = 1087.221,["y"] = 221.2297,["z"] = -50.20046, ["h"] = 180.297, ["outfit"] = 1, ["model"] = `s_f_y_casino_01`},
    [2] = {["x"] = 1117.841, ["y"] = 220.0, ["z"] = -49.435, ["h"] = 87.231, ["outfit"] = 2, ["model"] = `s_m_y_casino_01`},
    [3] = {["x"] = 1100.871, ["y"] = 195.396, ["z"] = -50.44, ["h"] = 313.31, ["outfit"] = 3, ["model"] = `s_f_y_casino_01`},
    --[1] = {["x"] = 0.0,["y"] = 0.0,["z"] = 0.0, ["h"] = 0.0, ["outfit"] = 1, ["model"] = `s_f_y_casino_01`}
    --[1] = {["x"] = 0.0,["y"] = 0.0,["z"] = 0.0, ["h"] = 0.0, ["outfit"] = 1, ["model"] = `s_f_y_casino_01`}
    --[1] = {["x"] = 0.0,["y"] = 0.0,["z"] = 0.0, ["h"] = 0.0, ["outfit"] = 1, ["model"] = `s_f_y_casino_01`}
}

local spawnedPeds = {}
Citizen.CreateThread(function()
    SpawnPed()
end)

function SpawnPed()
    for i=1, #peds do
        local hash = peds[i].model
        if not HasModelLoaded(hash) then
            RequestModel(hash)
            while not HasModelLoaded(hash) do
                Citizen.Wait(0)
            end
        end
        ped = CreatePed(4, hash, peds[i].x, peds[i].y, peds[i].z, peds[i].h, 0, 0)
        SetModelAsNoLongerNeeded(hash)
        SetPedOutfit(ped, peds[i].outfit)
        table.insert(spawnedPeds, ped)
    end
end

function DeletePeds()
    if #spawnedPeds > 0 then
        for i=1, #spawnedPeds do
            DeleteEntity(spawnedPeds[i])
        end
        spawnedPeds = {}
    end
end

function SetPedOutfit(ped, outfit)
    local dealerPed = ped
    SetPedDefaultComponentVariation(ped)
    if outfit == 1 then
        SetPedComponentVariation(ped, 0, 4, 0, 0)
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        SetPedComponentVariation(ped, 2, 4, 0, 0)
        SetPedComponentVariation(ped, 3, 2, 1, 0)
        SetPedComponentVariation(ped, 4, 1, 0, 0)
        SetPedComponentVariation(ped, 6, 1, 0, 0)
        SetPedComponentVariation(ped, 7, 1, 0, 0)
        SetPedComponentVariation(ped, 8, 2, 0, 0)
        SetPedComponentVariation(ped, 10, 0, 0, 0)
        SetPedComponentVariation(ped, 11, 0, 0, 0)
        SetPedPropIndex(ped, 1, 0, 0, false)
        FreezeEntityPosition(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetEntityInvincible(ped, true)
    elseif outfit == 2 then
        local pos = peds[outfit]
        SetPedComponentVariation(ped, 0, 3, 0, 0)
        SetPedComponentVariation(ped, 1, 1, 0, 0)
        SetPedComponentVariation(ped, 2, 3, 0, 0)
        SetPedComponentVariation(ped, 3, 1, 0, 0)
        SetPedComponentVariation(ped, 4, 0, 0, 0)
        SetPedComponentVariation(ped, 6, 1, 0, 0)
        SetPedComponentVariation(ped, 7, 2, 0, 0)
        SetPedComponentVariation(ped, 8, 3, 0, 0)
        SetPedComponentVariation(ped, 10, 1, 0, 0)
        SetPedComponentVariation(ped, 11, 1, 0, 0)
        TaskStartScenarioAtPosition(ped, 'PROP_HUMAN_SEAT_BENCH', pos.x - 0.3, pos.y, pos.z-0.3, GetEntityHeading(ped), 0, true, true)
        FreezeEntityPosition(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetEntityInvincible(ped, true)
    elseif outfit == 3 then
        SetPedComponentVariation(ped, 0, 4, 0, 0)
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        SetPedComponentVariation(ped, 2, 4, 0, 0)
        SetPedComponentVariation(ped, 3, 2, 1, 0)
        SetPedComponentVariation(ped, 4, 1, 0, 0)
        SetPedComponentVariation(ped, 6, 1, 0, 0)
        SetPedComponentVariation(ped, 7, 1, 0, 0)
        SetPedComponentVariation(ped, 8, 2, 0, 0)
        SetPedComponentVariation(ped, 10, 0, 0, 0)
        SetPedComponentVariation(ped, 11, 0, 0, 0)
        SetPedPropIndex(ped, 1, 0, 0, false)
        FreezeEntityPosition(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetEntityInvincible(ped, true)
    end
end

RegisterCommand('setModel', function()
    local newModel = `s_m_y_casino_01`
    if not HasModelLoaded(newModel) then
        RequestModel(newModel)
        while not HasModelLoaded(newModel) do
            Citizen.Wait(0)
        end
    end
    SetPlayerModel(PlayerId(), newModel)
end, false)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then 
        DeleteEntity(cashier)
        DeletePeds()
    end
end)

RegisterCommand('doAnim', function()
   --local dict = "anim@amb@office@pa@female@"
   --local anim = "base_chair"
   --loadAnimDict(dict)
   --local scene = CreateSynchronizedScene(v.pedCoords.x, v.pedCoords.y, v.pedCoords.z, 0.0, 0.0, v.pedCoords.w, 2)
   --TaskSynchronizedScene(cahsier, scene, "anim_casino_b@amb@casino@games@shared@dealer@", "idle", 1000.0, -8.0, 4, 1, 1148846080, 0)
    --TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)

    --[[
    local chair = GetClosestObjectOfType(1117.241, 219.9995, -50.1525, 10.0, `vw_prop_casino_stool_02a`, 0, 0, 0)
    local dict = "AMB@PROP_HUMAN_SEAT_CHAIR@FEMALE@PROPER@BASE"
    local anim = "BASE"
    loadAnimDict(dict)
    Wait(500)
    TaskPlayAnim(cashier, dict, anim, 1.0, -8, -1, 1, 1, 0, 0, 0)
]]
end)

function loadAnimDict(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(100)
        end
    end
end

--

-- NUI Callbacks

RegisterNUICallback('buyChips', function(data, cb)
    TriggerServerEvent('shrp-casino:buyChips', tonumber(data.amount))
    cb('ok')
end)

RegisterNUICallback('sellChips', function(data, cb)
    TriggerServerEvent('shrp-casino:sellChips', tonumber(data.amount))
    cb('ok')
end)

RegisterNUICallback('close', function(data, cb)
    showingUI = false
    SendNUIMessage({
        event = 'close-ui',
    })
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterCommand('tpCasino', function() 
    SetEntityCoords(PlayerPedId(), 1100.39, 220.09, -48.75)
end)