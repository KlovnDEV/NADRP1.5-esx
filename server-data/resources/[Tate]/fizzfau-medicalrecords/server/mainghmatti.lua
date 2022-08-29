ESX = nil
VehiclesRented = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("mtablet", function(source)
    local player = GetPlayerFromId(source)
    if player.job.name == "ambulance" then
        TriggerClientEvent("fizzfau-medicalrecords:client:open", source)
    end
end)

RegisterServerEvent("fizzfau-medicalrecords:create")
AddEventHandler("fizzfau-medicalrecords:create", function(data, name)
    local ts = os.time()
    local date = os.date('%d-%m-%Y %H:%M', ts)
    DiscordLog(data, name)
    exports.ghmattimysql:execute("INSERT INTO medical_records (name, text, date) VALUES (@name, @text, @date)", {["@name"] = data.name, ["@text"] = data.text, ["@date"] = date})
end)
RegisterServerEvent("fizzfau-medicalrecords:server:search")
AddEventHandler("fizzfau-medicalrecords:server:search", function(input)
    local data = false
    local src = source
    local result = exports.ghmattimysql:executeSync("SELECT * FROM medical_records WHERE name LIKE '%"..input.."%'")
    if result[1] then
        data = result
    end
    TriggerClientEvent("fizzfau-medicalrecords:client:search", src, data)
end)

RegisterServerEvent("fizzfau-medicalrecords:server:getName")
AddEventHandler("fizzfau-medicalrecords:server:getName", function(identifier)
    local src = source
    local result = exports.ghmattimysql:executeSync("SELECT firstname, lastname FROM users WHERE identifier = @identifier", {
        ["@identifier"] = identifier
    })
    TriggerClientEvent("fizzfau-medicalrecords:getName", src, result[1])
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
                ["text"] = name.. "                             " ..time,
                ["icon_url"] = "https://i.hizliresim.com/ViM5Rz.png",
            },
        }
    }
    PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({username = "fizzfau-medicalrecords", embeds = connect}), { ['Content-Type'] = 'application/json' })
end