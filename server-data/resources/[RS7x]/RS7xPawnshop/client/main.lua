ESX = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

local shop = { ['x'] = 182.71, ['y'] = -1319.41, ['z'] = 29.32, ['h'] = 54.98 }
local started = false
local run = 0
local complete = false
local name = false
local dropoffpoints = {
	[1] =  { ['x'] = 483.17,['y'] = -1827.35,['z'] = 27.86,['h'] = 135.87, ['info'] = ' East Side 1' },
	[2] =  { ['x'] = 475.87,['y'] = -1798.45,['z'] = 28.49,['h'] = 229.85, ['info'] = ' East Side 2' },
	[3] =  { ['x'] = 503.54,['y'] = -1765.06,['z'] = 28.51,['h'] = 67.61, ['info'] = ' East Side 3' },
	[4] =  { ['x'] = 512.0,['y'] = -1842.13,['z'] = 27.9,['h'] = 138.1, ['info'] = ' East Side 4' },
	[5] =  { ['x'] = 466.89,['y'] = -1852.81,['z'] = 27.72,['h'] = 310.97, ['info'] = ' East Side 5' },
	[6] =  { ['x'] = 431.33,['y'] = -1882.85,['z'] = 26.85,['h'] = 39.7, ['info'] = ' East Side 6' },
	[7] =  { ['x'] = 410.64,['y'] = -1908.57,['z'] = 25.46,['h'] = 80.03, ['info'] = ' East Side 7' },
	[8] =  { ['x'] = 192.93,['y'] = -2027.95,['z'] = 18.29,['h'] = 251.25, ['info'] = ' East Side 8' },
	[9] =  { ['x'] = 184.05,['y'] = -2004.77,['z'] = 18.31,['h'] = 49.81, ['info'] = ' East Side 9' },
	[10] =  { ['x'] = 212.4,['y'] = -1971.66,['z'] = 20.31,['h'] = 63.83, ['info'] = ' East Side 10' },
	[11] =  { ['x'] = 266.85,['y'] = -1964.41,['z'] = 23.0,['h'] = 49.59, ['info'] = ' East Side 11' },
	[12] =  { ['x'] = 313.05,['y'] = -1918.57,['z'] = 25.65,['h'] = 315.88, ['info'] = ' East Side 12' },
	[13] =  { ['x'] = 282.63,['y'] = -1948.96,['z'] = 24.39,['h'] = 40.21, ['info'] = ' East Side 13' },
	[14] =  { ['x'] = 250.44,['y'] = -1995.9,['z'] = 20.32,['h'] = 324.5, ['info'] = ' East Side 14' },
	[15] =  { ['x'] = 270.54,['y'] = -1706.13,['z'] = 29.31,['h'] = 46.82, ['info'] = ' Central 1' },
	[16] =  { ['x'] = 167.78,['y'] = -1635.0,['z'] = 29.3,['h'] = 22.04, ['info'] = ' Central 2' },
	[17] =  { ['x'] = 175.98,['y'] = -1542.48,['z'] = 29.27,['h'] = 316.21, ['info'] = ' Central 3' },
	[18] =  { ['x'] = -99.69,['y'] = -1577.74,['z'] = 31.73,['h'] = 231.66, ['info'] = ' Central 4' },
	[19] =  { ['x'] = -171.68,['y'] = -1659.11,['z'] = 33.47,['h'] = 85.41, ['info'] = ' Central 5' },
	[20] =  { ['x'] = -209.75,['y'] = -1632.29,['z'] = 33.9,['h'] = 177.99, ['info'] = ' Central 6' },
	[21] =  { ['x'] = -262.65,['y'] = -1580.04,['z'] = 31.86,['h'] = 251.02, ['info'] = ' Central 7' },
	[22] =  { ['x'] = -182.0,['y'] = -1433.79,['z'] = 31.31,['h'] = 210.92, ['info'] = ' Central 8' },
	[23] =  { ['x'] = -83.37,['y'] = -1415.39,['z'] = 29.33,['h'] = 180.98, ['info'] = ' Central 9' },
	[24] =  { ['x'] = -39.13,['y'] = -1473.67,['z'] = 31.65,['h'] = 5.17, ['info'] = ' Central 10' },
	[25] =  { ['x'] = 45.16,['y'] = -1475.65,['z'] = 29.36,['h'] = 136.92, ['info'] = ' Central 11' },
	[26] =  { ['x'] = 158.52,['y'] = -1496.02,['z'] = 29.27,['h'] = 133.49, ['info'] = ' Central 12' },
	[27] =  { ['x'] = 43.58,['y'] = -1599.87,['z'] = 29.61,['h'] = 50.3, ['info'] = ' Central 13' },
	[28] =  { ['x'] = 7.97,['y'] = -1662.14,['z'] = 29.33,['h'] = 318.63, ['info'] = ' Central 14' },
	[29] =  { ['x'] = -726.92,['y'] = -854.64,['z'] = 22.8,['h'] = 2.0, ['info'] = ' West 1' },
	[30] =  { ['x'] = -713.09,['y'] = -886.66,['z'] = 23.81,['h'] = 357.65, ['info'] = ' West 2' },
	[31] =  { ['x'] = -591.45,['y'] = -891.2,['z'] = 25.95,['h'] = 91.53, ['info'] = ' West 3' },
	[32] =  { ['x'] = -683.59,['y'] = -945.62,['z'] = 20.85,['h'] = 180.74, ['info'] = ' West 4' },
	[33] =  { ['x'] = -765.92,['y'] = -920.94,['z'] = 18.94,['h'] = 180.44, ['info'] = ' West 5' },
	[34] =  { ['x'] = -807.45,['y'] = -957.09,['z'] = 15.29,['h'] = 340.4, ['info'] = ' West 6' },
	[35] =  { ['x'] = -822.88,['y'] = -973.96,['z'] = 14.72,['h'] = 126.28, ['info'] = ' West 7' },
	[36] =  { ['x'] = -657.53,['y'] = -729.91,['z'] = 27.84,['h'] = 309.58, ['info'] = ' West 8' },
	[37] =  { ['x'] = -618.39,['y'] = -750.71,['z'] = 26.66,['h'] = 85.6, ['info'] = ' West 9' },
	[38] =  { ['x'] = -548.36,['y'] = -854.53,['z'] = 28.82,['h'] = 352.84, ['info'] = ' West 10' },
	[39] =  { ['x'] = -518.18,['y'] = -804.65,['z'] = 30.8,['h'] = 267.32, ['info'] = ' West 11' },
	[40] =  { ['x'] = -509.05,['y'] = -737.77,['z'] = 32.6,['h'] = 174.97, ['info'] = ' West 12' },
	[41] =  { ['x'] = -565.305,['y'] = -717.5001,['z'] = 33.1873,['h'] = 278.02, ['info'] = ' West 13' },
	[42] =  { ['x'] = -654.89,['y'] = -732.13,['z'] = 27.56,['h'] = 309.15, ['info'] = ' West 14' },
}


