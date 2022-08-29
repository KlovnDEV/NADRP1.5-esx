ESX = nil

Id = 0

Units = {}
Calls = {}
UnitStatus = {}

TriggerEvent("tac:getSharedObject",function(obj) ESX = obj end)

RegisterNetEvent("core_dispatch:playerStatus")
AddEventHandler("core_dispatch:playerStatus",function(status)
    local src = source
    if status.carPlate ~= "" then
        Units[src] = {plate = status.carPlate, type = status.type, job = status.job, netId = status.netId}
    else
        Units[src] = nil
    end
end)

RegisterNetEvent("core_dispatch:removeCall")
AddEventHandler("core_dispatch:removeCall",function(id)
    Calls[tonumber(id)] = nil
end)

RegisterNetEvent("core_dispatch:changeStatus")
AddEventHandler("core_dispatch:changeStatus",function(userid, status)
    UnitStatus[userid] = status
end)

RegisterNetEvent("core_dispatch:unitDismissed")
AddEventHandler("core_dispatch:unitDismissed",function(id, job, callsign)
    local src = source
    local count = 1
    for _, v in ipairs(Calls[tonumber(id)].respondingUnits) do
        if v.unit == callsign then
            table.remove(Calls[tonumber(id)].respondingUnits, count)
        end
        count = count + 1
    end
end)

RegisterNetEvent("core_dispatch:unitResponding")
AddEventHandler("core_dispatch:unitResponding",function(id, job, callsign)
    table.insert(Calls[tonumber(id)].respondingUnits, {unit = callsign, type = job})
end)

RegisterNetEvent("core_dispatch:forwardCall")
AddEventHandler("core_dispatch:forwardCall",function(id, job)
    local add = true
    for _, v in ipairs(Calls[tonumber(id)].job) do
        if v == job then
            add = false
        end
    end
    if add then
        table.insert(Calls[tonumber(id)].job, job)
        TriggerClientEvent("core_dispatch:callAdded", -1, tonumber(id), Calls[tonumber(id)], job, 5000)
    end
end)

RegisterNetEvent("core_dispatch:addMessage")
AddEventHandler( "core_dispatch:addMessage", function(message, location, job, cooldown, sprite, color)
    local src = source
    local identifier = ESX.GetPlayerFromId(src).getIdentifier()
    local phone = MySQL.Sync.fetchScalar("SELECT phone_number FROM users WHERE identifier = @identifier",{["@identifier"] = identifier})
    Calls[Id] = {
        code = "",
        title = "",
        extraInfo = {},
        respondingUnits = {},
        coords = location,
        job = {job},
        phone = phone,
        message = message,
        type = "message",
        caller = src
    }
    TriggerClientEvent("core_dispatch:callAdded", -1, Id, Calls[Id], job, cooldown or 5000, sprite or 11, color or 5)
    Id = Id + 1
end)

RegisterNetEvent("core_dispatch:addCall")
AddEventHandler("core_dispatch:addCall",function(code, title, info, location, job, cooldown, sprite, color)
    Calls[Id] = {
        code = code,
        title = title,
        extraInfo = info,
        respondingUnits = {},
        coords = location,
        job = {job},
        type = "call"
    }
    TriggerClientEvent("core_dispatch:callAdded", -1, Id, Calls[Id], job, cooldown or 3500, sprite or 11, color or 5)
    Id = Id + 1
end)

RegisterNetEvent("core_dispatch:arrivalNotice")
AddEventHandler("core_dispatch:arrivalNotice",function(caller)
    if caller ~= nil then
        TriggerClientEvent("core_dispatch:arrivalNotice", caller)
    end
end)

ESX.RegisterServerCallback("core_dispatch:getPersonalInfo",function(source, cb)
    local identifier = ESX.GetPlayerFromId(source).getIdentifier()
    local firstname = MySQL.Sync.fetchScalar( "SELECT firstname FROM users WHERE identifier = @identifier ", {["@identifier"] = identifier})
    local lastname = MySQL.Sync.fetchScalar( "SELECT lastname FROM users WHERE identifier = @identifier ", {["@identifier"] = identifier})
    cb(firstname, lastname)
end)

ESX.RegisterServerCallback("core_dispatch:getInfo",function(source, cb)
    local generated = {}
    for k, v in pairs(Units) do
        if GetPlayerPing(k) > 0 then
            local identifier = ESX.GetPlayerFromId(k).getIdentifier()
            local firstname = MySQL.Sync.fetchScalar( "SELECT firstname FROM users WHERE identifier = @identifier ", {["@identifier"] = identifier})
            local lastname = MySQL.Sync.fetchScalar( "SELECT lastname FROM users WHERE identifier = @identifier ", {["@identifier"] = identifier})
            local callsign = MySQL.Sync.fetchScalar( "SELECT callsign FROM characters WHERE identifier=@identifier ", {["@identifier"] = identifier})
            if generated[v.plate] == nil then
                if callsign == nil then
                    callsign = "TBD"
                end
                generated[v.plate] = {
                    type = Config.Icons[v.type],
                    units = {{id = callsign, name = firstname .. " " .. lastname}},
                    job = v.job
                }
            elseif generated[v.plate].job == v.job then
                table.insert(generated[v.plate].units, {id = k, name = firstname .. " " .. lastname})
            end
        end
    end
    cb(generated, Calls, UnitStatus)
end)

ESX.RegisterServerCallback("core_dispatch:getUnits",function(source, cb)
    local generated = {}
    for k, v in pairs(Units) do
        if GetPlayerPing(k) > 0 then
            local identifier = ESX.GetPlayerFromId(k).getIdentifier()
            local firstname = MySQL.Sync.fetchScalar("SELECT firstname FROM users WHERE identifier = @identifier ",{["@identifier"] = identifier})
            local lastname = MySQL.Sync.fetchScalar("SELECT lastname FROM users WHERE identifier = @identifier ",{["@identifier"] = identifier})
            generated[k] = {netId = v.netId, firstname = firstname, lastname = lastname, type = v.type, job = v.job}
        end
    end
    cb(generated)
end)

RegisterNetEvent('shrp-dispatch:setCallSign')
AddEventHandler('shrp-dispatch:setCallSign', function(pCallsign)
	local user = ESX.GetPlayerFromId(source)
	local ident = user.identifier
	if pCallsign ~= nil then
		MySQL.Async.fetchAll('SELECT callsign FROM characters WHERE identifier=@identifier', {
			['@identifier'] = ident
		}, function(result)
			if result[1] ~= nil then
				local callsign = result[1].callsign
				if callsign ~= 0 then
					TriggerClientEvent('ped:callSign', user.source, callsign)
					TriggerClientEvent('mythic_notify:client:SendAlert', user.source, {type = 'inform', text = 'Callsing already set (Refreshing Current Callsign)'})
				elseif callsign ~= nil then
					MySQL.Async.execute('UPDATE characters SET callsign=@pCallsign WHERE identifier=@identifier', {
						['@identifier'] = ident,
						['@pCallsign'] = pCallsign
					}, function(res)
						TriggerClientEvent('ped:callSign', user.source, pCallsign)
						TriggerClientEvent('mythic_notify:client:SendAlert', user.source, {type = 'inform',text = 'Setting callsing ('..pCallsign..')'})
					end)
				end
			end
		end)
	end
end)
