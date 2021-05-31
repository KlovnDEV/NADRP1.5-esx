local display = false

local first = vector3(340.767, -582.28, 28.797)
local second = vector3(332.364, -595.546, 43.284)
local Roof = vector3(338.57, -583.669, 74.162)

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("Floor1", function()
    SetEntityCoords(GetPlayerPed(-1), first)
    SetDisplay(false)
end)

RegisterNUICallback("Floor2", function()
    SetEntityCoords(GetPlayerPed(-1), second)
    SetDisplay(false)
end)

RegisterNUICallback("Roof", function()
    SetEntityCoords(GetPlayerPed(-1), third)
    SetDisplay(false)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display)
        DisableControlAction(0, 2, display)
        DisableControlAction(0, 142, display)
        DisableControlAction(0, 18, display)
        DisableControlAction(0, 322, display)
        DisableControlAction(0, 106, display)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        coords = GetEntityCoords(GetPlayerPed(-1))
        if GetDistanceBetweenCoords(coords, first) < 1 then
            SetTextComponentFormat("STRING")
            AddTextComponentString("Press ~INPUT_CONTEXT~ to open menu")
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            if IsControlJustPressed(0, 38) then
                SetDisplay(not display)
            end
        end
    end
end)