ESX						= nil
local PlayerData		= {}
local loaded = false
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('tac:playerLoaded')
AddEventHandler('tac:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

local invehicle = false
local HudStage = 1
local lastValues = {}
local currentValues = {
	["health"] = 100,
	["armor"] = 100,
	["hunger"] = 100,
	["thirst"] = 100,
	["oxy"] = 100,
	["voice"] = 2,
	["dev"] = false,
	["devdebug"] = false,
	["radio"] = false,
}

RegisterNetEvent('car:windowsdown')
AddEventHandler('car:windowsdown', function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())	
	for i = -1, 6 do
		if GetPedInVehicleSeat(veh, i) == PlayerPedId() then
			RollDownWindow(veh, i+1)
		end
	end	
end)

RegisterNetEvent('client:anchor')
AddEventHandler('client:anchor', function()
    local currVeh = GetVehiclePedIsIn(PlayerPedId(), false)
    if currVeh ~= 0 then
        local vehModel = GetEntityModel(currVeh)
        if vehModel ~= nil and vehModel ~= 0 then
            if DoesEntityExist(currVeh) then
                if IsThisModelABoat(vehModel) or IsThisModelAJetski(vehModel) or IsThisModelAnAmphibiousCar(vehModel) or IsThisModelAnAmphibiousQuadbike(vehModel) then
                	local finished = exports["nadrp-taskbar"]:taskBar(2000,"Toggling Anchor")
					if (finished ~= 100) then
					    return
					end
                    if IsBoatAnchoredAndFrozen(currVeh) then
                    	TriggerEvent("notification","Anchor Disabled")
                        SetBoatAnchor(currVeh, false)
                        SetBoatFrozenWhenAnchored(currVeh, false)
                        SetForcedBoatLocationWhenAnchored(currVeh, false)
                    elseif not IsBoatAnchoredAndFrozen(currVeh) and CanAnchorBoatHere(currVeh) and GetEntitySpeed(currVeh) < 3 then
                    	SetEntityAsMissionEntity(currVeh,false,true)
                    	TriggerEvent("notification","Anchor Enabled")
                        SetBoatAnchor(currVeh, true)
                        SetBoatFrozenWhenAnchored(currVeh, true)
                        SetForcedBoatLocationWhenAnchored(currVeh, true)
                    end
                end
            end
        end
    end
end)


local recoils = {
	-- pistols
	[416676503] = 0.34,
	--smg
	[-957766203] = 0.5,
	-- rifles
	[970310034] = 0.14,
}

local myRecoilFactor = 0.0
RegisterNetEvent("recoil:updateposition")
AddEventHandler("recoil:updateposition", function(sendFactor)
    myRecoilFactor = sendFactor / 5 + 0.0
end)

currentValues["hunger"] = 100
currentValues["thirst"] = 100

hunger = "Full"
thirst = "Sustained"
local cruise = {enabled = false, speed = 0, airTime = 0}

function getVehicleInDirection(coordFrom, coordTo)
	local offset = 0
	local rayHandle
	local vehicle

	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		
		offset = offset - 1

		if vehicle ~= 0 then break end
	end
	
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	
	if distance > 3000 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

RegisterNetEvent("disableHUD")
AddEventHandler("disableHUD", function(passedinfo)
	HudStage = passedinfo
end)

speedoON = false
RegisterNetEvent('stopSpeedo')
AddEventHandler('stopSpeedo', function()
	if speedoON then
		speedoON = false

		return
	end
end)

oxyOn = false
attachedProp = 0
attachedProp2 = 0

function removeAttachedProp2()
	DeleteEntity(attachedProp2)
	attachedProp2 = 0
end

function removeAttachedProp()
	DeleteEntity(attachedProp)
	attachedProp = 0
end

