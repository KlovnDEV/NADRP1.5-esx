CreateThread(function()
    if Config.Framework and string.strtrim(string.lower(Config.Framework)) == 'esx' then
        local SharedObject = promise:new()

        TriggerEvent('GetMainObject', Config.Framework, Config.FrameworkTriggers['object'], Config.FrameworkTriggers['resourceName'], function(object)
            SharedObject:resolve(object)
        end)

        local ESX = Citizen.Await(SharedObject)

        ShowNotification = function(source, text)
            TriggerClientEvent(Config.FrameworkTriggers['notify'], source, text)
        end

        GetPlayerId = function(source)
            return ESX.GetPlayerFromId(source).getIdentifier()
        end

        GetPlayerMoney = function(source)
            return ESX.GetPlayerFromId(source).getMoney()
        end

        GetPlayerItem = function(source, item)
            return ESX.GetPlayerFromId(source).getInventoryItem(item)
        end

        GetPoliceCount = function()
            local policeCount = 0

            for _, serverId in pairs(ESX.GetPlayers()) do
                Wait(0)
                
                if ESX.GetPlayerFromId(serverId).job.name == 'police' then
                    policeCount += 1
                end
            end

            return policeCount
        end

        AddPlayerMoney = function(source, amount)
            return ESX.GetPlayerFromId(source).addMoney(amount)
        end

        RemovePlayerMoney = function(source, amount)
            return ESX.GetPlayerFromId(source).removeMoney(amount)
        end

        RemovePlayerItem = function(source, item, amount)
            return ESX.GetPlayerFromId(source).removeInventoryItem(item, amount)
        end

        IsPlayerAllowed = function(source)
            return Config.AllowedGroups[ESX.GetPlayerFromId(source).getGroup()]
        end

        IsStorageEmpty = function(name)
            print("^1================ WARNING ================^7")
            print("^7You tried to ^2delete^7 gang storage! Please visit^2 https://documentation.rcore.cz/paid-resources/rcore_gangs ^7for more info.^7")
            print("^1================ WARNING ================^7")

            return true
        end

        Dispatch = function(source)
            print("^1================ WARNING ================^7")
            print("^7Dispatch ^2triggered^7! Please visit^2 https://documentation.rcore.cz/paid-resources/rcore_gangs ^7for more info.^7")
            print("^1================ WARNING ================^7")

            return nil
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