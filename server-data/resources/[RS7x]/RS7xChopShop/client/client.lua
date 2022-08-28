ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
local SpawnedPlate = ""
local chopinfo = {
	[1] =  { ['x'] = 2341.1,['y'] = 3052.2, ['z'] = 48.15, ['h'] = 359.2, ['info'] = ' Chop Entry Point' },
	[2] =  { ['x'] = 2341.1,['y'] = 3052.2, ['z'] = 48.15,['h'] = 309.96, ['info'] = ' Craft' },
}

function IsDroppable()
	playerped = PlayerPedId()
	coordA = GetEntityCoords(playerped, 1)
	coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
	veh = getVehicleInDirection(coordA, coordB)
	return veh
end

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
	if distance > 25 then vehicle = nil end
    return vehicle ~= nil and vehicle or 0
end

local vehicleList = {
	{ ["name"] = "Sultan", ["modelname"] = "sultan" },
	{ ["name"] = "Ingot", ["modelname"] = "INGOT" },
	{ ["name"] = "Surge", ["modelname"] = "SURGE" },
	{ ["name"] = "Issi", ["modelname"] = "ISSI2" },
	{ ["name"] = "Gresley", ["modelname"] = "GRESLEY" },
	{ ["name"] = "Pigalle", ["modelname"] = "PIGALLE" },
	{ ["name"] = "Sabre Turbo", ["modelname"] = "SABREGT" },
	{ ["name"] = "Landstalker", ["modelname"] = "Landstalker" },
	{ ["name"] = "Panto", ["modelname"] = "PANTO" },
	{ ["name"] = "Super Diamond", ["modelname"] = "superd" },
	{ ["name"] = "Massacro", ["modelname"] = "MASSACRO" },
	{ ["name"] = "Schafter", ["modelname"] = "schafter2" },
	{ ["name"] = "Bullet", ["modelname"] = "BULLET" },
	{ ["name"] = "Ruiner", ["modelname"] = "RUINER" },
	{ ["name"] = "Prairie", ["modelname"] = "PRAIRIE" },
	{ ["name"] = "Voltic", ["modelname"] = "VOLTIC" },
	{ ["name"] = "Sentinel", ["modelname"] = "SENTINEL2" },
	{ ["name"] = "Intruder", ["modelname"] = "INTRUDER" },
	{ ["name"] = "Seminole", ["modelname"] = "SEMINOLE" },
	{ ["name"] = "Felon GT", ["modelname"] = "FELON2" },
	{ ["name"] = "Emperor", ["modelname"] = "EMPEROR" },
	{ ["name"] = "Manana", ["modelname"] = "MANANA" },
	{ ["name"] = "Coquette", ["modelname"] = "COQUETTE" },
	{ ["name"] = "9F Cabrio", ["modelname"] = "NINEF2" },
	{ ["name"] = "Cavalcade", ["modelname"] = "Cavalcade" },
	{ ["name"] = "Comet", ["modelname"] = "Comet2" },
	{ ["name"] = "Rapid GT", ["modelname"] = "rapidgt" },
	{ ["name"] = "Blista Compact", ["modelname"] = "blista2" },
	{ ["name"] = "Mesa", ["modelname"] = "Mesa" },
	{ ["name"] = "Banshee", ["modelname"] = "Banshee" },
	{ ["name"] = "Carbonizzare", ["modelname"] = "carbonizzare" },
	{ ["name"] = "Peyote", ["modelname"] = "Peyote" },
	{ ["name"] = "BeeJay XL", ["modelname"] = "BJXL" },
	{ ["name"] = "Dilettante", ["modelname"] = "Dilettante" },
	{ ["name"] = "Tornado", ["modelname"] = "Tornado" },
	{ ["name"] = "Rocoto", ["modelname"] = "Rocoto" },
	{ ["name"] = "Zion", ["modelname"] = "Zion" },
	{ ["name"] = "Furore", ["modelname"] = "FuroreGT" },
	{ ["name"] = "Buffalo", ["modelname"] = "Buffalo" },
	{ ["name"] = "F620", ["modelname"] = "F620" },
	{ ["name"] = "Asea", ["modelname"] = "Asea" },
	{ ["name"] = "Feltzer", ["modelname"] = "feltzer2" },
	{ ["name"] = "Dubsta", ["modelname"] = "Dubsta" },
	{ ["name"] = "FQ2", ["modelname"] = "FQ2" },
	{ ["name"] = "Radius", ["modelname"] = "RADI" },
	{ ["name"] = "Stanier", ["modelname"] = "Stanier" },
	{ ["name"] = "Futo", ["modelname"] = "Futo" },
	{ ["name"] = "Vigero", ["modelname"] = "Vigero" },
	{ ["name"] = "Oracle", ["modelname"] = "oracle" },
	{ ["name"] = "Nine F", ["modelname"] = "ninef" },
	{ ["name"] = "Banshee", ["modelname"] = "banshee" },
	{ ["name"] = "Buffalo", ["modelname"] = "buffalo" },
	{ ["name"] = "Fusilade", ["modelname"] = "fusilade" },
	{ ["name"] = "Jester", ["modelname"] = "jester" },
	{ ["name"] = "Kuruma", ["modelname"] = "kuruma" },
	{ ["name"] = "Sultan", ["modelname"] = "sultan" },
	{ ["name"] = "Infernus", ["modelname"] = "infernus" },
	{ ["name"] = "Buccaneer", ["modelname"] = "buccaneer" },
	{ ["name"] = "Chino", ["modelname"] = "chino" },
	{ ["name"] = "Sanchez", ["modelname"] = "sanchez" },
	{ ["name"] = "Dominator", ["modelname"] = "dominator" },
	{ ["name"] = "Picador", ["modelname"] = "picador" },
	{ ["name"] = "Bifta", ["modelname"] = "bifta" },
	{ ["name"] = "Sandking", ["modelname"] = "sandking" },
	{ ["name"] = "Bison", ["modelname"] = "bison" },
	{ ["name"] = "Fugitive", ["modelname"] = "fugitive" },
	{ ["name"] = "Intruder", ["modelname"] = "intruder" },
	{ ["name"] = "Premier", ["modelname"] = "premier" },
	{ ["name"] = "Primo", ["modelname"] = "primo" },
	{ ["name"] = "Regina", ["modelname"] = "regina" },
	{ ["name"] = "Washington", ["modelname"] = "washington" },
	{ ["name"] = "Akuma", ["modelname"] = "AKUMA" },
	{ ["name"] = "Bagger", ["modelname"] = "bagger" },
	{ ["name"] = "Bati", ["modelname"] = "bati" },
	{ ["name"] = "Double", ["modelname"] = "double" },
	{ ["name"] = "Hexer", ["modelname"] = "hexer" },
	{ ["name"] = "Nemesis", ["modelname"] = "nemesis" },
	{ ["name"] = "BF 400", ["modelname"] = "bf400" },
	{ ["name"] = "Blade", ["modelname"] = "blade" },
	{ ["name"] = "Hot Rod Blazer", ["modelname"] = "blazer3" },
	{ ["name"] = "Street Blazer", ["modelname"] = "blazer4" },
	{ ["name"] = "Buccaneer Custom", ["modelname"] = "buccaneer2" },
	{ ["name"] = "Carbon RS", ["modelname"] = "carbonrs" },
	{ ["name"] = "Cheburek", ["modelname"] = "cheburek" },
	{ ["name"] = "Chino Custom", ["modelname"] = "chino2" },
	{ ["name"] = "Cliffhanger", ["modelname"] = "cliffhanger" },
	{ ["name"] = "Cognoscenti Cabrio", ["modelname"] = "cogcabrio" },
	--{ ["name"] = "", ["modelname"] = "comet4" },
	--{ ["name"] = "", ["modelname"] = "comet5" },
	{ ["name"] = "Defiler", ["modelname"] = "defiler" },
	{ ["name"] = "Diabolus", ["modelname"] = "diablous" },
	{ ["name"] = "Diabolus Custom", ["modelname"] = "diablous2" },
	{ ["name"] = "Ellie", ["modelname"] = "ellie" },
	{ ["name"] = "Enduro", ["modelname"] = "enduro" },
	{ ["name"] = "Esskey", ["modelname"] = "esskey" },
	{ ["name"] = "Faction", ["modelname"] = "faction" },
	{ ["name"] = "Faction Custom", ["modelname"] = "faction2" },
	{ ["name"] = "Fagaloa", ["modelname"] = "fagaloa" },
	{ ["name"] = "Faggio", ["modelname"] = "faggio" },
	{ ["name"] = "Furore GT", ["modelname"] = "furoregt" },
	{ ["name"] = "GB200", ["modelname"] = "gb200" },
	{ ["name"] = "Kamacho", ["modelname"] = "kamacho" },
	{ ["name"] = "Lynx", ["modelname"] = "lynx" },
	{ ["name"] = "Manchez", ["modelname"] = "manchez" },
	{ ["name"] = "Nightblade", ["modelname"] = "nightblade" },
	{ ["name"] = "Primo Custom", ["modelname"] = "primo2" },
	{ ["name"] = "Raiden", ["modelname"] = "raiden" },
	{ ["name"] = "Rapid GT Classic", ["modelname"] = "rapidgt3" },
	{ ["name"] = "Sadler", ["modelname"] = "sadler" },
	{ ["name"] = "Schafter LWB", ["modelname"] = "schafter4" },
	{ ["name"] = "Sentinel Classic", ["modelname"] = "sentinel3" },
	{ ["name"] = "Sovereign", ["modelname"] = "sovereign" },
	{ ["name"] = "Clown Van", ["modelname"] = "speedo2" },
	{ ["name"] = "Stryder", ["modelname"] = "stryder" },
	{ ["name"] = "Toros", ["modelname"] = "toros" },
	{ ["name"] = "Tropos Rallye", ["modelname"] = "tropos" },
	{ ["name"] = "Vindicator", ["modelname"] = "vindicator" },
	{ ["name"] = "Voodoo", ["modelname"] = "voodoo" },
	{ ["name"] = "Windsor", ["modelname"] = "windsor" },
	{ ["name"] = "Windsor Drop", ["modelname"] = "windsor2" }
}

