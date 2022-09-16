ESX = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('tuner:FinishMoneyCheckForVeh')
RegisterNetEvent('vehshop_tuner:spawnVehicle')
local vehshop_blips = {}
local financedPlates = {}
local buyPlates = {}
local inrangeofvehshop = false
local currentlocation = nil
local boughtcar = false
local vehicle_price = 0
local backlock = false
local firstspawn = 0
local commissionbuy = 0
local seller = ''
local carSafeSpawn = { ['x'] = 935.61, ['y'] = -990.8, ['z'] = 38.0, ['h'] = 252.4, ['info'] = ' Test Drive Spawn' }
local carBrowserLocation = { ['x'] = 920.73, ['y'] = -949.92,['z'] = 39.23, ['h'] = 119.9, ['info'] = ' Car Browser Location' }

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local currentCarSpawnLocation = 0
local ownerMenu = false

local vehshopDefault = {
	opened = false,
	title = "Tuner Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 250, type = 1 },
	menu = {
		x = 0.14,
		y = 0.15,
		width = 0.12,
		height = 0.03,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.29,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Vehicles", description = ""},
			}
		},
		["vehicles"] = {
			title = "VEHICLES",
			name = "vehicles",
			buttons = {
				{name = "Job Vehicles", description = ''},
			}
		},		
	}
}

