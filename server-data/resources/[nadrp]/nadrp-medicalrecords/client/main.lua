ESX = nil
local myName = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('tac:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(250)
    end
    while ESX.GetPlayerData() == nil do
        Citizen.Wait(250)
    end
    TriggerServerEvent("nadrp-medicalrecords:server:getName", ESX.GetPlayerData().identifier)
end)

RegisterNUICallback("close", function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback("create", function(data)
    TriggerServerEvent("nadrp-medicalrecords:create", data, myName)
end)

RegisterNUICallback("search", function(data)
    TriggerServerEvent("nadrp-medicalrecords:server:search", data.input, myName)
end)

RegisterNetEvent("nadrp-medicalrecords:client:open")
AddEventHandler("nadrp-medicalrecords:client:open", function()
    SendNUIMessage({type = "open", name = myName})
    SetNuiFocus(true, true)
end)

RegisterNetEvent("nadrp-medicalrecords:client:search")
AddEventHandler("nadrp-medicalrecords:client:search", function(data)
    print(json.encode(data))
    SendNUIMessage({type = "search", result = data})
end)

RegisterNetEvent("nadrp-medicalrecords:getName")
AddEventHandler("nadrp-medicalrecords:getName", function(name)
    myName = name.firstname.. " " ..name.lastname
    -- myName = "nadrp nadrp"
end)