ESX = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('bikeshop:FinishMoneyCheckForVeh')
RegisterNetEvent('vehshop_bikeshop:spawnVehicle')
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
local carSafeSpawn = { ['x'] = 59.38299, ['y'] = 6481.4233,['z'] = 31.42518, ['h'] = 221.72, ['info'] = ' Test Drive Spawn' }
local job =''
local carBrowserLocation = { ['x'] = 35.97, ['y'] = 6456.1,['z'] = 31.43, ['h'] = 224.32, ['info'] = ' Bike Browser Location' }


function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
local currentCarSpawnLocation = 0
local ownerMenu = false

local vehshopDefault = {
	opened = false,
	title = "Vehicle Shop",
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
				{name = "Cycles", description = ""},
			}
		},
		["cycles"] = {
			title = "cycles",
			name = "cycles",
			buttons = {
				{name = "BMX", costs = 150, description = {}, model = "bmx"},
				{name = "Cruiser", costs = 240, description = {}, model = "cruiser"},
				{name = "Fixter", costs = 270, description = {}, model = "fixter"},
				{name = "Scorcher", costs = 300, description = {}, model = "scorcher"},
				{name = "Pro 1", costs = 1500, description = {}, model = "tribike"},
				{name = "Pro 2", costs = 1600, description = {}, model = "tribike2"},
				{name = "Pro 3", costs = 1750, description = {}, model = "tribike3"},
			}
		},		
	}
}

vehshop = vehshopDefault
local vehshopOwner = {
	opened = false,
	title = "Vehicle Shop",
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
				{name = "motorcycles", description = ""},
				{name = "cycles", description = ""},
			}
		},

		["motorcycles"] = {
			title = "motorcycles",
			name = "motorcycles",
			buttons = {		
				{name = "Akuma", costs = 80000, description = {}, model = "AKUMA"},
				{name = "Bagger", costs = 60000, description = {}, model = "bagger"},
				{name = "Bati 801", costs = 75000, description = {}, model = "bati"},
				{name = "BF400", costs = 72000, description = {}, model = "bf400"},
				{name = "Carbon RS", costs = 75000, description = {}, model = "carbonrs"},
				{name = "Daemon", costs = 45000, description = {}, model = "daemon"},
				{name = "Enduro", costs = 59000, description = {}, model = "enduro"},
				{name = "Faggio", costs = 15000, description = {}, model = "faggio"},
				{name = "Gargoyle", costs = 65000, description = {}, model = "gargoyle"},
				{name = "Hexer", costs = 65000, description = {}, model = "hexer"},
				{name = "Innovation", costs = 75000, description = {}, model = "innovation"},
				{name = "Nemesis", costs = 70000, description = {}, model = "nemesis"},
				{name = "PCJ-600", costs = 75000, description = {}, model = "pcj"},
				{name = "Ruffian", costs = 64000, description = {}, model = "ruffian"},
				{name = "Sanchez", costs = 65000, description = {}, model = "sanchez"},
				{name = "Sovereign", costs = 159000, description = {}, model = "sovereign"},
				{name = "Zombiea", costs = 65000, description = {}, model = "zombiea"},
				{name = "Vespa", costs = 75000, description = {}, model = "faggio2"},
				{name = "Manchez", costs = 77000, description = {}, model = "manchez"},
				{name = "Vortex", costs = 90000, description = {}, model = "vortex"},
				{name = "Avarus", costs = 65000, description = {}, model = "avarus"},
				{name = "Vader", costs = 75000, description = {}, model = "vader"},
				{name = "Esskey", costs = 75000, description = {}, model = "esskey"},
				{name = "Defiler", costs = 95000, description = {}, model = "defiler"},
				{name = "Chimera", costs = 72000, description = {}, model = "chimera"},
				{name = "Daemon", costs = 79000, description = {}, model = "daemon"},
				{name = "DaemonHigh", costs = 85000, description = {}, model = "daemon2"},
				{name = "Nightblade", costs = 80000, description = {}, model = "nightblade"},	
				{name = "Sanctus", costs = 80000, description = {}, model = "sanctus"},	
				{name = "Wolfsbane", costs = 65000, description = {}, model = "wolfsbane"},
				{name = "Hakuchou Drag", costs = 100000, description = {}, model = "hakuchou2"},
				{name = "Fcr1000", costs = 75000, description = {}, model = "fcr2"},
				--{name = "Shotaro", costs = 120000, description = {}, model = "shotaro"},
				{name = "Hakuchou", costs = 80000, description = {}, model = "hakuchou"},
				{name = "Stryder", costs = 95000, description = {}, model = "stryder"},
				{name = "Cliffhanger", costs = 75000, description = {}, model = "cliffhanger"},
				{name = "Diablous 2", costs = 100000, description = {}, model = "diablous2"},
				{name = "Vindicator", costs = 75000, description = {}, model = "vindicator"},
				{name = "Thrust", costs = 65000, description = {}, model = "thrust"},
				{name = "Diablous", costs = 75500, description = {}, model = "diablous"},
				{name = "Lectro", costs = 70000, description = {}, model = "lectro"},
				{name = "Rat Bike", costs = 75000, description = {}, model = "ratbike"},
				{name = "Faggio Mod", costs = 20000, description = {}, model = "faggio3"},
				{name = "Yamaha R1", costs = 200000, description = {}, model = "r1"},--5
				{name = "Yamaha 1700 MAX", costs = 150000, description = {}, model = "Y1700MAX"},--5
				{name = "Harley Davidson", costs = 170000, description = {}, model = "HDIron883"},--5
				{name = "KTM RC390 ", costs = 200000, description = {}, model = "KTMRC39019"},--5
				{name = "Honder CB650R", costs = 200000, description = {}, model = "cb650r"},--5


		
			}
		},
		["cycles"] = {
			title = "cycles",
			name = "cycles",
			buttons = {
				{name = "BMX", costs = 550, description = {}, model = "bmx"},
				{name = "Cruiser", costs = 240, description = {}, model = "cruiser"},
				{name = "Fixter", costs = 270, description = {}, model = "fixter"},
				{name = "Scorcher", costs = 300, description = {}, model = "scorcher"},
				{name = "Pro 1", costs = 1500, description = {}, model = "tribike"},
				{name = "Pro 2", costs = 1600, description = {}, model = "tribike2"},
				{name = "Pro 3", costs = 1900, description = {}, model = "tribike3"},
			}
		},
	}
}

