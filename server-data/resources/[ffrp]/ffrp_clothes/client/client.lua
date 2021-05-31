local enabled = false
local player = false
local firstChar = false
local cam = false
local customCam = false
local oldPed = false
local startingMenu = false

local drawable_names = {"face", "masks", "hair", "torsos", "legs", "bags", "shoes", "neck", "undershirts", "vest", "decals", "jackets"}
local prop_names = {"hats", "glasses", "earrings", "mouth", "lhand", "rhand", "watches", "braclets"}
local head_overlays = {"Blemishes","FacialHair","Eyebrows","Ageing","Makeup","Blush","Complexion","SunDamage","Lipstick","MolesFreckles","ChestHair","BodyBlemishes","AddBodyBlemishes"}
local face_features = {"Nose_Width","Nose_Peak_Hight","Nose_Peak_Lenght","Nose_Bone_High","Nose_Peak_Lowering","Nose_Bone_Twist","EyeBrown_High","EyeBrown_Forward","Cheeks_Bone_High","Cheeks_Bone_Width","Cheeks_Width","Eyes_Openning","Lips_Thickness","Jaw_Bone_Width","Jaw_Bone_Back_Lenght","Chimp_Bone_Lowering","Chimp_Bone_Lenght","Chimp_Bone_Width","Chimp_Hole","Neck_Thikness"}
local tatCategory = GetTatCategs()
local tattooHashList = CreateHashList()

local StoreCosts = 0;
local barberCost = 0;
local tattooCost = 0;
local isService = false;

local weapon_types = {
    "WEAPON_KNIFE",
    "WEAPON_STUNGUN",
    "WEAPON_FLASHLIGHT",
    "WEAPON_NIGHTSTICK",
    "WEAPON_HAMMER",
    "WEAPON_BAT",
    "WEAPON_GOLFCLUB",
    "WEAPON_CROWBAR",
    "WEAPON_SWEEPERSHOTGUN",
    "WEAPON_PISTOL",
    "WEAPON_COMBATPISTOL",
    "WEAPON_COMPACTRIFLE",
    "WEAPON_APPISTOL",
    "WEAPON_PISTOL50",
    "WEAPON_MICROSMG",
    "WEAPON_SMG",
    "WEAPON_ASSAULTSMG",
    "WEAPON_ASSAULTRIFLE",
    "WEAPON_ADVANCEDRIFLE",
    "WEAPON_CARBINERIFLE",
    "WEAPON_ADVANCEDRIFLE",
    "WEAPON_MG",
    "WEAPON_GUSENBERG",
    "WEAPON_COMBATPDW",
    "WEAPON_COMBATMG",
    "WEAPON_PUMPSHOTGUN",
    "WEAPON_SAWNOFFSHOTGUN",
    "WEAPON_ASSAULTSHOTGUN",
    "WEAPON_BULLPUPSHOTGUN",
    "WEAPON_STUNGUN",
    "WEAPON_SNIPERRIFLE",
    "WEAPON_SNSPISTOL",
    "WEAPON_HEAVYSNIPER",
    "WEAPON_HEAVYPISTOL",
    "WEAPON_REMOTESNIPER",
    "WEAPON_GRENADELAUNCHER",
    "WEAPON_GRENADELAUNCHER_SMOKE",
    "WEAPON_RPG",
    "WEAPON_PASSENGER_ROCKET",
    "WEAPON_AIRSTRIKE_ROCKET",
    "WEAPON_STINGER",
    "WEAPON_MINIGUN",
    "WEAPON_REVOLVER",
    "WEAPON_MINISMG",
    "WEAPON_GRENADE",
    "WEAPON_STICKYBOMB",
    "WEAPON_SMOKEGRENADE",
    "WEAPON_MACHINEPISTOL",
    "WEAPON_BZGAS",
    "WEAPON_MOLOTOV",
    "WEAPON_FIREEXTINGUISHER",
    "WEAPON_PETROLCAN",
    "WEAPON_DIGISCANNER",
    "WEAPON_BRIEFCASE",
    "WEAPON_BRIEFCASE_02",
    "WEAPON_BALL",
    "WEAPON_FLARE"
}

function RefreshUI()
    hairColors = {}
    for i = 0, GetNumHairColors()-1 do
        local outR, outG, outB= GetPedHairRgbColor(i)
        hairColors[i] = {outR, outG, outB}
    end

    makeupColors = {}
    for i = 0, GetNumMakeupColors()-1 do
        local outR, outG, outB= GetPedMakeupRgbColor(i)
        makeupColors[i] = {outR, outG, outB}
    end

    SendNUIMessage({
        type="colors",
        hairColors=hairColors,
        makeupColors=makeupColors,
        hairColor=GetPedHair()
    })
    SendNUIMessage({
        type = "menutotals",
        drawTotal = GetDrawablesTotal(),
        propDrawTotal = GetPropDrawablesTotal(),
        textureTotal = GetTextureTotals(),
        headoverlayTotal = GetHeadOverlayTotals(),
        skinTotal = GetSkinTotal()
    })
    SendNUIMessage({
        type = "barbermenu",
        headBlend = GetPedHeadBlendData(),
        headOverlay = GetHeadOverlayData(),
        headStructure = GetHeadStructureData()
    })
    SendNUIMessage({
        type = "clothesmenudata",
        drawables = GetDrawables(),
        props = GetProps(),
        drawtextures = GetDrawTextures(),
        proptextures = GetPropTextures(),
        skin = GetSkin(),
        oldPed = oldPed,
    })
    SendNUIMessage({
        type = "tattoomenu",
        totals = tatCategory,
        values = GetTats()
    })
end

