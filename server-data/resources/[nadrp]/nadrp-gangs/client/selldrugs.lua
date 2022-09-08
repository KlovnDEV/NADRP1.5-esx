ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)


local pedsused = {}
local sellAmount = 0
local sellingweed = false
local sellingcocaine = false
local sellingmeth = false
local sellingcrack = false
local alerto = false
local cooldown = false
local hasDrugs = false
local sellAmount = 1

local hotSpots = {
	["Strawberry"] = { ["ratio"] = 0, ["zone"] = 1 },
	["Rancho"] = { ["ratio"] = 0, ["zone"] = 1 },
	["Vespucci Beach"] = { ["ratio"] = 0, ["zone"] = 1 },
	["Chamberlain Hills"] = { ["ratio"] = 0, ["zone"] = 1 },
	["Davis"] = { ["ratio"] = 0, ["zone"] = 1 },
	["West Vinewood"] = { ["ratio"] = 0, ["zone"] = 18 },
	["Downtown Vinewood"] = { ["ratio"] = 0, ["zone"] = 18 },

	["Lindsay Circus"] = { ["ratio"] = 0, ["zone"] = 2 },
	["Ginger St"] = { ["ratio"] = 0, ["zone"] = 2 },

	["Sandy Shores"] = { ["ratio"] = 0, ["zone"] = 1 },
	["Stab City"] = { ["ratio"] = 0, ["zone"] = 1 },
	["Harmony"] = { ["ratio"] = 0, ["zone"] = 1 },
	["Grapeseed"] = { ["ratio"] = 0, ["zone"] = 1 },
	["Paleto Bay"] = { ["ratio"] = 0, ["zone"] = 1 },
}

function EndSelling()
	sellAmount = 0
	sellingweed = false
	sellingcocaine = false
	sellingmeth = false
	sellingcrack = false
	alerto = false
	TriggerEvent('nadrp-density:SetPedDensity', 0.4)
end

local zoneNames = {
	AIRP = "Los Santos International Airport",
	ALAMO = "Alamo Sea",
	ALTA = "Alta",
	ARMYB = "Fort Zancudo",
	BANHAMC = "Banham Canyon Dr",
	BANNING = "Banning",
	BAYTRE = "Baytree Canyon", 
	BEACH = "Vespucci Beach",
	BHAMCA = "Banham Canyon",
	BRADP = "Braddock Pass",
	BRADT = "Braddock Tunnel",
	BURTON = "Burton",
	CALAFB = "Calafia Bridge",
	CANNY = "Raton Canyon",
	CCREAK = "Cassidy Creek",
	CHAMH = "Chamberlain Hills",
	CHIL = "Vinewood Hills",
	CHU = "Chumash",
	CMSW = "Chiliad Mountain State Wilderness",
	CYPRE = "Cypress Flats",
	DAVIS = "Davis",
	DELBE = "Del Perro Beach",
	DELPE = "Del Perro",
	DELSOL = "La Puerta",
	DESRT = "Grand Senora Desert",
	DOWNT = "Downtown",
	DTVINE = "Downtown Vinewood",
	EAST_V = "East Vinewood",
	EBURO = "El Burro Heights",
	ELGORL = "El Gordo Lighthouse",
	ELYSIAN = "Elysian Island",
	GALFISH = "Galilee",
	GALLI = "Galileo Park",
	golf = "GWC and Golfing Society",
	GRAPES = "Grapeseed",
	GREATC = "Great Chaparral",
	HARMO = "Harmony",
	HAWICK = "Hawick",
	HORS = "Vinewood Racetrack",
	HUMLAB = "Humane Labs and Research",
	JAIL = "Bolingbroke Penitentiary",
	KOREAT = "Little Seoul",
	LACT = "Land Act Reservoir",
	LAGO = "Lago Zancudo",
	LDAM = "Land Act Dam",
	LEGSQU = "Legion Square",
	LMESA = "La Mesa",
	LOSPUER = "La Puerta",
	MIRR = "Mirror Park",
	MORN = "Morningwood",
	MOVIE = "Richards Majestic",
	MTCHIL = "Mount Chiliad",
	MTGORDO = "Mount Gordo",
	MTJOSE = "Mount Josiah",
	MURRI = "Murrieta Heights",
	NCHU = "North Chumash",
	NOOSE = "N.O.O.S.E",
	OCEANA = "Pacific Ocean",
	PALCOV = "Paleto Cove",
	PALETO = "Paleto Bay",
	PALFOR = "Paleto Forest",
	PALHIGH = "Palomino Highlands",
	PALMPOW = "Palmer-Taylor Power Station",
	PBLUFF = "Pacific Bluffs",
	PBOX = "Pillbox Hill",
	PROCOB = "Procopio Beach",
	RANCHO = "Rancho",
	RGLEN = "Richman Glen",
	RICHM = "Richman",
	ROCKF = "Rockford Hills",
	RTRAK = "Redwood Lights Track",
	SanAnd = "San Andreas",
	SANCHIA = "San Chianski Mountain Range",
	SANDY = "Sandy Shores",
	SKID = "Mission Row",
	SLAB = "Stab City",
	STAD = "Maze Bank Arena",
	STRAW = "Strawberry",
	TATAMO = "Tataviam Mountains",
	TERMINA = "Terminal",
	TEXTI = "Textile City",
	TONGVAH = "Tongva Hills",
	TONGVAV = "Tongva Valley",
	VCANA = "Vespucci Canals",
	VESP = "Vespucci",
	VINE = "Vinewood",
	WINDF = "Ron Alternates Wind Farm",
	WVINE = "West Vinewood",
	ZANCUDO = "Zancudo River",
	ZP_ORT = "Port of South Los Santos",
	ZQ_UAR = "Davis Quartz"
}

