ESX = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('imports:FinishMoneyCheckForVeh')
RegisterNetEvent('vehshop_imports:spawnVehicle')
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
				{name = "Vehicles", description = ""},
			}
		},

		["vehicles"] = {
			title = "VEHICLES",
			name = "vehicles",
			buttons = {
				{name = "Sports", description = ''},
			}
		},

		["sports"] = {
			title = "sports",
			name = "sports",
			buttons = {
				{name = "Lamborghini Aventador LP700R", costs = 1500000, description = {}, model = "lp700r"},-- 3
                {name = "McLaren P1", costs = 1800000, description = {}, model = "p1"},-- 2
				{name = "Honda Civic EG", costs = 300000, description = {}, model = "delsoleg"},-- 5
			--	{name = "Shelby GT 500", costs = 500000, description = {}, model = "eleanor"},-- 4
				--{name = "NA6", costs = 350000, description = {}, model = "na6"},-- 4
				
				-- pack 2
                {name = "BMW i8", costs = 800000, description = {}, model = "acs8"}, --4


                --{name = "2019 Ford Mustang", costs = 500000, description = {}, model = "mustang19"},--5
                {name = "Yamaha R1", costs = 200000, description = {}, model = "r1"},--5
                {name = "Audi RS6", costs = 575000, description = {}, model = "audirs6tk"},--4
                {name = "Mercedes AMG GT63", costs = 575000, description = {}, model = "gt63"},--3
				{name = "Corvette C7", costs = 600000, description = {}, model = "c7"},--3
				--{name = "GTRC", costs = 800000, description = {}, model = "gtrc"},--3
				
				{name = "HSV", costs = 375000, description = {}, model = "bluecunt"},--4
				{name = "Caddy", costs = 850000, description = {}, model = "esv"},--3
				{name = "Old Mercedes", costs = 300000, description = {}, model = "mbw124"},--4
				{name = "Ferrari Enzo", costs = 2000000, description = {}, model = "mig"},--2
				{name = "Rolls Royce", costs = 1000000, description = {}, model = "wraith"},--3
				{name = "z2879 Muscle", costs = 425000, description = {}, model = "z2879"},--4
				{name = "Volvo", costs = 350000, description = {}, model = "v242"},--4

				-- {name = "S14 RB Boss", costs = 650000, description = {}, model = "s14boss"},
				{name = "Honda Civic Type-R FK8", costs = 350000, description = {}, model = "fk8"},--5
				{name = "Ford Focus RS", costs = 400000, description = {}, model = "focusrs"},--5
				{name = "Jeep Grand Cherokee SRT8", costs = 450000, description = {}, model = "srt8b"},--5
				{name = "Porsche Panamera Turbo", costs = 700000, description = {}, model = "panamera17turbo"},--4
				{name = "Camaro ZL1", costs = 550000, description = {}, model = "exor"},--5
				{name = "Ferrari LaFerrari", costs = 2000000, description = {}, model = "laferrari17"},--2
				{name = "Bentley Continental", costs = 650000, description = {}, model = "contss18"},--3
				--{name = "Koenigsegg Regera", costs = 1300000, description = {}, model = "regera"},--
				--{name = "Porsche 918", costs = 1900000, description = {}, model = "918"},--

				--Vanilla Supers

				{name = "Autarch", costs = 650000, description = {}, model = "autarch"},--3
				{name = "FMJ", costs = 750000, description = {}, model = "fmj"},--3
				{name = "Entity 2", costs = 900000, description = {}, model = "entity2"},--3
				{name = "Itali GTB", costs = 650000, description = {}, model = "italigtb"},--3
				{name = "Nero", costs = 1200000, description = {}, model = "nero"},--3
				{name = "Osiris", costs = 800000, description = {}, model = "osiris"},--3
				{name = "Proto", costs = 1400000, description = {}, model = "prototipo"},--3
				{name = "T20", costs = 1000000, description = {}, model = "t20"},--3
				{name = "Tempesta", costs = 850000, description = {}, model = "tempesta"},--3
				{name = "Emerus", costs = 1100000, description = {}, model = "emerus"},--3
				{name = "Krieger", costs = 950000, description = {}, model = "krieger"},--3
				{name = "Thrax", costs = 1350000, description = {}, model = "thrax"},--3
				{name = "Furia", costs = 850000, description = {}, model = "furia"},--3



			}
		},
	}
}

