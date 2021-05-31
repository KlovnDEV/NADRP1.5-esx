Config                  = {}

Config.AdminByID        = false -- Set to true if you want to set the access to the commands only to certain people (otherwise the permissions will be to ace access)
Config.DynamicWeather   = false -- Set this to false if you don't want the weather to change automatically every 10 minutes.

-- On server start
Config.StartWeather     = 'EXTRASUNNY' -- Default weather                       default: 'EXTRASUNNY'
Config.BaseTime         = 8 -- Time                                             default: 8
Config.TimeOffset       = 0 -- Time offset                                      default: 0
Config.FreezeTime       = false -- freeze time                                  default: false
Config.Blackout         = false -- Set blackout                                 default: false
Config.NewWeatherTimer  = 15 -- Time (in minutes) between each weather change   default: 10

Config.Locale           = 'en' -- Languages : en, fr, pt, tr, pt_br

Config.Admins = { -- Only if Config.AdminByID is set to true
'steam:1100001372f2acc', -- Ford
'steam:110000113afda94', --Panduko
'steam:110000113f4b389', -- Tate
'steam:110000136df1e4a', -- Reece
'steam:110000131df7840', --AZA
'steam:110000105bd7ed1', -- Epilogue
}

Config.Ace = { -- Only if Config.AdminByID is set to false
    'command', -- LEAVE BY DEFAULT TO GIVE ACCESS TO ADMINS AND SUPERADMINS IF U DIDN'T TOUCH ADMIN SYSTEM.
    --'vsyncr', -- Gives access to weather/time commands only to groups that have access to 'vsyncr' in your server.cfg (like this: add_ace group.admin vsyncr allow)
    --'yourgroupaccess', -- add_ace group.yourgroup yourgroupaccess allow
}

Config.AvailableWeatherTypes = { -- DON'T TOUCH EXCEPT IF YOU KNOW WHAT YOU ARE DOING
    'EXTRASUNNY',
    'CLEAR', 
    'NEUTRAL', 
    'SMOG', 
    'FOGGY',
    'RAIN', 
    'OVERCAST', 
    'CLOUDS', 
    'CLEARING', 
    'SNOW', 
    'BLIZZARD', 
    'SNOWLIGHT', 
    'XMAS', 
    'HALLOWEEN',
}