function GetSkin()
    for i = 1, #frm_skins do
        if (GetHashKey(frm_skins[i]) == GetEntityModel(PlayerPedId())) then
            return {name="skin_male", value=i}
        end
    end
    for i = 1, #fr_skins do
        if (GetHashKey(fr_skins[i]) == GetEntityModel(PlayerPedId())) then
            return {name="skin_female", value=i}
        end
    end
    return false
end

function GetDrawables()
    drawables = {}
    local model = GetEntityModel(PlayerPedId())
    local mpPed = false
    if (model == `mp_f_freemode_01` or model == `mp_m_freemode_01`) then
        mpPed = true
    end
    for i = 0, #drawable_names-1 do
        if mpPed and drawable_names[i+1] == "undershirts" and GetPedDrawableVariation(player, i) == -1 then
            SetPedComponentVariation(player, i, 15, 0, 2)
        end
        drawables[i] = {drawable_names[i+1], GetPedDrawableVariation(player, i)}
    end
    return drawables
end

function GetProps()
    props = {}
    for i = 0, #prop_names-1 do
        props[i] = {prop_names[i+1], GetPedPropIndex(player, i)}
    end
    return props
end

function GetDrawTextures()
    textures = {}
    for i = 0, #drawable_names-1 do
        table.insert(textures, {drawable_names[i+1], GetPedTextureVariation(player, i)})
    end
    return textures
end

function GetPropTextures()
    textures = {}
    for i = 0, #prop_names-1 do
        table.insert(textures, {prop_names[i+1], GetPedPropTextureIndex(player, i)})
    end
    return textures
end

function GetDrawablesTotal()
    drawables = {}
    for i = 0, #drawable_names - 1 do
        drawables[i] = {drawable_names[i+1], GetNumberOfPedDrawableVariations(player, i)}
    end
    return drawables
end

function GetPropDrawablesTotal()
    props = {}
    for i = 0, #prop_names - 1 do
        props[i] = {prop_names[i+1], GetNumberOfPedPropDrawableVariations(player, i)}
    end
    return props
end

function GetTextureTotals()
    local values = {}
    local draw = GetDrawables()
    local props = GetProps()

    for idx = 0, #draw-1 do
        local name = draw[idx][1]
        local value = draw[idx][2]
        values[name] = GetNumberOfPedTextureVariations(player, idx, value)
    end

    for idx = 0, #props-1 do
        local name = props[idx][1]
        local value = props[idx][2]
        values[name] = GetNumberOfPedPropTextureVariations(player, idx, value)
    end
    return values
end

function SetClothing(drawables, props, drawTextures, propTextures)
    for i = 1, #drawable_names do
        if drawables[0] == nil then
            if drawable_names[i] == "undershirts" and drawables[tostring(i-1)][2] == -1 then
                SetPedComponentVariation(player, i-1, 15, 0, 2)
            else
                SetPedComponentVariation(player, i-1, drawables[tostring(i-1)][2], drawTextures[i][2], 2)
            end
        else
            if drawable_names[i] == "undershirts" and drawables[i-1][2] == -1 then
                SetPedComponentVariation(player, i-1, 15, 0, 2)
            else
                SetPedComponentVariation(player, i-1, drawables[i-1][2], drawTextures[i][2], 2)
            end
        end
    end

    for i = 1, #prop_names do
        local propZ = (drawables[0] == nil and props[tostring(i-1)][2] or props[i-1][2])
        ClearPedProp(player, i-1)
        SetPedPropIndex(
            player,
            i-1,
            propZ,
            propTextures[i][2], true)
    end
end

function GetSkinTotal()

	return {
        #frm_skins,
        #fr_skins
    }
end

local toggleClothing = {}
function ToggleProps(data)
    local name = data["name"]

    selectedValue = has_value(drawable_names, name)
    if (selectedValue > -1) then
        if (toggleClothing[name] ~= nil) then
            SetPedComponentVariation(
                player,
                tonumber(selectedValue),
                tonumber(toggleClothing[name][1]),
                tonumber(toggleClothing[name][2]), 2)
            toggleClothing[name] = nil
        else
            toggleClothing[name] = {
                GetPedDrawableVariation(player, tonumber(selectedValue)),
                GetPedTextureVariation(player, tonumber(selectedValue))
            }

            local value = -1
            if name == "undershirts" or name == "torsos" then
                value = 15
                if name == "undershirts" and GetEntityModel(PlayerPedId()) == GetHashKey('mp_f_freemode_01') then
                    value = -1
                end
            end
            if name == "legs" then
                value = 14
            end

            SetPedComponentVariation(
                player,
                tonumber(selectedValue),
                value, 0, 2)
        end
    else
        selectedValue = has_value(prop_names, name)
        if (selectedValue > -1) then
            if (toggleClothing[name] ~= nil) then
                SetPedPropIndex(
                    player,
                    tonumber(selectedValue),
                    tonumber(toggleClothing[name][1]),
                    tonumber(toggleClothing[name][2]), true)
                toggleClothing[name] = nil
            else
                toggleClothing[name] = {
                    GetPedPropIndex(player, tonumber(selectedValue)),
                    GetPedPropTextureIndex(player, tonumber(selectedValue))
                }
                ClearPedProp(player, tonumber(selectedValue))
            end
        end
    end
end

function SaveToggleProps()
    for k in pairs(toggleClothing) do
        local name  = k
        selectedValue = has_value(drawable_names, name)
        if (selectedValue > -1) then
            SetPedComponentVariation(
                player,
                tonumber(selectedValue),
                tonumber(toggleClothing[name][1]),
                tonumber(toggleClothing[name][2]), 2)
            toggleClothing[name] = nil
        else
            selectedValue = has_value(prop_names, name)
            if (selectedValue > -1) then
                SetPedPropIndex(
                    player,
                    tonumber(selectedValue),
                    tonumber(toggleClothing[name][1]),
                    tonumber(toggleClothing[name][2]), true)
                toggleClothing[name] = nil
            end
        end
    end
