
--[[local recoils = {
    [453432689] = 1.1, -- PISTOL
    [3219281620] = 1.1, -- PISTOL MK2
    [1593441988] = 0.5, -- COMBAT PISTOL
    [584646201] = 0.4, -- AP PISTOL
    [2578377531] = 1.3, -- PISTOL .50
    [324215364] = 0.4350, -- MICRO SMG
    [736523883] = 0.3, -- SMG
    [2024373456] = 0.1, -- SMG MK2
    [-270015777] = 0.3, -- ASSAULT SMG
    [-1074790547] = 0.35, -- ASSAULT RIFLE
    [961495388] = 0.023, -- ASSAULT RIFLE MK2
    [-2084633992] = 0.412, -- CARBINE RIFLE
    [4208062921] = 0.412, -- CARBINE RIFLE MK2
    [-1357824103] = 0.30, -- ADVANCED RIFLE
    [2634544996] = 0.016, -- MG
    [2144741730] = 0.017, -- COMBAT MG
    [3686625920] = 0.016, -- COMBAT MG MK2
    [487013001] = 0.4, -- PUMP SHOTGUN
    [2017895192] = 0.7, -- SAWNOFF SHOTGUN
    [3800352039] = 0.4, -- ASSAULT SHOTGUN
    [2640438543] = 0.4, -- BULLPUP SHOTGUN
    [911657153] = 0.0, -- STUN GUN
    [100416529] = 0.5, -- SNIPER RIFLE
    [205991906] = 0.7, -- HEAVY SNIPER
    [177293209] = 0.7, -- HEAVY SNIPER MK2
    [856002082] = 1.2, -- REMOTE SNIPER
    [2726580491] = 1.0, -- GRENADE LAUNCHER
    [1305664598] = 1.0, -- GRENADE LAUNCHER SMOKE
    [2982836145] = 0.0, -- RPG
    [1752584910] = 0.0, -- STINGER
    [1119849093] = 0.01, -- MINIGUN
    [3218215474] = 0.2, -- SNS PISTOL
    [1627465347] = 0.1, -- GUSENBERG
    [3231910285] = 0.011, -- SPECIAL CARBINE
    [-771403250] = 0.5, -- HEAVY PISTOL
    [2132975508] = 0.2, -- BULLPUP RIFLE
    [137902532] = 1.2, -- VINTAGE PISTOL
    [2828843422] = 0.7, -- MUSKET
    [984333226] = 0.2, -- HEAVY SHOTGUN
    [3342088282] = 0.3, -- MARKSMAN RIFLE
    [1672152130] = 0.3, -- HOMING LAUNCHER
    [1198879012] = 0.9, -- FLARE GUN
    [171789620] = 0.1, -- COMBAT PDW
    [3696079510] = 0.9, -- MARKSMAN PISTOL
    [1834241177] = 2.4, -- RAILGUN
    [-619010992] = 0.46, -- MACHINE PISTOL
    [3249783761] = 1.2, -- REVOLVER
    [4019527611] = 0.7, -- DOUBLE BARREL SHOTGUN
    [1649403952] = 0.053, -- COMPACT RIFLE
    [317205821] = 0.2, -- AUTO SHOTGUN
    [125959754] = 0.5, -- COMPACT LAUNCHER
    [3173288789] = 0.35, -- MINI SMG
}
local myRecoilFactor = 0.0

RegisterNetEvent("recoil:updateposition")
AddEventHandler("recoil:updateposition", function(sendFactor)
    
    myRecoilFactor = sendFactor / 5 + 0.0

end)

Citizen.CreateThread( function()

	local resetcounter = 0
	local jumpDisabled = false

  	while true do
    Citizen.Wait(100)

		if jumpDisabled and resetcounter > 0 and IsPedJumping(GetPlayerPed(-1)) then

			SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 3, 0, 0, 0)

			resetcounter = 0
		end

		if not jumpDisabled and IsPedJumping(GetPlayerPed(-1)) then

			jumpDisabled = true
			resetcounter = 10
			Citizen.Wait(1200)
		end

		if resetcounter > 0 then
			resetcounter = resetcounter - 1
		else
			if jumpDisabled then
				resetcounter = 0
				jumpDisabled = false
			end
		end
	end
end)






Citizen.CreateThread( function()


  while true do

	 if IsPedArmed(GetPlayerPed(-1), 6) then
	 	Citizen.Wait(1)
	 else
	 	Citizen.Wait(1500)
	 end

	    if IsPedShooting(PlayerPedId()) then

	        local _,wep = GetCurrentPedWeapon(PlayerPedId())
	        _,cAmmo = GetAmmoInClip(PlayerPedId(), wep)
	        if recoils[wep] and recoils[wep] ~= 0 then
	            tv = 0
	            if GetFollowPedCamViewMode() == 4 then
	                p = GetGameplayCamRelativePitch()
	                recoiling = 2
	                while recoiling > 0 do

	                    possiblerecoil = math.random(math.ceil(recoils[wep] * 400))
	                    recoilfactor = possiblerecoil/100
	                    dicks = math.random(100)
	                    recoilfactor = recoilfactor + myRecoilFactor
	                    SetGameplayCamRelativePitch(p+recoilfactor,0.5)
                
	                    recoiling = recoiling - 1
	                end
	            else
	                p = GetGameplayCamRelativePitch()
	                recoiling = 3
	                while recoiling > 0 do

	                    possiblerecoil = math.random(math.ceil(recoils[wep] * 450))
	                    recoilfactor = possiblerecoil/100
	                    dicks = math.random(100)
	                    recoilfactor = recoilfactor + myRecoilFactor
	                    SetGameplayCamRelativePitch(p+recoilfactor,0.25)
	                    recoiling = recoiling - 1
	                end
	            end

	        end
	    end
	end
end)]]


