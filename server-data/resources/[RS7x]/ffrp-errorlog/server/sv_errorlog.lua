RegisterServerEvent('LogClientError')
AddEventHandler('LogClientError', function(resource, error)
    local log = {
        {
            ["color"] = "9312783",
            ["title"] = "**ERROR LOG** | (**" .. resource .. "**) By " .. GetPlayerName(source),
            ["description"] = error,
        }
    }

    --[[print("------------------ CLIENT ERROR IN RESOURCE: " .. resource.. '   By: '.. GetPlayerName(source))
    print(error)
    print("------------------ END OF CLIENT ERROR")]]

    PerformHttpRequest("https://discord.com/api/webhooks/789294122413457409/RyZzz_eaeIuTyAg7VyzScLLlciipU5lFy4Vtfmr_hvKZG9zXemnDcWp8RJElEfFFGZ2o", function(err, text, headers) end, 'POST', json.encode({username = "Error Logs", embeds = log}), { ['Content-Type'] = 'application/json' })
end)