function attachProp2(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
	removeAttachedProp2()
	attachModel = GetHashKey(attachModelSent)
	boneNumber = boneNumberSent
	local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
	--local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(100)
	end
	attachedProp2 = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
	exports["nadrp-ped"]:GlobalObject(attachedProp2)
	AttachEntityToEntity(attachedProp2, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
	SetModelAsNoLongerNeeded(attachModel)
end

function attachProp(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
	removeAttachedProp()
	attachModel = GetHashKey(attachModelSent)
	boneNumber = boneNumberSent 
	local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
	--local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(100)
	end
	attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
	exports["nadrp-ped"]:GlobalObject(attachedProp)
	AttachEntityToEntity(attachedProp, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
	SetModelAsNoLongerNeeded(attachModel)
end

dstamina = 0

sitting = false

imdead = 0

RegisterNetEvent('hadtreat')
AddEventHandler('hadtreat', function(arg1,arg2,arg3)
	local model = GetEntityModel(PlayerPedId())
    if model ~= GetHashKey("a_c_chop") then return end

    dstamina = 400
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.25)

    while dstamina > 0 do

        Citizen.Wait(1000)
        RestorePlayerStamina(PlayerId(), 1.0)
        dstamina = dstamina - 1

    end

    dstamina = 0

    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(),1000,1000, 3, 0, 0, 0)
    end

    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    RevertToStressMultiplier()
end)

function camOn()
	if(not DoesCamExist(cam)) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
	
		SetCamActive(cam,  true)

		RenderScriptCams(true,  false,  0,  true,  true)		
	end	
end

function camOff()
	RenderScriptCams(false, false, 0, 1, 0)
	DestroyCam(cam, false)
end

opacity = 0
fadein = false

local opacityBars = 0 
local Addition = 0.0


local GodEnabled = false
RegisterNetEvent("carandplayerhud:godCheck")
AddEventHandler("carandplayerhud:godCheck",function(arg)
	GodEnabled = arg
end)

RegisterNetEvent('voip:settizng')
AddEventHandler('voip:settizng', function(voipDistance)
	if (voipDistance == 1) then
		distanceSetting = 4.0
	elseif (voipDistance == 2) then
		distanceSetting = 18.0
	elseif (voipDistance == 3) then
		distanceSetting = 35.0
	end
end)

local colorblind = false
RegisterNetEvent('option:colorblind')
AddEventHandler('option:colorblind',function()
    colorblind = not colorblind
end)

local voipTypes = {
	
	{type = "Whisper", event = "pv:voip1"},
	{type = "Normal", event = "pv:voip2"},
	{type = "Yell", event = "pv:voip3"}
}

function lerp(min, max, amt)
	return (1 - amt) * min + amt * max
end
function rangePercent(min, max, amt)
	return (((amt - min) * 100) / (max - min)) / 100
end

RegisterNetEvent("nadrp-admin:currentDevmode")
AddEventHandler("nadrp-admin:currentDevmode", function(devmode)
    currentValues["dev"] = devmode
end)

RegisterNetEvent("nadrp-admin:currentDebug")
AddEventHandler("nadrp-admin:currentDebug", function(debugToggle)
    currentValues["devdebug"] = debugToggle
end)

Citizen.CreateThread(function()
    while true do
        
        TriggerEvent('tac_status:getStatus', 'hunger', function(hunger)
            TriggerEvent('tac_status:getStatus', 'thirst', function(thirst)

                local myhunger = hunger.getPercent()
                local mythirst = thirst.getPercent()

                SendNUIMessage({
                    action = "updateStatusHud",
					varSetHunger = myhunger,
					varSetThirst = mythirst,
                })
            end)
        end)
        Citizen.Wait(5000)
    end
end)

local stresslevel = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
		if DoesEntityExist(PlayerPedId()) and stresslevel <= 100 then
			if IsPedArmed(PlayerPedId(), 6) then
				stresslevel = stresslevel + 0.5
			else
				stresslevel = stresslevel + 0.1
			end
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		if stresslevel >= 25 then
			ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.01)
		elseif stresslevel >= 50 then
			ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.07)
		elseif stresslevel >= 75 then
			ShakeGameplayCam('MEDIUM_EXPLOSION_SHAKE', 0.07)
		end
		Citizen.Wait(2000)
	end
end)

RegisterNetEvent('client:useCig')
AddEventHandler('client:useCig', function()

	if IsPedInAnyVehicle(PlayerPedId(), false) then
		Citizen.Wait(5)
	else
		TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_SMOKING", -1, true)
	end
	exports["nadrp-taskbar"]:taskBar(15000, "Smoking Cigarette")
	if stresslevel <= 0.001 then
		Citizen.Wait(5)
	else
		stresslevel = stresslevel - 2.0
	end

	exports['mythic_notify']:SendAlert('inform', 'Stress slightly relieved')

	if IsPedInAnyVehicle(PlayerPedId(), false) then
		Citizen.Wait(5)
	else
		ClearPedTasksImmediately(PlayerPedId())
	end
end)

