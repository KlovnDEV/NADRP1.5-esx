ESX = nil
local doorState = {}
local printatoc = true

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('nadrp-doors:alterlockstate')
AddEventHandler('nadrp-doors:alterlockstate', function(alterNum, state)
    if state ~= nil then
        nadrp.DoorCoords[alterNum]["lock"] = state
    else
        if nadrp.DoorCoords[alterNum]["lock"] == 0 then
            nadrp.DoorCoords[alterNum]["lock"] = 1
        else
            nadrp.DoorCoords[alterNum]["lock"] = 0
        end
    end
    TriggerClientEvent("nadrp-door:alterState",-1,alterNum,nadrp.DoorCoords[alterNum]["lock"])
end)