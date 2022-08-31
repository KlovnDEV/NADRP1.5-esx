ESX = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('FinishMoneyCheckForVeh')
RegisterNetEvent('vehshop:spawnVehicle')
local vehshop_blips = {}
local financedPlates = {}
local buyPlate = {}
local inrangeofvehshop = false
local boughtcar = false
local backlock = false
local ownerMenu = false
local currentlocation = nil
local firstspawn = 0
local commissionbuy = 0
local currentCarSpawnLocation = 0
local ammount = 0
local vehicle_price = 0
local seller = ''
local NewPlate
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local vehshopDefault = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 250, type = 1 },
	menu = {
		x = 0.14,
		y = 0.15,
		width = 0.12,
		height = 0.03,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.29,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Vehicles", description = ""},
				{name = "Cycles", description = ""},
			}
		},
		["vehicles"] = {
			title = "VEHICLES",
			name = "vehicles",
			buttons = {
				{name = "Job Vehicles", description = ''},
			}
		},
		["jobvehicles"] = {
			title = "job vehicles",
			name = "job vehicles",
			buttons = {
				{name = "Taxi Cab", costs = 4000, description = {}, model = "taxi"},
				{name = "Flat Bed", costs = 4000, description = {}, model = "flatbed"},
				{name = "News Rumpo", costs = 4000, description = {}, model = "rumpo"},
				{name = "Taco Truck", costs = 4000, description = {}, model = "taco"},

			}
		},
		["cycles"] = {
			title = "cycles",
			name = "cycles",
			buttons = {
				{name = "BMX", costs = 150, description = {}, model = "bmx"},
				{name = "Cruiser", costs = 240, description = {}, model = "cruiser"},
				{name = "Fixter", costs = 270, description = {}, model = "fixter"},
				{name = "Scorcher", costs = 300, description = {}, model = "scorcher"},
				{name = "Pro 1", costs = 2500, description = {}, model = "tribike"},
				{name = "Pro 2", costs = 2600, description = {}, model = "tribike2"},
				{name = "Pro 3", costs = 2900, description = {}, model = "tribike3"},
			}
		},		
	}
}

