ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)



thecount = 0
isCop = false
isEMS = false
ragdol = 1
imDead = 0
inwater = false

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

Citizen.CreateThread(function()
    imDead = 0
    ragdol = 0
    while true do
        Wait(100)
        if IsEntityDead(PlayerPedId()) then 
            Wait(1000)
            SetEntityInvincible(PlayerPedId(), true)
            SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))

            plyPos = GetEntityCoords(PlayerPedId())

            if imDead == 0 then
                imDead = 1
                deathTimer()
            end
        end
    end
end)

RegisterNetEvent('doTimer')
AddEventHandler('doTimer', function()
    TriggerEvent('pd:deathcheck')
    timer2 = 5
    while imDead == 1 do
        Citizen.Wait(0)
        if thecount > 0 then
            drawTxt(0.89, 1.44, 1.0,1.0,0.6, "Respawn: ~r~" .. math.ceil(thecount) .. "~w~ seconds remaining", 255, 255, 255, 255)
        else
            drawTxt(0.89, 1.44, 1.0,1.0,0.6, "~w~ HOLD ~r~E ~w~(~r~" ..timer2.."~w~)TO ~r~RESPAWN ~w~OR WAIT FOR A ~r~MEDIC", 255, 255, 255, 255)
        end
    end
    TriggerEvent('pd:deathcheck')
end)

dragged = false
RegisterNetEvent('deathdrop')
AddEventHandler('deathdrop', function(beingDragged)
    dragged = beingDragged
    if beingDragged and imDead == 1 then
        --TriggerEvent('resurrect:relationships')
    end
    if not beingDragged and imDead == 1 then
        SetEntityHealth(PlayerPedId(), 200.0)
        SetEntityCoords( PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.5, 0.5) )
    end
end)

RegisterNetEvent('resurrect:relationships')
AddEventHandler('resurrect:relationships', function()
    local plyPos = GetEntityCoords(PlayerPedId(),  true)
    NetworkResurrectLocalPlayer(plyPos, true, true, false)
    resetrelations()
end)

RegisterNetEvent('ressurection:relationships:norevive')
AddEventHandler('ressurection:relationships:norevive', function()
    resetrelations()
end)

deathanims = {
    [1] = "dead_a",
}

myanim = "dead_a"

function InVeh()
  local ply = PlayerPedId()
  --local intrunk = exports["nadrp-ped"]:isPed("intrunk")
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

function resetrelations()
    Citizen.Wait(1000)
    if isCop or isEMS then
        SetPedRelationshipGroupDefaultHash(PlayerPedId(),GetHashKey('MISSION2'))
        SetPedRelationshipGroupHash(PlayerPedId(),GetHashKey('MISSION2'))
    else
        SetPedRelationshipGroupDefaultHash(PlayerPedId(),GetHashKey('PLAYER'))
        SetPedRelationshipGroupHash(PlayerPedId(),GetHashKey('PLAYER'))
    end
    TriggerEvent("gangs:setDefaultRelations")
end

local disablingloop = false

RegisterNetEvent('disableAllActions')
AddEventHandler('disableAllActions', function()
    if not disablingloop then
        myanim = deathanims[math.random(1,8)]
        disablingloop = true
        Citizen.Wait(100)
        while GetEntitySpeed(PlayerPedId()) > 0.5 do
            Citizen.Wait(1)
        end 
        Citizen.Wait(100)
        TriggerEvent("resurrect:relationships")
        TriggerEvent("nadrp-death:doAnim")
        TriggerEvent("disableAllActions2")
        local inveh = 0
        while imDead == 1 do
            if IsEntityInWater(PlayerPedId()) then
                inwater = true
            else
                inwater = false
            end
            SetEntityInvincible(PlayerPedId(), true)
            Citizen.Wait(1) 
            if InVeh() then
                if not inveh then
                    inveh = true
                end
                local intrunk = exports["nadrp-ped"]:isPed("intrunk")
                if not intrunk then
                    deadcaranim()
                end
            elseif not InVeh() and inveh and GetEntityHeightAboveGround(PlayerPedId()) < 2.0 or inveh == 0 and GetEntityHeightAboveGround(PlayerPedId()) < 2.0 then
                inveh = false
                TriggerEvent("nadrp-death:doAnim")
            elseif not InVeh() then
                if (GetEntitySpeed(PlayerPedId()) > 0.3  and not inwater) or (not IsEntityPlayingAnim(PlayerPedId(), "dead", myanim, 1) and not inwater) then
                    TriggerEvent("nadrp-death:doAnim")
                elseif (not IsEntityPlayingAnim(PlayerPedId(), "dam_ko", "drown", 1) and inwater) then
                    TriggerEvent("nadrp-death:doAnim")
                end
            end

        end
        SetEntityInvincible(PlayerPedId(), false)
        disablingloop = false
    end
end)

