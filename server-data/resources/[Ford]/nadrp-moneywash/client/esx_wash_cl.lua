local GUI          			  = {}
local hasAlreadyEnteredMarker = false
local isInWASHMarker 			  = false
local menuIsShowed   		  = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_moneywash:closeWASH')
AddEventHandler('esx_moneywash:closeWASH', function()
	SetNuiFocus(false)
	menuIsShowed = false
	SendNUIMessage({
		hideAll = true
	})
end)

RegisterNUICallback('escape', function(data, cb)
  	TriggerEvent('esx_moneywash:closeWASH')
	cb('ok')
end)

RegisterNUICallback('deposit', function(data, cb)
	TriggerServerEvent('esx_moneywash:deposit', data.amount)
	cb('ok')
end)

RegisterNUICallback('withdraw', function(data, cb)
	TriggerServerEvent('esx_moneywash:withdraw', data.amount)
	cb('ok')
end)

-- Create Blips
Citizen.CreateThread(function()

	if Config.Blip then
	
	for i=1, #Config.Map, 1 do
		
		local blip = AddBlipForCoord(Config.Map[i].x, Config.Map[i].y, Config.Map[i].z)
		SetBlipSprite (blip, Config.Map[i].id)
		SetBlipDisplay(blip, 4)
		SetBlipColour (blip, Config.Map[i].color)
		SetBlipScale  (blip, Config.Map[i].scale)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Map[i].name)
		EndTextCommandSetBlipName(blip)
	end
end
end)

-- Render markers
Citizen.CreateThread(function()
	while true do
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for i=1, #Config.WASH, 1 do
			if(GetDistanceBetweenCoords(coords, Config.WASH[i].x, Config.WASH[i].y, Config.WASH[i].z, true) < Config.DrawDistance) then
				found = true
				DrawMarker(Config.MarkerType, Config.WASH[i].x, Config.WASH[i].y, Config.WASH[i].z - Config.ZDiff, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end
		if found then 
			Citizen.Wait(0)
		else
			Citizen.Wait(500)
		end
		found = false
	end
end)

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		local dist = #(GetEntityCoords(ped, false) - vector3(1122.43,  -3194.49, -40.4))
		if dist < 5.0 then
			found = true
			DrawMarker(27, 1122.43,  -3194.49,  -40.4-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
			if dist < 2.0 then 
				DT(1122.43,  -3194.49, -40.4)
				if IsControlJustPressed(0, 38) then
					CleanCash()
				end
			end
		end
		if found then
			Citizen.Wait(0)
		else
			Citizen.Wait(500)
		end
		found = false
	end
end)

local Cleanables = {
	[1] = {["item"] = 'cashroll', ["payout"] = math.random(65, 85)},
	[2] = {["item"] = 'markedbills', ["payout"] = math.random(1000, 1200)},
	[3] = {["item"] = 'band', ["payout"] = math.random(100, 150)},
	[4] = {["item"] = 'rollcash', ["payout"] = math.random(85, 100)}
}

function CleanCash()
	for i=1, #Cleanables do
		if exports["nadrp-inventory"]:hasEnoughOfItem(Cleanables[i].item,1,false) then
			local itemCount = exports["nadrp-inventory"]:getQuantity(Cleanables[i].item)
			if itemCount > 0 and not cleaning then
				cleaning = true
				TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 15000, true)
				exports['t0sic_loadingbar']:StartDelayedFunction('Washing money', 18000, function()
					if exports["nadrp-inventory"]:hasEnoughOfItem(Cleanables[i].item,itemCount,false) then
						TriggerServerEvent('Ford:Wash', itemCount, Cleanables[i].payout)
						TriggerEvent('inventory:removeItem',Cleanables[i].item, itemCount)
						cleaning = false
						ClearPedTasks(PlayerPedId())
					end
					return
				end)
			end
		end
	end
end

function DT(x,y,z)
	local text = "Press ~r~[E]~w~ to wash money!"
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