function GetRandomNPC()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped,true) and distance > 1.0 and distance < 25.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped
            success = false
            pedsused["conf"..rped] = true
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped
end

function canPedBeUsed(ped,fresh)
    if ped == nil then
        return false
    end
    if pedsused["conf"..ped] and fresh then
      return false
    end
    if ped == GetPlayerPed(-1) then
        return false
    end

    if not DoesEntityExist(ped) then
        return false
    end

    if IsPedAPlayer(ped) then
        return false
    end

    if IsPedFatallyInjured(ped) then
        return false
    end

    if IsPedFleeing(ped) then
        return false
    end

    if IsPedInCover(ped) or IsPedGoingIntoCover(ped) or IsPedGettingUp(ped) then
        return false
    end

    if IsPedInMeleeCombat(ped) then
        return false
    end

    if IsPedShooting(ped) then
        return false
    end

    if IsPedDucking(ped) then
        return false
    end

    if IsPedBeingJacked(ped) then
        return false
    end

    if IsPedSwimming(ped) then
        return false
    end

    if IsPedSittingInAnyVehicle(ped) or IsPedGettingIntoAVehicle(ped) or IsPedJumpingOutOfVehicle(ped) or IsPedBeingJacked(ped) then
        return false
    end

    if IsPedOnAnyBike(ped) or IsPedInAnyBoat(ped) or IsPedInFlyingVehicle(ped) then
        return false
    end

    local pedType = GetPedType(ped)
    if pedType == 6 or pedType == 27 or pedType == 29 or pedType == 28 then
        return false
    end

    return true
end

