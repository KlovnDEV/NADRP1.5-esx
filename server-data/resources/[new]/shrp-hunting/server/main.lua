local DISCORD_WEBHOOK5 = "https://discord.com/api/webhooks/867342301260677120/rIC68Hz6vmuU72kCLPuwNYS3Z3wsVL3iVdnPAnyfdCZN6DM5M_tzAPtWVRaTBP4D8gOn"
local DISCORD_NAME5 = "Hunting Selling Logs"

local STEAM_KEY = "0782A359DAE1642AAB8DA50922585808"
local DISCORD_IMAGE = "https://i.imgur.com/zviw6oW.png" -- default is FiveM logo

PerformHttpRequest(DISCORD_WEBHOOK5, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME5, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })

local cachedData = {}

RegisterServerEvent('shrp-hunting:huntingreturnree')
AddEventHandler('shrp-hunting:huntingreturnree', function()
    --local user = exports["esx_extended"]:getModule("Player"):GetUser(source)
    local money = tonumber(user:getCash())
    user:addMoney(500)
end)

RegisterServerEvent('shrp-hunting:sell')
AddEventHandler('shrp-hunting:sell', function(money)
    local source = source
    local player = GetPlayerName(source)
   -- local user = exports["esx_extended"]:getModule("Player"):GetUser(source)
    if money ~= nil then
        user:addMoney(money)
        if money > 80 then
        	sendToDiscord5("Hunting Selling Logs", "Player ID: ".. source ..", Steam: ".. player ..",  Just Received $".. money .." From Selling Hunting.")
    	end
	end
end)

RegisterServerEvent('shrp-hunting:starthoe')
AddEventHandler('shrp-hunting:starthoe', function()
    local src = source
    --local user = exports["shrp-core"]:getModule("Player"):GetUser(src)
    local character = user:getCurrentCharacter()
    local money = tonumber(user:getCash())
    if money >= 100 then
        user:removeMoney(500)
        TriggerClientEvent('shrp-hunting:start2', src)
    else
        TriggerClientEvent('DoLongHudText', src, 'You dont have enough money on you!', 2)
    end
end)

RegisterServerEvent('shrp-hunting:giveloadout')
AddEventHandler('shrp-hunting:giveloadout', function()
    TriggerClientEvent('player:receiveItem', source, '100416529', 1)
    TriggerClientEvent('player:receiveItem', source, '2578778090', 1)
end)

RegisterServerEvent('shrp-hunting:removeloadout')
AddEventHandler('shrp-hunting:removeloadout', function()
    TriggerClientEvent('inventory:removeItem', source, '100416529', 1)
    TriggerClientEvent('inventory:removeItem', source, '2578778090', 1)
end)

RegisterServerEvent("shrp-hunting:retreive:license")
AddEventHandler("shrp-hunting:retreive:license", function()
    local src = source
	--local user = exports["shrp-core"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM user_licenses WHERE `owner`= ? AND `type` = ? AND `status` = ?', {character.id, "Hunting", "1"}, function(data)
		if data[1] then
            TriggerClientEvent("shrp-hunting:allowed", src, true)
        end
    end)
end)

function sendToDiscord5(name, message, color)
    local connect = {
      {
        ["color"] = color,
        ["title"] = "**".. name .."**",
        ["description"] = message,
      }
    }
    PerformHttpRequest(DISCORD_WEBHOOK5, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME5, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end
