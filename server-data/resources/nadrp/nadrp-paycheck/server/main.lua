ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('nadrp-paycheck:hasPaycheck')
AddEventHandler('nadrp-paycheck:hasPaycheck', function()
    local user = ESX.GetPlayerFromId(source)
    local identifier = user.identifier
    MySQL.Async.fetchAll('SELECT payslip FROM users WHERE identifier=@identifier', {
        ["@identifier"] = identifier
    }, function(result)
        if result[1] ~= nil then
            local payslip = result[1].payslip
            local payslipTax = (payslip / 10)
            local totalSlip = math.ceil((payslip - payslipTax))

            if payslip > 0 then
                user.addAccountMoney('bank', totalSlip)
                TriggerClientEvent('mythic_notify:client:DoLongHudText', user.source, {type = 'inform', text = 'A paycheck of $'..totalSlip..' has been added to your bank account', length = 7500})
                MySQL.Async.execute('UPDATE users SET payslip=@payslip WHERE identifier=@identifier', {['@identifier'] = identifier, ['@payslip'] = 0})
            else
                TriggerClientEvent('mythic_notify:client:DoLongHudText', user.source, {type = 'inform', text = "You don't currently have a payslip here"})
            end
        end
    end)
end)

RegisterServerEvent('nadrp-paycheck:addPaycheck')
AddEventHandler('nadrp-paycheck:addPaycheck', function(amount)
    local user = ESX.GetPlayerFromId(source)
    local identifier = user.identifier
    MySQL.Async.fetchAll('SELECT payslip FROM users WHERE identifier=@identifier', {
        ["@identifier"] = identifier
    }, function(result)
        if result[1] ~= nil then
            local salary = user.job.grade_salary
            if salary == amount then
                local payslip = result[1].payslip
                local payslipTax = (result[1].payslip / 10)
                local totalSlip = math.ceil(((payslip + amount) - payslipTax))

                MySQL.Async.execute('UPDATE users SET payslip=@payslip WHERE identifier=@identifier', {['@identifier'] = identifier, ['@payslip'] = payslip + amount})
                TriggerClientEvent('mythic_notify:client:DoLongHudText', user.source, {type = 'inform', text = 'A paycheck of $'..amount..' making a total of $'..totalSlip..' with $'..payslipTax..' tax witheld on your last payment, go to Life Invader to pick up your payment!', length = 7500})
            else
                local data = {
                    name = GetPlayerName(user.source),
                    reason = 'Attempted Paycheck Cheat',
                    identifiers = GetPlayerIdentifiers(user.source),
                    info = string.format("Player Job: **%s** | Job Salary: **%s** | Amount Detected: **%s** ", user.job.name, salary, amount)
                }
                exports['nadrp-log']:DiscordLog(data)
            end
        else
            TriggerClientEvent('mythic_notify:client:DoLongHudText', user.source, {type = 'error', text = "There was an error adding this paycheck"})
        end
    end)
end)