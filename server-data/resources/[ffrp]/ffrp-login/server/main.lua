
ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
local IdentifierTables = {
    {table = "addon_account_data", column = "owner"},
    --{table = "addon_inventory_items", column = "owner"},
    {table = "datastore_data", column = "owner"},
    {table = "user_licenses", column = "owner"},
    {table = "owned_vehicles", column = "owner"},
    {table = "user_licenses", column = "owner"},
    {table = "houses", column = "owner"},

    {table = "billing", column = "identifier"},
    {table = "playerhousing_keys", column = "identifier"},
    {table = "characters", column = "identifier"},
    {table = "users", column = "identifier"},
    {table = "user_accounts", column = "identifier"},
    --{table = "user_inventory", column = "identifier"},
    {table = "user_inventory2", column = "name"},
    {table = "character_current", column = "cid"},
    {table = "character_outfits", column = "cid"},

    {table = "playerstattoos", column = "identifier"},
    {table = "character_face", column = "identifier"},
    {table = "weed_plants", column = "identifier"},
    {table = "phone_contacts", column = "identifier"},
}

RegisterServerEvent("kashactersS:SetupCharacters")
AddEventHandler('kashactersS:SetupCharacters', function(logout)
    local src = source
    local user = ESX.GetPlayerFromId(src)
    if user ~= nil then
        if logout then
            ESX.SavePlayer(user, function()
            end)
        end
    end
    local LastCharId = GetLastCharacter(src)
    SetIdentifierToChar(GetPlayerIdentifiers(src)[1], LastCharId)
    local Characters = GetPlayerCharacters(src)
    TriggerClientEvent('kashactersC:SetupUI', src, Characters)
    TriggerClientEvent('updatesteamid', src, GetPlayerIdentifiers(src)[1])
end)

RegisterServerEvent("kashactersS:CharacterChosen")
AddEventHandler('kashactersS:CharacterChosen', function(charid, ischar, spawnid)
	local spid = spawnid
    local src = source
    local spawn = {}
    if type(charid) == "number" and type(ischar) == "boolean" then
        SetLastCharacter(src, tonumber(charid))
        SetCharToIdentifier(GetPlayerIdentifiers(src)[1], tonumber(charid))
        if ischar then
            if spid=="1" then
                spawn = GetSpawnPos(src)
            elseif spid=="2" then
                --Stab city
                spawn = { x = 198.79, y = -934.32, z = 30.68 }
            elseif spid=="3" then
                --Sandy Shores
                spawn = { x = 1556.18, y = 3609.20, z = 35.43 }
            elseif spid=="4" then
                --paleto
                spawn = { x = -687.73, y = 5768.60, z = 17.33 }
            else
                spawn = GetSpawnPos(src)
            end
            if spawn.x == nil then
                print("spawn its nill setting default")
                spawn = { x = -1045.42, y = -2750.85, z = 22.31 }
            end
            TriggerClientEvent("kashactersC:SpawnCharacter", src, spawn)
            TriggerClientEvent('updatesteamid', src, GetPlayerIdentifiers(src)[1])
            TriggerClientEvent('updatecid', src, GetCID(src))
        else
            spawn = { x = -1045.42, y = -2750.85, z = 22.31 } -- DEFAULT SPAWN POSITION -- EDIT THIS
            TriggerClientEvent("kashactersC:SpawnCharacter", src, spawn,true)
        end
    else
        local data = {
            name = GetPlayerName(src),
            reason = 'Attempted SQL Injection (FFRP-LOGIN)',
            identifiers = GetPlayerIdentifiers(src),
            info = "Perma-ban if you see this message"
        }
        exports['ffrp-log']:DiscordLog(data)
    end
end)

RegisterCommand('ForceLogout', function(source, args, raw)
	local player = tonumber(args[1])
    local user = ESX.GetPlayerFromId(source)
    local group = user.getGroup()
    if group ~= "user" and group ~= "" then
        if args[1] then
            if (player and GetPlayerName(player)) then
                TriggerClientEvent('kashactersC:ReloadCharacters', player)
            else
                RconPrint("Player not ingame")
            end
        else
            local player = source
            if (player and GetPlayerName(player)) then
                TriggerClientEvent('kashactersC:ReloadCharacters', player)
            end
        end
    end
end)

RegisterServerEvent("kashactersS:DeleteCharacter")
AddEventHandler('kashactersS:DeleteCharacter', function(charid)
    local src = source
    if type(charid) == "number" then
        DeleteCharacter(GetPlayerIdentifiers(src)[1], charid)
        TriggerClientEvent("kashactersC:ReloadCharacters", src)
        TriggerClientEvent('updatesteamid', src, GetPlayerIdentifiers(src)[1])
        TriggerClientEvent('updatecid', src, GetCID(src))
    else
        local data = {
            name = GetPlayerName(src),
            reason = 'Attempted SQL Injection (FFRP-LOGIN)',
            identifiers = GetPlayerIdentifiers(src),
            info = "Perma-ban if you see this message"
        }
        exports['ffrp-log']:DiscordLog(data)
    end
end)

