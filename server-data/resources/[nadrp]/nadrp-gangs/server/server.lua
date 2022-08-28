ESX = nil 

TriggerEvent('tac:getSharedObject',function(obj) ESX = obj; end)

RegisterServerEvent('nadrp-selldrugs:completeSale')
AddEventHandler('nadrp-selldrugs:completeSale', function(NPC, salePrice)
	local user = ESX.GetPlayerFromId(source)
	if salePrice ~= nil then
		if NPC ~= nil and NPC ~= -1 then
			TriggerEvent("player:receiveItem","cashroll",salePrice)
		end
	end
end)

-- Coke

local cocaine_amount = 0
local cocaine_status = 0
local cocaine_percent = 0
local cocaine_tick = ((60 * 1000) * 10)
RegisterServerEvent('nadrp-drugs:coke:status')
AddEventHandler('nadrp-drugs:coke:status', function()
	local user = ESX.GetPlayerFromId(source)
	if cocaine_status ~= nil then
		TriggerClientEvent('nadrp-gangs:currentCokeStatus', user.source, cocaine_percent, cocaine_status, cocaine_amount)
		if cocaine_status == 0 then
			cocaine_status = 1
			TriggerClientEvent('nadrp-gangs:startTask', user.source, math.random(1,5), 0)
		end
	end
end)

RegisterServerEvent('nadrp-gangs:coke:updatepercent')
AddEventHandler('nadrp-gangs:coke:updatepercent', function()
	local newAmount = math.random(5,10)
	if (cocaine_percent + newAmount) >= 100 then
		cocaine_percent = 0
		cocaine_amount = cocaine_amount + 1
	else
		cocaine_percent =  cocaine_percent + newAmount
	end

	MySQL.Async.execute('UPDATE cocaine SET percent=@percent, amount=@amount WHERE type=@type', {
		['@percent'] = cocaine_percent,
		['@amount'] = cocaine_amount,
		['@type'] = 'cocaine'
	})

	Wait((60 * 1000) * math.random(35,45))
	cocaine_status = 0
end)

RegisterServerEvent('nadrp-gangs:coke:removeBrick')
AddEventHandler('nadrp-gangs:coke:removeBrick', function()
	local src = source
	if cocaine_amount > 0 then
		cocaine_amount = cocaine_amount - 1
		TriggerClientEvent('player:receiveItem', src, 'coke50g', 1)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', src, {type = 'error', text = 'You dont have enough stock!'})
	end
end)

function StartPercentTick()
	if cocaine_percent >= 100 then 
		cocaine_percent = 0
		cocaine_amount = cocaine_amount + 4
	else
		cocaine_percent = cocaine_percent + 4
	end
	SetTimeout(cocaine_tick, StartPercentTick)
end

MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT status,percent,amount FROM cocaine WHERE type=@type', {
		['@type'] = 'cocaine'
	},function(result)
		if result ~= nil then
			cocaine_amount = result[1].amount
			cocaine_percent = result[1].percent
			cocaine_status = result[1].status
			SetTimeout(cocaine_tick, StartPercentTick)
		end
	end)
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		MySQL.Async.execute('UPDATE cocaine SET percent=@percent, amount=@amount WHERE type=@type', {
			['@percent'] = cocaine_percent,
			['@amount'] = cocaine_amount,
			['@type'] = 'cocaine'
		})
	end
end)