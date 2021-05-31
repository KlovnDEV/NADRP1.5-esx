local usingHeal = false

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end


--[[RegisterNetEvent("mythic_hospital:items:gauze")
AddEventHandler("mythic_hospital:items:gauze", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 1500,
        label = "Packing Wounds",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_paper_bag_small",
        }
    }, function(status)
        if not status then
            TriggerEvent('mythic_hospital:client:FieldTreatBleed')
        end
    end)
end)]]

RegisterNetEvent("mythic_hospital:items:bandage")
AddEventHandler("mythic_hospital:items:bandage", function(item)
    if not usingHeal then 
        usingHeal = true
        --loadAnimDict( "amb@world_human_clipboard@male@idle_a" ) 
        --TaskPlayAnim( PlayerPedId(), "amb@world_human_clipboard@male@idle_a", "idle_c", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
        --exports['t0sic_loadingbar']:StartDelayedFunction("Healing", 10000, function()
            local maxHealth = GetEntityMaxHealth(PlayerPedId())
			local health = GetEntityHealth(PlayerPedId())
			local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 16))
            SetEntityHealth(PlayerPedId(), newHealth)
            TriggerEvent('mythic_hospital:client:FieldTreatBleed')
            --ClearPedTasks(PlayerPedId())
            --TriggerServerEvent('removeHealItem', 'bandage')
            usingHeal = false
        --end)
    else
        exports['mythic_notify']:SendAlert('error', 'Already healing')
    end
end)

RegisterNetEvent("mythic_hospital:items:ifak")
AddEventHandler("mythic_hospital:items:ifak", function(item)
    if not usingHeal then
        usingHeal = true
        loadAnimDict( "amb@world_human_clipboard@male@idle_a" )
        TaskPlayAnim( PlayerPedId(), "amb@world_human_clipboard@male@idle_a", "idle_c", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
        exports['t0sic_loadingbar']:StartDelayedFunction("Applying IFAK", 10000, function()
            TriggerEvent('mythic_hospital:client:ifak')
            TriggerEvent('client:newStress',false, 25)
            TriggerEvent('mythic_hospital:client:ReduceBleed')
            ClearPedTasks(PlayerPedId())
            usingHeal = false
        end)
    else
        exports['mythic_notify']:SendAlert('error', 'Already using a heals')
    end
end)

RegisterNetEvent("mythic_hospital:items:firstaid")
AddEventHandler("mythic_hospital:items:firstaid", function(item)
    if not usingHeal then
        usingHeal = true
        loadAnimDict( "amb@world_human_clipboard@male@idle_a" ) 
        TaskPlayAnim( PlayerPedId(), "amb@world_human_clipboard@male@idle_a", "idle_c", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
        exports['t0sic_loadingbar']:StartDelayedFunction("Healing", 10000, function()
            local maxHealth = GetEntityMaxHealth(PlayerPedId())
			local health = GetEntityHealth(PlayerPedId())
			local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
            SetEntityHealth(PlayerPedId(), newHealth)
            ClearPedTasks(PlayerPedId())
            --TriggerServerEvent('removeHealItem', 'firstaid')
            usingHeal = false
        end)
    else
        exports['mythic_notify']:SendAlert('error', 'Already using a heals')
    end
end)

RegisterNetEvent("mythic_hospital:items:medkit")
AddEventHandler("mythic_hospital:items:medkit", function(item)
    if not usingHeal then
        usingHeal = true
        loadAnimDict( "amb@world_human_clipboard@male@idle_a" ) 
        TaskPlayAnim( PlayerPedId(), "amb@world_human_clipboard@male@idle_a", "idle_c", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
        exports['t0sic_loadingbar']:StartDelayedFunction("Healing", 10000, function()
			SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
            TriggerEvent('mythic_hospital:client:FieldTreatLimbs')
            TriggerEvent('mythic_hospital:client:RemoveBleed')
            ClearPedTasks(PlayerPedId())
            --TriggerServerEvent('removeHealItem', 'medkit')
            usingHeal = false
        end)
    else
        exports['mythic_notify']:SendAlert('error', 'Already using a heals')
    end
end)

RegisterNetEvent("mythic_hospital:items:oxy")
AddEventHandler("mythic_hospital:items:oxy", function(item)
    if not usingHeal then
        usingHeal = true
        loadAnimDict( "mp_suicide" )
        TaskPlayAnim( PlayerPedId(), "mp_suicide", "pill", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
        exports['t0sic_loadingbar']:StartDelayedFunction("Taking oxy", 2700, function()
            TriggerEvent('mythic_hospital:client:UsePainKiller', 1)
            TriggerEvent('client:newStress',false, 25)
            TriggerEvent('tac_status:remove','thirst', 50000)
            TriggerEvent('status:setState', 2, 450)
            TriggerEvent('mythic_hospital:client:ReduceBleed')
            ClearPedTasks(PlayerPedId())
            usingHeal = false
            --TriggerServerEvent('removeHealItem', 'oxy')
        end)
    else
        exports['mythic_notify']:SendAlert('error', 'Already using a heals')
    end
end)

--[[RegisterNetEvent("mythic_hospital:items:hydrocodone")
AddEventHandler("mythic_hospital:items:hydrocodone", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 1000,
        label = "Taking Hydrocodone",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_suicide",
            anim = "pill",
            flags = 49,
        },
        prop = {
            model = "prop_cs_pills",
            bone = 58866,
            coords = { x = 0.1, y = 0.0, z = 0.001 },
            rotation = { x = -60.0, y = 0.0, z = 0.0 },
        },
    }, function(status)
        if not status then
            TriggerEvent('mythic_hospital:client:UsePainKiller', 2)
        end
    end)
end)

RegisterNetEvent("mythic_hospital:items:morphine")
AddEventHandler("mythic_hospital:items:morphine", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 2000,
        label = "Taking Morphine",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_suicide",
            anim = "pill",
            flags = 49,
        },
        prop = {
            model = "prop_cs_pills",
            bone = 58866,
            coords = { x = 0.1, y = 0.0, z = 0.001 },
            rotation = { x = -60.0, y = 0.0, z = 0.0 },
        },
    }, function(status)
        if not status then
            TriggerEvent('mythic_hospital:client:UsePainKiller', 6)
        end
    end)
end)]]