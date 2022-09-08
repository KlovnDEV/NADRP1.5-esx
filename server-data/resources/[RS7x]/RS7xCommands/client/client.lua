ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


Citizen.CreateThread(function()
    while true do  
        Wait(0)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SAWNOFFSHOTGUN"), 0.50) 
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PUMPSHOTGUN_MK2"), 0.50)
    end
end)



-- strmem 1

Citizen.CreateThread(function()
    while true do
        if InAnim then
            Citizen.Wait(0)
            DisableAllControlActions(0)
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 2, true)
            EnableControlAction(0, 3, true)
            EnableControlAction(0, 4, true)
            EnableControlAction(0, 289, true)
            EnableControlAction(0, 322, true)
            EnableControlAction(0, 245, true)
        else
            Citizen.Wait(1000)
        end
    end
end)

-- Buy idcard

Citizen.CreateThread(function()
    while true do
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 237.35, -416.74, 47.95) < 5.0 then
            Citizen.Wait(0)
            DrawText3Ds(237.35, -416.74, 47.95, '~r~[E]~w~ Buy id-card')
            DrawMarker(27, 237.35, -416.74, 47.15 - 0.2, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.7, 255, 0, 0, 100, false, false, 2, false, false, false, false)
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 237.35, -416.74, 47.95) < 1.0 then
                if IsControlJustPressed(0,38) then
                    --TriggerServerEvent('RS7x:canBuyID')
                    OpenIdMenu()
                end
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

imdead = 0

RegisterNetEvent('RS7x:Rolljoints')
AddEventHandler('RS7x:Rolljoints', function(boj)
    if not InAnim then
        TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 0, true)
        InAnim = true
    end
    if boj == 'joints' then
        exports['t0sic_loadingbar']:StartDelayedFunction('Rolling Joints', 10000, function()
            ClearPedTasks(GetPlayerPed(-1))
            TriggerServerEvent('RS7x:GiveJoints', 'joints')
            InAnim = false
        end)
    end
    --[[elseif boj == 'blunts' then
        exports['t0sic_loadingbar']:StartDelayedFunction('Rolling Blunts', 10000, function()
            ClearPedTasks(GetPlayerPed(-1))
            TriggerServerEvent('RS7x:GiveJoints', 'blunts')
            InAnim = false
        end)
    end]]
end)

RegisterNetEvent('RS7x:Smokeweed')
AddEventHandler('RS7x:Smokeweed', function(blunt)
    local pedArmour = GetPedArmour(GetPlayerPed(-1))

    if not blunt then
        Smoking = true
        TaskStartScenarioInPlace(GetPlayerPed(-1),"WORLD_HUMAN_SMOKING_POT",-1,true)
        exports["t0sic_loadingbar"]:StartDelayedFunction('Smoking Joint', 6000, function()
            Smoking = false

            if pedArmour < 100 then
                SetPedArmour(GetPlayerPed(-1), pedArmour+33)
            end
            ClearPedTasksImmediately(GetPlayerPed(-1))
            EnableAllControlActions(0)
        end)
    end
    --[[if blunt then
        Smoking = true
        TaskStartScenarioInPlace(GetPlayerPed(-1),"WORLD_HUMAN_SMOKING_POT",-1,true)
        exports["t0sic_loadingbar"]:StartDelayedFunction('Smoking Blunt', 6000, function()
            Smoking = false
            if pedArmour < 100 then
                SetPedArmour(GetPlayerPed(-1), pedArmour+33)
            end
            ClearPedTasksImmediately(GetPlayerPed(-1))
            EnableAllControlActions(0)
        end)
    end]]
end)

