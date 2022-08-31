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

local hour
local minute

RegisterNetEvent('m-Fishing:client:MenuGeral')
AddEventHandler('m-Fishing:client:MenuGeral', function()
    if Config.Framework == "QBCore" then
        local charinfo = QBCore.Functions.GetPlayerData().charinfo
        Notify(Language.Notifys["Help"]..charinfo.firstname..' '..charinfo.lastname..Language.Notifys["Help2"])
        if Config.EnableRentBoat then
            exports["qb-menu"]:openMenu({{header = Language.QBMenu["Pescador"],isMenuHeader = true},
                {header = Language.QBMenu["PedirCana"],txt = "",params = {isServer = true,event = "m-Fishing:server:ReceberCanaPescaNivel1",}},
                {header = Language.QBMenu["PedirRede"],txt = "",params = {isServer = true,event = "m-Fishing:server:ReceberRedePesca",}},
                {header = Language.QBMenu["AbrirLoja"],txt = "",params = {event = "m-Fishing:client:AbrirLojaFishing",}}, 
                {header = Language.QBMenu["UpgradeCana"],txt = "",params = {event = "m-Fishing:client:UpgradeCana",}},  
                {header = Language.QBMenu["UpgradeRede"],txt = "",params = {event = "m-Fishing:client:UpgradeRede",}},
                {header = Language.QBMenu["RentBoat"],txt = "",params = {event = "m-Fishing:client:EscolherLocalizacao",}},  
                {header = Language.QBMenu["DevolverBarco"],txt = "",params = {event = "m-Fishing:client:ApagarBarco",}},
                {header = Language.QBMenu["FecharMenu"],txt = "",params = {event = "qb-menu:closeMenu"}},
            })
        else
            exports["qb-menu"]:openMenu({{header = Language.QBMenu["Pescador"],isMenuHeader = true},
                {header = Language.QBMenu["PedirCana"],txt = "",params = {isServer = true,event = "m-Fishing:server:ReceberCanaPescaNivel1",}},
                {header = Language.QBMenu["PedirRede"],txt = "",params = {isServer = true,event = "m-Fishing:server:ReceberRedePesca",}},
                {header = Language.QBMenu["AbrirLoja"],txt = "",params = {event = "m-Fishing:client:AbrirLojaFishing",}}, 
                {header = Language.QBMenu["UpgradeCana"],txt = "",params = {event = "m-Fishing:client:UpgradeCana",}},  
                {header = Language.QBMenu["UpgradeRede"],txt = "",params = {event = "m-Fishing:client:UpgradeRede",}},  
                {header = Language.QBMenu["DevolverBarco"],txt = "",params = {event = "m-Fishing:client:ApagarBarco",}},
                {header = Language.QBMenu["FecharMenu"],txt = "",params = {event = "qb-menu:closeMenu"}},
            })
        end
    elseif Config.Framework == "ESX" then
        exports["qb-menu"]:openMenu({{header = Language.QBMenu["Pescador"],isMenuHeader = true},
            {header = Language.QBMenu["PedirCana"],txt = "",params = {isServer = true,event = "m-Fishing:server:ReceberCanaPescaNivel1",}},
            {header = Language.QBMenu["PedirRede"],txt = "",params = {isServer = true,event = "m-Fishing:server:ReceberRedePesca",}},
            {header = Language.QBMenu["UpgradeCana"],txt = "",params = {event = "m-Fishing:client:UpgradeCana",}},  
            {header = Language.QBMenu["UpgradeRede"],txt = "",params = {event = "m-Fishing:client:UpgradeRede",}},  
            {header = Language.QBMenu["RentBoat"],txt = "",params = {event = "m-Fishing:client:EscolherLocalizacao",}},
            {header = Language.QBMenu["DevolverBarco"],txt = "",params = {event = "m-Fishing:client:ApagarBarco",}},
            {header = Language.QBMenu["FecharMenu"],txt = "",params = {event = "qb-menu:closeMenu"}},
        })
    end
end)

