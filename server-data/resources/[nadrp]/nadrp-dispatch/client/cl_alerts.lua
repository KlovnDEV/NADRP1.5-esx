ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent("tac:getSharedObject", function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
local currentCallSign = ''
local job = ''

RegisterNetEvent("tac:playerLoaded")
AddEventHandler("tac:playerLoaded", function(xPlayer)
	ESX.PlayerData = xPlayer
	TriggerServerEvent('CheckMyCallSign')
end)

RegisterNetEvent('nadrp-dispatch:myCallsign')
AddEventHandler('nadrp-dispatch:myCallsign', function(callSign)
	currentCallSign = callSign
end)

local exlusionZones = {
    {1713.1795654297,2586.6862792969,59.880760192871,250}, -- prison
    {-106.63687896729,6467.7294921875,31.626684188843,45}, -- paleto bank
    {251.21984863281,217.45391845703,106.28686523438,20}, -- city bank
    {-622.25042724609,-230.93577575684,38.057060241699,10}, -- jewlery store
    {699.91052246094,132.29960632324,80.743064880371,55}, -- power 1
    {2739.5505371094,1532.9992675781,57.56616973877,235}, -- power 2
    {12.53, -1097.99, 29.8, 10} -- Adam's Apple / Pillbox Weapon shop
}

local blacklistedGuns = {
	[1] = "911657153",
	[2] = "101631238",
	[3] = "126349499",
	[4] = "126349499",
}

RegisterCommand('callsign', function(source, args, raw)
	local callSign = tonumber(args[1])
	local PlayerData = ESX.GetPlayerData()
	if job == 'police' then
		if callSign ~= nil then
			if type(callSign) == 'number' then
				if tonumber(callSign) < 99 or tonumber(callSign) > 999 then
					exports['mythic_notify']:DoLongHudText('error', 'Invalid callsign')
				else	
					TriggerServerEvent('police:setCallSign', callSign)
				end
			else
				exports['mythic_notify']:DoLongHudText('error', 'Your callsign must be a number')
			end
		end
	end
end)

local ped = PlayerPedId()
local isInVehicle = IsPedInAnyVehicle(ped, true)
Citizen.CreateThread( function()
    while true do
        Wait(1000)
        ped = PlayerPedId()
        isInVehicle = IsPedInAnyVehicle(ped, true)
    end
end)


function getRandomNpc(basedistance)
    local basedistance = basedistance
    local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom

    repeat
        local pos = GetEntityCoords(ped)
        local distance = #(playerCoords - pos)
        if ped ~= PlayerPedId() and distance < basedistance and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped
        end
        success, ped = FindNextPed(handle)
    until not success

    EndFindPed(handle)

    return rped
end

function GetStreetAndZone()
    local plyPos = GetEntityCoords(PlayerPedId(),  true)
    local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
    local street1 = GetStreetNameFromHashKey(s1)
    local street2 = GetStreetNameFromHashKey(s2)
    zone = tostring(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
    local playerStreetsLocation = GetLabelText(zone)
    local street = street1 .. ", " .. playerStreetsLocation
    return street
end

RegisterNetEvent("police:setCallSign")
AddEventHandler("police:setCallSign", function(pCallSign)
	if pCallSign ~= nil then currentCallSign = pCallSign end
end)

--- Gun Shots ---

Citizen.CreateThread( function()
    local origin = false
    local w = `WEAPON_PetrolCan`
    local w1 = `WEAPON_FIREEXTINGUISHER`
    local w2 = `WEAPON_FLARE`
    local curw = GetSelectedPedWeapon(PlayerPedId())
    local armed = false
	local timercheck = 0
	local blacklisted = false
	while true do
        if not armed then
            if IsPedArmed(ped, 7) and not IsPedArmed(ped, 1) then
                curw = GetSelectedPedWeapon(ped)
                armed = true
                timercheck = 15
            end
        end

        if armed then
			Citizen.Wait(50)
            if IsPedShooting(ped) then
                local inArea = false
                for i,v in ipairs(exlusionZones) do
                    local playerPos = GetEntityCoords(ped)
                    if #(vector3(v[1],v[2],v[3]) - vector3(playerPos.x,playerPos.y,playerPos.z)) < v[4] then
                        --if `WEAPON_COMBATPDW` == curw then
                            inArea = true
                        --end
                    end
                end
				if not inArea then
					origin = true
					local blacklisted = GetBlacklist()
					if not blacklisted then
						--local myjob = exports['nadrp-ped']:isPed('myjob')
						--if myjob ~= 'police' then
							--print('alertPolice')
							if IsPedCurrentWeaponSilenced(ped) then
								--local chance = math.random(20)
								--if chance > 15 then
								--	TriggerEvent('civilian:alertPolice', 50.0, 'gunshot', 0,1,0)
								--end
							elseif isInVehicle then
								TriggerEvent('civilian:alertPolice', 90.0, 'gunshotvehicle', 0,1,0)
							else
								TriggerEvent('civilian:alertPolice', 90.0, 'gunshot', 0,1,0)
							end
						end
					--end
                    origin = false
                end
            end
            if timercheck == 0 then
                armed = false
            else
                timercheck = timercheck - 1
            end
        else
            Citizen.Wait(5000)
        end
    end
end)

function GetBlacklist()
	local curw = GetSelectedPedWeapon(PlayerPedId())
	for i=1, #blacklistedGuns do
		if tostring(curw) == blacklistedGuns[i] then
			return true
		end
	end
	return false
end

RegisterNetEvent('tac-outlawalert:gunshotInProgress')
AddEventHandler('tac-outlawalert:gunshotInProgress', function(targetCoords)
	if job == 'police' then
		if Config.gunAlert then
			local alpha = 250
			local gunshotBlip = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

			SetBlipScale(gunshotBlip, 1.3)
			SetBlipSprite(gunshotBlip,  432)
			SetBlipColour(gunshotBlip,  1)
			SetBlipAlpha(gunshotBlip, alpha)
			SetBlipAsShortRange(gunshotBlip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('10-71 Shots Fired!') 
			EndTextCommandSetBlipName(gunshotBlip)
			SetBlipAsShortRange(gunshotBlip,  1)
			PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

			while alpha ~= 0 do
				Citizen.Wait(Config.BlipGunTime * 4)
				alpha = alpha - 1
				SetBlipAlpha(gunshotBlip, alpha)

				if alpha == 0 then
					RemoveBlip(gunshotBlip)
					return
				end
			end

		end
	end
end)

---- Fight ----

Citizen.CreateThread( function()
    local origin3 = false
    while true do
        Wait(1)
        if GetVehiclePedIsUsing(PlayerPedId()) == 0 then
            if IsPedInMeleeCombat(PlayerPedId()) and not origin3 and getRandomNpc(3.0) then
                origin3 = true
				TriggerEvent("civilian:alertPolice",15.0,"fight",0)
				TriggerServerEvent('tac_outlawalert:combatInProgress', GetEntityCoords(PlayerPedId()))
                Wait(20000)
                origin3 = false
            end
        else
            Citizen.Wait(1500)
        end
    end
end)

RegisterNetEvent('tac-outlawalert:combatInProgress')
AddEventHandler('tac-outlawalert:combatInProgress', function(targetCoords)
	if job == 'police' then
		if Config.gunAlert then
			local alpha = 250
			local knife = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

			SetBlipScale(knife, 1.3)
			SetBlipSprite(knife,  437)
			SetBlipColour(knife,  1)
			SetBlipAlpha(knife, alpha)
			SetBlipAsShortRange(knife, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('10-11 Fight in progress')
			EndTextCommandSetBlipName(knife)
			SetBlipAsShortRange(knife,  1)
			PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

			while alpha ~= 0 do
				Citizen.Wait(Config.BlipGunTime * 4)
				alpha = alpha - 1
				SetBlipAlpha(knife, alpha)

				if alpha == 0 then
					RemoveBlip(knife)
					return
				end
			end
		end
	end
end)

---- 10-13s Officer Down ----

RegisterNetEvent('police:tenThirteenA')
AddEventHandler('police:tenThirteenA', function()
  if job == 'police' or job == 'ambulance' then
		local pos = GetEntityCoords(PlayerPedId(),  true)
		TriggerServerEvent("dispatch:svNotify", {
			dispatchCode = "10-13A",
			firstStreet = GetStreetAndZone(),
			callSign = currentCallSign,
			isImportant = true,
			priority = 3,
			dispatchMessage = "Officer Down",
			origin = {
				x = pos.x,
				y = pos.y,
				z = pos.z
			  }
		})
		TriggerServerEvent('tac-alerts:policealertA', pos)
	end
end)

RegisterNetEvent('police:panic')
AddEventHandler('police:panic', function()
  	if job == 'police' or job == 'ambulance' then
		local pos = GetEntityCoords(PlayerPedId(),  true)
		TriggerServerEvent("dispatch:svNotify", {
			dispatchCode = "CODE 99",
			firstStreet = GetStreetAndZone(),
			callSign = currentCallSign,
			isImportant = true,
			priority = 3,
			dispatchMessage = "Officer in distress",
			origin = {
				x = pos.x,
				y = pos.y,
				z = pos.z
			}
		})
		TriggerServerEvent('tac-alerts:policealertA', pos)
	end
end)

RegisterNetEvent('tac-alerts:policealertA')
AddEventHandler('tac-alerts:policealertA', function(targetCoords)
  	if job == 'police' or job == 'ambulance' then	
		local alpha = 250
		local policedown = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(policedown,  126)
		SetBlipColour(policedown,  1)
		SetBlipScale(policedown, 1.3)
		SetBlipAsShortRange(policedown,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-13A Officer Down')
		EndTextCommandSetBlipName(policedown)
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'polalert', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(policedown, alpha)

			if alpha == 0 then
				RemoveBlip(policedown)
				return
      		end
    	end
  	end
end)

RegisterNetEvent('police:tenThirteenB')
AddEventHandler('police:tenThirteenB', function()
	if job == 'police' or job == 'ambulance' then
		local pos = GetEntityCoords(PlayerPedId(),  true)
		TriggerServerEvent("dispatch:svNotify", {
			dispatchCode = "10-13B",
			firstStreet = GetStreetAndZone(),
			callSign = currentCallSign,
			isImportant = false,
			priority = 3,
			dispatchMessage = "Officer Down",
			origin = {
				x = pos.x,
				y = pos.y,
				z = pos.z
			}
		})
		TriggerServerEvent('tac-alerts:policealertB', pos)
	end
end)

RegisterNetEvent('tac-alerts:policealertB')
AddEventHandler('tac-alerts:policealertB', function(targetCoords)
	if job == 'police' or job == 'ambulance' then	
		local alpha = 250
		local policedown2 = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(policedown2,  126)
		SetBlipColour(policedown2,  1)
		SetBlipScale(policedown2, 1.3)
		SetBlipAsShortRange(policedown2,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-13B Officer Down')
		EndTextCommandSetBlipName(policedown2)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(policedown2, alpha)

			if alpha == 0 then
				RemoveBlip(policedown2)
				return
      		end
    	end
  	end
end)

RegisterNetEvent('tac-alerts:panic')
AddEventHandler('tac-alerts:panic', function(targetCoords)
	if job == 'police' or job == 'ambulance' then	
		local alpha = 250
		local panic = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(panic,  126)
		SetBlipColour(panic,  1)
		SetBlipScale(panic, 1.3)
		SetBlipAsShortRange(panic,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-78 Officer Panic Botton')
		EndTextCommandSetBlipName(panic)
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'polalert', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(panic, alpha)

			if alpha == 0 then
				RemoveBlip(panic)
				return
      		end
    	end
  	end
end)


---- 10-14 EMS ----

RegisterNetEvent("ems:tenForteenA")
AddEventHandler("ems:tenForteenA", function()	
	if job == 'police' or job == 'ambulance' then	
		local pos = GetEntityCoords(PlayerPedId(),  true)
		TriggerServerEvent("dispatch:svNotify", {
			dispatchCode = "10-14A",
			firstStreet = GetStreetAndZone(),
			callSign = currentCallSign,
			isImportant = true,
			priority = 3,
			dispatchMessage = "Medic Down",
			origin = {
				x = pos.x,
				y = pos.y,
				z = pos.z
			}
		})
		TriggerEvent('tac-alerts:policealertA', pos)
	end
end)

RegisterNetEvent('tac-alerts:tenForteenA')
AddEventHandler('tac-alerts:tenForteenA', function(targetCoords)
  	if job == 'police' or job == 'ambulance' then	
		local alpha = 250	
		local medicDown = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(medicDown,  126)
		SetBlipColour(medicDown,  1)
		SetBlipScale(medicDown, 1.3)
		SetBlipAsShortRange(medicDown,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-14A Medic Down')
		EndTextCommandSetBlipName(medicDown)
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'polalert', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(medicDown, alpha)

			if alpha == 0 then
				RemoveBlip(medicDown)
				return
      		end
		end
  	end
end)

RegisterNetEvent("ems:tenForteenB")
AddEventHandler("ems:tenForteenB", function()
	if job == 'police' or job == 'ambulance' then	
		local pos = GetEntityCoords(PlayerPedId(),  true)
		TriggerServerEvent("dispatch:svNotify", {
			dispatchCode = "10-14B",
			firstStreet = GetStreetAndZone(),
			callSign = currentCallSign,
			isImportant = false,
			priority = 3,
			dispatchMessage = "Medic Down",
			origin = {
				x = pos.x,
				y = pos.y,
				z = pos.z
			}
		})
		TriggerEvent('tac-alerts:tenForteenB', pos)
	end
end)

RegisterNetEvent('tac-alerts:tenForteenB')
AddEventHandler('tac-alerts:tenForteenB', function(targetCoords)
	if job == 'police' or job == 'ambulance' then	
		local alpha = 250
		local medicDown2 = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(medicDown2,  126)
		SetBlipColour(medicDown2,  1)
		SetBlipScale(medicDown2, 1.3)
		SetBlipAsShortRange(medicDown2,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-14B Officer Down')
		EndTextCommandSetBlipName(medicDown2)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(medicDown2, alpha)

			if alpha == 0 then
				RemoveBlip(medicDown2)
				return
      		end
    	end
  	end
end)

---- Down Person ----

RegisterNetEvent('tac-alerts:downalert')
AddEventHandler('tac-alerts:downalert', function(targetCoords)
	if job == 'police' or job == 'ambulance' then
		local alpha = 250
		local injured = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(injured,  126)
		SetBlipColour(injured,  18)
		SetBlipScale(injured, 1.5)
		SetBlipAsShortRange(injured,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-47 Injured Civillian')
		EndTextCommandSetBlipName(injured)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(injured, alpha)

			if alpha == 0 then
				RemoveBlip(injured)
				return
      		end
    	end
  	end
end)

---- Car Crash ----
RegisterNetEvent('tac-alerts:vehiclecrash')
AddEventHandler('tac-alerts:vehiclecrash', function(targetCoords)
	if job == 'police' or job == 'ambulance' then	
		local alpha = 250
		local injured = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(injured,  488)
		SetBlipColour(injured,  1)
		SetBlipScale(injured, 1.5)
		SetBlipAsShortRange(injured,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-50 Araç Kazası')
		EndTextCommandSetBlipName(injured)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(injured, alpha)

			if alpha == 0 then
				RemoveBlip(injured)
				return
      		end
    	end
  	end
end)



RegisterNetEvent('tac-dispatch:bankrobbery')
AddEventHandler('tac-dispatch:bankrobbery', function(targetCoords)
	if job == 'police' or job == 'ambulance' then	
		local alpha = 250
		local alpha2 = 180
		local injured = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
		local bankBlip2 = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, 100.0)
		SetBlipSprite(injured,  431)
		SetBlipColour(injured,  1)
		SetBlipScale(injured, 1.5)
		SetBlipAsShortRange(injured,  1)
		SetBlipHighDetail(bankBlip2, true)
		SetBlipColour(bankBlip2, 1)
		SetBlipAlpha(bankBlip2, alpha2)
		SetBlipScale(bankBlip2, 150.0)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-90 Fleeca')
		EndTextCommandSetBlipName(injured)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(injured, alpha)

			if alpha == 0 then
				RemoveBlip(injured)
				RemoveBlip(bankBlip2)
				return
			end
		end
  	end
end)


RegisterNetEvent('tac-dispatch:atmrob')
AddEventHandler('tac-dispatch:atmrob', function(targetCoords)
	if job == 'police' or job == 'ambulance' then	
		local alpha = 250
		local alpha2 = 180
		local injured = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
		local bankBlip2 = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, 100.0)
		SetBlipSprite(injured,  431)
		SetBlipColour(injured,  1)
		SetBlipScale(injured, 1.5)
		SetBlipAsShortRange(injured,  1)
		SetBlipHighDetail(bankBlip2, true)
		SetBlipColour(bankBlip2, 1)
		SetBlipAlpha(bankBlip2, alpha2)
		SetBlipScale(bankBlip2, 150.0)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-90B ATM Rob')
		EndTextCommandSetBlipName(injured)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(injured, alpha)

			if alpha == 0 then
				RemoveBlip(injured)
				RemoveBlip(bankBlip2)
				return
			end
		end
  	end
end)

---- Vehicle Theft ----

RegisterNetEvent('tac-alerts:vehiclesteal')
AddEventHandler('tac-alerts:vehiclesteal', function(targetCoords)
	if job == 'police' then	
		local alpha = 250
		local thiefBlip = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(thiefBlip,  488)
		SetBlipColour(thiefBlip,  1)
		SetBlipScale(thiefBlip, 1.5)
		SetBlipAsShortRange(thiefBlip,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-60 Vehicle Theft Report')
		EndTextCommandSetBlipName(thiefBlip)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(thiefBlip, alpha)

			if alpha == 0 then
				RemoveBlip(thiefBlip)
				return
      		end
    	end
  	end
end)

---- Store Robbery ----

RegisterNetEvent('tac-alerts:storerobbery')
AddEventHandler('tac-alerts:storerobbery', function(targetCoords)
	if job == 'police' then
		local alpha = 250
		local alpha2 = 180
		local store = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
		local bankBlip2 = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, 100.0)
		SetBlipHighDetail(store, true)
		SetBlipSprite(store,  52)
		SetBlipColour(store,  1)
		SetBlipScale(store, 1.3)
		SetBlipHighDetail(bankBlip2, true)
		SetBlipColour(bankBlip2, 3)
		SetBlipAlpha(bankBlip2, alpha2)
		SetBlipAsShortRange(bankBlip2, true)
		SetBlipScale(bankBlip2, 150.0)
		SetBlipAsShortRange(store,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-31B Store Robbery in Progress!')
		EndTextCommandSetBlipName(store)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'bankalarm', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(store, alpha)
			SetBlipAlpha(bankBlip2, alpha2)

			if alpha == 0 then
				RemoveBlip(store)
				RemoveBlip(bankBlip2)
				return
			end
		end
	end
end)

---- House Robbery ----

RegisterNetEvent('tac-alerts:houserobbery')
AddEventHandler('tac-alerts:houserobbery', function(targetCoords)
	if job == 'police' then
		local alpha = 250
		local burglary = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipHighDetail(burglary, true)
		SetBlipSprite(burglary,  411)
		SetBlipColour(burglary,  1)
		SetBlipScale(burglary, 1.3)
		SetBlipAsShortRange(burglary,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-31A Burglary')
		EndTextCommandSetBlipName(burglary)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(burglary, alpha)

			if alpha == 0 then
				RemoveBlip(burglary)
				return
			end
    	end
  	end
end)

---- Bank Truck ----

RegisterNetEvent('tac-alerts:banktruck')
AddEventHandler('tac-alerts:banktruck', function(targetCoords)
	if job == 'police' then	
		local alpha = 250
		local targetCoords = GetEntityCoords(PlayerPedId(), true)
		local truck = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(truck,  477)
		SetBlipColour(truck,  47)
		SetBlipScale(truck, 1.5)
		SetBlipAsShortRange(Blip,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-90 Bank Truck')
		EndTextCommandSetBlipName(truck)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'bankalarm', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(truck, alpha)

			if alpha == 0 then
				RemoveBlip(truck)
				return
      		end
    	end
  	end
end)

---- Jewerly Store ----

RegisterNetEvent('tac-alerts:jewelrobbey')
AddEventHandler('tac-alerts:jewelrobbey', function()
	if job == 'police' then	
		local alpha = 250
		local targetCoords = GetEntityCoords(PlayerPedId(), true)
		local jew = AddBlipForCoord(-634.02, -239.49, 38)

		SetBlipSprite(jew,  487)
		SetBlipColour(jew,  4)
		SetBlipScale(jew, 1.8)
		SetBlipAsShortRange(Blip,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-90 In Progress')
		EndTextCommandSetBlipName(jew)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'bankalarm', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(jew, alpha)

			if alpha == 0 then
				RemoveBlip(jew)
				return
      		end
    	end
  	end
end)



RegisterNetEvent('tac-alerts:meth')
AddEventHandler('tac-alerts:meth', function()
	if job == 'police' then	
		local alpha = 250
		local targetCoords = GetEntityCoords(PlayerPedId(), true)
		local jew = AddBlipForCoord(1245.682, 3404.816, 58.253)

		SetBlipSprite(jew,  487)
		SetBlipColour(jew,  4)
		SetBlipScale(jew, 1.8)
		SetBlipAsShortRange(Blip,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Suspicious smoking vehicle located in Sandy Shores area')
		EndTextCommandSetBlipName(jew)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'bankalarm', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(jew, alpha)

			if alpha == 0 then
				RemoveBlip(jew)
				return
      		end
    	end
  	end
end)

---- Jail Break ----

RegisterNetEvent('tac-alerts:jailbreak')
AddEventHandler('tac-alerts:jailbreak', function(targetCoords)
	if job == 'police' then	
		local alpha = 250
		local targetCoords = GetEntityCoords(PlayerPedId(), true)
		local jail = AddBlipForCoord(1779.65, 2590.39, 50.49)

		SetBlipSprite(jail,  487)
		SetBlipColour(jail,  4)
		SetBlipScale(jail, 1.8)
		SetBlipAsShortRange(jail,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-98 Hapisten Kaçış')
		EndTextCommandSetBlipName(jail)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'bankalarm', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(jail, alpha)

			if alpha == 0 then
				RemoveBlip(jail)
				return
      		end
    	end
  	end
end)

---- Drug Sale ----

RegisterNetEvent('tac-alerts:drugsale')
AddEventHandler('tac-alerts:drugsale', function(targetCoords)
	if job == 'police' then
		local alpha = 250
		local drugsale = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipColour(drugsale, 1)
		SetBlipHighDetail(drugsale, true)
		SetBlipSprite(drugsale,  501)
		SetBlipScale(drugsale, 1.9)
		SetBlipAsShortRange(drugsale,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-31B Drug Sale')
		EndTextCommandSetBlipName(drugsale)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(drugsale, alpha)

			if alpha == 0 then
				RemoveBlip(drugsale)
				return
			end
		end
	end
end)



RegisterNetEvent('tac-alerts:trespass')
AddEventHandler('tac-alerts:trespass', function(targetCoords)
	if job == 'police' then
		local alpha = 250
		local drugsale = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
		SetBlipSprite(drugsale,  480)
		SetBlipColour(drugsale, 1)
		SetBlipHighDetail(drugsale, true)
		SetBlipScale(drugsale, 2.0)
		SetBlipAsShortRange(drugsale,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-31B Tresspassing')
		EndTextCommandSetBlipName(drugsale)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(drugsale, alpha)

			if alpha == 0 then
				RemoveBlip(drugsale)
				return
			end
		end
	end
end)
RegisterNetEvent('tac-alerts:mechanic')
AddEventHandler('tac-alerts:mechanic', function(targetCoords)
	if job == 'mechanic' then
		local alpha = 250
		local drugsale = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
		SetBlipSprite(drugsale,  402)
		SetBlipColour(drugsale, 47)
		SetBlipHighDetail(drugsale, true)
		SetBlipScale(drugsale, 2.0)
		SetBlipAsShortRange(drugsale,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Mechanic needed')
		EndTextCommandSetBlipName(drugsale)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(drugsale, alpha)

			if alpha == 0 then
				RemoveBlip(drugsale)
				return
			end
		end
	end
end)

RegisterNetEvent('tac-alerts:1050')
AddEventHandler('tac-alerts:1050', function(targetCoords)
	if job == 'police' or job == 'ambulance' then
		local alpha = 250
		local drugsale = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
		SetBlipSprite(drugsale,  380)
		SetBlipColour(drugsale, 1)
		SetBlipHighDetail(drugsale, true)
		SetBlipScale(drugsale, 2.0)
		SetBlipAsShortRange(drugsale,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-50')
		EndTextCommandSetBlipName(drugsale)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(drugsale, alpha)

			if alpha == 0 then
				RemoveBlip(drugsale)
				return
			end
		end
	end
end)

RegisterNetEvent('tac-alerts:powerGrid')
AddEventHandler('tac-alerts:powerGrid', function(targetCoords)
	if job == 'police' then
		local alpha = 250
		local powerGrid = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
		SetBlipSprite(powerGrid,  459)
		SetBlipColour(powerGrid, 1)
		SetBlipHighDetail(powerGrid, true)
		SetBlipScale(powerGrid, 2.0)
		SetBlipAsShortRange(powerGrid,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Power Grid Disturbance')
		EndTextCommandSetBlipName(powerGrid)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(powerGrid, alpha)

			if alpha == 0 then
				RemoveBlip(powerGrid)
				return
			end
		end
	end
end)

RegisterNetEvent('tac-alerts:PaletoBank')
AddEventHandler('tac-alerts:PaletoBank', function(targetCoords)
	if job == 'police' then
		local alpha = 250
		local paletoBank = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
		SetBlipSprite(paletoBank,  431)
		SetBlipColour(paletoBank, 1)
		SetBlipHighDetail(paletoBank, true)
		SetBlipScale(paletoBank, 2.0)
		SetBlipAsShortRange(paletoBank,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-90 In Progress')
		EndTextCommandSetBlipName(paletoBank)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(paletoBank, alpha)

			if alpha == 0 then
				RemoveBlip(paletoBank)
				return
			end
		end
	end
end)


RegisterNetEvent('tac-alerts:StoreCamNotif')
AddEventHandler('tac-alerts:StoreCamNotif', function(str)
	if job == 'police' then
		TriggerEvent('chat:addMessage', {
			template = '<div class="chat-message emergency">[DISPATCH]: {0} </div>',
			args = {str}
		})
	end
end)

RegisterNetEvent('nadrp:playerBecameJob')
AddEventHandler('nadrp:playerBecameJob', function(jobpassed)
    job = jobpassed.name
end)