RegisterNetEvent('hadcocaine')
AddEventHandler('hadcocaine', function()
    local stresslevel = 0
    dstamina = 0
    local stresslevel = exports["nadrp-hud"]:GetStress()
	if math.random(100) > 50 then
		DrugFX1()
	else
		DrugFX2()
	end
    if stresslevel > 500 then
	   	SetRunSprintMultiplierForPlayer(PlayerId(), 1.08)
	    dstamina = 200
	else
	    SetRunSprintMultiplierForPlayer(PlayerId(), 1.1)
	    dstamina = 200
    end
    
    TriggerEvent("client:newStress",true,math.ceil(5))

    while dstamina > 0 do
        Citizen.Wait(1000)
        RestorePlayerStamina(PlayerId(), 1.0)
        dstamina = dstamina - 1
        if IsPedRagdoll(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(5), math.random(5), 3, 0, 0, 0)
        end

        local armor = GetPedArmour(PlayerPedId())
        SetPedArmour(PlayerPedId(),armor+3)

	  	if math.random(500) < 3 then
	  		if math.random(100) > 50 then
                DrugFX1()
	  		else
                DrugFX2()
	  		end
		  	Citizen.Wait(math.random(30000))
		end
        if math.random(100) > 91 and IsPedRunning(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(1000), math.random(1000), 3, 0, 0, 0)
        end
    end
    dstamina = 0
    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(),1000,1000, 3, 0, 0, 0)
    end
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    --RevertToStressMultiplier()
end)

RegisterNetEvent('hadcrack')
AddEventHandler('hadcrack', function(arg1,arg2,arg3)
    dstamina = 0
    Citizen.Wait(1000)
    local stresslevel = exports["nadrp-hud"]:GetStress()
	if math.random(100) > 50 then
		DrugFX1()
	else
		DrugFX2()
	end

    if stresslevel > 50 then
	   	SetRunSprintMultiplierForPlayer(PlayerId(), 1.25)
	    dstamina = 30
	else
	    SetRunSprintMultiplierForPlayer(PlayerId(), 1.35)
	    dstamina = 30
	end

	TriggerEvent("client:newStress",true,math.ceil(5))

    while dstamina > 0 do

        Citizen.Wait(1000)
        RestorePlayerStamina(PlayerId(), 1.0)
        dstamina = dstamina - 1

        if IsPedRagdoll(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(5), math.random(5), 3, 0, 0, 0)
        end

	  	if math.random(500) < 100 then
            if math.random(100) > 50 then
                DrugFX1()
            else
                DrugFX2()
            end
		  	Citizen.Wait(math.random(30000))
		end

        if math.random(100) > 91 and IsPedRunning(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(1000), math.random(1000), 3, 0, 0, 0)
        end
        
    end

    dstamina = 0

    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(),6000,6000, 3, 0, 0, 0)
    end

    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    --RevertToStressMultiplier()

end)

--//////////////////////////
--      Events
--//////////////////////////

-----------------------
-- Food stuff below --
-----------------------

RegisterNetEvent('RS7x:Drinkwater')
AddEventHandler('RS7x:Drinkwater', function()
    local playerPed = GetPlayerPed(-1)
    --local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
    AnimDict( "friends@frl@ig_1" )

    --if not HasModelLoaded('prop_cs_script_bottle_01') then
    --    LoadPropDict('prop_cs_script_bottle_01')
    --end

    if not IsEntityPlayingAnim(playerPed, "friends@frl@ig_1", "drink_lamar", 3) then
        TaskPlayAnim( GetPlayerPed(-1), "friends@frl@ig_1", "drink_lamar", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    end

    --prop = CreateObject(GetHashKey('prop_cs_script_bottle_01'), x, y, z+0.2,  true,  true, true)
    --AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.13, 0.05, 0.02, -50.0, 16.0, 60.0, true, true, false, true, 1, true)
    exports['t0sic_loadingbar']:StartDelayedFunction('Water 💧', 10000, function()
        --DeleteEntity(prop)
        ClearPedSecondaryTask(playerPed)
    end)
    --SetEntityAsNoLongerNeeded(prop)
end)

