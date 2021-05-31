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

ESX = nil

PlayerData = {}

local jailTime = 0
local inJail = false


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData() == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("ffrp-jail:PlayerLoaded")
AddEventHandler("ffrp-jail:PlayerLoaded", function()
    ESX.TriggerServerCallback("tac-qalle-jail:retrieveJailTime", function(inJail, newJailTime)
		if inJail then
			jailTime = newJailTime
            JailLogin()
            inJail = true
		end
	end)
end)

RegisterNetEvent("tac:setJob")
AddEventHandler("tac:setJob", function(response)
	PlayerData["job"] = response
end)

RegisterNetEvent("tac-qalle-jail:openJailMenu")
AddEventHandler("tac-qalle-jail:openJailMenu", function()
	OpenJailMenu()
end)

RegisterNetEvent("tac-qalle-jail:jailPlayer")
AddEventHandler("tac-qalle-jail:jailPlayer", function(newJailTime)
	jailTime = newJailTime

    Cutscene()
    inJail = true
end)

RegisterNetEvent("tac-qalle-jail:unJailPlayer")
AddEventHandler("tac-qalle-jail:unJailPlayer", function()
	jailTime = 0

    UnJail()
    inJail = false
end)

function JailLogin()
    local rand = math.random(#Config.JailPositions)
    SetEntityCoords(PlayerPedId(), Config.JailPositions[rand]["x"], Config.JailPositions[rand]["y"], Config.JailPositions[rand]["z"] - 1) 

    exports['mythic_notify']:SendAlert('inform', 'Last time you went to sleep you were jailed, because of that you are now put back!', 5000)
    InJail()
    inJail = true
end

function UnJail()
	InJail()

	ESX.Game.Teleport(PlayerPedId(), Config.Teleports["Boiling Broke"])

    TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message nonemergency">DOC | {0} </div>',
        args = {"You have been released"}
    });
    inJail = false
end

function InJail()
	--Jail Timer--
    Citizen.CreateThread(function()
		while jailTime > 0 do

			jailTime = jailTime - 1

			TriggerServerEvent("tac-qalle-jail:updateJailTime", jailTime)
            if jailTime == 0 then
                TriggerEvent('chat:addMessage', {
                    template = '<div class="chat-message nonemergency">DOC | {0} </div>',
                    args = {"You have done your time now leave!."}
                });
            end
			Citizen.Wait(60000)
		end
	end)
end

-- repair weld

eatenRecently = false
cleanedRecently = false
repairedRecently = false

repaircoords = {
    [1] = {["x"] = 1760.182, ["y"] = 2541.353, ["z"] = 45.565, ["h"] = 265.523},
    [2] = {["x"] = 1737.459, ["y"] = 2504.681, ["z"] = 45.565, ["h"] = 135.866},
    [3] = {["x"] = 1699.914, ["y"] = 2475.005, ["z"] = 45.565, ["h"] = 227.775},
    [4] = {["x"] = 1685.811, ["y"] = 2553.646, ["z"] = 45.565, ["h"] = 0.647},
    [5] = {["x"] = 1629.527, ["y"] = 2564.368, ["z"] = 45.565, ["h"] = 64.264},
    [6] = {["x"] = 1632.588, ["y"] = 2529.472, ["z"] = 45.565, ["h"] = 225.14},
    [7] = {["x"] = 1718.935, ["y"] = 2528.203, ["z"] = 45.565, ["h"] = 224.852},
    [8] = {["x"] = 1699.576, ["y"] = 2533.521, ["z"] = 45.565, ["h"] = 109.097},
}

cleancoords = {
    [1] =  {["x"] = 1777.86, ["y"] = 2583.0, ["z"] = 45.499, ["h"] = 249.31}, 
    [2] =  {["x"] = 1777.882, ["y"] = 2579.514, ["z"] = 45.517, ["h"] = 191.531}, 
    [3] =  {["x"] = 1778.088, ["y"] = 2575.378, ["z"] = 45.499, ["h"] = 8.727}, 
    [4] =  {["x"] = 1773.977, ["y"] = 2575.914, ["z"] = 45.499, ["h"] = 84.924}, 
    [5] =  {["x"] = 1773.625, ["y"] = 2579.274, ["z"] = 45.497, ["h"] = 82.868}, 
    [6] =  {["x"] = 1773.889, ["y"] = 2583.344, ["z"] = 45.499, ["h"] = 172.331}, 
}

