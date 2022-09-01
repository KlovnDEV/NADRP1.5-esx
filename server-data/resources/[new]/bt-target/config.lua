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

    
end)
-- Return an object in the format
-- {
--     name = job name
-- }

Config.NonEsxJob = function()
    local PlayerJob = {}

    return PlayerJob
end
