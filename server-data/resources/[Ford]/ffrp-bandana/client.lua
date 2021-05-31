ESX          = nil

bandana = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('elrp-bandana:bloodsbandana')
AddEventHandler('elrp-bandana:bloodsbandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
	if not bandana then
	RequestAnimDict(dict)
	TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	bandana = true
	SetPedPropIndex(GetPlayerPed(-1), 0, 14, 3, 2)
	elseif bandana then
	bandana = false
	RequestAnimDict(dict)
	TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
	end
end)

RegisterNetEvent('elrp-bandana:greenbandana')
AddEventHandler('elrp-bandana:greenbandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
	if not bandana then
	RequestAnimDict(dict)
	TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	bandana = true
	SetPedPropIndex(GetPlayerPed(-1), 0, 14, 0, 2)
	elseif bandana then
	bandana = false
	RequestAnimDict(dict)
	TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
	end
end)

RegisterNetEvent('elrp-bandana:ballasbandana')
AddEventHandler('elrp-bandana:ballasbandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
	if not bandana then
	RequestAnimDict(dict)
	TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	bandana = true
	SetPedPropIndex(GetPlayerPed(-1), 0, 14, 4, 2)
	elseif bandana then
	bandana = false
	RequestAnimDict(dict)
	TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
	end
end)

RegisterNetEvent('elrp-bandana:vagosbandana')
AddEventHandler('elrp-bandana:vagosbandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
	if not bandana then
	RequestAnimDict(dict)
	TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	bandana = true
	SetPedPropIndex(GetPlayerPed(-1), 0, 14, 7, 2)
	elseif bandana then
	bandana = false
	RequestAnimDict(dict)
	TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
	end
end)

RegisterNetEvent('elrp-bandana:cripsbandana')
AddEventHandler('elrp-bandana:cripsbandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
	if not bandana then
	RequestAnimDict(dict)
	TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	bandana = true
	SetPedPropIndex(GetPlayerPed(-1), 0, 14, 2, 2)
	elseif bandana then
	bandana = false
	RequestAnimDict(dict)
	TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
	end
end)

RegisterNetEvent('elrp-bandana:whitebandana')
AddEventHandler('elrp-bandana:whitebandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
	if not bandana then
	RequestAnimDict(dict)
	TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	bandana = true
	SetPedPropIndex(GetPlayerPed(-1), 0, 14, 1, 2)
	elseif bandana then
	bandana = false
	RequestAnimDict(dict)
	TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
	end
end)

RegisterNetEvent('elrp-bandana:blackbandana')
AddEventHandler('elrp-bandana:blackbandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
	if not bandana then
	RequestAnimDict(dict)
	TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	bandana = true
	SetPedPropIndex(GetPlayerPed(-1), 0, 14, 3, 2)
	elseif bandana then
	bandana = false
	RequestAnimDict(dict)
	TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
	end
end)

RegisterNetEvent('elrp-bandana:orangebandana')
AddEventHandler('elrp-bandana:orangebandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
	if not bandana then
	RequestAnimDict(dict)
	TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	bandana = true
	SetPedPropIndex(GetPlayerPed(-1), 0, 14, 6, 2)
	elseif bandana then
	bandana = false
	RequestAnimDict(dict)
	TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
	end
end)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end