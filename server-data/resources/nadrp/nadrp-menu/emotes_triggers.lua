AnimSet = "default";

RegisterNetEvent('AnimSet:default');
AddEventHandler('AnimSet:default', function()
    ResetPedMovementClipset(PlayerPedId(), 0)
    AnimSet = "default";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)


--// POLICE/EMS --//

function AnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(1)
    end
end

RegisterNetEvent('search:person')
AddEventHandler('search:person', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 2.0 then
       exports['esx_policejob']:OpenBodySearchMenu(closestPlayer)
    else
        exports['mythic_notify']:DoLongHudText('error', 'No Player Found')
    end
end)

RegisterNetEvent('escort:person')
AddEventHandler('escort:person', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local handcuff = exports['nadrp-ped']:isPed('handcuffed')
    if closestPlayer ~= -1 and closestDistance <= 2.0 then
        if not handcuffed then 
            TriggerServerEvent('nadrp-policejob:drag', GetPlayerServerId(closestPlayer))
        else
            exports['mythic_notify']:DoLongHudText('error', 'How do you expect to escort while cuffed ?')
        end
    else
        exports['mythic_notify']:DoLongHudText('error', 'No Player Found')
    end
end)

RegisterNetEvent('seat:person')
AddEventHandler('seat:person', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 2.0 then
        TriggerServerEvent('nadrp-policejob:putInVehicle', GetPlayerServerId(closestPlayer))
    else
        exports['mythic_notify']:DoLongHudText('error', 'No Player Found')
    end
end)

RegisterNetEvent('unseat:person')
AddEventHandler('unseat:person', function()
    --local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    --if closestPlayer ~= -1 and closestDistance <= 2.0 then
    --    TriggerServerEvent('nadrp-policejob:OutVehicle', GetPlayerServerId(closestPlayer))
    --else
    --    exports['mythic_notify']:DoLongHudText('error', 'No Player Found')
    --end
    TriggerEvent('unseatPlayer')
end)

RegisterNetEvent('police:OpenMDT')
AddEventHandler('police:OpenMDT', function()
    TriggerServerEvent("mdt:hotKeyOpen")
end)

RegisterNetEvent('police:impound')
AddEventHandler('police:impound', function()
    local vehicle = ESX.Game.GetVehicleInDirection()
    if DoesEntityExist(vehicle) then
        exports["t0sic_loadingbar"]:StartDelayedFunction("Impounding Vehicle", 5000, function()
            exports['esx_policejob']:ImpoundVehicle(vehicle)
        end)
    else
        exports['mythic_notify']:DoLongHudText('error', 'No Vehicle Found')
    end
end)

RegisterNetEvent('police:checkid')
AddEventHandler('police:checkid', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 2.0 then
        exports['esx_policejob']:OpenIdentityCardMenu(closestPlayer)
    else
        exports['mythic_notify']:DoLongHudText('error', 'No Player Found')
    end
end)





RegisterNetEvent('police:panicB')
AddEventHandler('police:panicB', function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
    streetName = GetStreetNameFromHashKey(streetName)
    local job = 'police'
    local coords = GetEntityCoords(GetPlayerPed(-1))
    TriggerServerEvent('tac_outlawalert:officerDown_B', coords, streetName)
end)

RegisterNetEvent('police:revive')
AddEventHandler('police:revive', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 2.0 then
        TriggerServerEvent('die:cunt', GetPlayerServerId(closestPlayer))
    else
        exports['mythic_notify']:DoLongHudText('error', 'No Player Found')
    end
end)

RegisterNetEvent('police:cuff')
AddEventHandler('police:cuff', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local playerheading = GetEntityHeading(GetPlayerPed(-1))
    local playerlocation = GetEntityForwardVector(PlayerPedId())
    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
    local target_id = GetPlayerServerId(closestPlayer)
    local sonic = GetEntitySpeed(closestPlayer)
    if sonic < 5.0 then
        if closestPlayer ~= -1 and closestDistance <= 2.0 then
            exports['mythic_notify']:DoHudText('inform', 'Hardcuffed Person!')
            TriggerServerEvent('nadrp-policejob:requesthard', target_id, playerheading, playerCoords, playerlocation)
            Citizen.Wait(1500)
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3, 'handcuff', 0.4)
        else
            exports['mythic_notify']:DoLongHudText('error', 'No Player Found')
        end
    else
        exports['mythic_notify']:DoLongHudText('Really trying to cuff someone while they are running?')
    end