RegisterNetEvent('m-Fishing:client:UpgradeCana')
AddEventHandler('m-Fishing:client:UpgradeCana', function()
    if Config.Framework == "QBCore" then
        exports["qb-menu"]:openMenu({{header = Language.QBMenu["Upgrades"],isMenuHeader = true, },
            {header = Language.QBMenu["UpgradeLevel2"],txt = Language.QBMenu["RequiredLevel2"],params = {isServer = true,event = 'm-Fishing:server:ReceberCanaNivel2', }},
            {header = Language.QBMenu["UpgradeLevel3"],txt = Language.QBMenu["RequiredLevel3"],params = {isServer = true,event = 'm-Fishing:server:ReceberCanaNivel3', }},
            {header = Language.QBMenu["UpgradeLevel4"],txt = Language.QBMenu["RequiredLevel4"],params = {isServer = true,event = 'm-Fishing:server:ReceberCanaNivel4', }},
            {header = Language.QBMenu["UpgradeLevel5"],txt = Language.QBMenu["RequiredLevel5"],params = {isServer = true,event = 'm-Fishing:server:ReceberCanaNivel5', }},
            {header = Language.QBMenu["FecharMenu"],txt = '',params = {event = 'qb-menu:close',}},
        })
    elseif Config.Framework == "ESX" then
        exports["qb-menu"]:openMenu({{header = Language.QBMenu["Upgrades"],isMenuHeader = true, },
            {header = Language.QBMenu["UpgradeLevel2"],txt = Language.QBMenu["RequiredLevel2"],params = {isServer = true,event = 'm-Fishing:server:ReceberCanaNivel2', }},
            {header = Language.QBMenu["UpgradeLevel3"],txt = Language.QBMenu["RequiredLevel3"],params = {isServer = true,event = 'm-Fishing:server:ReceberCanaNivel3', }},
            {header = Language.QBMenu["UpgradeLevel4"],txt = Language.QBMenu["RequiredLevel4"],params = {isServer = true,event = 'm-Fishing:server:ReceberCanaNivel4', }},
            {header = Language.QBMenu["UpgradeLevel5"],txt = Language.QBMenu["RequiredLevel5"],params = {isServer = true,event = 'm-Fishing:server:ReceberCanaNivel5', }},
            {header = Language.QBMenu["FecharMenu"],txt = '',params = {event = 'qb-menu:close',}},
        })
    end
end)

RegisterNetEvent('m-Fishing:client:UpgradeRede')
AddEventHandler('m-Fishing:client:UpgradeRede', function()
    if Config.Framework == "QBCore" then
        exports["qb-menu"]:openMenu({{header = Language.QBMenu["UpgradesRede"],isMenuHeader = true, },
            {header = Language.QBMenu["UpgradeRedeLevel2"],txt = Language.QBMenu["RequiredRedeLevel2"],params = {isServer = true,event = 'm-Fishing:server:ReceberRedeNivel2', }},
            {header = Language.QBMenu["UpgradeRedeLevel3"],txt = Language.QBMenu["RequiredRedeLevel3"],params = {isServer = true,event = 'm-Fishing:server:ReceberRedeNivel3', }},
            {header = Language.QBMenu["UpgradeRedeLevel4"],txt = Language.QBMenu["RequiredRedeLevel4"],params = {isServer = true,event = 'm-Fishing:server:ReceberRedeNivel4', }},
            {header = Language.QBMenu["UpgradeRedeLevel5"],txt = Language.QBMenu["RequiredRedeLevel5"],params = {isServer = true,event = 'm-Fishing:server:ReceberRedeNivel5', }},
            {header = Language.QBMenu["FecharMenu"],txt = '',params = {event = 'qb-menu:close',}},
        })
    elseif Config.Framework == "ESX" then
        exports["qb-menu"]:openMenu({{header = Language.QBMenu["UpgradesRede"],isMenuHeader = true, },
            {header = Language.QBMenu["UpgradeRedeLevel2"],txt = Language.QBMenu["RequiredRedeLevel2"],params = {isServer = true,event = 'm-Fishing:server:ReceberRedeNivel2', }},
            {header = Language.QBMenu["UpgradeRedeLevel3"],txt = Language.QBMenu["RequiredRedeLevel3"],params = {isServer = true,event = 'm-Fishing:server:ReceberRedeNivel3', }},
            {header = Language.QBMenu["UpgradeRedeLevel4"],txt = Language.QBMenu["RequiredRedeLevel4"],params = {isServer = true,event = 'm-Fishing:server:ReceberRedeNivel4', }},
            {header = Language.QBMenu["UpgradeRedeLevel5"],txt = Language.QBMenu["RequiredRedeLevel5"],params = {isServer = true,event = 'm-Fishing:server:ReceberRedeNivel5', }},
            {header = Language.QBMenu["FecharMenu"],txt = '',params = {event = 'qb-menu:close',}},
        })
    end
end)

