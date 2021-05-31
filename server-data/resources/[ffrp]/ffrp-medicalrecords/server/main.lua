ESX = nil
VehiclesRented = {}
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)



RegisterCommand("mtablet", function(source)
    local xplayer = ESX.GetPlayerFromId(source)
    if xplayer["job"]["name"] == "ambulance" or xplayer["job"]["name"] == "police" then
        TriggerClientEvent("ffrp-medicalrecords:client:open", source)
     else 
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You are not EMS 4Head' })
    end
end)

RegisterServerEvent("ffrp-medicalrecords:create")
AddEventHandler("ffrp-medicalrecords:create", function(data, name)
    local ts = os.time()
    local date = os.date('%d-%m-%Y %H:%M', ts)
    DiscordLog(data, name)
    MySQL.Async.execute("INSERT INTO medical_records (name, text, date) VALUES (@name, @text, @date)", {["@name"] = data.name, ["@text"] = data.text, ["@date"] = date})
end)
RegisterServerEvent("ffrp-medicalrecords:server:search")
AddEventHandler("ffrp-medicalrecords:server:search", function(input)
    local data = false
    local src = source
    local result = MySQL.Sync.fetchAll("SELECT * FROM medical_records WHERE name LIKE '%"..input.."%'")
    if result[1] then
        data = result
    end
    TriggerClientEvent("ffrp-medicalrecords:client:search", src, data)
end)
RegisterServerEvent("ffrp-medicalrecords:server:getName")
AddEventHandler("ffrp-medicalrecords:server:getName", function(identifier)
    local src = source
    local result = MySQL.Sync.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", {
        ["@identifier"] = identifier
    })
    TriggerClientEvent("ffrp-medicalrecords:getName", src, result[1])
end)

function DiscordLog(data, name)
    local ts = os.time()
    local time = os.date('%Y-%m-%d %H:%M:%S', ts)
    local connect = {
        {
            ["color"] = 15610527,
            ["title"] = data.name,
            ["description"] = data.text,
            ["footer"] = {
            --    ["text"] = name.. "         " ..time,
                ["icon_url"] = "https://i.hizliresim.com/ViM5Rz.png",
            },
        }
    }
    PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({username = "Pillbox-MedicalRecords", embeds = connect}), { ['Content-Type'] = 'application/json' })
end