function checkCars()
	for i = 1, #vehicleList do
        local hash = GetHashKey(vehicleList[i]["modelname"])
        if not IsModelAVehicle(hash) then
            print(vehicleList[i]["modelname"] .. " failed")
        end
	end
end

local currentVehicleList = {}
local currentTimer = 60

RegisterNetEvent('chop:CurrentCarListRemove')
AddEventHandler('chop:CurrentCarListRemove', function(id)
	if currentVehicleList[id] ~= nil then
		currentVehicleList[id]["chopped"] = true
	end
end)

RegisterNetEvent('chop:CurrentCarList')
AddEventHandler('chop:CurrentCarList', function(newList, timer)
	currentVehicleList = newList
	currentTimer = timer
end)

RegisterNetEvent('payment:chopshopscrap')
AddEventHandler('payment:chopshopscrap', function(rarity,playsound)
	local tradingTable = { "scrap","electronics","plastic","glass","rubber","copper","aluminium","steel", "carbattery" }
	if playsound then
		if math.random(50) == 20 then
			TriggerServerEvent("chop:receiveItem", "lockpick", 1)
		end
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'impactdrill', 0.5)
	end
	local amount = rarity
	for i=1,amount do
		for i,v in ipairs(tradingTable) do
			local random = math.random(100)
			if (v == 26) then
				TriggerServerEvent('chop:receiveItem', v, 7)
			end
			if random > 50 then
				TriggerServerEvent('chop:receiveItem', v,math.random(7))
				Citizen.Wait(250)
			end
		end
	end
	exports['mythic_notify']:SendAlert('inform', 'You got scrap items.')
