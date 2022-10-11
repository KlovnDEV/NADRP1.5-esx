ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

--[[ item setup
chance (1-10) - lower = more common
id - Item ID
name - Item Name
quantity = amount you get when you find the item
]]
   local dumpsterItems = {
    [1] = {chance = 1, id = 'scrapmetal', name = 'scrapmetal', quantity = 1},
}


TriggerEvent('player:receiveItem','scrapmetal',1)
--[[elseif myluck == 2 then
    TriggerEvent("player:receiveItem","securityblack",1)
elseif myluck == 3 then
    TriggerEvent("player:receiveItem","securitygreen",1)
elseif myluck == 4 then
    TriggerEvent("player:receiveItem","securitygold",1)
else
    TriggerEvent("player:receiveItem","securityred",1)
end]]