end)

RegisterNetEvent('nadrp-policejob:uncuff')
AddEventHandler('nadrp-policejob:uncuff', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local playerheading = GetEntityHeading(GetPlayerPed(-1))
    local playerlocation = GetEntityForwardVector(PlayerPedId())
    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
    local target_id = GetPlayerServerId(closestPlayer)
    if closestPlayer ~= -1 and closestDistance <= 2.0 then
        exports['mythic_notify']:DoHudText('inform', 'Uncuffed Person!')
        TriggerServerEvent('nadrp-policejob:requestrelease', target_id, playerheading, playerCoords, playerlocation)
        Citizen.Wait(1200)
        --TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3, 'uncuff', 0.5)
    else
        exports['mythic_notify']:DoLongHudText('error', 'No Player Found')
    end
end)

RegisterNetEvent('nadrp-policejob:softcuff')
AddEventHandler('nadrp-policejob:softcuff', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local playerheading = GetEntityHeading(GetPlayerPed(-1))
    local playerlocation = GetEntityForwardVector(PlayerPedId())
    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
    local target_id = GetPlayerServerId(closestPlayer)
    local sonic = GetEntitySpeed(closestPlayer)
    if sonic < 5.0 then
        if closestPlayer ~= -1 and closestDistance <= 2.0 then
            exports['mythic_notify']:DoHudText('inform', 'Softcuffed Person!')
            TriggerServerEvent('nadrp-policejob:requestarrest', false,target_id,playerheading, playerCoords, playerlocation)
            Citizen.Wait(1500)
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3, 'handcuff', 0.4)
        else
            exports['mythic_notify']:DoLongHudText('error', 'No Player Found')
        end
    else
        exports['mythic_notify']:DoLongHudText('Really trying to cuff someone while they are running?')
    end
end)

RegisterNetEvent('police:gsr')
AddEventHandler('police:gsr', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 2.0 then
        TriggerServerEvent('rad:test', GetPlayerServerId(closestPlayer))
    else
        exports['mythic_notify']:DoLongHudText('error', 'No Player Found')
    end
end)

--//            EMS         // --

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
      RequestAnimDict(dict)
      Citizen.Wait(1)
    end
end