function DrawText3Ds(x,y,z, text)
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

Citizen.CreateThread(function()
    while true do
        hour = GetClockHours()
        minute = GetClockMinutes()
        Citizen.Wait(0)
        local ped = GetEntityCoords(GetPlayerPed(-1))
        if GetDistanceBetweenCoords(ped.x, ped.y, ped.z , shop["x"],shop["y"],shop["z"], true) < 2.0 then
            if not OnRun then
                if not closed and not OnRun then
                    DrawText3Ds(shop["x"],shop["y"],shop["z"], "~r~[E]")
                    if IsControlJustReleased(0,38) and not OnRun then
                        TriggerServerEvent('RS7x:RequestRun')
                    end
                else
                    DrawText3Ds(shop["x"],shop["y"],shop["z"], "~r~ Closed")
                end
            end
        else
            Citizen.Wait(500)
        end

        if hour >= 19 or hour <= 7 then
            closed = true
        else
            closed = false
        end

    end
end)

RegisterNetEvent('RS7x:check')
AddEventHandler('RS7x:check', function(StolenGood)
    name = StolenGood
end)

RegisterNetEvent('RS7x:StartRun')
AddEventHandler('RS7x:StartRun', function()
    OnRun = true
    if not started then
        started = true

        if run == 12 then
            started = false
            OnRun = false
            exports['mythic_notify']:SendAlert('success', 'You have completed your list.')
            run = 0
            return
        end

        rnd = math.random(1, #dropoffpoints)
        CreateBlip(dropoffpoints[rnd]["x"], dropoffpoints[rnd]["y"], dropoffpoints[rnd]["z"])
        
        local timer = 600000
        while started do
            Citizen.Wait(1)
            local dist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), dropoffpoints[rnd]["x"], dropoffpoints[rnd]["y"], dropoffpoints[rnd]["z"] , true)

            timer = timer - 1

            if timer <= 0 then
                OnRun = false
                started = false
                run = 0
                exports['mythic_notify']:SendAlert('inform', 'You took to long your run has been cancelled.')
                return
            end

            if dist <= 50.0 and not pedSpawned then
                exports['mythic_notify']:SendAlert('inform', 'You are close to the drop off point')
                DeleteCreatedPed()
                CreatePawnPed()
                pedSpawned = true
            end

            if dist < 5.0 and pedSpawned then

                local crds = GetEntityCoords(deliveryPed)
                DrawText3Ds(crds["x"],crds["y"],crds["z"], "[E]")

                if IsControlJustPressed(0,38) then
                    if HasStolenGoods() then
                        --TriggerServerEvent('RS7x:ItemCheck')
                        TaskTurnPedToFaceEntity(deliveryPed, GetPlayerPed(-1), 1.0)
                        Citizen.Wait(1500)
                        PlayAmbientSpeech1(deliveryPed, "Generic_Hi", "Speech_Params_Force")
                        TriggerEvent('RS7x:DoDropOff')
                        started = false
                    --else
                    --    print('GOT HERE3')
                    --    TriggerEvent('RS7x:failed', false)
                    end
                end
            end
        end
    end
