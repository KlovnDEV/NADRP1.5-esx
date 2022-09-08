ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

isSmashed = {}
isSmashed[1] = false
isSmashed[2] = false
isSmashed[3] = false
isSmashed[4] = false
isSmashed[5] = false
isSmashed[6] = false
isSmashed[7] = false
isSmashed[8] = false
isSmashed[9] = false
isSmashed[10] = false
isSmashed[11] = false
isSmashed[12] = false
isSmashed[13] = false
isSmashed[14] = false
isSmashed[15] = false
isSmashed[16] = false
isSmashed[17] = false
isSmashed[18] = false
isSmashed[19] = false
isSmashed[20] = false

local resetStarted = false
local resetTimer = ((60 * 1000) * 40)

RegisterNetEvent('jewel:isSmashed')
AddEventHandler('jewel:isSmashed', function(num)
    local xPlayers = ESX.GetPlayers()
    isSmashed[num] = true
    resetStarted = true
    TriggerEvent("case:Reset")
    TriggerClientEvent("jewel:robbed", -1, isSmashed)
end)

RegisterServerEvent('cop:alert')
AddEventHandler('cop:alert', function(coords, streetName)
    TriggerEvent('tac_outlawalert:vangelicoInProgress', coords, streetName)
end)

--RegisterNetEvent('case:request')
--AddEventHandler('case:request', function()
--    TriggerClientEvent("case:robbed", src, isSmashed)
--end)

RegisterNetEvent('case:Reset')
AddEventHandler('case:Reset', function()
	SetTimeout(600000, turnJewelsOff)
end)

function turnJewelsOff()
	isSmashed[1] = true
	isSmashed[2] = true
	isSmashed[3] = true
	isSmashed[4] = true
	isSmashed[5] = true
	isSmashed[6] = true
	isSmashed[7] = true
	isSmashed[8] = true
	isSmashed[9] = true
	isSmashed[10] = true
	isSmashed[11] = true
	isSmashed[12] = true
	isSmashed[13] = true
	isSmashed[14] = true
	isSmashed[15] = true
	isSmashed[16] = true
	isSmashed[17] = true
	isSmashed[18] = true
	isSmashed[19] = true
	isSmashed[20] = true
	TriggerClientEvent("jewel:robbed", -1, isSmashed)
end

function resetJewels()
	isSmashed[1] = false
	isSmashed[2] = false
	isSmashed[3] = false
	isSmashed[4] = false
	isSmashed[5] = false
	isSmashed[6] = false
	isSmashed[7] = false
	isSmashed[8] = false
	isSmashed[9] = false
	isSmashed[10] = false
	isSmashed[11] = false
	isSmashed[12] = false
	isSmashed[13] = false
	isSmashed[14] = false
	isSmashed[15] = false
	isSmashed[16] = false
	isSmashed[17] = false
	isSmashed[18] = false
	isSmashed[19] = false
	isSmashed[20] = false
	TriggerClientEvent("jewel:robbed", -1, isSmashed)
	TriggerClientEvent('jewel:resetCards', -1)
	SetTimeout(resetTimer, resetJewels)
end

SetTimeout(resetTimer, resetJewels)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do

		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
		  CopsConnected = CopsConnected + 1
		end
	end
	return CopsConnected
end

RegisterServerEvent('RS7x:CountCops')
AddEventHandler('RS7x:CountCops', function()
	local CopsConnected = CountCops()
    TriggerClientEvent('jewel:cops', source, CopsConnected)
end)

RegisterServerEvent("RS7x:receiveItem")
AddEventHandler("RS7x:receiveItem", function(item, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
	if item ~= nil and amount ~= nil then
		TriggerClientEvent('player:receiveItem',user.source, item, amount) 
	end
end)

RegisterServerEvent('RS7x:TradeBars')
AddEventHandler('RS7x:TradeBars', function(itemCount)
	local xPlayer = ESX.GetPlayerFromId(source)

    if itemCount and itemCount > 0 then
		TriggerClientEvent('inventory:removeItem', xPlayer.source, "goldbar", itemCount)
        local payment  = (itemCount * math.random(1500, 2000))
		TriggerClientEvent('mythic_notify:client:DoLongHudText', xPlayer.source, { type = 'inform', text = 'Traded ' .. itemCount .. ' GoldBars For $' .. payment })
		xPlayer.addMoney(payment)
    else
        TriggerClientEvent('mythic_notify:client:DoLongHudText', xPlayer.source, { type = 'error', text = 'You do not have enough Goldbars!' })
    end
end)