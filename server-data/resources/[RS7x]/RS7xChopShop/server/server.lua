ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

local chopList = {
    [1] = { ["name"] = "Sultan", ["modelname"] = "sultan",["rarity"] = 1, ["taken"] = false, ["chopped"] = false},
	[2] = { ["name"] = "Ingot", ["modelname"] = "INGOT",["rarity"] = 1, ["taken"] = false, ["chopped"] = false },
	[3] = { ["name"] = "Surge", ["modelname"] = "SURGE" ,["rarity"] = 1, ["taken"] = false, ["chopped"] = false},
	[4] = { ["name"] = "Issi", ["modelname"] = "ISSI2" ,["rarity"] = 1, ["taken"] = false, ["chopped"] = false},
	[5] = { ["name"] = "Gresley", ["modelname"] = "GRESLEY",["rarity"] = 1, ["taken"] = false, ["chopped"] = false },
	[6] = { ["name"] = "Pigalle", ["modelname"] = "PIGALLE" ,["rarity"] = 1, ["taken"] = false, ["chopped"] = false},
	[7] = { ["name"] = "Sabre Turbo", ["modelname"] = "SABREGT" ,["rarity"] = 1, ["taken"] = false, ["chopped"] = false},
	[8] = { ["name"] = "Landstalker", ["modelname"] = "Landstalker" ,["rarity"] = 1, ["taken"] = false, ["chopped"] = false},
	[9] = { ["name"] = "Panto", ["modelname"] = "PANTO" ,["rarity"] = 1, ["taken"] = false, ["chopped"] = false},
	[10] = { ["name"] = "Super Diamond", ["modelname"] = "superd" ,["rarity"] = 1, ["taken"] = false, ["chopped"] = false},
	[11] = { ["name"] = "Massacro", ["modelname"] = "MASSACRO" ,["rarity"] = 1, ["taken"] = false, ["chopped"] = false},
	[12] = { ["name"] = "Schafter", ["modelname"] = "schafter2" ,["rarity"] = 1, ["taken"] = false, ["chopped"] = false},
	[13] = { ["name"] = "Bullet", ["modelname"] = "BULLET",["rarity"] = 10, ["taken"] = false, ["chopped"] = false },
	[14] = { ["name"] = "Ruiner", ["modelname"] = "RUINER",["rarity"] = 1, ["taken"] = false, ["chopped"] = false },
	[15] = { ["name"] = "Prairie", ["modelname"] = "PRAIRIE" ,["rarity"] = 1, ["taken"] = false, ["chopped"] = false},
	[16] = { ["name"] = "Voltic", ["modelname"] = "VOLTIC" ,["rarity"] = 1, ["taken"] = false, ["chopped"] = false},
	[17] = { ["name"] = "Sentinel", ["modelname"] = "SENTINEL2" ,["rarity"] = 1, ["taken"] = false, ["chopped"] = false},
	[18] = { ["name"] = "Intruder", ["modelname"] = "INTRUDER" ,["rarity"] = 1, ["taken"] = false, ["chopped"] = false},
	[19] = { ["name"] = "Seminole", ["modelname"] = "SEMINOLE" ,["rarity"] = 1, ["taken"] = false, ["chopped"] = false},
	[20] = { ["name"] = "Felon GT", ["modelname"] = "FELON2" ,["rarity"] = 10, ["taken"] = false, ["chopped"] = false},
	[21] = { ["name"] = "Emperor", ["modelname"] = "EMPEROR",["rarity"] = 1, ["taken"] = false, ["chopped"] = false },
	[22] = { ["name"] = "Manana", ["modelname"] = "MANANA",["rarity"] = 10, ["taken"] = false, ["chopped"] = false },
	[23] = { ["name"] = "Coquette", ["modelname"] = "COQUETTE",["rarity"] = 6, ["taken"] = false, ["chopped"] = false },
	[24] = { ["name"] = "9F Cabrio", ["modelname"] = "NINEF2",["rarity"] = 5, ["taken"] = false, ["chopped"] = false },
	[25] = { ["name"] = "Cavalcade", ["modelname"] = "Cavalcade",["rarity"] = 1, ["taken"] = false, ["chopped"] = false },
	[26] = { ["name"] = "Comet", ["modelname"] = "Comet2",["rarity"] = 12, ["taken"] = false, ["chopped"] = false },
	[27] = { ["name"] = "Rapid GT", ["modelname"] = "rapidgt",["rarity"] = 10, ["taken"] = false, ["chopped"] = false },
	[28] = { ["name"] = "Blista Compact", ["modelname"] = "blista2",["rarity"] = 1, ["taken"] = false, ["chopped"] = false },
	[29] = { ["name"] = "Mesa", ["modelname"] = "Mesa",["rarity"] = 6, ["taken"] = false, ["chopped"] = false },
	[30] = { ["name"] = "Banshee", ["modelname"] = "Banshee",["rarity"] = 5, ["taken"] = false, ["chopped"] = false },
	[31] = { ["name"] = "Carbonizzare", ["modelname"] = "carbonizzare",["rarity"] = 10, ["taken"] = false, ["chopped"] = false },
	[32] = { ["name"] = "Peyote", ["modelname"] = "Peyote",["rarity"] = 1, ["taken"] = false, ["chopped"] = false },
	[33] = { ["name"] = "BeeJay XL", ["modelname"] = "BJXL",["rarity"] = 1, ["taken"] = false, ["chopped"] = false },
	[34] = { ["name"] = "Dilettante", ["modelname"] = "Dilettante",["rarity"] = 1, ["taken"] = false, ["chopped"] = false },
	[35] = { ["name"] = "Tornado", ["modelname"] = "Tornado",["rarity"] = 1, ["taken"] = false, ["chopped"] = false },
	[36] = { ["name"] = "Rocoto", ["modelname"] = "Rocoto",["rarity"] = 1, ["taken"] = false, ["chopped"] = false },
	[37] = { ["name"] = "Zion", ["modelname"] = "Zion",["rarity"] = 1, ["taken"] = false, ["chopped"] = false },
	[38] = { ["name"] = "Furore", ["modelname"] = "FuroreGT",["rarity"] = 1, ["taken"] = false, ["chopped"] = false },
	[39] = { ["name"] = "Buffalo", ["modelname"] = "Buffalo",["rarity"] = 1, ["taken"] = false, ["chopped"] = false },
	[40] = { ["name"] = "F620", ["modelname"] = "F620",["rarity"] = 10, ["taken"] = false, ["chopped"] = false },
	[41] = { ["name"] = "Asea", ["modelname"] = "Asea",["rarity"] = 1, ["taken"] = false, ["chopped"] = false },
	[42] = { ["name"] = "Feltzer", ["modelname"] = "feltzer2",["rarity"] = 1, ["taken"] = false, ["chopped"] = false },
	[43] = { ["name"] = "Dubsta", ["modelname"] = "Dubsta",["rarity"] = 10, ["taken"] = false, ["chopped"] = false },
	[44] = { ["name"] = "FQ2", ["modelname"] = "FQ2",["rarity"] = 10, ["taken"] = false, ["chopped"] = false },
	[45] = { ["name"] = "Radius", ["modelname"] = "RADI",["rarity"] = 1, ["taken"] = false, ["chopped"] = false },
	[46] = { ["name"] = "Stanier", ["modelname"] = "Stanier",["rarity"] = 3, ["taken"] = false, ["chopped"] = false },
	[47] = { ["name"] = "Futo", ["modelname"] = "Futo",["rarity"] = 2, ["taken"] = false, ["chopped"] = false },
	[48] = { ["name"] = "Vigero", ["modelname"] = "Vigero",["rarity"] = 4, ["taken"] = false, ["chopped"] = false },
    [49] = { ["name"] = "Oracle", ["modelname"] = "oracle",["rarity"] = 3, ["taken"] = false, ["chopped"] = false },
}

