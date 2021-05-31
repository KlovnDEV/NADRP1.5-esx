ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

local isCop = false
local isDoc = false
local isMedic = false
local isTher = false
local asSteamIdKeys = false
local job = ''
local cidDoctorsCopAccess = {
    'steam:11000010aa15521',
}

function DrawText3DTest(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)

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

isJudge = false
RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
    isJudge = true
end)

RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)


RegisterNetEvent( 'cell:doors' )
AddEventHandler( 'cell:doors', function(num)
    TriggerEvent("dooranim")
    TriggerServerEvent("ffrp-doors:alterlockstate",tonumber(num))
end)


RegisterNetEvent( 'dooranim' )
AddEventHandler( 'dooranim', function()
    
    ClearPedSecondaryTask(PlayerPedId())
    loadAnimDict( "anim@heists@keycard@" ) 
    TaskPlayAnim( PlayerPedId(), "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Citizen.Wait(850)
    ClearPedTasks(PlayerPedId())

end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function cZ(num1,num2,maxLimit)
    local answer = false
    if (num1 - num2) > -1.2 and (num1 - num2) < maxLimit then
        answer = true
    end
    return answer
end


RegisterNetEvent("doors:HasKeys")
AddEventHandler("doors:HasKeys", function(boolRe)
    hasSteamIdKeys = boolRe
end)

local playerped = PlayerPedId()
local plyCoords = GetEntityCoords(playerped)

local closeDoorsStage1 = {}
local closeDoorsStage2 = {}

local distanceCheckStage1 = 140;
local distanceCheckStage2 = 80;

local TargetClosest = 0
local targetDoor = {};
local currentTargetDist = 999999;

local drawdist = 12.0
local distvariable = 20.0

local lastStaged = {}
local updatedCurrentStage = 0

local distantArea = {
    [1] = {1842.1411132813,2614.8305664063,44.628032684326,45},
    [2] = {465.51, -3119.87, 6.08,45},
    [3] = {15.47,-2536.23,6.15,70},
    [4] = {-195.26,-2516.0,6.14,70},
    [5] = {489.5,-1018.37,28.06,45},
    [6] = {-770.63,-240.00,37.43,45},
    [7] = {410.98,-1026.32,29.4,15},
    [8] = {397.8851,-1607.386,28.34166,45},
    [9] = {459.085,-989.92, 30.69, 70},
    [10] = {456.031,-984.435, 30.689, 70},
    [11] = {190.062, -934.028, 24.136, 70},
    [12] = {-364.48, -122.232, 38.696, 70},
    [13] = {-373.5585, -136.8999, 38.6854, 70},
}

Controlkey = {["generalUse"] = {38,"E"}} 
RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
  Controlkey["generalUse"] = table["generalUse"]
end)

Citizen.CreateThread(function() 
    while true do
        playerped = PlayerPedId()
        plyCoords = GetEntityCoords(playerped)
        Wait(500)
    end
end)

Citizen.CreateThread(function()
    playerped = PlayerPedId()
    plyCoords = GetEntityCoords(playerped)
    while true do
        for i = 1, #FFRP.DoorCoords do
            local distance = #(plyCoords - vector3(FFRP.DoorCoords[i]["x"], FFRP.DoorCoords[i]["y"], FFRP.DoorCoords[i]["z"]))
            if distance < distanceCheckStage1 then
                closeDoorsStage1[i] = FFRP.DoorCoords[i]
            else
                if(closeDoorsStage1[i] ~= nil) then
                    closeDoorsStage1[i] = nil
                end
            end
        end
        Wait(5000)
    end
end)

Citizen.CreateThread(function() 
    while true do
        if #closeDoorsStage1 > 0 then
            local inZone = false
            local custDist = -1
            for i=1,#distantArea do
                local area = distantArea[i]
                if not inZone and #(plyCoords - vector3(area[1],area[2],area[3])) < area[4] then 
                    inZone = true
                    custDist = area[4]
                end
            end
            if not inZone then
                distvariable = 20.0
                drawdist = 2.0
            else
                if custDist ~= -1 then
                    distvariable = custDist+5.0
                    drawdist = custDist+1.0
                else
                    distvariable = 40.0
                    drawdist = 20.0
                end
            end
        end

        for i, door in pairs(closeDoorsStage1) do
            local distance = #(plyCoords - vector3(door["x"], door["y"], door["z"]))
            
            if distance < distanceCheckStage2 then
                closeDoorsStage2[i] = door
            else
                if(closeDoorsStage2[i] ~= nil) then
                    closeDoorsStage2[i] = nil
                end
            end
        end
        Wait(3000)
        closeDoorsStage2 = {}
        updatedCurrentStage = 0
        lastStaged = {}
    end
end)


Citizen.CreateThread(function() 
    while true do
        local hasEntered = false
        for i, door in pairs(closeDoorsStage2) do
            if updatedCurrentStage == 0 then
                hasEntered = true
                local obj = nil
                if (type(door["doorType"]) == "number") then
                    obj = GetClosestObjectOfType(door["x"], door["y"], door["z"], distvariable, door["doorType"], 0, 0, 0)
                else
                    obj = GetClosestObjectOfType(door["x"], door["y"], door["z"], distvariable, GetHashKey(door["doorType"]), 0, 0, 0)
                end
                lastStaged[i] = obj
            end

            if door["lock"] ~= nil then
                if door["lock"] == 1 then 
                    FreezeEntityPosition(lastStaged[i], true)
                else
                    FreezeEntityPosition(lastStaged[i], false)
                end
            end
        end
        if hasEntered and updatedCurrentStage == 0 then updatedCurrentStage = 1 hasEntered = false  end
        Wait(200)
    end
end)


Citizen.CreateThread(function()
    while true do
        local found = false
        for i, door in pairs(closeDoorsStage2) do
            local distance = #(plyCoords - vector3(door["x"], door["y"], door["z"]))
            if distance < currentTargetDist then
                found = true
                TargetClosest = i
                currentTargetDist = distance
                targetDoor = closeDoorsStage2[i]
            end
        end

        if not found then closeDoorsStage2 = {} end
        Wait(500)
        currentTargetDist = 999999
        newestTargetID = 0
        TargetClosest = 0
    end 
end)


RegisterNetEvent("doors:resetTimer")
AddEventHandler("doors:resetTimer", function()
  closestTimer = 0
end)

local closestTimer = 999999
local newestTargetIDObject = 0
local objFound = nil

local newestTargerIDCoordsDoor = 0
local doorCoordsOffset = {}
local doorCoords = {}
local newestTargetID = 0

Citizen.CreateThread(function()

    while true do
        Citizen.Wait(5)
        local curClosestNum = TargetClosest
        local closestString = "None"
        local newaddition = currentTargetDist
        if newaddition < closestTimer then
            closestTimer = math.floor(newaddition)
        end
        if currentTargetDist < distvariable and targetDoor ~= nil then
            closestTimer = 0
            if newestTargetID == 0 or newestTargetID ~= curClosestNum then
                newestTargetID = curClosestNum
                if (type(targetDoor["doorType"]) == "number") then
                    objFound = GetClosestObjectOfType(targetDoor["x"], targetDoor["y"], targetDoor["z"], distvariable, targetDoor["doorType"], 0, 0, 0)
                else
                    objFound = GetClosestObjectOfType(targetDoor["x"], targetDoor["y"], targetDoor["z"], distvariable, GetHashKey(targetDoor["doorType"]), 0, 0, 0)
                end
            end

            objCoords = GetEntityCoords(objFound)
            local limit = 1.0
            if targetDoor["doorType"] == -550347177
            or targetDoor["doorType"] == -983965772
            or targetDoor["doorType"] == 'prop_ch_025c_g_door_01'
            or targetDoor["doorType"] == 'gabz_mrpd_bollards1'
            or targetDoor["doorType"] == 'gabz_mrpd_bollards2'
            or targetDoor["doorType"] == 'lost_mc_door_01'
            or targetDoor["doorType"] == 'gabz_mrpd_garage_door'
            or targetDoor["doorType"] ==  -1871759441 
            then
                limit = 4.0
            end

            if targetDoor["doorType"] ==  213067247 
            then
                limit = 25.0
            end
            if cZ(objCoords["z"],targetDoor["z"],limit) then
                if newestTargerIDCoordsDoor == 0 or newestTargerIDCoordsDoor ~= curClosestNum then
                    newestTargerIDCoordsDoor = curClosestNum
                    doorCoords = objCoords 
                end 

                if(FFRP.offSet[targetDoor["doorType"]]) then
                    if (type(targetDoor["doorType"]) == "number") then
                        local pos = FFRP.offSet[targetDoor["doorType"]]
                        doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, pos[1], pos[2], pos[3])
                    else
                        local pos = FFRP.offSet[targetDoor["doorType"]]
                        if pos ~= nil and pos[1] then
                            doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, pos[1], pos[2], pos[3])
                        else
                            doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.2, 0.0, 0.1)
                        end
                    end
                else
                    if (type(targetDoor["doorType"]) ~= "number") then
                        doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.2, 0.0, -0.1)
                    else
                        doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.2, 0.0, 0.1) 
                    end
                end
            end
        end

        if curClosestNum ~= 0 and targetDoor ~= nil then
            if targetDoor["lock"] == 1 then
                if (curClosestNum > 199 and curClosestNum < 219) or (curClosestNum > 20 and curClosestNum < 57) or (curClosestNum > 9 and curClosestNum < 13) then
                    closestString = "Locked (" .. curClosestNum .. ")"
                else
                    closestString = "Locked"
                end
            else 
                if (curClosestNum > 199 and curClosestNum < 219) or (curClosestNum > 20 and curClosestNum < 57) or (curClosestNum > 9 and curClosestNum < 13) then
                    closestString = "Unlocked (" .. curClosestNum .. ")"
                else
                    closestString = "Unlocked"
                end
            end
            if isKeyDoor(curClosestNum) then
                drawdist = 2.0
            else
                drawdist = 12.0
            end
            if currentTargetDist < drawdist then
                if isKeyDoor(curClosestNum) then
                    DrawText3DTest(doorCoordsOffset["x"], doorCoordsOffset["y"], doorCoordsOffset["z"], "["..Controlkey["generalUse"][2].."] - " .. closestString .. "" )
                else
                    if targetDoor["x"] == nil or targetDoor == nil or targetDoor["x"] == 0.0 then
                        DrawText3DTest(doorCoordsOffset["x"], doorCoordsOffset["y"], doorCoordsOffset["z"], "["..Controlkey["generalUse"][2].."] - " .. closestString .. "" )
                    else
                        DrawText3DTest(targetDoor["x"], targetDoor["y"], targetDoor["z"], "["..Controlkey["generalUse"][2].."] - " .. closestString .. "" )
                    end
                end

                if IsControlJustReleased(1,  Controlkey["generalUse"][1]) then
                    if OpenCheck(curClosestNum) then
                        local shortcheck = #(vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]) - vector3(doorCoordsOffset["x"], doorCoordsOffset["y"], doorCoordsOffset["z"]))
                        if shortcheck > 1.7 and isKeyDoor(curClosestNum) then
                            -- dont work til close enough
                        else
                            TriggerEvent("dooranim")

                            if isKeyDoor(curClosestNum) then
                                TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'keydoors', 0.4)
                            end
                            if targetDoor["lock"] == 0 then
                                if targetDoor["keypad"] ~= nil then
                                    TriggerEvent('keypad:attempt', targetDoor["keypad"], curClosestNum)
                                else
                                    if targetDoor["skipSwing"] == true then
                                        TriggerServerEvent("ffrp-doors:alterlockstate",curClosestNum)
                                    else
                                        local active = true
                                        local swingcount = 0
                                        while active do
                                            Citizen.Wait(0)
                                            locked, heading = GetStateOfClosestDoorOfType(GetHashKey(targetDoor["doorType"]), doorCoords["x"], doorCoords["y"], doorCoords["z"]) 
                                            heading = math.ceil(heading * 100) 
                                            DrawText3DTest(doorCoordsOffset["x"], doorCoordsOffset["y"], doorCoordsOffset["z"], "Locking" )
                                            
                                            local dist = #(plyCoords - vector3(targetDoor["x"], targetDoor["y"], targetDoor["z"]))
                                            local dst2 = #(plyCoords - vector3(1830.45, 2607.56, 45.59))

                                            if heading < 1.5 and heading > -1.5 then
                                                swingcount = swingcount + 1
                                            end
                                            if dist > 150.0 or swingcount > 100 or dst2 < 200.0 or timer == 10000 then
                                                active = false
                                            end
                                        end
                                        TriggerServerEvent("ffrp-doors:alterlockstate",curClosestNum)
                                    end
                                end
                            else
                                if targetDoor["keypad"] ~= nil then
                                    TriggerEvent('keypad:attempt', targetDoor["keypad"], curClosestNum)
                                else
                                    local active = true
                                    local swingcount = 0
                                    while active do
                                        Citizen.Wait(1)
                                        DrawText3DTest(doorCoordsOffset["x"], doorCoordsOffset["y"], doorCoordsOffset["z"], "Unlocking" )
                                        swingcount = swingcount + 1
                                        if swingcount > 100 then
                                            active = false
                                        end
                                    end
                                    TriggerServerEvent("ffrp-doors:alterlockstate",curClosestNum)
                                end
                            end
                        end
                    end
                end 
            end
        end
    end
