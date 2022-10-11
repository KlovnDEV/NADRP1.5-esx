Config = {}

Config.Locale = 'en' -- Choose Language

-- 0 (Explode After Countdown) | 1 (Explode once the veh reaches a set speed) | 2 (Remote Detonate on Key Press) | 3 (Detonate after veh is entered and timer ends) |
-- 4 (Detonate Immediately After the vehicle is entered)
Config.DetonationType = 1

Config.ProgressBarType = 2 -- 0 (Disable) | 1 (ProgressBars) | 2 (MythicProgressBars)

Config.UsingMythicNotifications = true -- false (Default ESX Notifications) | true (Mythic Notifications Enabled)

Config.TimeTakenToArm = 4 -- in seconds 

Config.TimeUntilDetonation = 20 -- in seconds

Config.TriggerKey = 47 -- If using type 2

Config.maxSpeed = 45 -- if using type 1

Config.Speed = 'MPH' -- if using type 2