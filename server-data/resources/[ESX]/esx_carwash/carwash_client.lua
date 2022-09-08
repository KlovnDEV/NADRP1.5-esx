--DO-NOT-EDIT-BELLOW-THIS-LINE--

Key = 201 -- ENTER

vehicleWashStation = {
	{26.5906,  -1392.0261,  27.3634},
	{167.1034,  -1719.4704,  27.2916},
	{-74.5693,  6427.8715,  29.4400},
	{-699.6325,  -932.7043,  17.0139}
}


Citizen.CreateThread(function ()
	Citizen.Wait(0)
	for i = 1, #vehicleWashStation do
		garageCoords = vehicleWashStation[i]
		stationBlip = AddBlipForCoord(garageCoords[1], garageCoords[2], garageCoords[3])
		SetBlipSprite(stationBlip, 100) -- 100 = carwash
		SetBlipAsShortRange(stationBlip, true)
		SetBlipScale(stationBlip, 0.7)
	end
    return
end)

function DrawSpecialText(m_text, showtime)
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

Citizen.CreateThread(function ()
	while true do
		if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
			for i = 1, #vehicleWashStation do
				garageCoords2 = vehicleWashStation[i]
				if #(vector3(garageCoords2[1], garageCoords2[2], garageCoords2[3]) - GetEntityCoords(GetPlayerPed(-1))) < 10.0 then
					found = true
                    DrawMarker(1, garageCoords2[1], garageCoords2[2], garageCoords2[3], 0, 0, 0, 0, 0, 0, 5.0, 5.0, 2.0, 0, 157, 0, 155, 0, 0, 2, 0, 0, 0, 0)
                end
                if #(vector3(garageCoords2[1], garageCoords2[2], garageCoords2[3]) - GetEntityCoords(GetPlayerPed(-1))) < 5 then
					DrawSpecialText("Press ~r~Enter~w~ to wash the car")
					if(IsControlJustPressed(1, Key)) then
						TriggerServerEvent('carwash:checkmoney')
					end
				end
			end
		end
		if found then
			Citizen.Wait(0)
		else
			Citizen.Wait(1000)
		end
		found = false
	end
end)

RegisterNetEvent('carwash:success')
AddEventHandler('carwash:success', function(price)
    exports['t0sic_loadingbar']:StartDelayedFunction('Washing Car', 10000, function()
        SetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  0.0000000001)
        SetVehicleUndriveable(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
        DrawSpecialText(msg, 5000)
        exports['mythic_notify']:DoLongHudText('inform', 'Car has been washed')
        Wait(5000)
    end)
end)

RegisterNetEvent('carwash:notenoughmoney')
AddEventHandler('carwash:notenoughmoney', function(moneyleft)
    exports['mythic_notify']:DoLongHudText('error', 'You dont have enough money on you')
	DrawSpecialText(msg, 5000)
	Wait(5000)
end)

RegisterNetEvent('carwash:free')
AddEventHandler('carwash:free', function()
    exports['t0sic_loadingbar']:StartDelayedFunction('Washing Car', 10000, function()
        exports['mythic_notify']:DoLongHudText('inform', 'Car has been washed')
        SetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1),  false),  0.0000000001)
        SetVehicleUndriveable(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
        DrawSpecialText(msg, 5000)
        Wait(5000)
    end)
end)