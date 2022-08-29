


Config = {}
Config.BotToken = "ODg3MDcwNDkxOTA5Njg1MjU5.GoRZbj.xwRedSCItINDk9_UicgyXa1quts-xP4BI5sLl4"
Config.Framework = 'esx' -- esx --- newqb -- oldqb

Config.NotUseDiscord = false  
Config.Defaultimage = "https://cdn.discordapp.com/attachments/913877366147801088/939971460280229948/Artboard_1.png"

Config.permaName = true

Config.Distance = 15.0


Config.GetFrameWork = function()
    local object = nil
    if Config.Framework == "esx" then
        while object == nil do
            TriggerEvent('tac:getSharedObject', function(obj) object = obj end)
            Citizen.Wait(0)
        end
    end
    if Config.Framework == "newqb" then
        object = exports["qb-core"]:GetCoreObject()
    end
    if Config.Framework == "oldqb" then
        while object == nil do
            TriggerEvent('QBCore:GetObject', function(obj) object = obj end)
            Citizen.Wait(200)
        end
    end
    return object
end