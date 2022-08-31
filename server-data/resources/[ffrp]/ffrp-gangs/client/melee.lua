ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

local found = false
local locations = {
    [1] = { ["x"] = -3155.655, ["y"] = 1125.23, ["z"] = 20.85889, ["h"] = 73.23055,  ["info"] = 'door'},
    [2] = { ["x"] = -3158.792,["y"] = 1126.055,["z"] = 20.84388, ["h"] = 340.2455,  ["info"] = 'garage'},
    [3] = { ["x"] = 892.6384, ["y"] = -3245.8664, ["z"] = -98.2645, ["info"] = 'inside'},
    [4] = { ["x"] = 903.7332, ["y"] = -3199.645, ["z"] = -97.18799, ["info"] = 'stash'},
}

local whitelisted = {
    1,
}

Citizen.CreateThread(function()
    while true do
        local pos = GetEntityCoords(PlayerPedId())

        if(Vdist(484.631, -1876.435, 26.135, pos.x, pos.y, pos.z) < 20.0)then
            found = true
            DrawMarker(27, 484.631, -1876.435, 26.135 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
            if(Vdist(484.631, -1876.435, 26.135, pos.x, pos.y, pos.z) < 3.0)then
                DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~ Yeet.")
                if IsControlJustPressed(1, 38) then
                    pos = GetEntityCoords(PlayerPedId(), false)
                    if(Vdist(484.631, -1876.435, 26.135, pos.x, pos.y, pos.z) < 3.0)then
                        TriggerEvent("server-inventory-open", "67", "Craft");
                        Wait(1000)
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



function IsMeleeWhitelisted()
    local cid = exports['ffrp-ped']:isPed('cid')
    for i=1, #whitelisted do
        if whitelisted[i] == cid then 
            return true
        end
    end
    return false
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
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