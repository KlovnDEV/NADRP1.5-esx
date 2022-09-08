ESX = nil
TriggerEvent('tac:getSharedObject', function (obj) ESX = obj end)

local scanId = 0
local cityRobbery = false
local myspawns = {}
local isLockpicking = false
local inCam = false
local securityCam = 0
local CorrectStore = 0
local started = false
local fuck = 0
local you = 0
local CopsNeeded = 2

local SecurityCamLocations = {
	[1] =  { ['x'] = 24.18,['y'] = -1347.35,['z'] = 29.5,['h'] = 271.32, ['info'] = ' Innocence Blvd - 1', ["recent"] = false },
	[2] =  { ['x'] = -46.56,['y'] = -1757.98,['z'] = 29.43,['h'] = 48.68, ['info'] = ' Grove Street - 2', ["recent"] = false },
	[3] =  { ['x'] = -706.02,['y'] = -913.61,['z'] = 19.22,['h'] = 85.61, ['info'] = ' Little Seoul - 3', ["recent"] = false },
	[4] =  { ['x'] = -1221.97,['y'] = -908.42,['z'] = 12.33,['h'] = 31.1, ['info'] = ' San Andreas Ave - 4', ["recent"] = false },
	[5] =  { ['x'] = 1164.99,['y'] = -322.78,['z'] = 69.21,['h'] = 96.91, ['info'] = ' Mirror Park Blvd - 5', ["recent"] = false },
	[6] =  { ['x'] = 372.25,['y'] = 326.43,['z'] = 103.57,['h'] = 252.9, ['info'] = '  Clinton Ave - 6', ["recent"] = false },
	[7] =  { ['x'] = -1819.98,['y'] = 794.57,['z'] = 138.09,['h'] = 126.56, ['info'] = ' North Rockford Drive - 7', ["recent"] = false },
	[8] =  { ['x'] = -2966.24,['y'] = 390.94,['z'] = 15.05,['h'] = 84.58, ['info'] = '  Great Ocean Highway - 8', ["recent"] = false },
	[9] =  { ['x'] = -3038.92,['y'] = 584.21,['z'] = 7.91,['h'] = 19.43, ['info'] = ' Inseno Road - 9', ["recent"] = false },
	[10] =  { ['x'] = -3242.48,['y'] = 999.79,['z'] = 12.84,['h'] = 351.35, ['info'] = ' Barbareno Road - 10', ["recent"] = false },
	[11] =  { ['x'] = 2557.14,['y'] = 380.64,['z'] = 108.63,['h'] = 353.01, ['info'] = ' Palomino Freeway - 11', ["recent"] = false },
	[12] =  { ['x'] = 1166.02,['y'] = 2711.15,['z'] = 38.16,['h'] = 175.0, ['info'] = '  Harmony Rt 68 - 12', ["recent"] = false },
	[13] =  { ['x'] = 549.32,['y'] = 2671.3,['z'] = 42.16,['h'] = 94.96, ['info'] = ' Rt 68/Joshua Rd - 13', ["recent"] = false },
	[14] =  { ['x'] = 1959.96,['y'] = 3739.99,['z'] = 32.35,['h'] = 296.38, ['info'] = ' Alhambra Drive - 14', ["recent"] = false },
	[15] =  { ['x'] = 2677.98,['y'] = 3279.28,['z'] = 55.25,['h'] = 327.81, ['info'] = ' Senora / Sandy Shores - 15', ["recent"] = false },
	[16] =  { ['x'] = 1392.88,['y'] = 3606.7,['z'] = 34.99,['h'] = 201.69, ['info'] = ' Algonquin Blvd - 16', ["recent"] = false },
	[17] =  { ['x'] = 1697.8,['y'] = 4922.69,['z'] = 42.07,['h'] = 322.95, ['info'] = ' Grapeseed Main - 17', ["recent"] = false },
	[18] =  { ['x'] = 1728.82,['y'] = 6417.38,['z'] = 35.04,['h'] = 233.94, ['info'] = ' North Senora / Pelato - 18', ["recent"] = false },
	[19] =  { ['x'] = 733.45,['y'] = 127.58,['z'] = 80.69,['h'] = 285.51, ['info'] = ' Cam Power' },
	[20] =  { ['x'] = 1846.32,['y'] = 2597.93,['z'] = 45.64,['h'] = 311.88, ['info'] = ' Cam Jail Front' },
	[21] =  { ['x'] = 1807.71,['y'] = 2590.62,['z'] = 45.64,['h'] = 143.41, ['info'] = ' Cam Jail Prisoner Drop Off' },
	[22] =  { ['x'] = -644.24,['y'] = -241.11,['z'] = 37.97,['h'] = 282.81, ['info'] = ' Cam Jewelry Store' },
	[23] =  { ['x'] = 1793.32,['y'] = 2678.28,['z'] = -70.04,['h'] = 155.04, ['info'] = ' Cam Jail Food' },
	[24] =  { ['x'] = 1724.71,['y'] = 2648.98,['z'] = 45.61,['h'] = 220.23, ['info'] = ' Cam Jail Cell Row 1' },
	[25] =  { ['x'] = 1724.71,['y'] = 2638.03,['z'] = 45.61,['h'] = 260.55, ['info'] = ' Cam Jail Cell Row 2' },
	[26] =  { ['x'] = 1724.77,['y'] = 2630.2,['z'] = 45.61,['h'] = 261.11, ['info'] = ' Cam Jail Cell Row 3' },
	[27] =  { ['x'] = -115.3,['y'] = 6441.41,['z'] = 31.53,['h'] = 341.95, ['info'] = ' Cam Paleto Bank Outside' },
	[28] =  { ['x'] = 240.07,['y'] = 218.97,['z'] = 106.29,['h'] = 276.14, ['info'] = ' Cam Main Bank 1' },
}
--4 8 12 16
storePedLocations = {
	[1] =  { ['x'] = 24.18,['y'] = -1347.35,['z'] = 29.5,['h'] = 271.32, ['info'] = ' Store Robbery 1', ["recent"] = false, ["safe"] = true },
	[2] =  { ['x'] = -46.56,['y'] = -1757.98,['z'] = 29.43,['h'] = 48.68, ['info'] = ' Store Robbery 2', ["recent"] = false, ["safe"] = true },
	[3] =  { ['x'] = -706.02,['y'] = -913.61,['z'] = 19.22,['h'] = 85.61, ['info'] = ' Store Robbery 3', ["recent"] = false, ["safe"] = true },
	[4] =  { ['x'] = -1221.97,['y'] = -908.42,['z'] = 12.33,['h'] = 31.1, ['info'] = ' Store Robbery 4', ["recent"] = false, ["safe"] = true },
	[5] =  { ['x'] = 1164.99,['y'] = -322.78,['z'] = 69.21,['h'] = 96.91, ['info'] = ' Store Robbery 5', ["recent"] = false, ["safe"] = true },
	[6] =  { ['x'] = 372.25,['y'] = 326.43,['z'] = 103.57,['h'] = 252.9, ['info'] = ' Store Robbery 6', ["recent"] = false, ["safe"] = true },
	[7] =  { ['x'] = -1819.98,['y'] = 794.57,['z'] = 138.09,['h'] = 126.56, ['info'] = ' Store Robbery 7', ["recent"] = false, ["safe"] = true },
	[8] =  { ['x'] = -2966.24,['y'] = 390.94,['z'] = 15.05,['h'] = 84.58, ['info'] = ' Store Robbery 8', ["recent"] = false, ["safe"] = true },
	[9] =  { ['x'] = -3038.92,['y'] = 584.21,['z'] = 7.91,['h'] = 19.43, ['info'] = ' Store Robbery 9', ["recent"] = false, ["safe"] = true },
	[10] =  { ['x'] = -3242.48,['y'] = 999.79,['z'] = 12.84,['h'] = 351.35, ['info'] = ' Store Robbery 10', ["recent"] = false, ["safe"] = true },
	[11] =  { ['x'] = 2557.14,['y'] = 380.64,['z'] = 108.63,['h'] = 353.01, ['info'] = ' Store Robbery 11', ["recent"] = false, ["safe"] = true },
	[12] =  { ['x'] = 1166.02,['y'] = 2711.15,['z'] = 38.16,['h'] = 175.0, ['info'] = ' Store Robbery 12', ["recent"] = false, ["safe"] = true },
	[13] =  { ['x'] = 549.32,['y'] = 2671.3,['z'] = 42.16,['h'] = 94.96, ['info'] = ' Store Robbery 13', ["recent"] = false, ["safe"] = true },
	[14] =  { ['x'] = 1959.96,['y'] = 3739.99,['z'] = 32.35,['h'] = 296.38, ['info'] = ' Store Robbery 14', ["recent"] = false, ["safe"] = true },
	[15] =  { ['x'] = 2677.98,['y'] = 3279.28,['z'] = 55.25,['h'] = 327.81, ['info'] = ' Store Robbery 15', ["recent"] = false, ["safe"] = true },
	[16] =  { ['x'] = 1392.88,['y'] = 3606.7,['z'] = 34.99,['h'] = 201.69, ['info'] = ' Store Robbery 16', ["recent"] = false, ["safe"] = false },
	[17] =  { ['x'] = 1697.8,['y'] = 4922.69,['z'] = 42.07,['h'] = 322.95, ['info'] = ' Store Robbery 17', ["recent"] = false, ["safe"] = true },
	[18] =  { ['x'] = 1728.82,['y'] = 6417.38,['z'] = 35.04,['h'] = 233.94, ['info'] = ' Store Robbery 18', ["recent"] = false, ["safe"] = true },
}


