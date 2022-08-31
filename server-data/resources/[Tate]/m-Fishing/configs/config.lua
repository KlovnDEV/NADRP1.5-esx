Config = {}

---------------
-- Utility
---------------
Config.Framework = "ESX" -- QBCore or ESX
Config.CoreName = "tac:getSharedObject" -- qb-core or esx:getSharedObject
Config.TempoEsperaPescar = {minTime = 5000, maxTime = 10000}   -- How long a player will be waiting to fish, during or after casting fishingrod
Config.StopFishing = 73  -- Stop Fishing Key [X] (https://docs.fivem.net/docs/game-references/controls/)
Config.QBTarget = "bt-target"  -- The name of the Target export you are using 
Config.SkillBarFish = "qb-lock"	-- qb-lock or qb-skillbar
Config.EnableCommandForProp = true -- Enable command to remove fishing rod prop from hand
Config.CommandForProp = "propcana" -- Command to remove the stack prop on the hand
Config.HudRelieveStress = "hud:server:RelieveStress" -- Trigger to relieve the stress
Config.BonusForEating = "all" 	-- You can put: armour, stress, stamina or all
Config.BonusStress = math.random(5, 10) -- Amount of give stress
Config.BonusAmour = math.random(5, 10) -- Amount of armour
Config.QuantityRelieveStress = math.random(5, 10) -- -- Amount of relieve stress
Config.BonusStamina = 1.0 -- Amount of stamina
Config.EnableRentBoat = true -- Enable rent a boats?
Config.ChanceRemoveKey = 2 -- 1 to 10  2 = 20% | If you dont need this put 10
Config.ChanceRemoveBait = 2 -- 1 to 10  2 = 20% | If you dont need this put 10
Config.CoreSkills = false -- If you use core_skills make this true and change values on s_editable.lua

---------------
-- Mini-Game
---------------
Config.QBSkillbar = {
    duration = math.random(2500,5000),
    pos = math.random(10, 30),
    width = math.random(10, 20),
}

Config.QBLock = {
    circles = math.random(2,4),
    time = math.random(7,10) ,
}
---------------
-- Blips
---------------
Config.EnableGeneralBlips = true -- Enable general blips?
Config.BlipSpriteLegalFishing = 410
Config.BlipDisplayLegalFishing = 4
Config.BlipScaleLegalFishing = 0.7
Config.BlipColourLegalFishing = 74
Config.LegalFishing = {
    [1] = { x = -1814.75, y = -951.19, z = 1.7, name = "Legal Fishing Zone"},
    [2] = { x = -283.98, y = 6602.14, z = 1.33, name = "Legal Fishing Zone"},
}

----------------------
-- Stash 
----------------------
-- **NOTE:** This is on available for QBCore
Config.Stash = {
	Name = "FishingBox_",
	Weight = 500000,
	Slots = 12,
}

----------------------
-- Car 
----------------------
Config.PayForVehicle = true -- If true when you rent a boat you gona pay
Config.AmountPayForVehicle = 250 -- If pay for vehile is true, this is the amount remove 
Config.Fuel = "LegacyFuel" -- Name of your fuel script
Config.VehicleKeysTrigger = "vehiclekeys:client:SetOwner" -- Trigger to give vehiclekeys

Config.Barcos = {
    [1] = {barco = "dinghy"},    -- Boat                                 
}

Config.SpawnBarcoLosSantos = { -- Locations to spawn boat SandyShores
    [1] = {x = -1827.51, y = -956.93, z = -0.14, h = 114.64},        
    [2] = {x = -1836.51, y = -946.11, z = -0.27, h = 94.39},
    -- You can add more
}

Config.SpawnBarcoPaletoBay = { -- Locations to spawn boat PaletoBay
    [1] = {x = -292.51, y = 6617.31, z = -0.40, h = 38.70},        
    [2] = {x = -294.22, y = 6637.88, z = -0.40, h = 71.35},
    -- You can add more
}

---------------
-- Fish
---------------
Config.PeixeLegal = { -- Legal Fish
	"cavala",
	"bacalhau",
	"robalo",
	"linguado",
	"fishingtin",
	"raia",
	"fishingboot",
	"salmao",
	"atum",
	"sardinha",
	"peixegato",
	"tamboril"
}

Config.PeixeIlegal = { -- Illegal Fish
	"golfinho",
	"tubaraotigre",
	"tubaraomartelo",
	"baleia",
	"fishingboot",
}

---------------
-- Upgrades
---------------
-- Upgrade Fishingrod
Config.ItemNecessario1 = "raia"					-- First item needed to upgrade fishing rod
Config.ItemNecessario1Label = "Stingray" 		-- Item name to look nice in the menu :D
Config.AmountItemNecessario1 = 25 				-- Amount of first item needed
Config.ItemNecessario2 = "bacalhau" 			-- Second item needed to upgrade fishing rod
Config.ItemNecessario2Label = "Cod" 			-- Item name to look nice in the menu :D
Config.AmountItemNecessario2 = 50 				-- Amount of second item needed

-- Upgrade Net
Config.ItemNecessarioRede1 = "raia"					-- First item needed to upgrade fishing rod
Config.ItemNecessarioRede1Label = "Stingray" 		-- Item name to look nice in the menu :D
Config.AmountItemNecessarioRede1 = 25 				-- Amount of first item needed
Config.ItemNecessarioRede2 = "bacalhau" 			-- Second item needed to upgrade fishing rod
Config.ItemNecessarioRede2Label = "Cod" 			-- Item name to look nice in the menu :D
Config.AmountItemNecessarioRede2 = 50 				-- Amount of second item needed

---------------
-- Rewards
---------------
-- Fishing with fishingrod
Config.RewardFishingRod = {
	FishingRodLevel_1 = {
		Max = 1,
		Min = 1,
	},
	FishingRodLevel_2 = {
		Max = 2,
		Min = 2,
	},
	FishingRodLevel_3 = {
		Max = 3,
		Min = 3,
	},
	FishingRodLevel_4 = {
		Max = 4,
		Min = 4,
	},
	FishingRodLevel_5 = {
		Max = 5,
		Min = 5,
	},
}

--------------------------
-- FISHING NET
--------------------------
Config.FishingNet = {
	Enable = true, -- Enable fishing net?
	BlockBoat = true, -- Block boat when is fishing with fishing net ( Not to spam multiple fishing nets )
}

Config.FishingTimeWithNet = 30000 -- 30 Seconds
Config.RewardsNetFish = {
	NetNivel_1 = {
		Max = 3,
		Min = 2,
	},
	NetNivel_2 = {
		Max = 4,
		Min = 3,
	},
	NetNivel_3 = {
		Max = 5,
		Min = 4,
	},
	NetNivel_4 = {
		Max = 6,
		Min = 5,
	},
	NetNivel_5 = {
		Max = 7,
		Min = 6,
	},
}

---------------
-- Sell Fishs
---------------
Config.EnableBlipSelling = true
Config.VendaPeixes = { -- Blip to sell fish you have caught (ONLY LEGAL FISH)
    [1] = { x = -1816.40, y = -1193.33, z =  13.305, name = "Selling Fish"},
    [2] = { x = -638.65, y = -1249.60, z =  11.81, name = "Selling Fish"},
}

-- Legal Fish
Config.PrecoCavala   	= math.random(1,5)       	-- Price of sell Mackerel
Config.PrecoBacalhau 	= math.random(1,5)      	-- Price of sell Cod
Config.PrecoRobalo   	= math.random(1,5)      	-- Price of sell Bass Fish
Config.PrecoLinguado 	= math.random(1,5)      	-- Price of sell Flounder
Config.PrecoRaia     	= math.random(1,5)      	-- Price of sell Stingrays
Config.PrecoSalmao 	 	= math.random(1,5)			-- Price of sell Stingray
Config.PrecoAtum 	 	= math.random(1,5)			-- Price of sell Tuna Fish
Config.PrecoSardinha 	= math.random(1,5)			-- Price of sell Sardine
Config.PrecoPeixeGato 	= math.random(1,5)			-- Price of sell Catfish
Config.PrecoTamboril	= math.random(1,5)			-- Price of sell Monkfish

-- Selling
Config.TypeCash = "bank" -- If you use Config.TypePayment = "cash" then here you put "bank" or "cash"
Config.TypePayment = "cash" -- "cash" or "blackmoney" or "item"
Config.PayItem = "phone" -- Item to pay if you have Config.TypePayment "item"
Config.AmountItem = {
	Min = 2,
	Max = 3,
}

Config.Markedbills = "markedbills"
Config.PrecoGolfinho      	= math.random(100,200)   	-- Price of sell Dolphins
Config.PrecoTubaraoTigre   	= math.random(200,300)   	-- Price of sell Tigersharks
Config.PrecoTubaraoMartelo  = math.random(300,400)   	-- Price of sell Hammerhead Sharks
Config.PrecoBaleia  		= math.random(400,500)   	-- Price of sell Killer Whales


---------------
-- Treasure Chest
---------------
-- QBCore
Config.CaixasRaras = { 			-- The percentage of these boxes going fishing is: 10%
	"fishingloot",
	"fishinglootbig",
}

Config.RewardDinheiroLootBox = 100   -- Cash reward when opening the box: fishingloot
Config.RewardItemLootBox = 'diamond_ring' -- Item reward when opening the box: fishingloot

Config.RewardsCaixaTesouro = { -- These items will come out in the box fishinglootbig                      
    [1] = { name = "water", price = 0, amount = math.random(1,2), info = {}, type = "item", slot = 1, },
	[2] = { name = "ouro", 	price = 0, amount = math.random(1,2), info = {}, type = "item", slot = 2, },
    [3] = { name = "phone", price = 0, amount = math.random(1,2), info = {}, type = "item", slot = 3, },
    [4] = { name = "ferro", price = 0, amount = math.random(1,2), info = {}, type = "item", slot = 4, },
    [5] = { name = "water", price = 0, amount = math.random(1,2), info = {}, type = "item", slot = 5, },
}



---------------
-- Peds
---------------
Config.PedListFishing = {                                              
	{
		model = "s_m_y_ammucity_01",                            
		coords = vector3(-1816.21, -951.54, 0.45),               
		heading = 110.0,
		gender = "male",
        scenario = "WORLD_HUMAN_STAND_FISHING"
	},
	{
		model = "s_m_y_ammucity_01",                            
		coords = vector3(-283.98, 6602.14, 0.33),               
		heading = 55.57,
		gender = "male",
        scenario = "WORLD_HUMAN_STAND_FISHING"
	},
    {
		model = "s_m_y_busboy_01",
		coords = vector3(-1816.406, -1193.334, 13.305),         
		heading = 325.172,
		gender = "male",
        scenario = "WORLD_HUMAN_CLIPBOARD"
	},
	{
		model = "a_m_y_mexthug_01",
		coords = vector3(-371.11, 277.47, 85.42),     -- Location to sell illegal fish    
		heading = 308.44,
		gender = "male",
        scenario = "WORLD_HUMAN_CLIPBOARD"
	},
	{
		model = "s_m_y_busboy_01",
		coords = vector3(-638.65, -1249.60, 10.81),         
		heading = 170.44,
		gender = "male",
        scenario = "WORLD_HUMAN_CLIPBOARD"
	},
}


------------- 
--- Police Alert Ilegal Fishing
------------
Config.ChanceChamarPolicia = 100     -- 10% probability to call cops
function AlertarPolicia(src)
	exports['ps-dispatch']:IllegalFishing()
end

------------- 
--- Notify
------------
function Notify(msg)
    if Config.Framework == "QBCore" then
        QBCore.Functions.Notify(msg)
    elseif Config.Framework == "ESX" then
        exports['mythic_notify']:DoHudText('inform', msg, 5000)
    end
end