RegisterNetEvent('m-Fishing:client:SellLegalFish')
AddEventHandler('m-Fishing:client:SellLegalFish', function()
    if Config.Framework == "QBCore" then
        exports["qb-menu"]:openMenu({{header = Language.QBMenu["SellHeader"],isMenuHeader = true},
            {header = Language.QBMenu["VenderCavala"],txt = Language.QBMenu["PrecoCavala"],params = {isServer = true,event = "m-Fishing:server:SellLegalFish",args = 1}},
            {header = Language.QBMenu["VenderBacalhau"],txt = Language.QBMenu["PrecoBacalhau"],params = {isServer = true,event = "m-Fishing:server:SellLegalFish",args = 2}},
            {header = Language.QBMenu["VenderRobalo"],txt = Language.QBMenu["PrecoRobalo"],params = {isServer = true,event = "m-Fishing:server:SellLegalFish",args = 3 }},
            {header = Language.QBMenu["VenderLinguado"],txt = Language.QBMenu["PrecoLinguado"],params = {isServer = true,event = "m-Fishing:server:SellLegalFish",args = 4}},
            {header = Language.QBMenu["VenderRaia"],txt = Language.QBMenu["PrecoRaia"],params = {isServer = true,event = "m-Fishing:server:SellLegalFish",args = 5}},	
            {header = Language.QBMenu["VenderSalmao"],txt = Language.QBMenu["PrecoSalmao"],params = {isServer = true,event = "m-Fishing:server:SellLegalFish",args = 6}},
            {header = Language.QBMenu["VenderAtum"],txt = Language.QBMenu["PrecoAtum"],params = {isServer = true,event = "m-Fishing:server:SellLegalFish",args = 7}},	
            {header = Language.QBMenu["VenderSardinha"],txt = Language.QBMenu["PrecoSardinha"],params = {isServer = true,event = "m-Fishing:server:SellLegalFish",args = 8}}, 
            {header = Language.QBMenu["VenderPeixeGato"],txt = Language.QBMenu["PrecoPeixeGato"],params = {isServer = true,event = "m-Fishing:server:SellLegalFish",args = 9}}, 
            {header = Language.QBMenu["VenderTamboril"],txt = Language.QBMenu["PrecoTamboril"],params = {isServer = true,event = "m-Fishing:server:SellLegalFish",args = 10}}, 
            {header = Language.QBMenu["FecharMenu"],txt = "",params = {event = "qb-menu:closeMenu"}},
        })
    elseif Config.Framework == "ESX" then
        exports["qb-menu"]:openMenu({{header = Language.QBMenu["SellHeader"],isMenuHeader = true},
            {header = Language.QBMenu["VenderCavala"],txt = Language.QBMenu["PrecoCavala"],params = {isServer = true,event = "m-Fishing:server:SellLegalFish",args = 1}},
            {header = Language.QBMenu["VenderBacalhau"],txt = Language.QBMenu["PrecoBacalhau"],params = {isServer = true,event = "m-Fishing:server:SellLegalFish",args = 2}},
            {header = Language.QBMenu["VenderRobalo"],txt = Language.QBMenu["PrecoRobalo"],params = {isServer = true,event = "m-Fishing:server:SellLegalFish",args = 3 }},
            {header = Language.QBMenu["VenderLinguado"],txt = Language.QBMenu["PrecoLinguado"],params = {isServer = true,event = "m-Fishing:server:SellLegalFish",args = 4}},
            {header = Language.QBMenu["VenderRaia"],txt = Language.QBMenu["PrecoRaia"],params = {isServer = true,event = "m-Fishing:server:SellLegalFish",args = 5}},   
            {header = Language.QBMenu["VenderSalmao"],txt = Language.QBMenu["PrecoSalmao"],params = {isServer = true,event = "m-Fishing:server:SellLegalFish",args = 6}},
            {header = Language.QBMenu["VenderAtum"],txt = Language.QBMenu["PrecoAtum"],params = {isServer = true,event = "m-Fishing:server:SellLegalFish",args = 7}},   
            {header = Language.QBMenu["VenderSardinha"],txt = Language.QBMenu["PrecoSardinha"],params = {isServer = true,event = "m-Fishing:server:SellLegalFish",args = 8}}, 
            {header = Language.QBMenu["VenderPeixeGato"],txt = Language.QBMenu["PrecoPeixeGato"],params = {isServer = true,event = "m-Fishing:server:SellLegalFish",args = 9}}, 
            {header = Language.QBMenu["VenderTamboril"],txt = Language.QBMenu["PrecoTamboril"],params = {isServer = true,event = "m-Fishing:server:SellLegalFish",args = 10}}, 
            {header = Language.QBMenu["FecharMenu"],txt = "",params = {event = "qb-menu:closeMenu"}},
        })
    end
end)

