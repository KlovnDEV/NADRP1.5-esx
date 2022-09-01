ESX   = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

local crops = {}
local inhouse = false
local cropstatus = {
	[1] = { ["info"] = "Looks Good", ["itemid"] = 0 },
	[2] = { ["info"] = "Needs Water", ["itemid"] = 0 },
	[3] = { ["info"] = "Needs Fertilizer", ["itemid"] = 0 },
}

RegisterNetEvent("nadrp-weed:currentcrops")
AddEventHandler("nadrp-weed:currentcrops", function(result)
	local newcrops = {}
	for i = 1, #result do
		local table = result[i]
		local coords = json.decode(result[i].coords)
		newcrops[i] = {  ["x"] = tonumber(coords.x), ["y"] = tonumber(coords.y), ["z"] = tonumber(coords.z), ["growth"] = tonumber(table.growth), ["strain"] = table.strain, ["status"] = tonumber(table.status), ["dbID"] = tonumber(table.id) }
	end
	DeleteTrees()
	crops = newcrops
end)

function DeleteTrees()
	for i = 1, #crops do
		local ObjectFound = crops[i]["object"]
		if ObjectFound then
			DeleteObject(ObjectFound)
		end
	end
end

function createTreeObject(num)
	local treeModel = `bkr_prop_weed_med_01b`
	local zm = 3.55
	if (crops[num]["growth"] < 33) then
		zm = 1
		treeModel = `bkr_prop_weed_01_small_01b`
	elseif (crops[num]["growth"] > 66) then
		treeModel = `bkr_prop_weed_lrg_01b`
	end


	RequestModel(treeModel)
	while not HasModelLoaded(treeModel) do
		Citizen.Wait(100)
	end

	local newtree = CreateObject(treeModel,crops[num]["x"],crops[num]["y"],crops[num]["z"]-zm,true,false,false)
	SetEntityCollision(newtree,false,false)
	crops[num]["object"] = newtree
end

function InsertPlant(seed, seedType)
	local strain = seed
	local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.4, 0.0))
	TriggerServerEvent("nadrp-weed:createplant",x,y,z,strain, seedType)
end

function nearMale()
	local answer = false
	local plyCoords = GetEntityCoords(PlayerPedId())
	for i = 1, #crops do
    	local dst = #(vector3(crops[i]["x"],crops[i]["y"],crops[i]["z"]) - plyCoords)
    	if dst < 10.0 and crops[i]["strain"] == "Male" then
    		answer = true
    	end
	end
	return answer
end

