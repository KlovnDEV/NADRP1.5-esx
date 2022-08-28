Citizen.CreateThread(function()
	exports["shrp-polyzone"]:AddBoxZone("casino_enter", vector3(928.45, 44.56, 81.1), 11.6, 5.4, {
		heading=327,
		minZ=80.1,
		maxZ=82.9,
		data = {
		  id = "1",
		},
	})
	exports["shrp-polyzone"]:AddBoxZone("casino_exit", vector3(1089.72, 206.58, -49.0), 2.4, 7.0, {
		heading=0,
		minZ=-50.2,
		maxZ=-47.2,
		data = {
		  id = "1",
		},
	})
	exports["shrp-polyzone"]:AddBoxZone("elevator_roof", vector3(964.33, 58.88, 112.56), 2.0, 2, {
		heading=327,
		minZ=111.61,
		maxZ=114.01,
		data = {
		  id = "1",
		},
	})
	exports["shrp-polyzone"]:AddBoxZone("elevator_inside", vector3(1085.75, 214.75, -49.2), 2.6, 2.2, {
		heading=45,
		minZ=-52.5,
		maxZ=-47.9,
		data = {
		  id = "1",
		},
	})
end)

function KeypressThread()
	Citizen.CreateThread(function()
		while NearElevator do
			Citizen.Wait(1)
			if IsControlJustPressed(0, 38) then
				UseElevator(NearName)
			end
		end
	end)
end

function UseElevator(name)
	local ped = PlayerPedId()
	if name == "roof" then
		DoScreenFadeOut(500)
		Wait(500)
		SetEntityCoords(ped, 1085.75, 214.75, -49.2)
		Wait(500)
		DoScreenFadeIn(500)
		TriggerEvent('shrp-casino:InCasino', true)
	elseif name == "inside" then
		DoScreenFadeOut(500)
		Wait(500)
		SetEntityCoords(ped, 964.33, 58.88, 112.56)
		Wait(500)
		DoScreenFadeIn(500)
		TriggerEvent('shrp-casino:InCasino', false)
	end
	exports["shrp-notify"]:ShowPersistAlert('[E] - Elevator', 'info', 'hide')
end


AddEventHandler('shrp-polyzone:exit', function(zone)
	if zone == "elevator_roof" or zone == "elevator_inside" then 
		NearElevator,NearName = false,""
		exports["shrp-notify"]:ShowPersistAlert('', '', 'hide')
	end
end)

AddEventHandler('shrp-polyzone:enter', function(zone, data, center)
	if zone == "casino_enter" and not justUsed then
		justUsed = true
		DoScreenFadeOut(500)
		Wait(500)
		SetEntityCoords(PlayerPedId(), 1089.72, 206.58, -49.0)
		SetEntityHeading(PlayerPedId(), 343.398)
		Wait(500)
		DoScreenFadeIn(500)
		TriggerEvent('shrp-casino:InCasino', true)
		SetTimeout(2500, function()
			justUsed = false
		end)
	elseif zone == "casino_exit" and not justUsed then
		justUsed = true
		DoScreenFadeOut(500)
		Wait(500)
		SetEntityCoords(PlayerPedId(), 928.45, 44.56, 81.1)
		SetEntityHeading(PlayerPedId(), 59.379)
		Wait(500)
		DoScreenFadeIn(500)
		TriggerEvent('shrp-casino:InCasino', false)
		SetTimeout(2500, function()
			justUsed = false
		end)
	elseif zone == "elevator_inside" then
		NearElevator,NearName = true,"inside"
		KeypressThread()
		exports["shrp-notify"]:ShowPersistAlert('[E] - Elevator', 'info', 'show')
	elseif zone == "elevator_roof" then
		NearElevator,NearName = true,"roof"
		KeypressThread()
		exports["shrp-notify"]:ShowPersistAlert('[E] - Elevator', 'info', 'show')
	end
end)