end)

function OpenCheck(curClosestNum)
    local gangType = exports["ffrp-ped"]:isPed("gang")
    if (job == "unemployed" or job == "judge" or job == "ambulance" or job == "offambulance" or hasSteamIdKeys) and (curClosestNum == 146 or curClosestNum == 147) then
        return false
    end

    if curClosestNum ~= 0 and (job == "offpolice" or job == "police" or job == "judge" or job == "offambulance" or job == "ambulance" or job == "DA" or job == "dispatch" or job == "doc" or hasSteamIdKeys) then
        return true
    end

    if curClosestNum >= 1 and curClosestNum <= 84 and (job ~= "police") then
        return false
    end

    if curClosestNum >= 101 and curClosestNum <= 120 and (job ~= "police") then
        return false
    end

    if curClosestNum > 141 and curClosestNum < 144 and (job == "mechanic") then
        return true
    end

    if curClosestNum > 96 and curClosestNum < 99 and (job == 'tuner') then
        return true
    end

    if curClosestNum >= 90 and curClosestNum <= 95 and (job == 'realestateagent') then
        return true
    end

    if (curClosestNum == 146 or curClosestNum == 147 or curClosestNum == 157 or curClosestNum == 158) and gangType == 1 then
        return true
    end

    if (isDoc or isMedic or isTher) and ((curClosestNum >= 251 and curClosestNum <= 264) or curClosestNum == 275 or curClosestNum == 276 or curClosestNum == 277)then
        return true
    end

    if (curClosestNum > 109 and curClosestNum < 137) and (job == "police" or job == "ambulance") then
        return true
    end

    if (curClosestNum == 173 or curClosestNum == 174) and (job == "police" or job == "ambulance") then
        return true
    end

    if (curClosestNum >= 156 and curClosestNum <= 172) and (job == "cartel" or job == "police") then
        return true
    end

    if (curClosestNum == 147 or curClosestNum == 148 or curClosestNum == 149) and (job == "police" or job == "ambulance" or job == "mechanic") then
        return true
    end

    if (curClosestNum == 150 or curClosestNum == 151 or curClosestNum == 152 or curClosestNum == 153 or curClosestNum == 154 or curClosestNum == 155 ) and (job == "police" or job == "ambulance" or job == "burgershot") then
        return true
    end

    if (curClosestNum == 135 or curClosestNum == 136 or curClosestNum == 137) and (job == "vu" or job == "vu2") then
        return true
    end

    if (curClosestNum == 135 or curClosestNum == 136 or curClosestNum == 137 or curClosestNum == 138 or curClosestNum == 139 or curClosestNum == 140 ) and (job == "vu2") then
        return true
    end

    if (curClosestNum >= 150 or curClosestNum <= 157) and (job == "lostmc") then
        return true
    end

    if FFRP.DoorCoords[curClosestNum]["keypad"] ~= nil then
        return true
    end

    local foundValid = false
    for k,v in pairs(FFRP.rankCheck) do
        local rank = exports["ffrp-ped"]:GroupRank(k)
        for o,p in pairs(v) do
            if rank >= o and not foundValid then
                if p.between ~= nil then
                    for i=1,#p.between do
                        if curClosestNum >= p.between[i][1] and curClosestNum <= p.between[i][2] then foundValid = true end
                    end
                end

                if p.single ~= nil then
                    for i=1,#p.single do
                        if curClosestNum == p.single[i] then foundValid = true  end
                    end
                end
            end
        end
    end

    if foundValid then
        return true
    end
    return false