RegisterNetEvent('nadrp-selldrugs:start')
AddEventHandler('nadrp-selldrugs:start', function()
	if cooldown then
		exports['mythic_notify']:DoLongHudText('error', 'You can only set up on corner once every 1 minute.')
		return
	end

	if sellingcocaine or sellingcrack or sellingweed  or sellingmeth then
		EndSelling()
	end
	local plyId = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(plyId, true))
    local zone = tostring(GetNameOfZone(x, y, z))
    local Area = zoneNames[tostring(zone)]
    local x, y, z = table.unpack(GetEntityCoords(plyId, true))

    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
	MyStreetName = GetStreetNameFromHashKey(currentStreetHash)
	local plyCoords = GetEntityCoords(PlayerPedId())
    local dst = #(plyCoords - vector3(143.62,-1766.86,28.4))
	print(MyStreetName)
    if (MyStreetName == "Forum Dr" or MyStreetName == "Brouge Ave" or MyStreetName == "Grove St" or MyStreetName == "Macdonald St" or MyStreetName == "Carson Ave") and exports["nadrp-inventory"]:hasEnoughOfItem("weedq",1,false) or exports["nadrp-inventory"]:hasEnoughOfItem("weedq2",1,false) and dst < 500.0 then
		exports['mythic_notify']:DoLongHudText('inform', 'You are corner selling weed.')
	    sellingweed = true
	    cooldown = true
    elseif (MyStreetName == "Lindsay Circus" or MyStreetName == "Ginger St" or MyStreetName == "Jamestown St" or MyStreetName == "West Eclipse Blvd") then
		exports['mythic_notify']:DoLongHudText('inform', 'You are corner selling cocaine')
		sellingcocaine = true
		cooldown = true
	else
	    if not hotSpots[Area] then
			exports['mythic_notify']:DoLongHudText('error', 'You cant do that here..')
	    	return
	    end
		if hotSpots[Area]["zone"] == 18 then
			exports['mythic_notify']:DoLongHudText('inform', 'This spot is too hot.')
			return
	    end

		-- if hotSpots[Area]["zone"] == 1 then
		-- 	exports['mythic_notify']:DoLongHudText('inform', 'You are corner selling crack.')
	    -- 	sellingcrack = true
	    -- 	cooldown = true		
		-- end
		if hotSpots[Area]["zone"] == 1 then
			exports['mythic_notify']:DoLongHudText('inform', 'You are corner selling meth.')
			sellingmeth = true
			cooldown = true
		end
	end

    local plyStartCoords = plyCoords
    TriggerEvent('nadrp-density:SetPedDensity', 0.6)
    while sellingcocaine or sellingcrack or sellingweed or sellingmeth do
    	Wait(15000)
		exports['mythic_notify']:DoLongHudText('inform', 'Corner Selling Active.')
    	local curCoords = GetEntityCoords(PlayerPedId())
		local dstCheck = #(plyStartCoords - curCoords)

		if dstCheck > 45.0 then
			exports['mythic_notify']:DoLongHudText('error', 'You moved too far and now we have reset your corner sales.')
			EndSelling()
		end

		local RandomNPC = GetRandomNPC()
		local x, y, z = table.unpack(GetEntityCoords(plyId, true))
	    local zone = tostring(GetNameOfZone(x, y, z))
	    local Area = zoneNames[tostring(zone)]
	    local extraValue = 0
	    if hotSpots[Area] then
	    	extraValue = hotSpots[Area]["ratio"]
	    end
		local areaValue = extraValue
		local saleprice = 1
		if math.random(100) < 90 then
			saleprice = 1
			if sellingcocaine then
				saleprice = 5 + math.random(1,5)
			elseif sellingmeth then
				saleprice = 3 + math.random(1,2)
			elseif sellingweed then
				saleprice = 3
			end
		end

		saleprice = saleprice * sellAmount
		if sellingweed then
			saleprice = math.ceil(saleprice / 1.2)
		end
		TriggerEvent("nadrp-selldrugs:AllowSale", RandomNPC, saleprice, sellAmount)
    end
	exports['mythic_notify']:DoLongHudText('error', 'Sales Ended')
	TriggerEvent('nadrp-density:SetPedDensity', 0.4)
    Wait(60000)
    cooldown = false
end)