eatTask = {
    ["x"] = 1779.632, 
    ["y"] = 2589.666, 
    ["z"] = 45.798
}

finishCleanTask = {
    ["x"] = 1776.01,
    ["y"] = 2587.863,
    ["z"] = 45.71234
}

imjailed = false
curTaskType = "None"
jobProcess = false

Citizen.CreateThread(function()
    local jobmessage = "Waiting for new job.."
    while true do
        if jailTime > 0 then
            Citizen.Wait(0)
            if curTask ~= nil and curTaskType ~= "None" then
                if not jobProcess then
                    jobProcess = true
                    addBlipForJob(curTask["x"],curTask["y"],curTask["z"])
                end

                if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), 0), curTask["x"],curTask["y"],curTask["z"]) > 1.5) then
                    DrawMarker(27, curTask["x"],curTask["y"],curTask["z"], 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 70, 0, 0, 0, 0)
                    DisplayHelpText(" Your current job is marked: ~r~ " .. curTaskType .. "")
                end

                if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1), 0), curTask["x"],curTask["y"],curTask["z"]) < 1.5) then
                    DrawMarker(27, curTask["x"],curTask["y"],curTask["z"], 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 70, 0, 0, 0, 0)
                    DisplayHelpText('Currently Working!')
                    finishTask()
                end
            end
        else
            Citizen.Wait(10000)
        end
    end
end)

