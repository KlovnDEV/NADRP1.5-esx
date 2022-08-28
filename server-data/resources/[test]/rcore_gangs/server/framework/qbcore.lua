CreateThread(function()
    if Config.Framework and string.strtrim(string.lower(Config.Framework)) == 'qbcore' then
        local SharedObject = promise:new()

        TriggerEvent('GetMainObject', Config.Framework, Config.FrameworkTriggers['object'], Config.FrameworkTriggers['resourceName'], function(object)
            SharedObject:resolve(object)
        end)

        local QBCore = Citizen.Await(SharedObject)

        ShowNotification = function(source, text)
            TriggerClientEvent(Config.FrameworkTriggers['notify'], source, text)
        end

        GetPlayerId = function(source)
            return QBCore.Functions.GetPlayer(source).PlayerData.citizenid
        end

        GetPlayerMoney = function(source)
            return QBCore.Functions.GetPlayer(source).PlayerData.money.cash
        end

        GetPlayerItem = function(source, item)
            return QBCore.Functions.GetPlayer(source).Functions.GetItemByName(item)
        end

        GetPoliceCount = function()
            local policeCount = 0

            for _, serverId in pairs(QBCore.Functions.GetPlayers()) do
                Wait(0)
                
                if QBCore.Functions.GetPlayer(serverId).PlayerData.job.name == 'police' then
                    policeCount += 1
                end
            end

            return policeCount
        end

        AddPlayerMoney = function(source, amount)
            return QBCore.Functions.GetPlayer(source).Functions.AddMoney('cash', amount)
        end

        RemovePlayerMoney = function(source, amount)
            return QBCore.Functions.GetPlayer(source).Functions.RemoveMoney('cash', amount)
        end

        RemovePlayerItem = function(source, item, amount)
            return QBCore.Functions.GetPlayer(source).Functions.RemoveItem(item, amount)
        end

        IsPlayerAllowed = function(source)
            local permissions = QBCore.Functions.GetPermission(source)

            if type(permissions) == 'table' then
                for permission, _ in pairs(permissions) do
                    if Config.AllowedGroups[permission] then
                        return true
                    end
                end
            else
                return Config.AllowedGroups[QBCore.Functions.GetPermission(source)]
            end
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
            if string.strtrim(string.lower(Config.Framework)) ~= 'esx' and string.strtrim(string.lower(Config.Framework)) ~= 'other' then
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