vehshop = vehshopDefault
local vehshopOwner = {
	opened = false,
	title = "Tuner Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 250, type = 1 },
	menu = {
		x = 0.14,
		y = 0.15,
		width = 0.12,
		height = 0.03,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.29,
		font = 0,

		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Vehicles", description = ""},
			}
		},

		["vehicles"] = {
			title = "VEHICLES",
			name = "vehicles",
			buttons = {
				{name = "Sports", description = ''},
				{name = "Sold", description = ''},
				{name = "Drift", description = ''},
			}
		},

		---CHANGE FROM HERE

		["Drift"] = {
			title = "Drift",
			name = "Drift",
			buttons = {
				{model = "sultanrsv8", name = "Sultan RS MK2", costs = 300000, description = {} },
				{model = "m235", name = "BMW M235", costs = 235000, description = {} },
				{model = "schwarzer2", name = "6STR Schwartzer", costs = 335000, description = {} }, 
			}
		},

		["Sports"] = {
			title = "Sports",
			name = "Sports",
			buttons = {
				--{model = "zx10", name = "Kawasaki Ninja ZX10R", costs = 200000, description = {} },
				{model = "filthynsx", name = "Liberty Walk NSX", costs = 274000, description = {} },
				{model = "m3e46", name = "BMW M3 GTR", costs = 285000, description = {} },
				-- New pack
				--{model = "tempesta2", name = "6STR Tempesta", costs = 725000, description = {} },
				--{model = "comet6str", name = "6STR Comet", costs = 500000, description = {} },
				{model = "banshee2", name = "Banshee 900R", costs = 254000, description = {} },
				--{model = "revolution6str2", name = "6STR Revolution SR", costs = 550000, description = {} },
				--{model = "skyline", name = "Skyline R34", costs = 500000, description = {} }, 


				{model = "gauntlet6str", name = "6STR Gauntlet", costs = 224000, description = {} },
				{model = "c63", name = "Mercedes C63 AMG", costs = 365000, description = {} },
				{model = "m4", name = "BMW LW M4", costs = 345000, description = {} },
				{model = "rmodmustang", name = "Ford Mustang", costs = 398000, description = {}},
				--{model = "granlb", name = "Maserati Gran Turismo LW", costs = 556000, description = {} },
				{model = "gtr", name = "Nissan GTR RB", costs = 475000, description = {} },
				{model = "s15rb", name = "Nissan S15 Rocket bunny", costs = 285000, description = {} },
				{model = "subwrx", name = "Scooby", costs = 324000, description = {} },
			
				{model = "510", name = "Datson", costs = 184000, description = {} },
				{model = "golfp", name = "Golf", costs = 138000, description = {} },
				{model = "rcf", name = "Lexus", costs = 290000, description = {} },
				{model = "ap2", name = "Honda S2000", costs = 200000, description = {} },
				{model = "dc5", name = "Honda Integra", costs = 255000, description = {} },
				{model = "ar8lb", name = "Audi R8 LW", costs = 450000, description = {} },
				{model = "infernus2custom", name = "Infernus 2", costs = 450000, description = {} },
				{model = "sultanrs", name = "Sultan RS", costs = 420000, description = {} },
				{name = "Aerondight", costs = 550, description = {}, model = "Aerondight"},
				{name = "Cliors", costs = 550, description = {}, model = "Cliors"},
				{name = "Hevo", costs = 550, description = {}, model = "Hevo"},	
				{name = "m6f13t", costs = 550, description = {}, model = "m6f13"},	
				{name = "Rmodf40", costs = 550, description = {}, model = "Rmodf40"},	
				{name = "rmodc63amg", costs = 550, description = {}, model = "rmodc63amg"},	
				{name = "Rmodf40", costs = 550, description = {}, model = "Rmodf40"},	
				{name = "Rmodgt63", costs = 550, description = {}, model = "Rmodgt63"},	
				{name = "rmodgtr50", costs = 550, description = {}, model = "rmodgtr50"},	
				{name = "Rmodjesko", costs = 550, description = {}, model = "Rmodjesko"},	
				{name = "Rmodrover", costs = 550, description = {}, model = "Rmodrover"},	
				{name = "Rmodsianr", costs = 550, description = {}, model = "Rmodsianr"},						
				{name = "Rmodspeed", costs = 550, description = {}, model = "Rmodspeed"},	
				{name = "Victorhirot", costs = 550, description = {}, model = "Victorhirot"},	
				{name = "Gtrnismo17", costs = 550, description = {}, model = "Gtrnismo17"},	
				{name = "hellcatlb", costs = 550, description = {}, model = "hellcatlb"},	
				{name = "lp700", costs = 550, description = {}, model = "lp700"},	
				{name = "Piikesvip4", costs = 550, description = {}, model = "Piikesvip4"},	
				{name = "Piikesvip7", costs = 550, description = {}, model = "Piikesvip7"},	
				{name = "Piikesvip9", costs = 550, description = {}, model = "Piikesvip9"},
				{name = "Piikesvip10", costs = 550, description = {}, model = "Piikesvip10"},
				{name = "Piikesvip16", costs = 550, description = {}, model = "Piikesvip16"},
				{name = "Piikesvip21", costs = 550, description = {}, model = "Piikesvip21"},
				{name = "Piikesvip22", costs = 550, description = {}, model = "Piikesvip22"},
				{name = "Piikesvip23", costs = 550, description = {}, model = "Piikesvip23"},
				{name = "Piikesvip36", costs = 550, description = {}, model = "Piikesvip36"},
			}
		},
		

		["Sold"] = {
			title = "Sold",
			name = "Sold",
			buttons = {
				-- {model = "gauntlet6str", name = "6STR Gauntlet", costs = 450000, description = {} },
				-- {model = "c63", name = "Mercedes C63 AMG", costs = 510000, description = {} },
				-- {model = "m4", name = "BMW LW M4", costs = 401000, description = {} },
				-- {model = "rmodmustang", name = "Ford Mustang", costs = 467500, description = {}},
				-- {model = "granlb", name = "Maserati Gran Turismo LW", costs = 556000, description = {} },
				-- {model = "gtr", name = "Nissan GTR RB", costs = 550000, description = {} },
				-- {model = "s15rb", name = "Nissan S15 Rocket bunny", costs = 340000, description = {} }
			}
		},
	}
}

local fakecar = {model = '', car = nil}
local vehshop_locations = {
	{
		entering = { 920.73, -949.92, 39.23, 119.9 },
		inside = {944.54, -978.62, 39.51, 187.47}, 
		outside = {944.54, -978.62, 39.51, 187.47},
		browsing = { 911.38, -967.77, 39.51, 265.04},
	}
}

local carspawns = {
	[1] =  { ["x"] = 959.78, ["y"] = -953.044, ["z"] = 39.5, ["h"] = 93.919,  ['info'] = ' car1' },
	[2] =  { ["x"] = 959.499, ["y"] = -947.756, ["z"] = 39.5, ["h"] = 93.052, ['info'] = ' car2' },
	[3] =  { ["x"] = 959.227, ["y"] = -942.683, ["z"] = 39.5, ["h"] = 90.917, ['info'] = ' car3' },
	[4] =  { ["x"] = 954.544, ["y"] = -935.905, ["z"] = 39.5, ["h"] = 180.777,['info'] = ' car4' },
	[5] =  { ["x"] = 950.2, ["y"] = -935.937, ["z"] = 39.5, ["h"] = 181.372,  ['info'] = ' car5' },
	[6] =  { ["x"] = 946.002, ["y"] = -936.36, ["z"] = 39.5, ["h"] = 183.908, ['info'] = ' car6' },
	[7] =  { ["x"] = 941.926, ["y"] = -936.492, ["z"] = 39.5, ["h"] = 183.107,['info'] = ' car7'  },
}

