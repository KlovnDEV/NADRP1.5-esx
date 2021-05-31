-----------
-- 3D ME --
-----------

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/me', 'Can show personal actions, face expressions & much more.')
    TriggerEvent('chat:addSuggestion', '/roll', 'Roll dice and lose everything')
end)

local nbrDisplaying = 1

RegisterCommand('me', function(source, args, raw)
    local text = string.sub(raw, 4)
    TriggerServerEvent('3dme:shareDisplay', text)
end)

RegisterNetEvent('3dme:triggerDisplay')
AddEventHandler('3dme:triggerDisplay', function(text, source)
    local offset = 1 + (nbrDisplaying*0.15)
    Display(GetPlayerFromServerId(source), text, offset)
end)

function Display(mePlayer, text, offset)
    local displaying = true

    Citizen.CreateThread(function()
        Wait(5000)
        displaying = false
    end)

    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = #(vector3(coordsMe.x,coordsMe.y,coordsMe.z) - vector3(coords.x,coords.y,coords.z)) --Vdist2(coordsMe, coords)
            if dist < 20 then
                DrawText3D(coordsMe['x'], coordsMe['y'], coordsMe['z']+offset-1.250, text)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DrawText3D(x,y,z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local p = GetGameplayCamCoords()
  local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
  local scale = (1 / distance) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov
  if onScreen then
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
end

local rolling = false
RegisterCommand('roll', function(source, args, rawCommand)
    if rolling then
        return
    end
    rolling = true
    times = tonumber(args[1])
    weight = tonumber(args[2])
    loadAnimDict("anim@mp_player_intcelebrationmale@wank")
    TaskPlayAnim(GetPlayerPed(-1), "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(1500)
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'dice', 0.6)
    ClearPedSecondaryTask(GetPlayerPed(-1))
    local strg = ""
    for i = 1, times do
        if i == 1 then
            strg = strg .. " " .. math.random(times, weight) .. "/" .. weight
        else
            strg = strg .. " | " .. math.random(times, weight) .. "/" .. weight
        end
    end
    TriggerServerEvent('3dme:shareDisplay', 'Dice rolled ' .. strg)
    rolling = false
end)

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict( dict )
        Citizen.Wait(5)
    end
end