RegisterNetEvent('nadrp-selldrugs:MovePed')
AddEventHandler("nadrp-selldrugs:MovePed",function(p)
    local usingped = p

    local nm1 = math.random(6,9) / 100
    local nm2 = math.random(6,9) / 100
    nm1 = nm1 + 0.3
    nm2 = nm2 + 0.3
    if math.random(10) > 5 then
      nm1 = 0.0 - nm1
    end

    if math.random(10) > 5 then
      nm2 = 0.0 - nm2
    end

    local moveto = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), nm1, nm2, 0.0)
    TaskGoStraightToCoord(usingped, moveto, 1.0, 30.0, 0.0, 0.0)
    SetPedKeepTask(usingped, true) 

    local dist = GetDistanceBetweenCoords(moveto, GetEntityCoords(usingped), false)
    local toolong = 0
    local lastcheck = GetDistanceBetweenCoords(GetEntityCoords(usingped),GetEntityCoords(GetPlayerPed(-1)))

    while dist > 3.5 and toolong < 600 and GetDistanceBetweenCoords(GetEntityCoords(usingped),GetEntityCoords(GetPlayerPed(-1))) > 1.5 do
    	local dstmoved = lastcheck - GetDistanceBetweenCoords(GetEntityCoords(usingped),GetEntityCoords(GetPlayerPed(-1)))
    	if dstmoved < 0.5 then
    		toolong = toolong + 20
    	end
      	toolong = toolong + 1
      	TaskGoStraightToCoord(usingped, moveto, 1.0, 30.0, 0.0, 0.0)
      	dist = GetDistanceBetweenCoords(moveto, GetEntityCoords(usingped), false)
      	Citizen.Wait(1000)
      	lastcheck = GetDistanceBetweenCoords(GetEntityCoords(usingped),GetEntityCoords(GetPlayerPed(-1)))
    end

    if toolong > 500 then
    	TaskWanderStandard(usingped, 10.0, 10)
    else 
	    TaskLookAtEntity(usingped, GetPlayerPed(-1), 5500.0, 2048, 3)
	    TaskTurnPedToFaceEntity(usingped, GetPlayerPed(-1), 5500)
	    if not sellingweed then
		    TaskStartScenarioInPlace(usingped, "WORLD_HUMAN_BUM_STANDING", 0, 1)
		end
    end
end)

