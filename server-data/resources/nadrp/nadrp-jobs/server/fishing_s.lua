

ESX = nil
TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('fishing:catch')
AddEventHandler('fishing:catch', function(bait)
	
	_source = source
	local weight = 2
	local rnd = math.random(1,100)
	xPlayer = ESX.GetPlayerFromId(_source)
	if bait == nil then bait = 'none' end
	if bait == "turtle" then
		if rnd >= 78 then
			if rnd >= 94 then
				TriggerClientEvent('fishing:setbait', _source, "none")
				TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'error', text = 'It was huge and it broke your fishing rod!', length = 5000})
				TriggerClientEvent('fishing:break', _source)
				TriggerClientEvent('inventory:removeItem',xPlayer.source,"fishingrod", 1)
			else
				TriggerClientEvent('fishing:setbait', _source, "none")
				TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'inform', text = 'You caught a turtle, These are endangered species and are illegal to posses', length = 5000})
				TriggerClientEvent("player:receiveItem",xPlayer.source,"turtle",1)
			end
		else
			if rnd >= 75 then
				weight = math.random(4,9)
				TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'success', text = 'You caught a fish:' .. weight .. 'kg', length = 5000})
				TriggerClientEvent("player:receiveItem",xPlayer.source,"fish",weight)
			else
				weight = math.random(2,6)
				TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'success', text = 'You caught a fish:' .. weight .. 'kg', length = 5000})
				TriggerClientEvent("player:receiveItem",xPlayer.source,"fish",weight)
			end
		end
	else
		if bait == "fish" then
			if rnd >= 75 then
				TriggerClientEvent('fishing:setbait', _source, "none")
				weight = math.random(4,11)
				TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'success', text = 'You caught a fish:' .. weight .. 'kg', length = 5000})
				TriggerClientEvent("player:receiveItem",xPlayer.source,"fish",weight)
			else
				weight = math.random(1,6)
				TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'success', text = 'You caught a fish:' .. weight .. 'kg', length = 5000})
				TriggerClientEvent("player:receiveItem",xPlayer.source,"fish",weight)
			end
		end
		if bait == "none" then
			if rnd >= 70 then
				--TriggerClientEvent('fishing:message', _source, "~y~You are currently fishing without any equipped bait")
				TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'error', text = 'You are currently fishing without any equipped bait', length = 5000})
				weight = math.random(2,4)
				TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'success', text = 'You caught a fish:' .. weight .. 'kg', length = 5000})
				TriggerClientEvent("player:receiveItem",xPlayer.source,"fish",weight)
			else
				weight = math.random(1,2)
				TriggerClientEvent("player:receiveItem",xPlayer.source,"plastic",weight)
				TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'inform', text = 'Well done you caught plastic :)', length = 5000})
			end
		end
		if bait == "shark" then
			if rnd >= 82 then
				if rnd >= 91 then
					TriggerClientEvent('fishing:setbait', _source, "none")
					TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'error', text = 'It was huge and it broke your fishing rod!', length = 5000})
					TriggerClientEvent('fishing:break', _source)
					TriggerClientEvent('inventory:removeItem',xPlayer.source,"fishingrod", 1) 
				else
					TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'error', text = 'You caught a shark! These are endangered species and are illegal to posses', length = 5000})
					TriggerClientEvent('fishing:spawnPed', _source)
					TriggerClientEvent("player:receiveItem",xPlayer.source,"shark",1)
				end
			else
				weight = math.random(4,8)
				TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'success', text = 'You caught a fish:' .. weight .. 'kg', length = 5000})
				--TriggerClientEvent('fishing:message', _source, "~b~You caught a fish: ~y~~h~" .. weight .. "kg")
				--xPlayer.addInventoryItem('fish', weight)
				TriggerClientEvent("player:receiveItem",xPlayer.source,"fish",weight)
			end
		end
	end
end)


RegisterServerEvent('Ford:TradeFish')
AddEventHandler('Ford:TradeFish', function(itemCount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local payment  = (itemCount * math.random(30,50))
    if itemCount and itemCount > 0 then
		TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'inform', text = 'Traded ' .. itemCount .. ' Fish For $' .. payment })
		TriggerClientEvent('inventory:removeItem',_source ,"packagedfish",  itemCount) 
        xPlayer.addMoney(payment)
    else
        Citizen.Wait(5000)
        TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'error', text = 'You dont have enough Fish'})
    end
end)

RegisterServerEvent('Ford:TradeTurtle')
AddEventHandler('Ford:TradeTurtle', function(itemCount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local payment  = (itemCount * math.random(400,450))
    if itemCount and itemCount > 0 then
        TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'inform', text = 'Traded ' .. itemCount .. ' Turtle For $' .. payment })
        xPlayer.addMoney(payment)
    else
        Citizen.Wait(5000)
        TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'error', text = 'You dont have enough Fish'})
    end
end)

RegisterServerEvent('Ford:TradeShark')
AddEventHandler('Ford:TradeShark', function(itemCount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local payment  = (itemCount * math.random(700,950))
    if itemCount and itemCount > 0 then
        TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'inform', text = 'Traded ' .. itemCount .. ' Shark For $' .. payment })
        xPlayer.addMoney(payment)
    else
        Citizen.Wait(5000)
        TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'error', text = 'You dont have enough Fish'})
    end
end)



--[[RegisterServerEvent('fishing:startSelling')
AddEventHandler('fishing:startSelling', function(item)

	local _source = source
	
	local xPlayer  = ESX.GetPlayerFromId(_source)
			if item == "fish" then
					local FishQuantity = xPlayer.getInventoryItem('fish').count
						if FishQuantity <= 4 then
					    TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'success', text = 'You dont have enough fish', length = 5000})
						--TriggerClientEvent('esx:showNotification', source, '~r~You dont have enough~s~ fish')			
					else   
						xPlayer.removeInventoryItem('fish', 5)
						local payment = Config.FishPrice.a
						payment = math.random(Config.FishPrice.a, Config.FishPrice.b) 
						xPlayer.addMoney(payment)
						
						
			end
				

				

				
			end
			if item == "turtle" then
				local FishQuantity = xPlayer.getInventoryItem('turtle').count

				if FishQuantity <= 0 then
					TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'success', text = 'You dont have enough turtles', length = 5000})
					--TriggerClientEvent('esx:showNotification', source, '~r~You dont have enough~s~ turtles')			
				else   
					xPlayer.removeInventoryItem('turtle', 1)
					local payment = Config.TurtlePrice.a
					payment = math.random(Config.TurtlePrice.a, Config.TurtlePrice.b) 
					xPlayer.addAccountMoney('black_money', payment)
					
					
				end
			end
			if item == "shark" then
				local FishQuantity = xPlayer.getInventoryItem('shark').count

				if FishQuantity <= 0 then
					TriggerClientEvent('mythic_notify:client:DoLongHudText', source, { type = 'success', text = 'You dont have enough sharks', length = 5000})
					--TriggerClientEvent('esx:showNotification', source, '~r~You dont have enough~s~ sharks')			
				else   
					xPlayer.removeInventoryItem('shark', 1)
					local payment = Config.SharkPrice.a
					payment = math.random(Config.SharkPrice.a, Config.SharkPrice.b)
					xPlayer.addAccountMoney('black_money', payment)
					
					
				end
			end
			
	
end)

]]