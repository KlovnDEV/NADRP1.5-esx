ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

local group = "user"
RegisterNetEvent('es_admin:setGroup')
AddEventHandler('es_admin:setGroup', function(g)
	group = g
end)

---------------------------------------------------------

local nadrp = nadrp or {}
nadrp.Scoreboard = {}
nadrp._Scoreboard = {}

nadrp.Scoreboard.Menu = {}

nadrp._Scoreboard.Players = {}
nadrp._Scoreboard.Recent = {}
nadrp._Scoreboard.SelectedPlayer = nil
nadrp._Scoreboard.MenuOpen = false
nadrp._Scoreboard.Menus = {}

local function spairs(t, order)
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function nadrp.Scoreboard.AddPlayer(self, data)
    nadrp._Scoreboard.Players[data.src] = data
end

function nadrp.Scoreboard.RemovePlayer(self, data)
    nadrp._Scoreboard.Players[data.src] = nil
    nadrp._Scoreboard.Recent[data.src] = data
end

function nadrp.Scoreboard.RemoveRecent(self, src)
    nadrp._Scoreboard.Recent[src] = nil
end

function nadrp.Scoreboard.AddAllPlayers(self, data, recentData)
    nadrp._Scoreboard.Players[data.src] = data
    nadrp._Scoreboard.Recent[recentData.src] = recentData
end

function nadrp.Scoreboard.GetPlayerCount(self)
    local count = 0

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then count = count + 1 end
    end

    return count
end

Citizen.CreateThread(function()
    local function DrawMain()
        if WarMenu.Button("Total:", tostring(nadrp.Scoreboard:GetPlayerCount()), {r = 135, g = 206, b = 250, a = 150}) then end

        for k,v in spairs(nadrp._Scoreboard.Players, function(t, a, b) return t[a].src < t[b].src end) do
            local playerId = GetPlayerFromServerId(v.src)

            if NetworkIsPlayerActive(playerId) or GetPlayerPed(playerId) == GetPlayerPed(-1) then
                if WarMenu.MenuButton("[" .. v.src .. "] " .. v.steamid .. " ", "options") then nadrp._Scoreboard.SelectedPlayer = v end
            else
                if WarMenu.MenuButton("[" .. v.src .. "] - instanced?", "options", {r = 255, g = 0, b = 0, a = 255}) then nadrp._Scoreboard.SelectedPlayer = v end
            end
        end

        if WarMenu.MenuButton("Recent Disconnects", "recent", {r = 0, g = 0, b = 0, a = 150}) then
        end
    end

    local function DrawRecent()
        for k,v in spairs(nadrp._Scoreboard.Recent, function(t, a, b) return t[a].src < t[b].src end) do
            if WarMenu.MenuButton("[" .. v.src .. "] " .. v.name, "options") then nadrp._Scoreboard.SelectedPlayer = v end
        end
    end

    local function DrawOptions()
        if group ~= "user" or group ~= "moderator" then
            if WarMenu.Button("Name:", nadrp._Scoreboard.SelectedPlayer.name) then end
        end
        if WarMenu.Button("Steam ID:", nadrp._Scoreboard.SelectedPlayer.steamid) then end
        if WarMenu.Button("Community ID:", nadrp._Scoreboard.SelectedPlayer.comid) then end
        if WarMenu.Button("Server ID:", nadrp._Scoreboard.SelectedPlayer.src) then end
    end

    nadrp._Scoreboard.Menus = {
        ["scoreboard"] = DrawMain,
        ["recent"] = DrawRecent,
        ["options"] = DrawOptions
    }

    local function Init()
        WarMenu.CreateMenu("scoreboard", "Player List")
        WarMenu.SetSubTitle("scoreboard", "Players")

        WarMenu.SetMenuWidth("scoreboard", 0.5)
        WarMenu.SetMenuX("scoreboard", 0.71)
        WarMenu.SetMenuY("scoreboard", 0.017)
        WarMenu.SetMenuMaxOptionCountOnScreen("scoreboard", 30)
        WarMenu.SetTitleColor("scoreboard", 135, 206, 250, 255)
        WarMenu.SetTitleBackgroundColor("scoreboard", 0 , 0, 0, 150)
        WarMenu.SetMenuBackgroundColor("scoreboard", 0, 0, 0, 100)
        WarMenu.SetMenuSubTextColor("scoreboard", 255, 255, 255, 255)

        WarMenu.CreateSubMenu("recent", "scoreboard", "Recent D/C's")
        WarMenu.SetMenuWidth("recent", 0.5)
        WarMenu.SetTitleColor("recent", 135, 206, 250, 255)
        WarMenu.SetTitleBackgroundColor("recent", 0 , 0, 0, 150)
        WarMenu.SetMenuBackgroundColor("recent", 0, 0, 0, 100)
        WarMenu.SetMenuSubTextColor("recent", 255, 255, 255, 255)

        WarMenu.CreateSubMenu("options", "scoreboard", "User Info")
        WarMenu.SetMenuWidth("options", 0.5)
        WarMenu.SetTitleColor("options", 135, 206, 250, 255)
        WarMenu.SetTitleBackgroundColor("options", 0 , 0, 0, 150)
        WarMenu.SetMenuBackgroundColor("options", 0, 0, 0, 100)
        WarMenu.SetMenuSubTextColor("options", 255, 255, 255, 255)
    end
    Init()
    timed = 0
    while true do
        for k,v in pairs(nadrp._Scoreboard.Menus) do
            if WarMenu.IsMenuOpened(k) then
                v()
                WarMenu.Display()
            else
                if timed > 0 then
                    timed = timed - 1
                end
            end
        end

        Citizen.Wait(1)
    end
end)

