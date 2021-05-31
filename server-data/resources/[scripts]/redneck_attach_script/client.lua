attachKey = 51 -- Index number for attach key - http://docs.fivem.net/game-references/controls/
attachKeyName = "~INPUT_CONTEXT~" -- Key name (center column) of above key.

--- Code ---

function GetVehicleInDirection(cFrom, cTo)
    local rayHandle = CastRayPointToPoint(cFrom.x, cFrom.y, cFrom.z, cTo.x, cTo.y, cTo.z, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end


gators = {
    ["gator"] = {10, 1.2, 2.2, 0.40, 0.0, 0.0, 0.0, false, false, true, false, 20, true}
}

gatortrailers = {
    ["utvtrailer"] = true
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = GetPlayerPed(-1)
		local veh = GetVehiclePedIsIn(ped)
		if veh ~= nil then
			local vehName = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
			if gators[vehName] then
				local belowFaxMachine = GetOffsetFromEntityInWorldCoords(veh, 1.0, 6.0, -5.0)
				local gatorCoordsInWorldLol = GetEntityCoords(veh)
                local trailerLoc = GetVehicleInDirection(gatorCoordsInWorldLol, belowFaxMachine)
				local trailName = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(trailerLoc)))
                if gatortrailers[trailName] then
					if IsEntityAttached(veh) then 
						if IsControlJustReleased(1, attachKey) then -- detach
							DetachEntity(veh, false, true)
						end
						-- Start Prompt
						Citizen.InvokeNative(0x8509B634FBE7DA11, "STRING") -- BeginTextCommandDisplayHelp()
						Citizen.InvokeNative(0x5F68520888E69014, "Press " .. attachKeyName .. " to detach gator.") -- AddTextComponentScaleform()
						Citizen.InvokeNative(0x238FFE5C7B0498A6, 0, false, true, -1) -- EndTextCommandDisplayHelp()
					else
                        if IsControlJustReleased(1, attachKey) then -- Attach
                            local gator = gators[vehName]
                            -- if vehName == "nitrogator" then
                                -- if trailName == "nbtrailer" then
                                    -- gator = {2, 0.18, -1.0, 0.20, 0.0, 0.0, 0.0, false, false, true, false, 20, true}
                                -- end
                            -- elseif vehName == "mediumgator" then
                                -- if trailName == "nbtrailer" then
                                     -- gator = {2, 0.18, -1.0, 0.65, 0.0, 0.0, 0.0, false, false, true, false, 20, true}
                                -- end
                            -- end
							AttachEntityToEntity(veh, trailerLoc, gator[1], gator[2], gator[3], gator[4], gator[5], gator[6], gator[7], gator[8], gator[9], gator[10], gator[11], gator[12], gator[13])
						end
                        -- Start Prompt
						Citizen.InvokeNative(0x8509B634FBE7DA11, "STRING") -- BeginTextCommandDisplayHelp()
						Citizen.InvokeNative(0x5F68520888E69014, "Press " .. attachKeyName .. " to attach gator.") -- AddTextComponentScaleform()
						Citizen.InvokeNative(0x238FFE5C7B0498A6, 0, false, true, -1) -- EndTextCommandDisplayHelp()
					end
				end
			end
		end
    end
end)