end)

RegisterNetEvent('chopshoppub:leave')
AddEventHandler('chopshoppub:leave', function(plate)
	local veh = GetVehiclePedIsIn(PlayerPedId(), false)
	local myplate = GetVehicleNumberPlateText(veh)
	if plate == myplate then
		TaskLeaveVehicle(PlayerPedId(), veh, 0)
		Citizen.Wait(100)
		SetEntityCoords(PlayerPedId(),GetEntityCoords(PlayerPedId()))
	end
end)

function listedVehicle(veh)
	local answer = 0
	for i = 1, #currentVehicleList do 
		if GetEntityModel(veh) == GetHashKey(currentVehicleList[i]["modelname"]) and not currentVehicleList[i]["chopped"] then
			answer = i
		end
	end
	return answer
end

function CompleteScrapping(vehicle, originalVehicleLocation)
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'impactdrill', 0.5)
	RequestAnimDict('mp_car_bomb')
	while not HasAnimDictLoaded("mp_car_bomb") do
		Citizen.Wait(0)
	end

	TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 8.0, -8, -1, 49, 0, 0, 0, 0)

	local finished = exports["nadrp-taskbar"]:taskBar(20000,"Scrapping Car")
	local currentLocation = GetEntityCoords(vehicle)
	if finished == 100 then
		local plate = GetVehicleNumberPlateText(vehicle)
		if plate == SpawnedPlate then
			local data = {
				name = GetPlayerName(PlayerId()),
				title = 'Admin abusing powers',
				reason = 'Admin attempted to chop a spawned car',
				info = 'plate: '..plate..' SpawnedPlate: '..SpawnedPlate
			}
			TriggerServerEvent('nadrp-log:SendDiscordLog', data)
			SetEntityAsNoLongerNeeded(veh,true)
			DeleteEntity(veh)
		else
			local vehicleDifference = #(currentLocation - originalVehicleLocation)
			if not IsPedInVehicle(PlayerPedId(),vehicle,false) then
				if vehicleDifference <= 1 then
					local vehResponse = listedVehicle(veh)
					TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'impactdrill', 0.5)
					TriggerServerEvent("chopshop:removevehicle",vehResponse)
					Citizen.Wait(2500)
					TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'impactdrill', 0.5)
					SetEntityAsNoLongerNeeded(veh,true)
					DeleteEntity(veh)
				else
					exports['mythic_notify']:SendAlert('error', "Don't move your vehicle while we're trying to chop it")
				end
			else
				exports['mythic_notify']:SendAlert('error', "You can't stay inside the vehicle while we're trying to chop it")
			end
		end
	end