function nadrp.Scoreboard.Menu.Open(self)
    nadrp._Scoreboard.SelectedPlayer = nil
    WarMenu.OpenMenu("scoreboard")
end

function nadrp.Scoreboard.Menu.Close(self)
    for k,v in pairs(nadrp._Scoreboard.Menus) do
        WarMenu.CloseMenu(K)
    end
end

Citizen.CreateThread(function()
    local function IsAnyMenuOpen()
        for k,v in pairs(nadrp._Scoreboard.Menus) do
            if WarMenu.IsMenuOpened(k) then return true end
        end

        return false
    end

    while true do
        Citizen.Wait(0)
        if IsControlPressed(0, 166) then
            if not IsAnyMenuOpen() then
                nadrp.Scoreboard.Menu:Open()
            end
        else
            if IsAnyMenuOpen() then nadrp.Scoreboard.Menu:Close() end
            Citizen.Wait(100)
        end
    end
end)

RegisterNetEvent("nadrp-scoreboard:RemovePlayer")
AddEventHandler("nadrp-scoreboard:RemovePlayer", function(data)
    nadrp.Scoreboard:RemovePlayer(data)
end)

RegisterNetEvent("nadrp-scoreboard:AddPlayer")
AddEventHandler("nadrp-scoreboard:AddPlayer", function(data)
    nadrp.Scoreboard:AddPlayer(data)
end)

RegisterNetEvent("nadrp-scoreboard:RemoveRecent")
AddEventHandler("nadrp-scoreboard:RemoveRecent", function(src)
    nadrp.Scoreboard:RemoveRecent(src)
end)

RegisterNetEvent("nadrp-scoreboard:AddAllPlayers")
AddEventHandler("nadrp-scoreboard:AddAllPlayers", function(data, recentData)
    nadrp.Scoreboard:AddAllPlayers(data, recentData)
end)

-----------------------------
-- Player IDs Above Head
-----------------------------

local hidden = {}
local showPlayerBlips = false
local ignorePlayerNameDistance = false
local disPlayerNames = 50
local playerSource = 0

function DrawText3DTalking(x,y,z, text, textColor)
    local color = { r = 220, g = 220, b = 220, alpha = 255 }
    if textColor ~= nil then 
        color = {r = textColor[1] or 22, g = textColor[2] or 55, b = textColor[3] or 155, alpha = textColor[4] or 255}
    end

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(px,py,pz) - vector3(x,y,z))

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.0*scale, 0.75*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(color.r, color.g, color.b, color.alpha)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

RegisterNetEvent("hud:HidePlayer")
AddEventHandler("hud:HidePlayer", function(player, toggle)
    if type(player) == "table" then
        for k,v in pairs(player) do
            local id = GetPlayerFromServerId(k)
            hidden[id] = k
        end
        return
    end
    local id = GetPlayerFromServerId(player)
    if toggle == true then hidden[id] = player
    else
        for k,v in pairs(hidden) do
            if v == player then hidden[k] = nil end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if IsControlPressed(0, 166) then

            for i=0,255 do
                N_0x31698aa80e0223f8(i)
            end
            for id = 0, 255 do
                if NetworkIsPlayerActive( id ) --[[ and GetPlayerPed( id ) ~= GetPlayerPed( -1 )) ]] then
                    local playerped = PlayerPedId()
                    local HeadBone = 0x796e
                    local ped = GetPlayerPed(id)
                    local playerCoords = GetPedBoneCoords(playerped, HeadBone)
                    if ped == playerped then
                        DrawText3DTalking(playerCoords.x, playerCoords.y, playerCoords.z+0.5, " ".. GetPlayerServerId(id) .. " ", {152, 251, 152, 255})
                    else
                        local pedCoords = GetPedBoneCoords(ped, HeadBone)
                        local distance = math.floor(#(playerCoords - pedCoords))

                        local isDucking = IsPedDucking(GetPlayerPed( id ))
                        local cansee = HasEntityClearLosToEntity( GetPlayerPed( -1 ), GetPlayerPed( id ), 17 )
                        local isReadyToShoot = IsPedWeaponReadyToShoot(GetPlayerPed( id ))
                        local isStealth = GetPedStealthMovement(GetPlayerPed( id ))
                        local isDriveBy = IsPedDoingDriveby(GetPlayerPed( id ))
                        local isInCover = IsPedInCover(GetPlayerPed( id ),true)
                        if isStealth == nil then
                            isStealth = 0
                        end

                        if isDucking or isStealth == 1 or isDriveBy or isInCover then
                            cansee = false
                        end

                        if hidden[id] then cansee = false end
                        
                        if (distance < disPlayerNames) then
                            local isTalking = 0
                            if isTalking > 0 then
                                if cansee then
                                    DrawText3DTalking(pedCoords.x, pedCoords.y, pedCoords.z+0.5, " ".. GetPlayerServerId(id) .. " ", {140, 204, 239, 255})
                                end
                            else
                                if cansee then
                                    DrawText3DTalking(pedCoords.x, pedCoords.y, pedCoords.z+0.5, " ".. GetPlayerServerId(id) .. " ", {255, 255, 255, 255})
                                end
                            end
                        end
                            
                    end
                end
            end
            Citizen.Wait(1)
        else
            Citizen.Wait(2000)
        end
    end
end)