ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

apartments = {
	[1] =   {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[2] =   {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[3] =   {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[4] =   {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[5] =   {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[6] =   {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[7] =   {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[8] =   {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[9] =   {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[10] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[11] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[12] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[13] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[14] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[15] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[16] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[17] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[18] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[19] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[20] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[21] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[22] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[23] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[24] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[25] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[26] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[27] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[28] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[29] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[30] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[31] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[32] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[33] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[34] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},

	[35] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[36] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[37] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true}, 

	[38] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[39] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[40] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[41] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[42] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[43] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[44] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[45] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[46] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[47] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[48] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[49] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[40] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[41] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[42] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[43] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[44] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[45] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[46] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[47] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[48] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},

	[49] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[50] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[51] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[52] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[53] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[54] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[55] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[56] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[57] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[58] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[59] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[60] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[61] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[62] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[63] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[64] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},

	[65] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[66] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[67] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[68] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[69] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[70] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[71] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[72] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[73] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[74] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[75] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[76] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[77] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[78] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[79] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[80] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[81] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[82] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[83] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[84] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[85] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[86] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[87] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
	[88] =  {['Owner'] = 0, ['Taken'] = false, ['Locked'] = true},
}

RegisterServerEvent('nadrp-motels:getID')
AddEventHandler('nadrp-motels:getID', function()
    local src = source 
    local user = ESX.GetPlayerFromId(src)
	MySQL.Async.fetchAll('SELECT id FROM users WHERE identifier=@ident', {
		['@ident'] = user.identifier
	}, function(result)
		if result[1] ~= nil then
			TriggerClientEvent('nadrp-motels:SetID', user.source, result[1].id)
		else
			print('^1[nadrp-MOTELS]^0: Failed to get cid?')
		end
	end)
end)

RegisterServerEvent('nadrp-motels:updatelocks')
AddEventHandler('nadrp-motels:updatelocks', function(status, roomNumber)
    local src = source
    if status == true then 
        newStatus = false 
    else
        newStatus = true
    end
    apartments[roomNumber]['Locked'] = newStatus
    TriggerClientEvent('nadrp-motels:updateLockStatus', src, newStatus)
end)

RegisterServerEvent('nadrp-motels:upgradeApartment')
AddEventHandler('nadrp-motels:upgradeApartment', function(roomType)
    local src = source
    if roomType == 2 then 
        return
    end
    TriggerClientEvent('nadrp-motels:newRoomType', src, roomType)
end)

RegisterServerEvent('nadrp-motels:GetHotel')
AddEventHandler('nadrp-motels:GetHotel', function()
    local src = source
    local user = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll('SELECT roomType FROM characters WHERE identifier=@ident', {
        ['@ident'] = user.identifier
    }, function(result)
        if result ~= nil then
			local roomType = result[1].roomType
			local myMotel = GetMyMotelRoom(user.source)
			if myMotel == 0 then
				myMotel = SetMotelRoom(user.source, roomType)
			end
			local GetJailTime = MySQL.Sync.fetchAll("SELECT jail FROM users WHERE identifier = @identifier", { ["@identifier"] = user.identifier})
			local MyKeys = MySQL.Sync.fetchAll('SELECT house_id,house_model,house_name FROM playerhousing_keys WHERE identifier=@identifier', {['@identifier'] = user.identifier})
			if GetJailTime[1].jail > 0 then
				inJail = true
			else
				inJail = false
			end
			if MyKeys[1] ~= nil then
				TriggerClientEvent('nadrp-motels:createRoom', user.source, myMotel, roomType, MyKeys, "none", inJail,false)
			else
				TriggerClientEvent('nadrp-motels:createRoom', user.source, myMotel, roomType, {}, "none", inJail,false)
			end
        end
    end)
end)

RegisterServerEvent('nadrp-motels:resetMotel')
AddEventHandler('nadrp-motels:resetMotel', function(roomNumber)
    apartments[roomNumber]["Taken"] = false
	apartments[roomNumber]["Locked"] = true
	apartments[roomNumber]["Owner"] = 0
end)

RegisterServerEvent('nadrp-motels:RequestEntry')
AddEventHandler('nadrp-motels:RequestEntry', function(room)
    local src = source
    if room ~= nil then 
        local hotel = apartments[room]
        if hotel ~= nil then
			local lockState = apartments[room]["Locked"]
            if lockState == false then
				TriggerClientEvent('nadrp-motels:CommandEnter',src, room, 1)
				TriggerClientEvent('nadrp-motels:interactState', src, false)
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', src, {type = 'error', text = 'Room is locked.'})
            end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', src, {type = 'error', text = 'Room doesnt exist?.'})
		end
    end
end)

function GetMyMotelRoom(src)
	for i=1, #apartments do
		if apartments[i]['Owner'] == src then
			return i
		end
	end
	return 0
end

function SetMotelRoom(src, roomType)
	if tonumber(roomType) == 1 then
		for i=1, #apartments, 1 do
			if apartments[i]["Taken"] == false then
				apartments[i]["Taken"] = true
				apartments[i]["Owner"] = src
				return i
			end
		end
	end
end

AddEventHandler('tac:playerDropped', function(playerId)
	local MyRoom = GetMyMotelRoom(playerId)
	if MyRoom ~= 0 then
		TriggerEvent('nadrp-motels:resetMotel', MyRoom)
	end
end)