local carTable = {
	[1] = { ["model"] = "gauntlet", ["baseprice"] = 100000, ["commission"] = 15 }, 
	[2] = { ["model"] = "dubsta3", ["baseprice"] = 100000, ["commission"] = 15 },
	[3] = { ["model"] = "landstalker", ["baseprice"] = 100000, ["commission"] = 15 },
	[4] = { ["model"] = "bobcatxl", ["baseprice"] = 100000, ["commission"] = 15 },
	[5] = { ["model"] = "surfer", ["baseprice"] = 100000, ["commission"] = 15 },
	[6] = { ["model"] = "glendale", ["baseprice"] = 100000, ["commission"] = 15 },
	[7] = { ["model"] = "washington", ["baseprice"] = 100000, ["commission"] = 15 },
}

--[6] = { ["name"] = "Sultan RS MK2", ["model"] = "sultanrsv8", ["baseprice"] = 250000, ["commission"] = 25 }, 

function updateCarTable(model,price,name)
	carTable[currentCarSpawnLocation]["model"] = model
	carTable[currentCarSpawnLocation]["baseprice"] = price
	carTable[currentCarSpawnLocation]["name"] = name
	TriggerServerEvent("carshop_tuner:table",carTable)
end

local myspawnedvehs = {}

RegisterNetEvent("car:testdrive_tuner")
AddEventHandler("car:testdrive_tuner", function()
	if job ~= 'tuner' or #(vector3(carSafeSpawn["x"],carSafeSpawn["y"],carSafeSpawn["z"]) - GetEntityCoords(PlayerPedId())) > 60.0 then
		return
	end

	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		exports['mythic_notify']:DoLongHudText('inform', 'Could not locate vehicle')
		return
	end
	
	local model = GetEntityModel(veh)
	local veh = GetClosestVehicle(carSafeSpawn["x"],carSafeSpawn["y"],carSafeSpawn["z"], 3.000, 0, 70)

	if not DoesEntityExist(veh) then

		local modelwait = 1
		RequestModel(model)
		while not HasModelLoaded(model) and modelwait < 100 do
			Citizen.Wait(100)
			modelwait = modelwait + 1
		end
		if modelwait > 100 then
			CloseCreator()
			return
		end

		local veh = CreateVehicle(model,carSafeSpawn["x"],carSafeSpawn["y"],carSafeSpawn["z"],carSafeSpawn["h"],true,false)
		local vehplate = "CAR"..math.random(10000,99999) 
		SetVehicleNumberPlateText(veh, vehplate)
		Citizen.Wait(100)
		TriggerEvent("ARPF:spawn:recivekeys",veh,vehplate)
		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)
		SetEntityAsMissionEntity(veh,false,true)
		TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)
		myspawnedvehs[veh] = true
	else
		exports['mythic_notify']:DoLongHudText('inform', 'A car is on the spawn point.')
	end
end)

RegisterNetEvent("finance_tuner")
AddEventHandler("finance_tuner", function()
	if job ~= 'tuner' or #(vector3(carSafeSpawn["x"],carSafeSpawn["y"],carSafeSpawn["z"]) - GetEntityCoords(PlayerPedId())) > 60.0 then
		return
	end
	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		exports['mythic_notify']:DoLongHudText('inform', 'Could not locate vehicle')
		return
	end
	local vehplate = GetVehicleNumberPlateText(veh)
	TriggerServerEvent("finance_tuner:enable",vehplate)
end)

RegisterNetEvent("tuner:enable_buy")
AddEventHandler("tuner:enable_buy", function()
	if job ~= 'tuner' or #(vector3(carSafeSpawn["x"],carSafeSpawn["y"],carSafeSpawn["z"]) - GetEntityCoords(PlayerPedId())) > 60.0 then
		return
	end
	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		exports['mythic_notify']:DoLongHudText('inform', 'Could not locate vehicle')
		return
	end
	local vehplate = GetVehicleNumberPlateText(veh)
	TriggerServerEvent("tuner:buyEnable",vehplate)
end)