end


function isKeyDoor(num)
    if num == 0 then
        return false
    end
    if FFRP.DoorCoords[num]["doorType"] == "prop_gate_prison_01" then
        return false
    end
    if FFRP.DoorCoords[num]["doorType"] == 1286392437 then
        return false
    end
    if FFRP.DoorCoords[num]["doorType"] == "v_ilev_fin_vaultdoor" then
        return false
    end
    if FFRP.DoorCoords[num]["doorType"] == -1603817716 then
        return false
    end
    if FFRP.DoorCoords[num]["doorType"] == 1501451068 then
        return false
    end
    if FFRP.DoorCoords[num]["doorType"] == -550347177 then
        return false
    end
    if FFRP.DoorCoords[num]["doorType"] == "gabz_pillbox_dlc_gate" then
        return false
    end
    if FFRP.DoorCoords[num]["doorType"] == "gabz_mrpd_bollards1" then
        return false
    end
    if FFRP.DoorCoords[num]["doorType"] == "gabz_mrpd_bollards2" then
        return false
    end
    if FFRP.DoorCoords[num]["doorType"] == "gabz_mrpd_garage_door" then
        return false
    end
    if FFRP.DoorCoords[num]["doorType"] == "prop_facgate_07b" then
        return false
    end
    if FFRP.DoorCoords[num]["doorType"] == "lost_mc_door_01" then
        return false
    end
    if FFRP.DoorCoords[num]["doorType"] == "lost_mc_gate" then
        return false
    end
    if FFRP.DoorCoords[num]["doorType"] == "v_ilev_carmod3door" then
        return false
    end
    return true
end

RegisterNetEvent('ffrp:playerBecameJob')
AddEventHandler('ffrp:playerBecameJob', function(jobPassed)
    job = jobPassed.name
end)