end

function LoadPed(data)
    SetSkin(data.model, true)
    --print(data.model)
    SetClothing(data.drawables, data.props, data.drawtextures, data.proptextures)
    --print(data.drawables)
    --exports['mythic_notify']:SendAlert('inform', data.drawables, 22500)
    Citizen.Wait(500)
    SetPedHairColor(player, tonumber(data.hairColor[1]), tonumber(data.hairColor[2]))
    SetPedHeadBlend(data.headBlend)
    SetHeadStructure(data.headStructure)
    SetHeadOverlayData(data.headOverlay)
    PlayerModel(data.sex)
    return
end

function GetCurrentPed()
    player = GetPlayerPed(-1)
    return {
        model = GetEntityModel(PlayerPedId()),
        hairColor = GetPedHair(),
        headBlend = GetPedHeadBlendData(),
        headOverlay = GetHeadOverlayData(),
        headStructure = GetHeadStructure(),
        drawables = GetDrawables(),
        props = GetProps(),
        drawtextures = GetDrawTextures(),
        proptextures = GetPropTextures(),
    }
end

function PlayerModel(data)
    local armour = GetPedArmour(PlayerPedId())
    local skins
    if (data['name'] == 'skin_male') then
        skins = frm_skins
    else
        skins = fr_skins
    end
    local skin = skins[tonumber(data['value'])]
    rotation(180.0)
    SetSkin(GetHashKey(skin), true)
    Citizen.Wait(1)
    rotation(180.0)
    SetPedArmour(PlayerPedId(), armour)
end

function SetSkin(model, setDefault)
    -- TODO: If not isCop and model not in copModellist, do below.
    -- Model is a hash, GetHashKey(modelName)
    SetEntityInvincible(PlayerPedId(),true)
    local armour = GetPedArmour(PlayerPedId())
    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while (not HasModelLoaded(model)) do
            Citizen.Wait(0)
        end

        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
        player = GetPlayerPed(-1)
        FreezePedCameraRotation(player, true)
        if setDefault and model ~= nil and not isCustomSkin(model) then
            if (model ~= `mp_f_freemode_01` and model ~= `mp_m_freemode_01`) then
                SetPedRandomComponentVariation(GetPlayerPed(-1), true)
            else
                SetPedHeadBlendData(player, 0, 0, 0, 15, 0, 0, 0, 1.0, 0, false)
                SetPedComponentVariation(player, 11, 0, 11, 0)
                SetPedComponentVariation(player, 8, 0, 1, 0)
                SetPedComponentVariation(player, 6, 1, 2, 0)
                SetPedHeadOverlayColor(player, 1, 1, 0, 0)
                SetPedHeadOverlayColor(player, 2, 1, 0, 0)
                SetPedHeadOverlayColor(player, 4, 2, 0, 0)
                SetPedHeadOverlayColor(player, 5, 2, 0, 0)
                SetPedHeadOverlayColor(player, 8, 2, 0, 0)
                SetPedHeadOverlayColor(player, 10, 1, 0, 0)
                SetPedHeadOverlay(player, 1, 0, 0.0)
                SetPedHairColor(player, 1, 1)
            end
        end
    end
    SetEntityInvincible(PlayerPedId(),false)
    SetPedArmour(PlayerPedId(), armour)
end


RegisterNUICallback('updateclothes', function(data, cb)
    toggleClothing[data["name"]] = nil
    selectedValue = has_value(drawable_names, data["name"])
    if (selectedValue > -1) then
        SetPedComponentVariation(player, tonumber(selectedValue), tonumber(data["value"]), tonumber(data["texture"]), 2)
        cb({
            GetNumberOfPedTextureVariations(player, tonumber(selectedValue), tonumber(data["value"]))
        })
    else
        selectedValue = has_value(prop_names, data["name"])
        if (tonumber(data["value"]) == -1) then
            ClearPedProp(player, tonumber(selectedValue))
        else
            SetPedPropIndex(
                player,
                tonumber(selectedValue),
                tonumber(data["value"]),
                tonumber(data["texture"]), true)
        end
        cb({
            GetNumberOfPedPropTextureVariations(
                player,
                tonumber(selectedValue),
                tonumber(data["value"])
            )
        })
    end
end)

RegisterNUICallback('customskin', function(data, cb)
    if canUseCustomSkins() then
        local valid_model = isInSkins(data)
        if valid_model then
            SetSkin(GetHashKey(data), true)
        end
    end
end)

RegisterNUICallback('setped', function(data, cb)
    PlayerModel(data)
    RefreshUI()
    cb('ok')
end)

RegisterNUICallback('resetped', function(data, cb)
    LoadPed(oldPed)
    cb('ok')
end)

AddEventHandler('playerSpawned', function(spawn)
    isDead = false
    --loadPed()
end)

------------------------------------------------------------------------------------------
-- Barber

function GetPedHeadBlendData()
    local blob = string.rep("\0\0\0\0\0\0\0\0", 6 + 3 + 1) -- Generate sufficient struct memory.
    if not Citizen.InvokeNative(0x2746BD9D88C5C5D0, player, blob, true) then -- Attempt to write into memory blob.
        return nil
    end

    return {
        shapeFirst = string.unpack("<i4", blob, 1),
        shapeSecond = string.unpack("<i4", blob, 9),
        shapeThird = string.unpack("<i4", blob, 17),
        skinFirst = string.unpack("<i4", blob, 25),
        skinSecond = string.unpack("<i4", blob, 33),
        skinThird = string.unpack("<i4", blob, 41),
        shapeMix = string.unpack("<f", blob, 49),
        skinMix = string.unpack("<f", blob, 57),
        thirdMix = string.unpack("<f", blob, 65),
        hasParent = string.unpack("b", blob, 73) ~= 0,
    }
