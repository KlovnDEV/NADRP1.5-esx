ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

local found = false
local spawnedPeds = {}
local whitelisted = {
   --27, -- Reece
   1,
   540,
   1186,
}
local locations = {
    [1] = { ["x"] = -1321.219, ["y"] = -1264.057, ["z"] = 4.59, ["h"] = 105.767,  ["info"] = 'door'},
    [2] = { ["x"] = 1088.716, ["y"] = -3187.748, ["z"] = -38.993, ["h"] = 178.374,  ["info"] = 'inside'},
    --[3] = { ["x"] = 903.7332, ["y"] = -3199.645, ["z"] = -97.18799, ["info"] = 'stash'}
}
local pedLocations = {
	[1] =  { ['x'] = 1101.99,['y'] = -3193.72,['z'] = -38.99,['h'] = 355.19, ['model'] = 'mp_f_cocaine_01' },
	[2] =  { ['x'] = 1099.56,['y'] = -3194.44,['z'] = -38.99,['h'] = 45.81, ['model'] = 'mp_f_cocaine_01' },
	[3] =  { ['x'] = 1093.13,['y'] = -3194.92,['z'] = -38.99,['h'] = 175.54, ['model'] = 'mp_f_cocaine_01' },
	[4] =  { ['x'] = 1092.6,['y'] = -3196.67,['z'] = -38.99,['h'] = 350.64, ['model'] = 'mp_f_cocaine_01' },
}
local workAreas = {
    [1] =  { ['x'] = 1089.95,['y'] = -3198.86,['z'] = -38.99,['h'] = 184.41, ['info'] = ' Check Product', ["itemid"] = 33, ["name"] = "Rubber" },
    [2] =  { ['x'] = 1093.53,['y'] = -3199.12,['z'] = -38.99,['h'] = 178.7, ['info'] = ' Check Product', ["itemid"] = 33, ["name"] = "Rubber" },
    [3] =  { ['x'] = 1100.16,['y'] = -3198.62,['z'] = -38.99,['h'] = 196.58, ['info'] = ' Check Product', ["itemid"] = 33, ["name"] = "Rubber" },
    [4] =  { ['x'] = 1100.93,['y'] = -3193.77,['z'] = -38.99,['h'] = 353.0, ['info'] = ' Check Product', ["itemid"] = 33, ["name"] = "Rubber" },
    [5] =  { ['x'] = 1087.29,['y'] = -3196.9,['z'] = -38.99,['h'] = 81.27, ['info'] = ' Check Product', ["itemid"] = 33, ["name"] = "Rubber" },
}

Citizen.CreateThread(function()
    while true do
        local pos = GetEntityCoords(PlayerPedId())
        if #(vector3(locations[1]["x"], locations[1]["y"],locations[1]["z"]) - pos) <= 2.0 then
            found = true
            if IsControlJustPressed(0, 38) then
                if IsCokeWhitelisted() then
                    SpawnPeds()
                    SetEntityCoords(PlayerPedId(), locations[2]["x"], locations[2]["y"], locations[2]["z"])
                    Wait(500)
                    inside = true
                end
            end
        end

        if #(vector3(locations[2]["x"], locations[2]["y"],locations[2]["z"]) - pos) <= 4.0 then
            found = true
            if IsControlJustPressed(0, 38) then
                if IsCokeWhitelisted() then
                    RemoveSpawnedPeds()
                    SetEntityCoords(PlayerPedId(), locations[1]["x"], locations[1]["y"], locations[1]["z"])
                    Wait(500)
                    inside = false
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

Citizen.CreateThread(function()
    while true do
        if inside then 
            Citizen.Wait(0)
        else
            Citizen.Wait(1000)
        end
    end
end)

RegisterNetEvent('ffrp-gangs:startTask')
AddEventHandler('ffrp-gangs:startTask', function(passedid,amount)
	currentTaskId = passedid
	while currentTaskId ~= 0 do
		local x,y,z = workAreas[passedid]["x"], workAreas[passedid]["y"], workAreas[passedid]["z"]
		local msg = workAreas[passedid]["info"]
		local itemname = workAreas[passedid]["name"]
		local dstCheck = #(GetEntityCoords(PlayerPedId()) - vector3(x,y,z))
		if dstCheck < 20.0 then
			DrawText3D(x,y,z, "[E]" .. msg .. "")
			if IsControlJustPressed(0, 38) and dstCheck < 3.0 then
				AttemptTask(passedid,amount)
			end
		elseif dstCheck > 50.0 then
			Citizen.Wait(1000)
		end
		Citizen.Wait(1)
	end
end)

RegisterNetEvent('ffrp-gangs:cokestatus')
AddEventHandler('ffrp-gangs:cokestatus', function()
    if IsCokeWhitelisted() then 
        TriggerServerEvent('ffrp-drugs:coke:status')
    end
end)

RegisterNetEvent('ffrp-gangs:currentCokeStatus')
AddEventHandler('ffrp-gangs:currentCokeStatus', function(cocaine_percent,cocaine_status,cocaine_amount)
    if cocaine_status == 0 then
        cocaine_status = "No Task Being Done"
    else
        cocaine_status = "Task In Process"
    end
    TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message nonemergency">COCAINE: {0} </div>',
        args = {"Current Batch: " .. cocaine_percent .. "% | Crates Available: " .. cocaine_amount .." |  Current Status: "..cocaine_status}
    })
