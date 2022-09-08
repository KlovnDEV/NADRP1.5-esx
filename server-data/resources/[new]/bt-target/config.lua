Config = {}

Config.ESX = true


Citizen.CreateThread(function()
    local peds = {
        `a_f_m_bevhills_02`,
    }

    

    AddBoxZone("PoliceDuty", vector3(443.0036, -979.5211, 30.59682), 0.4, 0.6, {
        name="PoliceDuty",
        heading=43.245,
        debugPoly=false,
        minZ=30.00,
        maxZ=40.99
        }, {
            options = {
                {
                    event = "signon",
                    icon = "far fa-clipboard",
                    label = "On-Duty",
                },
                {
                    event = "signoff",
                    icon = "far fa-clipboard",
                    label = "Off-Duty",
                },
            },
            job = {"police", "ambulance", "mechanic"},
            distance = 1.5
        })

        AddBoxZone("shop", vector3( -705.539, -913.461, 19.216), 0.4, 0.6, {
            name="shop",
            heading=91.971,
            debugPoly=false,
            minZ=15.00,
            maxZ=25.99
            }, {
                options = {
                    {
                        event = "server-inventory-open", "2", "Shop",
                        icon = "far fa-clipboard",
                        label = "Openshop",
                    },
                   
                },
                job = {"police"},
                distance = 1.5
            })

    
end)
-- Return an object in the format
-- {
--     name = job name
-- }

Config.NonEsxJob = function()
    local PlayerJob = {}

    return PlayerJob
end