end

function SetPedHeadBlend(data)
    SetPedHeadBlendData(player,
        tonumber(data['shapeFirst']),
        tonumber(data['shapeSecond']),
        tonumber(data['shapeThird']),
        tonumber(data['skinFirst']),
        tonumber(data['skinSecond']),
        tonumber(data['skinThird']),
        tonumber(data['shapeMix']),
        tonumber(data['skinMix']),
        tonumber(data['thirdMix']),
        false)
end

function GetHeadOverlayData()
    local headData = {}
    for i = 1, #head_overlays do
        local retval, overlayValue, colourType, firstColour, secondColour, overlayOpacity = GetPedHeadOverlayData(player, i-1)
        if retval then
            headData[i] = {}
            headData[i].name = head_overlays[i]
            headData[i].overlayValue = overlayValue
            headData[i].colourType = colourType
            headData[i].firstColour = firstColour
            headData[i].secondColour = secondColour
            headData[i].overlayOpacity = overlayOpacity
        end
    end
    return headData
end

function SetHeadOverlayData(data)
    if json.encode(data) ~= "[]" then
        for i = 1, #head_overlays do
            SetPedHeadOverlay(player,  i-1, tonumber(data[i].overlayValue),  tonumber(data[i].overlayOpacity))
            -- SetPedHeadOverlayColor(player, i-1, data[i].colourType, data[i].firstColour, data[i].secondColour)
        end

        SetPedHeadOverlayColor(player, 0, 0, tonumber(data[1].firstColour), tonumber(data[1].secondColour))
        SetPedHeadOverlayColor(player, 1, 1, tonumber(data[2].firstColour), tonumber(data[2].secondColour))
        SetPedHeadOverlayColor(player, 2, 1, tonumber(data[3].firstColour), tonumber(data[3].secondColour))
        SetPedHeadOverlayColor(player, 3, 0, tonumber(data[4].firstColour), tonumber(data[4].secondColour))
        SetPedHeadOverlayColor(player, 4, 2, tonumber(data[5].firstColour), tonumber(data[5].secondColour))
        SetPedHeadOverlayColor(player, 5, 2, tonumber(data[6].firstColour), tonumber(data[6].secondColour))
        SetPedHeadOverlayColor(player, 6, 0, tonumber(data[7].firstColour), tonumber(data[7].secondColour))
        SetPedHeadOverlayColor(player, 7, 0, tonumber(data[8].firstColour), tonumber(data[8].secondColour))
        SetPedHeadOverlayColor(player, 8, 2, tonumber(data[9].firstColour), tonumber(data[9].secondColour))
        SetPedHeadOverlayColor(player, 9, 0, tonumber(data[10].firstColour), tonumber(data[10].secondColour))
        SetPedHeadOverlayColor(player, 10, 1, tonumber(data[11].firstColour), tonumber(data[11].secondColour))
        SetPedHeadOverlayColor(player, 11, 0, tonumber(data[12].firstColour), tonumber(data[12].secondColour))
    end
end

function GetHeadOverlayTotals()
    local totals = {}
    for i = 1, #head_overlays do
        totals[head_overlays[i]] = GetNumHeadOverlayValues(i-1)
    end
    return totals
end

function GetPedHair()
    local hairColor = {}
    hairColor[1] = GetPedHairColor(player)
    hairColor[2] = GetPedHairHighlightColor(player)
    return hairColor
end

function GetHeadStructureData()
    local structure = {}
    for i = 1, #face_features do
        structure[face_features[i]] = GetPedFaceFeature(player, i-1)
    end
    return structure
end

function GetHeadStructure(data)
    local structure = {}
    for i = 1, #face_features do
        structure[i] = GetPedFaceFeature(player, i-1)
    end
    return structure
end

function SetHeadStructure(data)
    for i = 1, #face_features do
        SetPedFaceFeature(player, i-1, data[i])
    end
end


RegisterNUICallback('saveheadblend', function(data, cb)
    SetPedHeadBlendData(player,
    tonumber(data.shapeFirst),
    tonumber(data.shapeSecond),
    tonumber(data.shapeThird),
    tonumber(data.skinFirst),
    tonumber(data.skinSecond),
    tonumber(data.skinThird),
    tonumber(data.shapeMix) / 100,
    tonumber(data.skinMix) / 100,
    tonumber(data.thirdMix) / 100, false)
    cb('ok')
end)

RegisterNUICallback('savehaircolor', function(data, cb)
    SetPedHairColor(player, tonumber(data['firstColour']), tonumber(data['secondColour']))
end)

RegisterNUICallback('savefacefeatures', function(data, cb)
    local index = has_value(face_features, data["name"])
    if (index <= -1) then return end
    local scale = tonumber(data["scale"]) / 100
    SetPedFaceFeature(player, index, scale)
    cb('ok')
end)

RegisterNUICallback('saveheadoverlay', function(data, cb)
    local index = has_value(head_overlays, data["name"])
    SetPedHeadOverlay(player,  index, tonumber(data["value"]), tonumber(data["opacity"]) / 100)
    cb('ok')
end)

RegisterNUICallback('saveheadoverlaycolor', function(data, cb)
    local index = has_value(head_overlays, data["name"])
    local success, overlayValue, colourType, firstColour, secondColour, overlayOpacity = GetPedHeadOverlayData(player, index)
    local sColor = tonumber(data['secondColour'])
    if (sColor == nil) then
        sColor = tonumber(data['firstColour'])
    end
    SetPedHeadOverlayColor(player, index, colourType, tonumber(data['firstColour']), sColor)
    cb('ok')
end)


