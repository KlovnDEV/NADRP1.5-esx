
local PodiumThread = false
local inCasino = false

Citizen.CreateThread(function()
    exports["ffrp-polyzone"]:AddBoxZone("podium_room", vector3(1110.23, 221.74, -49.44), 53.8, 36.0, {
        heading=320,
        --debugPoly=true,
        minZ=-51.64,
        maxZ=-46.44,
        data = {
            id = "1"
        }
	})
end)

function PodiumThread()
    Citizen.CreateThread(function()
        while inCasino do
            Citizen.Wait(20)
            if podium == 0 or podium == nil then
                podium = GetClosestObjectOfType(1100.145, 219.914, -51.0, 5.0, 2733879850, 0, 0, 0)
            end
            local rotation = GetEntityHeading(podiumVehicle)
            SetEntityRotation(podium, 0.0, 0.0, rotation + 0.05, 1, true)
            SetEntityHeading(podiumVehicle, GetEntityHeading(podium))
        end
    end)
end

function SpawnPodiumVehicle()
    if not requesting then
        requesting = true
        local hash = GetHashKey('gtr')
        if not HasModelLoaded(hash) then
            RequestModel(hash)
            while not HasModelLoaded(hash) do
                Citizen.Wait(0)
            end
        end
        podiumVehicle = CreateVehicle(hash, 1100.145, 219.914, -51.0, 0.0, false, false)
        SetModelAsNoLongerNeeded(hash)
        FreezeEntityPosition(podiumVehicle, true)
        SetVehicleDoorsLocked(podiumVehicle, 2)
        requesting = false
    end
end

AddEventHandler('onResourceStop',function(resource)
    if resource == GetCurrentResourceName() then 
        DeleteEntity(podiumVehicle)
    end
end)

AddEventHandler("ffrp-polyzone:enter", function(zone, data, center) 
	if zone == "podium_room" then
        inCasino = true
        PodiumThread()
        SpawnPodiumVehicle()
    end
end)

AddEventHandler('ffrp-polyzone:exit', function(zone)
    if zone == "podium_room" then
        inCasino = false
        DeleteEntity(podiumVehicle)
        podium = 0
    end
end)