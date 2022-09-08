
ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

isSmashed = {}
isSmashed[1] = false
isSmashed[2] = false
isSmashed[3] = false
isSmashed[4] = false
isSmashed[5] = false
isSmashed[6] = false
isSmashed[7] = false
isSmashed[8] = false
isSmashed[9] = false
isSmashed[10] = false
isSmashed[11] = false
isSmashed[12] = false
isSmashed[13] = false
isSmashed[14] = false
isSmashed[15] = false
isSmashed[16] = false
isSmashed[17] = false
isSmashed[18] = false
isSmashed[19] = false
isSmashed[20] = false

local trying = false
local DroppedCard = false
local weaponTypes = {
    ["2685387236"] = { "Unarmed", ["slot"] = 0 },
    ["3566412244"] = { "Melee", ["slot"] = 1 },
    ["-728555052"] = { "Melee", ["slot"] = 1 },
    ["416676503"] = { "Pistol", ["slot"] = 2 },
    ["3337201093"] = { "SMG", ["slot"] = 3 },
    ["970310034"] = { "AssaultRifle", ["slot"] = 4 },
    ["-957766203"] = { "AssaultRifle", ["slot"] = 4 },
    ["3539449195"] = { "DigiScanner", ["slot"] = 4 },
    ["4257178988"] = { "FireExtinguisher", ["slot"] = 0 },
    ["1159398588"] = { "MG", ["slot"] = 4 },
    ["3493187224"] = { "NightVision", ["slot"] = 0 },
    ["431593103"] = { "Parachute", ["slot"] = 0 },
    ["860033945"] = { "Shotgun", ["slot"] = 3 },
    ["3082541095"] = { "Sniper", ["slot"] = 3 },
    ["690389602"] = { "Stungun", ["slot"] = 1 },
    ["2725924767"] = { "Heavy", ["slot"] = 4 },
    ["1548507267"] = { "Thrown", ["slot"] = 0 },
    ["1595662460"] = { "PetrolCan", ["slot"] = 1 }
}

local locations = {
	[1] = {-626.5326,-238.3758,38.05},
	[2] = {-625.6032, -237.5273, 38.05},
	[3] = {-626.9178, -235.5166, 38.05},
	[4] = {-625.6701, -234.6061, 38.05},
	[5] = {-626.8935, -233.0814, 38.05},
	[6] = {-627.9514, -233.8582, 38.05},
	[7] = {-624.5250, -231.0555, 38.05},
	[8] = {-623.0003, -233.0833, 38.05},
	[9] = {-620.1098, -233.3672, 38.05},
	[10] = {-620.2979, -234.4196, 38.05},
	[11] = {-619.0646, -233.5629, 38.05},
	[12] = {-617.4846, -230.6598, 38.05},
	[13] = {-618.3619, -229.4285, 38.05},
	[14] = {-619.6064, -230.5518, 38.05},
	[15] = {-620.8951, -228.6519, 38.05},
	[16] = {-619.7905, -227.5623, 38.05},
	[17] = {-620.6110, -226.4467, 38.05},
	[18] = {-623.9951, -228.1755, 38.05},
	[19] = {-624.8832, -227.8645, 38.05},
	[20] = {-623.6746, -227.0025, 38.05},
}

local CopsNeeded = 4
local cops = 0

function weaponTypeC()
	local w = GetSelectedPedWeapon(PlayerPedId())
	local wg = GetWeapontypeGroup(w)
	if weaponTypes[""..wg..""] then
		return weaponTypes[""..wg..""]["slot"]
	else
		return 0
	end
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

RegisterNetEvent("jewel:cops")
AddEventHandler("jewel:cops", function(copAmount)
    cops = copAmount
end)

RegisterNetEvent("jewel:robbed")
AddEventHandler("jewel:robbed", function(newSet)
    isSmashed = newSet
end)