safeLocations = {
	[1] =  { ['x'] = 28.26,['y'] = -1339.25,['z'] = 29.5,['h'] = 356.94, ['info'] = ' 1 safe' },
	[2] =  { ['x'] = -43.44,['y'] = -1748.46,['z'] = 29.43,['h'] = 48.64, ['info'] = ' 2 safe' },
	[3] =  { ['x'] = -709.67,['y'] = -904.19,['z'] = 19.22,['h'] = 84.34, ['info'] = ' 3 safe' },
	[4] =  { ['x'] = -1220.84,['y'] = -915.88,['z'] = 11.33,['h'] = 125.89, ['info'] = ' 4 safe' },
	[5] =  { ['x'] = 1159.78,['y'] = -314.06,['z'] = 69.21,['h'] = 99.31, ['info'] = ' 5 safe' },
	[6] =  { ['x'] = 378.08,['y'] = 333.37,['z'] = 103.57,['h'] = 338.48, ['info'] = ' 6 safe' },
	[7] =  { ['x'] = -1829.03,['y'] = 798.92,['z'] = 138.19,['h'] = 127.41, ['info'] = ' 7 safe' },
	[8] =  { ['x'] = -2959.64,['y'] = 387.16,['z'] = 14.05,['h'] = 173.43, ['info'] = ' 8 safe' },
	[9] =  { ['x'] = -3047.55,['y'] = 585.67,['z'] = 7.91,['h'] = 104.0, ['info'] = ' 9 safe' },
	[10] =  { ['x'] = -3249.92,['y'] = 1004.42,['z'] = 12.84,['h'] = 81.06, ['info'] = ' 10 safe' },
	[11] =  { ['x'] = 2549.25,['y'] = 384.91,['z'] = 108.63,['h'] = 84.09, ['info'] = ' 11 safe' },
	[12] =  { ['x'] = 1169.24,['y'] = 2717.96,['z'] = 37.16,['h'] = 266.31, ['info'] = ' 12 safe' },
	[13] =  { ['x'] = 546.42,['y'] = 2663.01,['z'] = 42.16,['h'] = 186.64, ['info'] = ' 13 safe' },
	[14] =  { ['x'] = 1959.27,['y'] = 3748.78,['z'] = 32.35,['h'] = 26.58, ['info'] = ' 14 safe' },
	[15] =  { ['x'] = 2672.89,['y'] = 3286.54,['z'] = 55.25,['h'] = 60.89, ['info'] = ' 15 safe' },
	[16] =  { ['x'] = 0.0,['y'] = 0.0,['z'] = 0.0,['h'] = 60.89, ['info'] = ' 16 safe' },
	[17] =  { ['x'] = 1707.66,['y'] = 4920.13,['z'] = 42.07,['h'] = 320.34, ['info'] = ' 17 safe' },
	[18] =  { ['x'] = 1734.69,['y'] = 6420.48,['z'] = 35.04,['h'] = 332.9, ['info'] = ' 18 safe' },
}

