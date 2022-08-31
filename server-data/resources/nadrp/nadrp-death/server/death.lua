RegisterServerEvent('nadrp-death:setDead')
AddEventHandler('nadrp-death:setDead', function(isDead) -- for anti-combat log
    local player = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
        ['@isDead'] = isDead,
        ['@identifier'] = player.identifier
    })
end)

RegisterServerEvent('nadrp-death:RemoveItems')
AddEventHandler('nadrp-death:RemoveItems', function(removeCash)
    local xPlayer = ESX.GetPlayerFromId(source)

    if removeCash then
		if xPlayer.getMoney() > 0 then
			xPlayer.removeMoney(xPlayer.getMoney())
		end

		if xPlayer.getAccount('black_money').money > 0 then
			xPlayer.setAccountMoney('black_money', 0)
		end
    end
    --TriggerEvent('inv:delete', xPlayer.identifier)
end)

RegisterServerEvent('nadrp-death:healplayer')
AddEventHandler('nadrp-death:healplayer', function(player, type)
    if player ~= nil then
        if type ~= nil then
            TriggerClientEvent('nadrp-death:healTarget', player, type)
        end
    end
end)

TriggerEvent('es:addGroupCommand', 'revive', 'mod', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			TriggerClientEvent('nadrp-death:revive', tonumber(args[1]))
		end
	else
		TriggerClientEvent('nadrp-death:revive', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, { help = 'revive a player', params = {{ name = 'id' }} })

TriggerEvent('es:addGroupCommand', 'heal', 'mod', function(source, args, user)
    -- heal another player - don't heal source
    if args[1] then
        local playerId = tonumber(args[1])

        -- is the argument a number?
        if playerId then
            -- is the number a valid player?
            if GetPlayerName(playerId) then
                TriggerClientEvent('tac_basicneeds:healPlayer', playerId)
                TriggerClientEvent('chat:addMessage', source, { args = { '^5HEAL', 'You have been healed.' } })
            else
                TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
            end
        else
            TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid player id.' } })
        end
    else
        TriggerClientEvent('tac_basicneeds:healPlayer', source)
    end
end, function(source, args, user)
    TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', params = {{name = 'playerId', help = '(optional) player id'}}})

RegisterNetEvent('die:cunt')
AddEventHandler('die:cunt', function(ped)
    TriggerClientEvent('nadrp-death:revive', ped)
end)