ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
local firstspawn = 0
local currentRuns = 0
local PickupRun = false
local onRun = false
local working = false
local finished = false
local Returned = false
local found = false
local detaching = false
local dropoff = 0
local pickup = 0
local trailer = 0
local oldspot = 0
local newSpots = {
    [1] = {["x"] = 212.567, ["y"] = 2803.256, ["z"] = 45.655, ["h"] = 100.938, ["Spawned"] = false}, --- Trailer Pickups
    [2] = {["x"] = 614.925, ["y"] = 2794.333, ["z"] = 42.096, ["h"] = 2.248, ["Spawned"] = false},  --{info: trailer1},
    [3] = {["x"] = 1062.063, ["y"] = 2660.07, ["z"] = 39.557, ["h"] = 357.941, ["Spawned"] = false}, --{info: trailer2},
    [4] = {["x"] = 1984.012, ["y"] = 3781.553, ["z"] = 32.181, ["h"] = 207.266, ["Spawned"] = false},  --{info: trailer3},
}

local parkSpots = {
    [1] = {["x"] = 929.247, ["y"] = -3128.78, ["z"] = 5.901, ["h"] = 177.936},
    [2] = {["x"] = 924.926, ["y"] = -3129.198, ["z"] = 5.901, ["h"] = 176.857},
    [3] = {["x"] = 920.793, ["y"] = -3128.813, ["z"] = 5.901, ["h"] = 180.46},
    [4] = {["x"] = 928.728, ["y"] = -3153.766, ["z"] = 5.901, ["h"] = 181.81},
    [5] = {["x"] = 912.823, ["y"] = -3153.701, ["z"] = 5.901, ["h"] = 178.495},
    [6] = {["x"] = 945.184, ["y"] = -3183.409, ["z"] = 5.901, ["h"] = 179.67},
    [7] = {["x"] = 965.604, ["y"] = -3184.414, ["z"] = 5.901, ["h"] = 179.329},
    [8] = {["x"] = 1048.359, ["y"] = -3208.85, ["z"] = 5.901, ["h"] = 188.102},
    [9] = {["x"] = 1034.421, ["y"] = -3205.66, ["z"] = 5.901, ["h"] = 182.101},
    [10] = {["x"] = 1010.355, ["y"] = -3209.059, ["z"] = 5.901, ["h"] = 176.1},
    [11] = {["x"] = 994.142, ["y"] = -3207.955, ["z"] = 5.901, ["h"] = 167.099},
    [12] = {["x"] = 1005.304, ["y"] = -3183.107, ["z"] = 5.901, ["h"] = 188.097},
    [13] = {["x"] = 1020.748, ["y"] = -3180.91, ["z"] = 5.901, ["h"] = 194.097},
    [14] = {["x"] = 1037.525, ["y"] = -3182.941, ["z"] = 5.901, ["h"] = 191.096}
}

local plate = "Truck" .. math.ceil(math.random(100,999))
RegisterNetEvent('RS7x:Spawntruck')
AddEventHandler('RS7x:Spawntruck', function(FirstRun, TrailerOnly)
    print('Spawning Truck/Trailer')
    --###############
    --    Truck
    --###############
    if FirstRun then
        local vehicle = GetHashKey('phantom')
        RequestModel(vehicle)
        while not HasModelLoaded(vehicle) do
            Wait(1)
        end

        local truck = CreateVehicle(vehicle, 149.16, 6423.52, 31.29, 253.82, true, false)

        SetVehicleNumberPlateText(truck, plate)
        SetModelAsNoLongerNeeded(truck)
        TriggerEvent("ARPF:spawn:recivekeys",truck,GetVehicleNumberPlateText(truck))
        --###############
        --    Trailer
        --###############

        local trailerHash = GetHashKey('trailers4')
        
        RequestModel(trailerHash)
        while not HasModelLoaded(trailerHash) do
            Wait(1)
        end

        local Tplate = plate
        trailer = CreateVehicle(trailerHash, 138.19, 6367.14, 31.38, 28.15, true, false)
        SetVehicleNumberPlateText(trailer, Tplate)
        SetModelAsNoLongerNeeded(trailer)
    end

    if TrailerOnly then
        local trailerHash = GetHashKey('trailers4')
        RequestModel(trailerHash)
        while not HasModelLoaded(trailerHash) do
            Wait(1)
        end

        local Tplate = plate
        trailer = CreateVehicle(trailerHash, newSpots[pickup]["x"], newSpots[pickup]["y"], newSpots[pickup]["z"], newSpots[pickup]["h"], true, false)
        SetVehicleNumberPlateText(trailer, Tplate)
        SetModelAsNoLongerNeeded(trailer)
        print(pickup)
    end

end)