end

Citizen.CreateThread(function()
    while true do
	    local dropOff2 = #(vector3(GetEntityCoords(PlayerPedId())) - vector3(chopinfo[2]["x"],chopinfo[2]["y"],chopinfo[2]["z"]))
		if dropOff2 < 20.0 then
			sleep = 500
			local veh = IsDroppable()
			if DoesEntityExist(veh) then
				local vehResponse = listedVehicle(veh)
				if vehResponse > 0 then
					sleep = 0
					local vehLoc = GetEntityCoords(veh)
					DrawText3Ds(vehLoc["x"],vehLoc["y"],vehLoc["z"], "[E] Drop Vehicle Off") 
					if IsControlJustReleased(0,38) then
						if not IsPedInAnyVehicle(PlayerPedId(), false) then
							CompleteScrapping(veh, GetEntityCoords(veh))
						else
							exports['mythic_notify']:SendAlert('error', 'You cant do this while in the car')
						end
					end
				end
			else
				if (#(GetEntityCoords(PlayerPedId()) - vector3(chopinfo[2]["x"],chopinfo[2]["y"],chopinfo[2]["z"]))) < 5.0 and not IsPedInAnyVehicle(PlayerPedId(), false) then
					sleep = 0
					DrawText3Ds(chopinfo[2]["x"],chopinfo[2]["y"],chopinfo[2]["z"], "The Chop Shop '/choplist'")
					if IsControlJustReleased(0,38) then
						if #currentVehicleList == 0 then
							TriggerServerEvent("request:chopshop")
							Citizen.Wait(2000)
						end
						local message = "Required List: <br>"
						for i = 1, #currentVehicleList do
							if not currentVehicleList[i]["chopped"] then
								if currentVehicleList[i]["rarity"] >= 10 then
									if i == 1 then
										message = message .. " " .. currentVehicleList[i]["name"] .. " (priority)"
									else
										message = message .. " | " .. currentVehicleList[i]["name"] .. " (priority)"
									end
								else
									if i == 1 then
										message = message .. " " .. currentVehicleList[i]["name"]
									else
										message = message .. " | " .. currentVehicleList[i]["name"]
									end
								end
							end
						end
						TriggerEvent("phone:addnotification", "EMAIL ", message)
					end
				else
					sleep = 500
				end
			end
	    else
		    sleep = 1000
		end
		Citizen.Wait(sleep)
    end
end)

RegisterNetEvent('chop:commandrequest')
AddEventHandler('chop:commandrequest', function()

	if #currentVehicleList == 0 then
		TriggerServerEvent("request:chopshop")
		Citizen.Wait(2000)
	end

	local message = "Required List: <br>"
	for i = 1, #currentVehicleList do
		if not currentVehicleList[i]["chopped"] then
			if currentVehicleList[i]["rarity"] > 10 then
				if i == 1 then
				   message = message .. " " .. currentVehicleList[i]["name"] .. " (priority)"
			   	else
				   message = message .. " | " .. currentVehicleList[i]["name"] .. " (priority)"
			   	end
		   	else
			   	if i == 1 then
				   message = message .. " " .. currentVehicleList[i]["name"]
			   	else
				   message = message .. " | " .. currentVehicleList[i]["name"]
			   	end
		   	end
		end
	end
    TriggerEvent("phone:addnotification", "EMAIL ", message)
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(60 * 1000)
		currentTimer = currentTimer - 1
		if currentTimer == 0 then
			TriggerServerEvent('request:chopshop')
		end
	end
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.30, 0.30)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

RegisterCommand('choplist', function()
	if #currentVehicleList == 0 then
		TriggerServerEvent("request:chopshop")
		Citizen.Wait(2000)
	end
	local message = "Required List: <br>"
	for i = 1, #currentVehicleList do
		if not currentVehicleList[i]["chopped"] then
			if currentVehicleList[i]["rarity"] >= 10 then
				if i == 1 then
					message = message .. " " .. currentVehicleList[i]["name"] .. " (priority)"
				else
					message = message .. " | " .. currentVehicleList[i]["name"] .. " (priority)"
				end
			else
				if i == 1 then
					message = message .. " " .. currentVehicleList[i]["name"]
				else
					message = message .. " | " .. currentVehicleList[i]["name"]
				end
			end
		end
	end
	TriggerEvent("phone:addnotification", "EMAIL ", message)
end,false)

RegisterNetEvent('chopshop:setSpawnPlate')
AddEventHandler('chopshop:setSpawnPlate', function(plate)
	SpawnedPlate = plate
end)