vehshop = vehshopDefault
local vehshopOwner = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 250, type = 1 },
	menu = {
		x = 0.14,
		y = 0.15,
		width = 0.12,
		height = 0.03,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.29,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Vehicles", description = ""},
				{name = "Motorcycles", description = ""},
				{name = "Cycles", description = ""},
			}
		},
		["vehicles"] = {
			title = "VEHICLES",
			name = "vehicles",
			buttons = {
				{name = "Job Vehicles", description = ''},
				{name = "Compacts", description = ''},
				{name = "Coupes", description = ''},
				{name = "Sedans", description = ''},
				{name = "Sports", description = ''},
				{name = "Sports Classics", description = ''},
				{name = "casino", description = ''},
				{name = "Muscle", description = ''},
				{name = "Off-Road", description = ''},
				{name = "SUVs", description = ''},
				{name = "Vans", description = ''},
			}
		},
		["jobvehicles"] = {
			title = "job vehicles",
			name = "job vehicles",
			buttons = {
				{name = "Taxi Cab", costs = 4000, description = {}, model = "taxi"},
		--		{name = "Flat Bed", costs = 4000, description = {}, model = "flatbed"},
  		        {name = "Taco Truck", costs = 4000, description = {}, model = "taco"},								
				{name = "News Rumpo", costs = 4000, description = {}, model = "rumpo"},
			}
		},
		["compacts"] = {
			title = "compacts",
			name = "compacts",
			buttons = {			
				{name = "Blista", costs = 12000, description = {}, model = "blista"},
				{name = "Brioso R/A", costs = 42000, description = {}, model = "brioso"},
				{name = "Dilettante", costs = 7000, description = {}, model = "Dilettante"},
				{name = "Issi", costs = 14000, description = {}, model = "issi2"},
				{name = "Panto", costs = 12000, description = {}, model = "panto"},
				{name = "Prairie", costs = 20000, description = {}, model = "prairie"},
				{name = "Rhapsody", costs = 12000, description = {}, model = "rhapsody"},
				{name = "Caddy", costs = 12000, description = {}, model = "caddy"},
		
			}
		},
		["coupes"] = {
			title = "coupes",
			name = "coupes",
			buttons = {
				{name = "Cognoscenti Cabrio", costs = 100000, description = {}, model = "cogcabrio"},
				{name = "Exemplar", costs = 80000, description = {}, model = "exemplar"},
				{name = "F620", costs = 56000, description = {}, model = "f620"},
				{name = "Felon", costs = 55000, description = {}, model = "felon"},
				{name = "Felon GT", costs = 60000, description = {}, model = "felon2"},
				{name = "Jackal", costs = 110000, description = {}, model = "jackal"},
				{name = "Oracle", costs = 115000, description = {}, model = "oracle"},
				{name = "Oracle XS", costs = 130000, description = {}, model = "oracle2"},
				{name = "Sentinel", costs = 80000, description = {}, model = "sentinel"},
				{name = "Sentinel XS", costs = 70000, description = {}, model = "sentinel2"},
				{name = "Windsor", costs = 120000, description = {}, model = "windsor"},
				{name = "Windsor Drop", costs = 112000, description = {}, model = "windsor2"},
				{name = "Zion", costs = 70000, description = {}, model = "zion"},
				{name = "Zion Cabrio", costs = 78000, description = {}, model = "zion2"},
			}
		},
		["sports"] = {
			title = "sports",
			name = "sports",
			buttons = {
				{name = "Futo", costs = 70000, description = {}, model = "futo"},
				{name = "9F", costs = 120000, description = {}, model = "ninef"},
				{name = "9F Cabrio", costs = 130000, description = {}, model = "ninef2"},
				{name = "Alpha", costs = 150000, description = {}, model = "alpha"},
				{name = "Banshee", costs = 165000, description = {}, model = "banshee"},
				{name = "Bestia GTS", costs = 185000, description = {}, model = "bestiagts"},
				{name = "Buffalo", costs = 40000, description = {}, model = "buffalo"},
				{name = "Buffalo S", costs = 89000, description = {}, model = "buffalo2"},
				{name = "Carbonizzare", costs = 160000, description = {}, model = "carbonizzare"},
				{name = "Comet", costs = 185000, description = {}, model = "comet2"},
				{name = "Coquette", costs = 140000, description = {}, model = "coquette"},
				{name = "Feltzer", costs = 120000, description = {}, model = "feltzer2"},
				{name = "Furore GT", costs = 170000, description = {}, model = "furoregt"},
				{name = "Fusilade", costs = 80000, description = {}, model = "fusilade"},
				{name = "Jester", costs = 150000, description = {}, model = "jester"},
				{name = "Kuruma", costs = 134000, description = {}, model = "kuruma"},
				{name = "Lynx", costs = 160000, description = {}, model = "lynx"},
				{name = "Massacro", costs = 130000, description = {}, model = "massacro"},
				{name = "Omnis", costs = 156000, description = {}, model = "omnis"},
				{name = "Penumbra", costs = 50000, description = {}, model = "penumbra"},
				{name = "Rapid GT", costs = 100000, description = {}, model = "rapidgt"},
				{name = "Rapid GT Convertible", costs = 120000, description = {}, model = "rapidgt2"},
				{name = "Schafter V12", costs = 140000, description = {}, model = "schafter3"},
				{name = "Sultan", costs = 100000, description = {}, model = "sultan"},
				{name = "Surano", costs = 130000, description = {}, model = "surano"},
				{name = "Tropos", costs = 170000, description = {}, model = "tropos"},
				{name = "Verkierer", costs = 195000, description = {}, model = "verlierer2"},
				{name = "Comet SR", costs = 220000, description = {}, model = "comet5"},
				{name = "Sentinel Classic", costs = 120000, description = {}, model = "sentinel3"},
				{name = "Streiter", costs = 130000, description = {}, model = "streiter"},
				{name = "Comet Safari", costs = 230000, description = {}, model = "comet4"},
				{name = "Pariah", costs = 165000, description = {}, model = "pariah"},
				{name = "Elegy", costs = 170000, description = {}, model = "elegy2"},
				{name = "Jester Classic", costs = 175000, description = {}, model = "jester2"},
				{name = "Jester Classic 2", costs = 200000, description = {}, model = "jester3"},
				{name = "Infernus Classic", costs = 250000, description = {}, model = "infernus2"},
				{name = "Cheetah Classic ", costs = 220000, description = {}, model = "cheetah2"},
				{name = "Turismo Classic ", costs = 252000, description = {}, model = "turismo2"},
				{name = "Raptor ", costs = 125000, description = {}, model = "raptor"},
				{name = "Comet Custom", costs = 320000, description = {}, model = "comet3"},
				{name = "Flash GT", costs = 150000, description = {}, model = "flashgt"},
				{name = "GB200", costs = 160000, description = {}, model = "gb200"},
				{name = "Khamelion", costs = 120000, description = {}, model = "khamelion"},
				{name = "Raiden", costs = 130000, description = {}, model = "raiden"},
				{name = "schlagengt", costs = 300000, description = {}, model = "schlagen"},
				{name = "neon", costs = 190000, description = {}, model = "neon"},
				{name = "Specter2", costs = 300000, description = {}, model = "specter2"},

			}
		},
		["sportsclassics"] = {
			title = "sports classics",
			name = "sportsclassics",
			buttons = {
				{name = "Casco", costs = 280000, description = {}, model = "casco"},
				{name = "Coquette Classic", costs = 240000, description = {}, model = "coquette2"},
				{name = "JB 700", costs = 190000, description = {}, model = "jb700"},
				{name = "Pigalle", costs = 110000, description = {}, model = "pigalle"},
				{name = "Stinger", costs = 210000, description = {}, model = "stinger"},
				{name = "Stinger GT", costs = 235000, description = {}, model = "stingergt"},
				{name = "Stirling GT", costs = 275000, description = {}, model = "feltzer3"},
				{name = "Rapid GT Classic", costs = 260000, description = {}, model = "rapidgt3"},
				{name = "Retinue", costs = 150000, description = {}, model = "retinue"},
				{name = "Viseris", costs = 230000, description = {}, model = "viseris"}, 
				{name = "190z", costs = 240000, description = {}, model = "z190"},
				{name = "GT500", costs = 270000, description = {}, model = "gt500"},
				{name = "Savestra", costs = 165000, description = {}, model = "savestra"},
				{name = "ElegyCustom", costs = 400000, description = {}, model = "elegy"},
				{name = "Monroe", costs = 225000, description = {}, model = "monroe"},
				{name = "Stafford", costs = 225000, description = {}, model = "stafford"},
				{name = "btype1", costs = 170000, description = {}, model = "btype"},
				{name = "btype2", costs = 190000, description = {}, model = "btype2"},
				{name = "Swinger", costs = 300000, description = {}, model = "swinger"},
		
				
				
			}
		},
		
		
		["casino"] = {
			title = "casino",
			name = "casino",
			buttons = {
				{name = "Jugular", costs = 175000, description = {}, model = "jugular"},
				{name = "Peyote", costs = 75000, description = {}, model = "peyote2"},
				{name = "Gauntlet 4", costs = 150000, description = {}, model = "gauntlet4"},
				{name = "Caracara", costs = 160000, description = {}, model = "caracara2"},
				{name = "Novak", costs = 140000, description = {}, model = "Novak"},
				{name = "Issi 7", costs = 140000, description = {}, model = "issi7"},
				{name = "Hellion", costs = 110000, description = {}, model = "hellion"},
				{name = "Dynasty", costs = 20000, description = {}, model = "Dynasty"},
				{name = "Gauntlet 3", costs = 130000, description = {}, model = "gauntlet3"},
				{name = "Nebula", costs = 83000, description = {}, model = "nebula"},
				{name = "Zion 3", costs = 75000, description = {}, model = "zion3"},
				{name = "Drafter", costs = 140000, description = {}, model = "drafter"},
				{name = "Komoda", costs = 146000, description = {}, model = "komoda"},
				{name = "Rebla", costs = 110000, description = {}, model = "rebla"},
				{name = "Retinue", costs = 80000, description = {}, model = "retinue2"},
				{name = "Sugoi", costs = 105000, description = {}, model = "sugoi"},
				{name = "Sultan 2", costs = 155000, description = {}, model = "sultan2"},
				{name = "VSTR", costs = 186000, description = {}, model = "vstr"},
				{name = "KANJO", costs = 30000, description = {}, model = "kanjo"},
				{name = "Everon", costs = 175000, description = {}, model = "everon"},
				{name = "Outlaw", costs = 230000, description = {}, model = "outlaw"},
				{name = "Vagrant", costs = 175000, description = {}, model = "vagrant"},
				{name = "Asbo", costs = 29000, description = {"josh harris 2020"}, model = "asbo"},
				{name = "Locust", costs = 250000, description = {}, model = "locust"},
				{name = "Paragon", costs = 375000, description = {}, model = "paragon"},
				{name = "imorgon", costs = 320000, description = {}, model = "imorgon"},

			}
		},
		
		["muscle"] = {
			title = "muscle",
			name = "muscle",
			buttons = {
				{name = "Blade", costs = 45700, description = {}, model = "blade"},
				{name = "Buccaneer", costs = 36000, description = {}, model = "buccaneer"},
				{name = "Chino", costs = 29000, description = {}, model = "chino"},
				{name = "Coquette BlackFin", costs = 55500, description = {}, model = "coquette3"},
				{name = "Dominator", costs = 100000, description = {}, model = "dominator"},
				{name = "Dukes", costs = 40000, description = {}, model = "dukes"},
				{name = "Gauntlet", costs = 75000, description = {}, model = "gauntlet"},
				{name = "Faction", costs = 36000, description = {}, model = "faction"},
				{name = "Picador", costs = 36000, description = {}, model = "picador"},
				{name = "Sabre Turbo", costs = 57000, description = {}, model = "sabregt"},
				{name = "Tampa", costs = 35000, description = {}, model = "tampa"},
				{name = "Virgo", costs = 38000, description = {}, model = "virgo"},
				{name = "Vigero", costs = 70000, description = {}, model = "vigero"},
				{name = "Elliie", costs = 150000, description = {}, model = "ellie"},
				{name = "Phoenix", costs = 35000, description = {}, model = "phoenix"},
				{name = "Tulip", costs = 110000, description = {}, model = "tulip"},
				{name = "Impaler", costs = 90000, description = {}, model = "impaler"},
				{name = "Nightshade", costs = 130000, description = {}, model = "nightshade"},
				{name = "Vamos", costs = 110000, description = {}, model = "vamos"},
				{name = "Dominator gt", costs = 120000, description = {}, model = "dominator3"},
				{name = "Hotknife", costs = 90000, description = {}, model = "hotknife"},
				{name = "Hustler", costs = 80000, description = {}, model = "hustler"},
				{name = "Slam van custom", costs = 170000, description = {}, model = "slamvan3"},
				{name = "Sabre GT custom", costs = 150000, description = {}, model = "sabregt2"},
				{name = "Lurcher", costs = 60000, description = {}, model = "lurcher"},
				
			}
		},
		["offroad"] = {
			title = "off-road",
			name = "off-road",
			buttons = {
				{name = "Bifta", costs = 50000, description = {}, model = "bifta"},
				{name = "Blazer", costs = 18000, description = {}, model = "blazer"},
				{name = "Brawler", costs = 71500, description = {}, model = "brawler"},
				{name = "Dune Buggy", costs = 19000, description = {}, model = "dune"},
				{name = "Rebel", costs = 45000, description = {}, model = "rebel2"},
				{name = "Sandking", costs = 55000, description = {}, model = "sandking"},
				{name = "Riata", costs = 75000, description = {}, model = "riata"},
				{name = "Kamacho", costs = 90000, description = {}, model = "kamacho"},
				{name = "Trophy Truck", costs = 200000, description = {}, model = "trophytruck"},
				{name = "Mesa 3", costs = 130000, description = {}, model = "mesa3"},
			}
		},
		["suvs"] = {
			title = "suvs",
			name = "suvs",
			buttons = {
				{name = "Cavalcade", costs = 39000, description = {}, model = "cavalcade2"},
				{name = "Granger", costs = 55000, description = {}, model = "granger"},
				{name = "Huntley S", costs = 75000, description = {}, model = "huntley"},
				{name = "Landstalker", costs = 38000, description = {}, model = "landstalker"},
				{name = "Radius", costs = 46000, description = {}, model = "radi"},
				{name = "Rocoto", costs = 85000, description = {}, model = "rocoto"},
				{name = "Seminole", costs = 31000, description = {}, model = "seminole"},
				{name = "XLS", costs = 55000, description = {}, model = "xls"},
				{name = "Dubsta", costs = 75000, description = {}, model = "dubsta"},
				{name = "Patriot", costs = 65000, description = {}, model = "patriot"},
				{name = "Gresley", costs = 40000, description = {}, model = "gresley"},
		
			}
		},
		["vans"] = {
			title = "vans",
			name = "vans",
			buttons = {
				{name = "Bison", costs = 30000, description = {}, model = "bison"},
				{name = "Bobcat XL", costs = 15000, description = {}, model = "bobcatxl"},
				{name = "Gang Burrito", costs = 55000, description = {}, model = "gburrito"},
				{name = "Journey", costs = 15000, description = {}, model = "journey"},
				{name = "Minivan", costs = 13000, description = {}, model = "minivan"},
				{name = "Paradise", costs = 15000, description = {}, model = "paradise"},
				{name = "Surfer", costs = 15000, description = {}, model = "surfer"},
				{name = "Youga", costs = 16000, description = {}, model = "youga"},
				{name = "Moonbeam", costs = 23000, description = {}, model = "moonbeam"},
				{name = "Camper", costs = 18000, description = {}, model = "camper"},
			}
		},
		["sedans"] = {
			title = "sedans",
			name = "sedans",
			buttons = {
				{name = "Emperor", costs = 25000, description = {}, model = "emperor2"},
				{name = "Tornado", costs = 22000, description = {}, model = "tornado3"},
				{name = "Tornado +", costs = 34900, description = {}, model = "tornado6"},
				{name = "Bodhi", costs = 25000, description = {}, model = "bodhi2"},		
				{name = "Asea", costs = 31000, description = {}, model = "asea"},
				{name = "Asterope", costs = 28000, description = {}, model = "asterope"},
				{name = "Fugitive", costs = 37000, description = {}, model = "fugitive"},
				{name = "Glendale", costs = 32000, description = {}, model = "glendale"},
				{name = "Intruder", costs = 35000, description = {}, model = "intruder"},
				{name = "Premier", costs = 36000, description = {}, model = "premier"},
				{name = "Regina", costs = 32000, description = {}, model = "regina"},
				{name = "Schafter", costs = 49000, description = {}, model = "schafter2"},
				{name = "Stanier", costs = 25000, description = {}, model = "stanier"},
				{name = "Stratum", costs =28000, description = {}, model = "stratum"},
				{name = "Super Diamond", costs = 150000, description = {}, model = "superd"},
				{name = "Warrener", costs = 54000, description = {}, model = "warrener"},
				{name = "Washington", costs = 35000, description = {}, model = "washington"},
				{name = "Tailgater", costs = 36000, description = {}, model = "tailgater"},
				{name = "Cognoscenti", costs = 110000, description = {}, model = "cognoscenti"},
		
			}
		},
		["motorcycles"] = {
			title = "motorcycles",
			name = "motorcycles",
			buttons = {
				{name = "Akuma", costs = 80000, description = {}, model = "AKUMA"},
				{name = "Bagger", costs = 60000, description = {}, model = "bagger"},
				{name = "Bati 801", costs = 75000, description = {}, model = "bati"},
				{name = "BF400", costs = 72000, description = {}, model = "bf400"},
				{name = "Carbon RS", costs = 75000, description = {}, model = "carbonrs"},
				{name = "Daemon", costs = 45000, description = {}, model = "daemon"},
				{name = "Enduro", costs = 59000, description = {}, model = "enduro"},
				{name = "Faggio", costs = 15000, description = {}, model = "faggio"},
				{name = "Gargoyle", costs = 65000, description = {}, model = "gargoyle"},
				{name = "Hexer", costs = 65000, description = {}, model = "hexer"},
				{name = "Innovation", costs = 75000, description = {}, model = "innovation"},
				{name = "Nemesis", costs = 70000, description = {}, model = "nemesis"},
				{name = "PCJ-600", costs = 75000, description = {}, model = "pcj"},
				{name = "Ruffian", costs = 64000, description = {}, model = "ruffian"},
				{name = "Sanchez", costs = 65000, description = {}, model = "sanchez"},
				{name = "Sovereign", costs = 159000, description = {}, model = "sovereign"},
				{name = "Zombiea", costs = 65000, description = {}, model = "zombiea"},
				{name = "Vespa", costs = 75000, description = {}, model = "faggio2"},
				{name = "Manchez", costs = 77000, description = {}, model = "manchez"},
				{name = "Vortex", costs = 90000, description = {}, model = "vortex"},
				{name = "Avarus", costs = 65000, description = {}, model = "avarus"},
				{name = "Vader", costs = 75000, description = {}, model = "vader"},
				{name = "Esskey", costs = 75000, description = {}, model = "esskey"},
				{name = "Defiler", costs = 95000, description = {}, model = "defiler"},
				{name = "Chimera", costs = 72000, description = {}, model = "chimera"},
				{name = "Daemon", costs = 79000, description = {}, model = "daemon"},
				{name = "DaemonHigh", costs = 85000, description = {}, model = "daemon2"},
				{name = "Nightblade", costs = 80000, description = {}, model = "nightblade"},	
				{name = "Sanctus", costs = 80000, description = {}, model = "sanctus"},	
				{name = "Wolfsbane", costs = 65000, description = {}, model = "wolfsbane"},
				{name = "Hakuchou Drag", costs = 100000, description = {}, model = "hakuchou2"},
				{name = "Fcr1000", costs = 75000, description = {}, model = "fcr2"},
				--{name = "Shotaro", costs = 120000, description = {}, model = "shotaro"},
				{name = "Hakuchou", costs = 80000, description = {}, model = "hakuchou"},
				{name = "Stryder", costs = 95000, description = {}, model = "stryder"},
				{name = "Cliffhanger", costs = 75000, description = {}, model = "cliffhanger"},
				{name = "Diablous 2", costs = 100000, description = {}, model = "diablous2"},
				{name = "Vindicator", costs = 75000, description = {}, model = "vindicator"},
				{name = "Thrust", costs = 65000, description = {}, model = "thrust"},
				{name = "Diablous", costs = 75500, description = {}, model = "diablous"},
				{name = "Lectro", costs = 70000, description = {}, model = "lectro"},
				{name = "Rat Bike", costs = 75000, description = {}, model = "ratbike"},
				{name = "Faggio Mod", costs = 20000, description = {}, model = "faggio3"},
				{name = "Yamaha R1", costs = 200000, description = {}, model = "r1"},--5
				--{name = "Yamaha 1700 MAX", costs = 150000, description = {}, model = "Y1700MAX"},--5
				{name = "Harley Davidson", costs = 170000, description = {}, model = "HDIron883"},--5
				--{name = "KTM RC390 ", costs = 200000, description = {}, model = "KTMRC39019"},--5
				--{name = "Honder CB650R", costs = 200000, description = {}, model = "cb650r"},--5
			}
		},
		["cycles"] = {
			title = "cycles",
			name = "cycles",
			buttons = {
				{name = "BMX", costs = 550, description = {}, model = "bmx"},
				{name = "Cruiser", costs = 240, description = {}, model = "cruiser"},
				{name = "Fixter", costs = 270, description = {}, model = "fixter"},
				{name = "Scorcher", costs = 300, description = {}, model = "scorcher"},
				{name = "Pro 1", costs = 1500, description = {}, model = "tribike"},
				{name = "Pro 2", costs = 1600, description = {}, model = "tribike2"},
				{name = "Pro 3", costs = 1900, description = {}, model = "tribike3"},
			}
		},
	}
}




