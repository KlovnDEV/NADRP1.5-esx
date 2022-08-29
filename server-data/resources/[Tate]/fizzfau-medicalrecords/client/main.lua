ESX = nil
local myName = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(250)
    end
   --[[ while GetPlayerData().job == nil do
        Citizen.Wait(250)
    end

    
    TriggerServerEvent("fizzfau-medicalrecords:server:getName", PlayerData.identifier)
end)]]

RegisterNUICallback("close", function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback("create", function(data)
    TriggerServerEvent("fizzfau-medicalrecords:create", data, myName)
end)

RegisterNUICallback("search", function(data)
    TriggerServerEvent("fizzfau-medicalrecords:server:search", data.input, myName)
end)

RegisterNetEvent("fizzfau-medicalrecords:client:open")
AddEventHandler("fizzfau-medicalrecords:client:open", function()
    SendNUIMessage({type = "open", name = myName})
    SetNuiFocus(true, true)
end)

RegisterNetEvent("fizzfau-medicalrecords:client:search")
AddEventHandler("fizzfau-medicalrecords:client:search", function(data)
    print(json.encode(data))
    SendNUIMessage({type = "search", result = data})
end)

RegisterNetEvent("fizzfau-medicalrecords:getName")
AddEventHandler("fizzfau-medicalrecords:getName", function(name)
    myName = name.firstname.. " " ..name.lastname
    -- myName = "fizzfau fizzfau"
end)