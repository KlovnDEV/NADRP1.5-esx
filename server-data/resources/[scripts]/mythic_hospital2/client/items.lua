local usingHeal = false

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end


--[[RegisterNetEvent("mythic_hospital2:items:gauze")
AddEventHandler("mythic_hospital2:items:gauze", function(item)
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
            TriggerEvent('mythic_hospital2:client:FieldTreatBleed')
        end
    end)
end)]]

RegisterNetEvent("mythic_hospital2:items:bandage")
AddEventHandler("mythic_hospital2:items:bandage", function(item)
    if not usingHeal then 
        usingHeal = true
            local maxHealth = GetEntityMaxHealth(PlayerPedId())
			local health = GetEntityHealth(PlayerPedId())
			local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 16))
            SetEntityHealth(PlayerPedId(), newHealth)
            TriggerEvent('mythic_hospital2:client:FieldTreatBleed')
            usingHeal = false
    else
        exports['mythic_notify']:SendAlert('error', 'Already healing')
    end
end)

RegisterNetEvent("mythic_hospital2:items:ifak")
AddEventHandler("mythic_hospital2:items:ifak", function(item)
    if not usingHeal then
        usingHeal = true
        loadAnimDict( "amb@world_human_clipboard@male@idle_a" )
        TaskPlayAnim( PlayerPedId(), "amb@world_human_clipboard@male@idle_a", "idle_c", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
        local finished = exports["ffrp-taskbar"]:taskBar(10000, "Applying IFAK 🤕")
        if (finished == 100) then
            TriggerEvent('mythic_hospital2:client:ifak')
            TriggerEvent('client:newStress',false, 25)
            TriggerEvent('mythic_hospital2:client:ReduceBleed')
            ClearPedTasks(PlayerPedId())
            usingHeal = false         
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Already using a heals')
    end
end)

RegisterNetEvent("mythic_hospital2:items:firstaid")
AddEventHandler("mythic_hospital2:items:firstaid", function(item)
    if not usingHeal then
        usingHeal = true
        loadAnimDict( "amb@world_human_clipboard@male@idle_a" ) 
        TaskPlayAnim( PlayerPedId(), "amb@world_human_clipboard@male@idle_a", "idle_c", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
        local finished = exports["ffrp-taskbar"]:taskBar(15000, "Healing 🤕")
        if (finished == 100) then
            local maxHealth = GetEntityMaxHealth(PlayerPedId())
			local health = GetEntityHealth(PlayerPedId())
			local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
            SetEntityHealth(PlayerPedId(), newHealth)
            ClearPedTasks(PlayerPedId())
            usingHeal = false            
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Already using a heals')
    end
end)

RegisterNetEvent("mythic_hospital2:items:medkit")
AddEventHandler("mythic_hospital2:items:medkit", function(item)
    if not usingHeal then
        usingHeal = true
        loadAnimDict( "amb@world_human_clipboard@male@idle_a" ) 
        TaskPlayAnim( PlayerPedId(), "amb@world_human_clipboard@male@idle_a", "idle_c", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
        local finished = exports["ffrp-taskbar"]:taskBar(10000, "Healing 🤕")
        if (finished == 100) then
			SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
            TriggerEvent('mythic_hospital2:client:FieldTreatLimbs')
            TriggerEvent('mythic_hospital2:client:RemoveBleed')
            ClearPedTasks(PlayerPedId())
            usingHeal = false
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Already using a heals')
    end
end)

RegisterNetEvent("mythic_hospital2:items:oxy")
AddEventHandler("mythic_hospital2:items:oxy", function(item)
    if not usingHeal then
        usingHeal = true
        loadAnimDict( "mp_suicide" )
        TaskPlayAnim( PlayerPedId(), "mp_suicide", "pill", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
        local finished = exports["ffrp-taskbar"]:taskBar(2700, "Taking oxy 💊")
        if (finished == 100) then
            TriggerEvent('mythic_hospital2:client:UsePainKiller', 1)
            TriggerEvent('client:newStress',false, 25)
            TriggerEvent('tac_status:remove','thirst', 50000)
            TriggerEvent('status:setState', 2, 450)
            TriggerEvent('mythic_hospital2:client:ReduceBleed')
            ClearPedTasks(PlayerPedId())
            usingHeal = false
            --TriggerServerEvent('removeHealItem', 'oxy')         
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Already using a heals')
    end
end)

--[[RegisterNetEvent("mythic_hospital2:items:hydrocodone")
AddEventHandler("mythic_hospital2:items:hydrocodone", function(item)
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
            TriggerEvent('mythic_hospital2:client:UsePainKiller', 2)
        end
    end)
end)

RegisterNetEvent("mythic_hospital2:items:morphine")
AddEventHandler("mythic_hospital2:items:morphine", function(item)
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
            TriggerEvent('mythic_hospital2:client:UsePainKiller', 6)
        end
    end)
end)]]