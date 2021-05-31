local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        DisableControlAction( 0, 36, true )
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
	end
end)

----CROUCH BOI
local crouched = false
function crouch()
    local ped = GetPlayerPed( -1 )
    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then
        if ( not IsPauseMenuActive() ) then
            RequestAnimSet( "move_ped_crouched" )
            while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
                Citizen.Wait( 100 )
            end 
            if ( crouched == true ) then 
                ResetPedMovementClipset( ped, 0 )
                crouched = false
            elseif ( crouched == false ) then
                SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
                crouched = true
            end
        end
    end
end

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		disableSeatShuffle(false)
		Citizen.Wait(5000)
		disableSeatShuffle(true)
	else
		CancelEvent()
	end
end)

RegisterCommand('ToggleCrouch', crouch, false)
RegisterKeyMapping('ToggleCrouch', 'crouch', 'keyboard', 'lcontrol')