Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local playerLocalisation = GetEntityCoords(PlayerPedId())
		RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_CARBINERIFLE'))
		RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_PISTOL'))
		RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_PUMPSHOTGUN'))
		SetVehicleModelIsSuppressed(GetHashKey("ambulance"), true)
		DisablePlayerVehicleRewards(PlayerId())
		ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 400.0)
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		for i = 1, 15 do
			EnableDispatchService(i, false)
		end
		SetPlayerWantedLevel(PlayerId(), 0, false)
		SetPlayerWantedLevelNow(PlayerId(), false)
		SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
	end
end)