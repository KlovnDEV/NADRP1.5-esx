Config = {}

-- priority list can be any identifier. (hex steamid, steamid32, ip) Integer = power over other people with priority
-- a lot of the steamid converting websites are broken rn and give you the wrong steamid. I use https://steamid.xyz/ with no problems.
-- you can also give priority through the API, read the examples/readme.
Config.Priority = {
    ["steam:1100001372f2acc"] = 10, -- Ford
    ["steam:110000113f4b389"] = 10, -- Tate
    ["steam:110000104c72d3d"] = 10, -- Stark
    ["steam:110000136df1e4a"] = 9, -- RS7x
    ["steam:110000113afda94"] = 9, -- Panduko
    ["steam:11000010719d775"] = 8, -- Richards
    ["steam:110000105bd7ed1"] = 6, -- Epilogue
    ["steam:110000131df7840"] = 8, -- Azay
    ["steam:110000133fdb6d9"] = 7, -- Loke
    ["steam:110000115f994c5"] = 7, -- Turner
    ["steam:110000111ea40c0"] = 7, -- Rafa
    ["steam:110000102a56ae8"] = 6, -- -V-
    ["steam:110000112455a07"] = 7, -- Turner
    ["steam:110000133a982c7"] = 6, -- Danny
    ["steam:11000011291aae6"] = 6, -- Sports
    ["steam:11000010b4a6bcb"] = 6, -- Trentment
    ["steam:11000013c588b5b"] = 6, -- Kevin
    ["steam:110000115d67da1"] = 6, -- Ajkula
    ["steam:110000136d55cca"] = 6, -- JBooth
    ["steam:1100001031b6f5f"] = 6, -- Phoenixx
    ["steam:11000010e66e868"] = 6, -- Zeus
    ["steam:11000010b1795b0"] = 6, -- Jimmy
    
    -- Donators
    -- Make sure you name them and not have duplicates

    -- Tier 3
    ["steam:1100001064c9a90"] = 6, -- Mechanic VIP Tier
    ["steam:110000106f12c9f"] = 6, -- Swift VIP Tier
    ["steam:110000104fb815f"] = 6, -- Rusty
    ["steam:110000107ef6688"] = 6, --Foxy
    -- Tier 2 
    ["steam:11000010cf58323"] = 5, -- Weevil - 2nd tier 
    ["steam:11000011bcfdd07"] = 5, -- Shy - 2nd tier 
    ["steam:1100001072e5484"] = 5, -- DrWickk
    ["steam:110000117a6e648"] = 5, --CplJack
    ["steam:110000112a0bee9"] = 5, --Kelly
    ["steam:110000143ddc9e5"] = 5, --Harlee
    ["steam:11000010a89aa64"] = 5, --Labunga
    ["steam:11000011cbb02bb"] = 5, --Widow Maker

    -- Tier 1 
    ["steam:11000014264f3f2"] = 4, -- Jumbao
    ["steam:11000011782785c"] = 4,-- Kai
    ["steam:110000105f09634"] = 4,-- Murray
    ["steam:110000116c7987b"] = 4,-- Brianna
    ["steam:110000103b16b9f"] = 4,-- Jacob Prat
    ["steam:11000011c00d18e"] = 4,-- Slidey
    ["steam:1100001414aac92"] = 4, -- Tito
    ["steam:110000132335726"] = 4, --_cocain_crocodile_

    ["ip:127.0.0.0"] = 85
}

-- require people to run steam
Config.RequireSteam = true

-- "whitelist" only server
Config.PriorityOnly = false

-- disables hardcap, should keep this true
Config.DisableHardCap = true

-- will remove players from connecting if they don't load within: __ seconds; May need to increase this if you have a lot of downloads.
-- i have yet to find an easy way to determine whether they are still connecting and downloading content or are hanging in the loadscreen.
-- This may cause session provider errors if it is too low because the removed player may still be connecting, and will let the next person through...
-- even if the server is full. 10 minutes should be enough
Config.ConnectTimeOut = 600

-- will remove players from queue if the server doesn't recieve a message from them within: __ seconds
Config.QueueTimeOut = 90

-- will give players temporary priority when they disconnect and when they start loading in
Config.EnableGrace = true

-- how much priority power grace time will give
Config.GracePower = 8

-- how long grace time lasts in seconds
Config.GraceTime = 360

-- on resource start, players can join the queue but will not let them join for __ milliseconds
-- this will let the queue settle and lets other resources finish initializing
Config.JoinDelay =  3 * 60000

-- will show how many people have temporary priority in the connection message
Config.ShowTemp = true

-- simple localization
Config.Language = {
    joining = "\xF0\x9F\x8E\x89Joining...",
    connecting = "\xE2\x8F\xB3Connecting...",
    idrr = "\xE2\x9D\x97[Queue] Error: Couldn't retrieve any of your id's, try restarting.",
    err = "\xE2\x9D\x97[Queue] There was an error",
    pos = "\xF0\x9F\x90\x8CYou are %d/%d in queue \xF0\x9F\x95\x9C%s",
    connectingerr = "\xE2\x9D\x97[Queue] Error: Error adding you to connecting list",
    timedout = "\xE2\x9D\x97[Queue] Error: Timed out?",
    wlonly = "\xE2\x9D\x97[Queue] You must be whitelisted to join this server", -- Server is down for new update \n Discord : discord.gg/gnubkde
    steam = "\xE2\x9D\x97 [Queue] Error: Steam must be running"
}