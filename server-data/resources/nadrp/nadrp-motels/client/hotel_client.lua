ESX = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

local buildingSpawn = { x = 175.09986877441 , y = -904.7946166992, z = -98.999984741211}
--Max X = 190 Min X = ?
-- Max Z = 30 Min Z = -98
local curRoom = { x = 1420.0, y = 1420.0, z = -900.0 }
local centerPos = { x = 343.01187133789, y = -950.25201416016, z = -99.0 }
local myroomcoords = { x = 175.09986877441 , y = -904.7946166992, z = -98.999984741211 }
local currentRoom = {}
local CurrentForced = {x = 0.0,y = 0.0,z=0.0}
local selectedspawnposition = nil
local insideApartment = false
local showhelp = false
local camactive = false
local killcam = true
local myspawnpoints = {}
local spawning = false
cam = 0
currentselection = 1
curappartmentnumber = 0
forcedID = 0

apartments1 = {
	[1] = { ["x"] = 312.96966552734,["y"] = -218.2705078125, ["z"] = 54.221797943115},
	[2] = { ["x"] = 311.27377319336,["y"] = -217.74626159668, ["z"] = 54.221797943115},
	[3] = { ["x"] = 307.63830566406,["y"] = -216.43359375, ["z"] = 54.221797943115}, 
	[4] = { ["x"] = 307.71112060547,["y"] = -213.40884399414, ["z"] = 54.221797943115}, 
	[5] = { ["x"] = 309.95989990234,["y"] = -208.48258972168, ["z"] = 54.221797943115},
	[6] = { ["x"] = 311.78106689453,["y"] = -203.50025939941, ["z"] = 54.221797943115}, 
	[7] = { ["x"] = 313.72155761719,["y"] = -198.6107635498, ["z"] = 54.221797943115},
	[8] = { ["x"] = 315.5329284668,["y"] = -195.24925231934, ["z"] = 54.226440429688},
	[9] = { ["x"] = 319.23147583008,["y"] = -196.4300994873, ["z"] = 54.226451873779},
	[10] = { ["x"] = 321.08117675781,["y"] = -197.23593139648, ["z"] = 54.226451873779},
	[11] = { ["x"] = 312.98037719727,["y"] = -218.36080932617, ["z"] = 58.019248962402},
	[12] = { ["x"] = 311.10736083984,["y"] = -217.64399719238, ["z"] = 58.019248962402},
	[13] = { ["x"] = 307.37707519531,["y"] = -216.34501647949, ["z"] = 58.019248962402},
	[14] = { ["x"] = 307.76007080078,["y"] = -213.59916687012, ["z"] = 58.019248962402},
	[15] = { ["x"] = 309.76248168945,["y"] = -208.25439453125, ["z"] = 58.019248962402},
	[16] = { ["x"] = 311.48220825195,["y"] = -203.75033569336, ["z"] = 58.019248962402},
	[17] = { ["x"] = 313.65570068359,["y"] = -198.22790527344, ["z"] = 58.019248962402},
	[18] = { ["x"] = 315.47378540039,["y"] = -195.19331359863, ["z"] = 58.019248962402},
	[19] = { ["x"] = 319.39694213867,["y"] = -196.58866882324, ["z"] = 58.019248962402},
	[20] = { ["x"] = 321.19458007813,["y"] = -197.31185913086, ["z"] = 58.019248962402},
	[21] = { ["x"] = 329.49240112305,["y"] = -224.92803955078, ["z"] = 54.221771240234},
	[22] = { ["x"] = 331.33309936523,["y"] = -225.56880187988, ["z"] = 54.221771240234},
	[23] = { ["x"] = 335.18447875977,["y"] = -227.14477539063, ["z"] = 54.221771240234},
	[24] = { ["x"] = 336.71957397461,["y"] = -224.66767883301, ["z"] = 54.221771240234},
	[25] = { ["x"] = 338.79501342773,["y"] = -219.11264038086, ["z"] = 54.221771240234},
	[26] = { ["x"] = 340.43829345703,["y"] = -214.78857421875, ["z"] = 54.221771240234},
	[27] = { ["x"] = 342.28509521484,["y"] = -209.32579040527, ["z"] = 54.221771240234},
	[28] = { ["x"] = 344.39224243164,["y"] = -204.4561920166, ["z"] = 54.221881866455},
	[29] =  { ['x'] = 346.5351,['y'] = -199.4512, ['z'] = 54.222182 },
	[30] = { ["x"] = 329.7096862793,["y"] = -224.65902709961, ["z"] = 58.019248962402}, 
	[31] = { ["x"] = 331.52966308594,["y"] = -225.52110290527, ["z"] = 58.019248962402}, 
	[32] = { ["x"] = 335.16506958008,["y"] = -227.07464599609, ["z"] = 58.019248962402},
	[33] = { ["x"] = 336.35406494141,["y"] = -224.58212280273, ["z"] = 58.019245147705}, 
	[34] = { ["x"] = 338.56127929688,["y"] = -219.3408203125, ["z"] = 58.019245147705},

	[35] = { ["x"] = 342.41970825195,["y"] = -209.25254821777, ["z"] = 58.019245147705},
	[36] = { ["x"] = 344.03280639648,["y"] = -204.98118591309, ["z"] = 58.019245147705},
	[37] = { ["x"] = 346.08560180664,["y"] = -199.59660339355, ["z"] = 58.019245147705}, 

	[38] =  { ['x'] = -1498.02,['y'] = -664.59,['z'] = 33.39,['h'] = 128.87, ['info'] = ' Bay City Ave / App 36' , ['apt'] = 1 },
	[39] =  { ['x'] = -1489.69,['y'] = -671.15,['z'] = 33.39,['h'] = 134.21, ['info'] = ' Bay City Ave / App 69' , ['apt'] = 1 },
	[40] =  { ['x'] = -1493.46,['y'] = -668.06,['z'] = 33.39,['h'] = 141.4, ['info'] = ' Bay City Ave / App 37' , ['apt'] = 1 },
	[41] =  { ['x'] = -1461.53,['y'] = -641.04,['z'] = 33.39,['h'] = 304.53, ['info'] = ' Bay City Ave / App 18' , ['apt'] = 1 },
	[42] =  { ['x'] = -1458.35,['y'] = -645.91,['z'] = 33.39,['h'] = 308.11, ['info'] = ' Bay City Ave / App 19' , ['apt'] = 1 },
	[43] =  { ['x'] = -1456.04,['y'] = -648.95,['z'] = 33.39,['h'] = 306.76, ['info'] = ' Bay City Ave / App 20' , ['apt'] = 1 },
	[44] =  { ['x'] = -1452.73,['y'] = -653.47,['z'] = 33.39,['h'] = 301.36, ['info'] = ' Bay City Ave / App 21' , ['apt'] = 1 },
	[45] =  { ['x'] = -1454.63,['y'] = -655.6,['z'] = 33.39,['h'] = 215.46, ['info'] = ' Bay City Ave / App 22' , ['apt'] = 1 },
	[46] =  { ['x'] = -1459.41,['y'] = -658.81,['z'] = 33.39,['h'] = 213.78, ['info'] = ' Bay City Ave / App 23' , ['apt'] = 1 },
	[47] =  { ['x'] = -1463.32,['y'] = -661.53,['z'] = 33.39,['h'] = 210.0, ['info'] = ' Bay City Ave / App 24' , ['apt'] = 1 },
	[48] =  { ['x'] = -1467.84,['y'] = -665.24,['z'] = 33.39,['h'] = 189.07, ['info'] = ' Bay City Ave / App 25' , ['apt'] = 1 },
	[49] =  { ['x'] = -1471.78,['y'] = -668.02,['z'] = 33.39,['h'] = 214.32, ['info'] = ' Bay City Ave / App 26' , ['apt'] = 1 },
	[40] =  { ['x'] = -1476.37,['y'] = -671.31,['z'] = 33.39,['h'] = 216.08, ['info'] = ' Bay City Ave / App 27' , ['apt'] = 1 },
	[41] =  { ['x'] = -1464.99,['y'] = -639.7,['z'] = 33.39,['h'] = 35.06, ['info'] = ' Bay City Ave / App 28' , ['apt'] = 1 },
	[42] =  { ['x'] = -1469.15,['y'] = -643.43,['z'] = 33.39,['h'] = 35.14, ['info'] = ' Bay City Ave / App 29' , ['apt'] = 1 },
	[43] =  { ['x'] = -1473.23,['y'] = -646.27,['z'] = 33.39,['h'] = 32.85, ['info'] = ' Bay City Ave / App 30' , ['apt'] = 1 },
	[44] =  { ['x'] = -1477.85,['y'] = -649.78,['z'] = 33.39,['h'] = 32.61, ['info'] = ' Bay City Ave / App 31' , ['apt'] = 1 },
	[45] =  { ['x'] = -1481.81,['y'] = -652.67,['z'] = 33.39,['h'] = 33.91, ['info'] = ' Bay City Ave / App 32' , ['apt'] = 1 },
	[46] =  { ['x'] = -1486.47,['y'] = -655.77,['z'] = 33.39,['h'] = 36.38, ['info'] = ' Bay City Ave / App 33' , ['apt'] = 1 },
	[47] =  { ['x'] = -1490.7,['y'] = -658.4,['z'] = 33.39,['h'] = 33.02, ['info'] = ' Bay City Ave / App 34' , ['apt'] = 1 },
	[48] =  { ['x'] = -1495.22,['y'] = -661.82,['z'] = 33.39,['h'] = 38.31, ['info'] = ' Bay City Ave / App 35' , ['apt'] = 1 },

	[49] =  { ['x'] = -1481.97,['y'] = -652.46,['z'] = 29.59,['h'] = 31.19, ['info'] = ' Bay City Ave / App 6' , ['apt'] = 1 },
	[50] =  { ['x'] = -1477.95,['y'] = -649.54,['z'] = 29.59,['h'] = 32.3, ['info'] = ' Bay City Ave / App 7' , ['apt'] = 1 },
	[51] =  { ['x'] = -1473.36,['y'] = -646.2,['z'] = 29.59,['h'] = 26.38, ['info'] = ' Bay City Ave / App 8' , ['apt'] = 1 },
	[52] =  { ['x'] = -1469.31,['y'] = -643.41,['z'] = 29.59,['h'] = 29.38, ['info'] = ' Bay City Ave / App 8' , ['apt'] = 1 },
	[53] =  { ['x'] = -1464.75,['y'] = -640.1,['z'] = 29.59,['h'] = 33.84, ['info'] = ' Bay City Ave / App 10' , ['apt'] = 1 },
	[54] =  { ['x'] = -1461.78,['y'] = -641.4,['z'] = 29.59,['h'] = 303.51, ['info'] = ' Bay City Ave / App 11' , ['apt'] = 1 },
	[55] =  { ['x'] = -1452.58,['y'] = -653.29,['z'] = 29.59,['h'] = 300.87, ['info'] = ' Bay City Ave / App 12' , ['apt'] = 1 },
	[56] =  { ['x'] = -1454.68,['y'] = -655.64,['z'] = 29.59,['h'] = 213.03, ['info'] = ' Bay City Ave / App 13' , ['apt'] = 1 },
	[57] =  { ['x'] = -1459.3,['y'] = -658.86,['z'] = 29.59,['h'] = 228.02, ['info'] = ' Bay City Ave / App 14' , ['apt'] = 1 },
	[58] =  { ['x'] = -1463.37,['y'] = -661.72,['z'] = 29.59,['h'] = 214.95, ['info'] = ' Bay City Ave / App 15' , ['apt'] = 1 },
	[59] =  { ['x'] = -1468.05,['y'] = -664.9,['z'] = 29.59,['h'] = 214.39, ['info'] = ' Bay City Ave / App 16' , ['apt'] = 1 },
	[60] =  { ['x'] = -1471.96,['y'] = -667.82,['z'] = 29.59,['h'] = 213.94, ['info'] = ' Bay City Ave / App 17' , ['apt'] = 1 },
	[61] =  { ['x'] = -1497.83,['y'] = -664.47,['z'] = 29.03,['h'] = 137.35, ['info'] = ' Bay City Ave / App 2' , ['apt'] = 1 },
	[62] =  { ['x'] = -1495.04,['y'] = -661.92,['z'] = 29.03,['h'] = 30.17, ['info'] = ' Bay City Ave / App 3' , ['apt'] = 1 },
	[63] =  { ['x'] = -1490.48,['y'] = -658.73,['z'] = 29.03,['h'] = 29.52, ['info'] = ' Bay City Ave / App 4' , ['apt'] = 1 },
	[64] =  { ['x'] = -1486.45,['y'] = -655.88,['z'] = 29.59,['h'] = 37.15, ['info'] = ' Bay City Ave / App 5' , ['apt'] = 1 },

	[65] =  { ['x'] = 485.3,['y'] = 213.35,['z'] = 108.31},
	[66] =  { ['x'] = 525.38,['y'] = 207.42,['z'] = 104.75},
	[67] =  { ['x'] = 527.99,['y'] = 213.69,['z'] = 104.75},
	[68] =  { ['x'] = 531.07,['y'] = 222.29,['z'] = 104.75},
	[69] =  { ['x'] = 526.89,['y'] = 225.87,['z'] = 104.75},
	[70] =  { ['x'] = 519.51,['y'] = 228.31,['z'] = 104.75},
	[71] =  { ['x'] = 510.99,['y'] = 231.24,['z'] = 104.75},
	[72] =  { ['x'] = 504.31,['y'] = 233.97,['z'] = 104.75},
	[73] =  { ['x'] = 497.27,['y'] = 237.05,['z'] = 104.75},
	[74] =  { ['x'] = 490.52,['y'] = 227.01,['z'] = 104.75},
	[75] =  { ['x'] = 487.98,['y'] = 221.05,['z'] = 104.75},
	[76] =  { ['x'] = 485.06,['y'] = 212.41,['z'] = 104.75},
	[77] =  { ['x'] = 482.71,['y'] = 206.25,['z'] = 104.75},
	[78] =  { ['x'] = 486.53,['y'] = 201.95,['z'] = 104.75},
	[79] =  { ['x'] = 508.32,['y'] = 194.19,['z'] = 104.75},
	[80] =  { ['x'] = 515.06,['y'] = 191.39,['z'] = 104.75},
	[81] =  { ['x'] = 520.08,['y'] = 192.44,['z'] = 104.75},
	[82] =  { ['x'] = 522.32,['y'] = 198.72,['z'] = 104.75},
	[83] =  { ['x'] = 508.17,['y'] = 193.98,['z'] = 108.31},
	[84] =  { ['x'] = 515.18,['y'] = 191.49,['z'] = 108.31},
	[85] =  { ['x'] = 520.42,['y'] = 193.04,['z'] = 108.31},
	[86] =  { ['x'] = 522.46,['y'] = 199.33,['z'] = 108.31},
	[87] =  { ['x'] = 486.13,['y'] = 201.89,['z'] = 108.31},
	[88] =  { ['x'] = 482.3,['y'] = 205.83,['z'] = 108.31},
}

