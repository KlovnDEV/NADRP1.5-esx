CreateThread(function()
    if Config.Framework and string.strtrim(string.lower(Config.Framework)) == 'esx' then
        local SharedObject = promise:new()

        TriggerEvent('GetMainObject', Config.Framework, Config.FrameworkTriggers['object'], Config.FrameworkTriggers['resourceName'], function(object)
            SharedObject:resolve(object)
        end)

        local ESX = Citizen.Await(SharedObject)

        ShowNotification = function(text)
            ESX.ShowNotification(text, true, false, 140)
        end

        ShowAdvancedNotification = function(title, subject, msg, icon, iconType)
            ESX.ShowAdvancedNotification(title, subject, Locales[Config.Language] and (Locales[Config.Language][msg] or msg) or (Locales['EN'][msg] or msg), icon, iconType)
        end

        GetInventoryItems = function()
            print("^1================ WARNING ================^7")
            print("^7You tried to ^2get^7 inventory items! Please visit^2 https://documentation.rcore.cz/paid-resources/rcore_gangs ^7for more info.^7")
            print("^1================ WARNING ================^7")

            return {}
        end

        OpenPlayerInventory = function(player)
            print("^1================ WARNING ================^7")
            print("^7You tried to ^2open^7 someone's inventory! Please visit^2 https://documentation.rcore.cz/paid-resources/rcore_gangs ^7for more info.^7")
            print("^1================ WARNING ================^7")

            return nil
        end

        OpenStorage = function()
            print("^1================ WARNING ================^7")
            print("^7You tried to ^2open^7 gang storage! Please visit^2 https://documentation.rcore.cz/paid-resources/rcore_gangs ^7for more info.^7")
            print("^1================ WARNING ================^7")

            return nil
        end

        BlockActionsOnRestrain = function(toggle)
            -- This functions is called when player gets handcuffed
        end

        BlockActionsOnHeadbag = function(toggle)
            -- This functions is called when player gets paper bag put on his head
        end
    else
        if Config.Framework then
            if string.strtrim(string.lower(Config.Framework)) ~= 'qbcore' and string.strtrim(string.lower(Config.Framework)) ~= 'other' then
                print("^1================ WARNING ================^7")
                print("^7Choose your ^2framework^7 in the config!^7")
                print("^1================ WARNING ================^7")
            end
        else
            print("^1================ WARNING ================^7")
            print("^7Choose your ^2framework^7 in the config!^7")
            print("^1================ WARNING ================^7")
        end
    end
end)