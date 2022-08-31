local ESX

local nadrp = nadrp or {}
nadrp.Scoreboard = {}
nadrp._Scoreboard = {}
nadrp._Scoreboard.PlayersS = {}
nadrp._Scoreboard.RecentS = {}

TriggerEvent("tac:getSharedObject", function(obj) ESX = obj end)

RegisterServerEvent('nadrp-scoreboard:AddPlayer')
AddEventHandler("nadrp-scoreboard:AddPlayer", function()

    local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end

    local stid = HexIdToSteamId(steamIdentifier)
    local ply = GetPlayerName(source)
    local scomid = steamIdentifier:gsub("steam:", "")
    local data = { src = source, steamid = stid, comid = scomid, name = ply }

    TriggerClientEvent("nadrp-scoreboard:AddPlayer", -1, data )
    nadrp.Scoreboard.AddAllPlayers()
end)

function nadrp.Scoreboard.AddAllPlayers(self)
    local xPlayers   = ESX.GetPlayers()
    local src = source
    for i=1, #xPlayers, 1 do
        local identifiers, steamIdentifier = GetPlayerIdentifiers(xPlayers[i])
        for _, v in pairs(identifiers) do
            if string.find(v, "steam") then
                steamIdentifier = v
                break
            end
        end

        local stid = HexIdToSteamId(steamIdentifier)
        local ply = GetPlayerName(xPlayers[i])
        local scomid = steamIdentifier:gsub("steam:", "")
        local data = { src = xPlayers[i], steamid = stid, comid = scomid, name = ply }

        TriggerClientEvent("nadrp-scoreboard:AddAllPlayers", src, data, recentData)
    end
end

function nadrp.Scoreboard.AddPlayerS(self, data)
    nadrp._Scoreboard.PlayersS[data.src] = data
end

AddEventHandler("playerDropped", function()
	local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end

    local stid = HexIdToSteamId(steamIdentifier)
    local ply = GetPlayerName(source)
    local scomid = steamIdentifier:gsub("steam:", "")
    local plyid = source
    local data = { src = source, steamid = stid, comid = scomid, name = ply }

    TriggerClientEvent("nadrp-scoreboard:RemovePlayer", -1, data )
    Wait(600000)
    TriggerClientEvent("nadrp-scoreboard:RemoveRecent", -1, plyid)
end)

--[[ function nadrp.Scoreboard.RemovePlayerS(self, data)
    nadrp._Scoreboard.RecentS = data
end

function nadrp.Scoreboard.RemoveRecentS(self, src)
    nadrp._Scoreboard.RecentS.src = nil
end ]]

function HexIdToSteamId(hexId)
    local cid = math.floor(tonumber(string.sub(hexId, 7), 16))
	local steam64 = math.floor(tonumber(string.sub( cid, 2)))
	local a = steam64 % 2 == 0 and 0 or 1
	local b = math.floor(math.abs(6561197960265728 - steam64 - a) / 2)
	local sid = "STEAM_0:"..a..":"..(a == 1 and b -1 or b)
    return sid
end