local fakecar = {model = '', car = nil}
local vehshop_locations = {
	{
		entering = {-33.737,-1102.322,26.422},
		inside = {-61.166320800781,-1107.8854980469,26.43579864502,76.141090393066},
		outside = {-61.166320800781,-1107.8854980469,26.43579864502,76.141090393066},
	}
}

local carspawns = {
	[1] =  { ['x'] = -38.25,['y'] = -1104.18,['z'] = 26.43,['h'] = 14.46, ['info'] = ' Car Spot 1' },
	[2] =  { ['x'] = -36.36,['y'] = -1097.3,['z'] = 26.43,['h'] = 109.4, ['info'] = ' Car Spot 2' },
	[3] =  { ['x'] = -43.11,['y'] = -1095.02,['z'] = 26.43,['h'] = 67.77, ['info'] = ' Car Spot 3' },
	[4] =  { ['x'] = -50.45,['y'] = -1092.66,['z'] = 26.43,['h'] = 116.33, ['info'] = ' Car Spot 4' },
	[5] =  { ['x'] = -56.24,['y'] = -1094.33,['z'] = 26.43,['h'] = 157.08, ['info'] = ' Car Spot 5' },
	[6] =  { ['x'] = -49.73,['y'] = -1098.63,['z'] = 26.43,['h'] = 240.99, ['info'] = ' Car Spot 6' },
	[7] =  { ['x'] = -45.58,['y'] = -1101.4,['z'] = 26.43,['h'] = 287.3, ['info'] = ' Car Spot 7' },
}

