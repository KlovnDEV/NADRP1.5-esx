ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

local sleep = 1000
local TruckExists = false
local job = ''
local locations = {
    [1] = {["x"] = 446.028, ["y"] = -1242.527, ["z"] = 30.287, ["h"] = 359.355,  ["info"] = 'door'},
    [2] = {["x"] = 459.808, ["y"] = -1250.154, ["z"] = 29.736, ["h"] = 270.861,  ["info"] = 'Spawn'},
}

Citizen.CreateThread(function()
    while true do
        for i=1, #locations do
            local pos = GetEntityCoords(PlayerPedId())
            if #(vector3(locations[i]["x"], locations[i]["y"],locations[i]["z"]) - pos) < 10.0 and job == 'taco' then
                found = true
                if DoesEntityExist(truck) then
                    TruckExists = true
                else
                    TruckExists = false
                end
                if i == 1 then
                    if (#(vector3(locations[i]["x"], locations[i]["y"],locations[i]["z"]) - pos) < 5.0) then
                        if not TruckExists then
                            DrawText3D(locations[i]["x"], locations[i]["y"],locations[i]["z"], '[E] - Request taco truck')
                            if IsControlJustPressed(0, 38) then
                                local IsAreaClear = GetClosestVehicle(locations[2]["x"], locations[2]["y"], locations[2]["z"], 3.000, 0, 70)
                                if not DoesEntityExist(IsAreaClear) then
                                    SpawnTruck()
                                    exports['mythic_notify']:SendAlert('inform', 'Remember to return the truck or you will be charged for a new one!', 7500)
                                else
                                    exports['mythic_notify']:SendAlert('error', 'There seems to be a car in the way?', 6000)
                                end
                            end
                        else
                            DrawText3D(locations[i]["x"], locations[i]["y"],locations[i]["z"], 'You already have a truck out - ~r~[E] - ~w~$500 ~r~ for a new truck')
                            if IsControlJustPressed(0, 38) then
                                local IsAreaClear = GetClosestVehicle(locations[2]["x"], locations[2]["y"], locations[2]["z"], 3.000, 0, 70)
                                if not DoesEntityExist(IsAreaClear) then
                                    TriggerServerEvent('nadrp-taco:payTruckBill')
                                else
                                    exports['mythic_notify']:SendAlert('error', 'There seems to be a car in the way?', 6000)
                                end
                            end
                        end
                    end
                elseif i == 2 and TruckExists then
                    if (#(vector3(locations[i]["x"], locations[i]["y"],locations[i]["z"]) - pos) < 5.0) then
                        if IsPedInAnyVehicle(PlayerPedId(),false) then
                            DrawText3D(locations[i]["x"], locations[i]["y"],locations[i]["z"], '[E] - Return taco truck')
                            if IsControlJustPressed(0, 38) then
                                if TruckExists then
                                    if plate == GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false)) then
                                        DeleteEntity(truck)
                                        TruckExists = false
                                    else
                                        exports['mythic_notify']:SendAlert('error', 'This is not the truck we gave you!', 6000)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        if found then
            sleep = 0
        else
            sleep = 1000
        end

        Citizen.Wait(sleep)
        found = false
    end
end)

RegisterNetEvent('nadrp-truck:requestTruck')
AddEventHandler('nadrp-truck:requestTruck', function()
    SpawnTruck()
end)

RegisterNetEvent("nadrp:playerBecameJob")
AddEventHandler("nadrp:playerBecameJob", function(jobpassed)
    job = jobpassed.name
    if job == 'taco' then 
        tacoBlip = AddBlipForCoord(locations[1]["x"],locations[1]["y"],locations[1]["z"])

		SetBlipSprite (tacoBlip, 208)
		SetBlipDisplay(tacoBlip, 4)
		SetBlipScale  (tacoBlip, 0.8)
		SetBlipColour (tacoBlip, 5)
		SetBlipAsShortRange(tacoBlip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Attack-A-Taco')
		EndTextCommandSetBlipName(tacoBlip)
    end
end)

-- /////////////////
--//   Functions  //
--//////////////////

function SpawnTruck()
    local model = 'taco'
    RequestModel(model)
    while not HasModelLoaded(model) do 
        RequestModel(model)
        Citizen.Wait(0)
    end
    truck = CreateVehicle(GetHashKey(model), locations[2]["x"], locations[2]["y"], locations[2]["z"], locations[2]["h"], true, 0)
    SetVehicleOnGroundProperly(truck)
    SetVehicleNumberPlateText(truck, 'TACO-'..math.random(100,999))
    SetVehicleExtra(truck, 2, true)
    plate = GetVehicleNumberPlateText(truck)
    TriggerEvent("ARPF:spawn:recivekeys", truck, plate)
    TruckExists = true
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