----------------------------------------------------------------------------------
-- UTIL SHIT


function has_value (tab, val)
    for index = 1, #tab do
        if tab[index] == val then
            return index-1
        end
    end
    return -1
end

function EnableGUI(enable, menu)
    enabled = enable
    SetNuiFocus(enable, enable)
    SendNUIMessage({
        type = "enableclothesmenu",
        enable = enable,
        menu = menu,
        isService = isService,
    })

    if (not enable) then
        SaveToggleProps()
        oldPed = {}
    end
end

function CustomCamera(position)
    if customCam or position == "torso" then
        FreezePedCameraRotation(player, false)
        SetCamActive(cam, false)
        RenderScriptCams(false,  false,  0,  true,  true)
        if (DoesCamExist(cam)) then
            DestroyCam(cam, false)
        end
        customCam = false
    else
        if (DoesCamExist(cam)) then
            DestroyCam(cam, false)
        end

        local pos = GetEntityCoords(player, true)
        SetEntityRotation(player, 0.0, 0.0, 0.0, 1, true)
        FreezePedCameraRotation(player, true)

        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamCoord(cam, player)
        SetCamRot(cam, 0.0, 0.0, 0.0)

        SetCamActive(cam, true)
        RenderScriptCams(true,  false,  0,  true,  true)

        SwitchCam(position)
        customCam = true
    end
end

function rotation(dir)
    local pedRot = GetEntityHeading(PlayerPedId())+dir
    SetEntityHeading(PlayerPedId(), pedRot % 360)
end

function TogRotation()
    local pedRot = GetEntityHeading(PlayerPedId())+90 % 360
    SetEntityHeading(PlayerPedId(), math.floor(pedRot / 90) * 90.0)
end

function SwitchCam(name)
    if name == "cam" then
        TogRotation()
        return
    end

    local pos = GetEntityCoords(player, true)
    local bonepos = false
    if (name == "head") then
        bonepos = GetPedBoneCoords(player, 31086)
        bonepos = vector3(bonepos.x - 0.1, bonepos.y + 0.4, bonepos.z + 0.05)
    end
    if (name == "torso") then
        bonepos = GetPedBoneCoords(player, 11816)
        bonepos = vector3(bonepos.x - 0.4, bonepos.y + 2.2, bonepos.z + 0.2)
    end
    if (name == "leg") then
        bonepos = GetPedBoneCoords(player, 46078)
        bonepos = vector3(bonepos.x - 0.1, bonepos.y + 1, bonepos.z)
    end

    SetCamCoord(cam, bonepos.x, bonepos.y, bonepos.z)
    SetCamRot(cam, 0.0, 0.0, 180.0)
end

RegisterNUICallback('escape', function(data, cb)
    Save(data['save'])
    EnableGUI(false, false)
    cb('ok')
end)

RegisterNUICallback('togglecursor', function(data, cb)
    CustomCamera("torso")
    SetNuiFocus(false, false)
    FreezePedCameraRotation(player, false)
    cb('ok')
end)

RegisterNUICallback('rotate', function(data, cb)
    if (data["key"] == "left") then
        rotation(20)
    else
        rotation(-20)
    end
    cb('ok')
end)

RegisterNUICallback('switchcam', function(data, cb)
    CustomCamera(data['name'])
    cb('ok')
end)

RegisterNUICallback('toggleclothes', function(data, cb)
    ToggleProps(data)
    cb('ok')
end)


------------------------------------------------------------------------
-- Tattooooooos


-- currentTats [[collectionHash, tatHash], [collectionHash, tatHash]]
-- loop tattooHashList [categ] find [tatHash, collectionHash]

function GetTats()
    local tempTats = {}
    if currentTats == nil then return {} end
    for i = 1, #currentTats do
        for key in pairs(tattooHashList) do
            for j = 1, #tattooHashList[key] do
                if tattooHashList[key][j][1] == currentTats[i][2] then
                    tempTats[key] = j
                end
            end
        end
    end
    return tempTats
end

function SetTats(data)
    currentTats = {}
    for k, v in pairs(data) do
        for categ in pairs(tattooHashList) do
            if k == categ then
                local something = tattooHashList[categ][tonumber(v)]
                if something ~= nil then
                    table.insert(currentTats, {something[2], something[1]})
                end
            end
        end
    end
    ClearPedDecorations(PlayerPedId())
    for i = 1, #currentTats do
        ApplyPedOverlay(PlayerPedId(), currentTats[i][1], currentTats[i][2])
    end
end

RegisterNUICallback('settats', function(data, cb)
    SetTats(data["tats"])
    cb('ok')
end)


--------------------------------------------------------------------
-- Main menu

function OpenMenu(name)
    player = GetPlayerPed(-1)
    oldPed = GetCurrentPed()
    local isAllowed = false
    if(oldPed.model == 1885233650 or oldPed.model == -1667301416) then isAllowed = true end
    if((oldPed.model ~= 1885233650 or oldPed.model ~= -1667301416) and (name == "clothesmenu" or name == "tattoomenu" or name == "healmenu")) then isAllowed = true end
    if isAllowed then
        FreezePedCameraRotation(player, true)
        RefreshUI()
        EnableGUI(true, name)
    else
        TriggerEvent("DoLongHudText", "You are not welcome here!");
    end
end

function Save(save)
    if save then
        data = GetCurrentPed()
        TriggerServerEvent("ffrp-clothes:insert_character_current", data)
        if data.model == `mp_f_freemode_01` or data.model == `mp_m_freemode_01` then
            TriggerServerEvent("ffrp-clothes:insert_character_face", data)
            TriggerServerEvent("ffrp-clothes:set_tats", currentTats)
        end
    else
        LoadPed(oldPed)
    end
    TriggerEvent("ressurection:relationships:norevive")
    TriggerEvent("gangs:setDefaultRelations")
    TriggerEvent("facewear:update")
    CustomCamera('torso')