local carTable = {
	[1] = { ["model"] = "gauntlet", ["baseprice"] = 100000, ["commission"] = 15 }, 
	[2] = { ["model"] = "dubsta3", ["baseprice"] = 100000, ["commission"] = 15 },
	[3] = { ["model"] = "landstalker", ["baseprice"] = 100000, ["commission"] = 15 },
	[4] = { ["model"] = "bobcatxl", ["baseprice"] = 100000, ["commission"] = 15 },
	[5] = { ["model"] = "surfer", ["baseprice"] = 100000, ["commission"] = 15 },
	[6] = { ["model"] = "glendale", ["baseprice"] = 100000, ["commission"] = 15 },
	[7] = { ["model"] = "washington", ["baseprice"] = 100000, ["commission"] = 15 },
}

function updateCarTable(model,price,name)
	carTable[currentCarSpawnLocation]["model"] = model
	carTable[currentCarSpawnLocation]["baseprice"] = price
	carTable[currentCarSpawnLocation]["name"] = name
	TriggerServerEvent("carshop:table",carTable)
end

local myspawnedvehs = {}

RegisterNetEvent("car:testdrive")
AddEventHandler("car:testdrive", function()
	if job ~= 'pdm' or #(vector3(-51.51, -1077.96, 26.92) - GetEntityCoords(PlayerPedId())) > 50.0 then
		return
	end

	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		exports["mythic_notify"]:SendAlert('error', 'Could not locate vehicle')
		return
	end

	local model = GetEntityModel(veh)
	local veh = GetClosestVehicle(-51.51, -1077.96, 26.92, 3.000, 0, 70)

	if not DoesEntityExist(veh) then

		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local veh = CreateVehicle(model,-51.51, -1077.96, 26.92,80.0,true,false)
		local vehplate = "CAR"..math.random(10000,99999)
		SetVehicleNumberPlateText(veh, vehplate)
		Citizen.Wait(100)
		TriggerEvent("ARPF:spawn:recivekeys", veh,vehplate)
		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)

		TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)
		myspawnedvehs[veh] = true
	else
		exports["mythic_notify"]:SendAlert('error', 'A car is on the spawn point.')
	end