RegisterNetEvent("finance_tuner:enableOnClient")
AddEventHandler("finance_tuner:enableOnClient", function(addplate, employee)
	seller = employee
	financedPlates[addplate] = true
	Citizen.Wait(30000)
	financedPlates[addplate] = nil
	seller = nil
end)

RegisterNetEvent("tuner:enableBuyOnClient")
AddEventHandler("tuner:enableBuyOnClient", function(addplate, employee)
	seller = employee
	buyPlates[addplate] = true
	Citizen.Wait(30000)
	buyPlates[addplate] = nil
	seller = nil
end)

RegisterNetEvent("commission_tuner")
AddEventHandler("commission_tuner", function(newAmount)
	if job ~= 'tuner' or #(vector3(carSafeSpawn["x"],carSafeSpawn["y"],carSafeSpawn["z"]) - GetEntityCoords(PlayerPedId())) > 60.0 then
		return
	end
	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			carTable[i]["commission"] = tonumber(newAmount)
			TriggerServerEvent("carshop_tuner:table",carTable)
		end
	end
end)

RegisterNetEvent('tuner:refreshDisplay')
AddEventHandler('tuner:refreshDisplay', function()
	DespawnSaleVehicles()
	Wait(1500)
	SpawnSaleVehicles()
end)

RegisterNetEvent("veh_shop_tuner:returnTable")
AddEventHandler("veh_shop_tuner:returnTable", function(newTable)
	carTable = newTable
	DespawnSaleVehicles()
	SpawnSaleVehicles()
end)

local hasspawned = false

local spawnedvehicles = {}
local vehicles_spawned = false

function BuyMenu()
	for i = 1, #carspawns do
		local veh = GetClosestVehicle(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], 3.000, 0, 70)
		local addplate = GetVehicleNumberPlateText(veh)
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 1.5 then
			if GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= nil and GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= 0 then
				ClearPedTasksImmediately(PlayerPedId())
			end
			DisableControlAction(0,23)
			if IsControlJustReleased(0,47) and buyPlates[addplate] ~= nil then
				exports["mythic_notify"]:DoLongHudText('inform', 'Attempting Purchase')
				AttemptBuy(i,false)
			end

			if IsControlJustReleased(0,23) or IsDisabledControlJustReleased(0,23) then
				local veh = GetClosestVehicle(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], 3.000, 0, 70)
				local addplate = GetVehicleNumberPlateText(veh)
				if financedPlates[addplate] ~= nil then
					exports['mythic_notify']:DoLongHudText('inform', 'Attempting Purchase')
					AttemptBuy(i,true)
				end
			end
		end
	end
end

function AttemptBuy(tableid,financed)

	local veh = GetClosestVehicle(carspawns[tableid]["x"],carspawns[tableid]["y"],carspawns[tableid]["z"], 3.000, 0, 70)

	if not DoesEntityExist(veh) then
		exports["mythic_notify"]:DoLongHudText('error', 'Could not locate vehicle')
		return
	end

	if financed then
		print("financed")
	end

	local model = carTable[tableid]["model"]
	local commission = carTable[tableid]["commission"]
	local baseprice = carTable[tableid]["baseprice"]
	local name = carTable[tableid]["name"]
	local price = baseprice + (baseprice * commission/100)

	currentlocation = vehshop_blips[1]
	TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)
	TriggerServerEvent('tuner:CheckMoneyForVeh',name, model, price, financed, commission)
	commissionbuy = (baseprice * commission / 100)
end


function OwnerMenu()
	if not vehshop.opened then
		currentCarSpawnLocation = 0
		ownerMenu = false
	end
	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			ownerMenu = true
			currentCarSpawnLocation = i
			if IsControlJustReleased(0,38) then
				exports['mythic_notify']:DoLongHudText('inform', 'We Opened')
				if vehshop.opened then
					CloseCreator()
				else
					OpenCreator()
				end
			end
		end
	end
end