local fakecar = {model = '', car = nil}
local vehshop_locations = {
	[1] = {
		entering = {-794.29,-218.86,36.38, 140.92509460449}, 
		inside = {-799.0,-221.02,36.9, 173.97}, 
		outside = {-789.3,-196.07, 37.1, 298.95}, 
	}
}


local carspawns = {
	[1] = { ['x'] = -787.03,['y'] = -243.37,['z'] = 36.32,['h'] = 85.14},
	[2] = { ['x'] = -790.26,['y'] = -237.81,['z'] = 36.32,['h'] = 95.3},
	[3] = { ['x'] = -792.6,['y'] = -233.09,['z'] = 36.32,['h'] = 100.49},
	[4] = { ['x'] = -795.7,['y'] = -228.24,['z'] = 36.32,['h'] = 94.29},
	[5] = { ['x'] = -783.25,['y'] = -223.68,['z'] = 36.56,['h'] = 171.93},
	
}

local carTable = {
	[1] = { ["model"] = "prototipo", ["baseprice"] = 1400000, ["commission"] = 15 }, 
	[2] = { ["model"] = "thrax", ["baseprice"] = 1350000, ["commission"] = 15 },
	[3] = { ["model"] = "p1", ["baseprice"] = 1800000, ["commission"] = 15 },
	[4] = { ["model"] = "lp700r", ["baseprice"] = 1500000, ["commission"] = 15 },
	[5] = { ["model"] = "laferrari17", ["baseprice"] = 2000000, ["commission"] = 15 },
}

function updateCarTable(model,price,name)
	carTable[currentCarSpawnLocation]["model"] = model
	carTable[currentCarSpawnLocation]["baseprice"] = price
	carTable[currentCarSpawnLocation]["name"] = name
	TriggerServerEvent("carshop_imports:table",carTable)
end

local myspawnedvehs = {}

RegisterNetEvent("car:imports:testdrive")
AddEventHandler("car:imports:testdrive", function()
	if job ~= 'cardealer' or GetDistanceBetweenCoords(-794.29,-218.86,36.38,GetEntityCoords(GetPlayerPed(-1))) > 50.0 then
		return
	end

	local veh = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		exports['mythic_notify']:SendAlert('error', 'Could not locate vehicle')
		return
	end

	local model = GetEntityModel(veh)
	local veh = GetClosestVehicle(-794.29,-218.86,36.38, 3.000, 0, 70)

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
		local veh = CreateVehicle(model,-789.3,-196.07, 37.1, 298.95,true,false)
		local vehplate = "CAR"..math.random(10000,99999) 
		SetVehicleNumberPlateText(veh, vehplate)
		Citizen.Wait(100)
		TriggerEvent("ARPF:spawn:recivekeys", veh,vehplate)
		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)
		SetEntityAsMissionEntity(veh,false,true)
		TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
		myspawnedvehs[veh] = true
	else
		exports['mythic_notify']:SendAlert('error', 'A car is on the spawn point.')
	end
end)

RegisterNetEvent("imports:finance")
AddEventHandler("imports:finance", function()
	if job ~= 'cardealer' or GetDistanceBetweenCoords(-794.29,-218.86,36.38,GetEntityCoords(GetPlayerPed(-1))) > 50.0 then
		return
	end
	local veh = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		exports['mythic_notify']:SendAlert('error', 'Could not locate vehicle')
		return
	end
	local vehplate = GetVehicleNumberPlateText(veh)
	TriggerServerEvent("finance_imports:enable",vehplate)
end)