local registers = {
    [1] = {["x"] = 24.451, ["y"] = -1347.4, ["z"] = 29.497, ["h"] = 268.138,  ["Robbed"] = false},
    [2] = {["x"] = 24.422, ["y"] = -1345.033, ["z"] = 29.497, ["h"] = 279.993,  ["Robbed"] = false},
    [3] = {["x"] = -47.861, ["y"] = -1759.348, ["z"] = 29.421, ["h"] = 60.246,  ["Robbed"] = false},
    [4] = {["x"] = -46.753, ["y"] = -1758.096, ["z"] = 29.421, ["h"] = 52.583,  ["Robbed"] = false},
    [5] = {["x"] = -706.036, ["y"] = -915.436, ["z"] = 19.216, ["h"] = 90.733,  ["Robbed"] = false},
    [6] = {["x"] = -706.003, ["y"] = -913.698, ["z"] = 19.216, ["h"] = 90.895,  ["Robbed"] = false},
    [7] = {["x"] = -1222.056, ["y"] = -908.334, ["z"] = 12.326, ["h"] = 33.048,  ["Robbed"] = false},
    [8] = {["x"] = 1165.017, ["y"] = -324.523, ["z"] = 69.205, ["h"] = 100.675,  ["Robbed"] = false},
    [9] = {["x"] = 1164.814, ["y"] = -322.743, ["z"] = 69.205, ["h"] = 96.523,  ["Robbed"] = false},
    [10] = {["x"] = 373.009, ["y"] = 328.669, ["z"] = 103.566, ["h"] = 250.414,  ["Robbed"] = false},
    [11] = {["x"] = 372.428, ["y"] = 326.414, ["z"] = 103.566, ["h"] = 252.695,  ["Robbed"] = false},
    [12] = {["x"] = -1818.816, ["y"] = 792.946, ["z"] = 138.081, ["h"] = 136.773,  ["Robbed"] = false},
    [13] = {["x"] = -1820.104, ["y"] = 794.329, ["z"] = 138.088, ["h"] = 134.89,  ["Robbed"] = false},
    [14] = {["x"] = -2966.281, ["y"] = 390.905, ["z"] = 15.043, ["h"] = 86.769,  ["Robbed"] = false},
    [15] = {["x"] = -3038.996, ["y"] = 584.394, ["z"] = 7.909, ["h"] = 15.447,  ["Robbed"] = false},
    [16] = {["x"] = -3041.035, ["y"] = 583.729, ["z"] = 7.909, ["h"] = 1.64,  ["Robbed"] = false},
    [17] = {["x"] = -3242.48, ["y"] = 999.844, ["z"] = 12.831, ["h"] = 346.842,  ["Robbed"] = false},
    [18] = {["x"] = -3244.845, ["y"] = 1000.119, ["z"] = 12.831, ["h"] = 338.975,  ["Robbed"] = false},
    [19] = {["x"] = 2557.1, ["y"] = 380.617, ["z"] = 108.623, ["h"] = 1.091,  ["Robbed"] = false},
    [20] = {["x"] = 2555.234, ["y"] = 380.692, ["z"] = 108.623, ["h"] = 345.982,  ["Robbed"] = false},
    [21] = {["x"] = 1166.054, ["y"] = 2711.017, ["z"] = 38.158, ["h"] = 180.56,  ["Robbed"] = false},
	[22] = {["x"] = 1696.556, ["y"] = 4924.006, ["z"] = 42.064, ["h"] = 353.408, ["Robbed"] = false},
    [23] = {["x"] = 1698.028, ["y"] = 4922.919, ["z"] = 42.064, ["h"] = 323.294,  ["Robbed"] = false},
	[24] = {["x"] = 549.478, ["y"] = 2669.102, ["z"] = 42.157, ["h"] = 99.857, ["Robbed"] = false},
    [25] = {["x"] = 549.028, ["y"] = 2671.387, ["z"] = 42.157, ["h"] = 94.808,  ["Robbed"] = false}
}