end)


local stolenGoodsTable = {
	[1] = "rolexwatch",
	[2] = "valuablegoods",
    [3] = "stolenraybans",
    [4] = "stolens8",
    [5] = "stolennokia",
    [6] = "stoleniphone",
    [7] = "stolengameboy",
    [8] = "stolencasiowatch",
    [9] = "stolen8ctchain",
    [10] = "stolen5ctchain",
    [11] = "stolen2ctchain",
    [12] = "stolen10ctchain",
    [13] = "stoleffrpsp",
}

function HasStolenGoods()
    for i=1, #stolenGoodsTable do
        local hasItem = exports["ffrp-inventory"]:hasEnoughOfItem(stolenGoodsTable[i],1,false)
        if hasItem then
            name = stolenGoodsTable[i]
            return true
        end
    end
    return false
end

RegisterNetEvent('RS7x:DoDropOff')
AddEventHandler('RS7x:DoDropOff', function()
    if DoesEntityExist(deliveryPed) and not IsPedDeadOrDying(deliveryPed, false) then
        PlayAmbientSpeech1(deliveryPed, "Chat_State", "Speech_Params_Force")
        TaskTurnPedToFaceEntity(deliveryPed, GetPlayerPed(-1), 1.0)

        Citizen.Wait(2000)
        giveAnim(deliveryPed)
        Citizen.Wait(3000)
        giveAnim(GetPlayerPed(-1))
        Citizen.Wait(3000)
        --TriggerEvent("attachItem","cashcase01")
        local itemcount = exports["ffrp-inventory"]:getQuantity(name)
        print(name, itemcount)
        TriggerServerEvent('RS7x:payout', name, itemcount)

        complete = true

        if complete then
            exports['mythic_notify']:SendAlert('inform', 'I got the call in, Go await the next drop')
            DeleteBlip()
            DeleteCreatedPed()
            run = run + 1
            Citizen.Wait(math.random(30000, 40000))
            pedSpawned = false
            TriggerEvent('RS7x:StartRun')
        end
    end
end)