RegisterNetEvent("client:updateStress")
AddEventHandler("client:updateStress",function()
	stresslevel = 0
end)

RegisterNetEvent('client:newStress')
AddEventHandler('client:newStress', function(toggle, amount)
	if toggle == true then
		stresslevel = stresslevel + ToFloat(amount)
		exports['mythic_notify']:SendAlert('inform', 'Stress increased')
	else
		stresslevel = stresslevel - ToFloat(amount)
		exports['mythic_notify']:SendAlert('inform', 'Stress reduced')
	end
	print(stresslevel)
end)

currentValues["hunger"] = 0
currentValues["thirst"] = 0

Citizen.CreateThread(function()
	
	while true do
		Citizen.Wait(5000)
		TriggerEvent('tac_status:getStatus', 'hunger', function(status)
			currentValues["hunger"]  = status.val/1000000*100
		end)
		TriggerEvent('tac_status:getStatus', 'thirst', function(status)
			currentValues["thirst"] = status.val/1000000*100
		end)
	end
end)

oxyOn = false
attachedProp = 0
attachedProp2 = 0

function removeAttachedProp2()
	DeleteEntity(attachedProp2)
	attachedProp2 = 0
end

function removeAttachedProp()
	DeleteEntity(attachedProp)
	attachedProp = 0
end