RegisterNetEvent('m-Fishing:client:SellillegalFish')
AddEventHandler('m-Fishing:client:SellillegalFish', function() 
    hour = GetClockHours()
    minute = GetClockMinutes()
    if hour >= 20 then
        if Config.Framework == "QBCore" then
            exports["qb-menu"]:openMenu({{header = Language.QBMenu["SellHeader"],isMenuHeader = true},
                {header = Language.QBMenu["VenderGolfinho"],txt = Language.QBMenu["PrecoGolfinho"],params = {isServer = true,event = "m-Fishing:server:SellillegalFish",args = 1}},
                {header = Language.QBMenu["VenderTubaraoTigre"],txt = Language.QBMenu["PrecoTubaraoTigre"],params = {isServer = true,event = "m-Fishing:server:SellillegalFish",args = 2}},
                {header = Language.QBMenu["VenderTubaraoMartelo"],txt = Language.QBMenu["PrecoTubaraoMartelo"],params = {isServer = true,event = "m-Fishing:server:SellillegalFish",args = 3}},
                {header = Language.QBMenu["VenderBaleia"],txt = Language.QBMenu["PrecoBaleia"],params = {isServer = true,event = "m-Fishing:server:SellillegalFish",args = 4}},
                {header = Language.QBMenu["FecharMenu"],txt = "",params = {event = "qb-menu:closeMenu"}},
            })
        elseif Config.Framework == "ESX" then
            exports["qb-menu"]:openMenu({{header = Language.QBMenu["SellHeader"],isMenuHeader = true},
                {header = Language.QBMenu["VenderGolfinho"],txt = Language.QBMenu["PrecoGolfinho"],params = {isServer = true,event = "m-Fishing:server:SellillegalFish",args = 1}},
                {header = Language.QBMenu["VenderTubaraoTigre"],txt = Language.QBMenu["PrecoTubaraoTigre"],params = {isServer = true,event = "m-Fishing:server:SellillegalFish",args = 2}},
                {header = Language.QBMenu["VenderTubaraoMartelo"],txt = Language.QBMenu["PrecoTubaraoMartelo"],params = {isServer = true,event = "m-Fishing:server:SellillegalFish",args = 3}},
                {header = Language.QBMenu["VenderBaleia"],txt = Language.QBMenu["PrecoBaleia"],params = {isServer = true,event = "m-Fishing:server:SellillegalFish",args = 4}},
                {header = Language.QBMenu["FecharMenu"],txt = "",params = {event = "qb-menu:closeMenu"}},
            })
        end
    else
        Notify(Language.Notifys["SoAnoite"], 'error', 3500)
    end
end)