myRoomNumber = 1
myRoomLock = true
curRoomType = 1
myRoomType = 1
hid = 0 
isForced = false


RegisterNetEvent('nadrp-motels:forceOut')
AddEventHandler('nadrp-motels:forceOut', function(roomNumber,roomtype)
	isForced = false
	returnCurrentRoom(roomtype,roomNumber)
	if #(vector3(CurrentForced.x, CurrentForced.y, CurrentForced.z) - GetEntityCoords(PlayerPedId())) < 90.0 then
		CleanUpArea()
		if roomNumber == 2 then
			SetEntityCoords(PlayerPedId(),267.48132324219,-638.818359375,42.020294189453)
		elseif roomNumber == 3 then
			SetEntityCoords(PlayerPedId(),160.26762390137,-641.96905517578,47.073524475098)
		end
	end
	if myRoomNumber == roomNumber then
		CleanUpArea()
		if #(vector3(CurrentForced.x, CurrentForced.y, CurrentForced.z) - GetEntityCoords(PlayerPedId())) < 90.0 then
			if roomNumber == 2 then
				SetEntityCoords(PlayerPedId(),267.48132324219,-638.818359375,42.020294189453)
			elseif roomNumber == 3 then
				SetEntityCoords(PlayerPedId(),160.26762390137,-641.96905517578,47.073524475098)
			end
		end
	end
end)

RegisterNetEvent('nadrp-motels:AttemptUpgrade')
AddEventHandler('nadrp-motels:AttemptUpgrade', function()
	--if #(vector3(260.72366333008,-375.27133178711,-44.137680053711) - GetEntityCoords(PlayerPedId())) < 3.0 then
		TriggerServerEvent('nadrp-motels:upgradeApartment', myRoomType)
		TriggerEvent("nadrp-motels:myroomtype",myRoomType)
	--end
end)

RegisterNetEvent('nadrp-motels:SetID')
AddEventHandler('nadrp-motels:SetID', function(hidX)
	hid = hidX
end)

RegisterNetEvent('nadrp-motels:SetID2')
AddEventHandler('nadrp-motels:SetID2', function(hidX)
	hid = hidX
	forcedID = hidX
end)

RegisterNetEvent("nadrp-motels:forceEnter")
AddEventHandler("nadrp-motels:forceEnter", function(roomNumber,roomtype)
	roomNumber = tonumber(roomNumber)
	roomtype = tonumber(roomtype)
	isForced = true
	returnCurrentRoom(roomtype,roomNumber)
end)

RegisterNetEvent('nadrp-motels:CommandEnter')
AddEventHandler('nadrp-motels:CommandEnter', function(roomNumber,roomtype)
	if roomNumber ~= nil and roomtype ~= nil then 
		processBuildType(tonumber(roomNumber), tonumber(roomtype))
	end
end)

function returnCurrentRoom(roomtype,roomNumber)
	if roomtype == 3 then
		local generator = { x = -265.68209838867 , y = -957.06573486328, z = 145.824577331543}
		if roomNumber > 0 and roomNumber < 7 then
			--generator = { x = -143.16976928711 , y = -596.31140136719, z = 61.95349121093}
			--generator.z = (61.9534912) + ((roomNumber * 11.0) * roomType)
			generator = { x = 131.0290527343, y = -644.0509033203, z = 68.025619506836}
			generator.z = (68.0534912) + ((roomNumber * 11.0))
		end

		if roomNumber > 6 and roomNumber < 14 then
			generator = { x = -134.43560791016 , y = -638.13916015625, z = 68.953491210938}
			roomNumber = roomNumber - 6
			generator.z = (61.9534912) + ((roomNumber * 11.0))
		end

		if roomNumber > 13 and roomNumber < 20 then
			generator = { x = -181.440234375 , y = -584.04815673828, z = 68.95349121093}
			roomNumber = roomNumber - 13
			generator.z = (61.9534912) + ((roomNumber * 11.0))
		end

		if roomNumber > 19 and roomNumber < 26 then
			generator = { x = -109.9752227783, y = -570.272351074, z = 61.9534912}
			roomNumber = roomNumber - 19
			generator.z = (61.9534912) + ((roomNumber * 11.0))
		end

		if roomNumber > 25 and roomNumber < 38 then
			generator = { x = -3.9463002681732, y = -693.2456665039, z = 103.0334701538}
			roomNumber = roomNumber - 25
			generator.z = (103.0534912) + ((roomNumber * 11.0))
		end

		if roomNumber > 37 and roomNumber < 49 then
			generator = { x = 140.0758819580, y = -748.12322998, z = 87.0334701538}
			roomNumber = roomNumber - 37
			generator.z = (87.0534912) + ((roomNumber * 11.0))
		end

		if roomNumber > 48 and roomNumber < 60 then
			generator = { x = 131.0290527343, y = -644.0509033203, z = 68.025619506836}
			roomNumber = roomNumber - 48
			generator.z = (68.0534912) + ((roomNumber * 11.0))
		end

		CurrentForced = generator

	elseif roomtype == 2 then 
		local generator = { x = 175.09986877441 , y = -904.7946166992, z = -98.999984741211}
		generator.x = (175.09986877441) + ((roomNumber * 25.0))
		generator.y = (-904.7946166992) - ((roomNumber * 25.0))
		CurrentForced = generator
	end
end

RegisterNetEvent('doApartHelp')
AddEventHandler('doApartHelp', function()
	showhelp = true
end)

RegisterNetEvent('nadrp-motels:updateLockStatus')
AddEventHandler('nadrp-motels:updateLockStatus', function(newStatus)
	myRoomLock = newStatus
end)

RegisterNetEvent('nadrp-motels:createRoomFirst')
AddEventHandler('nadrp-motels:createRoomFirst', function(numMultiplier,roomType)
	myRoomNumber = numMultiplier
	myRoomType = roomType
	TriggerEvent("nadrp-motels:myroomtype",myRoomType)
end)

