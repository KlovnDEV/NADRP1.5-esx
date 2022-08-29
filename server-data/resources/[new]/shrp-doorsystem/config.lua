Config = {}
Config.ShowUnlockedText = true

Config.DoorList = {
	------------------------------------------
	--	MISSION ROW POLICE DEPARTMENT		--
	------------------------------------------
	-- gabz_mrpd	FRONT DOORS
	{
		authorizedJobs = { 'police', 'offpolice' },
		locked = false,
		maxDistance = 2.0,
		doors = {
			{objHash = -1547307588, objHeading = 90.0, objCoords = vector3(434.7444, -983.0781, 30.8153)},
			{objHash = -1547307588, objHeading = 270.0, objCoords = vector3(434.7444, -980.7556, 30.8153)}
		},
		
	},

	-- gabz_mrpd	NORTH DOORS
	{
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		maxDistance = 2.0,
		doors = {
			{objHash = -1547307588, objHeading = 180.0, objCoords = vector3(458.2087, -972.2543, 30.8153)},
			{objHash = -1547307588, objHeading = 0.0, objCoords = vector3(455.8862, -972.2543, 30.8153)}
		},
		
	},

	-- gabz_mrpd	SOUTH DOORS
	{
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		maxDistance = 2.0,
		doors = {
			{objHash = -1547307588, objHeading = 0.0, objCoords = vector3(440.7392, -998.7462, 30.8153)},
			{objHash = -1547307588, objHeading = 180.0, objCoords = vector3(443.0618, -998.7462, 30.8153)}
		},
		
	},

	-- gabz_mrpd	LOBBY LEFT


	{
		authorizedJobs = {'police'},
		objHash = -1406685646,
		objHeading = 0.0,
		objCoords = vector3(441.13, -977.93, 30.82319),
		locked = true,
		maxDistance = 2.0,
		fixText = true
	
	},

	-- gabz_mrpd	LOBBY RIGHT
	{
		objHash = -96679321,
		objHeading = 180.0,
		objCoords = vector3(440.5201, -986.2335, 30.82319),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- gabz_mrpd	GARAGE ENTRANCE 1
	{
		objHash = 1830360419,
		objHeading = 269.78,
		objCoords = vector3(464.1591, -974.6656, 26.3707),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		maxDistance = 2.0,
	},

	-- gabz_mrpd	GARAGE ENTRANCE 2
	{
		objHash = 1830360419,
		objHeading = 89.87,
		objCoords = vector3(464.1566, -997.5093, 26.3707),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},
	
	-- gabz_mrpd	GARAGE ROLLER DOOR 1
	{
		objHash = 2130672747,
		objHeading = 0.0,
		objCoords = vector3(431.4119, -1000.772, 26.69661),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		maxDistance = 6,
		garage = true,
		slides = true,
		audioRemote = true,
	},
	
	-- gabz_mrpd	GARAGE ROLLER DOOR 2
	{
		objHash = 2130672747,
		objHeading = 0.0,
		objCoords = vector3(452.3005, -1000.772, 26.69661),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		maxDistance = 6,
		garage = true,
		slides = true,
		audioRemote = true,
	},
	
	-- gabz_mrpd	BACK GATE
	{
		objHash = -1603817716,
		objHeading = 90.0,
		objCoords = vector3(488.8948, -1017.212, 27.14935),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		maxDistance = 6,
		slides = true,
		audioRemote = true
	},

	-- gabz_mrpd	BACK DOORS
	{
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		maxDistance = 2.0,
		doors = {
			{objHash = -692649124, objHeading = 0.0, objCoords = vector3(467.3686, -1014.406, 26.48382)},
			{objHash = -692649124, objHeading = 180.0, objCoords = vector3(469.7743, -1014.406, 26.48382)}
		},
		
	},

	-- gabz_mrpd	MUGSHOT
	{
		objHash = -1406685646,
		objHeading = 180.0,
		objCoords = vector3(475.9539, -1010.819, 26.40639),
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 2.0,
	},

	-- gabz_mrpd	CELL ENTRANCE 1
	{
		objHash = -53345114,
		objHeading = 270.0,
		objCoords = vector3(476.6157, -1008.875, 26.48005),
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 2.0,
		fixText = true,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- gabz_mrpd	CELL ENTRANCE 2
	{
		objHash = -53345114,
		objHeading = 180.0,
		objCoords = vector3(481.0084, -1004.118, 26.48005),
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 2.0,
		fixText = true,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- gabz_mrpd	CELL 1
	{
		objHash = -53345114,
		objHeading = 0.0,
		objCoords = vector3(477.9126, -1012.189, 26.48005),
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- gabz_mrpd	CELL 2
	{
		objHash = -53345114,
		objHeading = 0.0,
		objCoords = vector3(480.9128, -1012.189, 26.48005),
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- gabz_mrpd	CELL 3
	{
		objHash = -53345114,
		objHeading = 0.0,
		objCoords = vector3(483.9127, -1012.189, 26.48005),
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- gabz_mrpd	CELL 4
	{
		objHash = -53345114,
		objHeading = 0.0,
		objCoords = vector3(486.9131, -1012.189, 26.48005),
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- gabz_mrpd	CELL 5
	{
		objHash = -53345114,
		objHeading = 180.0,
		objCoords = vector3(484.1764, -1007.734, 26.48005),
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 2.0,
		fixText = true,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- gabz_mrpd	LINEUP
	{
		objHash = -288803980,
		objHeading = 90.0,
		objCoords = vector3(479.06, -1003.173, 26.4065),
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- gabz_mrpd	OBSERVATION I
	{
		objHash = -1406685646,
		objHeading = 270.0,
		objCoords = vector3(482.6694, -983.9868, 26.40548),
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 2.0,
	},

	-- gabz_mrpd	INTERROGATION I
	{
		objHash = -1406685646,
		objHeading = 270.0,
		objCoords = vector3(482.6701, -987.5792, 26.40548),
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 2.0,
	},

	-- gabz_mrpd	OBSERVATION II
	{
		objHash = -1406685646,
		objHeading = 270.0,
		objCoords = vector3(482.6699, -992.2991, 26.40548),
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 2.0,
	},

	-- gabz_mrpd	INTERROGATION II
	{
		objHash = -1406685646,
		objHeading = 270.0,
		objCoords = vector3(482.6703, -995.7285, 26.40548),
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 2.0,
	},

	-- gabz_mrpd	EVIDENCE
	{
		objHash = -692649124,
		objHeading = 134.7,
		objCoords = vector3(475.8323, -990.4839, 26.40548),
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 2.0,
		setText = true,
		textCoords = vector3(475.3978, -989.9868, 26.34802)
	},

	-- gabz_mrpd	ARMOURY 1
	{
		objHash = -692649124,
		objHeading = 90.0,
		objCoords = vector3(479.7507, -999.629, 30.78927),
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- gabz_mrpd	ARMOURY 2
	{
		objHash = -692649124,
		objHeading = 181.28,
		objCoords = vector3(487.4378, -1000.189, 30.78697),
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 2.0,
	},

	-- gabz_mrpd	SHOOTING RANGE
	{
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 2.0,
		doors = {
			{objHash = -692649124, objHeading = 0.0, objCoords = vector3(485.6133, -1002.902, 30.78697)},
			{objHash = -692649124, objHeading = 180.0, objCoords = vector3(488.0184, -1002.902, 30.78697)}
		},
		
	},

	-- Casino Inside

	--[[{
		--authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 1.5,
		doors = {
			{objHash = 21324050, objHeading = 0.0, objCoords = vector3(1090.844,205.738,-49.0)},
			{objHash = 21324050, objHeading = 180.0, objCoords = vector3(1088.42,205.799,-49.0)},
		},
		
	},]]



	------------------------------------------
	--				Pillbox					--
	------------------------------------------
	-- gabz_pillbox	DOORS RIGHT HAND SIDE OP FLOOR
	{
        authorizedJobs = { 'police', 'offpolice','ambulance'},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = -434783486, objHeading = 0.0, objCoords = vector3(324.89,-589.93, 43.29)},
            {objHash = -1700911976, objHeading = 180.0, objCoords = vector3(326.08, -589.8,43.29)}
        },
    },
	-- gabz_pillbox	DOUBLE DOORS BY FRONT
	{
        authorizedJobs = { 'police', 'offpolice','ambulance'},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = -434783486, objHeading = 0.0, objCoords = vector3(303.01141357422, -581.88134765625 ,43.28653717041)},
            {objHash = -1700911976, objHeading = 180.0, objCoords = vector3(304.60537719727, -581.65545654297,43.284034729004)}
        },
    },
	-- gabz_pillbox	DOUBLE DOORS BY WARD A
	{
        authorizedJobs = { 'police', 'offpolice','ambulance'},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = -1700911976, objHeading = 0.0, objCoords = vector3(325.28,-579.66,43.29)},
            {objHash = -434783486, objHeading = 180.0, objCoords = vector3(326.16,-578.49, 43.31)}
        },
    },
	-- gabz_pillbox	SURGERY BY WARD B
	{
        authorizedJobs = { 'police', 'offpolice','ambulance'},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = -1700911976, objHeading = 0.0, objCoords = vector3(325.65,-576.29,43.29)},
            {objHash = -434783486, objHeading = 180.0, objCoords = vector3(323.88,-575.72,43.29)}
        },
    },

	-- gabz_pillbox	SURGERY Opposite Intensive Care
	{
        authorizedJobs = { 'police', 'offpolice','ambulance'},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = -1700911976, objHeading = 0.0, objCoords = vector3(319.7762,-574.6462, 43.28)},
            {objHash = -434783486, objHeading = 180.0, objCoords = vector3(318.74,-573.66, 43.3)}
        },
    },
	-- gabz_pillbox	SURGERY CLOSE TO FRONT
	{
		authorizedJobs = { 'police', 'offpolice','ambulance'},
		locked = true,
		maxDistance = 2.0,
		doors = {
			{objHash = -1700911976, objHeading = 0.0, objCoords = vector3(313.45, -572.17, 43.29)},
			{objHash = -434783486, objHeading = 180.0, objCoords = vector3(312.8,-571.49,43.29)}
			
		},
	},
	-- gabz_pillbox	SURGERY CLOSE TO FRONT
	{
		authorizedJobs = { 'police', 'offpolice','ambulance'},
		locked = true,
		maxDistance = 2.0,
		doors = {
			{objHash = -1700911976, objHeading = 0.0, objCoords = vector3(313.45, -572.17, 43.29)},
			{objHash = -434783486, objHeading = 180.0, objCoords = vector3(312.8,-571.49,43.29)}
		},
	},
	-- gabz_pillbox	WARD B
	{
		authorizedJobs = { 'police', 'offpolice','ambulance'},
		locked = true,
		maxDistance = 2.0,
		doors = {
			{objHash = -1700911976, objHeading = 0.0, objCoords = vector3(348.87,-587.97,43.29)},
			{objHash = -434783486, objHeading = 180.0, objCoords = vector3(349.02,-586.31,43.29)}
		},
	},		
	-- gabz_pillbox	JANITORS
	{
		objHash = 854291622,
		objHeading = 131.72,
		objCoords = vector3(304.4,-572.6,43.29),
		authorizedJobs = { 'police', 'offpolice','ambulance'},
		locked = true,
		maxDistance = 2.0,
	},
	-- gabz_pillbox	LAB
	{
		objHash = 854291622,
		objHeading = 131.72,
		objCoords = vector3(304.4,-572.6,43.29),
		authorizedJobs = { 'police', 'offpolice','ambulance'},
		locked = true,
		maxDistance = 2.0,
	},	
	-- gabz_pillbox	STAFF ROOM
	{
		objHash = 854291622,
		objHeading = 167.091,
		objCoords = vector3(308.465,-597.54, 43.284),
		authorizedJobs = { 'police', 'offpolice','ambulance'},
		locked = true,
		maxDistance = 2.0,
	},	
	-- gabz_pillbox	LOWER PILLBOX DOUBLE DOOR LEFT
	{
		authorizedJobs = { 'police', 'offpolice','ambulance'},
		locked = true,
		maxDistance = 2.0,
		doors = {
			{objHash = -1700911976, objHeading = 0.0, objCoords = vector3(346.758, -591.099, 28.797)},
			{objHash = -434783486, objHeading = 180.0, objCoords = vector3(346.019, -591.762, 28.797)}
		},
	},
	-- gabz_pillbox	LOWER PILLBOX DOUBLE DOOR RIGHT
	{
		authorizedJobs = { 'police', 'offpolice','ambulance'},
		locked = true,
		maxDistance = 2.0,
		doors = {
			{objHash = -434783486, objHeading = 0.0, objCoords = vector3(349.685, -583.462, 28.797)},
			{objHash = -1700911976, objHeading = 180.0, objCoords = vector3(350.101, -582.189, 28.797)}
		},
	},	
	-- gabz_pillbox	LOWER PILLBOX DOUBLE DOOR GARAGE
	{
		authorizedJobs = { 'police', 'offpolice','ambulance'},
		locked = true,
		maxDistance = 2.0,
		doors = {
			{objHash = -1700911976, objHeading = 0.0, objCoords = vector3(338.665, -588.295, 28.797)},
			{objHash = -434783486, objHeading = 180.0, objCoords = vector3(338.193, -589.449,28.797)}
		},
	},
	
	-- gabz_pillbox	GARAGE LEFT
	{
		objHash = -820650556,
		objHeading = 131.72,
		objCoords = vector3(337.2777, -564.432, 29.77529),
		authorizedJobs = { 'police', 'offpolice','ambulance'},
		locked = true,
		maxDistance = 10.0,
	},	
	
	-- gabz_pillbox	GARAGE RIGHT
	{
		objHash = -820650556,
		objHeading = 131.72,
		objCoords = vector3(330.1349, -561.8331, 29.77529),
		authorizedJobs = { 'police', 'offpolice','ambulance'},
		locked = true,
		maxDistance = 10.0,
	},	

	------------------------------------------
	--				VU				        --
	------------------------------------------
	-- gabz_vu	FRONT DOOR
	{
		objHash = -1116041313,
		objHeading = 131.72,
		objCoords = vector3(128.46, -1298.019, 29.269),
		authorizedJobs = { 'police', 'offpolice','ambulance','vu', 'vu2'},
		locked = true,
		maxDistance = 3.0,
	},	
	-- gabz_vu	STRIPPER DOOR
	{
		objHash = 390840000,
		objHeading = 131.72,
		objCoords = vector3(113.895, -1296.774, 29.269),
		authorizedJobs = { 'police', 'offpolice','ambulance','vu', 'vu2'},
		locked = true,
		maxDistance = 3.0,
	},	
	-- gabz_vu	MANAGER DOOR
	{
		objHash = 390840000,
		objHeading = 131.72,
		objCoords = vector3(99.499, -1293.272, 29.264),
		authorizedJobs = { 'police', 'vu2'},
		locked = true,
		maxDistance = 3.0,
	},	
	-- gabz_vu	MANAGER BACK DOOR
	{
		objHash = 1695461688,
		objHeading = 131.72,
		objCoords = vector3(95.189, -1284.807,29.275),
		authorizedJobs = { 'police', 'vu2'},
		locked = true,
		maxDistance = 3.0,
	},	
	
	------------------------------------------
	--				Tuners				    --
	------------------------------------------
	--Tuners FRONT GATE
	{
		objHash = -983965772,
		objHeading = 0.3,
		objCoords = vector3(945.996, -985.662, 39.499),
		authorizedJobs = { 'police', 'tuner'},
		locked = true,
		maxDistance = 14.0,
	},	
	--Tuners STAFF
	{
		objHash = 1289778077,
		objHeading = 0.3,
		objCoords = vector3(947.999, -964.697, 39.5),
		authorizedJobs = { 'police', 'tuner'},
		locked = true,
		maxDistance = 2.0,
	},
	--Tuners STAFF BACKDOOR
	{
		objHash = -626684119,
		objHeading = 0.3,
		objCoords = vector3(954.709, -972.238, 39.507),
		authorizedJobs = { 'police', 'tuner'},
		locked = true,
		maxDistance = 2.0,
	},		

	--Tuners DOOR TO VOID
	{
		objHash = -267021114,
		objHeading = 0.3,
		objCoords = vector3(911.237, -976.879, 39.5),
		authorizedJobs = { 'police', 'tuner'},
		locked = true,
		maxDistance = 2.0,
	},		
	


	------------------------------------------
	--				SANDY				    --
	------------------------------------------
	--FRONT DOOR
	{
		objHash = -1765048490,
		objHeading = 0.3,
		objCoords = vector3(1855.268, 3683.421,34.268),
		authorizedJobs = { 'police', 'tuner'},
		locked = true,
		maxDistance = 2.0,
	},	
	------------------------------------------
	--				PALETO				    --
	------------------------------------------
	--FRONT DOOR

	-- PALETO FRONT DOOR
	{
		authorizedJobs = { 'police', 'offpolice','ambulance'},
		locked = false,
		maxDistance = 2.0,
		doors = {
			{objHash = -1501157055, objHeading = 0.0, objCoords = vector3(-443.129, 6015.804, 31.716)},
			{objHash = -1501157055, objHeading = 180.0, objCoords = vector3(-443.957, 6016.84, 31.712)}
		},
	},	

	-- PALETO FRONT LEFT DOOR
	{
		authorizedJobs = { 'police', 'offpolice','ambulance'},
		locked = true,
		maxDistance = 2.0,
		doors = {
			{objHash = 964838196, objHeading = 0.0, objCoords = vector3(-441.484, 6012.39, 31.716)},
			{objHash = 964838196, objHeading = 180.0, objCoords = vector3(-442.387, 6011.53, 31.716)}
		},
	},	
	-- PALETO FRONT RECEPT
	{
		authorizedJobs = { 'police', 'offpolice','ambulance'},
		locked = true,
		maxDistance = 2.0,
		doors = {
			{objHash = 245182344, objHeading = 0.0, objCoords = vector3(-448.162, 6007.329, 31.716)},
			{objHash = -681066206, objHeading = 180.0, objCoords = vector3(-448.905, 6008.377, 31.716)}
		},
	},		
	
	--BACKDOOR1
	{
		objHash = 452874391,
		objHeading = 0.3,
		objCoords = vector3(-446.517, 6002.351, 31.716),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		maxDistance = 2.0,
	},
	--BACKDOOR2
	{
		objHash = 452874391,
		objHeading = 0.3,
		objCoords = vector3(-451.222, 6006.757, 31.716),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		maxDistance = 2.0,
	},
	--BACKJAIL
	{
		objHash = 631614199,
		objHeading = 0.3,
		objCoords = vector3(-432.658, 5992.404, 31.716),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		maxDistance = 1.0,
	},
	--BACKJAIL1
	{
		objHash = 631614199,
		objHeading = 0.3,
		objCoords = vector3(-432.088, 5999.988, 31.716),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		maxDistance = 1.0,
	},
	--BACKJAIL2
	{
		objHash = 631614199,
		objHeading = 0.3,
		objCoords = vector3(-428.736, 5996.805, 31.716),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		maxDistance = 1.0,
	},
	------------------------------------------
	--				AZAS				    --
	------------------------------------------	
	--FRONTLEFT
	{
		authorizedJobs = { 'police', 'cardealer'},
		locked = true,
		maxDistance = 2.0,
		doors = {
			{objHash = 1015445881, objHeading = 0.0, objCoords = vector3(-802.678, -223.309, 37.323)},
			{objHash = 1015445881, objHeading = 180.0, objCoords = vector3(-802.345, -223.786, 37.323)}
		},
	},
	--FRONT BY GARAGE	

	{
		authorizedJobs = { 'police', 'cardealer'},
		locked = true,
		maxDistance = 2.0,
		doors = {
			{objHash = 447044832, objHeading = 0.0, objCoords = vector3(-777.344, -244.55, 37.109)},
			{objHash = 447044832, objHeading = 180.0, objCoords = vector3(-776.388, -244.174, 37.134)}
		},
	},
	--GARAGE LEFT
	{
		objHash = 1501451068,
		objHeading = 0.3,
		objCoords = vector3(-770.739, -240.535, 37.068),
		authorizedJobs = { 'police', 'cardealer'},
		locked = true,
		maxDistance = 5.0,
	},


	{
		objHash = 1501451068,
		objHeading = 23.086,
		objCoords = vector3(-764.736, -239.21, 37.135),
		authorizedJobs = { 'police', 'cardealer'},
		locked = true,
		maxDistance = 5.0,
	},



}