RegisterNetEvent('disableAllActions2')
AddEventHandler('disableAllActions2', function()
    while imDead == 1 do

        Citizen.Wait(1)

        DisableInputGroup(0)
        DisableInputGroup(1)
        DisableInputGroup(2)
        DisableControlAction(1, 19, true)
        DisableControlAction(0, 34, true)
        DisableControlAction(0, 9, true)

        DisableControlAction(0, 32, true)
        DisableControlAction(0, 8, true)
        DisableControlAction(2, 31, true)
        DisableControlAction(2, 32, true)
        DisableControlAction(1, 33, true)
        DisableControlAction(1, 34, true)
        DisableControlAction(1, 35, true)
        DisableControlAction(1, 21, true)  -- space
        DisableControlAction(1, 22, true)  -- space
        DisableControlAction(1, 23, true)  -- F
        DisableControlAction(1, 24, true)  -- F
        DisableControlAction(1, 25, true)  -- F
        DisableControlAction(0, 137, true)
        if IsControlJustPressed(1,29) then
            SetPedToRagdoll(PlayerPedId(), 26000, 26000, 3, 0, 0, 0) 
            Citizen.Wait(22000)
            TriggerEvent("nadrp-death:doAnim")
        end

        DisableControlAction(1, 106, true) -- VehicleMouseControlOverride
        DisableControlAction(1, 140, true) --Disables Melee Actions
        DisableControlAction(1, 141, true) --Disables Melee Actions
        DisableControlAction(1, 142, true) --Disables Melee Actions 
        DisableControlAction(1, 37, true) --Disables INPUT_SELECT_WEAPON (tab) Actions
        DisablePlayerFiring(PlayerPedId(), true) -- Disable weapon firing
        EnableControlAction(0, 166, true)
        --SetPedCanRagdoll(PlayerPedId(), false)
    end
end)

local tryingAnim = false
local enteringveh = false
RegisterNetEvent('respawn:sleepanims')
AddEventHandler('respawn:sleepanims', function()
    if not enteringveh then
        enteringveh = true
        ClearPedTasksImmediately(PlayerPedId())
        Citizen.Wait(1000)
        enteringveh = false
    end
end)

function deadcaranim()
   loadAnimDict( "veh@low@front_ps@idle_duck" ) 
   TaskPlayAnim(PlayerPedId(), "veh@low@front_ps@idle_duck", "sit", 8.0, -8, -1, 1, 0, 0, 0, 0)
end

myanim = deathanims[math.random(1,8)]

RegisterNetEvent('nadrp-death:doAnim')
AddEventHandler('nadrp-death:doAnim', function()
    if not dragged and not tryingAnim and not enteringveh and not InVeh() and imDead == 1 then
        tryingAnim = true
        while GetEntitySpeed(PlayerPedId()) > 0.5 and not inwater do
            Citizen.Wait(1)
        end
        if inwater then
            SetEntityCoords(GetEntityCoords(PlayerPedId()))
            SetPedToRagdoll(PlayerPedId(), 26000, 26000, 3, 0, 0, 0)
        elseif not IsEntityPlayingAnim(PlayerPedId(), "dead", "dead_a", 3) then
            loadAnimDict( "dead" )
            SetEntityCoords(PlayerPedId(),GetEntityCoords(PlayerPedId()))
            ClearPedTasksImmediately(PlayerPedId())
            TaskPlayAnim(PlayerPedId(), "dead", "dead_a", 1.0, 1.0, -1, 1, 0, 0, 0, 0)
        end
        Citizen.Wait(3000)
        tryingAnim = false
    end
end)

function deathTimer()
    TriggerEvent("tac-dispatch:downplayer")
    thecount = 300
    TriggerEvent("doTimer")
    TriggerEvent("disableAllActions")
    while imDead == 1 do

        Citizen.Wait(100)
        thecount = thecount - 0.1

        if thecount == 60 or thecount == 180 or thecount == 240 then
            TriggerEvent("tac-dispatch:downplayer")
        end

        SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
        while thecount < 0 do
            Citizen.Wait(1)

            while IsControlPressed(1,38) do
                Citizen.Wait(1000)
                timer2 = timer2 - 1
                if timer2 == 0 then
                    thecount = 99999999
                    releaseBody()
                end
            end
            if timer2 < 5 and not IsControlPressed(0,38) then
                timer2 = 5
            end
        end
    end
end