RegisterNetEvent('nadrp-motels:teleportRoom')
AddEventHandler('nadrp-motels:teleportRoom', function(numMultiplier,roomType)
	local numMultiplier = tonumber(numMultiplier)
	local roomType = tonumber(roomType)
	if (#(vector3(106.11, -647.76, 45.1) - GetEntityCoords(PlayerPedId())) < 5 and roomType == 3) or (#(vector3(160.26762390137,-641.96905517578,47.073524475098) - GetEntityCoords(PlayerPedId())) < 5 and roomType == 3) or (#(vector3(267.48132324219,-638.818359375,42.020294189453) - GetEntityCoords(PlayerPedId())) < 5 and roomType == 2) then
		moveToMultiplierHotel(numMultiplier,roomType)
	elseif (#(vector3(apartments1[numMultiplier]["x"],apartments1[numMultiplier]["y"],apartments1[numMultiplier]["z"]) - GetEntityCoords(PlayerPedId())) < 5 and roomType == 1) then
		moveToMultiplierHotel(numMultiplier,roomType)
	else
		exports['mythic_notify']:SendAlert('error', 'No Entry Point.')
	end
end)

RegisterNetEvent('nadrp-motels:attemptringbell')
AddEventHandler("nadrp-motels:attemptringbell",function(apnm)
	if (#(vector3(160.29, -642.06, 47.08) - GetEntityCoords(PlayerPedId()) < 5)) or
		(#(vector3(267.52, -638.79, 42.02) - GetEntityCoords(PlayerPedId()) < 5)) or
		(#(vector3(313.09, -225.83, 54.23) - GetEntityCoords(PlayerPedId()) < 5)) then
		TriggerServerEvent("confirmbellring",apnm)
		TriggerEvent("buzzer")
	else
		exports['mythic_notify']:SendAlert('error', 'You are not near a buzzer point.')
	end
end)

RegisterNetEvent('nadrp-motels:buzzbuzz')
AddEventHandler("nadrp-motels:buzzbuzz",function(apartmentnumber)
	if tonumber(apartmentnumber) == 0 then
		return
	end
	if tonumber(curappartmentnumber) == tonumber(apartmentnumber) then
		TriggerEvent('InteractSound_CL:PlayOnOne','doorbell', 0.5)
	end
end)

RegisterNetEvent('buzzer')
AddEventHandler("buzzer",function()
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 1.0, 'doorbell', 0.5)
end)

local canInteract = true

RegisterNetEvent('nadrp-motels:interactState')
AddEventHandler('nadrp-motels:interactState', function(state)
	canInteract = state
end)

RegisterNetEvent('nadrp-motels:newRoomType')
AddEventHandler('nadrp-motels:newRoomType', function(newRoomType)
	myRoomType = newRoomType
	TriggerEvent("nadrp-motels:myroomtype",myRoomType)
end)


--[[AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		print('RESET MOTEL')
		if roomType == 1 then
			TriggerServerEvent('nadrp-motels:resetMotel', myRoomNumber)
		end
	end
end)]]

local comparedst = 1000
function smallestDist(typeCheck)
	if typeCheck < comparedst then
		comparedst = typeCheck
	end
end

Controlkey = {
	["generalUse"] = {38,"E"},
	["housingMain"] = {74,"H"},
	["housingSecondary"] = {47,"G"}
}

RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
	Controlkey["generalUse"] = table["generalUse"]
	Controlkey["housingMain"] = table["housingMain"]
	Controlkey["housingSecondary"] = table["housingSecondary"]

	if Controlkey["housingSecondary"] == nil or Controlkey["housingMain"] == nil or Controlkey["generalUse"] == nil then
		Controlkey = {["generalUse"] = {38,"E"},["housingMain"] = {74,"H"},["housingSecondary"] = {47,"G"}} 
	end
end)

Citizen.CreateThread(function()

 	while true do
		Citizen.Wait(0)

		comparedst = 1000

		local plyId = PlayerPedId()
		local plyCoords = GetEntityCoords(plyId)
		local entryUpgradesDst = #(vector3(-221.544921875, -1012.197265625, 29.298439025879) - plyCoords)
		local entry7th = #(vector3(apartments1[29]["x"],apartments1[29]["y"],apartments1[29]["z"]) - plyCoords)
		local entry6th = #(vector3(apartments1[65]["x"],apartments1[65]["y"],apartments1[65]["z"]) - plyCoords)
		local entry5rd = #(vector3(apartments1[50]["x"],apartments1[50]["y"],apartments1[50]["z"]) - plyCoords)
		local entry4rd = #(vector3(4.67, -724.85, 32.18) -  plyCoords)
		local entry3rd = #(vector3(160.26762390137,-641.96905517578,47.073524475098) - plyCoords)
		local entry2nd = #(vector3(267.48132324219,-638.818359375,42.020294189453) - plyCoords)
		local entry1st = #(vector3(apartments1[1]["x"],apartments1[1]["y"],apartments1[1]["z"]) - plyCoords)
		local payTicketsDst = #(vector3(235.91, -416.43, -118.16) - plyCoords)
		
		smallestDist(payTicketsDst)
		smallestDist(entryUpgradesDst)
		smallestDist(entry6th)
		smallestDist(entry5rd)
		smallestDist(entry4rd)
		smallestDist(entry3rd)
		smallestDist(entry2nd)
		smallestDist(entry1st)

		if insideApartment or comparedst < 100 then

			if entryUpgradesDst < 1.0 then
				--DrawText3Ds(-221.544921875, -1012.197265625, 29.298439025879, "~b~"..Controlkey["generalUse"][2].."~s~ Upgrade Housing (25k for tier 2.)")
				--if IsControlJustReleased(1,Controlkey["generalUse"][1]) then
				--	TriggerEvent("nadrp-motels:AttemptUpgrade")
				--	Citizen.Wait(2500)
				--end
			end

			if (entry4rd < 5 and myRoomType == 3) or (entry3rd < 5 and myRoomType == 3) or (entry1st < 35.0 and myRoomType == 1) or (entry5rd < 65.0 and myRoomType == 1) or (entry2nd < 5 and myRoomType == 2) or (entry6th < 81.0 and myRoomType == 1) or (entry7th < 15.0 and myRoomType == 1) then
				if myRoomType == 1 then
					local myappdist = #(vector3(apartments1[myRoomNumber]["x"],apartments1[myRoomNumber]["y"],apartments1[myRoomNumber]["z"]) - plyCoords)
					if myappdist < 15.0 then
						DrawMarker(20,apartments1[myRoomNumber]["x"],apartments1[myRoomNumber]["y"],apartments1[myRoomNumber]["z"], 0, 0, 0, 0, 0, 0, 0.701,1.0001,0.3001, 0, 155, 255, 200, 0, 0, 0, 0)
						if myappdist < 3.0 then
							if myRoomLock then
								DrawText3Ds(apartments1[myRoomNumber]["x"],apartments1[myRoomNumber]["y"],apartments1[myRoomNumber]["z"], "~b~"..Controlkey["housingMain"][2].."~s~ to enter ~b~"..Controlkey["housingSecondary"][2].."~s~ to unlock (" .. myRoomNumber .. ")")
							else
								DrawText3Ds(apartments1[myRoomNumber]["x"],apartments1[myRoomNumber]["y"],apartments1[myRoomNumber]["z"], "~b~H~s~ to enter ~b~G~s~ to lock (" .. myRoomNumber .. ")")
							end
						end
					end
				end

				if myRoomType == 2 then
					DrawMarker(27,267.48132324219,-638.818359375,41.020294189453, 0, 0, 0, 0, 0, 0, 7.001, 7.0001, 0.3001, 0, 155, 255, 200, 0, 0, 0, 0)
					if myRoomLock then
						DrawText3Ds(267.48132324219,-638.818359375,42.020294189453, "~b~"..Controlkey["housingMain"][2].."~s~ to enter ~b~"..Controlkey["housingSecondary"][2].."~s~ to unlock (" .. myRoomNumber .. ")")
					else
						DrawText3Ds(267.48132324219,-638.818359375,42.020294189453, "~b~"..Controlkey["housingMain"][2].."~s~ to enter ~b~"..Controlkey["housingSecondary"][2].."~s~ to lock (" .. myRoomNumber .. ")")
					end
				end

				if myRoomType == 3 then
					if entry4rd < 5 then
						DrawMarker(27,4.67, -724.85, 32.18, 0, 0, 0, 0, 0, 0, 7.001, 7.0001, 0.3001, 0, 155, 255, 200, 0, 0, 0, 0)
						if myRoomLock then
							DrawText3Ds(4.67, -724.85, 32.18, "~b~"..Controlkey["housingMain"][2].."~s~ to enter ~b~"..Controlkey["housingSecondary"][2].."~s~ to unlock (" .. myRoomNumber .. ")")
						else
							DrawText3Ds(4.67, -724.85, 32.18, "~b~"..Controlkey["housingMain"][2].."~s~ to enter ~b~"..Controlkey["housingSecondary"][2].."~s~ to lock (" .. myRoomNumber .. ")")
						end
					else
						DrawMarker(27,160.26762390137,-641.96905517578,47.073524475098, 0, 0, 0, 0, 0, 0, 7.001, 7.0001, 0.3001, 0, 155, 255, 200, 0, 0, 0, 0)
						if myRoomLock then
							DrawText3Ds(160.26762390137,-641.96905517578,47.073524475098, "~b~"..Controlkey["housingMain"][2].."~s~ to enter ~b~"..Controlkey["housingSecondary"][2].."~s~ to unlock (" .. myRoomNumber .. ")")
						else
							DrawText3Ds(160.26762390137,-641.96905517578,47.073524475098, "~b~"..Controlkey["housingMain"][2].."~s~ to enter ~b~"..Controlkey["housingSecondary"][2].."~s~ to lock (" .. myRoomNumber .. ")")
						end
					end
				end

				if IsControlJustReleased(1,Controlkey["housingSecondary"][1]) then
					if #(vector3(apartments1[myRoomNumber]["x"],apartments1[myRoomNumber]["y"],apartments1[myRoomNumber]["z"]) - plyCoords) < 5 and myRoomType == 1 then	
						TriggerEvent("dooranim")
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'keydoors', 0.4)
						TriggerServerEvent("nadrp-motels:updatelocks", myRoomLock, myRoomNumber)
						Citizen.Wait(500)
					elseif myRoomType ~= 1 then
						TriggerEvent("dooranim")
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'keydoors', 0.4)
						TriggerServerEvent("nadrp-motels:updatelocks", myRoomLock, myRoomNumber)
						Citizen.Wait(500)
					end
				end

				if IsControlJustReleased(1,Controlkey["housingMain"][1]) then
					exports['mythic_notify']:SendAlert('inform', 'Please wait!')

					Citizen.Wait(300)
					TriggerEvent("dooranim")
					TriggerEvent('InteractSound_CL:PlayOnOne','DoorOpen', 0.7)

					if #(vector3(apartments1[myRoomNumber]["x"],apartments1[myRoomNumber]["y"],apartments1[myRoomNumber]["z"]) - plyCoords) < 5 and myRoomType == 1 then	
						processBuildType(myRoomNumber,myRoomType)
						TriggerServerEvent("nadrp-motels:getInfo")
						Citizen.Wait(500)
					elseif (#(vector3(160.26762390137,-641.96905517578,47.073524475098) - plyCoords) < 5 and myRoomType == 3) or entry4rd < 5 then
						processBuildType(myRoomNumber,myRoomType)
						TriggerServerEvent("nadrp-motels:getInfo")
						Citizen.Wait(500)
					elseif #(vector3(267.48132324219,-638.818359375,42.020294189453) - plyCoords) < 5 and myRoomType == 2 then
						processBuildType(myRoomNumber,myRoomType)
						TriggerServerEvent("nadrp-motels:getInfo")
						Citizen.Wait(500)
					else
						exports['mythic_notify']:SendAlert('inform', 'Moved too far away!')
					end
				end
			end

			-- if #(vector3(myroomcoords.x-2, myroomcoords.y + 2.5, myroomcoords.z) - plyCoords) < 3.0 and curRoomType == 1 then
			-- 	DrawText3Ds(myroomcoords.x-2, myroomcoords.y + 2.5, myroomcoords.z, '~b~'..Controlkey["housingSecondary"][2]..'~s~ to swap char or /outfits.')
			-- 	if IsControlJustReleased(1,Controlkey["housingSecondary"][1]) then
			-- 		logout()
			-- 	end
			-- elseif #(vector3(myroomcoords.x+8, myroomcoords.y + 4, myroomcoords.z+0.4) - plyCoords) < 5.5 and curRoomType == 2 then
			-- 	DrawText3Ds(myroomcoords.x+8, myroomcoords.y + 4, myroomcoords.z+2.4, '~b~'..Controlkey["housingSecondary"][2]..'~s~ to swap char or /outfits.')
			-- 	if IsControlJustReleased(1, Controlkey["housingSecondary"][1]) then
			-- 		logout()
			-- 	end
			-- elseif #(vector3(myroomcoords.x + 6, myroomcoords.y + 6, myroomcoords.z) - plyCoords) < 2.5 and curRoomType == 3 then
			-- 	DrawText3Ds(myroomcoords.x + 6, myroomcoords.y + 6, myroomcoords.z+1.5, '~b~'..Controlkey["housingSecondary"][2]..'~s~ to swap char or /outfits.')
			-- 	if IsControlJustReleased(1, Controlkey["housingSecondary"][1]) then
			-- 		logout()
			-- 	end
			-- end

			if 	(#(vector3(myroomcoords.x - 14.3, myroomcoords.y - 02.00, myroomcoords.z + 7.02) - plyCoords) < 3.0 and curRoomType == 3) or 
				(#(vector3(myroomcoords.x + 4.30, myroomcoords.y - 15.95, myroomcoords.z + 0.42) - plyCoords) < 3.0 and curRoomType == 2) or 
				(#(vector3(myroomcoords.x - 2.00, myroomcoords.y - 04.00, myroomcoords.z) - plyCoords) < 3.0 and curRoomType == 1) then
				if curRoomType == 2 then
					DrawText3Ds(myroomcoords.x + 4.3,myroomcoords.y - 15.95,myroomcoords.z+2.42, '~b~'..Controlkey["housingMain"][2]..'~s~ to leave')
				elseif curRoomType == 3 then
					DrawText3Ds(myroomcoords.x - 14.45,myroomcoords.y - 2.5,myroomcoords.z+7.3, '~b~'..Controlkey["housingMain"][2]..'~s~ to leave or ~b~'..Controlkey["housingSecondary"][2]..'~s~ to enter garage.')				
				elseif curRoomType == 1 then
					DrawText3Ds(myroomcoords.x - 2.0,myroomcoords.y - 4.5,myroomcoords.z, '~b~'..Controlkey["housingMain"][2]..'~s~ to leave')
				end

				if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
					TriggerEvent("dooranim")
					TriggerEvent('InteractSound_CL:PlayOnOne','DoorOpen', 0.7)
					Wait(330)
					CleanUpArea()
					isForced = false
					if curRoomType == 2 then
						SetEntityCoords(PlayerPedId(),267.48132324219,-638.818359375,42.020294189453)
					elseif curRoomType == 3 then
						SetEntityCoords(PlayerPedId(),160.26762390137,-641.96905517578,47.073524475098)
					elseif curRoomType == 1 then
						SetEntityCoords(PlayerPedId(),apartments1[myRoomNumber]["x"],apartments1[myRoomNumber]["y"],apartments1[myRoomNumber]["z"])
					end
					insideApartment = false
					TriggerEvent('inhouse', false)
					Citizen.Wait(100)
					TriggerEvent("dooranim")
					TriggerEvent('InteractSound_CL:PlayOnOne','DoorClose', 0.7)
					curRoom = { x = 1420.0, y = 1420.0, z = -900.0 }
					TriggerEvent("attachWeapons")
				end

				if IsControlJustReleased(1, Controlkey["housingSecondary"][1]) and curRoomType == 3 then
					TriggerEvent("dooranim")
					TriggerEvent('InteractSound_CL:PlayOnOne','DoorOpen', 0.7)
					Wait(330)
					isForced = false
					insideApartment = false
					TriggerEvent('inhouse', false)
					CleanUpArea()
					DoScreenFadeOut(1)
					buildGarage()
					Citizen.Wait(4500)
					DoScreenFadeIn(1)
				end
			end

			if 	(#(vector3(myroomcoords.x - 3.6,myroomcoords.y + 0.6, myroomcoords.z - 0.2) - plyCoords) < 2.0 and curRoomType == 1) or 
				(#(vector3(myroomcoords.x + 9.8, myroomcoords.y - 1.35, myroomcoords.z + 0.15) - plyCoords) < 5.0 and curRoomType == 2) or 
				(#(vector3(myroomcoords.x + 1.5, myroomcoords.y + 8.00, myroomcoords.z + 1.00) - plyCoords) < 5.0 and curRoomType == 3) 
				and canInteract 
			then
				if curRoomType == 2 then
					DrawText3Ds(myroomcoords.x+9.8, myroomcoords.y - 1.35, myroomcoords.z+2.15, '~b~'..Controlkey["housingMain"][2]..'~s~ to interact')
				elseif curRoomType == 3 then
					DrawText3Ds(myroomcoords.x + 1.5, myroomcoords.y + 8, myroomcoords.z+1, '~b~'..Controlkey["housingMain"][2]..'~s~ to interact')
				elseif curRoomType == 1 then
					DrawText3Ds(myroomcoords.x - 3.6,myroomcoords.y + 0.6, myroomcoords.z - 0.2, '~b~'..Controlkey["housingMain"][2]..'~s~ to interact')
				end

				if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
					if inRoom() then
						canInteract = false
						TriggerEvent('InteractSound_CL:PlayOnOne','StashOpen', 0.6)
						maxRoomWeight = 100.0 * (curRoomType * 2)
						if not isForced then
							TriggerServerEvent('nadrp-motels:getID')
						end
						if hid == 0 then
							hid = exports['nadrp-ped']:isPed('cid')
						end
						TriggerEvent("server-inventory-open", "1", "motel"..curRoomType.."-"..hid)

						TriggerEvent("actionbar:setEmptyHanded")
					else
						exports['mythic_notify']:SendAlert('error', 'This is not your stash!')
					end
					Citizen.Wait(1900)
				end
			end

		if 	(#(vector3(curRoom.x - 1.6, curRoom.y + 1.20, curRoom.z + 1.00) - plyCoords) < 2.0 and curRoomType == 1) or 
			(#(vector3(curRoom.x + 9.8, curRoom.y - 1.35, curRoom.z + 0.15) - plyCoords) < 2.0 and curRoomType == 2) or 
			(#(vector3(curRoom.x + 1.5, curRoom.y + 8.00, curRoom.z + 1.00) - plyCoords) < 2.0 and curRoomType == 3) and canInteract then

			if curRoomType == 2 then
				DrawText3Ds(curRoom.x+9.8, curRoom.y - 1.35, curRoom.z+2.15, '~b~'..Controlkey["housingMain"][2]..'~s~ to interact')
			elseif curRoomType == 3 then
				DrawText3Ds(curRoom.x + 1.5, curRoom.y + 8, curRoom.z+1, '~b~'..Controlkey["housingMain"][2]..'~s~ to interact')
			elseif curRoomType == 1 then
				DrawText3Ds(curRoom.x - 1.6,curRoom.y + 0.3, curRoom.z, '~b~'..Controlkey["housingMain"][2]..'~s~ to interact')
			end
			if IsControlJustReleased(1, Controlkey["housingMain"][1]) then

				local myJob = exports["nadrp-ped"]:isPed("myJob")
				local LEO = false
				if myJob == "police" or myJob == "judge" then
					LEO = true
				end

				if LEO then
					canInteract = false
					TriggerEvent('InteractSound_CL:PlayOnOne','StashOpen', 0.6)
					maxRoomWeight = 500.0 * curRoomType
					TriggerServerEvent('nadrp-motels:getID')
					--TriggerServerEvent('nadrp-motels:GetInteract',maxRoomWeight,forcedID)
					TriggerEvent("server-inventory-open", "1", "motel"..curRoomType.."-"..forcedID)
				else
					exports['mythic_notify']:SendAlert('error', 'This is not your stash!')
				end
				Citizen.Wait(1900)
			end

		end

		if 	(#(vector3(curRoom.x - 14.3,curRoom.y - 2,curRoom.z+7.02) - plyCoords) < 3.0 and curRoomType == 3) or 
			(#(vector3(curRoom.x + 4.3,curRoom.y - 15.95,curRoom.z+0.42) - plyCoords) < 3.0 and curRoomType == 2) or 
			(#(vector3(curRoom.x - 2,curRoom.y - 4,curRoom.z) - plyCoords) < 3.0 and curRoomType == 1) 
		then
				if curRoomType == 2 then
					DrawText3Ds(curRoom.x + 4.3,curRoom.y - 15.95,curRoom.z+2.42, '~b~'..Controlkey["housingMain"][2]..'~s~ to leave')
				elseif curRoomType == 3 then
					DrawText3Ds(curRoom.x - 14.45,curRoom.y - 2.5,curRoom.z+7.3, '~b~'..Controlkey["housingMain"][2]..'~s~ to leave or ~b~'..Controlkey["housingSecondary"][2]..'~s~ to enter garage.')	
				elseif curRoomType == 1 then
					DrawText3Ds(curRoom.x - 1.15,curRoom.y - 3.8,curRoom.z, '~b~'..Controlkey["housingMain"][2]..'~s~ to leave')
				end

				if IsControlJustReleased(1, Controlkey["housingSecondary"][1]) and curRoomType == 3 then
					TriggerEvent("dooranim")
					TriggerEvent('InteractSound_CL:PlayOnOne','DoorOpen', 0.7)
					Wait(330)
					isForced = false
					insideApartment = false
					CleanUpArea()
					DoScreenFadeOut(1)
					buildGarage()
					Citizen.Wait(4500)
					DoScreenFadeIn(1)
				end

				if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
					Wait(200)
					CleanUpArea()
					if curRoomType == 2 then
						SetEntityCoords(PlayerPedId(),267.48132324219,-638.818359375,42.020294189453)
					elseif curRoomType == 3 then
						SetEntityCoords(PlayerPedId(),160.26762390137,-641.96905517578,47.073524475098)
					elseif curRoomType == 1 then
						SetEntityCoords(PlayerPedId(),313.2561340332,-227.30776977539,54.221176147461)
					end

					Citizen.Wait(2000)
					curRoom = { x = 1420.0, y = 1420.0, z = -900.0 }
					TriggerEvent("attachWeapons")
				end

			end
		else
			if ingarage then
				if #(vector3(currentGarage.x+9.5 , currentGarage.y-12.7, currentGarage.z+1.0) - plyCoords) < 3.0 then
					DrawText3Ds(currentGarage.x+9.5, currentGarage.y-12.7, currentGarage.z+1.0, '~b~'..Controlkey["housingMain"][2]..'~s~ to Room ~b~'..Controlkey["housingSecondary"][2]..'~s~ to Garage Door')
					if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
						TriggerEvent("Garages:ToggleHouse",false)
						Wait(200)
						CleanUpArea()
						processBuildType(garageNumber,3)
						ingarage = false
						TriggerEvent("attachWeapons")
					end
					if IsControlJustReleased(1, Controlkey["housingSecondary"][1]) then
						TriggerEvent("Garages:ToggleHouse",false)
						Wait(200)
						CleanUpArea()
						SetEntityCoords(PlayerPedId(),4.67, -724.85, 32.18)
						ingarage = false
						TriggerEvent("attachWeapons")
					end
				else
					DisplayHelpText('Press ~b~'..Controlkey["housingSecondary"][2]..'~s~ while in a vehicle to spawn it.')
					if IsControlJustReleased(1, Controlkey["housingSecondary"][1]) then
						if IsPedInAnyVehicle(PlayerPedId(), false) then
							local carcarbroombrooms = GetClosestVehicle(-41.43, -716.53, 32.54, 3.000, 0, 70)

							if not DoesEntityExist(carcarbroombrooms) then
								local vehmove = GetVehiclePedIsIn(PlayerPedId(), true)
								
								SetEntityCoords(vehmove,-41.43, -716.53, 32.54)
								SetEntityHeading(vehmove,170.0)
								Wait(200)
								CleanUpArea()
								SetPedIntoVehicle(PlayerPedId(), vehmove, - 1)
								ingarage = false
							else
								exports['mythic_notify']:SendAlert('inform', 'Vehicle on spawn.')
							end
							--leaveappartment
						else
							exports['mythic_notify']:SendAlert('inform', 'Enter Vehicle First.')
						end
					end
				end
				local lights = plyCoords
				DrawLightWithRange(lights["x"],lights["y"],lights["z"]+3, 255, 197, 143, 100.0, 0.45)
				DrawLightWithRange(lights["x"],lights["y"],lights["z"]-3, 255, 197, 143, 100.0, 0.45)
			else
				Citizen.Wait(math.ceil(comparedst * 10))
			end
		end
	end
end)

function nearClothingMotel()
	if #(vector3(myroomcoords.x, myroomcoords.y + 3, myroomcoords.z) - GetEntityCoords(PlayerPedId())) < 5.5 and curRoomType == 1 then
		return true
	end
	if #(vector3(myroomcoords.x + 10, myroomcoords.y + 6, myroomcoords.z) - GetEntityCoords(PlayerPedId())) < 5.5 and curRoomType == 2 then
		return true
	end
	if #(vector3(myroomcoords.x - 3, myroomcoords.y - 7, myroomcoords.z) - GetEntityCoords(PlayerPedId())) < 5.5 and curRoomType == 3 then
		return true
	end
	if #(vector3(1771.283, 2593.6, 45.72) - GetEntityCoords(PlayerPedId())) < 8.5 then
		return true
	end	
	return false
end

function moveToMyHotel(roomType)
	--TriggerEvent("resetPhone")
	processBuildType(myRoomNumber,roomType)
end

function moveToMultiplierHotel(numMultiplier,roomType)
	processBuildType(tonumber(numMultiplier),tonumber(roomType))
end

function processBuildType(numMultiplier,roomType)
	DoScreenFadeOut(1)
	insideApartment = true
	SetEntityInvincible(PlayerPedId(), true)
	TriggerEvent("dooranim")
	TriggerEvent('inhouse', true)
	if roomType == 1 then
		buildRoom(numMultiplier,roomType)
		if showhelp then
			TriggerEvent('chat:addMessage', {
				template = '<div style="padding: 0.6vw; padding-left: 0.8vw; background-color: rgba(207, 125, 25, 0.9); border-radius: 6px;"><span style="width: 100%; font-weight: bold;">[SYSTEM]: </span>Welcome to the Hotel, Here you can store items and change outfit.</div>',
				args = {}
			}) 
			showhelp = false
		end
	elseif roomType == 2 then
		buildRoom2(numMultiplier,roomType)
	elseif roomType == 3 then
		buildRoom3(numMultiplier,roomType)
	end
	curappartmentnumber = numMultiplier

	TriggerEvent('InteractSound_CL:PlayOnOne','DoorClose', 0.7)
	TriggerEvent("dooranim")
	CleanUpPeds()
	SetEntityInvincible(PlayerPedId(), false)
	FreezeEntityPosition(PlayerPedId(),false)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
end

function CleanUpPeds()
    local playerped = PlayerPedId()
    local plycoords = GetEntityCoords(playerped)
    local handle, ObjectFound = FindFirstPed()
    local success
    repeat
        local pos = GetEntityCoords(ObjectFound)
        local distance = #(plycoords - pos)
        if distance < 50.0 and ObjectFound ~= playerped then
    		if IsPedAPlayer(ObjectFound) or IsEntityAVehicle(ObjectFound) then
    		else
    			DeleteEntity(ObjectFound)
    		end
        end
        success, ObjectFound = FindNextPed(handle)
    until not success
    EndFindPed(handle)
end

function CleanUpArea()
    local playerped = PlayerPedId()
    local plycoords = GetEntityCoords(playerped)
    local handle, ObjectFound = FindFirstObject()
    local success
    repeat
        local pos = GetEntityCoords(ObjectFound)
        local distance = #(plycoords - pos)
        if distance < 50.0 and ObjectFound ~= playerped then
        	if IsEntityAPed(ObjectFound) then
        		if IsPedAPlayer(ObjectFound) then
        		else
        			DeleteObject(ObjectFound)
        		end
        	else
        		if not IsEntityAVehicle(ObjectFound) and not IsEntityAttached(ObjectFound) then
	        		DeleteObject(ObjectFound)
	        	end
        	end
        end
        success, ObjectFound = FindNextObject(handle)
    until not success
    EndFindObject(handle)
    curappartmentnumber = 0
end

function buildRoom(numMultiplier,roomType)
	-- this coord is the default object location, we use it to spawn in the interior.
	if not HasModelLoaded(`playerhouse_appartment_motel`) then
		RequestModel(`playerhouse_appartment_motel`)
		while not HasModelLoaded(`playerhouse_appartment_motel`) do
			Citizen.Wait(0)
			RequestModel(`playerhouse_appartment_motel`)
		end
		if HasModelLoaded(`playerhouse_hotlel`) then 
			print('Model loaded')
		end
	end

	SetEntityCoords(PlayerPedId(), 152.2605, -1004.471, -98.99999)

	Citizen.Wait(5000)
	local generator = { x = 175.09986877441 , y = -904.7946166992, z = -98.999984741211}
	generator.x = (175.09986877441) + ((numMultiplier * 12.0))

	if numMultiplier == myRoomNumber then
		myroomcoords = generator
	else
		curRoom = generator
	end

	SetEntityCoords(PlayerPedId(), generator.x - 2.0, generator.y - 4.5, generator.z + 1.0)
	local building = CreateObject(`playerhouse_appartment_motel`,generator.x - 0.7,generator.y-0.4,generator.z-1.42,false,false,false)
	print('[nadrp-motels]: Requested building')
	FreezeEntityPosition(building,true)
	Citizen.Wait(100)
	FloatTilSafe(numMultiplier,roomType,building)
	print('[nadrp-motels]: Begin building objects')
	--[[CreateObject(`v_49_motelmp_stuff`,generator.x,generator.y,generator.z,false,false,false)
		CreateObject(`v_49_motelmp_bed`,generator.x+1.4,generator.y-0.55,generator.z,false,false,false)
		CreateObject(`v_49_motelmp_clothes`,generator.x-2.0,generator.y+2.0,generator.z+0.15,false,false,false)
		CreateObject(`v_49_motelmp_winframe`,generator.x+0.74,generator.y-4.26,generator.z+1.11,false,false,false)
		CreateObject(`v_49_motelmp_glass`,generator.x+0.74,generator.y-4.26,generator.z+1.13,false,false,false)
		CreateObject(`v_49_motelmp_curtains`,generator.x+0.74,generator.y-4.15,generator.z+0.9,false,false,false)
		CreateObject(`v_49_motelmp_screen`,generator.x-2.21,generator.y-0.6,generator.z+0.79,false,false,false)
		CreateObject(`v_res_fa_trainer02r`,generator.x-1.9,generator.y+3.0,generator.z+0.38,false,false,false)
		CreateObject(`v_res_fa_trainer02l`,generator.x-2.1,generator.y+2.95,generator.z+0.38,false,false,false)

		local sink = CreateObject(`prop_sink_06`,generator.x+1.1,generator.y+4.0,generator.z,false,false,false)
		local chair1 = CreateObject(`prop_chair_04a`,generator.x+2.1,generator.y-2.4,generator.z,false,false,false)
		local chair2 = CreateObject(`prop_chair_04a`,generator.x+0.7,generator.y-3.5,generator.z,false,false,false)
		local kettle = CreateObject(`prop_kettle`,generator.x-2.3,generator.y+0.6,generator.z+0.9,false,false,false)
		local tvCabinet = CreateObject(`Prop_TV_Cabinet_03`,generator.x-2.3,generator.y-0.6,generator.z,false,false,false)
		local tv = CreateObject(`prop_tv_06`,generator.x-2.3,generator.y-0.6,generator.z+0.7,false,false,false)
		local toilet = CreateObject(`Prop_LD_Toilet_01`,generator.x+2.1,generator.y+2.9,generator.z,false,false,false)
		local clock = CreateObject(`Prop_Game_Clock_02`,generator.x-2.55,generator.y-0.6,generator.z+2.0,false,false,false)
		local phone = CreateObject(`v_res_j_phone`,generator.x+2.4,generator.y-1.9,generator.z+0.64,false,false,false)
		local ironBoard = CreateObject(`v_ret_fh_ironbrd`,generator.x-1.7,generator.y+3.5,generator.z+0.15,false,false,false)
		local iron = CreateObject(`prop_iron_01`,generator.x-1.9,generator.y+2.85,generator.z+0.63,false,false,false)
		local mug1 = CreateObject(`V_Ret_TA_Mug`,generator.x-2.3,generator.y+0.95,generator.z+0.9,false,false,false)
		local mug2 = CreateObject(`V_Ret_TA_Mug`,generator.x-2.2,generator.y+0.9,generator.z+0.9,false,false,false)
		CreateObject(`v_res_binder`,generator.x-2.2,generator.y+1.3,generator.z+0.87,false,false,false)
		print('[nadrp-motels]: Finished building objects')
		FreezeEntityPosition(sink,true)
		FreezeEntityPosition(chair1,true)
		FreezeEntityPosition(chair2,true)
		FreezeEntityPosition(tvCabinet,true)
		FreezeEntityPosition(tv,true)
		SetEntityHeading(chair1,GetEntityHeading(chair1)+270)
		SetEntityHeading(chair2,GetEntityHeading(chair2)+180)
		SetEntityHeading(kettle,GetEntityHeading(kettle)+90)
		SetEntityHeading(tvCabinet,GetEntityHeading(tvCabinet)+90)
		SetEntityHeading(tv,GetEntityHeading(tv)+90)
		SetEntityHeading(toilet,GetEntityHeading(toilet)+270)
		SetEntityHeading(clock,GetEntityHeading(clock)+90)
		SetEntityHeading(phone,GetEntityHeading(phone)+220)
		SetEntityHeading(ironBoard,GetEntityHeading(ironBoard)+90)
		SetEntityHeading(iron,GetEntityHeading(iron)+230)
		SetEntityHeading(mug1,GetEntityHeading(mug1)+20)
		SetEntityHeading(mug2,GetEntityHeading(mug2)+230)
	]]
	print('[nadrp-motels]: Set Object states')
	if not isForced then
		TriggerServerEvent('nadrp-motels:getID')
	end
	curRoomType = 1
	CleanUpPeds()
	print('[nadrp-motels]: Done building room')
	ClearAreaOfPeds(generator.x,generator.y,generator.z, 10.0, 1)
end

function getRotation(input)
	return 360/(10*input)
end

function buildRoom2(numMultiplier,roomType)

	SetEntityCoords(PlayerPedId(),347.04724121094,-1000.2844848633,-99.194671630859)
	FreezeEntityPosition(PlayerPedId(),true)
	Citizen.Wait(5000)

	local generator = { x = 175.09986877441 , y = -904.7946166992, z = -98.999984741211}
	generator.x = (175.09986877441) + ((numMultiplier * 25.0))
	generator.y = (-774.7946166992) -- ((numMultiplier * 25.0))
	currentRoom = generator

	if numMultiplier == myRoomNumber then
		myroomcoords = generator
	else
		curRoom = generator
	end

	SetEntityCoords(PlayerPedId(), generator.x+4.5 , generator.y-14, generator.z+2.9)
	local building = CreateObject(`v_16_mid_shell`,generator.x+2.29760700,generator.y-1.33191200,generator.z+1.26253700,false,false,false)
	FreezeEntityPosition(building,true)
	Citizen.Wait(100)
	FloatTilSafe(numMultiplier,roomType,building)

	local dt = CreateObject(`V_16_DT`,generator.x-1.21854400,generator.y-1.04389600,generator.z+1.39068600,false,false,false)
	local mpmid01 = CreateObject(`V_16_mpmidapart01`,generator.x+0.52447510,generator.y-5.04953700,generator.z+1.32,false,false,false)
	local mpmid09 = CreateObject(`V_16_mpmidapart09`,generator.x+0.82202150,generator.y+2.29612000,generator.z+1.88,false,false,false)
	local mpmid07 = CreateObject(`V_16_mpmidapart07`,generator.x-1.91445900,generator.y-6.61911300,generator.z+1.45,false,false,false)
	local mpmid03 = CreateObject(`V_16_mpmidapart03`,generator.x-4.82565300,generator.y-6.86803900,generator.z+1.14,false,false,false)
	local midData = CreateObject(`V_16_midapartdeta`,generator.x+2.28558400,generator.y-1.94082100,generator.z+1.32,false,false,false)
	local glow = CreateObject(`V_16_treeglow`,generator.x-1.37408500,generator.y-0.95420070,generator.z+1.135,false,false,false)
	local curtins = CreateObject(`V_16_midapt_curts`,generator.x-1.96423300,generator.y-0.95958710,generator.z+1.280,false,false,false)
	local mpmid13 = CreateObject(`V_16_mpmidapart13`,generator.x-4.65580700,generator.y-6.61684000,generator.z+1.259,false,false,false)
	local mpcab = CreateObject(`V_16_midapt_cabinet`,generator.x-1.16177400,generator.y-0.97333810,generator.z+1.27,false,false,false)
	local mpdecal = CreateObject(`V_16_midapt_deca`,generator.x+2.311386000,generator.y-2.05385900,generator.z+1.297,false,false,false)
	local mpdelta = CreateObject(`V_16_mid_hall_mesh_delta`,generator.x+3.69693000,generator.y-5.80020100,generator.z+1.293,false,false,false)
	local beddelta = CreateObject(`V_16_mid_bed_delta`,generator.x+7.95187400,generator.y+1.04246500,generator.z+1.28402300,false,false,false)
	local bed = CreateObject(`V_16_mid_bed_bed`,generator.x+6.86376900,generator.y+1.20651200,generator.z+1.36589100,false,false,false)
	local beddecal = CreateObject(`V_16_MID_bed_over_decal`,generator.x+7.82861300,generator.y+1.04696700,generator.z+1.34753700,false,false,false)
	local bathDelta = CreateObject(`V_16_mid_bath_mesh_delta`,generator.x+4.45460500,generator.y+3.21322800,generator.z+1.21116100,false,false,false)
	local bathmirror = CreateObject(`V_16_mid_bath_mesh_mirror`,generator.x+3.57740800,generator.y+3.25032000,generator.z+1.48871300,false,false,false)

	--props
	local beerbot = CreateObject(`Prop_CS_Beer_Bot_01`,generator.x+1.73134600,generator.y-4.88520200,generator.z+1.91083000,false,false,false)
	local couch = CreateObject(`v_res_mp_sofa`,generator.x-1.48765600,generator.y+1.68100600,generator.z+1.21640500,false,false,false)
	local chair = CreateObject(`v_res_mp_stripchair`,generator.x-4.44770800,generator.y-1.78048800,generator.z+1.21640500,false,false,false)
	local chair2 = CreateObject(`v_res_tre_chair`,generator.x+2.91325400,generator.y-5.27835100,generator.z+1.22746400,false,false,false)
	local plant = CreateObject(`Prop_Plant_Int_04a`,generator.x+2.78941300,generator.y-4.39133900,generator.z+2.12746400,false,false,false)
	local lamp = CreateObject(`v_res_d_lampa`,generator.x-3.61473100,generator.y-6.61465100,generator.z+2.08382800,false,false,false)
	local fridge = CreateObject(`v_res_fridgemodsml`,generator.x+1.90339700,generator.y-3.80026800,generator.z+1.29917900,false,false,false)
	local micro = CreateObject(`prop_micro_01`,generator.x+2.03442400,generator.y-4.61585100,generator.z+2.30395600,false,false,false)
	local sideBoard = CreateObject(`V_Res_Tre_SideBoard`,generator.x+2.84053000,generator.y-4.30947100,generator.z+1.24577300,false,false,false)
	local bedSide = CreateObject(`V_Res_Tre_BedSideTable`,generator.x-3.50363200,generator.y-6.55289400,generator.z+1.30625800,false,false,false)
	local lamp2 = CreateObject(`v_res_d_lampa`,generator.x+2.69674700,generator.y-3.83123500,generator.z+2.09373700,false,false,false)
	local plant2 = CreateObject(`v_res_tre_tree`,generator.x-4.96064800,generator.y-6.09898500,generator.z+1.31631400,false,false,false)
	local table = CreateObject(`V_Res_M_DineTble_replace`,generator.x-3.50712600,generator.y-4.13621600,generator.z+1.29625800,false,false,false)
	local tv = CreateObject(`Prop_TV_Flat_01`,generator.x-5.53120400,generator.y+0.76299670,generator.z+2.17236000,false,false,false)
	local plant3 = CreateObject(`v_res_tre_plant`,generator.x-5.14112800,generator.y-2.78951000,generator.z+1.25950800,false,false,false)
	local chair3 = CreateObject(`v_res_m_dinechair`,generator.x-3.04652400,generator.y-4.95971200,generator.z+1.19625800,false,false,false)
	local lampStand = CreateObject(`v_res_m_lampstand`,generator.x+1.26588400,generator.y+3.68883900,generator.z+1.30556700,false,false,false)
	local stool = CreateObject(`V_Res_M_Stool_REPLACED`,generator.x-3.23216300,generator.y+2.06159000,generator.z+1.20556700,false,false,false)
	local chair4 = CreateObject(`v_res_m_dinechair`,generator.x-2.82237200,generator.y-3.59831300,generator.z+1.25950800,false,false,false)
	local chair5 = CreateObject(`v_res_m_dinechair`,generator.x-4.14955100,generator.y-4.71316600,generator.z+1.19625800,false,false,false)
	local chair6 = CreateObject(`v_res_m_dinechair`,generator.x-3.80622900,generator.y-3.37648300,generator.z+1.19625800,false,false,false)

	local plant4 = CreateObject(`v_res_fa_plant01`,generator.x+2.97859200,generator.y+2.55307400,generator.z+1.85796300,false,false,false)
	local storage = CreateObject(`v_res_tre_storageunit`,generator.x+8.47819500,generator.y-2.50979300,generator.z+1.19712300,false,false,false)
	local storage2 = CreateObject(`v_res_tre_storagebox`,generator.x+9.75982700,generator.y-1.35874100,generator.z+1.29625800,false,false,false)
	local basketmess = CreateObject(`v_res_tre_basketmess`,generator.x+8.70730600,generator.y-2.55503600,generator.z+1.94059590,false,false,false)
	local lampStand2 = CreateObject(`v_res_m_lampstand`,generator.x+9.54306000,generator.y-2.50427700,generator.z+1.30556700,false,false,false)
	local plant4 = CreateObject(`Prop_Plant_Int_03a`,generator.x+9.87521400,generator.y+3.90917400,generator.z+1.20829700,false,false,false)

	local basket = CreateObject(`v_res_tre_washbasket`,generator.x+9.39091500,generator.y+4.49676300,generator.z+1.19625800,false,false,false)
	local wardrobe = CreateObject(`V_Res_Tre_Wardrobe`,generator.x+8.46626300,generator.y+4.53223600,generator.z+1.19425800,false,false,false)
	local basket2 = CreateObject(`v_res_tre_flatbasket`,generator.x+8.51593000,generator.y+4.55647300,generator.z+3.46737300,false,false,false)
	local basket3 = CreateObject(`v_res_tre_basketmess`,generator.x+7.57797200,generator.y+4.55198800,generator.z+3.46737300,false,false,false)
	local basket4 = CreateObject(`v_res_tre_flatbasket`,generator.x+7.12286400,generator.y+4.54689200,generator.z+3.46737300,false,false,false)
	local wardrobe2 = CreateObject(`V_Res_Tre_Wardrobe`,generator.x+7.24382000,generator.y+4.53423500,generator.z+1.19625800,false,false,false)
	local basket5 = CreateObject(`v_res_tre_flatbasket`,generator.x+8.03364600,generator.y+4.54835500,generator.z+3.46737300,false,false,false)

	local switch = CreateObject(`v_serv_switch_2`,generator.x+6.28086900,generator.y-0.68169880,generator.z+2.30326000,false,false,false)

	local table2 = CreateObject(`V_Res_Tre_BedSideTable`,generator.x+5.84416200,generator.y+2.57377400,generator.z+1.22089100,false,false,false)
	local lamp3 = CreateObject(`v_res_d_lampa`,generator.x+5.84912100,generator.y+2.58001100,generator.z+1.95311890,false,false,false)
	local laundry = CreateObject(`v_res_mlaundry`,generator.x+5.77729800,generator.y+4.60211400,generator.z+1.19674400,false,false,false)

	local ashtray = CreateObject(`Prop_ashtray_01`,generator.x-1.24716200,generator.y+1.07820500,generator.z+1.89089300,false,false,false)

	local candle1 = CreateObject(`v_res_fa_candle03`,generator.x-2.89289900,generator.y-4.35329700,generator.z+2.02881310,false,false,false)
	local candle2 = CreateObject(`v_res_fa_candle02`,generator.x-3.99865700,generator.y-4.06048500,generator.z+2.02530190,false,false,false)
	local candle3 = CreateObject(`v_res_fa_candle01`,generator.x-3.37733400,generator.y-3.66639800,generator.z+2.02526200,false,false,false)
	local woodbowl = CreateObject(`v_res_m_woodbowl`,generator.x-3.50787400,generator.y-4.11983000,generator.z+2.02589900,false,false,false)
	local tablod = CreateObject(`V_Res_TabloidsA`,generator.x-0.80513000,generator.y+0.51389600,generator.z+1.18418800,false,false,false)


	local tapeplayer = CreateObject(`Prop_Tapeplayer_01`,generator.x-1.26010100,generator.y-3.62966400,generator.z+2.37883200,false,false,false)
	local woodbowl2 = CreateObject(`v_res_tre_fruitbowl`,generator.x+2.77764900,generator.y-4.138297000,generator.z+2.10340100,false,false,false)
	local sculpt = CreateObject(`v_res_sculpt_dec`,generator.x+3.03932200,generator.y+1.62726400,generator.z+3.58363900,false,false,false)
	local jewlry = CreateObject(`v_res_jewelbox`,generator.x+3.04164100,generator.y+0.31671810,generator.z+3.58363900,false,false,false)

	local basket6 = CreateObject(`v_res_tre_basketmess`,generator.x-1.64906300,generator.y+1.62675900,generator.z+1.39038500,false,false,false)
	local basket7 = CreateObject(`v_res_tre_flatbasket`,generator.x-1.63938900,generator.y+0.91133310,generator.z+1.39038500,false,false,false)

	local basket8 = CreateObject(`v_res_tre_flatbasket`,generator.x-1.19923400,generator.y+1.69598600,generator.z+1.39038500,false,false,false)
	local basket9 = CreateObject(`v_res_tre_basketmess`,generator.x-1.18293800,generator.y+0.91436380,generator.z+1.39038500,false,false,false)
	local bowl = CreateObject(`v_res_r_sugarbowl`,generator.x-0.26029210,generator.y-6.66716800,generator.z+3.77324900,false,false,false)
	local breadbin = CreateObject(`Prop_Breadbin_01`,generator.x+2.09788500,generator.y-6.57634000,generator.z+2.24041900,false,false,false)
	local knifeblock = CreateObject(`v_res_mknifeblock`,generator.x+1.82084700,generator.y-6.58438500,generator.z+2.27399500,false,false,false)

	local toaster = CreateObject(`prop_toaster_01`,generator.x-1.05790700,generator.y-6.59017400,generator.z+2.26793200,false,false,false)
	local wok = CreateObject(`prop_wok`,generator.x+2.01728800,generator.y-5.57091500,generator.z+2.26793200,false,false,false)
	local plant5 = CreateObject(`Prop_Plant_Int_03a`,generator.x+2.55015600,generator.y+4.60183900,generator.z+1.20829700,false,false,false)

	local tumbler = CreateObject(`p_tumbler_cs2_s`,generator.x-0.90916440,generator.y-4.24099100,generator.z+2.26793200,false,false,false)
	local wisky = CreateObject(`p_whiskey_bottle_s`,generator.x-0.92809300,generator.y-3.99099100,generator.z+2.26793200,false,false,false)
	local tissue = CreateObject(`v_res_tissues`,generator.x+7.95889300,generator.y-2.54847100,generator.z+1.94013400,false,false,false)

	local pants = CreateObject(`V_16_Ap_Mid_Pants4`,generator.x+7.55366500,generator.y-0.25457100,generator.z+1.33009200,false,false,false)
	local pants2 = CreateObject(`V_16_Ap_Mid_Pants5`,generator.x+7.76753200,generator.y+3.00476500,generator.z+1.33052800,false,false,false)
	local hairdryer = CreateObject(`v_club_vuhairdryer`,generator.x+8.12616000,generator.y-2.50562000,generator.z+1.96009390,false,false,false)


	FreezeEntityPosition(dt,true)
	FreezeEntityPosition(mpmid01,true)
	FreezeEntityPosition(mpmid09,true)
	FreezeEntityPosition(mpmid07,true)
	FreezeEntityPosition(mpmid03,true)
	FreezeEntityPosition(midData,true)
	FreezeEntityPosition(glow,true)
	FreezeEntityPosition(curtins,true)
	FreezeEntityPosition(mpmid13,true)
	FreezeEntityPosition(mpcab,true)
	FreezeEntityPosition(mpdecal,true)
	FreezeEntityPosition(mpdelta,true)
	FreezeEntityPosition(couch,true)
	FreezeEntityPosition(chair,true)
	FreezeEntityPosition(chair2,true)
	FreezeEntityPosition(plant,true)
	FreezeEntityPosition(lamp,true)
	FreezeEntityPosition(fridge,true)
	FreezeEntityPosition(micro,true)
	FreezeEntityPosition(sideBoard,true)
	FreezeEntityPosition(bedSide,true)
	FreezeEntityPosition(plant2,true)
	FreezeEntityPosition(table,true)
	FreezeEntityPosition(tv,true)
	FreezeEntityPosition(plant3,true)
	FreezeEntityPosition(chair3,true)
	FreezeEntityPosition(lampStand,true)
	FreezeEntityPosition(chair4,true)
	FreezeEntityPosition(chair5,true)
	FreezeEntityPosition(chair6,true)
	FreezeEntityPosition(plant4,true)
	FreezeEntityPosition(storage2,true)
	FreezeEntityPosition(basket,true)
	FreezeEntityPosition(wardrobe,true)
	FreezeEntityPosition(wardrobe2,true)
	FreezeEntityPosition(table2,true)
	FreezeEntityPosition(lamp3,true)
	FreezeEntityPosition(laundry,true)
	FreezeEntityPosition(beddelta,true)
	FreezeEntityPosition(bed,true)
	FreezeEntityPosition(beddecal,true)
	FreezeEntityPosition(tapeplayer,true)
	FreezeEntityPosition(basket7,true)
	FreezeEntityPosition(basket6,true)
	FreezeEntityPosition(basket8,true)
	FreezeEntityPosition(basket9,true)

	SetEntityHeading(beerbot,GetEntityHeading(beerbot)+90)
	SetEntityHeading(couch,GetEntityHeading(couch)-90)
	SetEntityHeading(chair,GetEntityHeading(chair)+getRotation(0.28045480))
	SetEntityHeading(chair2,GetEntityHeading(chair2)+getRotation(0.3276100))
	SetEntityHeading(fridge,GetEntityHeading(chair2)+160)
	SetEntityHeading(micro,GetEntityHeading(micro)-80)
	SetEntityHeading(sideBoard,GetEntityHeading(sideBoard)+90)
	SetEntityHeading(bedSide,GetEntityHeading(bedSide)+180)
	SetEntityHeading(tv,GetEntityHeading(tv)+90)
	SetEntityHeading(plant3,GetEntityHeading(plant3)+90)
	SetEntityHeading(chair3,GetEntityHeading(chair3)+200)
	SetEntityHeading(chair4,GetEntityHeading(chair3)+100)
	SetEntityHeading(chair5,GetEntityHeading(chair5)+135)
	SetEntityHeading(chair6,GetEntityHeading(chair6)+10)
	SetEntityHeading(storage,GetEntityHeading(storage)+180)
	SetEntityHeading(storage2,GetEntityHeading(storage2)-90)
	SetEntityHeading(table2,GetEntityHeading(table2)+90)
	SetEntityHeading(tapeplayer,GetEntityHeading(tapeplayer)+90)
	SetEntityHeading(knifeblock,GetEntityHeading(knifeblock)+180)

	if not isForced then
		TriggerServerEvent('nadrp-motels:getID')
	end
	curRoomType = 2
end

function FloatTilSafe(numMultiplier,roomType,buildingsent)
	SetEntityInvincible(PlayerPedId(),true)
	FreezeEntityPosition(PlayerPedId(),true)
	local plyCoord = GetEntityCoords(PlayerPedId())
	local processing = 3
	local counter = 100
	local building = buildingsent
	while processing == 3 do
		Citizen.Wait(100)
		if DoesEntityExist(building) then

			processing = 2
		end
		if counter == 0 then
			processing = 1
		end
		counter = counter - 1
	end

	if counter > 0 then
		SetEntityCoords(PlayerPedId(),plyCoord)
		CleanUpPeds()
	elseif processing == 1 then
		if roomType == 2 then
			SetEntityCoords(PlayerPedId(),267.48132324219,-638.818359375,42.020294189453)
		elseif roomType == 3 then
			SetEntityCoords(PlayerPedId(),160.26762390137,-641.96905517578,47.073524475098)
		elseif roomType == 1 then
			SetEntityCoords(PlayerPedId(),312.96966552734,-218.2705078125,54.221797943115)
		end
		exports['mythic_notify']:SendAlert('error', 'Failed to load, please retry.')
	end
	TriggerEvent("nadrp-death:revive")
end

function buildRoom3(numMultiplier,roomType)
	garageNumber = numMultiplier

	SetEntityCoords(PlayerPedId(),305.66970825195,-993.61737060547,-94.195129394531)
	FreezeEntityPosition(PlayerPedId(),true)
	Citizen.Wait(5000)

	local generator = { x = -265.68209838867 , y = -957.06573486328, z = 145.824577331543}
	if numMultiplier > 0 and numMultiplier < 7 then
		--generator = { x = -143.16976928711 , y = -596.31140136719, z = 61.95349121093}
		--generator.z = (61.9534912) + ((numMultiplier * 11.0) * roomType)
		generator = { x = 131.0290527343, y = -644.0509033203, z = 68.025619506836}
		generator.z = (68.0534912) + ((numMultiplier * 11.0))
	end

	if numMultiplier > 6 and numMultiplier < 14 then
		generator = { x = -134.43560791016 , y = -638.13916015625, z = 68.953491210938}
		numMultiplier = numMultiplier - 6
		generator.z = (61.9534912) + ((numMultiplier * 11.0))
	end

	if numMultiplier > 13 and numMultiplier < 20 then
		generator = { x = -181.440234375 , y = -584.04815673828, z = 68.95349121093}
		numMultiplier = numMultiplier - 13
		generator.z = (61.9534912) + ((numMultiplier * 11.0))
	end

	if numMultiplier > 19 and numMultiplier < 26 then
		generator = { x = -109.9752227783, y = -570.272351074, z = 61.9534912}
		numMultiplier = numMultiplier - 19
		generator.z = (61.9534912) + ((numMultiplier * 11.0))
	end

	if numMultiplier > 25 and numMultiplier < 38 then
		generator = { x = -3.9463002681732, y = -693.2456665039, z = 103.0334701538}
		numMultiplier = numMultiplier - 25
		generator.z = (103.0534912) + ((numMultiplier * 11.0))
	end

	if numMultiplier > 37 and numMultiplier < 49 then
		generator = { x = 140.0758819580, y = -748.12322998, z = 87.0334701538}
		numMultiplier = numMultiplier - 37
		generator.z = (87.0534912) + ((numMultiplier * 11.0))
	end

	if numMultiplier > 48 and numMultiplier < 60 then
		generator = { x = 131.0290527343, y = -644.0509033203, z = 68.025619506836}
		numMultiplier = numMultiplier - 48
		generator.z = (68.0534912) + ((numMultiplier * 11.0))
	end

	currentRoom = generator

	if numMultiplier == myRoomNumber then
		myroomcoords = generator
	else
		curRoom = generator
	end

	SetEntityCoords(PlayerPedId(), generator.x - 12.9,generator.y - 1.5,generator.z+8.00)

	local building = CreateObject(`v_16_mesh_shell`,generator.x+3.62430500,generator.y-1.55553200,generator.z+0.0,false,false,false)
	FreezeEntityPosition(building,true)
	FloatTilSafe(numMultiplier,roomType,building)
	CreateObject(`V_16_bed_mesh_windows`,generator.x+0.30707600,generator.y-5.44994300,generator.z+0.0,false,false,false)
	CreateObject(`V_16_bed_mesh_delta`,generator.x-1.76030900,generator.y-0.67466500,generator.z-0.0,false,false,false)
	CreateObject(`V_16_bed_mesh_delta`,generator.x-1.76030900,generator.y-0.67466500,generator.z+0.02,false,false,false)
	CreateObject(`V_16_high_bed_over_normal`,generator.x-1.75513100,generator.y+1.65130700,generator.z-0.0,false,false,false)
	CreateObject(`V_16_bdrm_mesh_bath`,generator.x+5.70348400,generator.y-0.86338900,generator.z+0.0,false,false,false)
	CreateObject(`V_16_bdr_mesh_bed`,generator.x+4.96819100,generator.y-0.72599610,generator.z+0.0,false,false,false)
	CreateObject(`V_16_bdRm_paintings002`,generator.x-0.41010200,generator.y-0.58682690,generator.z+0.15,false,false,false)
	CreateObject(`V_16_high_bed_mesh_lights`,generator.x+0.59020600,generator.y+2.21927200,generator.z-0.01,false,false,false)
	CreateObject(`V_16_high_bed_over_shadow`,generator.x+2.22250100,generator.y+1.72320200,generator.z-0.12,false,false,false)
	CreateObject(`V_16_lgb_rock001`,generator.x+0.30704400,generator.y-5.44356400,generator.z+2.65031600,false,false,false)
	CreateObject(`V_16_lnb_mesh_coffee`,generator.x+0.55458700,generator.y-2.51553800,generator.z+0.0,false,false,false)
	CreateObject(`V_16_high_bed_over_dirt`,generator.x+3.62430500,generator.y-1.55553200,generator.z+0.0,false,false,false)
	CreateObject(`V_16_high_bed_mesh_unit`,generator.x+3.64581600,generator.y+2.85395100,generator.z+0.0,false,false,false)
	CreateObject(`V_16_lng_mesh_stairGlass`,generator.x-7.56569000,generator.y-0.83904900,generator.z+5.030,false,false,false)
	CreateObject(`V_16_lng_mesh_delta`,generator.x-5.13722400,generator.y+0.09224100,generator.z+2.580,false,false,false)
	CreateObject(`V_16_lng_over_normal`,generator.x-1.36473800,generator.y+0.80418800,generator.z+2.580,false,false,false)
	CreateObject(`V_16_lng_mesh_blinds`,generator.x+4.04209900,generator.y-0.44575400,generator.z+7.680,false,false,false)
	CreateObject(`V_16_lng_mesh_windows`,generator.x+4.13028000,generator.y-0.57411700,generator.z+4.800,false,false,false)
	CreateObject(`V_16_high_lng_details`,generator.x+8.45114900,generator.y-0.81883400,generator.z+5.390,false,false,false)
	CreateObject(`V_16_lgb_mesh_lngProp`,generator.x+8.37186000,generator.y-1.07978700,generator.z+4.880,false,false,false)
	CreateObject(`V_16_high_lng_mesh_shelf`,generator.x-1.95027700,generator.y-3.14528700,generator.z+5.100,false,false,false)
	CreateObject(`V_16_knt_c`,generator.x+6.42180800,generator.y-0.99209900,generator.z+4.810,false,false,false)
	CreateObject(`V_16_rpt_mesh_pictures`,generator.x-8.01097500,generator.y-2.66429500,generator.z+5.450,false,false,false)
	CreateObject(`V_16_high_lng_mesh_delta`,generator.x-9.39279700,generator.y+0.07170800,generator.z+2.380,false,false,false)

	local table = CreateObject(`V_16_FH_SideBrdLngB_RSref001`,generator.x+5.00673200,generator.y-0.30080600,generator.z+4.890,false,false,false)
	--CreateObject(`V_16_knt_f`,generator.x-11.58236000,generator.y+1.10087100,generator.z+4.890,false,false,false)
	CreateObject(`V_16_high_lng_mesh_plant`,generator.x-3.68126800,generator.y+4.03672500,generator.z+4.590,false,false,false)
	CreateObject(`V_16_high_lng_mesh_tvUnit`,generator.x+9.03048800,generator.y-4.68231400,generator.z+4.900,false,false,false)
	CreateObject(`V_16_high_lng_over_shadow`,generator.x+10.16043000,generator.y-4.83294600,generator.z+4.840,false,false,false)
	CreateObject(`V_16_high_lng_over_shadow2`,generator.x-8.00688600,generator.y-1.29692100,generator.z+3.6,false,false,false)
	local armChairs = CreateObject(`V_16_high_lng_armChairs`,generator.x+1.49934300,generator.y-1.34954600,generator.z+4.85,false,false,false)
	CreateObject(`V_16_high_stp_mesh_unit`,generator.x-13.39290000,generator.y-0.17506300,generator.z+2.35,false,false,false)
	CreateObject(`v_16_v_sofa`,generator.x+7.80983000,generator.y+0.06534800,generator.z+4.85,false,false,false)
	CreateObject(`V_16_lng_mesh_stairGlassB`,generator.x-9.96113500,generator.y-2.60950900,generator.z+6.39,false,false,false)
	local kitchenShadow = CreateObject(`V_16_high_ktn_over_shadows`,generator.x+5.58696700,generator.y+5.58839800,generator.z+4.85,false,false,false)
	local kitchenStuff = CreateObject(`V_16_knt_mesh_stuff`,generator.x-4.19894500,generator.y+8.82334300,generator.z+4.9,false,false,false)
	CreateObject(`V_16_rpt_mesh_pictures003`,generator.x+12.47420000,generator.y+6.88947700,generator.z+5.76,false,false,false)
	CreateObject(`V_16_dnr_a`,generator.x+9.33427000,generator.y+12.73493000,generator.z+6.25,false,false,false)
	CreateObject(`V_16_high_ktn_over_decal`,generator.x+1.23671000,generator.y+8.76967200,generator.z+4.82,false,false,false)
	CreateObject(`V_16_high_ktn_over_shadow`,generator.x+9.23939100,generator.y+12.44786000,generator.z+4.82,false,false,false)
	CreateObject(`V_16_high_kit_mesh_unit`,generator.x-1.81104800,generator.y+9.17513200,generator.z+4.82,false,false,false)
	CreateObject(`V_16_lnb_mesh_tableCenter001`,generator.x+9.90664500,generator.y+6.71798600,generator.z+5.7,false,false,false)
	CreateObject(`V_16_high_ktn_mesh_delta`,generator.x+4.43419300,generator.y+9.17583700,generator.z+4.81,false,false,false)
	CreateObject(`V_16_high_ktn_mesh_windows`,generator.x+4.12927300,generator.y+12.89458000,generator.z+4.81,false,false,false)
	CreateObject(`V_16_high_ktn_mesh_fire`,generator.x+6.25015900,generator.y+5.34384200,generator.z+5.1,false,false,false)
	local tableDin = CreateObject(`v_res_fh_diningtable`,generator.x+9.90193900,generator.y+6.85432300,generator.z+4.84,false,false,false)
	CreateObject(`V_16_dnr_c`,generator.x+9.99221000,generator.y+12.55397000,generator.z+4.84,false,false,false)
	CreateObject(`V_16_lngAS_mesh_delta003`,generator.x+0.69565000,generator.y+13.05990000,generator.z+4.84,false,false,false)
	CreateObject(`V_16_hiigh_ktn_over_normal`,generator.x+3.76106900,generator.y+9.03640600,generator.z+4.84,false,false,false)
	CreateObject(`V_16_high_hall_mesh_delta`,generator.x-18.46974000,generator.y-0.07385800,generator.z+6.2,false,false,false)
	CreateObject(`V_16_high_hall_over_normal`,generator.x-18.30516000,generator.y+1.78606500,generator.z+6.2,false,false,false)
	CreateObject(`V_16_high_hall_over_dirt`,generator.x-18.19183000,generator.y-0.05498100,generator.z+6.2,false,false,false)
	CreateObject(`V_16_high_hall_over_shadow`,generator.x-16.98634000,generator.y-0.46674400,generator.z+6.2,false,false,false)
	CreateObject(`V_16_high_hal_mesh_plant`,generator.x-15.28974000,generator.y+4.79591600,generator.z+6.0,false,false,false)
	CreateObject(`V_16_high_bath_mesh_mirror`,generator.x-4.29534100,generator.y+3.74431100,generator.z+1.2,false,false,false)
	CreateObject(`V_16_high_bath_over_shadow`,generator.x-4.25607300,generator.y+6.22950200,generator.z+0.0,false,false,false)
	CreateObject(`V_16_high_bath_over_normals`,generator.x-4.32515600,generator.y+5.55146000,generator.z+0.0,false,false,false)
	--CreateObject(`V_16_high_bath_showerDoor`,generator.x-4.32213500,generator.y+6.22829300,generator.z+0.0,false,false,false)
	CreateObject(`V_16_high_bath_delta`,generator.x-4.32213500,generator.y+6.22829300,generator.z+0.0,false,false,false)

	--- Study Room ?
	CreateObject(`V_16_mags`,generator.x-10.44022000,generator.y+8.14852500,generator.z+6.23,false,false,false)
	CreateObject(`V_16_HIFI`,generator.x-10.23440000,generator.y+8.07973100,generator.z+6.23,false,false,false)
	CreateObject(`V_16_goldRecords`,generator.x-6.60447500,generator.y+8.12033200,generator.z+7.6,false,false,false)
	CreateObject(`V_16_BasketBall`,generator.x-9.66279400,generator.y+5.33664100,generator.z+7.0,false,false,false)
	CreateObject(`V_16_study_rug`,generator.x-10.4173000,generator.y+8.21256100,generator.z+6.23,false,false,false)
	CreateObject(`V_16_study_sofa`,generator.x-8.57377800,generator.y+6.95918400,generator.z+6.23,false,false,false)
	CreateObject(`V_16_hi_apt_S_Books`,generator.x-10.46981000,generator.y+7.54295200,generator.z+6.62,false,false,false)


	--Heist Room ?
	--CreateObject(`V_16_hi_apt_planningrmstf`,generator.x-10.23550000,generator.y+7.98658200,generator.z+6.23,false,false,false)
	CreateObject(`V_16_high_plan_mesh_delta`,generator.x-10.72429000,generator.y+8.18422700,generator.z+8.5,false,false,false)
	CreateObject(`V_16_high_plan_over_normal`,generator.x-10.24225000,generator.y+8.13986200,generator.z+6.23,false,false,false)
	CreateObject(`V_16_high_pln_mesh_lights`,generator.x-10.38581000,generator.y+8.22193600,generator.z+9.24,false,false,false)
	CreateObject(`V_16_high_pln_over_shadow`,generator.x-14.40226000,generator.y+7.20166000,generator.z+6.23,false,false,false)
	CreateObject(`V_16_high_pln_m_map`,generator.x-10.86284000,generator.y+10.98704000,generator.z+6.55,false,false,false)
	CreateObject(`V_16_highStudWallDirt`,generator.x-7.45147700,generator.y+11.00713000,generator.z+6.23,false,false,false)
	CreateObject(`V_16_hi_studdorrtrim`,generator.x-12.58800000,generator.y+1.08456500,generator.z+0.0,false,false,false)
	CreateObject(`V_16_hi_apt_planningrmstf`,generator.x-10.23550000,generator.y+7.98658200,generator.z+6.23,false,false,false)

	CreateObject(`V_16_Wardrobe`,generator.x+4.04197800,generator.y+6.41092600,generator.z+0.0,false,false,false)
	CreateObject(`V_16_high_ward_over_decal`,generator.x+3.53625300,generator.y+6.29680900,generator.z+0.0,false,false,false)
	CreateObject(`V_16_high_ward_over_shadow`,generator.x+3.89552500,generator.y+6.29853200,generator.z+0.0,false,false,false)
	CreateObject(`V_16_high_ward_over_normal`,generator.x+3.70096300,generator.y+6.29901000,generator.z+0.0,false,false,false)

	---- Props

	local door = CreateObject(`V_ILev_MP_high_FrontDoor`,generator.x-14.59187000,generator.y-1.30682500,generator.z+6.25,false,false,true)
	local lamp = CreateObject(`v_res_fh_lampa_on`,generator.x+5.86731700,generator.y-2.72296000,generator.z+0.5,false,false,false)
	local chair1 = CreateObject(`v_res_fh_easychair`,generator.x+0.64114900,generator.y-4.38969100,generator.z+0.1,false,false,false)
	CreateObject(`v_res_fh_benchshort`,generator.x-3.74095700,generator.y-4.90060600,generator.z+0.1,false,false,false)
	CreateObject(`V_16_shitbench`,generator.x-0.45795000,generator.y+8.45196000,generator.z+0.1,false,false,false)
	local pouf = CreateObject(`v_res_fh_pouf`,generator.x+2.76928800,generator.y-1.43858200,generator.z+0.05,false,false,false)
	local tv = CreateObject(`Prop_TV_Flat_01`,generator.x+10.30526000,generator.y-4.7350230,generator.z+5.8,false,false,false)
	local table2 = CreateObject(`V_Res_FH_CofTblDisp`,generator.x+8.42698100,generator.y-0.80205100,generator.z+4.9,false,false,false)
	local scope = CreateObject(`Prop_T_Telescope_01b`,generator.x+11.87588000,generator.y+3.78066000,generator.z+4.8,false,false,false)
	local plant = CreateObject(`v_res_mplanttongue`,generator.x-0.89350100,generator.y+12.45097000,generator.z+4.8,false,false,false)
	local stool = CreateObject(`v_res_fh_kitnstool`,generator.x+1.50922800,generator.y+5.23503600,generator.z+4.8,false,false,false)
	local stool2 = CreateObject(`v_res_fh_kitnstool`,generator.x+0.71056300,generator.y+5.23717500,generator.z+4.8,false,false,false)
	local stool3 = CreateObject(`v_res_fh_kitnstool`,generator.x+0.00570800,generator.y+5.23717500,generator.z+4.8,false,false,false)
	local table3 = CreateObject(`v_res_fh_sidebrddine`,generator.x+10.23037000,generator.y+12.51273000,generator.z+4.8,false,false,false)

	FreezeEntityPosition(tableDin,true)
	FreezeEntityPosition(door,true)
	FreezeEntityPosition(lamp,true)
	FreezeEntityPosition(chair1,true)
	FreezeEntityPosition(pouf,true)
	FreezeEntityPosition(table2,true)
	FreezeEntityPosition(plant,true)
	FreezeEntityPosition(stool,true)
	FreezeEntityPosition(stool2,true)
	FreezeEntityPosition(stool3,true)
	FreezeEntityPosition(table3,true)

	SetEntityHeading(table,GetEntityHeading(table)-90)
	SetEntityHeading(armChairs,GetEntityHeading(armChairs)-25)
	SetEntityHeading(kitchenShadow,GetEntityHeading(kitchenShadow)+90)
	SetEntityHeading(kitchenStuff,GetEntityHeading(kitchenStuff)-34)
	SetEntityHeading(door,GetEntityHeading(door)+90)
	SetEntityHeading(lamp,GetEntityHeading(lamp)+90)
	SetEntityHeading(chair1,GetEntityHeading(chair1)+180)
	SetEntityHeading(pouf,GetEntityHeading(pouf)+15)
	SetEntityHeading(tv,GetEntityHeading(tv)+180)
	SetEntityHeading(table2,GetEntityHeading(table2)+90)
	SetEntityHeading(scope,GetEntityHeading(scope)+180)
	if not isForced then
		TriggerServerEvent('nadrp-motels:getID')
	end
	FreezeEntityPosition(PlayerPedId(),false)
	curRoomType = 3
end

function DrawText3Ds(x,y,z, text)
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

function logout()
    TransitionToBlurred(500)
    DoScreenFadeOut(500)
    Citizen.Wait(1000)
    CleanUpArea()
    Citizen.Wait(1000)
	TriggerEvent('kashactersC:ReloadCharacters')
	TriggerEvent('inhouse', false)
	TransitionFromBlurred(500)
	DoScreenFadeIn(500)
	Citizen.Wait(1000)
end

function inRoom()
	if #(vector3(myroomcoords.x,myroomcoords.y,myroomcoords.z) - GetEntityCoords(PlayerPedId())) < 40.0 then
		return true
	else
		return false
	end
end



local apartmentEntries = {
    [1] = { ["x"] = 312.96966552734,["y"] = -218.2705078125, ["z"] = 54.221797943115, ["name"] = "Pink Cage Motel", ['colour'] = 19},
    [2] = { ['x'] = -1472.38,['y'] = -657.84,['z'] = 29.27, ["name"] = "Beach Side Motel", ['colour'] = 5},
    --[5] = { ['x'] = 505.4,['y'] = 215.07,['z'] = 102.9, ["name"] = "Hotel 1-3" },
}

Citizen.CreateThread(function()
	for i = 1, #apartmentEntries do
		local blip = AddBlipForCoord(apartmentEntries[i]["x"], apartmentEntries[i]["y"], apartmentEntries[i]["z"])

		SetBlipSprite(blip, 475)
		SetBlipColour(blip, apartmentEntries[i]["colour"])
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		SetBlipScale(blip, 1.0)
		AddTextComponentString(apartmentEntries[i]["name"])
		EndTextCommandSetBlipName(blip)
	end
end)

RegisterCommand('enterroom', function(source, args, raw)
	local roomNumber = tonumber(args[1])
	print(apartments1[roomNumber])
	if roomNumber ~= nil then 
		local coords = GetEntityCoords(PlayerPedId())
		if #(vector3(apartments1[roomNumber]["x"], apartments1[roomNumber]["y"], apartments1[roomNumber]["z"]) - coords) < 3.0 then
			TriggerServerEvent('nadrp-motels:RequestEntry', tonumber(roomNumber))
		else
			exports["mythic_notify"]:SendAlert('error', 'You need to be near the door to enter, stoopid')
		end
	end
end)

-- Spawn Selector

RegisterNetEvent('nadrp-motels:createRoom')
AddEventHandler('nadrp-motels:createRoom', function(numMultiplier,roomType,mykeys,illness,isImprisoned,isClothesSpawn)
	imprisoned = isImprisoned
	spawning = false
	TriggerEvent("spawning",true)
	FreezeEntityPosition(PlayerPedId(),true)
	SetEntityCoords(PlayerPedId(), 152.09986877441 , -1004.7946166992, -98.999984741211)
	SetEntityInvincible(PlayerPedId(),true)
	myRoomNumber = numMultiplier
	myRoomType = roomType
	local lastPos = ESX.GetPlayerData().lastPosition
	TriggerEvent("nadrp-motels:myroomtype",myRoomType)

	myspawnpoints  = {
		[1] =  { ['x'] = -206.674, ['y'] = -1015.1, ['z'] = 30.1381,['h'] = 282.91, ['info'] = ' Altee Street Train Station', ["typeSpawn"] = 1 },
		[2] =  { ['x'] = 272.16,['y'] = 185.44,['z'] = 104.67,['h'] = 320.57, ['info'] = ' Vinewood Blvd Taxi Stand', ["typeSpawn"] = 1 },
		[3] =  { ['x'] = -1037.74, ['y'] = -2738.04, ['z'] = 20.1693, ['h'] = 282.91, ['info'] = ' Airport Taxi stand', ["typeSpawn"] = 1 },
		[4] =  { ['x'] = -1833.96,['y'] = -1223.5,['z'] = 13.02,['h'] = 310.63, ['info'] = ' The Boardwalk', ["typeSpawn"] = 1 },
		[5] =  { ['x'] = 145.62,['y'] = 6563.19,['z'] = 32.0,['h'] = 42.83, ['info'] = ' Paleto Gas Station', ["typeSpawn"] = 1 },
		[6] =  { ['x'] = -214.24,['y'] = 6178.87,['z'] = 31.17,['h'] = 40.11, ['info'] = ' Paleto Bus Stop', ["typeSpawn"] = 1 },
		[7] =  { ['x'] = 1122.11,['y'] = 2667.24,['z'] = 38.04,['h'] = 180.39, ['info'] = ' Harmony Motel', ["typeSpawn"] = 1 },
		[8] =  { ['x'] = 453.29,['y'] = -662.23,['z'] = 28.01,['h'] = 5.73, ['info'] = ' LS Bus Station', ["typeSpawn"] = 1 },
		[9] =  { ['x'] = -1266.53,['y'] = 273.86,['z'] = 64.66,['h'] = 28.52, ['info'] = ' The Richman Hotel', ["typeSpawn"] = 1 },
		[10] =  { ['x'] = lastPos.x ,['y'] = lastPos.y ,['z'] = lastPos.z ,['h'] = 28.52, ['info'] = ' Last known location', ["typeSpawn"] = 1 },
	}

	if illness == "dead" or illness == "icu" then
		return
	end

	if roomType == 1 then
		myspawnpoints[#myspawnpoints + 1] = { ['x'] = 326.38,['y'] = -212.11,['z'] = 54.09,['h'] = 166.11, ['info'] = ' Apartments 1', ["typeSpawn"] = 2 }
	elseif roomType == 2 then
		myspawnpoints[#myspawnpoints + 1] = { ['x'] = 262.0,['y'] = -639.15,['z'] = 42.88,['h'] = 67.09, ['info'] = ' Apartments 2', ["typeSpawn"] = 2 }
	else
		myspawnpoints[#myspawnpoints + 1] = { ['x'] = 173.96,['y'] = -631.29,['z'] = 47.08,['h'] = 303.12, ['info'] = ' Apartments 3', ["typeSpawn"] = 2 }
	end

	for i = 1, #mykeys do
		local house_model = tonumber(mykeys[i]["house_model"])
		local house_id = tonumber(mykeys[i]["house_id"])
		local keyinsert = exports['nadrp-property']:GetHouseCoords('robberycoords', house_id, house_model)

		if house_model == 2 then
			keyinsert = exports['nadrp-property']:GetHouseCoords('robberycoordsMansions', house_id, house_model)
			keyinsert["info"] = mykeys[i]["house_name"]
		end
		if house_model < 3 or house_model == 5 then
			keyinsert["typeSpawn"] = 3
			keyinsert["info"] = mykeys[i]["house_name"]
			keyinsert["house_model"] = mykeys[i]["house_model"]
			keyinsert["house_id"] = mykeys[i]["house_id"]
			myspawnpoints[#myspawnpoints + 1] = keyinsert
		end
	end

	if isClothesSpawn then
		local apartmentName = ' Apartments 1'
		if roomType == 1 then
			apartmentName = ' Apartments 1'
		elseif roomType == 2 then
			apartmentName = ' Apartments 2'
		else
			apartmentName = ' Apartments 3'
		end

		for k,v in pairs(myspawnpoints) do
			if v.info == apartmentName then
				currentselection = k
			end
		end
		confirmSpawning(true)
		TriggerServerEvent('nadrp:GetMetaData')
	else
		if not imprisoned then
			SendNUIMessage({
				openSection = "main",
			})

			SetNuiFocus(true,true)
			doSpawn(myspawnpoints)
			DoScreenFadeIn(2500)
			doCamera()
		elseif imprisoned then
			DoScreenFadeIn(2500)
			doCamera(true)
			prisionSpawn()
		end
		TriggerServerEvent('nadrp:GetMetaData')
	end
end)

RegisterNUICallback('selectedspawn', function(data, cb)
	if spawning then
		return
	end
	currentselection = data.tableidentifier
    doCamera()
end)

RegisterNUICallback('confirmspawn', function(data, cb)
	spawning = true
	DoScreenFadeOut(100)
	Citizen.Wait(100)
	SendNUIMessage({
		openSection = "close",
	})
	startcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	RenderScriptCams(false, true, 500, true, true)
	SetCamActiveWithInterp(cam, cam2, 3700, true, true)
	SetEntityVisible(PlayerPedId(), true, 0)
	FreezeEntityPosition(PlayerPedId(), false)
    SetPlayerInvisibleLocally(PlayerPedId(), false)
    SetPlayerInvincible(PlayerPedId(), false)
    DestroyCam(startcam, false)
    DestroyCam(cam, false)
    DestroyCam(cam2, false)
    Citizen.Wait(0)
    FreezeEntityPosition(GetPlayerPed(-1), false)
	confirmSpawning(false)
end)

function confirmSpawning(isClothesSpawn,prison)
	local x = myspawnpoints[currentselection]["x"]
	local y = myspawnpoints[currentselection]["y"]
	local z = myspawnpoints[currentselection]["z"]
	local h = myspawnpoints[currentselection]["h"]

	ClearFocus()
	SetNuiFocus(false,false)
	-- spawn them here.

	RenderScriptCams(false, false, 0, 1, 0) -- Return to gameplay camera
	DestroyCam(cam, false)

	if myspawnpoints[currentselection]["typeSpawn"] == 1 then
		SetEntityCoords(PlayerPedId(),x,y,z)
		SetEntityHeading(PlayerPedId(),h)
	elseif myspawnpoints[currentselection]["typeSpawn"] == 2 then
		defaultSpawn()
	elseif myspawnpoints[currentselection]["typeSpawn"] == 3 then
		local house_id = myspawnpoints[currentselection]["house_id"]
		local house_model = myspawnpoints[currentselection]["house_model"]
		TriggerServerEvent("house:enterhouse",house_id,house_model,false)
	else
		print("error spawning?")
	end

	SetEntityInvincible(PlayerPedId(),false)
	FreezeEntityPosition(PlayerPedId(),false)

	Citizen.Wait(3500)
	DoScreenFadeIn(5000)
	TriggerEvent("spawning",false)

	if isClothesSpawn then
	end

	if(DoesCamExist(cam)) then
		DestroyCam(cam, false)
	end
	Wait(100)
end

function doSpawn(array)
	for i = 1, #array do
		SendNUIMessage({
			openSection = "enterspawn",
			textmessage = array[i]["info"],
			tableid = i,
		})
	end
end

function doCamera(prison)
	killcam = true
	if spawning then
		return
	end
	Citizen.Wait(1)
	killcam = false
	local camselection = currentselection
	DoScreenFadeOut(1)
	if(not DoesCamExist(cam)) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
	end

	local x,y,z,h

	if prison then
		x = 1646.767
		y = 2491.27
		z = 55.42717
		h = 41.672
	else
		x = myspawnpoints[currentselection]["x"]
		y = myspawnpoints[currentselection]["y"]
		z = myspawnpoints[currentselection]["z"]
		h = myspawnpoints[currentselection]["h"]
	end
	
	i = 3200
	SetFocusArea(x, y, z, 0.0, 0.0, 0.0)
	SetCamActive(cam,  true)
	RenderScriptCams(true,  false,  0,  true,  true)
	DoScreenFadeIn(1500)
	local camAngle = -90.0
	while i > 1 and camselection == currentselection and not spawning and not killcam do
		local factor = i / 50
		if i < 1 then i = 1 end
		i = i - factor
		SetCamCoord(cam, x,y,z+i)
		if i < 1200 then
			DoScreenFadeIn(600)
		end
		if i < 90.0 then
			camAngle = i - i - i
		end
		SetCamRot(cam, camAngle, 0.0, 0.0)
		Citizen.Wait(1)
	end
end

function prisionSpawn()
	spawning = true
	DoScreenFadeOut(100)
	Citizen.Wait(100)

	ClearFocus()
	SetNuiFocus(false,false)
	-- spawn them here.

	RenderScriptCams(false, true, 500, true, true) -- Return to gameplay camera
	DestroyCam(cam, false)

	SetEntityInvincible(PlayerPedId(),false)
	FreezeEntityPosition(PlayerPedId(),false)

	Citizen.Wait(2000)
	TriggerEvent("spawning",false)

	TriggerServerEvent("request-dropped-items")
	TriggerServerEvent("server-request-update",exports["nadrp-ped"]:isPed("steamid"))
	TriggerEvent('nadrp-jail:PlayerLoaded')
	DestroyAllCams(false)
	DoScreenFadeIn(100)
end

function defaultSpawn()
	moveToMyHotel(myRoomType)
	TriggerEvent("nadrp-motels:myroomtype",myRoomType)
end
