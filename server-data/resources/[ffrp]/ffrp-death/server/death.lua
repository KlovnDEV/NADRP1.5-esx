RegisterServerEvent('ffrp-death:setDead')
AddEventHandler('ffrp-death:setDead', function(isDead) -- for anti-combat log
    local player = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
        ['@isDead'] = isDead,
        ['@identifier'] = player.identifier
    })
end)

RegisterServerEvent('ffrp-death:RemoveItems')
AddEventHandler('ffrp-death:RemoveItems', function(removeCash)
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

RegisterServerEvent('ffrp-death:healplayer')
AddEventHandler('ffrp-death:healplayer', function(player, type)
    if player ~= nil then
        if type ~= nil then
            TriggerClientEvent('ffrp-death:healTarget', player, type)
        end
    end
end)

TriggerEvent('es:addGroupCommand', 'revive', 'mod', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			TriggerClientEvent('ffrp-death:revive', tonumber(args[1]))
		end
	else
		TriggerClientEvent('ffrp-death:revive', source)
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
    TriggerClientEvent('ffrp-death:revive', ped)
end)