CreateThread(function()
    if Config.Framework and string.strtrim(string.lower(Config.Framework)) == 'other' then
        ShowNotification = function(text)
            -- Shows a simple notification
        end

        ShowAdvancedNotification = function(title, subject, msg, icon, iconType)
            -- Shows a more advanced notification with ped headshot as an image
        end

        GetInventoryItems = function()
            -- Must return player's inventory items [ item.name, item.label, item.amount ]
        end

        OpenPlayerInventory = function(player)
            -- This function is called when player is about to be robbed
        end

        OpenStorage = function()
            -- Opens gang storage (you can use MyGang.name as an identifier)
        end

        BlockActionsOnRestrain = function(toggle)
            -- This functions is called when player gets handcuffed
        end

        BlockActionsOnHeadbag = function(toggle)
            -- This functions is called when player gets paper bag put on his head
        end
    else
        if Config.Framework then
            if string.strtrim(string.lower(Config.Framework)) ~= 'esx' and string.strtrim(string.lower(Config.Framework)) ~= 'qbcore' then
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