local fakecar = {model = '', bike = nil}
local vehshop_locations = {
	{
		entering = {24.839,6466.347,31.43,224.32},
		inside = {35.97,6456.1,31.43,224.32},
		outside =  {35.97,6456.1,31.43,224.32},
		browsing = {35.97,6456.1,31.43,224.32},
	}
}

local carspawns = {
	[1] =  { ['x'] = 12.49,['y'] = 6463.79,['z'] = 31.43,['h'] = 254.37, ['info'] = ' Car Spot 1' },
	[2] =  { ['x'] = 15.64,['y'] = 6467.17,['z'] = 31.43,['h'] = 197.46, ['info'] = ' Car Spot 2' },
	[3] =  { ['x'] = 15.67,['y'] = 6460.22,['z'] = 31.43,['h'] = 320.35, ['info'] = ' Car Spot 3' },
	[4] =  { ['x'] = 19.87,['y'] = 6464.46,['z'] = 31.43,['h'] = 135.39, ['info'] = ' Car Spot 4' },
	[5] =  { ['x'] = 20.05,['y'] = 6456.08,['z'] = 31.43,['h'] = 313.11, ['info'] = ' Car Spot 5' },
	[6] =  { ['x'] = 23.76,['y'] = 6452.63,['z'] = 31.43,['h'] = 311.29, ['info'] = ' Car Spot 6' },
	[7] =  { ['x'] = 28.02,['y'] = 6448.55,['z'] = 31.43,['h'] = 350.66, ['info'] = ' Car Spot 7' },
}

local carTable = {
	[1] = { ["model"] = "pcj", ["baseprice"] = 75000, ["commission"] = 15 }, 
	[2] = { ["model"] = "AKUMA", ["baseprice"] = 80000, ["commission"] = 15 },
	[3] = { ["model"] = "hexer", ["baseprice"] = 65000, ["commission"] = 15 },
	[4] = { ["model"] = "nemesis", ["baseprice"] = 70000, ["commission"] = 15 },
	[5] = { ["model"] = "manchez", ["baseprice"] = 77000, ["commission"] = 15 },
	[6] = { ["model"] = "defiler", ["baseprice"] = 95000, ["commission"] = 15 },
	[7] = { ["model"] = "sanctus", ["baseprice"] = 80000, ["commission"] = 15 },
}

function updateCarTable(model,price,name)
	carTable[currentCarSpawnLocation]["model"] = model
	carTable[currentCarSpawnLocation]["baseprice"] = price
	carTable[currentCarSpawnLocation]["name"] = name
	TriggerServerEvent("bikeshop:table",carTable)
end

local myspawnedvehs = {}

