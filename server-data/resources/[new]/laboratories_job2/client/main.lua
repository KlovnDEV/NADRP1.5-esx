local a = exports[Config.MetaLibsName]
local b = Config.UseProgBars and exports["progbars"] or false;
local c = a:Vector()
local d = a:SynchronisedScene()
local e = {}
local f = false;
local g = false;
local h = false;
local i = print;
vDist = function(j, k)
    if not j or not k or not j.x or not k.x or not j.z or not k.z then
        return 0
    end
    return math.sqrt((j.x - k.x) * (j.x - k.x) + (j.y - k.y) * (j.y - k.y) + (j.z - k.z) * (j.z - k.z))
end;
function AddLongString(l)
    local m = 100;
    for n = 0, string.len(l), m do
        local o = string.sub(l, n, math.min(n + m, string.len(l)))
        AddTextComponentString(o)
    end
end
ShowNotification = function(p)
    AddTextEntry('TerritoriesNotify', p)
    SetNotificationTextEntry('TerritoriesNotify')
    DrawNotification(false, true)
    return DrawNotification(0, 1)
end;
ShowHelpNotification = function(p)
    SetTextComponentFormat("jamyfafi")
    AddLongString(p)
    DisplayHelpTextFromStringLabel(0, 0, 0, -1)
end;
DrawCenterText = function(p, q)
    ClearPrints()
    SetTextEntry_2("jamyfafi")
    AddTextComponentString(p)
    DrawSubtitleTimed(q and math.ceil(q) or 0, true)
end;
TriggerEvent('instance:registerType', 'laboratoir')
TriggerEvent('instance:registerType', 'property')
Start = function()
    GetFramework()
    print('test')
    PlayerData = GetPlayerData()
    Wait(1000)
    TriggerServerEvent('Territories:PlayerLogin')
    Update()
end;
local r;
RegisterCommand("zoneinfo", function()
    local s = GetClosestZone()
    local t = Territories[s]
    local u = DeathCheck(lastZone)
    if t then
        if r then
            RemoveNotification(r)
        end
        r = ShowNotification("~s~Zone : ~g~" .. s .. "\n~s~Control : ~g~" .. t.control:sub(1, 1):upper() ..
                                 t.control:sub(2) .. "\n~s~Influence : ~g~" .. math.floor(t.influence) .. "%")
    else
        if r then
            RemoveNotification(r)
        end
        r = ShowNotification("~r~Aucune zone n'est défini ici.")
    end
end)
TableCopy = function(v)
    local w = {}
    for x, y in pairs(v) do
        if type(y) == "table" then
            w[x] = TableCopy(y)
        else
            w[x] = y
        end
    end
    return w
end;
local z = false;
local A = false;
Update = function()
    while true do
        attente = 500;
        local s = GetClosestZone()
        local t = Territories[s]
        local u = DeathCheck(lastZone)
        if not u then
            CheckLocation(s)
        else
            if lastZone then
                if PlayerData.job and PlayerData.job.name and GangLookup[PlayerData.job.name] then
                    TriggerServerEvent('Territories:LeaveZone', lastZone, PlayerData.job.name)
                    lastZone = false
                elseif PlayerData.job2 and PlayerData.job2.name and GangLookup[PlayerData.job2.name] then
                    TriggerServerEvent('Territories:LeaveZone', lastZone, PlayerData.job2.name)
                    lastZone = false
                end
            end
        end
        if z or A then
            attente = 1
        end
        Wait(attente)
    end
end;
local B = function(C)
    return IsControlJustReleased(0, C)