RegisterNetEvent('nadrp-selldrugs:AllowSale')
AddEventHandler('nadrp-selldrugs:AllowSale', function(NPC,saleprice,amount)
	local timer = 0
	local plyCoords = GetEntityCoords(PlayerPedId())
	local startdst = #(GetEntityCoords(NPC) - plyCoords)
	TriggerEvent("nadrp-selldrugs:MovePed",NPC)
	while true do
		if not canPedBeUsed(NPC,false) then
			return
		end 
		local curdst = #(GetEntityCoords(NPC) - plyCoords)
		if curdst-4 > startdst then
			TaskWanderStandard(NPC, 10.0, 10)
			return
		end
		local x,y,z=table.unpack(GetEntityCoords(NPC))
		DrawText3D(x,y,z, "[E] to sell drugs for "..saleprice.." rolls of cash! " .. " [H] to shoo")
		if IsControlJustReleased(1, 38) and #(plyCoords - vector3(x,y,z)) < 3.0 then
			if IsPedModel(NPC,416176080) or IsPedInAnyVehicle(PlayerPedId(), false) then
				exports['mythic_notify']:DoLongHudText('inform', 'He seems to have changed his mind', 5000)
				if math.random(1, 5) == 1 then
					TriggerEvent("civilian:alertPolice",25.0,"drugsale",0)
				end
				TaskWanderStandard(NPC, 10.0, 10)
				return
			end
			ClearPedTasks(NPC)
			ClearPedSecondaryTask(NPC)
			TaskTurnPedToFaceEntity(NPC, PlayerPedId(), 1.0)
			SellDrugs(NPC,saleprice, amount)
			return
		end
		if IsControlJustReleased(1, 74) and #(plyCoords - vector3(x,y,z)) < 5.0 then
			TaskWanderStandard(NPC, 10.0, 10)
			if math.random(1, 3) == 1 then
				TriggerEvent("civilian:alertPolice",25.0,"drugsale",0)
			end
			return
		end
		timer = timer + 1
		if timer > 60000 then
			TaskWanderStandard(NPC, 10.0, 10)
			return
		end
		Wait(1)
	end
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function giveAnim(NPC)
    if ( DoesEntityExist( NPC ) and not IsEntityDead( NPC ) ) then 
	    loadAnimDict( "random@mugging4" )
	    TaskPlayAnim( NPC, "random@mugging4", "agitated_loop_a", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
	    Wait(1000)
        loadAnimDict( "mp_safehouselost@" )
        TaskPlayAnim( NPC, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    end
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
		streetName = GetStreetNameFromHashKey(streetName)
	end
end)

function SellDrugs(NPC,saleprice,amount)
	local success = true
	Citizen.Wait(500)

	PlayAmbientSpeech1(NPC, "Chat_State", "Speech_Params_Force")
	giveAnim(NPC)
	Wait(1000)
	local counter = math.random(100,300)
	while counter > 0 do
		counter = counter - 1
		Citizen.Wait(1)
	end

	local crds = GetEntityCoords(NPC)
	local crds2 = GetEntityCoords(PlayerPedId())

	if #(crds - crds2) > 5.0 or not DoesEntityExist(NPC) or IsEntityDead(NPC) then
		return
	end

	local crack = exports["nadrp-inventory"]:hasEnoughOfItem("1gcrack",amount,false)
	if crack and sellingcrack then
		TriggerEvent("inventory:removeItem", "1gcrack", amount)
	end

	local weedbaggies = exports["nadrp-inventory"]:hasEnoughOfItem("weedq",amount,false)
	if weedbaggies and sellingweed then
		TriggerEvent("inventory:removeItem", "weedq", amount)
	end

	local methbag = exports["nadrp-inventory"]:hasEnoughOfItem("methbag",amount,false)
	if methbag and sellingmeth then
		TriggerEvent("inventory:removeItem", "methbag", amount)
	end

	local cocaine = exports["nadrp-inventory"]:hasEnoughOfItem("1gcocaine",amount,false)
	if cocaine and sellingcocaine then
		TriggerEvent("inventory:removeItem", "1gcocaine", amount)
	end

	if not weedbaggies and sellingweed then
		EndSelling()
		TaskWanderStandard(NPC, 10.0, 10)
		return
	end

	if not cocaine and sellingcocaine then
		EndSelling()
		TaskWanderStandard(NPC, 10.0, 10)
		return
	end

	if not crack and sellingcrack then
		EndSelling()
		TaskWanderStandard(NPC, 10.0, 10)
		return
	end

	if not methbag and sellingmeth then
		EndSelling()
		TaskWanderStandard(NPC, 10.0, 10)
		return
	end

	if sellingcrack or sellingcocaine or sellingweed or sellingmeth then
		if amount > 1 then
			if math.random(1, 8) == 1 then
				TriggerEvent("tac-dispatch:drugsale")
			end
		end
		TriggerEvent("player:receiveItem","cashroll",saleprice)
		PlayAmbientSpeech1(NPC, "Generic_Thanks", "Speech_Params_Force_Shouted_Critical")
		TriggerEvent("client:newStress",true,math.random(3,5))
		giveAnim(PlayerPedId())
		Wait(4000)
		TaskWanderStandard(NPC, 10.0, 10)
	end
end

RegisterNetEvent('nadrp-gangs:corner:amount')
AddEventHandler('nadrp-gangs:corner:amount', function(newAmount)
	sellAmount = tonumber(newAmount)
	if sellAmount > 3 then
		exports['mythic_notify']:DoLongHudText('inform', 'You can only set amount between 1-3, setting amount to 3')
		sellAmount = 3
	end
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.31, 0.31)
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

function loadModel(modelName)
    RequestModel(GetHashKey(modelName))
    while not HasModelLoaded(GetHashKey(modelName)) do
        RequestModel(GetHashKey(modelName))
        Citizen.Wait(1)
    end
end

function loadAnim( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

RegisterCommand("postup", function(source, args, rawCommand)
	local amount = args[1]
	ESX.TriggerServerCallback('GetPoliceOnline', function(CopsConnected)
		local pData = ESX.GetPlayerData()
		if pData.job.name ~= "police" then
			if CopsConnected >= 1 then
				if amount ~= nil then
					if not IsPedInAnyVehicle(PlayerPedId(), false) then
						TriggerEvent('nadrp-selldrugs:start', CopsConnected)
						TriggerEvent('nadrp-gangs:corner:amount', amount)
					else
						exports['mythic_notify']:DoLongHudText('error', 'I think you must be stupid.')
					end
				else
					exports['mythic_notify']:DoLongHudText('error', '/postup [amount 1-3]')
				end
			else
				exports['mythic_notify']:DoLongHudText('error', 'There are no authorities in the city to do this!!')
			end
		else
			exports['mythic_notify']:DoLongHudText('error', 'You\'re a cop!')
		end
	end)
end, false)