local currentList = {}
local num = 0
local max = math.random(10, 15)
local timer = (60 * 1000) * 25

function ChopList()
	currentList = {}
	for i=1, #chopList do
		local ran = math.random(#chopList)
		if not chopList[ran]["taken"] then
			chopList[ran]["taken"] = true
			currentList[num] = chopList[ran]
			num = num + 1
		end
		if num == max then
			return
		end
	end
end

function NewList()
	for i=1, #chopList do
		chopList[i]["taken"] = false
	end
	num = 0
	max = math.random(10,15)
	currentList = nil
	ChopList()
	SetTimeout(timer, NewList)
end
SetTimeout(timer, NewList)

RegisterServerEvent('request:chopshop')
AddEventHandler('request:chopshop', function()
	local user = ESX.GetPlayerFromId(source)
	TriggerClientEvent('chop:CurrentCarList', user.source, currentList, 25)
end)

RegisterServerEvent('chopshop:removevehicle')
AddEventHandler('chopshop:removevehicle', function(veh)
	local user = ESX.GetPlayerFromId(source)
	local rarity = currentList[veh]["rarity"]
	currentList[veh]["chopped"] = true
	TriggerClientEvent('chop:CurrentCarListRemove', -1, veh)
	if rarity >= 10 then
		TriggerClientEvent('payment:chopshopscrap', user.source, rarity, true)
	else
		TriggerClientEvent('payment:chopshopscrap', user.source, rarity, false)
	end
end)

RegisterServerEvent('chop:receiveItem')
AddEventHandler('chop:receiveItem', function(item, amount)
	local user = ESX.GetPlayerFromId(source)
	if item ~= nil and amount ~= nil then 
		TriggerClientEvent('player:receiveItem',source, item, amount)
	end
end)

Citizen.CreateThread(function()
	ChopList()
end)