end;
local D = false;
local E = 60 * 1000 * 8.0;
RegisterNetEvent('esx:AlertGang')
AddEventHandler('esx:AlertGang', function(s)
    ShowNotification("~b~Guetteur~n~~w~Des personnes sont entrain ~r~d'attaquer~s~ notre ~r~Zone~s~ ! (~b~" .. s ..
                         "~s~)")
end)
RegisterNetEvent('esx:AlertGangAt')
AddEventHandler('esx:AlertGangAt', function(s)
    ShowNotification("~b~Informateur~n~~w~Nous sommes entrain ~r~d'attaquer~s~ une zone~s~ ! (~b~" .. s .. "~s~)")
end)
CheckLocation = function(s)
    local t = Territories[s]
    local F = GetPlayerPed(-1)
    local G = GetEntityCoords(F)
    local H = GetEntityHealth(F)
    if s then
        if H > 100 then
            if not lastZone or lastZone ~= s then
                if lastZone then
                    TriggerServerEvent('Territories:LeaveZone', lastZone, PlayerData.job.name)
                end
                if not h then
                    lastZone = s;
                    if PlayerData.job and PlayerData.job.name and GangLookup[PlayerData.job.name] and
                        GetSelectedPedWeapon(F) == GetHashKey("WEAPON_MOLOTOV") and not D then
                        D = true;
                        TriggerServerEvent('Territories:EnterZone', s, PlayerData.job.name)
                    elseif PlayerData.job2 and PlayerData.job2.name and GangLookup[PlayerData.job2.name] and
                        GetSelectedPedWeapon(F) == GetHashKey("WEAPON_MOLOTOV") and not D then
                        D = true;
                        DrawCenterText(
                            "Vous êtes entrain de capturer la zone. (~g~" .. s .. "~s~ / ~g~" .. t.control .. "~s~)",
                            20000)
                        PrepareMusicEvent("RH2A_MISSION_START")
                        TriggerMusicEvent("RH2A_MISSION_START")
                        Utils.AddTimerBar("Capture en cours:", {
                            endTime = GetGameTimer() + E
                        })
                        PlaySoundFrontend(-1, "Enter_Area", "DLC_Lowrider_Relay_Race_Sounds", 0)
                        TriggerServerEvent('Territories:EnterZone', s, PlayerData.job2.name)
                        TriggerServerEvent('esx:AlertGang', t.control, s)
                        TriggerServerEvent('esx:AlertGangAt', PlayerData.job2.name, s)
                    end
                end
            else
                if lastZone and h then
                    if PlayerData.job and PlayerData.job.name and GangLookup[PlayerData.job.name] and D then
                        D = false;
                        notifshootingafterenter = false;
                        TriggerServerEvent('Territories:LeaveZone', lastZone, PlayerData.job.name)
                    elseif PlayerData.job2 and PlayerData.job2.name and GangLookup[PlayerData.job2.name] and D then
                        D = false;
                        notifshootingafterenter = false;
                        DrawCenterText("~r~Vous avez fui la zone.", 5000)
                        Utils.RemoveTimerBar()
                        PrepareMusicEvent("MP_MC_ASSAULT_ADV_STOP")
                        TriggerMusicEvent("MP_MC_ASSAULT_ADV_STOP")
                        PlaySoundFrontend(-1, "Out_Of_Area", "DLC_Lowrider_Relay_Race_Sounds", 0)
                        TriggerServerEvent('Territories:LeaveZone', lastZone, PlayerData.job2.name)
                    end
                end
            end
        end
        if t.control == PlayerData.job.name or PlayerData.job2 and PlayerData.job2.name == t.control then
            if t.actions and t.actions.entry then
                if vDist(G, t.actions.entry.location) < Config.InteractDist then
                    z = true;
                    ShowHelpNotification(t.actions.entry.helpText)
                    if B(Config.InteractControl) then
                        InsideInterior = t;
                        a:TeleportPlayer(InsideInterior.actions.exit.location)
                        TriggerEvent('instance:create', 'laboratoir')
                    end
                elseif vDist(G, t.actions.entry.location) > Config.InteractDist then
                    z = false
                end
            end
            if (Config.SlingByHotkey and B(Config.SlingDrugsControl) or f) and not CurSlinging then
                f = false;
                SlingDrugs(t, s)
            end
        end
        if not InsideInterior then
            if vDist(G, t.actions.exit.location) < Config.InteractDist then
                A = true;
                ShowHelpNotification(t.actions.exit.helpText)
                if B(Config.InteractControl) then
                    InsideInterior = t;
                    a:TeleportPlayer(InsideInterior.actions.entry.location)
                    TriggerEvent('instance:close')
                    SetEntityVisible(GetPlayerPed(-1), true, false)
                end
            elseif vDist(G, t.actions.exit.location) > Config.InteractDist then
                A = false
            end
        end
    else
        if lastZone then
            if PlayerData.job and PlayerData.job.name and GangLookup[PlayerData.job.name] and D then
                D = false;
                notifshootingafterenter = false;
                TriggerServerEvent('Territories:LeaveZone', lastZone, PlayerData.job.name)
            elseif PlayerData.job2 and PlayerData.job2.name and GangLookup[PlayerData.job2.name] and D then
                D = false;
                notifshootingafterenter = false;
                DrawCenterText("~r~Vous avez fui la zone.", 5000)
                Utils.RemoveTimerBar()
                PrepareMusicEvent("MP_MC_ASSAULT_ADV_STOP")
                TriggerMusicEvent("MP_MC_ASSAULT_ADV_STOP")
                PlaySoundFrontend(-1, "Out_Of_Area", "DLC_Lowrider_Relay_Race_Sounds", 0)
                TriggerServerEvent('Territories:LeaveZone', lastZone, PlayerData.job2.name)
            end
            lastZone = false
        end
        if not InsideInterior then
            print = false;
            local I, J;
            for x, y in pairs(Territories) do
                local K = y.actions.exit.location;
                local L = vDist(G, K)
                if not J or L < J then
                    I = x;
                    J = L
                end
            end
            if J and J < Config.InteractDist then
                z = true;
                ShowHelpNotification(Territories[I].actions.exit.helpText)
                if B(Config.InteractControl) then
                    TriggerEvent('instance:create', 'laboratoir')
                    a:TeleportPlayer(Territories[I].actions.entry.location)
                    InsideInterior = nil
                end
            elseif J > Config.InteractDist then
                z = false
            end
        end
    end
    if InsideInterior then
        A = true;
        local J = vDist(G, InsideInterior.actions.exit.location)
        if J and J < Config.InteractDist then
            ShowHelpNotification(InsideInterior.actions.exit.helpText)
            if B(Config.InteractControl) then
                TriggerEvent('instance:close')
                SetEntityVisible(GetPlayerPed(-1), true, false)
                a:TeleportPlayer(InsideInterior.actions.entry.location)
                InsideInterior = nil
            end
        else
            local M, N = GetClosestAction(InsideInterior)
            if N < Config.InteractDist then
                z = true;
                ShowHelpNotification(InsideInterior.actions[M].helpText)
                if B(Config.InteractControl) then
                    SceneHandler(InsideInterior.actions[M])
                end
            end
        end
    end