end)

RegisterNetEvent("finance")
AddEventHandler("finance", function()
	if #(vector3(-51.51, -1077.96, 26.92) - GetEntityCoords(PlayerPedId())) > 50.0 then
		return
	end

	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		exports["mythic_notify"]:SendAlert('error', 'Could not locate vehicle')
		return
	end
	local vehplate = GetVehicleNumberPlateText(veh)
	TriggerServerEvent("finance:enable",vehplate)
end)

RegisterNetEvent("buyEnable")
AddEventHandler("buyEnable", function()
	if #(vector3(-51.51, -1077.96, 26.92) - GetEntityCoords(PlayerPedId())) > 50.0 and job == 'pdm' then
		return
	end

	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		exports["mythic_notify"]:SendAlert('error', 'Could not locate vehicle')
		return
	end
	local vehplate = GetVehicleNumberPlateText(veh)
	TriggerServerEvent("buy:enable",vehplate)
end)

RegisterNetEvent("finance:enableOnClient")
AddEventHandler("finance:enableOnClient", function(addplate,employee)
	seller = employee
	financedPlates[addplate] = true
	Citizen.Wait(60000)
	financedPlates[addplate] = nil
	seller = ''
end)

RegisterNetEvent("buy:enableOnClient")
AddEventHandler("buy:enableOnClient", function(addplate,employee)
	seller = employee
	buyPlate[addplate] = true
	Citizen.Wait(60000)
	buyPlate[addplate] = nil
	seller = ''
end)

RegisterNetEvent("commission")
AddEventHandler("commission", function(newAmount)
	if job ~= 'pdm' or #(vector3(-51.51, -1077.96, 26.92) - GetEntityCoords(PlayerPedId())) > 50.0 then
		return
	end

	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			carTable[i]["commission"] = tonumber(newAmount)
			TriggerServerEvent("carshop:table",carTable)
		end
	end
end)

RegisterNetEvent("veh_shop:returnTable")
AddEventHandler("veh_shop:returnTable", function(newTable)
	carTable = newTable
	DespawnSaleVehicles()
	SpawnSaleVehicles()
end)

local hasspawned = false
local spawnedvehicles = {}
local vehicles_spawned = false

function BuyMenu()
	for i = 1, #carspawns do

		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			local veh = GetClosestVehicle(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], 3.000, 0, 70)
			local addplate = GetVehicleNumberPlateText(veh)
			if GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= nil and GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= 0 then
				ClearPedTasksImmediately(PlayerPedId())
			end
			DisableControlAction(0,23)
			if IsControlJustReleased(0,47) and buyPlate[addplate] ~= nil then
				exports["mythic_notify"]:SendAlert('inform', 'Attempting Purchase')
				AttemptBuy(i,false)
			end

			if IsControlJustReleased(0,23) or IsDisabledControlJustReleased(0,23) then
				if financedPlates[addplate] ~= nil then
					exports["mythic_notify"]:SendAlert('inform', 'Attempting Purchase')
					AttemptBuy(i,true)
				end
			end
		end
	end
end

function AttemptBuy(tableid,financed)

	local veh = GetClosestVehicle(carspawns[tableid]["x"],carspawns[tableid]["y"],carspawns[tableid]["z"], 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		exports["mythic_notify"]:SendAlert('error', 'Could not locate vehicle')
		return
	end

	if financed then
		print("financed")
	end

	local model = carTable[tableid]["model"]
	local commission = carTable[tableid]["commission"]
	local baseprice = carTable[tableid]["baseprice"]
	local name = carTable[tableid]["name"]
	local price = baseprice + (baseprice * commission/ 100)

	--if baseprice > 10000 and not financed then
	--	exports['mythic_notify']:SendAlert('error', 'This vehicle must be financed.')
	--	return
	--end

	currentlocation = vehshop_blips[1]
	TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)
	TriggerServerEvent('CheckMoneyForVeh',name, model, price, financed, commission)
	commissionbuy = (baseprice * commission / 100)
end

function OwnerMenu()
	if not vehshop.opened then
		currentCarSpawnLocation = 0
		ownerMenu = false
	end
	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			ownerMenu = true
			currentCarSpawnLocation = i
			if IsControlJustReleased(0,38) then
				exports['mythic_notify']:SendAlert('inform', 'We Opened')
				if vehshop.opened then
					CloseCreator()
				else
					OpenCreator()
				end
			end
		end
	end
end

function DrawPrices()
	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.5 then
			local commission = carTable[i]["commission"]
			local baseprice = carTable[i]["baseprice"]
			local price = baseprice + (baseprice * commission/100)
	
			local veh = GetClosestVehicle(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], 3.000, 0, 70)
			local addplate = GetVehicleNumberPlateText(veh)
			if job == 'pdm' then
				if financedPlates[addplate] ~= nil and buyPlate[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " | Com: %" ..commission.. " | [E] to change | [G] to buy | [F] to Finance ")
				elseif financedPlates[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " | Com: %" ..commission.. " | [E] to change | [F] to Finance ")
				elseif buyPlate[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " | Com: %" ..commission.. " | [E] to change | [G] to buy. ")
				else
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " | Com: %" ..commission.. " | [E] to change")
				end
			else
				if financedPlates[addplate] ~= nil and buyPlate[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " [G] to buy | $" .. math.ceil(price/4) .. " upfront, $" .. math.ceil(price) .. " over 10 weeks, [F] to finance. ")
				elseif financedPlates[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], "$" .. math.ceil(price/4) .. " upfront, $" .. math.ceil(price) .. " over 10 weeks, [F] to finance. ")
				elseif buyPlate[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " [G] to buy. ")
				else
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"Buy Price: $" .. math.ceil(price) .. " ")
				end
			end
		end
	end
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function SpawnSaleVehicles()
	if started then 
		return
	end
	started = true
	if not hasspawned then
		TriggerServerEvent("carshop:requesttable")
		print("requesting table")
		Citizen.Wait(1500)
	end
	DespawnSaleVehicles()
	hasspawned = true
	for i = 1, #carTable, 1 do
		local model = GetHashKey(carTable[i]["model"])
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
		local veh = CreateVehicle(model,carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]-1,carspawns[i]["h"],false,false)
		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)
		SetEntityInvincible(veh,true)

		FreezeEntityPosition(veh,true)
		spawnedvehicles[#spawnedvehicles+1] = veh
		SetVehicleNumberPlateText(veh, "PDM ".. i)
	end
	vehicles_spawned = true
	started = false
end

function DespawnSaleVehicles()
	for i = 1, #spawnedvehicles do
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(spawnedvehicles[i]))
	end
	vehicles_spawned = false
end


Controlkey = {["generalUse"] = {38,"E"},["generalUseSecondary"] = {191,"Enter"}}
RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
	Controlkey["generalUse"] = table["generalUse"]
	Controlkey["generalUseSecondary"] = table["generalUseSecondary"]
end)

--[[Functions]]--