RegisterNetEvent("lucky:storebro")
AddEventHandler("lucky:storebro", function()
	CorrectStore = math.random(18)
    TriggerEvent("phone:addnotification", "EMAIL ", "Hey, I heard a store has some hot shit in it, go check it out @" .. SecurityCamLocations[CorrectStore]["info"])
end)


RegisterNetEvent("security:camera")
AddEventHandler("security:camera", function(camNumber)
	camNumber = tonumber(camNumber)
	if inCam then
		inCam = false
		TriggerEvent('animation:tablet',false)
		Wait(250)
		ClearPedTasks(PlayerPedId())
	else
		if camNumber > 0 and camNumber < #SecurityCamLocations+1 then
			TriggerEvent("security:startcamera",camNumber)
		else
			exports['mythic_notify']:DoLongHudText('error', 'This camera appears to be faulty')
		end
	end
end)

function SafeCheck()
	for i = 1, #storePedLocations do
		penis = true
		SetEntityCoords(PlayerPedId(),storePedLocations[i]["x"],storePedLocations[i]["y"],storePedLocations[i]["z"])
		while penis do
			Wait(1)
			if IsControlJustPressed(0,38) then
				penis = false
				print(i+1)
			end
		end
	end
end

RegisterNetEvent("police:notifySecurityCam")
AddEventHandler("police:notifySecurityCam", function()
	local currentRobbery = isStoreRobbery()
	local str = "Security Camera number [" .. currentRobbery .. "] has been triggered."
	TriggerServerEvent('tac_outlawalert:StoreCamNotif', str)
end)

