ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('ffrp-log:AdminLog')
AddEventHandler('ffrp-log:AdminLog', function(name, identifier, type, log)
    if log == nil then return end
    if type == nil then type = 'error' end
    if identifier == nil then identifier = ESX.GetPlayerFromId(source)[1].identifier end
    MySQL.Async.execute('INSERT INTO admin_logs (name, identifier, type, log) VALUES (@name, @identifier, @type, @log)', {
        ['@name'] = name,
        ['@identifier'] = identifier,
        ['@type'] = type,
        ['@log'] = log
    })
end)

RegisterServerEvent('ffrp-log:ExploiterLog')
AddEventHandler('ffrp-log:ExploiterLog', function(name,identifier,type,log)
    if log == nil then return end
    if type == nil then type = 'error' end
    if identifier == nil then identifier = ESX.GetPlayerFromId(source)[1].identifier end
    MySQL.Async.execute('INSERT INTO _exploiter_logs (name, identifier, log) VALUES (@name, @identifier, @log)', {
        ['@name'] = name,
        ['@identifier'] = identifier,
        ['@log'] = log
    })
end)

RegisterServerEvent('ffrp-log:BusinessLog')
AddEventHandler('ffrp-log:BusinessLog', function(name,identifier,type,log,business)
    if log == nil then return end
    if type == nil then type = 'error' end
    if identifier == nil then identifier = ESX.GetPlayerFromId(source)[1].identifier end
    MySQL.Async.execute('INSERT INTO _business_logs (name, identifier, type, log, business) VALUES (@name, @identifier, @type, @log, @business)', {
        ['@name'] = name,
        ['@identifier'] = identifier,
        ['@type'] = type,
        ['@log'] = log,
        ['@business'] = business
    })
end)

RegisterServerEvent('ffrp-log:AddHousingLog')
AddEventHandler('ffrp-log:AddHousingLog', function(name,identifier,type,log,house_name)
    if log == nil then return end
    if type == nil then type = 'error' end
    if identifier == nil then identifier = ESX.GetPlayerFromId(source)[1].identifier end
    MySQL.Async.execute('INSERT INTO _housing_logs (name, identifier, type, house_name, log) VALUES (@name, @identifier, @type, @house_name, @log)', {
        ['@name'] = name,
        ['@identifier'] = identifier,
        ['@type'] = type,
        ['@log'] = log,
        ['@house_name'] = house_name
    })
end)

RegisterNetEvent('ffrp-log:SendDiscordLog')
AddEventHandler('ffrp-log:SendDiscordLog', function(data)
    local src = source
    if data ~= nil then
        data.identifiers = GetPlayerIdentifiers(src)
        DiscordLog(data)
    end
end)

function DiscordLog(data)
    if (Config.WebHook == nil) or (Config.WebHook == '') then
        return
    end

    local identifierString = ''
    for _, identifier in pairs(data.identifiers or {}) do
        identifierString = identifierString .. identifier

        if (_ ~= #data.identifiers) then
            identifierString = identifierString .. '\n '
        end
    end

    local discordInfo = {
        ["color"] = "15158332",
        ["type"] = "rich",
        ["title"] = data.title,
        ["description"] = string.format('**Name:** %s\n **Reason:** %s\n **Info:** %s\n **Identifiers:**\n %s', data.name, data.reason,data.info, identifierString),
        ["footer"] = {
            ["text"] = 'FFRP-LOG | 1.0.0'
        }
    }

    PerformHttpRequest(Config.WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'FFRP-LOG', embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end


-- Get DiscordUserName
RegisterCommand('GetDiscordName', function(source,args,raw)
    local discordId = tonumber(args[1])
    local nameData = nil;
    if discordId then
        local endpoint = ("users/%s"):format(discordId)
        local member = DiscordRequest("GET", endpoint, {})
        if member.code == 200 then
            local data = json.decode(member.data)
            if data ~= nil then
                nameData = data.username .. "#" .. data.discriminator;
                print('^2[DiscordName]:^0', data.username .. "#" .. data.discriminator)
            else
                print("[ffrp-log] ERROR: Couldnt get discord data")
            end
        else
            print("[ffrp-log] ERROR: Code 200 was not reached. Error provided: " .. member.data)
        end
    end
end, true)

function DiscordRequest(method, endpoint, jsondata)
    local data = nil
    local FormattedToken = "Bot " .. 'NzY3NDg0MDYyMDEyNDA3ODEw.X4ylOw.w16fxZG3HD9m_1kbbrv2s-_LmsQ'
    PerformHttpRequest("https://discordapp.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
		data = {data=resultData, code=errorCode, headers=resultHeaders}
    end, method, #jsondata > 0 and json.encode(jsondata) or "", {["Content-Type"] = "application/json", ["Authorization"] = FormattedToken})

    while data == nil do
        Citizen.Wait(0)
    end
	
    return data
end