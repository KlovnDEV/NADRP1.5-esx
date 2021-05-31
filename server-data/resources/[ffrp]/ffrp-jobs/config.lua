Config                            = {}

Config.DrawDistance               = 25.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = false
Config.EnableSocietyOwnedVehicles = false

Config.Locale                     = 'en'

Config.AuthorizedVehicles = {

		{
			model = 'rubble',
			label = 'rubble',
			price = 500
		}

	}

--[[Config.Cloakroom = {

}]]

Config.Zones = {


}

Config.Strefy = {

	Praca = {
        x = 538.17,
        y = 101.61,
        z = 95.63
	},

	Spawn = {
        Pos   = {x = 548.39, y = 125.23, z = 96.47},
        Heading = 70.0
    },

    Anulowanie = {
        x = 558.52,
        y = 121.27,
        z = 97.37
    },
    
    Zakonczenie = {
        x = 571.25,
        y = 116.78,
        z = 97.36
	},
	

}

Config.FishTime = {a = 20000, b = 44000}
	
	--------------------------------------------------------
	--=====Prices of the items players can sell==========--
	--------------------------------------------------------
	--First amount minimum price second maximum amount (the amount player will get is random between those two numbers)
	Config.FishPrice = {a = 95, b = 143} --Will get clean money THIS PRICE IS FOR EVERY 5 FISH ITEMS (5 kg)
	Config.TurtlePrice = {a = 240, b = 260} --Will get dirty money
	Config.SharkPrice = {a = 350, b = 356} --Will get dirty money

	--------------------------------------------------------
	--=====Locations where players can sell stuff========--
	--------------------------------------------------------

	Config.SellFish = {x = -1038.949, y =-1396.742, z =  5.553} --Place where players can sell their fish
	Config.SellTurtle = {x = 3804.0, y = 4443.3, z = 5.0} --Place where players can sell their turtles 
	Config.SellShark = {x = 2517.6 , y = 4218.0, z = 38.8} --Place where players can sell their sharks

	--------------------------------------------------------
	--=====Locations where players can rent boats========--
	--------------------------------------------------------
Config.MarkerZones = { 
	
    {x = -3426.7   ,y = 955.66 ,z = 7.35, xs = -3426.2  , ys = 942.4, zs = 1.1 },
	{x = -732.9     ,y = -1309.7 ,z = 4.0, xs = -725.7    , ys = -1351.5, zs = 0.5 },  
	{x = -1607.6      ,y =  5252.8 ,z = 3.0, xs = -1590.2      , ys = 5278.8, zs = 1.0 },
	{x = 3855.0        ,y =  4463.7 ,z = 1.6, xs = 3885.2       , ys =  4507.2, zs = 1.0 },
	{x = 1330.8        ,y =  4226.6 ,z = 32.9, xs = 1334.2         , ys =  4192.4, zs = 30.0 },
	

}