-- store robbery checks
RegisterNetEvent("store:dosafe")
AddEventHandler("store:dosafe", function()
	TriggerEvent("civilian:alertPolice",8.0,"robberyhouse",0)
	TriggerEvent("safecracking:loop",8,"robbery:safe")
end)

RegisterNetEvent("store:register")
AddEventHandler("store:register", function(storeid,regid)
	TriggerEvent("esx-dispatch:storerobbery")
	TriggerEvent("civilian:alertPolice",8.0,"robberyhouse",0)
	TriggerEvent("safecracking:loop",3,"robbery:register")
	fuck = storeid
	you = regid
	isLockpicking = true
	TriggerEvent('police:notifySecurityCam')
end)

RegisterNetEvent("stores:onUse")
AddEventHandler("stores:onUse", function()
	if isLockpicking then return end
	local storeid = isStoreRobbery()
	local curCoords = GetEntityCoords(PlayerPedId())
	local RegisterObject = GetClosestObjectOfType(curCoords, 2.0, 303280717, 0, 0, 0)
	local GoodSpot = GetOffsetFromEntityInWorldCoords(RegisterObject, 0.0, -0.6, 0.0)
	streetName,street2 = GetStreetNameAtCoord(curCoords.x, curCoords.y, curCoords.z)
	streetName = GetStreetNameFromHashKey(streetName)..' | '..GetStreetNameFromHashKey(street2)
	ESX.TriggerServerCallback('GetPoliceOnline', function(CopsConnected)
		if CopsConnected >= CopsNeeded then
			if storeid ~= 0 then
				local safeCoords = safeLocations[storeid]
				if #(vector3(safeCoords["x"],safeCoords["y"],safeCoords["z"]) - GetEntityCoords(PlayerPedId())) < 3.0 then
					TriggerServerEvent("store:robbery:safe",storeid)
					TriggerEvent('civilian:alertPolice', 100.0, 'storerobbed', 0,0,0)
					return
				end

				if #(GoodSpot - curCoords) > 1.0 then
					exports['mythic_notify']:DoLongHudText('inform', 'You must be at the front of the register')
					isLockpicking = false
					return
				end

				if RegisterObject then
					local objHead = GetEntityHeading(RegisterObject)
					local plyHead = GetEntityHeading(PlayerPedId())
					if objHead - plyHead > 20.0 and objHead - plyHead < 340.0 then
						exports['mythic_notify']:DoLongHudText('inform', 'You must face the register')
						isLockpicking = false
						return
					end
					TriggerEvent("register:id",storeid)
					TriggerEvent('civilian:alertPolice', 100.0, 'storerobbed', 0,0,0)
					return
				end
				print(storeid)
			end
		else
			exports["mythic_notify"]:DoLongHudText('error', 'There is not enough police for this')
			return
		end
	end)
end)

RegisterNetEvent('register:id')
AddEventHandler('register:id', function(storeid)
    for i=1, #registers do
        if #(vector3(GetEntityCoords(PlayerPedId())) - vector3(registers[i]["x"], registers[i]["y"], registers[i]["z"])) < 1.0 then
			TriggerServerEvent('store:robbery:register', storeid,  i)
			TriggerEvent('start:check')
        end
    end
end)

RegisterNetEvent('start:check')
AddEventHandler('start:check', function()
	local storeid = isStoreRobbery()
	started = true
	while started do
		Citizen.Wait(1000)
		if #(vector3(GetEntityCoords(PlayerPedId())) - vector3(storePedLocations[storeid]["x"], storePedLocations[storeid]["y"], storePedLocations[storeid]["z"])) > 100.0 then
			TriggerServerEvent('reset:started', storeid)
			print('Moved Too Far')
			started = false
		end
	end
end)

RegisterNetEvent("robbery:register:finishedLockpick")
AddEventHandler("robbery:register:finishedLockpick", function()
	isLockpicking = false
end)