end;
local O = false;
local notifshootingafterenter = false;
local P;
SceneHandler = function(Q)
    local R, S = not Q.requireItem, ''
    if Q.requireItem then
        local T = ESX.GetPlayerData()
        for x, y in pairs(T.inventory) do
            if y.name == Q.requireItem then
                R = y.count >= Q.requireRate;
                S = y.label
            end
        end
    elseif Q.requireCash then
        R = false;
        S = "Dirty Money"
        local T = ESX.GetPlayerData()
        for x, y in pairs(T.accounts) do
            if y.name == Config.DirtyAccount then
                R = y.money and y.money >= Q.requireCash
            end
        end
    end
    if R then
        local F = GetPlayerPed(-1)
        local U = Q.act;
        local V = Q.scene;
        local W = Q.location - Q.offset;
        local X = Q.rotation;
        local Y = SceneDicts[U][V]
        local Z = SceneItems[U][V]
        local _ = SceneAnims[U][V]
        local a0 = PlayerAnims[U][V]
        while not HasAnimDictLoaded(Y) do
            RequestAnimDict(Y)
            Wait(0)
        end
        local a1 = 1;
        local a2 = 0;
        for x, y in pairs(Z) do
            local a3 = GetHashKey(y)
            while not HasModelLoaded(a3) do
                RequestModel(a3)
                Wait(0)
            end
            e[x] = CreateObject(a3, W, true)
            SetModelAsNoLongerNeeded(a3)
            a2 = a2 + 1;
            while not DoesEntityExist(e[x]) do
                Wait(0)
            end
            SetEntityCollision(e[x], false, false)
        end
        local a4 = {}
        local a5 = d.SceneConfig(W, X, 2, false, false, 1.0, 0, 1.0)
        for n = 1, math.max(1, math.ceil(a2 / 3)), 1 do
            a4[n] = d.Create(a5)
        end
        local a6 = d.PedConfig(F, a4[1], Y, a0)
        d.AddPed(a6)
        for x, a7 in pairs(_) do
            local a8 = a4[math.ceil(a1 / 3)]
            local a9 = d.EntityConfig(e[x], a8, Y, a7)
            d.AddEntity(a9)
            a1 = a1 + 1
        end
        local aa = {}
        if Q.extraProps then
            for x, y in pairs(Q.extraProps) do
                a:LoadModel(y.model)
                local ab = CreateObject(GetHashKey(y.model), W + y.pos, true, true, true)
                while not DoesEntityExist(ab) do
                    Wait(0)
                end
                SetEntityRotation(ab, y.rot)
                FreezeEntityPosition(ab, true)
                aa[#aa + 1] = ab
            end
        end
        P = GetGameTimer()
        for n = 1, #a4, 1 do
            d.Start(a4[n])
        end
        Wait(Q.time)
        for n = 1, #a4, 1 do
            d.Stop(a4[n])
        end
        for x, y in pairs(aa) do
            DeleteObject(y)
        end
        RemoveAnimDict(Y)
        TriggerServerEvent('Territories:RewardPlayer', Q)
        for x, y in pairs(e) do
            NetworkFadeOutEntity(y, false, false)
        end
    else
        local ac = _U["not_enough"]
        local ad = S:len() > 0 and S or 'UNKNOWN'
        local ae = Q.requireRate or (Q.requireCash and "$" .. Q.requireCash or 'UNKNOWN')
        ShowNotification(string.format(ac, ad, ae))
    end
end;
GetClosestAction = function(af)
    local G = GetEntityCoords(GetPlayerPed(-1))
    local s, ag;
    for x, y in pairs(af.actions) do
        if x ~= "entry" and x ~= "exit" then
            local L = vDist(G, y.location)
            if not ag or L < ag then
                ag = L;
                s = x
            end
        end
    end
    return s or false, ag or 9999
end;
DeathCheck = function(ah)
    local F = GetPlayerPed(-1)
    local H = GetEntityHealth(F)
    local u = IsPedFatallyInjured(F)
    if isDead then
        if not u then
            isDead = false
        end
    else
        if u and ah then
            isDead = true;
            local ai = NetworkGetEntityKillerOfPlayer(PlayerId())
            local aj = GetPlayerByEntityID(ai)
            if ai ~= F and aj ~= nil and NetworkIsPlayerActive(aj) then
                local ak = GetPlayerServerId(aj)
                if ak and ak ~= -1 then
                    TriggerServerEvent('Territories:GotMurdered', ak, ah)
                end
            end
        end
    end
    return isDead
end;
Switch = function(al, ...)
    local am = {...}
    local an = #am % 2 == 0;
    for n = 1, #am - (an and 0 or 1), 2 do
        if al == am[n] then
            return am[n + 1](an and nil or am[#am])
        end
    end
end;
GetClosestZone = function()
    local s;
    local ao = GetStreetNameFromHashKey(GetStreetNameAtCoord(GetEntityCoords(GetPlayerPed(-1)).x,
                                            GetEntityCoords(GetPlayerPed(-1)).y, GetEntityCoords(GetPlayerPed(-1)).z))
    for x, y in pairs(Territories) do
        if y.zone == ao then
            s = x
        end
    end
    return s or false
end;
Sync = function(v)
    for x, y in pairs(v) do
        Territories[x].influence = y.influence;
        Territories[x].control = y.control
    end
end;
GetPlayerByEntityID = function(ap)
    for n = 0, Config.MaxPlayerCount do
        if NetworkIsPlayerActive(n) and GetPlayerPed(n) == ap then
            return n
        end
    end
    return nil
end;
PlayerInGang = function()
    if not PlayerData or not PlayerData.job and not PlayerData.job2 or not PlayerData.job.name and
        not PlayerData.job2.name then
        return false
    end
    if GangLookup[PlayerData.job.name] then
        return true
    else
        if PlayerData.job2 and PlayerData.job2.name and GangLookup[PlayerData.job2.name] then
            return true
        else
            return false
        end
    end
end;
if Config.StartEvent == "Thread" then
    Citizen.CreateThread(Start)
else
    AddEventHandler(Config.StartEvent, Start)
end
local aq = false;
GotCuffed = function()
    aq = not aq;
    local ah = aq and GetClosestZone()
    if ah then
        TriggerServerEvent('Territories:CuffSuccess', ah)
    end
end;
PlayerReported = function(ar)
    local as = ESX.GetPlayerData().job;
    if as and as.name and PoliceLookup[as.name] then
        local at = GetGameTimer()
        ShowNotification(_U["drug_deal_reported"])
        while GetGameTimer() - at < 8000 do
            if IsControlJustReleased(0, 101) or IsDisabledControlJustReleased(0, 101) then
                SetNewWaypoint(ar.x, ar.y)
                return
            end
            Wait(0)
        end
    else
        local au = ESX.GetPlayerData().job2;
        if au and au.name and PoliceLookup[au.name] then
            local at = GetGameTimer()
            ShowNotification(_U["drug_deal_reported"])
            while GetGameTimer() - at < 8000 do
                if IsControlJustReleased(0, 101) or IsDisabledControlJustReleased(0, 101) then
                    SetNewWaypoint(ar.x, ar.y)
                    return
                end
                Wait(0)
            end
        end
    end
end;
function Utils.DrawText2(av, aw, ax, ay, az, aA, aB, aC, aD)
    SetTextFont(av)
    SetTextScale(ax, ax)
    if aB then
        SetTextDropShadow(0, 0, 0, 0, 0)
        SetTextEdge(0, 0, 0, 0, 0)
    end
    SetTextColour(aA[1], aA[2], aA[3], 255)
    if aC == 0 then
        SetTextCentre(true)
    else
        SetTextJustification(aC or 1)
        if aC == 2 then
            SetTextWrap(.0, aD or ay)
        end
    end
    SetTextEntry("STRING")
    AddTextComponentString(aw)
    DrawText(ay, az)
end
local aE = {
    baseX = 0.918,
    baseY = 0.984,
    titleOffsetX = 0.012,
    titleOffsetY = -0.012,
    valueOffsetX = 0.0785,
    valueOffsetY = -0.0165,
    pbarOffsetX = 0.047,
    pbarOffsetY = 0.0015
}
local aF = {
    timerBarWidth = 0.165,
    timerBarHeight = 0.035,
    timerBarMargin = 0.038,
    pbarWidth = 0.0616,
    pbarHeight = 0.0105
}
local aG = {}
function Utils.AddTimerBar(aH, aI)
    if not aI then
        return
    end
    RequestStreamedTextureDict("timerbars", true)
    local aJ = #aG + 1;
    aG[aJ] = {
        title = aH,
        text = aI.text,
        textColor = aI.color or {255, 255, 255, 255},
        percentage = aI.percentage,
        endTime = aI.endTime,
        pbarBgColor = aI.bg or {155, 155, 155, 255},
        pbarFgColor = aI.fg or {255, 255, 255, 255}
    }
    return aJ
end
function Utils.RemoveTimerBar()
    aG = {}
    SetStreamedTextureDictAsNoLongerNeeded("timerbars")
end
local aK = {200, 100, 100}
local math = math;
function SecondsToClock(aL)
    aL = tonumber(aL)
    if aL <= 0 then
        return "00:00"
    else
        mins = string.format("%02.f", math.floor(aL / 60))
        secs = string.format("%02.f", math.floor(aL - mins * 60))
        return string.format("%s:%s", mins, secs)
    end
end
Citizen.CreateThread(function()
    while true do
        local attente = 500;
        local aM = GetSafeZoneSize()
        local aN = (1.0 - aM) * 0.5;
        local aO = (1.0 - aM) * 0.5;
        if #aG > 0 then
            attente = 1;
            HideHudComponentThisFrame(6)
            HideHudComponentThisFrame(7)
            HideHudComponentThisFrame(8)
            HideHudComponentThisFrame(9)
            for n, y in pairs(aG) do
                local aP = aE.baseY - aO - n * aF.timerBarMargin;
                DrawSprite("timerbars", "all_black_bg", aE.baseX - aN, aP, aF.timerBarWidth, aF.timerBarHeight, 0.0,
                    255, 255, 255, 160)
                Utils.DrawText2(0, y.title, 0.3, aE.baseX - aN + aE.titleOffsetX, aP + aE.titleOffsetY, y.textColor,
                    false, 2)
                if y.percentage then
                    local aQ = aE.baseX - aN + aE.pbarOffsetX;
                    local aR = aP + aE.pbarOffsetY;
                    local aS = aF.pbarWidth * y.percentage;
                    DrawRect(aQ, aR, aF.pbarWidth, aF.pbarHeight, y.pbarBgColor[1], y.pbarBgColor[2], y.pbarBgColor[3],
                        y.pbarBgColor[4])
                    DrawRect(aQ - aF.pbarWidth / 2 + aS / 2, aR, aS, aF.pbarHeight, y.pbarFgColor[1], y.pbarFgColor[2],
                        y.pbarFgColor[3], y.pbarFgColor[4])
                elseif y.text then
                    Utils.DrawText2(0, y.text, 0.425, aE.baseX - aN + aE.valueOffsetX, aP + aE.valueOffsetY,
                        y.textColor, false, 2)
                elseif y.endTime then
                    local aT = math.floor(y.endTime - GetGameTimer())
                    Utils.DrawText2(0, SecondsToClock(aT / 1000), 0.425, aE.baseX - aN + aE.valueOffsetX,
                        aP + aE.valueOffsetY, aT <= 0 and aK or y.textColor, false, 2)
                end
            end
        end
        Wait(attente)
    end
end)
EnterHouse = function(...)
    if not Config.InfluenceInHouse then
        h = true
    end
end;
LeaveHouse = function(...)
    if not Config.InfluenceInHouse then
        lastZone = false;
        h = false
    end
end;
StartRet = function(aU, aV)
    ModStart = aU;
    Territories = aV
end;
RegisterCommand('slingdrugs', function(...)
    if not CurSlinging then
        f = true
    end
end)
GetFramework = function()
    while not ESX do
        Wait(0)
    end
    while not ESX.IsPlayerLoaded() do
        Citizen.Wait(0)
    end
end;
GetPlayerData = function()
    return ESX.GetPlayerData()
end;
SetJob = function(as)
    PlayerData.job = as;
    if lastZone then
        TriggerServerEvent('Territories:LeaveZone', lastZone, PlayerData.job.name)
        lastZone = false
    end
end;
Setjob2 = function(au)
    PlayerData.job2 = au;
    if lastZone then
        TriggerServerEvent('Territories:LeaveZone', lastZone, PlayerData.job2.name)
        lastZone = false
    end
end;
Smack = function()
    ShowNotification("Tricheur tricheur, mange merde !")
end;
RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(aW)
    if aW.type == 'laboratoir' then
        TriggerEvent('instance:enter', aW)
    end
end)
Utils.event(1, Sync, 'Territories:Sync')
Utils.event(1, StartRet, 'Territories:StartRet')
Utils.event(1, SetJob, Config.SetJobEvent)
Utils.event(1, Setjob2, Config.Setjob2Event)
Utils.event(1, GotCuffed, 'Territories:GotCuffed')
Utils.event(1, PlayerReported, 'Territories:PlayerReported')
Utils.event(1, GotMarketAccess, 'Territories:GotMarketAccess')
Utils.event(1, LostMarketAccess, 'Territories:LostMarketAccess')
Utils.event(1, Smack, 'Territories:Smacked')
Utils.event(1, EnterHouse, 'playerhousing:Entered')
Utils.event(1, LeaveHouse, 'playerhousing:Leave')
