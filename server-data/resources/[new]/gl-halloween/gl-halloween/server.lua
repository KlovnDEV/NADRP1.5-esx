ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('gl-halloween:getSurprise',function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local surprise = Config.Items[math.random(#Config.Items)] 
	xPlayer.addInventoryItem(surprise,Config.Amount)

end)