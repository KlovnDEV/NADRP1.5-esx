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
    TriggerServerEvent("ffrp-medicalrecords:server:getName", ESX.GetPlayerData().identifier)
end)

RegisterNUICallback("close", function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback("create", function(data)
    TriggerServerEvent("ffrp-medicalrecords:create", data, myName)
end)

RegisterNUICallback("search", function(data)
    TriggerServerEvent("ffrp-medicalrecords:server:search", data.input, myName)
end)

RegisterNetEvent("ffrp-medicalrecords:client:open")
AddEventHandler("ffrp-medicalrecords:client:open", function()
    SendNUIMessage({type = "open", name = myName})
    SetNuiFocus(true, true)
end)

RegisterNetEvent("ffrp-medicalrecords:client:search")
AddEventHandler("ffrp-medicalrecords:client:search", function(data)
    print(json.encode(data))
    SendNUIMessage({type = "search", result = data})
end)

RegisterNetEvent("ffrp-medicalrecords:getName")
AddEventHandler("ffrp-medicalrecords:getName", function(name)
    myName = name.firstname.. " " ..name.lastname
    -- myName = "ffrp ffrp"
end)