function DrawPrices()
	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			local commission = carTable[i]["commission"]
			local baseprice = carTable[i]["baseprice"]
			local price = baseprice + (baseprice * commission/100)
			local veh = GetClosestVehicle(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], 3.000, 0, 70)
			local addplate = GetVehicleNumberPlateText(veh)
			if job == 'tuner' then
				if financedPlates[addplate] ~= nil and buyPlates[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " | Com: %" ..commission.. " | [E] to change | [G] to buy | [F] to Finance ")
				elseif financedPlates[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " | Com: %" ..commission.. " | [E] to change | [F] to Finance ")
				elseif buyPlates[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " | Com: %" ..commission.. " | [E] to change | [G] to buy. ")
				else
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " | Com: %" ..commission.. " | [E] to change")
				end
			else
				if financedPlates[addplate] ~= nil and buyPlates[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " [G] to buy | $" .. math.ceil(price/4) .. " upfront, $" .. math.ceil(price) .. " over 10 weeks, [F] to finance. ")
				elseif financedPlates[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], "$" .. math.ceil(price/4) .. " upfront, $" .. math.ceil(price) .. " over 10 weeks, [F] to finance. ")
				elseif buyPlates[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " [G] to buy. ")
				else
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"Buy Price: $" .. math.ceil(price) .. " ")
				end
			end
		end
	end
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

function SpawnSaleVehicles()
	if started then 
		return
	end
	started = true
	if not hasspawned then
		TriggerServerEvent("carshop_tuner:requesttable")
		print("requesting table")
		--Citizen.Wait(1500)
	end
	DespawnSaleVehicles()
	vehicles_spawned = true
	hasspawned = true
	Citizen.Wait(1500)
	spawnedvehicles = {}
	for i = 1, #carTable do
		local model = GetHashKey(carTable[i]["model"])
		local modelwait = 1

		RequestModel(model)
		while not HasModelLoaded(model) and modelwait < 100 do
			Citizen.Wait(100)
			modelwait = modelwait + 1
		end

		if modelwait > 100 then
			DespawnSaleVehicles()
			exports['mythic_notify']:DoLongHudText('inform', 'Vehicles failed to load, please be patient')
			Wait(10000)
			return
		end

		local veh = CreateVehicle(model,carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]-1,carspawns[i]["h"],false,false)
		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)
		SetEntityInvincible(veh,true)
		SetEntityAsMissionEntity(veh,false,true)
		FreezeEntityPosition(veh,true)
		spawnedvehicles[#spawnedvehicles+1] = veh
		for i = 0,24 do
			SetVehicleModKit(veh,0)
			RemoveVehicleMod(veh,i)
		end
		SetVehicleNumberPlateText(veh, i .. "TUNER")
	end
	started = false
end

function DespawnSaleVehicles()
	for i = 1, #spawnedvehicles do
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(spawnedvehicles[i]))
	end
	spawnedvehicles = {}
	vehicles_spawned = false
	called = false
end

--[[Functions]]--

function LocalPed()
	return PlayerPedId()
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function IsPlayerInRangeOfVehshop()
	return inrangeofvehshop
end

function ShowVehshopBlips(bool)
	if bool and #vehshop_blips == 0 then
		for station,pos in pairs(vehshop_locations) do
			local loc = pos
			pos = pos.entering
			local blip = AddBlipForCoord(946.42, -990.2, 39.21)
			-- 60 58 137
			SetBlipSprite(blip,326)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Tuner Shop')
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip,true)
			SetBlipAsMissionCreatorBlip(blip,true)
			SetBlipScale(blip, 0.8)
			SetBlipColour(blip, 3)
			vehshop_blips[#vehshop_blips+1]= {blip = blip, pos = loc}
		end
		Citizen.CreateThread(function()
			while #vehshop_blips > 0 do
				local inrange = false
				local inrangereturn = false
				Citizen.Wait(0)
				if #(vector3(carSafeSpawn["x"],carSafeSpawn["y"],carSafeSpawn["z"]) - GetEntityCoords(LocalPed())) < 5.0 then
					local veh = GetVehiclePedIsUsing(LocalPed())
					if myspawnedvehs[veh] ~= nil then
						DrawText3D(carSafeSpawn["x"],carSafeSpawn["y"],carSafeSpawn["z"],"["..Controlkey["generalUse"][2].."] return vehicle")
						inrangereturn = true
						if IsControlJustReleased(0,Controlkey["generalUse"][1]) then
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
						end
					end
				end

				for i,b in ipairs(vehshop_blips) do
					if #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) < 50 then
						currentlocation = b
						if not vehicles_spawned then
							if not called then
								called = true
								print("Spawning Display Vehicles?")
								SpawnSaleVehicles()
								Citizen.Wait(500)
							end
						end
						if #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) < 40 then
							DrawPrices()
						end
						DrawMarker(27,b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,50,0,0,0,0)
						if vehshop.opened == false and IsPedInAnyVehicle(LocalPed(), true) == false and #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) < 1 then
							inrange = true
						end
						if vehshop.opened == true then
							DisplayHelpText('~b~E~s~ or ~b~Enter~s~ Accepts ~b~Arrows~s~ Move ~b~Backspace~s~ Exit')
						end
						if job == 'tuner' then
							OwnerMenu()
						end
						BuyMenu()
					else
						if vehicles_spawned then
							DespawnSaleVehicles()
						end
						if not inrangereturn then
							Citizen.Wait(1000)
						end
					end
				end
				inrangeofvehshop = inrange
			end
		end)
	elseif bool == false and #vehshop_blips > 0 then
		for i,b in ipairs(vehshop_blips) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		vehshop_blips = {}
	end
end

function f(n)
	return n + 0.0001
end

function try(f, catch_f)
	local status, exception = pcall(f)
	if not status then
		catch_f(exception)
	end
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function OpenCreator()
	boughtcar = false
	
	if ownerMenu then
		vehshop = vehshopOwner
	else
		return
	end

	local ped = LocalPed()
	local pos = carBrowserLocation
	FreezeEntityPosition(ped,true)
	SetEntityVisible(ped,false)
	local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,carBrowserLocation.x,carBrowserLocation.y,carBrowserLocation.z,Citizen.PointerValueFloat(),0)
	SetEntityCoords(ped,carBrowserLocation.x,carBrowserLocation.y,g)
	SetEntityHeading(ped,carBrowserLocation.h)

	vehshop.currentmenu = "main"
	vehshop.opened = true
	vehshop.selectedbutton = 0