local jewelKOS = true
RegisterNetEvent('JewelKOS')
AddEventHandler('JewelKOS', function()
	if jewelKOS then
		return
	end
	jewelKOS = true
    SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION3`)
    SetPedRelationshipGroupHash(PlayerPedId(),`MISSION3`)
    Wait(60000)
    SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
    SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
    jewelKOS = false
end)

function DropItemPedBankCard()
    local pos = GetEntityCoords(PlayerPedId())
    local myluck = math.random(5)
    if myluck == 1 then
        TriggerEvent("player:receiveItem","securityblue",1)
    elseif myluck == 2 then
        TriggerEvent("player:receiveItem","securityblack",1)
    elseif myluck == 3 then
        TriggerEvent("player:receiveItem","securitygreen",1)
    elseif myluck == 4 then
        TriggerEvent("player:receiveItem","securitygold",1)
    else
        TriggerEvent("player:receiveItem","securityred",1)
    end
end

function giveitems()
	if weaponTypeC() >= 2 then
		if math.random(25) == 20 and not DroppedCard then
            DropItemPedBankCard()
            DroppedCard = true
		end

		TriggerEvent("player:receiveItem", "rolexwatch",math.random(5,10))

		if math.random(5) == 1 then
			TriggerEvent("player:receiveItem", "goldbar",math.random(1,3))
		end

        if weaponTypeC() >= 3 then
            if math.random(1,100) >= 75 then
                TriggerEvent("player:receiveItem", "valuablegoods",math.random(2))
            end
        end
    else
        TriggerEvent("player:receiveItem", "rolexwatch",math.random(1,5))
    end
end

RegisterNetEvent('spawning')
AddEventHandler('spawning', function()
    TriggerServerEvent("jewel:request")
end)

function AttackGlass(num)
    local coords = GetEntityCoords(PlayerPedId())
    streetName,street2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
	streetName = GetStreetNameFromHashKey(streetName)..' | '..GetStreetNameFromHashKey(street2)
	if math.random(100) > 85 or weaponTypeC() > 2 then
		Citizen.Wait(1500)
		ClearPedTasks(PlayerPedId())
		if math.random(50) > 30 then
            print('print')
            TriggerEvent('civilian:alertPolice', 90.0, 'vangelico', 0,0,0)

            exports['core_dispach']:addCall("10-90", "Vangelico in Progress",
            {-622.5833,-231.1677,38.05}, "police", 3000, 11, 5 )

		end
		TriggerServerEvent("jewel:isSmashed",num)
        exports['mythic_notify']:DoLongHudText('inform', 'You broke the glass and got some items!')
        TriggerEvent('client:newStress', true,math.random(1,3))
		giveitems()
        isSmashed[num] = true
        trying = false
	else
        exports['mythic_notify']:DoLongHudText('inform', "You failed to break the glass - more force would help.")
        ClearPedTasks(PlayerPedId())
        TriggerEvent('client:newStress', true,math.random(3,5))
        trying = false
	end
end

RegisterNetEvent('Attempt:jewelRob')
AddEventHandler('Attempt:jewelRob', function(useID)
    if not IsPedRunning(PlayerPedId()) and not IsPedSprinting(PlayerPedId()) and not isSmashed[useID] then
        trying = true
		local v = locations[useID]
		local player = GetPlayerPed( -1 )
        TaskTurnPedToFaceCoord(player,v[1],v[2],v[3],1.0)
		Citizen.Wait(2000)
		loadParticle()
		StartParticleFxLoopedAtCoord("scr_jewel_cab_smash",v[1],v[2],v[3], 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		loadAnimation()
		AttackGlass(useID)
	end
end)

-- #MarkedForMarker

Citizen.CreateThread(function()
	while true do

		if (#(GetEntityCoords(PlayerPedId()) - vector3(-626.5326, -238.3758, 38.05)) < 60.0) then

			--if (#(GetEntityCoords(PlayerPedId()) - vector3(-626.5326, -238.3758, 38.05)) < 20.0 and not isCop) then
				--if IsPedArmed(PlayerPedId(), 7) or IsPedInMeleeCombat(PlayerPedId()) or GetPedStealthMovement(PlayerPedId()) or IsPedPerformingStealthKill(PlayerPedId()) then
				--	TriggerEvent("JewelKOS")
				--end
			--end

			for i=1,#locations do
                local v = locations[i]
                if ( #(GetEntityCoords(PlayerPedId()) - vector3(v[1],v[2],v[3])) < 0.8 ) then
                    if (not isSmashed[i]) then
                        if trying == false then
                            DrawText3Ds(v[1],v[2],v[3])
                            if IsControlJustPressed(0,38) then
                                TriggerServerEvent('RS7x:CountCops')
                                Citizen.Wait(100)
                                if cops >= CopsNeeded then
                                    TriggerEvent('Attempt:jewelRob', i)
                                else
                                    exports['mythic_notify']:DoLongHudText('inform', 'There is not enough cops around')
                                end
                            end
                        end
                    end
                end
			end
			Citizen.Wait(1)
		else
			Citizen.Wait(6000)
		end
	end
end)

function loadParticle()
	if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
    RequestNamedPtfxAsset("scr_jewelheist")
    end
    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
    Citizen.Wait(0)
    end
    SetPtfxAssetNextCall("scr_jewelheist")
end

function loadAnimation()
	loadAnimDict( "missheist_jewel" ) 
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'robberyglassbreak', 0.5)
	TaskPlayAnim( PlayerPedId(), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
    Citizen.Wait(3200)
end


Citizen.CreateThread(function()
    Wait(900)
    while true do 
        local player = GetEntityCoords(PlayerPedId())
        local distance = #(vector3(-596.47, -283.96, 50.33) - player)
        if distance < 3.0 then
        	Wait(1)
             DrawMarker(27,-596.47, -283.96, 50.33, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.3, 11, 111, 11, 60, 0, 0, 2, 0, 0, 0, 0) 
             DT(-596.47, -283.96, 50.33, "[E] Unlock Doors")
             if IsControlJustReleased(0,38) and distance < 1.0 then
             	if exports["nadrp-inventory"]:hasEnoughOfItem("Gruppe6Card",1,false) then
             		TriggerEvent("inventory:removeItem", "Gruppe6Card", 1)
             		TriggerServerEvent("nadrp-doors:alterlockstate",173)
             		TriggerServerEvent("nadrp-doors:alterlockstate",174)
                 else
                    exports['mythic_notify']:DoLongHudText('error', 'You do not have the required resources!')
             	end
             end
		else
            Wait(3000)
        end        
    end
end)

function DT(x,y,z,text)
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

function DrawText3Ds(x,y,z)
	local text = "Press ~r~[E]~w~ to rob!"
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

RegisterNetEvent('jewel:resetCards')
AddEventHandler('jewel:resetCards', function()
    DroppedCard = false
end)

Citizen.CreateThread(function()
    while true do
        local hours = GetClockHours()
        if #(vector3(-113.2352, 6470.437, 31.63) - GetEntityCoords(GetPlayerPed(-1))) < 4.0 then
            Citizen.Wait(0)
            if hours >= 12 and hours <= 17 then
                DT(-113.2352, 6470.437, 31.63, '~r~[H]~w~ Trade in gold bars')
                if IsControlJustPressed(0, 74) and not recent then
                    exports['t0sic_loadingbar']:StartDelayedFunction('Trading Gold Bars', (math.random(40, 60) * 1000), function()
                        local itemCount = exports["nadrp-inventory"]:getQuantity("goldbar")
                        local hasItem = exports["nadrp-inventory"]:hasEnoughOfItem("goldbar",itemCount,true)
                        local sid = exports['nadrp-ped']:isPed('steamid')
                        if hasItem then
                            TriggerServerEvent('RS7x:TradeBars', itemCount)
                            Wait(2000)
                            recent = false
                            TriggerServerEvent("sendingItemstoClient", sid, PlayerId())
                        end
                    end)
                end
            else
                DT(-113.2352, 6470.437, 31.63, '~r~Closed')
            end
        else
            Citizen.Wait(500)
        end
    end
end)