end

function IsNearShop(shops)
    local dstchecked = 1000
    local plyPos = GetEntityCoords(GetPlayerPed(PlayerId()), false)
	for i = 1, #shops do
		shop = shops[i]
		local comparedst = Vdist(plyPos.x, plyPos.y, plyPos.z,shop[1], shop[2], shop[3])
		if comparedst < dstchecked then
			dstchecked = comparedst
		end

		if comparedst < 3.0 then
			DrawMarker(27,shop[1], shop[2], shop[3], 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 1.7001, 0, 55, 240, 20, 0, 0, 0, 0)
		end
	end
	return dstchecked
end


local bitch = {
    [1] = {["x"] = 1693.45667, ["y"] = 4823.17725,["z"] =  42.1631294},
    [2] = {["x"] = -1177.865234375, ["y"] = -1780.5612792969,["z"] = 3.9084651470184},
    [3] = {["x"] = 198.4602355957, ["y"] = -1646.7690429688,["z"] = 29.803218841553},
    [4] = {["x"] =   299.29, ["y"] =  -598.45,["x"] =  43.29},
    [5] = {["x"] = -712.215881, ["y"] = -155.352982,["z"] =  37.4151268},
    [6] = {["x"] = 123.779823, ["y"] = -301.616455,["z"] =  54.557827},
    [7] = {["x"] = -1192.94495, ["y"] = -772.688965,["z"] =  17.3255997},
    [8] = {["x"] = 454.75, ["y"] =  -991.05,["z"] = 30.69},
	[9] = {["x"] =  425.236, ["y"] = -806.008,["z"] = 28.491},
	[10] = {["x"] =  -162.658, ["y"] = -303.397,["z"] = 38.733},
	[11] = {["x"] =  75.950, ["y"] = -1392.891,["z"] = 28.376},
	[12] = {["x"] =  -822.194, ["y"] = -1074.134,["z"] = 10.328},
	[13] = {["x"] =  -1450.711, ["y"] = -236.83,["z"] = 48.809},
	[14] = {["x"] =  4.254, ["y"] = 6512.813,["z"] = 30.877},
	[15] = {["x"] =  615.180, ["y"] = 2762.933,["z"] = 41.088},
	[16] = {["x"] =  1196.785, ["y"] = 2709.558,["z"] = 37.222},
	[17] = {["x"] =  -3171.453, ["y"] = 1043.857,["z"] = 19.863},
	[18] = {["x"] =  -1100.959, ["y"] = 2710.211,["z"] = 18.107},
	[19] = {["x"] =  -1207.6564941406, ["y"] = -1456.8890380859,["z"] = 4.3784737586975},
	[20] = {["x"] =  121.76, ["y"] = -224.6,["z"] = 53.56},
	[21] = {["x"] =  1784.13, ["y"] = 2492.6,["z"] = 50.43},
}


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
        local nearcloth = IsNearShop(clothingShops)
        local nearheal = IsNearShop(healingShops)
        local neartat = IsNearShop(tattoosShops)
        local nearbarber = IsNearShop(barberShops)
        local StoreCosts = 100
        local barberCost = 70
        local tattooCost = 50

        local menu = nil

        if nearcloth < 5.0 then
            menu = {"clothesmenu", "Press ~g~M~s~ to change Clothes $"..StoreCosts}
            for i=1, #bitch do
                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),bitch[i]["x"], bitch[i]["y"], bitch[i]["z"], true) <= 4.0 then
                    DrawText3Ds(bitch[i]["x"], bitch[i]["y"], bitch[i]["z"]+1, '~g~/outfithelp~w~ for outfit commands')
                end
            end
            StoreCost = StoreCosts
        elseif neartat < 5.0 then
            menu = {"tattoomenu", "Press ~g~M~s~ to change Tattoos $"..tattooCost}
            StoreCost = tattooCost
        elseif nearbarber < 5.0 then
            menu = {"barbermenu", "Press ~g~M~s~ to visit the Barber $"..barberCost}
            StoreCost = barberCost
        elseif nearheal < 2.0 then
            menu = {"healmenu", "~g~UP~s~ to Heal/Remove Bleeding"}
        elseif startingMenu then
            menu = "clothesmenu"
        end


        if (menu ~= nil) then
            if menu[1] == "healmenu" then
                if IsControlJustPressed(1, 188) then
                    SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
                    TriggerEvent("Evidence:ClearDamageStates")
                end
            end
            if (not enabled) then
                DisplayHelpText(menu[2])
                if IsControlJustPressed(1, 244) then
                    TriggerServerEvent("clothing:checkMoney",menu[1],StoreCost)
                end
            else
                if (IsControlJustReleased(1, 25)) then
                    SetNuiFocus(true, true)
                    FreezePedCameraRotation(player, true)
                end
                InvalidateIdleCam()
            end
        else
            local dist = math.min(nearcloth, neartat, nearbarber, nearheal)
            if dist > 10 then
                Citizen.Wait(math.ceil(dist * 10))
            end
		end
	end
end)

RegisterNetEvent("ffrp-clothes:inService")
AddEventHandler("ffrp-clothes:inService", function(service)
    isService = service
end)

RegisterNetEvent("ffrp-clothes:hasEnough")
AddEventHandler("ffrp-clothes:hasEnough", function(menu)
    if menu == "tattoomenu" then
        TriggerServerEvent("ffrp-clothes:retrieve_tats")
        while currentTats == nil do
            Citizen.Wait(1)
        end
    end
    OpenMenu(menu)
end)