function addBlipForJob(x,y,z)
    RemoveBlip(Blip)
    if curTaskType == "Eat" then
        x = 1779.632
        y = 2589.666
        z = 45.798
    end
    Blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(Blip, 430)
    SetBlipScale(blip, 0.45)
    SetBlipAsShortRange(Blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Next Jail Task")
    EndTextCommandSetBlipName(Blip)
end

cleaninginprogress = false


function finishTask()
    local factor = 25

    if curTaskType == "Clean" then
        repairing = true
            exports['t0sic_loadingbar']:StartDelayedFunction('Cleaning 🧽', 50000, function()
                repairing = false
            end)
        repair()
        factor = 10
        Citizen.Wait(40000)
    end

    if curTaskType == "Repair" then
        repairing = true
        exports['t0sic_loadingbar']:StartDelayedFunction('Repairing 🔨', 60000, function()
            repairing = false
        end)
        repair()
        factor = 5
        Citizen.Wait(40000)
    end

    if curTaskType == "Eat" then
        exports['mythic_notify']:SendAlert('inform', 'Sit down and take a break')
        drink()
        factor = 0
        Citizen.Wait(60000)
    end

    if math.random(100) > factor then
        jailTime = jailTime - 5
        TriggerServerEvent("tac-qalle-jail:updateJailTime", jailTime)
        exports['mythic_notify']:SendAlert('inform', 'Your jail sentence was reduced.')
    end

    jobProcess = false
    curTask = nil
    curTaskType = "None"
end

Citizen.CreateThread(function()
    local workCount = 0
    while true do
        if jailTime > 0 then
            Citizen.Wait(10000)
            if curTask == nil then
                local curTime = GetClockHours()
                if curTime >= 6 and curTime <= 7 and not eatenRecently then
                    curTask = eatTask
                    curTaskType = "Eat"
                    eatenRecently = true
                elseif curTime >= 11 and curTime <= 12 and not eatenRecently then 
                    curTask = eatTask
                    curTaskType = "Eat"
                    eatenRecently = true
                elseif curTime >= 17 and curTime <= 16 and not eatenRecently then 
                    curTask = eatTask
                    curTaskType = "Eat"
                    eatenRecently = true
                else
                    if eatenRecently then
                        eatenRecently = false
                        if workCount > 12 then
                            curTask = repaircoords[math.random(#repaircoords)]
                            curTaskType = "Repair"
                            workCount = 0
                        else
                            curTask = cleancoords[math.random(#cleancoords)]
                            curTaskType = "Clean"
                        end
                    else
                        if workCount > 5 then
                            curTask = eatTask
                            curTaskType = "Eat"
                            eatenRecently = true
                            workCount = 0
                        else
                            --curTask = repaircoords[math.random(#repaircoords)]
                            --curTaskType = "Repair"
                            curTask = cleancoords[math.random(#cleancoords)]
                            curTaskType = "Clean"
                        end
                    end
                end
                workCount = workCount + 1
            end
        else
            Citizen.Wait(20000)
        end
    end
end)

local minCalc = 300000

Citizen.CreateThread(function()
    while true do

        if inJail then
            if minCalc == 0 then
                minCalc = 300000

                TriggerEvent('chat:addMessage', {
                    template = '<div class="chat-message nonemergency">DOC | {0} </div>',
                    args = {"You have " .. jailTime .. " minutes left in jail!"}
                });
            end

            if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1780.716,2567.433,45.71839) < 10.0) then
                DrawMarker(27, 1780.716,2567.433,45.71839, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 155, 155, 155, 70, 0, 0, 0, 0)
            end
            if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1780.716,2567.433,45.71839) < 4.0) then
                if IsControlJustPressed(1, Keys["E"]) then
                    TriggerEvent('chat:addMessage', {
                        template = '<div class="chat-message nonemergency">DOC | {0} </div>',
                        args = {"You have " .. jailTime .. " months left in jail!"}
                    })
                    Citizen.Wait(5000)
                    if jailTime <= 0 then
                        UnJail()
                        TriggerServerEvent("tac-qalle-jail:updateJailTime", 0)
                    end
                end
                if IsControlJustPressed(1, Keys["G"]) then
                    TriggerEvent('kashactersC:ReloadCharacters')
                end
                drawTxt(0.90, 1.40, 1.0,1.0,0.25, "Press [G] to swap characters.", 255, 255, 255, 255)
                drawTxt(0.90, 1.44, 1.0,1.0,0.25, "Press [E] to check your jail time.", 255, 255, 255, 255)
            end
            for i = 1, #Config.JailPositions do
                if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.JailPositions[i]["x"],Config.JailPositions[i]["y"],Config.JailPositions[i]["z"]) > 400) then
                    SetEntityCoords(GetPlayerPed(-1), Config.JailPositions[i]["x"],Config.JailPositions[i]["y"],Config.JailPositions[i]["z"])
                end
            end
            minCalc = minCalc - 1
        end
        Citizen.Wait(0)
    end
end)

local reclaim = vector3(1843.561, 2587.223, 45.892)
Citizen.CreateThread(function()
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId())
        local waitCheck = #(playerCoords - reclaim)
        if waitCheck < 15 then
            DrawText3D(reclaim.x, reclaim.y, reclaim.z, 'Press [E] to re-claim your possessions.')
            DrawMarker(27,reclaim.x,reclaim.y,reclaim.z -1, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 255, 255, 255, 55, 0, 0, 0, 0)
        end
        if waitCheck < 1.5 then
            if IsControlJustPressed(0,46) then
                TriggerServerEvent("ffrp-jail:reclaimPossessions")
                exports['mythic_notify']:SendAlert('inform', 'You have re-claimed your possessions.')
                Wait(60000)
            end
        end
        waitCheck = (waitCheck < 15 and 1 or waitCheck)
        Wait(math.ceil(waitCheck))
    end
end)

function repair()
    local Ped = GetPlayerPed(-1)

    loadAnimDict('mini@repair')

    while repairing == true do
        if not IsEntityPlayingAnim(Ped, "mini@repair", "fixing_a_player", 3) then
            ClearPedSecondaryTask(Ped)
            TaskPlayAnim(Ped, "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end
    ClearPedTasksImmediately(Ped)
end

function drink()
    ClearPedSecondaryTask(GetPlayerPed(-1))
    loadAnimDict( "mp_player_intdrink" ) 

    TaskPlayAnim( GetPlayerPed(-1), "mp_player_intdrink", "loop_bottle", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Citizen.Wait(5000)

    endanimation()
end

function clean()

    local Ped = GetPlayerPed(-1)

    loadAnimDict('anim@amb@prop_human_atm@interior@male@base')

    while cleaning == true do
        if not IsEntityPlayingAnim(Ped, "anim@amb@prop_human_atm@interior@male@base", "base", 3) then
            ClearPedSecondaryTask(Ped)
            TaskPlayAnim(Ped, "anim@amb@prop_human_atm@interior@male@base", "base", 8.0, -8, -1, 49, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end
    ClearPedTasksImmediately(Ped)
end

function endanimation()
    ClearPedSecondaryTask(GetPlayerPed(-1))
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
        SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end
function DrawText3D(x,y,z, text)
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