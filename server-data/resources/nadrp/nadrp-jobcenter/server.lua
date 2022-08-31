
ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('jobsystem:Job')
AddEventHandler('jobsystem:Job', function(job)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		xPlayer.setJob(job, 0)
    end
end)