--[[RegisterCommand('spawnme', function(source, args)
    --print("spawned me")
--TriggerEvent("ffrp-clothes:register")
    OpenMenu("barbermenu")
end)]]

RegisterNetEvent("ffrp-clothes:setclothes")
AddEventHandler("ffrp-clothes:setclothes", function(data,alreadyExist)

    player = GetPlayerPed(-1)
    local armour = GetPedArmour(PlayerPedId())
    local function setDefault()
        Citizen.CreateThread(function()
            firstChar = true
            local sex = nil
            local LocalPlayer = ESX.GetPlayerFromId(source)
            local sex = LocalPlayer:getCurrentCharacter().sex
            Citizen.Wait(5000)
            if skin.sex ~= 0 then
                SetSkin(`mp_m_freemode_01`, true)
            else
                SetSkin(`mp_f_freemode_01`, true)
            end
            TriggerEvent("ffrp-clothes:defaultReset")
            OpenMenu("clothesmenu")
            startingMenu = true
            DoScreenFadeIn(50)
        end)
    end

	if not data.model and alreadyExist <= 0 then setDefault() return end
    if not data.model and alreadyExist >= 1 then return end
    model = data.model
    model = model ~= nil and tonumber(model) or false

	if not IsModelInCdimage(model) or not IsModelValid(model) then setDefault() return end
    SetSkin(model, false)
    Citizen.Wait(500)
    SetClothing(data.drawables, data.props, data.drawtextures, data.proptextures)
    SetTats(GetTats())
    Citizen.Wait(500)
	TriggerEvent("facewear:update")
    TriggerServerEvent("ffrp-clothes:get_character_face")
    TriggerServerEvent("ffrp-clothes:retrieve_tats")
    SetPedArmour(PlayerPedId(), armour)
end)

RegisterNetEvent("ffrp-clothes:defaultReset")
AddEventHandler("ffrp-clothes:defaultReset", function(sex)
    Citizen.Wait(1000)
    if sex == 'f' then
        SetSkin(`mp_f_freemode_01`, true)
    else
        SetSkin(`mp_m_freemode_01`, true)
    end
    OpenMenu("clothesmenu")
    startingMenu = true
end)

RegisterNetEvent("ffrp-clothes:settattoos")
AddEventHandler("ffrp-clothes:settattoos", function(playerTattoosList)
    currentTats = playerTattoosList
    SetTats(GetTats())
end)

RegisterNetEvent("ffrp-clothes:setpedfeatures")
AddEventHandler("ffrp-clothes:setpedfeatures", function(data)
    player = GetPlayerPed(-1)
    if data == false then
        SetSkin(GetEntityModel(PlayerPedId()), true)
        return
    end

    local head = data.headBlend
    local haircolor = data.hairColor
    local headOverlay = data.headOverlay
    local headStructure = data.headStructure

    SetPedHeadBlendData(player,
        tonumber(head['shapeFirst']),
        tonumber(head['shapeSecond']),
        tonumber(head['shapeThird']),
        tonumber(head['skinFirst']),
        tonumber(head['skinSecond']),
        tonumber(head['skinThird']),
        tonumber(head['shapeMix']),
        tonumber(head['skinMix']),
        tonumber(head['thirdMix']),
    false)
    SetHeadStructure(headStructure)
    SetHeadOverlayData(headOverlay)
    SetPedHairColor(player, tonumber(haircolor[1]), tonumber(haircolor[2]))
    --print(tonumber(haircolor[1]), tonumber(haircolor[2]))
    --LoadPed(data)
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


RegisterNetEvent('ffrp-clothes:outfits')
AddEventHandler('ffrp-clothes:outfits', function(pAction, pId, pName)
    if pAction == 1 then
        TriggerServerEvent("ffrp-clothes:set_outfit",pId, pName, GetCurrentPed())
    elseif pAction == 2 then
        TriggerServerEvent("ffrp-clothes:remove_outfit",pId)
    elseif pAction == 3 then
        TriggerEvent('item:deleteClothesDna')
        TriggerServerEvent("ffrp-clothes:get_outfit", pId)
    else
        TriggerServerEvent("ffrp-clothes:list_outfits")
    end
end)

--new regiser
AddEventHandler('ffrp-clothes:register', function(name)
    OpenMenu("clothesmenu")
end)


-- LoadPed(data) Sets clothing based on the data structure given, the same structure that GetCurrentPed() returns
-- GetCurrentPed() Gives you the data structure of the currently worn clothes


shopBlips = {
    {x = 1693.45667, y = 4823.17725, z = 42.163129 },
    {x = 198.4602355957,y = -1646.7690429688,z = 29.80321884155},
    {  x = 299.29, y = -598.45, z = 43.29 } ,
    {x = -712.215881,y = -155.352982, z = 37.415126},
    {x = -1192.94495,y = -772.688965, z = 17.3255997,1500},
    {x = 454.75, y = -991.05, z = 30.69},
    { x = 425.236,y = -806.008,z = 28.491},
    { x = -162.658,y = -303.397,z = 38.733},
    { x = 75.950,y = -1392.891,z = 28.376},
    { x = -822.194,y = -1074.134,z = 10.328},
    { x = -1450.711,y = -236.83,z = 48.809},
    { x = 4.254,y = 6512.813,z = 30.877},
    { x = 615.180,y = 2762.933,z = 41.088},
    { x = 1196.785,y = 2709.558,z = 37.22},
    { x = -3171.453,y = 1043.857,z = 19.86},
    { x = -1100.959,y = 2710.211,z = 18.10},
    { x = -1207.6564941406,y = -1456.8890380859,z = 4.378473758697},
    { x = 121.76,y = -224.6,z = 53.5},
    { x = 1780.449, y = 2547.869, z = 44.798},
    { x = 1849.555, y = 3695.773, z = 33.3},
	{ x = -454.379, y = 6014.986, z = 30.7},
}

barberBlips = {
    {x = 1932.0756835938, y = 3729.6706542969, z = 32.844413757324},
    {x = -278.19036865234, y = 6228.361328125, z = 31.695510864258},
    {x = 1211.9903564453, y = -472.77117919922, z = 66.207984924316},
    {x = -33.224239349365, y = -152.62608337402, z = 57.076496124268},
    {x = 136.7181854248, y = -1708.2673339844, z = 29.291622161865},
    {x = -815.18896484375, y = -184.53868103027, z = 37.568943023682},
    {x = -1283.2886962891, y = -1117.3210449219, z = 6.9901118278503}
}

tattooBlips = {
    {x = 1322.645, y = -1651.976, z = 52.275},
    {x = -1153.676, y = -1425.68, z = 4.954},
    {x = 322.139, y = 180.467, z = 103.587},
    {x = -3170.071, y = 1075.059, z = 20.829},
    {x = 1864.633, y = 3747.738, z = 33.032},
    {x = -293.713, y = 6200.04, z = 31.487},
    {x = -1220.6872558594, y = -1430.6593017578, z = 4.3321843147278},
}

Citizen.CreateThread(function()
    for i=1, #shopBlips, 1 do
        local blip = AddBlipForCoord(shopBlips[i].x, shopBlips[i].y, shopBlips[i].z )
        SetBlipSprite (blip, 73)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.6)
        SetBlipColour (blip, 81)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Clothing Store')
        EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    for i=1, #barberBlips, 1 do
        local blip = AddBlipForCoord(barberBlips[i].x, barberBlips[i].y, barberBlips[i].z )
        SetBlipSprite (blip, 71)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.6)
        SetBlipColour (blip, 51)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Barber Shop')
        EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    for i=1, #tattooBlips, 1 do
        local blip = AddBlipForCoord(tattooBlips[i].x, tattooBlips[i].y, tattooBlips[i].z )
        SetBlipDisplay(blip, 4)
        SetBlipSprite(blip, 75)
        SetBlipColour(blip, 1)
        SetBlipScale(blip, 0.6)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Tattoo Store')
        EndTextCommandSetBlipName(blip)
    end
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end