end)

RegisterNetEvent('ffrp-gangs:removeBrick')
AddEventHandler('ffrp-gangs:removeBrick', function()
    if IsCokeWhitelisted() then
        TriggerServerEvent('ffrp-gangs:coke:removeBrick')
    end
end)

function SpawnPeds()
	for i = 1, #pedLocations do
		local pedType = `mp_f_cocaine_01`

        RequestModel(pedType)
        while not HasModelLoaded(pedType) do
            Citizen.Wait(0)
        end
        ped = CreatePed(26, pedType, pedLocations[i]["x"],pedLocations[i]["y"],pedLocations[i]["z"],pedLocations[i]["h"], 0, 1)
	    local dict = "anim@amb@business@coc@coc_unpack_cut@"
        local anim = "fullcut_cycle_v6_cokecutter"
        SetPedAlertness(ped, 1)
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
        end
        table.insert(spawnedPeds,ped)
        TimedAnim(ped,dict,anim)
        SetModelAsNoLongerNeeded(pedType)
    end
end

function RemoveSpawnedPeds()
    for i=1, #spawnedPeds do
        if DoesEntityExist(spawnedPeds[i]) then
            DeleteEntity(spawnedPeds[i])
        end
    end
    spawnedPeds = {}
end

function TimedAnim(ped,dict,anim)
    Citizen.CreateThread(function()
        local testdic2 = "friends@fra@ig_1"
        local testanim2 = "base_idle"
        if math.random(4) == 1 then
            testanim2 = "impatient_idle_c"
        elseif math.random(3) > 1 then
            testanim2 = "impatient_idle_a"
        else
            testanim2 = "idle_b"
        end
        RequestAnimDict(testdic2)
        while not HasAnimDictLoaded(testdic2) do
            Citizen.Wait(0)
        end
    
        TaskPlayAnim(ped, testdic2, testanim2, 1.0, 1.0, -1, 1, -1, 0, 0, 0)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetPedSeeingRange(ped, 0.0)
        SetPedHearingRange(ped, 0.0)
        SetPedFleeAttributes(ped, 0, false)
        SetPedKeepTask(ped, true)
        Citizen.Wait(math.random(35000))
        TaskPlayAnim(ped, dict, anim, 1.0, 1.0, -1, 1, -1, 0, 0, 0)
    
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetPedSeeingRange(ped, 0.0)
        SetPedHearingRange(ped, 0.0)
        SetPedFleeAttributes(ped, 0, false)
        SetPedKeepTask(ped, true)
    end)
end

function IsCokeWhitelisted()
    local cid = exports['ffrp-ped']:isPed('cid')
    for i=1, #whitelisted do
        if whitelisted[i] == cid then
            return true
        end
    end
    return false
end

function AttemptTask(workNumber,amountRequired)
	--local itemid = workAreas[workNumber]["itemid"]
	currentTaskId = 0
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CLIPBOARD", 0, false)
	Citizen.Wait(10000)
    exports['mythic_notify']:SendAlert('inform', 'You have fixed the problems.')
	TriggerServerEvent("ffrp-gangs:coke:updatepercent")
	Citizen.Wait(1500)
    ClearPedTasks(PlayerPedId())
end

function DrawText3D(x,y,z, text)
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