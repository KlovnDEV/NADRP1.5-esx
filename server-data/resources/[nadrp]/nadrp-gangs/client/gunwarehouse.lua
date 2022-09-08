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
    4, -- Reece
    2, -- Loke
    317,--Panduko
    751, --Vitaly
    --1, --Barry
    --1114,
}

Citizen.CreateThread(function()
    while true do
        local pos = GetEntityCoords(PlayerPedId())
        if #(vector3(locations[1]["x"], locations[1]["y"],locations[1]["z"]) - pos) <= 2.0 then
            found = true
            if IsControlJustPressed(0, 38) then
                if IsGunWhitelisted() then
                    SetEntityCoords(PlayerPedId(), locations[3]["x"], locations[3]["y"], locations[3]["z"])
                    Wait(500)
                end
            end
        end
        if #(vector3(locations[2]["x"], locations[2]["y"],locations[2]["z"]) - pos) <= 5.0 then
            found = true
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                if IsControlJustPressed(0, 38) then
                    if IsGunWhitelisted() then
                        SetEntityCoords(GetVehiclePedIsIn(PlayerPedId()), locations[3]["x"], locations[3]["y"], locations[3]["z"])
                        Wait(500)
                    end
                end
            end
        end
        if #(vector3(locations[3]["x"], locations[3]["y"],locations[3]["z"]) - pos) <= 5.0 then
            found = true
            if IsControlJustPressed(0, 38) then
                if IsGunWhitelisted() then
                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                        SetEntityCoords(GetVehiclePedIsIn(PlayerPedId()), locations[2]["x"], locations[2]["y"], locations[2]["z"])
                        SetEntityHeading(PlayerPedId(), locations[2]['h'])
                        Wait(500)
                    else
                        SetEntityCoords(PlayerPedId(), locations[1]["x"], locations[1]["y"], locations[1]["z"])
                        SetEntityHeading(PlayerPedId(), locations[1]['h'])
                        Wait(500)
                    end
                end
            end
        end

        if(Vdist(885.61,-3199.84,-98.19, pos.x, pos.y, pos.z) < 20.0) then
            found = true
            DrawMarker(27, 885.61,-3199.84,-98.19 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0) --- Gun warehouse
            if(Vdist(885.61,-3199.84,-98.19, pos.x, pos.y, pos.z) < 3.0) then
                DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~ CRAFT.")
                if IsControlJustPressed(1, 38) and IsGunWhitelisted() then	
                    pos = GetEntityCoords(PlayerPedId(), false)
                    if(Vdist(885.61,-3199.84,-98.19, pos.x, pos.y, pos.z) < 3.0) then
                       TriggerEvent("server-inventory-open", "6", "Craft");
                       Wait(1000)
                    end
                end
            end
        end

        if(Vdist(891.9258, -3197.145, -98.19632, pos.x, pos.y, pos.z) < 20.0)then
            found = true
            DrawMarker(27, 891.9258, -3197.145, -98.19632 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
            if(Vdist(891.9258, -3197.145, -98.19632, pos.x, pos.y, pos.z) < 3.0)then
                DisplayHelpText("Press ~INPUT_CONTEXT~ to ~b~ CRAFT.")
                if IsControlJustPressed(1, 38) and IsGunWhitelisted() then
                    pos = GetEntityCoords(PlayerPedId(), false)
                    if(Vdist(891.9258, -3197.145, -98.19632, pos.x, pos.y, pos.z) < 3.0)then
                        TriggerEvent("server-inventory-open", "8", "Craft");
                        Wait(1000)
                    end
                end
           end
        end

        if #(vector3(locations[4]["x"], locations[4]["y"],locations[4]["z"]) - pos) < 5.0 then
			found = true
			if #(vector3(locations[4]["x"], locations[4]["y"],locations[4]["z"]) - pos) < 2.0 then
				DrawText3D(locations[4]["x"], locations[4]["y"],locations[4]["z"], "[E] - Stash")
                if IsControlJustPressed(1, 38) then
                    if IsGunWhitelisted() then
                        TriggerEvent("server-inventory-open", "1", "gun-warehouse");
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

function IsGunWhitelisted()
    local cid = exports['nadrp-ped']:isPed('cid')
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