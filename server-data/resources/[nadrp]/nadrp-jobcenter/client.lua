---------------------------------- VAR ----------------------------------
isCop = false
curJob = nil

local changeYourJob = {
    {name = "Job Center", colour = 17, id = 351, x = 237.7632, y = -414.0678, z = 47.94788}
}

local jobs = {
    {name = "Unemployed", id = "unemployed"},
    {name = "Taxi", id = "taxi"},
    {name = "Miner Job", id = "miner"},
    {name = "Reporter", id = "reporter"},
    {name = "Garbage Job", id = "garbage"},
    {name = "Taco", id = "taco"},
   -- {name = "Trucker", id = "trucker"}
}

---------------------------------- FUNCTIONS ----------------------------------

function drawTxt(text, font, centre, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function menuJobs()
    MenuTitle = "Jobs"
    ClearMenu()

    for _, item in pairs(jobs) do
        local nameJob = item.name
        local idJob = item.id
        Menu.addButton(nameJob, "SetJob", idJob)
    end
    Menu.addButton("Exit", "SetJob", "exit")
end

function SetJob(job)
    if job == "exit" then
        ClearMenu()
    else
        TriggerServerEvent("jobsystem:Job", job)
        TriggerEvent('nadrp:playerBecameJob', job)
        exports['mythic_notify']:DoLongHudText('inform', 'Your job has been set to '..job)
    end
end

local zones = {
    vector3(238.2307, -414.2452, 47.0)
}

-- #MarkedForMarker
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            local ply = PlayerPedId()
            local plyCoords = GetEntityCoords(ply, 0)

            for k, v in pairs(zones) do
                local dist = Vdist2(GetEntityCoords(PlayerPedId()), v.x, v.y, v.z)
                if dist < 5.0 then
                    DrawMarker(27, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.7, 0, 255, 0, 100, 0, 0, 0, 0)
                    DrawText3Ds(v.x, v.y, v.z + 1.0, "[E] - Job center")
                    if dist < 1 then
                        if IsControlJustPressed(0, 38) then
                            menuJobs()
                            Menu.hidden = not Menu.hidden
                        end
                    end
                else
                    Citizen.Wait(1000)
                end
            end
            Menu.renderGUI()
        end
    end
)

local blips = {
    -- Example {title="", colour=, id=, x=, y=, z=},
    {title = "Job Center", colour = 5, id = 40, x = 237.7632, y = -414.0678, z = 47.94788}
}

Citizen.CreateThread(
    function()
        for _, info in pairs(blips) do
            info.blip = AddBlipForCoord(info.x, info.y, info.z)
            SetBlipSprite(info.blip, 525)
            SetBlipDisplay(info.blip, 4)
            SetBlipScale(info.blip, 0.6)
            SetBlipColour(info.blip, info.colour)
            SetBlipAsShortRange(info.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(info.title)
            EndTextCommandSetBlipName(info.blip)
        end
    end
)

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