end

function CloseCreator(name, veh, price, financed, curCom)
	Citizen.CreateThread(function()
		local ped = LocalPed()
		local pPrice = price
		if not boughtcar then
			local pos = currentlocation.pos.entering
			SetEntityCoords(ped,pos[1],pos[2],pos[3])
			FreezeEntityPosition(ped,false)
			SetEntityVisible(ped,true)
		else
			local name = name
			local vehicle = veh
			local price = price
			local veh = GetVehiclePedIsUsing(ped)
			local model = GetEntityModel(veh)
			local colors = table.pack(GetVehicleColours(veh))
			local extra_colors = table.pack(GetVehicleExtraColours(veh))

			local mods = {}
			for i = 0,24 do
				mods[i] = GetVehicleMod(veh,i)
			end
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
			local pos = currentlocation.pos.outside

			FreezeEntityPosition(ped,false)
			RequestModel(model)
			while not HasModelLoaded(model) do
				Citizen.Wait(0)
			end

			personalvehicle = CreateVehicle(model,pos[1],pos[2],pos[3],pos[4],true,false)
			SetModelAsNoLongerNeeded(model)

			for i,mod in pairs(mods) do
				SetVehicleModKit(personalvehicle,0)
				SetVehicleMod(personalvehicle,i,mod)
			end

			SetVehicleOnGroundProperly(personalvehicle)

			local plate = GetVehicleNumberPlateText(personalvehicle)
			TriggerEvent("ARPF:spawn:recivekeys",personalvehicle,plate)

			SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
			local id = NetworkGetNetworkIdFromEntity(personalvehicle)
			SetNetworkIdCanMigrate(id, true)
			Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(personalvehicle))
			SetVehicleColours(personalvehicle,colors[1],colors[2])
			SetVehicleExtraColours(personalvehicle,extra_colors[1],extra_colors[2])
			TaskWarpPedIntoVehicle(PlayerPedId(),personalvehicle,-1)
			SetEntityVisible(ped,true)

			local vehProps = ESX.Game.GetVehicleProperties(personalvehicle)
			TriggerServerEvent('tuner:BuyForVeh', vehProps, name, vehicle, pPrice, financed, seller, curCom, commissionbuy)
			TriggerServerEvent("garages:CheckGarageForVeh")
			DespawnSaleVehicles()
			SpawnSaleVehicles()
		end
		vehshop.opened = false
		vehshop.menu.from = 1
		vehshop.menu.to = 10
	end)
end

RegisterNetEvent("carshop_tuner:failedpurchase")
AddEventHandler("carshop_tuner:failedpurchase", function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	TaskLeaveVehicle(PlayerPedId(),veh,0)
end)

