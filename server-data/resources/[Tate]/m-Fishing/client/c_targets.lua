if Config.Framework == "QBCore" then
    QBCore = exports[Config.CoreName]:GetCoreObject()
elseif Config.Framework == "ESX" then 
    ESX = nil
    CreateThread(function()
        while ESX == nil do
            TriggerEvent(Config.CoreName, function(obj) ESX = obj end)
            Wait(0)
        end
    end)
else
    print("The Framework '", Config.Framework, "' is not support, please change in config.lua")
end

--========================================================= Maças
CreateThread(function()
    if Config.Framework == "QBCore" then
        for k, v in pairs(Config.LegalFishing) do --> General Menu
            name = "Leg"..k
            exports[Config.QBTarget]:AddBoxZone(name, vector3(v.x, v.y, v.z), 1, 5.2, {
                name= name,
                heading = 22,
                debugPoly=false,
            }, { options = { {event = "m-Fishing:client:MenuGeral", icon = Language.QBTarget["IconFisherman"], label = Language.QBTarget["Fisherman"] },}, distance = 5.0 })
        end

        --> Restaurante Menu ( Selling fish )
        exports[Config.QBTarget]:AddTargetModel(`s_m_y_busboy_01`, {
            options = {{event = "m-Fishing:client:PrimeirasInformacoes",icon = Language.QBTarget["IconEmploye"],label = Language.QBTarget["Employe"],},},distance = 10.0
        })

        --> Selling illegal fish
        exports[Config.QBTarget]:AddTargetModel(`a_m_y_mexthug_01`, {
            options = {{event = "m-Fishing:client:SellillegalFish",icon = Language.QBTarget["IconEmploye2"],label = Language.QBTarget["Employe2"],},},distance = 10.0
        })

        --> QB-target on campfire
        exports[Config.QBTarget]:AddTargetModel(`prop_beach_fire`, {
            options = {
                {event = "m-Fishing:client:MenuCozinhar",icon = Language.QBTarget["IconCook"],label = Language.QBTarget["Cook"],},
                {event = "m-Fishing:client:ApagarFogueira",icon = Language.QBTarget["IconBonfire"],label = Language.QBTarget["Bonfire"],},
            },
            distance = 3.0
        })
    elseif Config.Framework == "ESX" then 
        for k, v in pairs(Config.LegalFishing) do --> General Menu
            name = "Leg"..k
             exports.qtarget:AddBoxZone(name, vector3(v.x, v.y, v.z), 1, 5.2, {
                name= name,
                heading = 22,
                debugPoly=false,
            }, { options = { {event = "m-Fishing:client:MenuGeral", icon = Language.QBTarget["IconFisherman"], label = Language.QBTarget["Fisherman"] },}, distance = 5.0 })
        end

        --> Restaurante Menu ( Selling fish )
         exports.qtarget:AddTargetModel(`s_m_y_busboy_01`, {
            options = {{event = "m-Fishing:client:PrimeirasInformacoes",icon = Language.QBTarget["IconEmploye"],label = Language.QBTarget["Employe"],},},distance = 10.0
        })

        --> Selling illegal fish
         exports.qtarget:AddTargetModel(`a_m_y_mexthug_01`, {
            options = {{event = "m-Fishing:client:SellillegalFish",icon = Language.QBTarget["IconEmploye2"],label = Language.QBTarget["Employe2"],},},distance = 10.0
        })

        --> QB-target on campfire
         exports.qtarget:AddTargetModel(`prop_beach_fire`, {
            options = {
                {event = "m-Fishing:client:MenuCozinhar",icon = Language.QBTarget["IconCook"],label = Language.QBTarget["Cook"],},
                {event = "m-Fishing:client:ApagarFogueira",icon = Language.QBTarget["IconBonfire"],label = Language.QBTarget["Bonfire"],},
            },
            distance = 3.0
        })
    end
end)