RegisterNetEvent("bike:testdrive")
AddEventHandler("bike:testdrive", function()
	if job ~= 'bikedealer' or #(vector3(carSafeSpawn["x"],carSafeSpawn["y"],carSafeSpawn["z"]) - GetEntityCoords(PlayerPedId())) > 60.0 then
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
		local vehplate = "BIKE"..math.random(10000,99999) 
		SetVehicleNumberPlateText(veh, vehplate)
		Citizen.Wait(100)
		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)
		SetEntityAsMissionEntity(veh,false,true)
		TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)
		TriggerEvent("ARPF:spawn:recivekeys",veh,GetVehicleNumberPlateText(veh))
		myspawnedvehs[veh] = true
	else
		exports['mythic_notify']:DoLongHudText('inform', 'A bike is on the spawn point.')
	end
end)

RegisterNetEvent("finance_bikeshop")
AddEventHandler("finance_bikeshop", function()
	if job ~= 'bikedealer' or #(vector3(carSafeSpawn["x"],carSafeSpawn["y"],carSafeSpawn["z"]) - GetEntityCoords(PlayerPedId())) > 60.0 then
		print(#(vector3(carSafeSpawn["x"],carSafeSpawn["y"],carSafeSpawn["z"]) - GetEntityCoords(PlayerPedId())))
		return
	end
	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		exports['mythic_notify']:DoLongHudText('inform', 'Could not locate vehicle')
		return
	end
	local vehplate = GetVehicleNumberPlateText(veh)
	TriggerServerEvent("finance_bikeshop:enable",vehplate)
end)

RegisterNetEvent("bikeshop:enable_buy")
AddEventHandler("bikeshop:enable_buy", function()
	if job ~= 'bikedealer' or #(vector3(carSafeSpawn["x"],carSafeSpawn["y"],carSafeSpawn["z"]) - GetEntityCoords(PlayerPedId())) > 60.0 then
		return
	end
	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		exports['mythic_notify']:DoLongHudText('inform', 'Could not locate vehicle')
		return
	end
	local vehplate = GetVehicleNumberPlateText(veh)
	TriggerServerEvent("bikeshop:buyEnable",vehplate)
end)

RegisterNetEvent("finance_bikeshop:enableOnClient")
AddEventHandler("finance_bikeshop:enableOnClient", function(addplate, employee)
	seller = employee
	financedPlates[addplate] = true
	Citizen.Wait(30000)
	financedPlates[addplate] = nil
	seller = nil
end)

RegisterNetEvent("bikeshop:enableBuyOnClient")
AddEventHandler("bikeshop:enableBuyOnClient", function(addplate, employee)
	seller = employee
	buyPlates[addplate] = true
	Citizen.Wait(30000)
	buyPlates[addplate] = nil
	seller = nil
end)

RegisterNetEvent("commission_bikeshop")
AddEventHandler("commission_bikeshop", function(newAmount)
	if job ~= 'bikedealer' then
		return
	end
	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			carTable[i]["commission"] = tonumber(newAmount)
			TriggerServerEvent("bikeshop:table",carTable)
		end
	end
end)

RegisterNetEvent('bikeshop:refreshDisplay')
AddEventHandler('bikeshop:refreshDisplay', function()
	DespawnSaleVehicles()
	Wait(1500)
	SpawnSaleVehicles()
end)

RegisterNetEvent("bikeshop:returnTable")
AddEventHandler("bikeshop:returnTable", function(newTable)
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
	TriggerServerEvent('bikeshop:CheckMoneyForVeh',name, model, price, financed, commission)
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
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 1.5 then
			local commission = carTable[i]["commission"]
			local baseprice = carTable[i]["baseprice"]
			local price = baseprice + (baseprice * commission/100)
			local veh = GetClosestVehicle(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], 3.000, 0, 70)
			local addplate = GetVehicleNumberPlateText(veh)
			if job == 'bikedealer' then
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
		TriggerServerEvent("bikeshop:requesttable")
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
		SetVehicleNumberPlateText(veh, i .. "bikeshop")
	end
	started = false
end

function DespawnSaleVehicles()
	for i = 1, #spawnedvehicles do
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(spawnedvehicles[i]))
	end
	vehicles_spawned = false
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
			local blip = AddBlipForCoord(5.67,6470.47,31.43)
			-- 60 58 137
			SetBlipSprite(blip,326)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Bike Shop')
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip,true)
			SetBlipAsMissionCreatorBlip(blip,true)
			SetBlipScale(blip, 0.8)
			SetBlipColour(blip, 3)
			vehshop_blips[#vehshop_blips+1]= {blip = blip, pos = loc}
		end
		Citizen.CreateThread(function()
			while #vehshop_blips > 0 do
				Citizen.Wait(1)
				local inrange = false
				local inrangereturn = false
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
					if #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) < 60 then
						currentlocation = b
						if not vehicles_spawned then
							SpawnSaleVehicles()
						end
						if #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) < 35 then
							DrawPrices()
						end
						DrawMarker(27,b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,50,0,0,0,0)
						if vehshop.opened == false and IsPedInAnyVehicle(LocalPed(), true) == false and #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) < 1 then		
							inrange = true
						end
						if vehshop.opened == true then
							DisplayHelpText('~b~E~s~ or ~b~Enter~s~ Accepts ~b~Arrows~s~ Move ~b~Backspace~s~ Exit')
						end

						if job == 'bikedealer' then
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
			TriggerServerEvent('bikeshop:BuyForVeh', vehProps, name, vehicle, pPrice, financed, seller, curCom, commissionbuy)
			TriggerServerEvent("garages:CheckGarageForVeh")
			DespawnSaleVehicles()
			SpawnSaleVehicles()
		end
		vehshop.opened = false
		vehshop.menu.from = 1
		vehshop.menu.to = 10
	end)
end

RegisterNetEvent("bikeshop:failedpurchase")
AddEventHandler("bikeshop:failedpurchase", function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	TaskLeaveVehicle(PlayerPedId(),veh,0)
end)

RegisterNetEvent("bikeshop:setPlate")
AddEventHandler("bikeshop:setPlate", function(vehicle, plate)

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
		elseif btn == "motorcycles" then
			OpenMenu('motorcycles')
		elseif btn == "Cycles" then
			OpenMenu('cycles')
		end
	elseif this == "vehicles" then
		if btn == "Sports" then
			OpenMenu('sports')
		elseif btn == "Sedans" then
			OpenMenu('sedans')
		elseif btn == "Job Vehicles" then
			OpenMenu('jobvehicles')
		elseif btn == "Compacts" then
			OpenMenu('compacts')
		elseif btn == "Coupes" then
			OpenMenu('coupes')
		elseif btn == "Sports Classics" then
			OpenMenu("sportsclassics")
		elseif btn == "Super" then
			OpenMenu('super')
		elseif btn == "Muscle" then
			OpenMenu('muscle')
		elseif btn == "Off-Road" then
			OpenMenu('offroad')
		elseif btn == "SUVs" then
			OpenMenu('suvs')
		elseif btn == "Vans" then
			OpenMenu('vans')
		end
	elseif this == "jobvehicles" or this == "cycles" or this == "motorcycles" then
		if ownerMenu then
			updateCarTable(button.model,button.costs,button.name)
		else
			TriggerServerEvent('bikeshop:CheckMoneyForVeh',button.name, button.model, button.costs)
		end
	end
end

function OpenMenu(menu)
	fakecar = {model = '', bike = nil}
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
	elseif vehshop.currentmenu == "jobvehicles" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
		if DoesEntityExist(fakecar.bike) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.bike))
		end
		fakecar = {model = '', bike = nil}
		OpenMenu(vehshop.lastmenu)
	else
		OpenMenu(vehshop.lastmenu)
	end
