# m-MiningJob script for QB & ESX

| If you are intested in recieving updates join the community on **[Discord](https://discord.gg/svmzYehU8R)**! |

# About
- Optimized
- Many Features
- Full and easy customization

# About
- A simple miner's job script with some new things to innovate the roleplay. Script with level system.

# Level System
- There are 5 pickaxes available, from level 1 to level 5, when they start working, they receive a level 1 pickaxe but, after gathering some wood, they can evolve to the level 2 pickaxe that will give more wood.

# Installation

1) Run the SQL

2) Install the files on folder **[DependenciesESX]**

3) If you using qs-inventory + qs-core :

**qs-core/config/config_items.lua**

	-- m-MinerJob
	["picaretalevel1"] 				= {["name"] = "picaretalevel1", 		["label"] = "Pickaxes Lvl 1", 	["weight"] = 150, 		["type"] = "item", 		["image"] = "picaretalevel1.png", 			["unique"] = false,   	["useable"] = false,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = "Simples Pickaxes.."},
	["picaretalevel2"] 				= {["name"] = "picaretalevel2", 		["label"] = "Pickaxes Lvl 2", 	["weight"] = 150, 		["type"] = "item", 		["image"] = "picaretalevel2.png", 			["unique"] = false,   	["useable"] = false,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = "Simples Pickaxes.."},
	["picaretalevel3"] 				= {["name"] = "picaretalevel3", 		["label"] = "Pickaxes Lvl 3", 	["weight"] = 150, 		["type"] = "item", 		["image"] = "picaretalevel3.png", 			["unique"] = false,   	["useable"] = false,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = "Simples Pickaxes.."},
	["picaretalevel4"] 				= {["name"] = "picaretalevel4", 		["label"] = "Pickaxes Lvl 4", 	["weight"] = 150, 		["type"] = "item", 		["image"] = "picaretalevel4.png", 			["unique"] = false,   	["useable"] = false,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = "Simples Pickaxes.."},
	["picaretalevel5"] 				= {["name"] = "picaretalevel5", 		["label"] = "Pickaxes Lvl 5", 	["weight"] = 150, 		["type"] = "item", 		["image"] = "picaretalevel5.png", 			["unique"] = false,   	["useable"] = false,    ["shouldClose"] = false,    ["combinable"] = nil,   ["description"] = "Simples Pickaxes.."},
	["oculosmineiro"] 				= {["name"] = "oculosmineiro", 			["label"] = "Protective goggles", ["weight"] = 150, 	["type"] = "item", 		["image"] = "oculosmineiro.png", 			["unique"] = false,   	["useable"] = true,    	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Protective goggles"},
	["fonesmineiro"] 				= {["name"] = "fonesmineiro", 			["label"] = "Protection Headphones", ["weight"] = 150, 		["type"] = "item", 		["image"] = "fonesmineiro.png", 			["unique"] = false,   	["useable"] = true,    	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Protection Headphones"},
	["sacomineiros"] 				= {["name"] = "sacomineiros", 			["label"] = "Bag", 			["weight"] = 150, 		["type"] = "item", 		["image"] = "sacomineiros.png", 			["unique"] = true,   	["useable"] = true,    	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Bag"},
	["pedras"] 						= {["name"] = "pedras", 				["label"] = "Stones", 			["weight"] = 150, 		["type"] = "item", 		["image"] = "pedras.png", 					["unique"] = false,   	["useable"] = true,    	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Stones.."},
	["pedraspartidas"] 				= {["name"] = "pedraspartidas", 		["label"] = "Broken stones", 	["weight"] = 150, 		["type"] = "item", 		["image"] = "pedraspartidas.png", 			["unique"] = false,   	["useable"] = true,    	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Broken stones"},
	["carvao"] 						= {["name"] = "carvao", 				["label"] = "Coal", 			["weight"] = 150, 		["type"] = "item", 		["image"] = "carvao.png", 					["unique"] = false,   	["useable"] = true,    	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Coal"},
	["ferro"] 						= {["name"] = "ferro", 					["label"] = "Iron", 			["weight"] = 150, 		["type"] = "item", 		["image"] = "ferro.png", 					["unique"] = false,   	["useable"] = true,    	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Iron"},
	["esmeralda"] 					= {["name"] = "esmeralda", 				["label"] = "Emerald", 		["weight"] = 150, 		["type"] = "item", 		["image"] = "esmeralda.png", 				["unique"] = false,   	["useable"] = true,    	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Emerald"},
	["ouro"] 						= {["name"] = "ouro", 					["label"] = "Gold", 			["weight"] = 150, 		["type"] = "item", 		["image"] = "ouro.png", 					["unique"] = false,   	["useable"] = true,    	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Gold"},
	["diamante"] 					= {["name"] = "diamante", 				["label"] = "Diamond", 		["weight"] = 150, 		["type"] = "item", 		["image"] = "diamante.png", 				["unique"] = false,   	["useable"] = true,    	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Diamond"},
	["safira"] 						= {["name"] = "safira", 				["label"] = "Sapphire", 			["weight"] = 150, 		["type"] = "item", 		["image"] = "safira.png", 					["unique"] = false,   	["useable"] = true,    	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Sapphire"},
	["titanite"] 					= {["name"] = "titanite", 				["label"] = "Titanite", 		["weight"] = 150, 		["type"] = "item", 		["image"] = "titanite.png", 				["unique"] = false,   	["useable"] = true,    	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Titanite"},
	["wolframite"] 					= {["name"] = "wolframite", 			["label"] = "Wolframite", 		["weight"] = 150, 		["type"] = "item", 		["image"] = "wolframite.png", 				["unique"] = false,   	["useable"] = true,    	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Wolframite"},
	["perovskite"] 					= {["name"] = "perovskite", 			["label"] = "Perovskite", 		["weight"] = 150, 		["type"] = "item", 		["image"] = "perovskite.png", 				["unique"] = false,   	["useable"] = true,    	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Perovskite"},
	["baryte"] 						= {["name"] = "baryte", 				["label"] = "Baryte", 			["weight"] = 150, 		["type"] = "item", 		["image"] = "baryte.png", 					["unique"] = false,   	["useable"] = true,    	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Baryte"},
	["rainbowpyrite"] 				= {["name"] = "rainbowpyrite", 			["label"] = "Rainbow Pyrite", 	["weight"] = 150, 		["type"] = "item", 		["image"] = "rainbowpyrite.png", 			["unique"] = false,   	["useable"] = true,    	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Rainbow Pyrite"},
	["maquina"] 					= {["name"] = "maquina", 				["label"] = "Machine", 			["weight"] = 150, 		["type"] = "item", 		["image"] = "maquina.png", 					["unique"] = false,   	["useable"] = true,    	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Machine"},