RegisterNetEvent("imports:buyEnable")
AddEventHandler("imports:buyEnable", function()
	if job ~= 'cardealer' or GetDistanceBetweenCoords(-794.29,-218.86,36.38,GetEntityCoords(GetPlayerPed(-1))) > 50.0 then
		return
	end
	local veh = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		exports['mythic_notify']:SendAlert('error', 'Could not locate vehicle')
		return
	end
	local vehplate = GetVehicleNumberPlateText(veh)
	TriggerServerEvent("imports:buyEnable",vehplate)
end)

RegisterNetEvent("finance_imports:enableOnClient")
AddEventHandler("finance_imports:enableOnClient", function(addplate)
	financedPlates[addplate] = true
	Citizen.Wait(60000)
	financedPlates[addplate] = nil
end)	

RegisterNetEvent("finance_imports:enableBuyOnClient")
AddEventHandler("finance_imports:enableBuyOnClient", function(addplate)
	buyPlates[addplate] = true
	Citizen.Wait(60000)
	buyPlates[addplate] = nil
end)

RegisterNetEvent("imports:commission")
AddEventHandler("imports:commission", function(newAmount)
	if job ~= 'cardealer' or GetDistanceBetweenCoords(-794.29,-218.86,36.38,GetEntityCoords(GetPlayerPed(-1))) > 50.0 then
		return
	end
	for i = 1, #carspawns do
		if GetDistanceBetweenCoords(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], GetEntityCoords(GetPlayerPed(-1)) ) < 2.0 then
			carTable[i]["commission"] = tonumber(newAmount)
			TriggerServerEvent("carshop_imports:table",carTable)
		end
	end
end)

RegisterNetEvent("veh_shop_imports:returnTable")
AddEventHandler("veh_shop_imports:returnTable", function(newTable)
	carTable = newTable
	DespawnSaleVehicles()
	SpawnSaleVehicles()
end)

local hasspawned = false

local spawnedvehicles = {}
local vehicles_spawned = false
function BuyMenu()
	for i = 1, #carspawns do

		if GetDistanceBetweenCoords(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], GetEntityCoords(GetPlayerPed(-1)) ) < 2.0 then
			if GetVehiclePedIsTryingToEnter(GetPlayerPed(-1)) ~= nil and GetVehiclePedIsTryingToEnter(GetPlayerPed(-1)) ~= 0 then
				ClearPedTasksImmediately(GetPlayerPed(-1))
			end
			DisableControlAction(0,23)
			local veh = GetClosestVehicle(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], 3.000, 0, 70)
			local addplate = GetVehicleNumberPlateText(veh)
			if IsControlJustReleased(0,47) and buyPlates[addplate] ~= nil then
				exports["mythic_notify"]:SendAlert('inform', 'Attempting Purchase')
				AttemptBuy(i,false)
			end

			if IsControlJustReleased(0,23) or IsDisabledControlJustReleased(0,23) then
				if financedPlates[addplate] ~= nil then
					exports['mythic_notify']:SendAlert('inform', 'Attempting Purchase')
					AttemptBuy(i,true)
				end
			end
		end
	end
end