RegisterNetEvent("veh_shop_tuner:setPlate")
AddEventHandler("veh_shop_tuner:setPlate", function(vehicle, plate)

	SetVehicleNumberPlateText(vehicle, plate)
	TriggerEvent("keys:addNew", vehicle, plate)

	TriggerServerEvent('garages:SetVehOut', vehicle, plate)
	TriggerServerEvent('veh.getVehicles', plate, vehicle)
	TriggerServerEvent("garages:CheckGarageForVeh")

	local plt = GetVehicleNumberPlateText(vehicle)
	TriggerServerEvent("request:illegal:upgrades",plate)
end)

function drawMenuButton(button,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,51,122,181,220)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function drawMenuInfo(text)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawRect(0.675, 0.95,0.65,0.050,0,0,0,250)
	DrawText(0.255, 0.254)
end

function drawMenuRight(txt,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.2, 0.2)
	--SetTextRightJustify(1)
	if selected then
		SetTextColour(250,250,250, 255)
	else
		SetTextColour(0, 0, 0, 255)
	end
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 + 0.025, y - menu.height/3 + 0.0002)

	if selected then
		DrawRect(x + menu.width/2 + 0.025, y,menu.width / 3,menu.height,51,122,181,250)
	else
		DrawRect(x + menu.width/2 + 0.025, y,menu.width / 3,menu.height,255, 255, 255,250) 
	end
end

function drawMenuTitle(txt,x,y)
	local menu = vehshop.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)

	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,250)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

function ButtonSelected(button)
	local ped = PlayerPedId()
	local this = vehshop.currentmenu
	local btn = button.name
	if this == "main" then
		if btn == "Vehicles" then
			OpenMenu('vehicles')
		end
	elseif this == "vehicles" then
		if btn == "Sports" then
			OpenMenu('Sports')
		elseif btn == "Drift" then
			OpenMenu('Drift')
		elseif btn == "Sold" then
			OpenMenu('Sold')
		end
	elseif this == "jobvehicles" or this == "Drift" or this == "Sports" then
		if ownerMenu then
			updateCarTable(button.model,button.costs,button.name)
		else
			TriggerServerEvent('tuner:CheckMoneyForVeh',button.name, button.model, button.costs)
		end
	end
end

function OpenMenu(menu)
	fakecar = {model = '', car = nil}
	vehshop.lastmenu = vehshop.currentmenu
	if menu == "vehicles" then
		vehshop.lastmenu = "main"
	elseif menu == "bikes"  then
		vehshop.lastmenu = "main"
	elseif menu == 'race_create_objects' then
		vehshop.lastmenu = "main"
	elseif menu == "race_create_objects_spawn" then
		vehshop.lastmenu = "race_create_objects"
	end
	vehshop.menu.from = 1
	vehshop.menu.to = 10
	vehshop.selectedbutton = 0
	vehshop.currentmenu = menu
end

function Back()
	if backlock then
		return
	end
	backlock = true
	if vehshop.currentmenu == "main" then
		CloseCreator()
	elseif vehshop.currentmenu == "jobvehicles" or vehshop.currentmenu == "Drift"  or vehshop.currentmenu == "Sold" or vehshop.currentmenu == "Sports"then
		if DoesEntityExist(fakecar.car) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
		end
		fakecar = {model = '', car = nil}
		OpenMenu(vehshop.lastmenu)
	else
		OpenMenu(vehshop.lastmenu)
	end
end

Controlkey = {["generalUse"] = {38,"E"},["generalUseSecondary"] = {18,"Enter"}} 