function LocalPed()
	return PlayerPedId()
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function IsPlayerInRangeOfVehshop()
	return inrangeofvehshop
end

function ShowVehshopBlips(bool)
	if bool and #vehshop_blips == 0 then
		for station,pos in pairs(vehshop_locations) do
			local loc = pos
			pos = pos.entering
			local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
			-- 60 58 137
			SetBlipSprite(blip,326)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Vehicle Shop')
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip,true)
			SetBlipAsMissionCreatorBlip(blip,true)
			SetBlipScale(blip, 0.8)
			SetBlipColour(blip, 3)
			vehshop_blips[#vehshop_blips+1]= {blip = blip, pos = loc}
		end
		Citizen.CreateThread(function()
			while #vehshop_blips > 0 do
				Citizen.Wait(1)
				local inrange = false

				if #(vector3(-45.98,-1082.97, 26.27) - GetEntityCoords(LocalPed())) < 5.0 then
					local veh = GetVehiclePedIsUsing(LocalPed())
					if myspawnedvehs[veh] ~= nil then
						DrawText3D(-45.98,-1082.97, 26.27,"["..Controlkey["generalUse"][2].."] return vehicle")
						if IsControlJustReleased(0,Controlkey["generalUse"][1]) then
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
						end
					end
				end

				for i,b in ipairs(vehshop_blips) do
					if #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) < 100 then
						currentlocation = b
						if not vehicles_spawned then
							print("Spawning Display Vehicles?")
							SpawnSaleVehicles()
						end
						if #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) < 25 then
							DrawPrices()
						end

						DrawMarker(27,b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]-0.9,0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,50,0,0,0,0)

						if vehshop.opened == false and IsPedInAnyVehicle(LocalPed(), true) == false and #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) <= 1 then
							DisplayHelpText('~b~'..Controlkey["generalUse"][2]..'~s~ to browse')
							inrange = true
						end

						if vehshop.opened == true then
							DisplayHelpText('~b~'..Controlkey["generalUse"][2]..'~s~ or ~b~'..Controlkey["generalUseSecondary"][2]..'~s~ Accepts ~b~Arrows~s~ Move ~b~Backspace~s~ Exit')
						end

						if job == 'pdm' then
							OwnerMenu()
						end
						BuyMenu()
					else
						if vehicles_spawned then
							print("Despawning Display ?")
							DespawnSaleVehicles()
						end
						Citizen.Wait(1000)
					end
				end
				inrangeofvehshop = inrange
			end
		end)
	elseif bool == false and #vehshop_blips > 0 then
		for i,b in ipairs(vehshop_blips) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		vehshop_blips = {}
	end
end

function f(n)
	return n + 0.0001
end

function try(f, catch_f)
	local status, exception = pcall(f)
	if not status then
		catch_f(exception)
	end
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function OpenCreator()
	boughtcar = false
	if ownerMenu then
		vehshop = vehshopOwner
	else
		vehshop = vehshopDefault
	end

	local ped = LocalPed()
	local pos = currentlocation.pos.inside
	FreezeEntityPosition(ped,true)
	SetEntityVisible(ped,false)
	local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,pos[1],pos[2],pos[3],Citizen.PointerValueFloat(),0)
	SetEntityCoords(ped,pos[1],pos[2],g)
	SetEntityHeading(ped,pos[4])

	vehshop.currentmenu = "main"
	vehshop.opened = true
	vehshop.selectedbutton = 0
end

function CloseCreator(name, veh, price, financed, commission)
	Citizen.CreateThread(function()
		local ped = LocalPed()
		local pPrice = price
		if not boughtcar then
			local pos = currentlocation.pos.entering
			SetEntityCoords(ped,pos[1],pos[2],pos[3])
			FreezeEntityPosition(ped,false)
			SetEntityVisible(ped,true)
		else
			local name = name
			local vehicle = veh
			local price = price
			local veh = GetVehiclePedIsUsing(ped)
			local model = GetEntityModel(veh)
			local colors = table.pack(GetVehicleColours(veh))
			local extra_colors = table.pack(GetVehicleExtraColours(veh))

			local mods = {}
			for i = 0,24 do
				mods[i] = GetVehicleMod(veh,i)
			end
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
			local pos = currentlocation.pos.outside

			FreezeEntityPosition(ped,false)
			RequestModel(model)
			while not HasModelLoaded(model) do
				Citizen.Wait(0)
			end
			personalvehicle = CreateVehicle(model,pos[1],pos[2],pos[3],pos[4],true,false)
			SetVehicleNumberPlateText(personalvehicle, NewPlate)

			if name == "rumpo" then
				SetVehicleLivery(personalvehicle,0)
			end

			if name == "taxi" then
				SetVehicleExtra(personalvehicle, 8, 0)
				SetVehicleExtra(personalvehicle, 9, 0)
				SetVehicleExtra(personalvehicle, 5, 1)
			end

			for i,mod in pairs(mods) do
				SetVehicleModKit(personalvehicle,0)
				SetVehicleMod(personalvehicle,i,mod)
			end
			local plate = GetVehicleNumberPlateText(personalvehicle)
			TriggerEvent('ARPF:spawn:recivekeys', personalvehicle, plate)
			SetVehicleOnGroundProperly(personalvehicle)
			SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
			local id = NetworkGetNetworkIdFromEntity(personalvehicle)
			SetNetworkIdCanMigrate(id, true)
			Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(personalvehicle))
			SetVehicleColours(personalvehicle,colors[1],colors[2])
			SetVehicleExtraColours(personalvehicle,extra_colors[1],extra_colors[2])
			TaskWarpPedIntoVehicle(PlayerPedId(),personalvehicle,-1)
			SetEntityVisible(ped,true)
			local vehProps = ESX.Game.GetVehicleProperties(personalvehicle)
			TriggerServerEvent('BuyForVeh', vehProps, name, vehicle, pPrice, financed,seller, commission, commissionbuy)
			TriggerServerEvent("garages:CheckGarageForVeh")
			SetModelAsNoLongerNeeded(model)
			DespawnSaleVehicles()
			SpawnSaleVehicles()
			NewPlate = ''
		end
		vehshop.opened = false
		vehshop.menu.from = 1
		vehshop.menu.to = 10
	end)
end


RegisterNetEvent("carshop:failedpurchase")
AddEventHandler("carshop:failedpurchase", function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	TaskLeaveVehicle(PlayerPedId(),veh,0)
end)

RegisterNetEvent('carshop:newPlate')
AddEventHandler('carshop:newPlate', function(plate)
	NewPlate = plate
end)

function drawMenuButton(button,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,255,55,55,220)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function drawMenuInfo(text)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawRect(0.675, 0.95,0.65,0.050,0,0,0,250)
	DrawText(0.255, 0.254)
end

function drawMenuRight(txt,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.2, 0.2)
	--SetTextRightJustify(1)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(250,250,250, 255)
	end

	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 + 0.025, y - menu.height/3 + 0.0002)

	if selected then
		DrawRect(x + menu.width/2 + 0.025, y,menu.width / 3,menu.height,255,255,255,255)
	else
		DrawRect(x + menu.width/2 + 0.025, y,menu.width / 3,menu.height,255,55,55,220)
	end