local restblip = AddBlipForCoord(2438.3266601563,4960.3046875,47.27229309082)
SetBlipAsFriendly(restblip, true)
SetBlipSprite(restblip, 84)
SetBlipColour(restblip, 68)
SetBlipAsShortRange(restblip,true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString(tostring("The Rest House"))
EndTextCommandSetBlipName(restblip)

RegisterNetEvent('nadrp-death:cpr')
AddEventHandler('nadrp-death:cpr', function()
    curDist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), 0), 2438.3266601563,4960.3046875,47.27229309082,true)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if curDist < 3.0 then
        if tonumber(closestPlayer) ~= tonumber(PlayerPedId()) then
            if closestDistance < 3.0 then
                local finished = exports['nadrp-skillbar']:taskBar(4000,math.random(5,15))
                if finished ~= 100 then
                    exports["mythic_notify"]:SendAlert('error', 'Failed...')
                else
                    local finished2 = exports['nadrp-skillbar']:taskBar(3000,math.random(5,15))
                    if finished2 ~= 100 then
                        exports["mythic_notify"]:SendAlert('error', 'Failed...')
                    else
                        local finished3 = exports['nadrp-skillbar']:taskBar(2000,math.random(5,15))
                        if finished3 ~= 100 then
                            exports["mythic_notify"]:SendAlert('error', 'Failed...')
                        else
                            local finished4 = exports['nadrp-skillbar']:taskBar(1500,math.random(5,15))
                            if finished4 ~= 100 then
                                exports["mythic_notify"]:SendAlert('error', 'Failed...')
                            else
                                exports["mythic_notify"]:SendAlert('inform', 'Success')
                                TriggerServerEvent("nadrp-death:cpr", GetPlayerServerId(closestPlayer))
                            end
                        end
                    end
                end
            else
                exports['mythic_notify']:SendAlert('inform', 'No Player Found')
            end
        end
    else
        exports['mythic_notify']:SendAlert('inform', 'You are not near the rest house')
    end
end)

RegisterNetEvent('nadrp-death:revive')
AddEventHandler('nadrp-death:revive', function()
    attemptRevive()
end)

function releaseBody()
    thecount = 240
    imDead = 0
    ragdol = 1
    ClearPedTasksImmediately(PlayerPedId())
    DoScreenFadeOut(500)
    Citizen.Wait(1000)
    TriggerServerEvent('mythic_hospital:server:RequestBed')
    TriggerServerEvent('nadrp-death:RemoveItems', 1)
    TriggerEvent('nadrp-death:revive')
    Citizen.Wait(1000)
    DoScreenFadeIn(500)
    Citizen.Wait(1000)
    exports['mythic_notify']:SendAlert('inform', 'You woke up in hospital and can\'t seem to remember what happened')
    FreezeEntityPosition(PlayerPedId(), false)
    SetEntityInvincible(PlayerPedId(), false)
    ClearPedBloodDamage(PlayerPedId())
    TriggerEvent("resurrect:relationships")
end

function attemptRevive(hospital)
    if imDead == 1 then
        ragdol = 1
        imDead = 0
        thecount = 240
        TriggerEvent("Heal")
        SetEntityInvincible(PlayerPedId(), false)
        ClearPedBloodDamage(PlayerPedId())
        TriggerEvent("resurrect:relationships")
        ClearPedTasksImmediately(PlayerPedId())
        Citizen.Wait(500)
        getup()
    end
end

function getup()
    ClearPedSecondaryTask(PlayerPedId())
    loadAnimDict( "random@crash_rescue@help_victim_up" )
    TaskPlayAnim( PlayerPedId(), "random@crash_rescue@help_victim_up", "helping_victim_to_feet_victim", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    SetCurrentPedWeapon(PlayerPedId(),2725352035,true)
    Citizen.Wait(3000)
    endanimation()
end

function endanimation()
    ClearPedSecondaryTask(PlayerPedId())
end

function loadAnimDict( dict )
    RequestAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        Citizen.Wait( 1 )
    end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		if IsPedBeingStunned(PlayerPedId()) then
		    ragdol = 1
		end
	end
end)

RegisterNetEvent("nadrp-death:heal")
AddEventHandler("nadrp-death:heal", function()
	local ped = PlayerPedId()
	if DoesEntityExist(ped) and not IsEntityDead(ped) then
		SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
		ragdol = 0
	end
end)


function GetDeath()
    if imDead == 1 then
        return true
    elseif not imDead == 0 then
        return false
    end
end

RegisterCommand('trycpr', function(source, args, raw)
    TriggerEvent('nadrp-death:cpr')
end, false)