Citizen.CreateThread(function()
    while true do
        local pos = GetEntityCoords(PlayerPedId())
        if working and not finished then
            if not DoesBlipExist(Blip3) then
                Blip3 = AddBlipForCoord(144.919, 6365.188, 31.529)
                SetBlipSprite(Blip3,  477)
                SetBlipColour(Blip3,  1)
                SetBlipAsShortRange(Blip3)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("Return Truck")
                EndTextCommandSetBlipName(Blip3)
            end
        elseif working and finished then
            if not DoesBlipExist(Blip3) then
                SetNewWaypoint(144.919, 6365.188)
                Blip3 = AddBlipForCoord(144.919, 6365.188, 31.529)
                SetBlipSprite(Blip3,  477)
                SetBlipColour(Blip3,  1)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("Return Truck")
                EndTextCommandSetBlipName(Blip3)
            end
        end
        if #(vector3(pos.x,pos.y,pos.z) - vector3(122.49, 6406.1, 31.36)) < 4.0 and not working then
            found = true
            DrawText3Ds(122.49, 6406.1, 31.36, 'Press ~g~[E]~w~ to start doing truck job')
            if IsControlJustPressed(0, 38) then
                exports["mythic_notify"]:SendAlert('inform', 'Go pick up the trailer on the side of and deliver it to the docks')
                local str = [[ You can finish anytime you like just come back here and collect your paycheck. Also
                    Remember to return the truck at the side of the building.
                ]]
                TriggerEvent('chat:addMessage', {
                    template = '<div class="chat-message nonemergency">[SYSTEM] : {0} </div>',
                    args = {str}
                });
                TriggerEvent('RS7x:Spawntruck', true, false)
                dropoff = math.random(#parkSpots)
                pickup = math.random(#newSpots)
                onRun = true
                working = true
            end
        else
            if #(vector3(pos.x,pos.y,pos.z) - vector3(122.49, 6406.1, 31.36)) < 4.0 and working then
                found = true
                DrawText3Ds(122.49, 6406.1, 31.36, 'Press ~g~[E]~w~ to collect your paycheck')
                if IsControlJustPressed(0,38) then
                    TriggerServerEvent('RS7xTrucker:PayPlayer', 1500, currentRuns)
                    Wait(3000)
                    ResetRuns()
                end
            end
        end
        if working then
            if #(vector3(pos.x,pos.y,pos.z) - vector3(144.919, 6365.188, 31.529)) < 10.0 and working and not Returned then
                found = true
                DrawText3Ds(144.919, 6365.188, 31.529, 'Press ~g~[E]~w~ to Return Truck')
                if IsControlJustPressed(0,38) then
                    if GetVehicleNumberPlateText(truck) == Plate then
                        DeleteVehicle(GetVehiclePedIsIn(PlayerPedId(), false))
                        Returned = true
                    else
                        exports["mythic_notify"]:SendAlert('error', 'This is not the company truck')
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
        if PickupRun then
            Citizen.Wait(0)
            RemoveBlip(Blip)
            if currentRuns == 5 then
                onRun = false
                PickupRun = false
                finished = true
            end
            if currentRuns < 5 then
                if oldspot ~= 0 then
                    if #(GetEntityCoords(PlayerPedId()) - vector3(parkSpots[oldspot]["x"], parkSpots[oldspot]["y"], parkSpots[oldspot]["z"])) > 50.0 then
                        DeleteVehicle(trailer)
                        oldspot = 0
                    end
                end

                if not DoesBlipExist(Blip2) then
                    SetNewWaypoint(newSpots[pickup]["x"], newSpots[pickup]["y"])
                    Blip2 = AddBlipForCoord(newSpots[pickup]["x"], newSpots[pickup]["y"], newSpots[pickup]["z"])
                    SetBlipSprite(Blip2,  477)
                    SetBlipColour(Blip2,  2)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Pick Up Trailer")
                    EndTextCommandSetBlipName(Blip)
                end

                local hasTrailer = false
                local pos = GetEntityCoords(PlayerPedId())
                local dstCheck = #(vector3(newSpots[pickup]["x"], newSpots[pickup]["y"], newSpots[pickup]["z"]) - vector3(pos.x,pos.y,pos.z))
                local RecentSpawn = newSpots[pickup]["Spawned"] == true

                if dstCheck <= 50.0 and not RecentSpawn then
                    newSpots[pickup]["Spawned"] = true
                    Citizen.Wait(3000)
                    TriggerEvent('RS7x:Spawntruck', false, true)
                end

                if dstCheck < 20.0 and not hasTrailer then
                    DrawMarker(1, newSpots[pickup]["x"], newSpots[pickup]["y"], newSpots[pickup]["z"]-2, 0, 0, 0, 0, 0, 0, 3.801, 3.8001, 3.0001, 0, 255, 0, 100, 0, 0, 0, 0)
                    if not hasTrailer then
                        DrawText3Ds(newSpots[pickup]["x"], newSpots[pickup]["y"], newSpots[pickup]["z"], 'Pickup Trialer to Continue')
                    end
                end

                if dstCheck <= 10.0 then
                    if GetVehicleTrailerVehicle(GetVehiclePedIsIn(PlayerPedId()), GetHashKey('trailers4')) then
                        hasTrailer = true
                    end
                    if hasTrailer then
                        RemoveBlip(Blip2)
                        onRun = true
                        ResetSpawns()
                        PickupRun = false
                    end
                end
            end
        else
            Citizen.Wait(500)
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        if onRun then
            Citizen.Wait(0)
            RemoveBlip(Blip2)
            if currentRuns == 5 then
                onRun = false
                PickupRun = false
                working = true
                finished = true
                RemoveBlip(Blip)
                RemoveBlip(Blip2)
                exports['mythic_notify']:SendAlert('error', 'You have Completed your list go back and return the truck then collect your paycheck')
            end
            if currentRuns < 5 then 
                if not DoesBlipExist(Blip) then
                    SetNewWaypoint(parkSpots[dropoff]["x"], parkSpots[dropoff]["y"])
                    Blip = AddBlipForCoord(parkSpots[dropoff]["x"], parkSpots[dropoff]["y"], parkSpots[dropoff]["z"])
                    SetBlipSprite(Blip,  477)
                    SetBlipColour(Blip,  2)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Deliver Trailer")
                    EndTextCommandSetBlipName(Blip)
                end
                local pos = GetEntityCoords(PlayerPedId())
                if #(vector3(parkSpots[dropoff]["x"], parkSpots[dropoff]["y"], parkSpots[dropoff]["z"]) - vector3(pos.x,pos.y,pos.z)) <= 20.0 then
                    DrawMarker(1, parkSpots[dropoff]["x"], parkSpots[dropoff]["y"], parkSpots[dropoff]["z"]-2, 0, 0, 0, 0, 0, 0, 3.801, 3.8001, 3.0001, 0, 255, 0, 100, 0, 0, 0, 0)
                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                        DrawText3Ds(parkSpots[dropoff]["x"], parkSpots[dropoff]["y"], parkSpots[dropoff]["z"], 'Exit Vehicle to Detach Trailer')
                    else
                        DrawText3Ds(parkSpots[dropoff]["x"], parkSpots[dropoff]["y"], parkSpots[dropoff]["z"], 'Press ~g~[E]~w~ To deliver goods')
                    end

                    if #(vector3(parkSpots[dropoff]["x"], parkSpots[dropoff]["y"], parkSpots[dropoff]["z"]) - vector3(pos.x,pos.y,pos.z)) <= 10.0 then
                        local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.001, 0, 70)
                        if DoesEntityExist(vehicle) then
                            if GetEntityModel(vehicle) == GetHashKey('phantom') then
                                if GetVehicleTrailerVehicle(vehicle, GetHashKey('trailers4')) then
                                    if IsControlJustPressed(0,38) then
                                        detaching = true
                                        TriggerEvent('RS7xTrucker:detachAnim')
                                        local finished = exports['ffrp-taskbar']:taskBar(10000, 'Detaching Trailer')
                                        detaching = false
                                        if finished == 100 then
                                            oldspot = dropoff
                                            DetachVehicleFromTrailer(vehicle)
                                            dropoff = math.random(#parkSpots)
                                            pickup = math.random(#newSpots)
                                            PickupRun = true
                                            onRun = false
                                            currentRuns = currentRuns + 1
                                            if currentRuns == 5 then
                                                exports['mythic_notify']:DoHudText('error', 'You have Completed your list go back and collect your paycheck')
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            Citizen.Wait(500)
        end
    end
end)

function ResetRuns()
    PickupRun = false
    onRun = false
    working = false
    finished = false
    Returned = false
    currentRuns = 0
    ResetSpawns()
    if DoesBlipExist(Blip2) then
        RemoveBlip(Blip2)
    end
    if DoesBlipExist(Blip) then
        RemoveBlip(Blip)
    end
    print('RunsReset ? Should be 0 || ' .. ' #'..currentRuns)
end

function ResetSpawns()
    for i=1, #newSpots do
        newSpots[i]["Spawned"] = false
    end
end

function DrawText3Ds(x,y,z,text)
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

RegisterNetEvent('RS7xTrucker:detachAnim')
AddEventHandler('RS7xTrucker:detachAnim', function()
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(0)
    end

    while detaching do
        local anim = IsEntityPlayingAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 3)
        if not anim then
           TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end
end)

AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
        local JobBlip = AddBlipForCoord(122.49, 6406.1, 31.36)
        SetBlipSprite(JobBlip,  477)
        SetBlipColour(JobBlip,  4)
        SetBlipAsShortRange(JobBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Truck Job")
        EndTextCommandSetBlipName(JobBlip)
		firstspawn = 1
	end
end)