Citizen.CreateThread(function()
	local modelTimer = 0
	while true do
		if IsPlayerInRangeOfVehshop() or vehshop.opened then
			Citizen.Wait(0)
		else
			Citizen.Wait(500)
		end
		if (IsControlJustPressed(1,Controlkey["generalUse"][1]) or IsControlJustPressed(1, Controlkey["generalUseSecondary"][1])) and IsPlayerInRangeOfVehshop() then
			if vehshop.opened then
				CloseCreator()
			else
				OpenCreator()
			end
		end
		if vehshop.opened then
			local ped = LocalPed()
			local menu = vehshop.menu[vehshop.currentmenu]
			local y = vehshop.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false
			for i,button in pairs(menu.buttons) do
				--local br = button.rank ~= nil and button.rank or 0
				if job == 'tuner' and i >= vehshop.menu.from and i <= vehshop.menu.to then
					if i == vehshop.selectedbutton then
						selected = true
					else
						selected = false
					end
					drawMenuButton(button,vehshop.menu.x,y,selected)

					if button.costs ~= nil then
						drawMenuRight("$"..button.costs,vehshop.menu.x,y,selected)
					end

					y = y + 0.04
					if vehshop.currentmenu == "jobvehicles" or vehshop.currentmenu == "Drift" or vehshop.currentmenu == "Sold" or vehshop.currentmenu == "Sports" then
						if selected then
							if fakecar.model ~= button.model then
								if DoesEntityExist(fakecar.car) then
									Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
								end

								local pos = currentlocation.pos.inside
								local hash = GetHashKey(button.model)

								RequestModel(hash)
								while not HasModelLoaded(hash) do
									Citizen.Wait(0)
								end
								local veh = CreateVehicle(hash,pos[1],pos[2],pos[3],pos[4],false,false)
								SetModelAsNoLongerNeeded(hash)
								local timer = 9000
								while not DoesEntityExist(veh) and timer > 0 do
									timer = timer - 1
								end
								FreezeEntityPosition(veh,true)
								SetEntityInvincible(veh,true)
								SetVehicleDoorsLocked(veh,4)
								--SetEntityCollision(veh,false,false)
								TaskWarpPedIntoVehicle(LocalPed(),veh,-1)
								for i = 0,24 do
									SetVehicleModKit(veh,0)
									RemoveVehicleMod(veh,i)
								end
								fakecar = { model = button.model, car = veh}
								local topspeed = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel') / 2)
								local handling = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock') * 2)
								local braking = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce') * 100)
								local accel = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce') * 100) 
								if button.model == "rumpo" then
									SetVehicleLivery(veh,2)
								end
							end
						end
					end
					if selected and ( IsControlJustPressed(1,Controlkey["generalUse"][1]) or IsControlJustPressed(1, Controlkey["generalUseSecondary"][1])  ) then
						ButtonSelected(button)
					end
				end
			end

			if DoesEntityExist(fakecar.car) then
				if vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
					daz = 6.0
					if fakecar.model == "Chimera" then
						daz = 8.0
					end
					if fakecar.model == "bmx" then
						daz = 8.0
					end
					x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 3.0, -1.5, daz))
					Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x,y,z, 0.0, 180.0, 100.0, 1.0, 1.0, 1.0, 7.0, 7.0, 7.0, 0)
				else
					x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 3.0, -1.5, 10.0))
					Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x,y,z, 0.0, 180.0, 100.0, 1.0, 1.0, 1.0, 10.0, 10.0, 10.0, 0)		
				end
				TaskWarpPedIntoVehicle(LocalPed(),fakecar.car,-1)
			end
		end
		if vehshop.opened then
			if IsControlJustPressed(1,202) then
				Back()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				if vehshop.selectedbutton > 1 then
					vehshop.selectedbutton = vehshop.selectedbutton -1
					if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
						vehshop.menu.from = vehshop.menu.from -1
						vehshop.menu.to = vehshop.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				if vehshop.selectedbutton < buttoncount then
					vehshop.selectedbutton = vehshop.selectedbutton +1
					if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
						vehshop.menu.to = vehshop.menu.to + 1
						vehshop.menu.from = vehshop.menu.from + 1
					end
				end
			end
		end
	end
end)

AddEventHandler('tuner:FinishMoneyCheckForVeh', function(name, vehicle, price,financed, commission)
	local name = name
	local vehicle = vehicle
	local price = price
	boughtcar = true
	CloseCreator(name, vehicle, price,financed, commission)
end)

AddEventHandler('tuner:spawnVehicle', function(v)
	local car = GetHashKey(v)
	local playerPed = PlayerPedId()
	if playerPed and playerPed ~= -1 then
		RequestModel(car)

		local modelwait = 1
		while not HasModelLoaded(car) and modelwait < 100 do
			Citizen.Wait(100)
			modelwait = modelwait + 1
		end

		if modelwait > 100 then
			CloseCreator()
			return
		end

		local playerCoords = GetEntityCoords(playerPed)
		veh = CreateVehicle(car, playerCoords, 0.0, true, false)
		SetModelAsNoLongerNeeded(car)
		TaskWarpPedIntoVehicle(playerPed, veh, -1)
		SetEntityInvincible(veh, true)
	end
end)
ShowVehshopBlips(true)

AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		ShowVehshopBlips(true)
		firstspawn = 1
	end
end)

RegisterNetEvent('nadrp:playerBecameJob')
AddEventHandler('nadrp:playerBecameJob', function(jobpassed)
	job = jobpassed.name
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then 
		DespawnSaleVehicles()
	end
end)