function KneelMedic()
    local player = GetPlayerPed( -1 )
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( "amb@medic@standing@tendtodead@enter" )
        loadAnimDict( "amb@medic@standing@timeofdeath@enter" )
        loadAnimDict( "amb@medic@standing@tendtodead@idle_a" )
        loadAnimDict( "random@crash_rescue@help_victim_up" )

        TaskPlayAnim( player, "amb@medic@standing@tendtodead@enter", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
        Wait (1000)
        TaskPlayAnim( player, "amb@medic@standing@tendtodead@idle_a", "idle_b", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
        Wait (3000)
        TaskPlayAnim( player, "amb@medic@standing@tendtodead@exit", "exit_flee", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
        Wait (1000)
        TaskPlayAnim( player, "amb@medic@standing@timeofdeath@enter", "enter", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )  
        Wait (500)
        TaskPlayAnim( player, "amb@medic@standing@timeofdeath@enter", "helping_victim_to_feet_player", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )  
    end
end

RegisterNetEvent('nadrp-ems:revive')
AddEventHandler('nadrp-ems:revive', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer ~= -1 and closestDistance <= 2.0 then
        KneelMedic()
        TriggerServerEvent('die:cunt', GetPlayerServerId(closestPlayer))
    else
        exports['mythic_notify']:DoLongHudText('error', 'No Player Found')
    end
end)

RegisterNetEvent('nadrp-ems:heal')
AddEventHandler('nadrp-ems:heal', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer ~= -1 and closestDistance <= 2.0 then
        AnimDict( "weapons@first_person@aim_rng@generic@projectile@thermal_charge@" )

        if not IsEntityPlayingAnim(GetPlayerPed(-1), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 3) then
            TaskPlayAnim( GetPlayerPed(-1), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
            TriggerServerEvent('nadrp-death:healplayer', GetPlayerServerId(closestPlayer), 'small')
            Citizen.Wait(2000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
        end
    else
        exports['mythic_notify']:DoLongHudText('error', 'No Player Found')
    end
end)


RegisterNetEvent('nadrp-ems:bigheal')
AddEventHandler('nadrp-ems:bigheal', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer ~= -1 and closestDistance <= 2.0 then

        AnimDict( "weapons@first_person@aim_rng@generic@projectile@thermal_charge@" )

        if not IsEntityPlayingAnim(GetPlayerPed(-1), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 3) then
            TaskPlayAnim( GetPlayerPed(-1), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
            TriggerServerEvent('nadrp-death:healplayer', GetPlayerFromServerId(closestPlayer), 'big')
            Citizen.Wait(2000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
        end
    else
        exports['mythic_notify']:DoLongHudText('error', 'No Player Found')
    end
end)

--//          END EMS       // --

-----------------------------------

--//           NEWS         // --

RegisterNetEvent('camera:setCamera')
AddEventHandler('camera:setCamera', function()
    TriggerServerEvent('Toggle:cam')
end)

RegisterNetEvent('camera:setMic')
AddEventHandler('camera:setMic', function()
    TriggerServerEvent('Toggle:mic')
end)

RegisterNetEvent('camera:setBoom')
AddEventHandler('camera:setBoom', function()
    TriggerServerEvent('Toggle:bmic')
end)

--//        END OF EMS     //--

----------------------------------

--//          GENERAL     //-- 

RegisterNetEvent('general:ExamineSelf')
AddEventHandler('general:ExamineSelf', function()
    TriggerEvent('RS7x:CheckState')
end)

RegisterNetEvent('general:ExamineTarget')
AddEventHandler('general:ExamineTarget', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 2.0 then
        TriggerServerEvent('RS7x:CheckTstate',GetPlayerServerId(closestPlayer))
    else
        exports['mythic_notify']:DoLongHudText('error', 'No Player Found')
    end
end)

--//    END OF GENERAL   //--

------------------------------------

--// ANIMATION / EXPRESSIONS //--

AnimSet = "default";

local function SwitchAnimSet(animation)
    RequestAnimSet(animation)
    while not HasAnimSetLoaded(animation) do Citizen.Wait(1) end
    SetPedMovementClipset(PlayerPedId(), animation, 0.2)
    AnimSet = animation;
    local armour = GetPedArmour(PlayerPedId())
    TriggerServerEvent("nadrp:setMetaData", {animSet = AnimSet, armour = armour})
end

RegisterNetEvent('AnimSet:default');
AddEventHandler('AnimSet:default', function()
    ResetPedMovementClipset(PlayerPedId(), 0)
    AnimSet = "default";
    local armour = GetPedArmour(PlayerPedId())
    TriggerServerEvent("nadrp:setMetaData", {animSet = AnimSet, armour = armour})
end)

RegisterNetEvent('AnimSet:Hurry');
AddEventHandler('AnimSet:Hurry', function()
    SwitchAnimSet("move_m@hurry@a")
end)

RegisterNetEvent('AnimSet:Business');
AddEventHandler('AnimSet:Business', function()
    SwitchAnimSet("move_m@business@a")
end)

RegisterNetEvent('AnimSet:Brave');
AddEventHandler('AnimSet:Brave', function()
    SwitchAnimSet("move_m@brave")
end)

RegisterNetEvent('AnimSet:Tipsy');
AddEventHandler('AnimSet:Tipsy', function()
    SwitchAnimSet("move_m@drunk@slightlydrunk")
end)

RegisterNetEvent('AnimSet:Injured');
AddEventHandler('AnimSet:Injured', function()
    SwitchAnimSet("move_m@injured")
end)

RegisterNetEvent('AnimSet:ToughGuy');
AddEventHandler('AnimSet:ToughGuy', function()
    SwitchAnimSet("move_m@tough_guy@")
end)

RegisterNetEvent('AnimSet:Sassy');
AddEventHandler('AnimSet:Sassy', function()
    SwitchAnimSet("move_m@sassy")
end)

RegisterNetEvent('AnimSet:Sad');
AddEventHandler('AnimSet:Sad', function()
    SwitchAnimSet("move_m@sad@a")
end)

RegisterNetEvent('AnimSet:Posh');
AddEventHandler('AnimSet:Posh', function()
    SwitchAnimSet("move_m@posh@")
end)

RegisterNetEvent('AnimSet:Alien');
AddEventHandler('AnimSet:Alien', function()
    SwitchAnimSet("move_m@alien")
end)

RegisterNetEvent('AnimSet:NonChalant');
AddEventHandler('AnimSet:NonChalant', function()
    SwitchAnimSet("move_m@non_chalant")
end)

RegisterNetEvent('AnimSet:Hobo');
AddEventHandler('AnimSet:Hobo', function()
    SwitchAnimSet("move_m@hobo@a")
end)

RegisterNetEvent('AnimSet:Money');
AddEventHandler('AnimSet:Money', function()
    SwitchAnimSet("move_m@money")
end)

RegisterNetEvent('AnimSet:Swagger');
AddEventHandler('AnimSet:Swagger', function()
    SwitchAnimSet("move_m@swagger")
end)

RegisterNetEvent('AnimSet:Joy');
AddEventHandler('AnimSet:Joy', function()
    SwitchAnimSet("move_m@joy")
end)

RegisterNetEvent('AnimSet:Moon');
AddEventHandler('AnimSet:Moon', function()

    SwitchAnimSet("move_m@powerwalk")
end)

RegisterNetEvent('AnimSet:Shady');
AddEventHandler('AnimSet:Shady', function()
    SwitchAnimSet("move_m@shadyped@a")
end)

RegisterNetEvent('AnimSet:Tired');
AddEventHandler('AnimSet:Tired', function()
    SwitchAnimSet("move_m@tired")
end)

RegisterNetEvent('AnimSet:Sexy');
AddEventHandler('AnimSet:Sexy', function()
    SwitchAnimSet("move_f@sexy")
end)

RegisterNetEvent('AnimSet:ManEater');
AddEventHandler('AnimSet:ManEater', function()
    SwitchAnimSet("move_f@maneater")
end)

RegisterNetEvent('AnimSet:ChiChi');
AddEventHandler('AnimSet:ChiChi', function()
    SwitchAnimSet("move_f@chichi")
end)

RegisterNetEvent('AnimSet:Arrogant');
AddEventHandler('AnimSet:Arrogant', function()
    SwitchAnimSet("move_f@arrogant@a")
end)

RegisterNetEvent('AnimSet:Casual');
AddEventHandler('AnimSet:Casual', function()
    SwitchAnimSet("move_m@casual@a")
end)

RegisterNetEvent('AnimSet:Casual2');
AddEventHandler('AnimSet:Casual2', function()
    SwitchAnimSet("move_m@casual@b")
end)

RegisterNetEvent('AnimSet:Casual3');
AddEventHandler('AnimSet:Casual3', function()
    SwitchAnimSet("move_m@casual@c")
end)

RegisterNetEvent('AnimSet:Casual4');
AddEventHandler('AnimSet:Casual4', function()
    SwitchAnimSet("move_m@casual@d")
end)

RegisterNetEvent('AnimSet:Casual5');
AddEventHandler('AnimSet:Casual5', function()
    SwitchAnimSet("move_m@casual@e")
end)

RegisterNetEvent('AnimSet:Casual6');
AddEventHandler('AnimSet:Casual6', function()
    SwitchAnimSet("move_m@casual@f")
end)

RegisterNetEvent('AnimSet:Confident');
AddEventHandler('AnimSet:Confident', function()
    SwitchAnimSet("move_m@confident")
end)

RegisterNetEvent('AnimSet:Business2');
AddEventHandler('AnimSet:Business2', function()
    SwitchAnimSet("move_m@business@b")
end)

RegisterNetEvent('AnimSet:Business3');
AddEventHandler('AnimSet:Business3', function()
    SwitchAnimSet("move_m@business@c")
end)

RegisterNetEvent('AnimSet:Femme');
AddEventHandler('AnimSet:Femme', function()
    SwitchAnimSet("move_f@femme@")
end)

RegisterNetEvent('AnimSet:Flee');
AddEventHandler('AnimSet:Flee', function()
    SwitchAnimSet("move_f@flee@a")
end)

RegisterNetEvent('AnimSet:Gangster');
AddEventHandler('AnimSet:Gangster', function()
    SwitchAnimSet("move_m@gangster@generic")
end)

RegisterNetEvent('AnimSet:Gangster2');
AddEventHandler('AnimSet:Gangster2', function()
    SwitchAnimSet("move_m@gangster@ng")
end)

RegisterNetEvent('AnimSet:Gangster3');
AddEventHandler('AnimSet:Gangster3', function()
    SwitchAnimSet("move_m@gangster@var_e")
end)

RegisterNetEvent('AnimSet:Gangster4');
AddEventHandler('AnimSet:Gangster4', function()
    SwitchAnimSet("move_m@gangster@var_f")
end)

RegisterNetEvent('AnimSet:Gangster5');
AddEventHandler('AnimSet:Gangster5', function()
    SwitchAnimSet("move_m@gangster@var_i")
end)

RegisterNetEvent('AnimSet:Heels');
AddEventHandler('AnimSet:Heels', function()
    SwitchAnimSet("move_f@heels@c")
end)

RegisterNetEvent('AnimSet:Heels2');
AddEventHandler('AnimSet:Heels2', function()
    SwitchAnimSet("move_f@heels@d")
end)

RegisterNetEvent('AnimSet:Hipster');
AddEventHandler('AnimSet:Hipster', function()
    SwitchAnimSet("move_m@hipster@a")
end)

RegisterNetEvent('AnimSet:Hiking');
AddEventHandler('AnimSet:Hiking', function()
    SwitchAnimSet("move_m@hiking")
end)

RegisterNetEvent('AnimSet:Jog');
AddEventHandler('AnimSet:Jog', function()
    SwitchAnimSet("move_m@jog@")
end)

RegisterNetEvent('AnimSet:Muscle');
AddEventHandler('AnimSet:Muscle', function()
    SwitchAnimSet("move_m@muscle@a")
end)

RegisterNetEvent('AnimSet:Quick');
AddEventHandler('AnimSet:Quick', function()
    SwitchAnimSet("move_m@quick")
end)

RegisterNetEvent('AnimSet:Wide');
AddEventHandler('AnimSet:Wide', function()
    SwitchAnimSet("move_m@bag")
end)

RegisterNetEvent('AnimSet:Scared');
AddEventHandler('AnimSet:Scared', function()
    SwitchAnimSet("move_f@scared")
end)

RegisterNetEvent('AnimSet:Guard');
AddEventHandler('AnimSet:Guard', function()
    SwitchAnimSet("move_m@prison_gaurd")
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

RegisterNetEvent("expressions")
AddEventHandler("expressions", function(pArgs)
    if #pArgs ~= 1 then return end
    local expressionName = pArgs[1]
    SetFacialIdleAnimOverride(PlayerPedId(), expressionName, 0)
    return
end)

RegisterNetEvent("expressions:clear")
AddEventHandler("expressions:clear",function() 
    ClearFacialIdleAnimOverride(PlayerPedId()) 
end)

RegisterNetEvent('nadrp:LoadMetaData')
AddEventHandler('nadrp:LoadMetaData', function(data)
    local armour = data.armour
    local anim = data.animSet
    if armour > 0 then
        SetPedArmour(PlayerPedId(), armour)
    end
    if anim ~= nil then
        RequestAnimSet(anim)
        while not HasAnimSetLoaded(anim) do Citizen.Wait(1) end
        SetPedMovementClipset(PlayerPedId(), anim, 0.2)
        AnimSet = anim;
        print(AnimSet)
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then 
        local armour = GetPedArmour(PlayerPedId())
        TriggerServerEvent("nadrp:setMetaData", {animSet = AnimSet, armour = armour})
    end
end)

RegisterNetEvent('FlipVehicle')
AddEventHandler('FlipVehicle', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local vehicle = nil
    if IsPedInAnyVehicle(ped, false) then 
        vehicle = GetVehiclePedIsIn(ped, false) 
    else 
        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71) 
    end
    if DoesEntityExist(vehicle) then
        local finished = exports['nadrp-taskbar']:taskBar(10000, 'Flipping vehicle')
        if finished ==  100 then
            local coordA = GetEntityCoords(ped, 1)
            local coordB = GetOffsetFromEntityInWorldCoords(ped, 0.0, 100.0, 0.0)
            local targetVehicle = getVehicleInDirection(coordA, coordB)
            SetVehicleOnGroundProperly(targetVehicle)
        end
    else
        exports['mythic_notify']:DoLongHudText('error', 'There is no vehicle near-by', 7000)
    end
end)

function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle
    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)    
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)
        offset = offset - 1
        if vehicle ~= 0 then break end
    end
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    if distance > 25 then vehicle = nil end
    return vehicle ~= nil and vehicle or 0
end