RegisterNetEvent('RS7x:EatBread')
AddEventHandler('RS7x:EatBread', function()
    local playerPed = GetPlayerPed(-1)
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
    local prop1 = 'prop_sandwich_01'

    AnimDict( "mp_player_inteat@burger" )

    if not HasModelLoaded(prop1) then
        LoadPropDict(prop1)
    end

    if not IsEntityPlayingAnim(playerPed, "mp_player_inteat@burger", "mp_player_int_eat_burger", 3) then
        TaskPlayAnim( GetPlayerPed(-1), "mp_player_inteat@burger", "mp_player_int_eat_burger", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    end

    prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.13, 0.05, 0.02, -50.0, 16.0, 60.0, true, true, false, true, 1, true)
    exports['t0sic_loadingbar']:StartDelayedFunction('Sandwich 🥪', 7000, function()
        DeleteObject(prop)
        ClearPedTasks(playerPed)
        TriggerEvent('status:setState', 25, 500)
        SetEntityAsNoLongerNeeded(prop)
    end)
end)

RegisterNetEvent('RS7x:DrinkVodka')
AddEventHandler('RS7x:DrinkVodka', function()
    local playerPed = GetPlayerPed(-1)
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
    local prop1 = 'prop_vodka_bottle'

    AnimDict( "amb@world_human_drinking@coffee@male@idle_a" )

    if not HasModelLoaded(prop1) then
        LoadPropDict(prop1)
    end

    if not IsEntityPlayingAnim(playerPed, "amb@world_human_drinking@coffee@male@idle_a", "idle_c", 3) then
        TaskPlayAnim(playerPed, "amb@world_human_drinking@coffee@male@idle_a", "idle_c", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    end

    prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 6286),  0.02, -0.20, -0.22, 50.0, 16.0, -175.0, true, true, false, true, 1, true)
    exports['t0sic_loadingbar']:StartDelayedFunction('Vodka 🍾', 5000, function()
        DeleteObject(prop)
        ClearPedTasks(playerPed)
        TriggerEvent('status:setState', 8, 800)
        SetEntityAsNoLongerNeeded(prop)
    end)
end)

RegisterNetEvent('RS7x:DrinkBeer')
AddEventHandler('RS7x:DrinkBeer', function()
    local playerPed = GetPlayerPed(-1)
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
    local prop1 = 'prop_amb_beer_bottle'

    AnimDict( "amb@world_human_drinking@coffee@male@idle_a" )

    if not HasModelLoaded(prop1) then
        LoadPropDict(prop1)
    end

    if not IsEntityPlayingAnim(playerPed, "amb@world_human_drinking@coffee@male@idle_a", "idle_c", 3) then
        TaskPlayAnim(playerPed, "amb@world_human_drinking@coffee@male@idle_a", "idle_c", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    end

    prop = CreateObject(GetHashKey(prop1), x, y, z,  true,  true, true)
    AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422),  0, 0, 0, 0, 0, 0, true, true, false, true, 1, true)
    exports['t0sic_loadingbar']:StartDelayedFunction('Beer 🍺', 5000, function()
        DeleteObject(prop)
        ClearPedTasks(playerPed)
        TriggerEvent('status:setState', 8, 600)
        SetEntityAsNoLongerNeeded(prop)
    end)
end)

RegisterNetEvent('RS7x:DrinkCoffee')
AddEventHandler('RS7x:DrinkCoffee', function()
    local playerPed = GetPlayerPed(-1)
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
    local prop1 = 'p_ing_coffeecup_02'

    AnimDict( "amb@world_human_aa_coffee@idle_a" )

    if not HasModelLoaded(prop1) then
        LoadPropDict(prop1)
    end

    if not IsEntityPlayingAnim(playerPed, "amb@world_human_aa_coffee@idle_a", "idle_a", 3) then
        TaskPlayAnim(playerPed, "amb@world_human_aa_coffee@idle_a", "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    end

    prop = CreateObject(GetHashKey(prop1), x, y, z,  true,  true, true)
    AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 6286),  0.07, 0.00, -0.05, 50.0, 96.0, -175.0, true, true, false, true, 1, true)
    exports['t0sic_loadingbar']:StartDelayedFunction(' Coffee ☕', 5000, function()
        DeleteObject(prop)
        ClearPedTasks(playerPed)
        SetEntityAsNoLongerNeeded(prop)
    end)
end)