--###############
--#  Workout's
--##############


workoutAreas = {
    --[1] = { ["x"] = -1196.9790039063,["y"] = -1572.8973388672,["z"] = 4.6126470565796, ["h"] = 211.11492919922, ["workType"] = "Weights", ["emote"] = "world_human_muscle_free_weights_lo_res_base" },
    --[2] = { ["x"] = -1199.0599365234,["y"] = -1574.4929199219,["z"] = 4.6096420288086, ["h"] = 213.6491394043, ["workType"] = "Weights", ["emote"] = "world_human_muscle_free_weights_lo_res_base" },
    [1] = { ["x"] = -1204.496, ["y"] = -1560.324, ["z"] = 4.615, ["workType"] = "Pushups", ["emote"] = "world_human_push_ups_lo_res_base" },
    [2] = { ["x"] = -1208.074, ["y"] = -1563.436, ["z"] = 4.608, ["h"] = 306.336, ["workType"] = "Situps", ["emote"] = "world_human_sit_ups_lo_res_base" },
    [3] = { ["x"] = -1215.0224609375,["y"] = -1541.6857910156,["z"] = 4.7281851768494, ["h"] = 119.79830169678, ["workType"] = "Yoga", ["emote"] = "world_human_yoga_male_lo_res_base" },
    [4] = { ["x"] = -1217.5916748047,["y"] = -1543.162109375,["z"] = 4.7207465171814, ["h"] = 119.81834411621, ["workType"] = "Yoga", ["emote"] = "world_human_yoga_male_lo_res_base" },
    [5] = { ["x"] = -1220.8453369141,["y"] = -1545.0277099609,["z"] = 4.6919565200806, ["h"] = 119.8260345459, ["workType"] = "Yoga", ["emote"] = "world_human_yoga_male_lo_res_base" },
    [6] = { ["x"] = -1224.6988525391,["y"] = -1547.2470703125,["z"] = 4.6254777908325, ["h"] = 119.86821746826, ["workType"] = "Yoga", ["emote"] = "world_human_yoga_male_lo_res_base" },
    [7] = { ["x"] = -1228.4945068359,["y"] = -1549.4294433594,["z"] = 4.5562300682068, ["h"] = 119.87698364258, ["workType"] = "Yoga", ["emote"] = "world_human_yoga_male_lo_res_base" },

    --[10] =  { ['x'] = -1253.41,['y'] = -1601.65,['z'] = 3.15,['h'] = 213.34, ['info'] = ' Chinups 1', ["workType"] = "Chinups", ["emote"] = "chinups" },
    --[11] =  { ['x'] = -1252.43,['y'] = -1603.14,['z'] = 3.13,['h'] = 213.78, ['info'] = ' Chinups 2', ["workType"] = "Chinups", ["emote"] = "chinups" },
    --[12] =  { ['x'] = -1251.26,['y'] = -1604.81,['z'] = 3.14,['h'] = 217.94, ['info'] = ' Chinups 3', ["workType"] = "Chinups", ["emote"] = "chinups" },
}