RegisterServerEvent('ffrp-login:GetSpawnPos')
AddEventHandler('ffrp-login:GetSpawnPos', function()
    local src = source
    local spawnPos = GetSpawnPos(src)
    TriggerClientEvent('updatespawn', src, spawnPos)
end)

function GetPlayerCharacters(source)
    local identifier = GetIdentifierWithoutSteam(GetPlayerIdentifiers(source)[1])
    local Chars = MySQLAsyncExecute("SELECT * FROM `users` WHERE identifier LIKE '%"..identifier.."%'")
    return Chars
end

function GetLastCharacter(source)
    local LastChar = MySQLAsyncExecute("SELECT `charid` FROM `user_lastcharacter` WHERE `steamid` = '"..GetPlayerIdentifiers(source)[1].."'")
    if LastChar[1] ~= nil and LastChar[1].charid ~= nil then
        return tonumber(LastChar[1].charid)
    else
        MySQLAsyncExecute("INSERT INTO `user_lastcharacter` (`steamid`, `charid`) VALUES('"..GetPlayerIdentifiers(source)[1].."', 1)")
        return 1
    end
end

function SetLastCharacter(source, charid)
    MySQLAsyncExecute("UPDATE `user_lastcharacter` SET `charid` = '"..charid.."' WHERE `steamid` = '"..GetPlayerIdentifiers(source)[1].."'")
end

function SetIdentifierToChar(identifier, charid)
    for _, itable in pairs(IdentifierTables) do
        MySQLAsyncExecute("UPDATE `"..itable.table.."` SET `"..itable.column.."` = 'Char"..charid..GetIdentifierWithoutSteam(identifier).."' WHERE `"..itable.column.."` = '"..identifier.."'")
    end
    MySQL.Async.execute('UPDATE user_inventory2 SET name=@newname WHERE name=@oldname', {
        ['@newname'] = "jail-Char"..charid..GetIdentifierWithoutSteam(identifier),
        ["@oldname"] = "jail-"..identifier
    })
end

function SetCharToIdentifier(identifier, charid)
    for _, itable in pairs(IdentifierTables) do
        MySQLAsyncExecute("UPDATE `"..itable.table.."` SET `"..itable.column.."` = '"..identifier.."' WHERE `"..itable.column.."` = 'Char"..charid..GetIdentifierWithoutSteam(identifier).."'")
    end
    MySQL.Async.execute('UPDATE user_inventory2 SET name=@newname WHERE name=@oldname', {
        ['@newname'] = "jail-"..identifier,
        ["@oldname"] = "jail-Char"..charid..GetIdentifierWithoutSteam(identifier)
    })
end
function DeleteCharacter(identifier, charid)
    for _, itable in pairs(IdentifierTables) do
        MySQLAsyncExecute("DELETE FROM `"..itable.table.."` WHERE `"..itable.column.."` LIKE '%Char"..charid..GetIdentifierWithoutSteam(identifier).."%'")
    end
end

function GetSpawnPos(source)
    --local SpawnPos = MySQLSyncExecute("SELECT `position` FROM `users` WHERE `identifier` = '"..GetPlayerIdentifiers(source)[1].."'")
    local SpawnPos = MySQL.Sync.fetchAll("SELECT `position` FROM `users` WHERE `identifier` = '"..GetPlayerIdentifiers(source)[1].."'")
	if SpawnPos[1].position ~= nil then
		return json.decode(SpawnPos[1].position)
    else
		local spawn = { x = -1045.42, y = -2750.85, z = 22.31 }
		return spawn
	end
end

function GetCID(source)
    local cid = MySQL.Sync.fetchAll("SELECT `id` FROM `users` WHERE `identifier` = '"..GetPlayerIdentifiers(source)[1].."'")
    if cid ~= nil and cid ~= "[]" then
        return cid[1].id
    end
end

function GetIdentifierWithoutSteam(Identifier)
    return string.gsub(Identifier, "steam", "")
end

function MySQLAsyncExecute(query)
    local IsBusy = true
    local result = nil
    MySQL.Async.fetchAll(query, {}, function(data)
        result = data
        IsBusy = false
    end)
    while IsBusy do
        Citizen.Wait(0)
    end
    return result
end

RconPrint('^2['..GetCurrentResourceName()..'] ^4Character Data Loaded^7' .. "\n")
