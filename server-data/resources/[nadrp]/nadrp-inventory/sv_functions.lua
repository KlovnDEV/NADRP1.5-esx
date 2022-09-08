ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('tac:playerLoaded', function (source)
	GetLicenses(source)
	TriggerEvent("playerSpawned")
end)

function GetLicenses(source)
    TriggerEvent('tac_license:getLicenses', source, function (licenses)
        TriggerClientEvent('suku:GetLicenses', source, licenses)
    end)
end

RegisterServerEvent('suku:buyLicense')
AddEventHandler('suku:buyLicense', function ()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= 5000 then
		xPlayer.removeMoney(5000)
        TriggerClientEvent('mythic_notify:client:DoLongHudText', source, {type = 'inform', text = 'You registered a Fire Arms license.'})
		TriggerEvent('tac_license:addLicense', _source, 'weapon', function ()
			GetLicenses(_source)
		end)
    else
        TriggerClientEvent('mythic_notify:client:DoLongHudText', _source, {type = 'error' ,text = 'You do not have enough money!'})
	end
end)


RegisterServerEvent('cash:remove')
AddEventHandler('cash:remove', function(source, cash)
    local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer.getMoney() >= cash then
	    xPlayer.removeMoney(cash)
	    TriggerClientEvent("nadrp-banking:removeBalance", source, cash)
	end
end)

RegisterServerEvent('people-search')
AddEventHandler('people-search', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(target)
    local identifier = xPlayer.identifier
	TriggerClientEvent("server-inventory-open", source, "1", identifier)
end)

RegisterServerEvent('people-frisk')
AddEventHandler('people-frisk', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(target)
    local cash = xPlayer.getMoney()
    local identifier = xPlayer.identifier
    TriggerEvent("server-frisk-player-inventory", source, cash, 0, identifier)
    TriggerClientEvent('mythic_notify:client:DoLongHudText', target, {type = 'inform', text='You are currently being frisked'})
end)

RegisterServerEvent("server-item-quality-update")
AddEventHandler("server-item-quality-update", function(player, data)
	local quality = data.quality
	local slot = data.slot
	local itemid = data.item_id
    exports.ghmattimysql:execute("UPDATE user_inventory2 SET `quality` = @quality WHERE name = @name AND slot = @slot AND item_id = @item_id", {
        ['quality'] = quality,
        ['name'] = player,
        ['slot'] = slot,
        ['item_id'] = itemid
    })
end)

RegisterServerEvent('police:SeizeCash')
AddEventHandler('police:SeizeCash', function(target)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = xPlayer.identifier
    local zPlayer = ESX.GetPlayerFromId(target)

    if not xPlayer.job.name == 'police' then
        print('steam:'..identifier..' User attempted sieze cash')
        return
    end

    local cash = zPlayer.getAccount('cash').money
    zPlayer.removeMoney(cash)
    TriggerClientEvent('mythic_notify:client:DoLongHudText', target, {type = 'inform', text = 'Your cash and Marked Bills was seized'})
    TriggerClientEvent('mythic_notify:client:DoLongHudText', src, {type = 'inform', text = 'Seized persons cash'})
end)

RegisterServerEvent('steal:takeCash')
AddEventHandler('steal:takeCash', function(target)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = xPlayer.identifier
    local zPlayer = ESX.GetPlayerFromId(target)

    local cash = zPlayer.getMoney()
    zPlayer.removeMoney(cash)
    xPlayer.addMoney(cash)
end)