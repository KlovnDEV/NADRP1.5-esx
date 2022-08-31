-- Settings
local guiEnabled = false
local hasOpened = false
local serverNotes = {}
local Controlkey = {["generalUse"] = {38,"E"},["generalUseSecondaryWorld"] = {23,"F"}} 

-- Open Gui and Focus NUI
function openGui()
  guiEnabled = true
  SetCustomNuiFocus(true, true)
  Citizen.Trace("OPENING")
  SendNUIMessage({openSection = "openNotepad"})
  local inveh = IsPedSittingInAnyVehicle(PlayerPedId())
  TriggerEvent("notepad")
end

function openGuiRead(text)
  guiEnabled = true
  SetCustomNuiFocus(true, true)
  Citizen.Trace("OPENING")
  SendNUIMessage({openSection = "openNotepadRead", TextRead = text})
  local inveh = IsPedSittingInAnyVehicle(PlayerPedId())
  TriggerEvent("notepad")
end


-- Close Gui and disable NUI
function closeGui()
  guiEnabled = false
  ped = PlayerPedId();
  ClearPedTasks(ped);
  Citizen.Trace("CLOSING")
  SetCustomNuiFocus(false, false)
  SendNUIMessage({openSection = "close"})
end

RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
  ClearPedProp (ped)
end)

RegisterNUICallback('drop', function(data, cb)
  closeGui()
  local coords = GetEntityCoords(PlayerPedId())
  TriggerServerEvent("server:newNote",data.noteText,coords["x"],coords["y"],coords["z"])
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)


    if #serverNotes == 0 then
      Citizen.Wait(500)
    else
      local plyLoc = GetEntityCoords(PlayerPedId())
      local closestNoteDistance = 900.0
      local closestNoteId = 0
      for i = 1, #serverNotes do
        local distance = #(plyLoc - vector3( serverNotes[i]["x"],serverNotes[i]["y"],serverNotes[i]["z"]))

        if distance < 10.0 then
            DrawMarker(27, serverNotes[i]["x"],serverNotes[i]["y"],serverNotes[i]["z"]-0.8, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 2.0, 255, 255,150, 75, 0, 0, 2, 0, 0, 0, 0)
        end

        if distance < closestNoteDistance then
          closestNoteDistance = distance
          closestNoteId = i
        end
      end

      if closestNoteDistance > 100.0 then
        Citizen.Wait(math.ceil(closestNoteDistance*10))
      end
      if serverNotes[closestNoteId] ~= nil then
        local distance = #(plyLoc - vector3( serverNotes[closestNoteId]["x"],serverNotes[closestNoteId]["y"],serverNotes[closestNoteId]["z"]))
        if distance < 2.0 then
            DrawMarker(27, serverNotes[closestNoteId]["x"],serverNotes[closestNoteId]["y"],serverNotes[closestNoteId]["z"]-0.8, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 2.0, 255, 255, 155, 75, 0, 0, 2, 0, 0, 0, 0)
            DrawText3Ds(serverNotes[closestNoteId]["x"],serverNotes[closestNoteId]["y"],serverNotes[closestNoteId]["z"]-0.4, "~b~"..Controlkey["generalUse"][2].."~s~ to read,~b~"..Controlkey["generalUseSecondaryWorld"][2].."~s~ to destroy")

            if IsControlJustReleased(0, Controlkey["generalUse"][1]) then
                openGuiRead(serverNotes[closestNoteId]["text"])
            end
            if IsControlJustReleased(0, Controlkey["generalUseSecondaryWorld"][1]) then
              TriggerServerEvent("server:destroyNote",closestNoteId)
            end

        end
      else
        if serverNotes[closestNoteId] ~= nil then
          table.remove(serverNotes,closestNoteId)
        end
      end
    end
    
  end

end)



RegisterNetEvent('Notepad:close')
AddEventHandler('Notepad:close', function()
  closeGui()
  ClearPedProp (ped)
end)

RegisterNetEvent('client:updateNotes')
AddEventHandler('client:updateNotes', function(serverNotesPassed)
    serverNotes = serverNotesPassed
end)

RegisterNetEvent('client:updateNotesAdd')
AddEventHandler('client:updateNotesAdd', function(newNote)
    serverNotes[#serverNotes+1] = newNote 
end)
RegisterNetEvent('client:updateNotesRemove')
AddEventHandler('client:updateNotesRemove', function(id)
    table.remove(serverNotes,id)
end)



RegisterNetEvent('Notepad:open')
AddEventHandler('Notepad:open', function()
    local veh = GetVehiclePedIsUsing(PlayerPedId())  
    if GetPedInVehicleSeat(veh, -1) ~= PlayerPedId() then
      openGui()
      guiEnabled = true
    end
end)

CreateThread(function()
  Wait(200)
  TriggerServerEvent("server:requestNotes")
end)

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

function SetCustomNuiFocus(hasKeyboard, hasMouse)
  HasNuiFocus = hasKeyboard or hasMouse
  SetNuiFocus(hasKeyboard, hasMouse)
  SetNuiFocusKeepInput(HasNuiFocus)
  TriggerEvent("mumble:focus:set", HasNuiFocus, hasKeyboard, hasMouse)
  TriggerEvent("nadrp-actionbar:disable", HasNuiFocus)
end