RegisterNetEvent('m-Fishing:client:PrimeirasInformacoes')
AddEventHandler('m-Fishing:client:PrimeirasInformacoes', function()
    if Config.Framework == "QBCore" then
        local charinfo = QBCore.Functions.GetPlayerData().charinfo
        Notify(Language.Notifys["Help"]..charinfo.firstname..' '..charinfo.lastname..Language.Notifys["Help2"])
        exports["qb-menu"]:openMenu({{header = Language.QBMenu["Pescador"],isMenuHeader = true},
            {header = Language.QBMenu["SellFish"],txt = "",params = {event = "m-Fishing:client:SellLegalFish",}},
            {header = Language.QBMenu["InfoSobrePeixeIlegal"],txt = "",params = {event = "m-Fishing:client:DarInfoPeixesIlegais",}},     
            {header = Language.QBMenu["FecharMenu"],txt = "",params = {event = "qb-menu:closeMenu"}},
        })
    elseif Config.Framework == "ESX" then
        exports["qb-menu"]:openMenu({{header = Language.QBMenu["Pescador"],isMenuHeader = true},
            {header = Language.QBMenu["SellFish"],txt = "",params = {event = "m-Fishing:client:SellLegalFish",}},
            {header = Language.QBMenu["InfoSobrePeixeIlegal"],txt = "",params = {event = "m-Fishing:client:DarInfoPeixesIlegais",}},     
            {header = Language.QBMenu["FecharMenu"],txt = "",params = {event = "qb-menu:closeMenu"}},
        })
    end
end)

RegisterNetEvent('m-Fishing:client:MenuCozinhar')
AddEventHandler('m-Fishing:client:MenuCozinhar', function()
    if Config.Framework == "QBCore" then
        exports["qb-menu"]:openMenu({{header = Language.QBMenu["Campfire"],isMenuHeader = true},
            {header = Language.QBMenu["CozinharBacalhau"],txt = "",params = {event = "m-Fishing:client:CozinharBacalhau",}},
            {header = Language.QBMenu["CozinharCavala"],txt = "",params = {event = "m-Fishing:client:CozinharCavala",}}, 
            {header = Language.QBMenu["CozinharSalmao"],txt = "",params = {event = "m-Fishing:client:CozinharSalmao",}},  
            {header = Language.QBMenu["CozinharSardinha"],txt = "",params = {event = "m-Fishing:client:CozinharSardinha",}},   
            {header = Language.QBMenu["FecharMenu"],txt = "",params = {event = "qb-menu:closeMenu"}},
        })
    elseif Config.Framework == "ESX" then
        exports["qb-menu"]:openMenu({{header = Language.QBMenu["Campfire"],isMenuHeader = true},
            {header = Language.QBMenu["CozinharBacalhau"],txt = "",params = {event = "m-Fishing:client:CozinharBacalhau",}},
            {header = Language.QBMenu["CozinharCavala"],txt = "",params = {event = "m-Fishing:client:CozinharCavala",}}, 
            {header = Language.QBMenu["CozinharSalmao"],txt = "",params = {event = "m-Fishing:client:CozinharSalmao",}},  
            {header = Language.QBMenu["CozinharSardinha"],txt = "",params = {event = "m-Fishing:client:CozinharSardinha",}},   
            {header = Language.QBMenu["FecharMenu"],txt = "",params = {event = "qb-menu:closeMenu"}},
        })  
    end
end)

RegisterNetEvent('m-Fishing:client:EscolherLocalizacao')
AddEventHandler('m-Fishing:client:EscolherLocalizacao', function()
    if Config.Framework == "QBCore" then
        exports["qb-menu"]:openMenu({{header = Language.QBMenu["Pescador"],isMenuHeader = true}, 
            {header = Language.QBMenu["LosSantos"],txt = "",params = {event = "m-Fishing:client:SpawnBarcoLosSantos",}}, 
            {header = Language.QBMenu["PaletoBay"],txt = "",params = {event = "m-Fishing:client:SpawnBarcoPaletoBay",}},         
            {header = Language.QBMenu["FecharMenu"],txt = "",params = {event = "qb-menu:closeMenu"}},
        })
    elseif Config.Framework == "ESX" then
        exports["qb-menu"]:openMenu({{header = Language.QBMenu["Pescador"],isMenuHeader = true}, 
            {header = Language.QBMenu["LosSantos"],txt = "",params = {event = "m-Fishing:client:SpawnBarcoLosSantos",}}, 
            {header = Language.QBMenu["PaletoBay"],txt = "",params = {event = "m-Fishing:client:SpawnBarcoPaletoBay",}},         
            {header = Language.QBMenu["FecharMenu"],txt = "",params = {event = "qb-menu:closeMenu"}},
        })
    end
end)