----------------------------------------
--- Discord Whitelist, Made by FAXES ---
----------------------------------------

-- Documentation: https://docs.faxes.zone/docs/discord-whitelist-setup
--- Config ---
notWhitelistedMessage = "You are not whitelisted for this server. Make sure you are connected to discord.io/FadeFusionRP" -- Message displayed when they are not whitelist with the role

whitelistRoles = { -- Role IDs needed to pass the whitelist
    "692405154410135592", -- Owner
    "780211858186567680", --Management
    "692405154833629254",-- Senior Admin
    "692405155609706587",-- Admin
    "692405156368875610",--Moderator
    "699975106113437767",--Developer
    "780856066652373022",--Tier 3 Donator
    "780855989028913184",--Tier 2 Donator
    "780855852181487646",--Tier 1 Donator
    "692406923139743784",--Civilian
}

--- Code ---

AddEventHandler("playerConnecting", function(name, setCallback, deferrals)
    local src = source
    local passAuth = false
    deferrals.defer()

    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            identifierDiscord = v
        end
    end

    if identifierDiscord then
        usersRoles = exports.discord_perms:GetRoles(src)
        local function has_value(table, val)
            if table then
                for index, value in ipairs(table) do
                    if value == val then
                        return true
                    end
                end
            end
            return false
        end
        for index, valueReq in ipairs(whitelistRoles) do 
            if has_value(usersRoles, valueReq) then
                passAuth = true
            end
            if next(whitelistRoles,index) == nil then
                if passAuth == true then
                    deferrals.done()
                else
                    deferrals.done(notWhitelistedMessage)
                end
            end
        end
    else
        deferrals.done("Discord was not detected. Please make sure Discord is running and installed. See the below link for a debugging process - docs.faxes.zone/docs/debugging-discord")
    end
end)