function AttemptBuy(tableid,financed)
	local veh = GetClosestVehicle(carspawns[tableid]["x"],carspawns[tableid]["y"],carspawns[tableid]["z"], 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		exports['mythic_notify']:SendAlert('error', 'Could not locate vehicle')
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
	TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
	TriggerServerEvent('imports:CheckMoneyForVeh',name, model, price, financed, commissionbuy)
	commissionbuy = (baseprice * commission/100)
end



function OwnerMenu()
	if not vehshop.opened then
		currentCarSpawnLocation = 0
		ownerMenu = false
	end
	for i = 1, #carspawns do
		if GetDistanceBetweenCoords(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], GetEntityCoords(GetPlayerPed(-1)) ) < 2.0 then
			ownerMenu = true
			currentCarSpawnLocation = i
			if IsControlJustReleased(0,38) then
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
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.5 then
			local commission = carTable[i]["commission"]
			local baseprice = carTable[i]["baseprice"]
			local price = baseprice + (baseprice * commission/100)
			local veh = GetClosestVehicle(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], 3.000, 0, 70)
			local addplate = GetVehicleNumberPlateText(veh)
			if job == 'cardealer' then
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
		TriggerServerEvent("carshop_imports:requesttable")
		print("requesting table")
		Citizen.Wait(1500)
	end
	DespawnSaleVehicles()
	vehicles_spawned = true
	hasspawned = true
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
			exports['mythic_notify']:SendAlert('error', 'Vehicles failed to load, please be patient')
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
		SetVehicleNumberPlateText(veh, i .. "IMPORT")
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
	return GetPlayerPed(-1)
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
			local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
			-- 60 58 137
			SetBlipSprite(blip,326)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Vehicle Shop')
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

				if #(vector3(vehshop_locations[1].outside[1],vehshop_locations[1].outside[2],vehshop_locations[1].outside[3]) - GetEntityCoords(LocalPed())) < 5.0 then
					local veh = GetVehiclePedIsUsing(LocalPed())
					if myspawnedvehs[veh] ~= nil then
						DrawText3D(vehshop_locations[1].outside[1],vehshop_locations[1].outside[2],vehshop_locations[1].outside[3],"["..Controlkey["generalUse"][2].."] return vehicle")
						if IsControlJustReleased(0,38) then
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
							DisplayHelpText('~b~'..Controlkey["generalUse"][2]..'~s~ to browse')
							inrange = true
						end

						if vehshop.opened == true then
							DisplayHelpText('~b~'..Controlkey["generalUse"][2]..'~s~ or ~b~'..Controlkey["generalUseSecondary"][2]..'~s~ Accepts ~b~Arrows~s~ Move ~b~Backspace~s~ Exit')
						end

						if job == 'cardealer' then
							OwnerMenu()
						end

						BuyMenu()
					else
						if vehicles_spawned then
							DespawnSaleVehicles(false,true)
						end
						Citizen.Wait(1000)
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
	local pos = currentlocation.pos.inside
	FreezeEntityPosition(ped,true)
	SetEntityVisible(ped,false)
	local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,pos[1],pos[2],pos[3],Citizen.PointerValueFloat(),0)
	SetEntityCoords(ped,pos[1],pos[2],g)
	SetEntityHeading(ped,pos[4])

	vehshop.currentmenu = "main"
	vehshop.opened = true
	vehshop.selectedbutton = 0
end

function CloseCreator(name, veh, price, financed, curCom)
	Citizen.CreateThread(function()
		local ped = LocalPed()
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

			personalvehicle = CreateVehicle(model,pos[1],pos[2],pos[3],pos[4],true,false)
			SetModelAsNoLongerNeeded(model)

			for i,mod in pairs(mods) do
				SetVehicleModKit(personalvehicle,0)
				SetVehicleMod(personalvehicle,i,mod)
			end

			SetVehicleOnGroundProperly(personalvehicle)
			SetEntityAsMissionEntity(personalvehicle,false,true)
			local plate = GetVehicleNumberPlateText(personalvehicle)
			TriggerEvent("ARPF:spawn:recivekeys",personalvehicle,plate)

			SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
			local id = NetworkGetNetworkIdFromEntity(personalvehicle)
			SetNetworkIdCanMigrate(id, true)
			Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(personalvehicle))
			SetVehicleColours(personalvehicle,colors[1],colors[2])
			SetVehicleExtraColours(personalvehicle,extra_colors[1],extra_colors[2])
			TaskWarpPedIntoVehicle(GetPlayerPed(-1),personalvehicle,-1)
			SetEntityVisible(ped,true)
			local vehProps = ESX.Game.GetVehicleProperties(personalvehicle)
			TriggerServerEvent('imports:BuyForVeh', vehProps, name, vehicle, price, financed, seller, curCom, commissionbuy)
			TriggerServerEvent("garages:CheckGarageForVeh")
			DespawnSaleVehicles()
			SpawnSaleVehicles()
		end
		vehshop.opened = false
		vehshop.menu.from = 1
		vehshop.menu.to = 10
	end)
