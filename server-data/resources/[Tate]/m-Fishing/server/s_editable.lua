if Config.Framework == "QBCore" then
    QBCore = exports[Config.CoreName]:GetCoreObject()
elseif Config.Framework == "ESX" then
	ESX = nil
    TriggerEvent(Config.CoreName, function(obj) ESX = obj end)
else
    print("The Framework '", Config.Framework, "' is not support, please change in config.lua")
end

RegisterNetEvent('m-Fishing:Server:CatchLegalFish', function() 
    local src = source
    local Player  = QBCore.Functions.GetPlayer(src)
    -- Trigger the export to give XP to player when you catch legal fish
end)

RegisterNetEvent('m-Fishing:Server:CatchIlegalFish', function() 
    local src = source
    local Player  = QBCore.Functions.GetPlayer(src)
    -- Trigger the export to give XP to player when you catch ilegal fish
end)