RegisterNetEvent('RS7x:EatDonut')
AddEventHandler('RS7x:EatDonut', function()
    local playerPed = GetPlayerPed(-1)
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
    local prop1 = 'prop_amb_donut'

    AnimDict( "mp_player_inteat@burger" )

    if not HasModelLoaded(prop1) then
        LoadPropDict(prop1)
    end

    if not IsEntityPlayingAnim(playerPed, "mp_player_inteat@burger", "mp_player_int_eat_burger", 3) then
        TaskPlayAnim(playerPed, "mp_player_inteat@burger", "mp_player_int_eat_burger", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    end

    prop = CreateObject(GetHashKey(prop1), x, y, z,  true,  true, true)
    AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905),  0.13, 0.05, 0.02, -50.0, 16.0, 60.0, true, true, false, true, 1, true)
    exports['t0sic_loadingbar']:StartDelayedFunction('Donut 🍩', 5000, function()
        DeleteEntity(prop)
        ClearPedTasks(playerPed)
        TriggerEvent('status:setState', 25, 500)
        SetEntityAsNoLongerNeeded(prop)
    end)
end)

------------------------
-- End of food stuff ---
------------------------

--[[RegisterNetEvent('RS7x:showid')
AddEventHandler('RS7x:showid', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 5.0 then
        TriggerServerEvent('RS7x:showid_sv', GetPlayerServerId(closestPlayer))
    end
    ESX.TriggerServerCallback('RS7x:ident', function(fuck)
        if fuck ~= nil then
            firstname = fuck.firstname .. ', ' .. fuck.lastname
            dob = fuck.dateofbirth
            job = fuck.job
            sex = fuck.sex
            TriggerEvent('chat:addMessage', {
                template = '<div class="chat-message nonemergency">ID Card   <br> NAME : {0}  <br> DOB : {1}  <br> JOB : {2}  <br> SEX : {3} </div>',
                args = {firstname, dob, job, sex}
            })
        else
            --exports['mythic_notify']:DoLongHudText('error', 'Alien?')
            print('Alien?')
        end
    end)
end)]]

RegisterNetEvent('RS7x:showid')
AddEventHandler('RS7x:showid', function(data)
    cunt = json.decode(data)

    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 5.0 then
        TriggerServerEvent('RS7x:showid_sv', cunt, GetPlayerServerId(closestPlayer))
    end
    if cunt ~= nil then
        name = cunt.Name
        dob = cunt.dateofbirth
        job = firstToUpper(cunt.job)
        sex = cunt.sex
        cid = cunt.cid
        if sex == 'M' then
            sex = 'Male'
        else
            sex = 'Female'
        end
        TriggerEvent('chat:addMessage', {
            template = '<div class="chat-message nonemergency">Citizen Card | Name : {0} | DOB : {1} | Job : {2}  | Sex : {3} | CitizenID (CID) : {4} </div>',
            args = {name, dob, job, sex, cid}
        })
    else
        print('Alien?')
    end
end)

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

--// Functions //--

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z + 0.2)
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

function AnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

function LoadPropDict(model)
    while not HasModelLoaded(GetHashKey(model)) do
        RequestModel(GetHashKey(model))
        Wait(10)
    end
end

function OpenIdMenu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_license',{
        title = 'Buy a id-card ?',
        elements = {
          { label = 'yes' ..' ($' .. 500 ..')', value = 'yes' },
          { label = 'no', value = 'no' },
        }
      },
      function (data, menu)
        if data.current.value == 'yes' then
            TriggerServerEvent('RS7x:canBuyID')
        end
        menu.close()
    end,
    function (data, menu)
        menu.close()
    end)
end

function DrugFX1()
	StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
	Citizen.Wait(8000)
	StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
	Citizen.Wait(8000)
	StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
	StopScreenEffect("DrugsMichaelAliensFightIn")
	StopScreenEffect("DrugsMichaelAliensFight")
	StopScreenEffect("DrugsMichaelAliensFightOut")
end