function convertFemales()
	local convertedIds = false
	local convertedTable = {}
	local plyCoords = GetEntityCoords(PlayerPedId())
	for i = 1, #crops do
    	local dst = #(vector3(crops[i]["x"],crops[i]["y"],crops[i]["z"]) - plyCoords)
    	if dst < 10.0 and crops[i]["strain"] == "Kush" and crops[i]["growth"] < 34 then
    		if not convertedIds then
    			convertedIds = crops[i]["dbID"]
    		else
    			convertedIds = convertedIds .. "," .. crops[i]["dbID"]
    			convertedTable[#convertedTable+1] = crops[i]["dbID"]
    		end
    	end
	end
	if not convertedIds then
		return
	end
	TriggerServerEvent("nadrp-weed:convert",convertedIds,convertedTable)
end

RegisterNetEvent("nadrp-weed:startcrop")
AddEventHandler("nadrp-weed:startcrop", function(seedType)
	local plyCoords = GetEntityCoords(PlayerPedId())

	if not inhouse then
		exports['mythic_notify']:SendAlert('error', 'You can\'t do that here!')
		return
	end

	if not exports["nadrp-inventory"]:hasEnoughOfItem("plastic",3,true) then
		return
	end

	local Seed = "Kush"

	if seedType == "female" and nearMale() then
		Seed = "Seeded"
	end

	if seedType == "male" then
		convertFemales()
		Seed = "Male"
	end

    local success = true

    for i = 1, #crops do
    	local dst = #(vector3(crops[i]["x"],crops[i]["y"],crops[i]["z"]) - plyCoords)
    	if dst < 1.0 then
    		success = false
    	end
    end

    if success then
        InsertPlant(Seed, seedType)
	else
		exports['mythic_notify']:SendAlert('error', 'Bruh back the fuck up, (Cant stack plants)')
	end
end)

RegisterNetEvent("nadrp-weed:destroyplant")
AddEventHandler("nadrp-weed:destroyplant", function()
	local plyCoords = GetEntityCoords(PlayerPedId())
	local close = 0
	local dst = 1000.0
	for i = 1, #crops do
		local storagedist = #(vector3(crops[i]["x"],crops[i]["y"],crops[i]["z"]) - plyCoords)
		if storagedist < 3.0 then
			if storagedist < dst then
				dst = storagedist
				close = i
			end
		end
	end
	local finished = exports["nadrp-taskbar"]:taskBar(40000,"Destroy")
	if finished == 100 then
		TriggerServerEvent("nadrp-weed:killplant",crops[close]["dbID"])
	end
end)

RegisterNetEvent("nadrp-weed:updateplantwithID")
AddEventHandler("nadrp-weed:updateplantwithID", function(ids,newPercent,status)
	if status == "alter" then
		for i = 1, #crops do
			if(crops[i] ~= nil) then
				if crops[i]["dbID"] == ids then
					crops[i]["growth"] = newPercent
					crops[i]["status"] = 1
				end
			end
		end
	elseif status == "remove" then
		for i = 1, #crops do
			if(crops[i] ~= nil) then
				if crops[i]["dbID"] == ids then
					print('REMOVING : ', ids)
					table.remove(crops,i)
				end
			end
		end
	elseif status == "convert" then
		for d = 1, #ids do
			for i = 1, #crops do
				if(crops[i] ~= nil) then
					if crops[i]["dbID"] == ids then
						crops[i]["strain"] = "seeded"
					end
				end
			end
		end
	elseif status == "new" then
		crops[#crops+1] = ids
	end
end)

RegisterNetEvent("nadrp-weed:giveitems")
AddEventHandler("nadrp-weed:giveitems", function(strain)
	if strain == "Seeded" then
        TriggerEvent( "player:receiveItem","femaleseed",math.random(1,12))
		if math.random(100) < 10 then
	        TriggerEvent( "player:receiveItem","maleseed",1)
	    end
	else
		if strain == "Male" then
			TriggerEvent( "player:receiveItem","femaleseed",math.random(1,2))
			TriggerEvent( "player:receiveItem","weedq",math.random(3,8))
		else
			TriggerEvent( "player:receiveItem","weedoz",math.random(1,4))
			Citizen.Wait(500)
			TriggerEvent( "player:receiveItem","weedq",math.random(10,30))
		end
	end
end)

RegisterNetEvent("nadrp-weed:updateCrops")
AddEventHandler("nadrp-weed:updateCrops", function(newCrops)
	crops = newCrops
end)

RegisterNetEvent("inhouse")
AddEventHandler("inhouse", function(status)
	inhouse = status
	if inhouse then
		print("entered house")
	else
		print("left house")
	end
end)

RegisterNetEvent('nadrp-weed:removeItems')
AddEventHandler('nadrp-weed:removeItems', function(seedType)
	TriggerEvent("inventory:removeItem","plastic", 3)
	if seedType == "female" then
	    TriggerEvent("inventory:removeItem", "femaleseed", 1)
	else
		TriggerEvent("inventory:removeItem", "maleseed", 1)
	end
end)

Citizen.CreateThread( function()
	local counter = 0
	while true do
		if not inhouse then
			Citizen.Wait(3000)
		else
			Citizen.Wait(1)
			local close = 0
			local dst = 1000.0
			local plyCoords = GetEntityCoords(PlayerPedId())
			for i = 1, #crops do
				local storagedist = #(vector3(crops[i]["x"],crops[i]["y"],crops[i]["z"]) - plyCoords)
				if storagedist < 80.0 then
					if storagedist < dst then
						dst = storagedist
						close = i
					end
					if crops[i]["object"] == nil then
						createTreeObject(i)
					elseif crops[i]["object"] then
						if not DoesEntityExist(crops[i]["object"]) then
							createTreeObject(i)
						end
					end
				else
					if crops[i]["object"] then
						DeleteObject(crops[i]["object"])
						crops[i]["object"] = nil
					end
				end
			end

			if counter > 0 then
				counter = counter - 1
			end
			if dst > 80.0 then
				if counter > 0 or counter < 0 then
					counter = 0
				end
				Citizen.Wait(math.ceil(dst*3))
			else
				if #(vector3(crops[close]["x"],crops[close]["y"],crops[close]["z"]-0.3) - plyCoords) < 10.0 then
					local num = tonumber(crops[close]["status"])
					DrawText3Ds( crops[close]["x"],crops[close]["y"], crops[close]["z"] , "[E] " .. crops[close]["strain"] .. " Strain  @ " .. crops[close]["growth"] .. "% - " .. cropstatus[num]["info"])
					if IsControlJustReleased(2, 38) and #(vector3(crops[close]["x"],crops[close]["y"],crops[close]["z"]-0.3) - plyCoords) < 2.0 and counter == 0 then
						if crops[close]["growth"] >= 100 then
							local finished = exports["nadrp-taskbar"]:taskBar(1000,"Picking")
							TriggerEvent("Evidence:StateSet",4,1600)
							TriggerServerEvent("nadrp-weed:killplant",crops[close]["dbID"])
							TriggerEvent("nadrp-weed:giveitems",crops[close]["strain"])
						else
							if crops[close]["status"] == 1 then
								exports['mythic_notify']:SendAlert('inform','This crop doesnt need any attention.')
							else
								if crops[close]["strain"] == "Seeded" then
									if exports["nadrp-inventory"]:hasEnoughOfItem("fertilizer",1,false) then
										TriggerEvent("status:setState",4,1600)
										if math.random(100) > 85 then
											exports['mythic_notify']:SendAlert('inform','You just consumed all the Fertilizer.')
											TriggerEvent("inventory:removeItem", "fertilizer", 1)
										end
										local new = crops[close]["growth"] + math.random(15,25)
										TriggerServerEvent("nadrp-weed:UpdateWeedGrowth",crops[close]["dbID"],new, crops[close]['status'])
									else
										exports['mythic_notify']:SendAlert('error','You need Fertilizer for this!')
									end
								else
									if exports["nadrp-inventory"]:hasEnoughOfItem("water",1,false) then
										TriggerEvent("status:setState",4,1600)
										TriggerEvent("inventory:removeItem", "water", 1)
										local new = crops[close]["growth"] + math.random(14,17)
										TriggerServerEvent("nadrp-weed:UpdateWeedGrowth",crops[close]["dbID"],new, crops[close]['status'])
									else
										exports['mythic_notify']:SendAlert('error','You need 1 bottle of water for this!')
									end
								end
							end
						end
						counter = 200
					end
				end
			end
		end
	end
end)

RegisterNetEvent('tac:playerLoaded')
AddEventHandler('tac:playerLoaded', function()
	TriggerServerEvent('nadrp-weed:RequestWeedPlants')
end)

RegisterCommand('destroyplant', function(source, args, raw) 
	local pData = ESX.GetPlayerData()
	local job = pData.job.name
	if job == 'police' then
		TriggerEvent('nadrp-weed:destroyplant')
	end
end)

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