if Config.useESX then
	TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
elseif Config.useQB then
	QBCore = nil
	TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
else
	-- if any custom framework
end

RegisterServerEvent('grz_butcher:server:giveReward')
AddEventHandler('grz_butcher:server:giveReward', function()
    if Config.useESX then
        --
    elseif Config.useQB then
        --
    else
        -- if any custom framework
    end
end)