function CreatePawnPed()

    local hashKey = GetHashKey('a_m_y_stwhi_01')

    local pedType = 5
    
    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end


	deliveryPed = CreatePed(pedType, hashKey, dropoffpoints[rnd]["x"], dropoffpoints[rnd]["y"], dropoffpoints[rnd]["z"], dropoffpoints[rnd]["h"], 0, 0)
    --local netObject = exports['ffrp-ped']:GlobalObject(deliveryPed)
    ClearPedTasks(deliveryPed)
    ClearPedSecondaryTask(deliveryPed)
    TaskSetBlockingOfNonTemporaryEvents(deliveryPed, true)
    SetPedFleeAttributes(deliveryPed, 0, 0)
    SetPedCombatAttributes(deliveryPed, 17, 1)

    SetPedSeeingRange(deliveryPed, 0.0)
    SetPedHearingRange(deliveryPed, 0.0)
    SetPedAlertness(deliveryPed, 0)
    --searchPockets()
    SetPedKeepTask(deliveryPed, true)

end

function DeleteBlip()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
	end
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function giveAnim(ped)
    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        loadAnimDict( "mp_safehouselost@" )
        if ( IsEntityPlayingAnim( ped, "mp_safehouselost@", "package_dropoff", 3 ) ) then 
            TaskPlayAnim( ped, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        else
            TaskPlayAnim( ped, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        end
    end
end

function CreateBlip(x,y,z)
	DeleteBlip()
	if OxyRun then
		blip = AddBlipForCoord(x,y,z)
	else
		blip = AddBlipForCoord(x,y,z)
	end

    SetBlipSprite(blip, 514)
    SetBlipScale(blip, 1.0)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Drop Off")
    EndTextCommandSetBlipName(blip)
end

function DeleteCreatedPed()
	print("Deleting Ped?")
	if DoesEntityExist(deliveryPed) then 
		SetPedKeepTask(deliveryPed, false)
		TaskSetBlockingOfNonTemporaryEvents(deliveryPed, false)
		ClearPedTasks(deliveryPed)
		TaskWanderStandard(deliveryPed, 10.0, 10)
		SetPedAsNoLongerNeeded(deliveryPed)

		Citizen.Wait(20000)
		DeletePed(deliveryPed)
	end
end

--[[function SearchPockets(ai)
    local timer = 3000
    local ai = ai
    local searching = false
    
    while timer > 0 do
        timer = timer - 1
        local pos = GetEntityCoords(ai)
        Citizen.Wait(1)

        if not searching then
            DrawText3Ds(pos["x"], pos["y"],pos["z"], "Press E to search person.")
            if IsControlJustReleased(1,38) and GetDistanceBetweenCoords(pos,GetEntityCoords(GetPlayerPed(-1))) < 3.0 then
                searching = true
                TriggerEvent("animation:PlayAnimation","search")
                exports['t0sic_loadingbar']:StartDelayedFunction('searching', 10000, function()
                    DropItemPed(ai)
                    ClearPedTasks(GetPlayerPed(-1))
                    timer = 0
                end)
            end
        end
    end
    searching = false
end]]

RegisterNetEvent('RS7x:failed')
AddEventHandler('RS7x:failed', function(failed)
    if failed then
        started = false
        OnRun = false
        run = 0
        DeleteBlip()
        DeleteCreatedPed()
    end
end)
