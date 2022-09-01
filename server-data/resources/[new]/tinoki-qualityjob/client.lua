ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
end)

local hasjob = false
local ciuperci = 0

function DrawText3D(x,y,z, text, scl) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

local coordonate = {
    {736.0289,1301.0867,359.2962},
    {745.9656,1300.8491,359.2964},
    {733.6868,1273.5800,359.2962},
    {698.3311,1279.9468,359.2962},
    {686.6956,1286.8936,359.2962},
    {768.7957,1281.0298,359.2964},
}

local sleep = 2000

Citizen.CreateThread(function()                               
	while true do
        Citizen.Wait(sleep)
        perform = false
        local pos = GetEntityCoords(PlayerPedId())
        local metrii = math.floor(GetDistanceBetweenCoords(720.7438,1291.6547,360.2962, GetEntityCoords(PlayerPedId())))
        if ciuperci == 6 then
            perform = true
            DrawText3D(pos.x,pos.y,pos.z, "~y~Go get paycheck", 0.6)
        end
        if hasjob == true then
            for i,v in pairs(coordonate) do
                local metrii2 = math.floor(GetDistanceBetweenCoords(v[1],v[2],v[3], GetEntityCoords(PlayerPedId())))
                if ciuperci == 1 or ciuperci == 2 or ciuperci == 3 or ciuperci == 4 or ciuperci == 5 then
                    perform = true
                    DrawText3D(pos.x,pos.y,pos.z, "Check ups ~r~"..ciuperci.."~w~/~g~6", 0.6)
                end
                if coordonate[i] ~= nil then
                    if metrii2 <=3 then
                        perform = true
                        DrawText3D(v[1],v[2],v[3]+0.7, "Press ~y~[E]~w~ to check device", 0.8)
                        if IsControlJustPressed(1,51) then
                            table.remove(coordonate,i)
                            local playerPed = PlayerPedId()
                            exports.rprogress:Custom({
                                Duration = 10000,
                                Label = "Checking device...",
                                Animation = {
                                    scenario = "WORLD_HUMAN_CLIPBOARD", -- https://pastebin.com/6mrYTdQv
                                    animationDictionary = "", -- https://alexguirre.github.io/animations-list/
                                },
                                DisableControls = {
                                    Mouse = false,
                                    Player = true,
                                    Vehicle = true
                                }
                            })
                            SetTimeout(10000, function()
                            ClearPedTasks(playerPed)
                            exports.pNotify:SendNotification({
                                text = "You have checked the device", 
                                type = "info", 
                                timeout = math.random(2000, 2500), 
                                layout = "centerLeft", 
                                queue = "left"
                            })

                            ciuperci = ciuperci + 1
                                if ciuperci == 6 then
                                    SetNewWaypoint(720.7438,1291.6547)
                                end
                            end)
                        end
                    end
                else
                    perform = true
                    DrawText3D(coordonate[i]+0.7, "already been checked", 0.8)
                end
            end
        end
        if metrii <= 3 then
            perform = true
            DrawText3D(pos.x,pos.y,pos.z+0.6, "~y~[E]~w~ start working ~y~[Y]~w~ take your paycheck", 0.8)
            if IsControlJustPressed(1,51) then
                if hasjob == false then
                exports.pNotify:SendNotification({
                    text = "check the devices.", 
                    type = "info", 
                    timeout = math.random(2000, 2500), 
                    layout = "centerLeft", 
                    queue = "left"
                })
                hasjob = true
                SetNewWaypoint(686.6956,1286.8936)
                for i,v in pairs(coordonate) do
                    cvprop = CreateObject(GetHashKey('prop_ind_mech_02a'), v[1],v[2],v[3], false)
                end
                elseif hasjob == true then
                    exports.pNotify:SendNotification({
                        text = "you are already employed", 
                        type = "info", 
                        timeout = math.random(2000, 2500), 
                        layout = "centerLeft", 
                        queue = "left"
                    })
                end
            elseif IsControlJustPressed(1,246) then
                if ciuperci == 6 then
                table.insert(coordonate,{736.0289,1301.0867,359.2962})
                table.insert(coordonate,{745.9656,1300.8491,359.2964})
                table.insert(coordonate,{733.6868,1273.5800,359.2962})
                table.insert(coordonate,{698.3311,1279.9468,359.2962})
                table.insert(coordonate,{686.6956,1286.8936,359.2962})
                table.insert(coordonate,{768.7957,1281.0298,359.2964})
                TriggerServerEvent("tinoki-qualityjob:sell")
                ciuperci = 0
                hasjob = false
                DeleteEntity(cosdeoua)
                DeleteEntity(cosdeoua)
                else
                    exports.pNotify:SendNotification({
                        text = "Don't be stupid.", 
                        type = "info", 
                        timeout = math.random(2000, 2500), 
                        layout = "centerLeft", 
                        queue = "left"
                    })
                end
            end
        end
        if perform then
            sleep = 7
        elseif not perform then
            sleep = 2000
        end
    end
end)

local blips = {

     {title="Quality Job", colour=5, id=354, x = 720.7438, y = 1291.6547, z = 360.2962}
  }
      
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.6)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)