end

function drawMenuTitle(txt,x,y)
	local menu = vehshop.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)

	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,250)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

function ButtonSelected(button)
	local ped = PlayerPedId()
	local this = vehshop.currentmenu
	local btn = button.name
	if this == "main" then
		if btn == "Vehicles" then
			OpenMenu('vehicles')
		elseif btn == "Motorcycles" then
			OpenMenu('motorcycles')
		elseif btn == "Cycles" then
			OpenMenu('cycles')
		end
	elseif this == "vehicles" then
		if btn == "Sports" then
			OpenMenu('sports')
		elseif btn == "Sedans" then
			OpenMenu('sedans')
		elseif btn == "Job Vehicles" then
			OpenMenu('jobvehicles')
		elseif btn == "Compacts" then
			OpenMenu('compacts')
		elseif btn == "Coupes" then
			OpenMenu('coupes')
		elseif btn == "Sports Classics" then
			OpenMenu("sportsclassics")
		--elseif btn == "Super" then
		--	OpenMenu('super')
		elseif btn == "casino" then
			OpenMenu('casino')
		elseif btn == "Muscle" then
			OpenMenu('muscle')
		elseif btn == "Off-Road" then
			OpenMenu('offroad')
		elseif btn == "SUVs" then
			OpenMenu('suvs')
		elseif btn == "Vans" then
			OpenMenu('vans')
		end
	elseif this == "jobvehicles" or this == "compacts" or this == "coupes" or this == "sedans" or this == "sports" or this == "sportsclassics" or this == "casino" or --[[this == "super" or]] this == "muscle" or this == "offroad" or this == "suvs" or this == "vans" or this == "industrial" or this == "cycles" or this == "motorcycles" then
		if ownerMenu then
			updateCarTable(button.model,button.costs,button.name)
		else
			TriggerServerEvent('CheckMoneyForVeh',button.name, button.model, button.costs)
		end
	end
end

function OpenMenu(menu)
	fakecar = {model = '', car = nil}
	vehshop.lastmenu = vehshop.currentmenu
	if menu == "vehicles" then
		vehshop.lastmenu = "main"
	elseif menu == "bikes"  then
		vehshop.lastmenu = "main"
	elseif menu == 'race_create_objects' then
		vehshop.lastmenu = "main"
	elseif menu == "race_create_objects_spawn" then
		vehshop.lastmenu = "race_create_objects"
	end
	vehshop.menu.from = 1
	vehshop.menu.to = 10
	vehshop.selectedbutton = 0
	vehshop.currentmenu = menu
end

function Back()
	if backlock then
		return
	end
	backlock = true
	if vehshop.currentmenu == "main" then
		CloseCreator()
	elseif vehshop.currentmenu == "jobvehicles" or vehshop.currentmenu == "compacts" or vehshop.currentmenu == "coupes" or vehshop.currentmenu == "sedans" or vehshop.currentmenu == "sports" or vehshop.currentmenu == "sportsclassics" or vehshop.currentmenu == "casino"--[[or vehshop.currentmenu == "super"]] or vehshop.currentmenu == "muscle" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
		if DoesEntityExist(fakecar.car) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
		end
		fakecar = {model = '', car = nil}
		OpenMenu(vehshop.lastmenu)
	else
		OpenMenu(vehshop.lastmenu)
	end
end

Citizen.CreateThread(function()
	while true do
		if IsPlayerInRangeOfVehshop() or vehshop.opened then
			Citizen.Wait(0)
		else
			Citizen.Wait(500)
		end
		if (IsControlJustPressed(1,Controlkey["generalUse"][1]) or IsControlJustPressed(1, Controlkey["generalUseSecondary"][1])) and IsPlayerInRangeOfVehshop() then
			if vehshop.opened then
				CloseCreator()
			else
				OpenCreator()
			end
		end
		if vehshop.opened then

			local ped = LocalPed()
			local menu = vehshop.menu[vehshop.currentmenu]
			local y = vehshop.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false
	
			for i,button in pairs(menu.buttons) do
				--local br = button.rank ~= nil and button.rank or 0
				if job == 'pdm' and i >= vehshop.menu.from and i <= vehshop.menu.to then

					if i == vehshop.selectedbutton then
						selected = true
					else
						selected = false
					end
					drawMenuButton(button,vehshop.menu.x,y,selected)

					if button.costs ~= nil then
						drawMenuRight("$"..button.costs,vehshop.menu.x,y,selected)
					end

					y = y + 0.04
					if vehshop.currentmenu == "jobvehicles" or vehshop.currentmenu == "compacts" or vehshop.currentmenu == "coupes" or vehshop.currentmenu == "sedans" or vehshop.currentmenu == "sports" or vehshop.currentmenu == "sportsclassics" or vehshop.currentmenu == "casino" --[[or vehshop.currentmenu == "super"]] or vehshop.currentmenu == "muscle" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
						if selected then
							if fakecar.model ~= button.model then
								if DoesEntityExist(fakecar.car) then
									Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
								end
								local pos = currentlocation.pos.inside
								local hash = GetHashKey(button.model)
								RequestModel(hash)
								while not HasModelLoaded(hash) do
									Citizen.Wait(0)
								end
								local veh = CreateVehicle(hash,pos[1],pos[2],pos[3],pos[4],false,false)
								SetModelAsNoLongerNeeded(hash)
								local timer = 9000
								while not DoesEntityExist(veh) and timer > 0 do
									timer = timer - 1
									Citizen.Wait(1)
								end
								TriggerEvent("vehsearch:disable",veh)

								FreezeEntityPosition(veh,true)
								SetEntityInvincible(veh,true)
								SetVehicleDoorsLocked(veh,4)
								--SetEntityCollision(veh,false,false)
								TaskWarpPedIntoVehicle(LocalPed(),veh,-1)
								for i = 0,24 do
									SetVehicleModKit(veh,0)
									RemoveVehicleMod(veh,i)
								end
								fakecar = { model = button.model, car = veh}
								local topspeed = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel') / 2)
								local handling = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock') * 2)
								local braking = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce') * 100)
								local accel = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce') * 100) 
								if button.model == "rumpo" then
									SetVehicleLivery(veh,2)
								end

								-- not sure why it doesnt refresh itself, but blocks need to be set to their maximum 20 40 60 80 100 before a new number is pushed.
								--for i = 1, 5 do
								-- 	scaleform = resetscaleform(topspeed,handling,braking,accel,"mp_car_stats_01",i)
								--    x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
								--    Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x-1,y+1.8,z+7.0, 0.0, 180.0, 90.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0)
								--end

								--scaleform = Initialize("mp_car_stats_01",fakecar.car,fakecar.model)
							end
						end
					end
					if selected and ( IsControlJustPressed(1,Controlkey["generalUse"][1]) or IsControlJustPressed(1, Controlkey["generalUseSecondary"][1])  ) then
						ButtonSelected(button)
					end
				end
			end

			if DoesEntityExist(fakecar.car) then
				if vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
					daz = 6.0
					if fakecar.model == "Chimera" then
						daz = 8.0
					end
					if fakecar.model == "bmx" then
						daz = 8.0
					end
					x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 3.0, -1.5, daz))
					Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x,y,z, 0.0, 180.0, 100.0, 1.0, 1.0, 1.0, 7.0, 7.0, 7.0, 0)
				else
					x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 3.0, -1.5, 10.0))
					Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x,y,z, 0.0, 180.0, 100.0, 1.0, 1.0, 1.0, 10.0, 10.0, 10.0, 0)		
				end
				TaskWarpPedIntoVehicle(LocalPed(),fakecar.car,-1)
			end

		end
		if vehshop.opened then
			if IsControlJustPressed(1,202) then
				Back()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				if vehshop.selectedbutton > 1 then
					vehshop.selectedbutton = vehshop.selectedbutton -1
					if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
						vehshop.menu.from = vehshop.menu.from -1
						vehshop.menu.to = vehshop.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				if vehshop.selectedbutton < buttoncount then
					vehshop.selectedbutton = vehshop.selectedbutton +1
					if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
						vehshop.menu.to = vehshop.menu.to + 1
						vehshop.menu.from = vehshop.menu.from + 1
					end
				end
			end
		end
	end