function DrawText3DTest(x,y,z, text)
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

local inprocess = false
local returnedPass = false
local workoutType = 0

Citizen.CreateThread(function()
    while true do
      local playerped = GetPlayerPed(-1)
      local plyCoords = GetEntityCoords(playerped)  
      local waitCheck2 = GetDistanceBetweenCoords( GetEntityCoords( GetPlayerPed(-1) ), -1253.41,-1601.65,4.556230068206)
      local waitCheck = GetDistanceBetweenCoords( GetEntityCoords( GetPlayerPed(-1) ), -1228.4945068359,-1549.4294433594,4.556230068206)
        if (waitCheck > 40.0 and waitCheck2 > 40.0 ) or inprocess then
            Citizen.Wait(math.ceil(waitCheck))
        else
            Citizen.Wait(1)
            for i = 1, #workoutAreas do
                local distCheck = GetDistanceBetweenCoords( GetEntityCoords( GetPlayerPed(-1) ), workoutAreas[i]["x"], workoutAreas[i]["y"], workoutAreas[i]["z"])
                if distCheck < 4.0 then
                    DrawText3DTest(workoutAreas[i]["x"], workoutAreas[i]["y"], workoutAreas[i]["z"], "[E] to do " .. workoutAreas[i]["workType"] .. "" )
                end
                if distCheck < 1.0 then
                    if (IsControlJustReleased(1, 38)) then
                        returnedPass = false
                        workoutType = i
                        TriggerEvent("Start:workout",i)
                    end
                end
            end
        end
    end
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

RegisterNetEvent('Start:workout')
AddEventHandler('Start:workout', function(i)
    inprocess = true
    SetEntityCoords(GetPlayerPed(-1),workoutAreas[workoutType]["x"],workoutAreas[workoutType]["y"],workoutAreas[workoutType]["z"])
    SetEntityHeading(GetPlayerPed(-1),workoutAreas[workoutType]["h"])

    if i == 1 then
        loadAnimDict('amb@world_human_push_ups@male@idle_a')
        --while inprocess do
           -- Citizen.Wait(0)
            if not IsEntityPlayingAnim(GetPlayerPed(-1), 'amb@world_human_push_ups@male@idle_a', 'idle_d', 3) then
                TaskPlayAnim(GetPlayerPed(-1), 'amb@world_human_push_ups@male@idle_a', 'idle_d', 1.0, -1.0, -1, 1, 1, 0, 0, 0)
            end
        --end
    elseif i == 2 then
        loadAnimDict('amb@world_human_sit_ups@male@idle_a')
        --while inprocess do
            --Citizen.Wait(0)
            if not IsEntityPlayingAnim(GetPlayerPed(-1), 'amb@world_human_sit_ups@male@idle_a', 'idle_a', 3) then
                TaskPlayAnim(GetPlayerPed(-1), 'amb@world_human_sit_ups@male@idle_a', 'idle_a', 1.0, -1.0, -1, 1, 1, 0, 0, 0)
            end
        --end
    elseif i == 3 or i == 4 or i ==  5 or i == 6 or i == 7 then
        TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_YOGA", 0, 1)
    end

    exports['t0sic_loadingbar']:StartDelayedFunction('Doing ' .. workoutAreas[i]["workType"], 30000, function()
        ClearPedTasks(GetPlayerPed(-1))
        TriggerEvent('client:newStress',false, 10)
        exports['mythic_notify']:SendAlert('inform', 'Stress Removed', 3000)
        inprocess = false
    end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if inprocess then
            DisableAllControlActions(0)
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 2, true)
            EnableControlAction(0, 3, true)
            EnableControlAction(0, 4, true)
        end
    end
end)