end

RegisterNetEvent("carshop_imports:failedpurchase")
AddEventHandler("carshop_imports:failedpurchase", function()
	local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
	TaskLeaveVehicle(GetPlayerPed(-1),veh,0)
end)

RegisterNetEvent("veh_shop_imports:setPlate")
AddEventHandler("veh_shop_imports:setPlate", function(vehicle, plate)

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
	local ped = GetPlayerPed(-1)
	local this = vehshop.currentmenu
	local btn = button.name
	if this == "main" then
		if btn == "Vehicles" then
			OpenMenu('vehicles')
		elseif btn == "Motorcycles" then
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
	elseif this == "jobvehicles" or this == "compacts" or this == "coupes" or this == "sedans" or this == "sports" or this == "sportsclassics" or this == "super" or this == "muscle" or this == "offroad" or this == "suvs" or this == "vans" or this == "industrial" or this == "cycles" or this == "motorcycles" then
		if ownerMenu then
			updateCarTable(button.model,button.costs,button.name)
		else
			TriggerServerEvent('CheckMoneyForVeh',button.name, button.model, button.costs)
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
	elseif vehshop.currentmenu == "jobvehicles" or vehshop.currentmenu == "compacts" or vehshop.currentmenu == "coupes" or vehshop.currentmenu == "sedans" or vehshop.currentmenu == "sports" or vehshop.currentmenu == "sportsclassics" or vehshop.currentmenu == "super" or vehshop.currentmenu == "muscle" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
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
				if i >= vehshop.menu.from and i <= vehshop.menu.to then

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
					if vehshop.currentmenu == "jobvehicles" or vehshop.currentmenu == "compacts" or vehshop.currentmenu == "coupes" or vehshop.currentmenu == "sedans" or vehshop.currentmenu == "sports" or vehshop.currentmenu == "sportsclassics" or vehshop.currentmenu == "super" or vehshop.currentmenu == "muscle" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
						if selected then
							if fakecar.model ~= button.model then
								if DoesEntityExist(fakecar.car) then
									Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
								end
								local pos = currentlocation.pos.inside
								local hash = GetHashKey(button.model)
								RequestModel(hash)

								local modelwait = 1
								RequestModel(hash)
								while not HasModelLoaded(hash) and modelwait < 100 do
									Citizen.Wait(100)
									modelwait = modelwait + 1
								end

								if modelwait > 100 then
									CloseCreator()
								else

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
					end
					if selected and ( IsControlJustPressed(1,Controlkey["generalUse"][1]) or IsControlJustPressed(1, Controlkey["generalUseSecondary"][1]) ) then
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

AddEventHandler('imports:FinishMoneyCheckForVeh', function(name, vehicle, price,financed,commission)
	local name = name
	local vehicle = vehicle
	local price = price
	boughtcar = true
	CloseCreator(name, vehicle, price,financed,commission)
end)

AddEventHandler('vehshop_imports:spawnVehicle', function(v)
	local car = GetHashKey(v)
	local playerPed = GetPlayerPed(-1)
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
		local plate = GetVehicleNumberPlateText(veh)
		TriggerEvent("ARPF:spawn:recivekeys", veh,vehplate)
	end
end)
ShowVehshopBlips(true)

AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		--326 car blip 227 225
		ShowVehshopBlips(true)
		firstspawn = 1
	end
end)

RegisterNetEvent('ffrp:playerBecameJob')
AddEventHandler('ffrp:playerBecameJob', function(jobpassed)
	job = jobpassed.name
end)