function DrugFX2()
	StartScreenEffect("DrugsTrevorClownsFightIn", 3.0, 0)
	Citizen.Wait(8000)
	StartScreenEffect("DrugsTrevorClownsFight", 3.0, 0)
	Citizen.Wait(8000)
	StartScreenEffect("DrugsTrevorClownsFightOut", 3.0, 0)
	StopScreenEffect("DrugsTrevorClownsFight")
	StopScreenEffect("DrugsTrevorClownsFightIn")
	StopScreenEffect("DrugsTrevorClownsFightOut")
end


--[[Citizen.CreateThread(function() -- Test animations
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0,38) then
            TriggerEvent('RS7x:AnimTest')
        end
    end
end)]]

--[[RegisterNetEvent('RS7x:AnimTest')
AddEventHandler('RS7x:AnimTest', function()
    local playerPed = GetPlayerPed(-1)
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
    local prop1 = 'prop_amb_donut'

    AnimDict( "mp_player_inteat@burger" )

    if not HasModelLoaded(prop1) then
        LoadPropDict(prop1)
    end

    if not IsEntityPlayingAnim(playerPed, "mp_player_inteat@burger", "mp_player_int_eat_burger", 3) then
        TaskPlayAnim(playerPed, "mp_player_inteat@burger", "mp_player_int_eat_burger", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    end

    prop = CreateObject(GetHashKey(prop1), x, y, z,  true,  true, true)
    AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905),  0.13, 0.05, 0.02, -50.0, 16.0, 60.0, true, true, false, true, 1, true)
    exports['t0sic_loadingbar']:StartDelayedFunction('Donut 🍩', 5000, function()
        DeleteEntity(prop)
        ClearPedTasks(playerPed)
    end)
    SetEntityAsNoLongerNeeded(prop1)
end)]]



----BINOCULARS


local fov_max = 70.0
local fov_min = 2.0 -- max zoom level (smaller fov is more zoom)
local zoomspeed = 10.0 -- camera zoom speed
local speed_lr = 8.0 -- speed by which the camera pans left-right
local speed_ud = 8.0 -- speed by which the camera pans up-down

local binoculars = false
local fov = (fov_max+fov_min)*0.5

local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local keybindEnabled = false -- When enabled, binocular are available by keybind
local binocularKey = Keys["F9"]
local storeBinoclarKey = Keys["BACKSPACE"]

--THREADS--

Citizen.CreateThread(function()
    while true do

        Citizen.Wait(1500)

        local lPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(lPed)

        if binoculars then
            binoculars = true
            if not ( IsPedSittingInAnyVehicle( lPed ) ) then
                Citizen.CreateThread(function()
                    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_BINOCULARS", 0, 1)
                    PlayAmbientSpeech1(PlayerPedId(), "GENERIC_CURSE_MED", "SPEECH_PARAMS_FORCE")
                end)
            end

            Wait(2000)

            SetTimecycleModifier("default")


            SetTimecycleModifierStrength(0.3)

            local scaleform = RequestScaleformMovie("BINOCULARS")

            while not HasScaleformMovieLoaded(scaleform) do
                Citizen.Wait(10)
            end

            local lPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(lPed)
            local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)

            AttachCamToEntity(cam, lPed, 0.0,0.0,1.0, true)
            SetCamRot(cam, 0.0,0.0,GetEntityHeading(lPed))
            SetCamFov(cam, fov)
            RenderScriptCams(true, false, 0, 1, 0)
            PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
            PushScaleformMovieFunctionParameterInt(0) -- 0 for nothing, 1 for LSPD logo
            PopScaleformMovieFunctionVoid()

            while binoculars and not IsEntityDead(lPed) and (GetVehiclePedIsIn(lPed) == vehicle) and IsPedUsingScenario(PlayerPedId(), "WORLD_HUMAN_BINOCULARS") and true do
                TriggerEvent("disabledWeapons",true)
                if IsControlJustPressed(0, storeBinoclarKey) then -- Toggle binoculars
                    PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                    ClearPedTasks(PlayerPedId())
                    binoculars = false
                end

                local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
                CheckInputRotation(cam, zoomvalue)

                HandleZoom(cam)
                HideHUDThisFrame()

                DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
                Citizen.Wait(1)
            end

            TriggerEvent("disabledWeapons",false)
            binoculars = false
            ClearTimecycleModifier()
            fov = (fov_max+fov_min)*0.5
            RenderScriptCams(false, false, 0, 1, 0)
            SetScaleformMovieAsNoLongerNeeded(scaleform)
            DestroyCam(cam, false)
            SetNightvision(false)
            SetSeethrough(false)
        end
    end