RegisterCommand('outfitadd', function(source, args, raw)
    local slot = args[1]
    local name = args[2]
    local nearcloth = IsNearShop(clothingShops)
    local inMotel = exports['ffrp-motels']:nearClothingMotel()
    local inHouse = exports['ffrp_garages']:nearClothingHouse()
    if nearcloth < 10 or inMotel or inHouse then
        if slot ~= nil and name ~= nil then
            TriggerServerEvent('ffrp-clothes:set_outfit', slot, name, GetCurrentPed())
        else
            --TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text ='Make Sure you do : /outfitadd [slot] [name]'})
            exports['mythic_notify']:SendAlert('error', 'Make Sure you do : /outfitadd [slot] [name]')
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Not near a clothing point')
    end

end, false)

RegisterCommand('outfits', function(source, args, raw)
    local nearcloth = IsNearShop(clothingShops)
    local coord = GetEntityCoords(source)
    local inMotel = exports['ffrp-motels']:nearClothingMotel()
    local inHouse = exports['ffrp_garages']:nearClothingHouse()
    if nearcloth < 10 or inMotel or inHouse then
        TriggerServerEvent("ffrp-clothes:list_outfits")
    else
        exports['mythic_notify']:SendAlert('error', 'Not near a clothing point')
    end

end, false)


RegisterCommand('outfitdel', function(source, args, raw)
    local slot = args[1]
    local nearcloth = IsNearShop(clothingShops)
    local inMotel = exports['ffrp-motels']:nearClothingMotel()
    local inHouse = exports['ffrp_garages']:nearClothingHouse()
    if nearcloth < 10 or inMotel or inHouse then
        if slot ~= nil then
            TriggerServerEvent("ffrp-clothes:remove_outfit", slot)
        else
            exports['mythic_notify']:SendAlert('error', 'Invalid slot')
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Not near a clothing point')
    end
end, false)

RegisterCommand('outfituse', function(source, args, raw)
    local slot = args[1]
    local nearcloth = IsNearShop(clothingShops)
    local inMotel = exports['ffrp-motels']:nearClothingMotel()
    local inHouse = exports['ffrp_garages']:nearClothingHouse()
    if nearcloth < 10 or inMotel or inHouse then
        if slot ~= nil then
            TriggerServerEvent("ffrp-clothes:get_outfit", slot)
            TriggerEvent('InteractSound_CL:PlayOnOne','Clothes1', 0.6)
        else
            exports['mythic_notify']:SendAlert('error', 'Invalid slot')
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Not near a clothing point')
    end
end, false)

RegisterCommand('outfithelp', function(source, args, raw)
    local outfits = '/outfits - List all outfits with slot numbers'
    local outfitadd = '/outfitadd [slot] [outfitname] - Saves current outfit'
    local outfitdel = '/outfitdel [slot] - Deletes outfit on selected slot'
    local outfituse = '/outfituse [slot]  - Apply outfit on selected slot'
    TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message nonemergency">{0} <br> {1} <br> {2} <br> {3} </div>',
        args = {outfits,outfitadd,outfitdel,outfituse}
    })
end)

RegisterNetEvent('hotel:list')
AddEventHandler('hotel:list', function(skincheck)
	for i = 1, #skincheck do
        exports['mythic_notify']:SendAlert('inform', skincheck[i].slot .. " | " .. skincheck[i].name)
	end
end)