function attachProp2(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
	removeAttachedProp2()
	attachModel = GetHashKey(attachModelSent)
	boneNumber = boneNumberSent
	local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)

	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(100)
	end
	attachedProp2 = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
	exports["nadrp-ped"]:GlobalObject(attachedProp2)
	AttachEntityToEntity(attachedProp2, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
	SetModelAsNoLongerNeeded(attachModel)
end

function attachProp(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
	removeAttachedProp()
	attachModel = GetHashKey(attachModelSent)
	boneNumber = boneNumberSent 
	local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)

	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(100)
	end
	attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
	exports["nadrp-ped"]:GlobalObject(attachedProp)
	AttachEntityToEntity(attachedProp, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
	SetModelAsNoLongerNeeded(attachModel)
end

currentValues["oxy"] = 25.0

RegisterNetEvent("OxyMenu")
AddEventHandler("OxyMenu",function()
	if currentValues["oxy"] > 25.0 then
		--RemoveOxyTank
		TriggerEvent('sendToGui','Remove Oxy Tank','RemoveOxyTank')
	end
end)

RegisterNetEvent("RemoveOxyTank")
AddEventHandler("RemoveOxyTank",function()
	if currentValues["oxy"] > 25.0 then
		currentValues["oxy"] = 25.0
		TriggerEvent('menu:hasOxygenTank', false)
	end
end)

RegisterNetEvent("UseOxygenTank")
AddEventHandler("UseOxygenTank",function()
	currentValues["oxy"] = 100.0
	TriggerEvent('menu:hasOxygenTank', true)
end)

local lastDamageTrigger = 0

RegisterNetEvent("fire:damageUser")
AddEventHandler("fire:damageUser", function(Reqeuester)
	local attacker = GetPlayerFromServerId(Reqeuester)
	local Attackerped = GetPlayerPed(attacker)

	if IsPedShooting(Attackerped) then
		local name = GetSelectedPedWeapon(Attackerped)
        if name == `WEAPON_FIREEXTINGUISHER` and not exports["nadrp-ped"]:isPed("dead") then
        	lastDamageTrigger = GetGameTimer()
        	currentValues["oxy"] = currentValues["oxy"] - 15
        end
	end
end)

Citizen.CreateThread(function()

	while true do
		Wait(1)
		if currentValues["oxy"] > 0 and IsPedSwimmingUnderWater(PlayerPedId()) then
			SetPedDiesInWater(PlayerPedId(), false)
			if currentValues["oxy"] > 25.0 then
				currentValues["oxy"] = currentValues["oxy"] - 0.003125
			else
				currentValues["oxy"] = currentValues["oxy"] - 1
			end
		else
			if IsPedSwimmingUnderWater(PlayerPedId()) then
				currentValues["oxy"] = currentValues["oxy"] - 0.01
				SetPedDiesInWater(PlayerPedId(), true)
			end
		end

		if not IsPedSwimmingUnderWater( PlayerPedId() ) and currentValues["oxy"] < 25.0 then
			if GetGameTimer() - lastDamageTrigger > 3000 then
				currentValues["oxy"] = currentValues["oxy"] + 1
				if currentValues["oxy"] > 25.0 then
					currentValues["oxy"] = 25.0
				end
			else
				if currentValues["oxy"] <= 0 then
					
					if exports["nadrp-ped"]:isPed("dead") then
						lastDamageTrigger = -7000
						currentValues["oxy"] = 25.0
					else
						SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - 20)
					end
				end
			end
		end

		if currentValues["oxy"] > 25.0 and not oxyOn then
			oxyOn = true
			attachProp("p_s_scuba_tank_s", 24818, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0)
			attachProp2("p_s_scuba_mask_s", 12844, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0)
		elseif oxyOn and currentValues["oxy"] <= 25.0 then
			oxyOn = false
			removeAttachedProp()
			removeAttachedProp2()
		end
		if not oxyOn then
			Wait(1000)
		end
	end
end)

Citizen.CreateThread( function()
	
	while true do

		if IsPedArmed(PlayerPedId(), 6) then
			Citizen.Wait(1)
		else
			Citizen.Wait(1500)
		end

	    if IsPedShooting(PlayerPedId()) then
	    	local ply = PlayerPedId()
	    	local GamePlayCam = GetFollowPedCamViewMode()
	    	local Vehicled = IsPedInAnyVehicle(ply, false)
			local MovementSpeed = math.ceil(GetEntitySpeed(ply))
	    	if MovementSpeed > 69 then
	    		MovementSpeed = 69
	    	end

	        local _,wep = GetCurrentPedWeapon(ply)

	        local group = GetWeapontypeGroup(wep)

	        local p = GetGameplayCamRelativePitch()

	        local cameraDistance = #(GetGameplayCamCoord() - GetEntityCoords(ply))

	        local recoil = math.random(130,140+(math.ceil(MovementSpeed*1.5)))/100
	        local rifle = false

          	if group == 970310034 or group == 1159398588 then
          		rifle = true
          	end

          	if cameraDistance < 5.3 then
          		cameraDistance = 1.5
          	else
          		if cameraDistance < 8.0 then
          			cameraDistance = 4.0
          		else
          			cameraDistance = 7.0
          		end
          	end

	        if Vehicled then
	        	recoil = recoil * 0.5
	        else
	        	recoil = recoil * 0.3
	        end

	        if GamePlayCam == 4 then

	        	recoil = recoil * 0.7
		        if rifle then
		        	recoil = recoil * 0.1
		        end
	        end

	        if rifle then
	        	recoil = recoil * 0.1
	        end

	        local rightleft = math.random(4)
	        local h = GetGameplayCamRelativeHeading()
	        local hf = math.random(10,40+MovementSpeed)/100

	        if Vehicled then
	        	hf = hf * 2.0
	        end

	        if rightleft == 1 then
	        	SetGameplayCamRelativeHeading(h+hf)
	        elseif rightleft == 2 then
	        	SetGameplayCamRelativeHeading(h-hf)
	        end 
        
	        local set = p+recoil

			SetGameplayCamRelativePitch(set,0.8)
			if not recentTick then
				Citizen.CreateThread(function()
					stresslevel = stresslevel + 2.0
					recentTick = true
					Citizen.Wait(1000)
					recentTick = false
				end)
			end
	    end
	end
end)

Citizen.CreateThread(function()
	local minimap = RequestScaleformMovie("minimap")
	SetBigmapActive(true, false)
	Wait(500)
	SetBigmapActive(false, false)

	local counter = 0
	local get_ped = PlayerPedId() -- current ped
	local get_ped_veh = GetVehiclePedIsIn(get_ped,false) -- Current Vehicle ped is in
	local plate_veh = GetVehicleNumberPlateText(get_ped_veh) -- Vehicle Plate
	local veh_stop = IsVehicleStopped(get_ped_veh) -- Parked or not
	local veh_engine_health = GetVehicleEngineHealth(get_ped_veh) -- Vehicle Engine Damage 
	local veh_body_health = GetVehicleBodyHealth(get_ped_veh)
	local veh_burnout = IsVehicleInBurnout(get_ped_veh) -- Vehicle Burnout
	local thespeed = GetEntitySpeed(get_ped_veh) * 3.6
	currentValues["health"] = (GetEntityHealth(get_ped) - 100)
	currentValues["armor"] = GetPedArmour(get_ped)
	currentValues["parachute"] = HasPedGotWeapon(get_ped, `gadget_parachute`, false)
	if currentValues["oxy"] <= 0 then currentValues["oxy"] = 0 end

	while true do
		if sleeping then
			if IsControlJustReleased(0,38) then
				sleeping = false
				DetachEntity(PlayerPedId(), 1, true)
			end
		end

		Citizen.Wait(1)

		if loaded then
			if GetEntityMaxHealth(PlayerPedId()) < 200 then
				SetEntityMaxHealth(PlayerPedId(), 200)
				SetEntityHealth(PlayerPedId(), 200)
			end
		end

		if counter == 0 then
			-- current ped
			get_ped = PlayerPedId()
			SetPedSuffersCriticalHits(get_ped,false)
			get_ped_veh = GetVehiclePedIsIn(get_ped,false) -- Current Vehicle ped is in
			plate_veh = GetVehicleNumberPlateText(get_ped_veh) -- Vehicle Plate
			veh_stop = IsVehicleStopped(get_ped_veh) -- Parked or not
			veh_engine_health = GetVehicleEngineHealth(get_ped_veh) -- Vehicle Engine Damage 
			veh_body_health = GetVehicleBodyHealth(get_ped_veh)
			veh_burnout = IsVehicleInBurnout(get_ped_veh) -- Vehicle Burnout
			thespeed = GetEntitySpeed(get_ped_veh) * 3.6
			currentValues["health"] = GetEntityHealth(get_ped) - 100
			currentValues["armor"] = GetPedArmour(get_ped)
			currentValues["parachute"] = HasPedGotWeapon(get_ped, `gadget_parachute`, false)
			currentValues["stress"] = stresslevel
			currentValues["talking"] = NetworkIsPlayerTalking(PlayerId())

			if currentValues["stress"] > 100 then
				currentValues["stress"] = 100
			elseif currentValues["stress"] < 0 then
				currentValues["stress"] = 0
			end

			if currentValues["hunger"] < 0 then
				currentValues["hunger"] = 0
			end
			if currentValues["thirst"] < 0 then
				currentValues["thirst"] = 0
			end

			if currentValues["hunger"] > 100 then currentValues["hunger"] = 100 end

			if currentValues["health"] < 1 then currentValues["health"] = 100 end
			if currentValues["thirst"] > 100 then currentValues["thirst"] = 100 end
			if currentValues["oxy"] <= 0 then currentValues["oxy"] = 0 end
			local valueChanged = false

			for k,v in pairs(currentValues) do
				if lastValues[k] == nil or lastValues[k] ~= v then
					valueChanged = true
					lastValues[k] = v
				end
			end

			if valueChanged then
				SendNUIMessage({
					type = "updateStatusHud",
					hasParachute = currentValues["parachute"],
					varSetHealth = currentValues["health"],
					varSetArmor = currentValues["armor"],
					varSetHunger = currentValues["hunger"],
					varSetThirst = currentValues["thirst"],
					varSetOxy = currentValues["oxy"],
					varSetStress = currentValues["stress"],
					colorblind = colorblind,
					varSetVoice = currentValues["voice"],
					varDev = currentValues["dev"],
					varDevDebug = currentValues["devdebug"],
					isTalking = currentValues["talking"],
					isRadioActive = currentValues["radio"]
				})
			end
			counter = 25
		end

		counter = counter - 1

        if get_ped_veh ~= 0 then
            local model = GetEntityModel(get_ped_veh)
            local roll = GetEntityRoll(get_ped_veh)
  
            if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and IsEntityInAir(get_ped_veh) or (roll < -50 or roll > 50) then
                DisableControlAction(0, 59) -- leaning left/right
                DisableControlAction(0, 60) -- leaning up/down
            end

            if GetPedInVehicleSeat(GetVehiclePedIsIn(get_ped, false), 0) == get_ped then
				if GetIsTaskActive(get_ped, 165) then
					SetPedIntoVehicle(get_ped, GetVehiclePedIsIn(get_ped, false), 0)
				end
			end
			DisplayRadar(1)
        else
        	DisplayRadar(0)
        end

		BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
		EndScaleformMovieMethod()
		HideHudComponentThisFrame( 14 ) -- crosshair
	end
end)

RegisterNetEvent('nadrp-voice:radioActive')
AddEventHandler('nadrp-voice:radioActive', function(radioStatus)
	currentValues["radio"] = radioStatus
end)

AddEventHandler('nadrp-hud:UpdateVoice', function(voiceMode)
	currentValues["voice"] = voiceMode
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		ped = PlayerPedId()
		if not IsPedInAnyVehicle(plyr, false) then 
			if IsPedUsingActionMode(ped) then
				SetPedUsingActionMode(ped, -1, -1, 1)
			end
		else
			Citizen.Wait(3000)
		end
    end
end)

Citizen.CreateThread( function()

	local resetcounter = 0
	local jumpDisabled = false
  	
  	while true do 
    Citizen.Wait(100)

  --  if IsRecording() then
  --      StopRecordingAndDiscardClip()
  --  end     

		if jumpDisabled and resetcounter > 0 and IsPedJumping(PlayerPedId()) then
			
			SetPedToRagdoll(PlayerPedId(), 1000, 1000, 3, 0, 0, 0)

			resetcounter = 0
		end

		if not jumpDisabled and IsPedJumping(PlayerPedId()) then

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

RegisterNetEvent('client:useJoint')
AddEventHandler('client:useJoint', function()
	local plyPed = GetPlayerPed(-1)
	local playerPed = PlayerPedId()
	exports['mythic_notify']:SendAlert('inform', 'You Feel Good')

	if IsPedInAnyVehicle(PlayerPedId(), false) then
		Citizen.Wait(5)
	else
		TaskStartScenarioInPlace(GetPlayerPed(-1),"WORLD_HUMAN_SMOKING_POT",-1,true)
	end
	local finished = exports["nadrp-taskbar"]:taskBar(7500, "Smoking Joint")
	if finished == 100 then
		local takeStress = math.random(5,10)
		if stresslevel <= 0.001 then
			Citizen.Wait(5)
		else
			stresslevel = stresslevel - ToFloat(takeStress)
		end

		exports['mythic_notify']:SendAlert('inform', 'Stress slightly relieved')
		AddArmourToPed(plyPed, 20)
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			Citizen.Wait(5)
		else
			ClearPedTasksImmediately(PlayerPedId())
		end
	end
end)

RegisterNetEvent('client:useDonut')
AddEventHandler('client:useDonut', function()
	local plyPed = GetPlayerPed(-1)
	local playerPed = PlayerPedId()
	exports['mythic_notify']:SendAlert('inform', 'Yum')
		local takeStress = math.random(5,10)
		if stresslevel <= 0.001 then
			Citizen.Wait(5)
		else
			stresslevel = stresslevel - ToFloat(takeStress)
		end

		exports['mythic_notify']:SendAlert('inform', 'Stress slightly relieved')
		AddArmourToPed(plyPed, 20)
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			Citizen.Wait(5)
		else
			ClearPedTasksImmediately(PlayerPedId())
		end
end)

RegisterNetEvent('food:IceCream')
AddEventHandler('food:IceCream', function()
	TriggerServerEvent("server:alterStress", false, 350)
end)

RegisterNetEvent('food:FishTaco')
AddEventHandler('food:FishTaco', function()
	dstamina = 0

	myhunger = myhunger + 10
	if myhunger < 0 then
		myhunger = 0
	end

	if myhunger > 100 then
		myhunger = 100
	end

    if stresslevel > 50 then
		SetSwimMultiplierForPlayer(PlayerId(), 1.15)
	    dstamina = math.random(30,60)
	else
	    SetSwimMultiplierForPlayer(PlayerId(), 1.25)
	    dstamina = math.random(30,60)
	end

	while dstamina > 0 do
		if (IsPedSwimmingUnderWater(PlayerPedId()) or IsPedSwimming(PlayerPedId())) then
			RestorePlayerStamina(PlayerId(), 1.0)
		end
        Citizen.Wait(1000)
        dstamina = dstamina - 1
    end

    dstamina = 0


    SetSwimMultiplierForPlayer(PlayerId(), 1.0)
    RevertToStressMultiplier()
end)

RegisterNetEvent('food:Taco')
AddEventHandler('food:Taco', function()
	myhunger = 100
	TriggerEvent("healed:minors")
end)

RegisterNetEvent('food:Condiment')
AddEventHandler('food:Condiment', function()
	dstamina = 0
	Citizen.Wait(1000)

	myhunger = myhunger + 10

	if myhunger < 0 then
		myhunger = 0
	end

	if myhunger > 100 then
		myhunger = 100
	end

	if stresslevel > 50 then
		SetRunSprintMultiplierForPlayer(PlayerId(), 1.15)
		dstamina = math.random(10,15)
	else
		SetRunSprintMultiplierForPlayer(PlayerId(), 1.25)
		dstamina = math.random(10,15)
	end

    while dstamina > 0 do

        Citizen.Wait(1000)
        RestorePlayerStamina(PlayerId(), 1.0)
        dstamina = dstamina - 1

        if IsPedRagdoll(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(5), math.random(5), 3, 0, 0, 0)
        end

        if math.random(100) > 91 and IsPedRunning(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(1000), math.random(1000), 3, 0, 0, 0)
        end

    end

    dstamina = 0

    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(),6000,6000, 3, 0, 0, 0)
    end

    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    RevertToStressMultiplier()
end)


RegisterNetEvent('hadenergy')
AddEventHandler('hadenergy', function(arg1,arg2,arg3)

    dstamina = 0
    Citizen.Wait(1000)

    SetRunSprintMultiplierForPlayer(PlayerId(), 1.005)
    dstamina = 30

    if stresslevel > 75 then
	    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0005)
	    dstamina = 115
	elseif stresslevel > 90 then
	    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
	    dstamina = 60
	end

	TriggerEvent("client:newStress",true,math.ceil(5))

    while dstamina > 0 do
        Citizen.Wait(1000)
        RestorePlayerStamina(PlayerId(), 1.0)
        dstamina = dstamina - 1
        if IsPedRagdoll(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(55), math.random(55), 3, 0, 0, 0)
        end
        if math.random(100) > 85 and IsPedRunning(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(4000), math.random(4000), 3, 0, 0, 0)
        end
    end
    dstamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(),6000,6000, 3, 0, 0, 0)
    end
    RevertToStressMultiplier()
