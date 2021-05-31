ESX = nil
local doorState = {}
local printatoc = true

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('ffrp-doors:alterlockstate')
AddEventHandler('ffrp-doors:alterlockstate', function(alterNum, state)
    if state ~= nil then
        FFRP.DoorCoords[alterNum]["lock"] = state
    else
        if FFRP.DoorCoords[alterNum]["lock"] == 0 then
            FFRP.DoorCoords[alterNum]["lock"] = 1
        else
            FFRP.DoorCoords[alterNum]["lock"] = 0
        end
    end
    TriggerClientEvent("ffrp-door:alterState",-1,alterNum,FFRP.DoorCoords[alterNum]["lock"])
end)