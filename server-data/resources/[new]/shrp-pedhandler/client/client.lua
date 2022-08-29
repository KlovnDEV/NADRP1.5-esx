local CreatedPeds = {}
local devMode = true
Citizen.CreateThread(function()
    while true do
        for k,v in pairs(CreatedPeds) do
            local coords = v.position.coords
            local distance = v.distance
            local pedCoords = GetEntityCoords(PlayerPedId())
            local dist = #(pedCoords - vector3(coords.x,coords.y,coords.z))
            if #(pedCoords - vector3(coords.x,coords.y,coords.z)) < distance then
                if not v.spawned and created then
                    TogglePed(k, true)
                elseif not v.spawned and not created then 
                    SpawnPed(v)
                end
            else
                if v.spawned then
                    TogglePed(k, false)
                end
            end
        end
        Citizen.Wait(1000)
    end
end)

function SpawnPed(data)
    loadModel(data.model)
    local ped = CreatePed(data.pedType, GetHashKey(data.model), data.position.coords, data.position.heading, (data.networked and true or false), 3)
    
    local options = data.options
    local animation = data.animation
    local scenario = data.scenario

    CreatedPeds[data.id].pedName = ped
    CreatedPeds[data.id].spawned = true

    if options then
        if options.freeze then
            FreezeEntityPosition(ped, options.freeze)
        end
        if options.ignore then
            SetBlockingOfNonTemporaryEvents(ped, options.ignore)
        end
        if options.invincible then
            SetEntityInvincible(ped, options.invincible)
        end
    end

    if animation then
        LoadAnimDict(animation.dict)
        TaskPlayAnim(ped, animation.dict, animation.name, 1.0, 0.0, -1, (animation.flag and 1 or 0), 0, 0, 0, 0)
    end

    if scenario then
        TaskStartScenarioInPlace(ped, scenario.name, 0, false)
    end

    if data.components then
        SetComponentVariations(ped, data.components)
    end
    SetModelAsNoLongerNeeded(data.model)
end

function RegisterPed(data)
    if not data.id then return end
    if CreatedPeds[data.id] then
        if not devMode then
            if CreatedPeds[data.id].spawned then
                return print('Ped: '..data.id..' already exists, skipping')
            end
        else
            if CreatedPeds[data.id].spawned then 
                DeleteEntity(CreatedPeds[data.id].pedName)
            end
            CreatedPeds[data.id] = nil
        end
    end
    if not IsModelInCdimage(data.model) then 
        return print('Invalid Model:'..data.model..' Returning') 
    end

    CreatedPeds[data.id] = data
    CreatedPeds[data.id].spawned = false
    CreatedPeds[data.id].created = false
end
exports('RegisterPed', RegisterPed)

function RemovePed(id)
    if not id then return end
    if CreatedPeds[id] then
        if CreatedPeds[id].spawned then
            local ped = CreatedPeds[id].pedName
            local options = CreatedPeds[id].options
            if options then
                if options.freeze then
                    FreezeEntityPosition(ped, false)
                end
                if options.ignore then
                    SetBlockingOfNonTemporaryEvents(ped, false)
                end
                if options.invincible then
                    SetEntityInvincible(ped, false)
                end
            end
            TaskWanderStandard(CreatedPeds[id].pedName, 10.0, 10)
        end
        CreatedPeds[id] = nil
    end
end
exports('RemovePed', RemovePed)

function TogglePed(id, toggle)
    if not CreatedPeds[id] then return end
    local data = CreatedPeds[id]
    local pedName = data.pedName
    if toggle then
        SpawnPed(data)
    else
        DeleteEntity(pedName)
        data.spawned = false
    end
end
exports('TogglePed', TogglePed)

function SetComponentVariations(ped, variants)
    SetPedDefaultComponentVariation(ped)
    for _,v in pairs(variants) do
        local drawable = v.drawable and 1 or 0
        local texture = v.texture and 1 or 0
        local palette = v.palette and 1 or 0
        if v.type == "component" then
            SetPedComponentVariation(ped, v.component, v.drawable, v.texture, v.palette)
        elseif v.type == "prop" then
            SetPedPropIndex(ped, v.component, v.drawable, v.texture, true)
        end
    end
end

function loadModel(passedModel)
    if not HasModelLoaded(passedModel) then 
        RequestModel(passedModel)
        while not HasModelLoaded(passedModel) do 
            Citizen.Wait(0)
        end
    end
end

function LoadAnimDict(passedAnim)
    if not HasAnimDictLoaded(passedAnim) then
        while not HasAnimDictLoaded(passedAnim) do 
            Citizen.Wait(0)
        end
    end
end

--[[
    local draw = GetPedDrawableVariation(PlayerPedId(), 9)
    local text = GetPedTextureVariation(PlayerPedId(), 9)
    local pal = GetPedPaletteVariation(PlayerPedId(), 9)
    print(draw,text,pal)
    for i=0, 11 do
        local draw = GetPedDrawableVariation(PlayerPedId(), i)
        local text = GetPedTextureVariation(PlayerPedId(), i)
        local pal = GetPedPaletteVariation(PlayerPedId(), i)
        print('COMP:', i, 'DRAW:', draw, 'TEXT:', text, 'PAL:', pal)
    end
]]