end)

RegisterNetEvent('vehshop:refreshDisplay')
AddEventHandler('vehshop:refreshDisplay', function()
	DespawnSaleVehicles()
	Wait(1500)
	SpawnSaleVehicles()
end)

AddEventHandler('FinishMoneyCheckForVeh', function(name, vehicle, price,financed, commission)
	local name = name
	local vehicle = vehicle
	local price = price
	boughtcar = true
	CloseCreator(name, vehicle, price,financed, commission)
end)

ShowVehshopBlips(true)
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		--326 car blip 227 225
		ShowVehshopBlips(true)
		firstspawn = 1
	end
end)

AddEventHandler('vehshop:spawnVehicle', function(v)
	local car = GetHashKey(v)
	local playerPed = PlayerPedId()
	if playerPed and playerPed ~= -1 then
		RequestModel(car)
		while not HasModelLoaded(car) do
			Citizen.Wait(0)
		end
		local playerCoords = GetEntityCoords(playerPed)
		veh = CreateVehicle(car, playerCoords, 0.0, true, false)
		SetModelAsNoLongerNeeded(car)
		TaskWarpPedIntoVehicle(playerPed, veh, -1)
		SetEntityInvincible(veh, true)
	end
end)

local firstspawn = 0

AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		RemoveIpl('v_carshowroom')
		RemoveIpl('shutter_open')
		RemoveIpl('shutter_closed')
		RemoveIpl('shr_int')
		RemoveIpl('csr_inMission')
		RequestIpl('v_carshowroom')
		RequestIpl('shr_int')
		RequestIpl('shutter_closed')
		firstspawn = 1
	end
end)

RegisterCommand('finance', function(source, args, raw)
	if job == 'pdm' then
		TriggerEvent('finance')
	--elseif job == 'tuner' then
	--	TriggerEvent('finance_tuner')
	--elseif job == 'cardealer' then
	--	TriggerEvent('imports:finance')
	elseif job == 'bikedealer' then
		TriggerEvent('finance_bikeshop')
	else
		exports['mythic_notify']:SendAlert('inform', 'You dont have permissions for this')
	end
end)

RegisterCommand('commission', function(source, args, raw)
	local amount = tonumber(args[1])
	local name = GetPlayerName(PlayerId())
	local ident = exports['nadrp-ped']:isPed('steamid')
	local log = name..' ['..ident.. '] attempted to set '..amount..' commission'
	if job == 'pdm' then
		if amount ~= nil and amount > 0 and amount < 50 then
			TriggerEvent('commission', amount)
		elseif amount ~= nil and amount < 0 then 
			exports['nadrp-log']:AddLog('exploiter', name, ident, 'pdm', log)
		else
			exports['mythic_notify']:SendAlert('inform', 'Invalid amount "/commision [amount]"')
		end
	elseif job == 'tuner' then
		if amount ~= nil and amount > 0 and amount < 50 then
			TriggerEvent('commission_tuner', amount)
		elseif amount ~= nil and amount < 0 then
			exports['nadrp-log']:AddLog('exploiter', name, ident, 'tuner', log)
		else
			exports['mythic_notify']:SendAlert('inform', 'Invalid amount "/commision [amount]"')
		end
	elseif job == 'cardealer' then
		if amount ~= nil and amount > 0 and amount < 50 then
			TriggerEvent('imports:commission', amount)
		elseif amount ~= nil and amount < 0 then
			exports['nadrp-log']:AddLog('exploiter', name, ident, 'imports', log)
		else
			exports['mythic_notify']:SendAlert('inform', 'Invalid amount "/commision [amount]"')
		end
	elseif job == 'bikedealer' then
		if amount ~= nil and amount > 0 and amount < 50 then
			TriggerEvent('commission_bikeshop', amount)
		elseif amount ~= nil and amount < 0 then
			exports['nadrp-log']:AddLog('exploiter', name, ident, 'bikedealer', log)
		else
			exports['mythic_notify']:SendAlert('inform', 'Invalid amount "/commision [amount]"')
		end
	else
		exports['mythic_notify']:SendAlert('inform', 'You dont have permissions for this')
	end
end)

RegisterCommand('testdrive', function(source, args, raw)
	if job == 'pdm' then
		TriggerEvent('car:testdrive')
	elseif job == 'tuner' then
		TriggerEvent('car:testdrive_tuner')
	elseif job == 'cardealer' then
		TriggerEvent('car:imports:testdrive')
	elseif job == 'bikedealer' then
		TriggerEvent('bike:testdrive')
	else
		exports['mythic_notify']:SendAlert('inform', 'You dont have permissions for this')
	end
end)

RegisterCommand('enableBuy', function(source, args, raw)
	if job == 'pdm' then
		TriggerEvent('buyEnable')
	elseif job == 'tuner' then
		TriggerEvent('tuner:enable_buy')
	elseif job == 'cardealer' then
		TriggerEvent('imports:buyEnable')
	elseif job == 'bikedealer' then
		TriggerEvent('bikeshop:enable_buy')
	else
		exports['mythic_notify']:SendAlert('inform', 'You dont have permissions for this')
	end
end)

RegisterCommand('refreshDisplay', function()
	if job == 'pdm' then 
		TriggerServerEvent('vehshop:refreshDisplay')
	elseif job == 'tuner' then
		TriggerServerEvent('tuner:refreshDisplay')
	elseif job == 'cardealer' then
		TriggerServerEvent('imports:refreshDisplay')
	else
		exports['mythic_notify']:SendAlert('inform', 'You dont have permissions for this')
	end
end)

RegisterNetEvent('nadrp:playerBecameJob')
AddEventHandler('nadrp:playerBecameJob', function(jobpassed)
	job = jobpassed.name
end)
