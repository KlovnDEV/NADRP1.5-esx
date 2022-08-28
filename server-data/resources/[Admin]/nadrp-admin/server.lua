ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
nadrp = nadrp or {}
nadrp.Admin = nadrp.Admin or {}
nadrp._Admin = nadrp._Admin or {}
nadrp._Admin.Players = {}
nadrp._Admin.DiscPlayers = {}
nadrp._Admin.CloakedPlayers = {}

RegisterServerEvent('admin:setGroup')
AddEventHandler('admin:setGroup', function(target, rank)
    local source = source
    TriggerEvent("es:setPlayerData", target.src, "group", rank, function(response, success)
        TriggerClientEvent('es_admin:setGroup', target.src, rank)
        local message = "Set " .. target.src .. "'s rank to " .. rank .. "!"
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div class="chat-message emergency">SERVER | {0}</div>',
            args = {message},
        });
    end)
end)

RegisterServerEvent('nadrp-admin:Cloak')
AddEventHandler('nadrp-admin:Cloak', function(src, toggle)
    nadrp._Admin.CloakedPlayers[src] = toggle
    TriggerClientEvent("nadrp-admin:Cloak", -1, src, toggle)
end)

AddEventHandler("tac:playerLoaded", function(user)
    TriggerClientEvent("nadrp-admin:Cloak", user, nadrp._Admin.CloakedPlayers)
end)

AddEventHandler("playerDropped", function()
    local src = source
    if nadrp._Admin.CloakedPlayers[src] then
        nadrp._Admin.CloakedPlayers[src] = false
        TriggerClientEvent("nadrp-admin:Cloak", -1, src, false)
    end
end)

RegisterServerEvent('admin:addChatMessage')
AddEventHandler('admin:addChatMessage', function(message)
    print(message)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message emergency"><b>{0}</b> {1} </div>',
        args = {'Admin: ', message},
    });
end)

RegisterServerEvent('admin:addChatAnnounce')
AddEventHandler('admin:addChatAnnounce', function(message)
    print(message)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message nonemergency"><b>{0}</b> {1} </div>',
        args = {'Announcement: ', message},
    });
end)

RegisterServerEvent('nadrp-admin:RaveMode')
AddEventHandler('nadrp-admin:RaveMode', function(toggle)
    local source = source
    TriggerClientEvent('nadrp-admin:RaveMode', -1, toggle)
end)

RegisterServerEvent('nadrp-admin:AddPlayer')
AddEventHandler("nadrp-admin:AddPlayer", function()
    local licenses
    local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end
    for _, v in pairs(identifiers) do
        if string.find(v, "license") then
            licenses = v
            break
        end
    end

    local stid = HexIdToSteamId(steamIdentifier)
    local ply = GetPlayerName(source)
    local ip = GetPlayerEndpoint(source)
    local scomid = steamIdentifier:gsub("steam:", "")
    local licenseid = licenses:gsub("license:", "")
    local ping = GetPlayerPing(source)
    local data = { src = source, steamid = stid, comid = scomid, name = ply, ip = ip, license = licenseid, ping = ping}

    TriggerClientEvent("nadrp-admin:AddPlayer", -1, data)
    nadrp.Admin.AddAllPlayers()
end)

RegisterServerEvent('nadrp-admin:bringPlayer')
AddEventHandler('nadrp-admin:bringPlayer', function(target, coords)
    local source = source
    TriggerClientEvent('es_admin:teleportUser', target, coords.x, coords.y, coords.z)
    exports['mythic_notify']:SendAlert('inform', 'You brought this player.')
end)

function nadrp.Admin.AddAllPlayers(self)
    local xPlayers   = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local licenses
        local identifiers, steamIdentifier = GetPlayerIdentifiers(xPlayers[i])
        for _, v in pairs(identifiers) do
            if string.find(v, "steam") then
                steamIdentifier = v
                break
            end
        end
        for _, v in pairs(identifiers) do
            if string.find(v, "license") then
                licenses = v
                break
            end
        end
        local ip = GetPlayerEndpoint(xPlayers[i])
        local licenseid = licenses:gsub("license:", "")
        local ping = GetPlayerPing(xPlayers[i])
        local stid = HexIdToSteamId(steamIdentifier)
        local ply = GetPlayerName(xPlayers[i])
        local scomid = steamIdentifier:gsub("steam:", "")
        local data = { src = xPlayers[i], steamid = stid, comid = scomid, name = ply, ip = ip, license = licenseid, ping = ping }
        TriggerClientEvent("nadrp-admin:AddAllPlayers", source, data)
    end
end

function nadrp.Admin.AddPlayerS(self, data)
    nadrp._Admin.Players[data.src] = data
end

AddEventHandler("playerDropped", function()
	local licenses
    local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end
    for _, v in pairs(identifiers) do
        if string.find(v, "license") then
            licenses = v
            break
        end
    end

    local stid = HexIdToSteamId(steamIdentifier)
    local ply = GetPlayerName(source)
    local ip = GetPlayerEndpoint(source)
    local scomid = steamIdentifier:gsub("steam:", "")
    local licenseid = licenses:gsub("license:", "")
    local ping = GetPlayerPing(source)
    local data = { src = source, steamid = stid, comid = scomid, name = ply, ip = ip, license = licenseid, ping = ping}

    TriggerClientEvent("nadrp-admin:RemovePlayer", -1, data )
    Wait(600000)
    TriggerClientEvent("nadrp-admin:RemoveRecent", -1, data)
end)

RegisterCommand('cooldown', function(source, args, raw) 
    local user = ESX.GetPlayerFromId(source)
    local targ = ESX.GetPlayerFromId(tonumber(args[1]))
    local timer = tonumber(args[2])
    if targ ~= nil then
        if timer ~= nil then
            if (user.getGroup() ~= "user") and (user.getGroup() ~= "") then
                TriggerClientEvent('nadrp-admin:startCooldown', targ.source, timer)
                TriggerClientEvent('chat:addMessage', user.source, {
                    template = '<div class="chat-message server"><b>[ADMIN]: You have timed out id: ['..targ.source..'] for: '..timer..' second(s)</b></div>',
                    args = {}
                })
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', user.source, {type = 'error', text = 'You dont have permissions for this'})
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', user.source, {type = 'error', text = 'Invalid time - (/cooldown [id] [timer] - in seconds)'})
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', user.source, {type = 'error', text = 'Invalid Player id'})
    end
end)


function HexIdToSteamId(hexId)
    local cid = math.floor(tonumber(string.sub(hexId, 7), 16))
	local steam64 = math.floor(tonumber(string.sub( cid, 2)))
	local a = steam64 % 2 == 0 and 0 or 1
	local b = math.floor(math.abs(6561197960265728 - steam64 - a) / 2)
	local sid = "STEAM_0:"..a..":"..(a == 1 and b -1 or b)
    return sid
end







