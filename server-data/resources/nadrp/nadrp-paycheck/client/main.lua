ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    while true do
        if #(vector3(-1082.24, -247.723, 37.76328) - GetEntityCoords(PlayerPedId())) < 5.0 then
            Citizen.Wait(0)
            DrawMarker(27,-1082.24, -247.723, 36.76328, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 1.7001, 0, 55, 240, 100, 0, 0, 0, 0)
            ShowHelpText('Press ~INPUT_CONTEXT~ to claim paycheck')
            if IsControlJustPressed(0,38) then
                TriggerServerEvent('nadrp-paycheck:hasPaycheck')
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

RegisterNetEvent('nadrp-paycheck:client:addPaycheck')
AddEventHandler('nadrp-paycheck:client:addPaycheck', function(amount)
    if amount ~= nil then
        TriggerServerEvent('nadrp-paycheck:addPaycheck', amount)
    end
end)

function ShowHelpText(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end