end)

--EVENTS--

-- Activate binoculars
RegisterNetEvent('binoculars:Activate2')
AddEventHandler('binoculars:Activate2', function()

    binoculars = not binoculars
    if not binoculars then
        TriggerEvent("animation:c")
    end
end)

--FUNCTIONS--
function HideHUDThisFrame()
    HideHelpTextThisFrame()
    HideHudAndRadarThisFrame()
    HideHudComponentThisFrame(1) -- Wanted Stars
    HideHudComponentThisFrame(2) -- Weapon icon
    HideHudComponentThisFrame(3) -- Cash
    HideHudComponentThisFrame(4) -- MP CASH
    HideHudComponentThisFrame(6)
    HideHudComponentThisFrame(7)
    HideHudComponentThisFrame(8)
    HideHudComponentThisFrame(9)
    HideHudComponentThisFrame(13) -- Cash Change
    HideHudComponentThisFrame(11) -- Floating Help Text
    HideHudComponentThisFrame(12) -- more floating help text
    HideHudComponentThisFrame(15) -- Subtitle Text
    HideHudComponentThisFrame(18) -- Game Stream
    HideHudComponentThisFrame(19) -- weapon wheel
end

function CheckInputRotation(cam, zoomvalue)
    local rightAxisX = GetDisabledControlNormal(0, 220)
    local rightAxisY = GetDisabledControlNormal(0, 221)
    local rotation = GetCamRot(cam, 2)
    if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
        new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
        new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5)
        SetCamRot(cam, new_x, 0.0, new_z, 2)
        SetEntityHeading(PlayerPedId(),new_z)
    end
end

function HandleZoom(cam)
    local lPed = PlayerPedId()
    if not ( IsPedSittingInAnyVehicle( lPed ) ) then

        if IsControlJustPressed(0,241) then -- Scrollup
            fov = math.max(fov - zoomspeed, fov_min)
        end
        if IsControlJustPressed(0,242) then
            fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown
        end
        local current_fov = GetCamFov(cam)
        if math.abs(fov-current_fov) < 0.1 then
            fov = current_fov
        end
        SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
    else
        if IsControlJustPressed(0,17) then -- Scrollup
            fov = math.max(fov - zoomspeed, fov_min)
        end
        if IsControlJustPressed(0,16) then
            fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown
        end
        local current_fov = GetCamFov(cam)
        if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
            fov = current_fov
        end
        SetCamFov(cam, current_fov + (fov - current_fov)*0.05) -- Smoothing of camera zoom
    end
end

-----BLIPS
local blips = {
    -- Example {title="", colour=, id=, x=, y=, z=},
    {title=" Hospital", colour=5, id=61, x = -1875.394, y = -318.236, z = 50.189},
    {title="Life Invader", colour=30, id=351, x=-1081.8293457031, y=-248.12872314453, z=37.763294219971},
    {title="Bennys", colour=1, id=72, x=-207.85, y=-1318.53, z=30.89},
    {title="Mission Row PD", colour=3, id=60, x=437.45, y=-981.8, z=30.7},
    {title="Kipling Towing", colour=47, id=446, x = -1423.831, y = -447.143, z = 35.9},
    {title="Bait Shop", colour=5, id=317, x=-1600.685, y=5204.332, z=4.31},
    {title="Tools R Us", colour=1, id=154, x=1692.54, y=3758.13, z=34.71},
    {title="Davis PD", colour=3, id=60, x=382.541, y=-1621.954, z=29.292},
    {title="Bean Machine", colour=16, id=536, x=-623.751, y=237.417, z=81.882},
    {title="Burger Shot", colour=56, id=536, x = -1197.913, y = -895.975, z = 13.995},
    

    
}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.7)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		id = PlayerId()
		DisablePlayerVehicleRewards(id)	
	end
end)