end)

function GetStress()
	if stresslevel ~= nil then 
		return stresslevel
	else
		return 0
	end
end

local scopedWeapons = 
{
    100416529,  -- WEAPON_SNIPERRIFLE
    205991906,  -- WEAPON_HEAVYSNIPER
    3342088282  -- WEAPON_MARKSMANRIFLE
}

function HashInTable( hash )
    for k, v in pairs( scopedWeapons ) do 
        if ( hash == v ) then 
            return true 
        end 
    end 

    return false 
end 

function ManageReticle()
    local ped = GetPlayerPed( -1 )

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then
        local _, hash = GetCurrentPedWeapon( ped, true )

        if ( GetFollowPedCamViewMode() ~= 4 and IsPlayerFreeAiming() and not HashInTable( hash ) ) then 
            HideHudComponentThisFrame( 14 )
        end 
    end 
end

RegisterNetEvent('baseevents:enteredVehicle')
AddEventHandler('baseevents:enteredVehicle', function(currentVehicle)
	local InVehicle = true
	Citizen.CreateThread( function()
		while InVehicle do
			playerPed = PlayerPedId() 
			if IsPedArmed(playerPed, 6) then
				Wait(1)
				if IsPedDoingDriveby(playerPed) then
					if GetFollowVehicleCamViewMode() ~= 4 then
						DisableAimCamThisUpdate()
						SetPlayerCanDoDriveBy(PlayerId(),false)
						SetFollowPedCamViewMode(4)
						SetFollowVehicleCamViewMode(4)
						Wait(50)
						SetPlayerCanDoDriveBy(PlayerId(),true)
					end
				else
					DisableControlAction(0,36,true)
					if GetPedStealthMovement(playerPed) == 1 then
						SetPedStealthMovement(playerPed,0)
					end
				end
			else
				Wait(500)
			end
			if not IsPedInAnyVehicle(playerPed, false) then 
				InVehicle = false
				break
			end
		end
	end)
end)

RegisterNetEvent('tac:playerLoaded')
AddEventHandler('tac:playerLoaded', function()
	local minimap = RequestScaleformMovie("minimap")
	SetBigmapActive(true, false)
	Wait(500)
	SetBigmapActive(false, false)
	loaded = true
end)

exports('GetStress', GetStress)