end

Controlkey = {["generalUse"] = {38,"E"},["generalUseSecondary"] = {18,"Enter"}} 
RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
	Controlkey["generalUse"] = table["generalUse"]
	Controlkey["generalUseSecondary"] = table["generalUseSecondary"]
end)

Citizen.CreateThread(function()
	while true do
		if IsPlayerInRangeOfVehshop() or vehshop.opened then
			Citizen.Wait(0)
		else
			Citizen.Wait(500)
		end
		if vehshop.opened then
			local ped = LocalPed()
			local menu = vehshop.menu[vehshop.currentmenu]
			local y = vehshop.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false
			for i,button in pairs(menu.buttons) do
				if job == 'bikedealer' and i >= vehshop.menu.from and i <= vehshop.menu.to then
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
					if vehshop.currentmenu == "jobvehicles" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
						if selected then
							if fakecar.model ~= button.model then
								if DoesEntityExist(fakecar.bike) then
									Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.bike))
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
									Citizen.Wait(1)
								end
								TriggerEvent("vehsearch:disable",veh)

								FreezeEntityPosition(veh,true)
								SetEntityInvincible(veh,true)
								SetVehicleDoorsLocked(veh,4)
								--SetEntityCollision(veh,false,false)
								TaskWarpPedIntoVehicle(LocalPed(),veh,-1)
								for i = 0,24 do
									SetVehicleModKit(veh,0)
									RemoveVehicleMod(veh,i)
								end
								fakecar = { model = button.model, bike = veh}
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

			if DoesEntityExist(fakecar.bike) then
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
				TaskWarpPedIntoVehicle(LocalPed(),fakecar.bike,-1)
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

AddEventHandler('bikeshop:FinishMoneyCheckForVeh', function(name, vehicle, price,financed, commission)
	local name = name
	local vehicle = vehicle
	local price = price
	boughtcar = true
	CloseCreator(name, vehicle, price,financed, commission)
end)

AddEventHandler('bikeshop:spawnVehicle', function(v)
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