RegisterNetEvent("robbery:register")
AddEventHandler("robbery:register", function()
	local storeid = isStoreRobbery()
	print(CorrectStore,storeid)
	isLockpicking = false
	TriggerServerEvent("register:complete",fuck,you)
	--TriggerServerEvent('store:pay', math.random(240,1250))
	TriggerEvent("player:receiveItem","cashroll", math.random(3,15))
	TriggerEvent('client:newStress', true,math.random(7,10))
end)

local cards = {
	'securityred',
	'securityblue',
	'securityblack',
	'securitygreen',
	'securitygold',
}

RegisterNetEvent("robbery:safe")
AddEventHandler("robbery:safe", function()
	local storeid = isStoreRobbery()
	if tonumber(storeid) == tonumber(CorrectStore) then
		CorrectStore = 0
		if math.random(20) > 10 then
			'Gruppe6Card',
		    TriggerServerEvent("stores:giveItem",math.random(#cards), 1)
		end
		if math.random(10) > 7 then 
			TriggerEvent("player:receiveItem","Gruppe6Card", 1)
		end
		--TriggerServerEvent('store:pay', math.random(1500,4050))
		TriggerEvent("player:receiveItem","cashroll", math.random(20,50))
	end
	--TriggerServerEvent('store:pay', math.random(200,1050))
	TriggerEvent("player:receiveItem","cashroll", math.random(3,15))
	TriggerEvent('client:newStress', true,math.random(7,10))
	TriggerServerEvent('safe:complete', storeid)
end)

function isStoreRobbery()
	local dstMin = 999.0
	for i = 1, #storePedLocations do
		local dstScanned = #(GetEntityCoords(PlayerPedId()) - vector3(storePedLocations[i]["x"],storePedLocations[i]["y"],storePedLocations[i]["z"]))
		if dstScanned < dstMin then
			dstMin = dstScanned
			scanId = i
		end
	end
	if dstMin < 20.0 then
		return scanId
	else
		return 0
	end
end

local recentSpawn = false
Citizen.CreateThread(function()
	--SafeCheck()
    while true do

    	local dstMin = 999.0
    	for i = 1, #storePedLocations do
    		local dstScanned = #(GetEntityCoords(PlayerPedId()) - vector3(storePedLocations[i]["x"],storePedLocations[i]["y"],storePedLocations[i]["z"]))
    		if dstScanned < dstMin then
    			dstMin = dstScanned
    			scanId = i
    		end
    	end
    	if dstMin > 30.0 then
    		scanId = 0
    		Wait(math.ceil(dstMin*5))
    		if #myspawns > 0 then
    			for i = 1, #myspawns do
    				SetEntityAsNoLongerNeeded(myspawns[i],true)
    			end
    		end
    		myspawns = {}
    	else
    		local playerPed = PlayerPedId()
    		local inveh = IsPedInAnyVehicle(playerPed, true)
    		if not recentSpawn and not inveh then
	    		SpawnPed(scanId)
	    	end
	        Wait(1)
	    end
    end
end)



function SpawnPed(i)
	recentSpawn = true
	pedType = `mp_m_shopkeep_01`
	local x = storePedLocations[i]["x"]
	local y = storePedLocations[i]["y"]
	local z = storePedLocations[i]["z"]
	local h = storePedLocations[i]["h"]

    RequestModel(pedType)

    while not HasModelLoaded(pedType) do
        Citizen.Wait(0)
    end

    local IsPedNearCoords = IsPedNearCoords(x,y,z)
    if not IsPedNearCoords  then
    	if GetPedType(pedType) ~= nil then
			local shopPed = CreatePed(GetPedType(pedType), pedType, x,y,z, h, 1, 1)
			myspawns[#myspawns+1] = shopPed
			SetPedKeepTask(shopPed, true)
			SetPedDropsWeaponsWhenDead(shopPed,false)
	        SetPedFleeAttributes(shopPed, 0, 0)
	        SetPedCombatAttributes(shopPed, 17, 1)
	        SetPedSeeingRange(shopPed, 0.0)
	        SetPedHearingRange(shopPed, 0.0)
	        SetPedAlertness(shopPed, 0.0)
		end
    end
	Citizen.Wait(10000)
	recentSpawn = false
end

function IsPedNearCoords(x,y,z)
    local handle, ped = FindFirstPed()
    local pedfound = false
    local success
    repeat
        local pos = GetEntityCoords(ped)
        local distance = #(vector3(x,y,z) - pos)

        if distance < 5.0 then
          pedfound = true
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return pedfound
end