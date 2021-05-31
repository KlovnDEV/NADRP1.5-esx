

Currentstates = {
	[1] = { ["text"] = "Red Hands", ["status"] = false, ["timer"] = 0 },
	[2] = { ["text"] = "Dialated Eyes", ["status"] = false, ["timer"] = 0 },
	[3] = { ["text"] = "Red Eyes", ["status"] = false, ["timer"] = 0 },
	[4] = { ["text"] = "Smells Like Marijuana", ["status"] = false, ["timer"] = 0 },
	[5] = { ["text"] = "Fresh Bandaging", ["status"] = false, ["timer"] = 0 },
	[6] = { ["text"] = "Agitated", ["status"] = false, ["timer"] = 0 },
	[7] = { ["text"] = "Uncoordinated", ["status"] = false, ["timer"] = 0 },
	[8] = { ["text"] = "Breath smells like Alcohol", ["status"] = false, ["timer"] = 0 },
	[9] = { ["text"] = "Smells like Gasoline", ["status"] = false, ["timer"] = 0 },
	[10] = { ["text"] = "Red Gunpowder Residue", ["status"] = false, ["timer"] = 0 },
	[11] = { ["text"] = "Smells of Chemicals", ["status"] = false, ["timer"] = 0 },
	[12] = { ["text"] = "Smells of Oil / Metalwork", ["status"] = false, ["timer"] = 0 },
	[13] = { ["text"] = "Ink Stained Hands", ["status"] = false, ["timer"] = 0 },
	[14] = { ["text"] = "Smells like smoke.", ["status"] = false, ["timer"] = 0 },
	[15] = { ["text"] = "Has camping equipment.", ["status"] = false, ["timer"] = 0 },
	[16] = { ["text"] = "Smells like burnt Aluminum and iron.", ["status"] = false, ["timer"] = 0 },
	[17] = { ["text"] = "Has metal specs on clothing.", ["status"] = false, ["timer"] = 0 },
	[18] = { ["text"] = "Smells Like Cigarette Smoke.", ["status"] = false, ["timer"] = 0 },
	[19] = { ["text"] = "Labored Breathing.", ["status"] = false, ["timer"] = 0 },
	[20] = { ["text"] = "Body Sweat.", ["status"] = false, ["timer"] = 0 },
	[21] = { ["text"] = "Clothing Sweat.", ["status"] = false, ["timer"] = 0 },
    [22] = { ["text"] = "Wire Cuts.", ["status"] = false, ["timer"] = 0 },
	[23] = { ["text"] = "Saturated Clothing.", ["status"] = false, ["timer"] = 0 },
    [24] = { ["text"] = "Looks Dazed.", ["status"] = false, ["timer"] = 0 },
    [25] = { ["text"] = "Looks Well Fed.", ["status"] = false, ["timer"] = 0 },
    [26] = { ["text"] = "Has scratches on hands.", ["status"] = false, ["timer"] = 0 },
}


RegisterNetEvent("status:setState")
AddEventHandler("status:setState",function(stateId,stateLength)
	if Currentstates[stateId]["timer"] < 10 and stateLength ~= 0 then
        TriggerEvent('chat:addMessage', {
            template = '<div class="chat-message emergency">STATUS :: {0} </div>',
            args = {Currentstates[stateId]["text"]}
        });
	end
	Currentstates[stateId]["timer"] = stateLength
end)

Citizen.CreateThread(function()

    while true do
        Citizen.Wait(10000)
        for i = 1, #Currentstates do
        	if Currentstates[i]["timer"] > 0 then
        		Currentstates[i]["timer"] = Currentstates[i]["timer"] - 10
	        	if Currentstates[i]["timer"] < 0 then
	        		Currentstates[i]["timer"] = 0
	        	end
        	end
        end

    end
end)

function updateStates()
    StoringEnabled = true
	if not StoringEnabled then
		return
	end
	CurrentDamageList = {}
	for i = 1, #InjuryList do
		if HasPedBeenDamagedByWeapon(GetPlayerPed(-1), GetHashKey(InjuryList[i][1]),0) then
			table.insert( CurrentDamageList, InjuryList[i][3] )
		end
	end

    for i = 1, #Currentstates do
    	if Currentstates[i]["timer"] > 0 then
    		local msg = Currentstates[i]["text"] .. " "
	    	if Currentstates[i]["timer"] > 360 then
	    		msg = msg .. "(Very noticable)"
	    	elseif Currentstates[i]["timer"] > 180 then
	    		msg = msg .. "(Noticable)"
	    	elseif Currentstates[i]["timer"] > 60 then
	    		msg = msg .. "(Very light)"
	    	end
            table.insert( CurrentDamageList, msg )
	    end
    end

    if GetPedArmour(GetPlayerPed(-1)) > 1 and armor then
	    table.insert( CurrentDamageList, "Is wearing body armor." )
	elseif armor then
		armor = false
    end
end

local lastTarget
local target
local targetLastHealth
local bodySweat = 0
local sweatTriggered = false
local NoState = false

Citizen.CreateThread(function()

    while true do
        Wait(300)

        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        	local vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
        	local bicycle = IsThisModelABicycle( GetEntityModel(vehicle) )
        	local speed = GetEntitySpeed(vehicle)
        	if bicycle and speed > 0 then
        		sweatTriggered = true
        		if bodySweat < 180000 then
        			bodySweat = bodySweat + (150 + math.ceil(speed * 40))
        		else
        			bodySweat = bodySweat + (150 + math.ceil(speed * 11))
        		end

        		if bodySweat > 300000 then
	        		bodySweat = 300000
	        	end
        	end
        end

        if IsPedInMeleeCombat(GetPlayerPed(-1)) then
        	bodySweat = bodySweat + 3000
        	sweatTriggered = true
            target = GetMeleeTargetForPed(GetPlayerPed(-1))

        	if target == lastTarget or lastTarget == nil then
                if IsPedAPlayer(target) then
                    TriggerEvent("status:setState",1, 400)
                    lastTarget = target
                else
                    if not IsPedAPlayer(target) and target ~= 0 then
                        TriggerEvent("status:setState",1, 400)
                        lastTarget = target
                    end
                end
        	else
                if IsPedAPlayer(target) then
	        		targetLastHealth = GetEntityHealth(target)
	        		lastTarget = target
	        	end
        	end
        end

        if IsPedSwimming(GetPlayerPed(-1)) then
        	local speed = GetEntitySpeed(GetPlayerPed(-1))
        	if speed > 0 then
        		sweatTriggered = true
        		TriggerEvent("status:setState",23,600)
        		if bodySweat < 180000 then
        			bodySweat = bodySweat + (150 + math.ceil(speed * 40))
        		else
        			bodySweat = bodySweat + (150 + math.ceil(speed * 11))
        		end

        		if bodySweat > 210000 then
        			TriggerEvent("status:setState",19,600)
	        		bodySweat = 210000
	        	end
        	end
        end

        if IsPedSprinting(GetPlayerPed(-1)) or IsPedRunning(GetPlayerPed(-1)) then
        	bodySweat = bodySweat + 3000
        	if bodySweat > 800000 then
        		bodySweat = 800000
            end

        elseif bodySweat > 0.0 then
        	if not sweatTriggered then
        		bodySweat = 0.0
        	end
        	if bodySweat < 100000 then
                bodySweat = bodySweat - 1500
        	end
        	bodySweat = bodySweat - 100
        	if bodySweat == 0.0 then
        		sweatTriggered = false
            end
        end

        if bodySweat > 200000 and not IsPedSwimming(GetPlayerPed(-1)) then
			TriggerEvent("status:setState",19,300)
        end

        if bodySweat > 300000 and not IsPedSwimming(GetPlayerPed(-1)) and Currentstates[22]["timer"] < 50 then
            TriggerEvent("status:setState",20,450)
        end
        if bodySweat > 800000 and not IsPedSwimming(GetPlayerPed(-1)) and Currentstates[22]["timer"] < 50 then
        	sweatTriggered = true
			TriggerEvent("status:setState",21,600)
        end
    end
end)

RegisterNetEvent('RS7x:CheckState')
AddEventHandler('RS7x:CheckState', function(target)
    for i=1, #Currentstates do
        updateStates()
        if Currentstates[i]["timer"] > 0 and not target then
            if Currentstates[i]["timer"] > 360 then
                TriggerEvent('chat:addMessage', {
                    template = '<div class="chat-message nonemergency">STATUS :: {0} (Very noticable)</div>',
                    args = {Currentstates[i]["text"]}
                });
            elseif Currentstates[i]["timer"] > 180 then
                TriggerEvent('chat:addMessage', {
                    template = '<div class="chat-message nonemergency">STATUS :: {0} (Noticable)</div>',
                    args = {Currentstates[i]["text"]}
                });
            elseif Currentstates[i]["timer"] > 60 then
                TriggerEvent('chat:addMessage', {
                    template = '<div class="chat-message nonemergency">STATUS :: {0} (Very Light)</div>',
                    args = {Currentstates[i]["text"]}
                });
            end
        end
    end
end)

RegisterNetEvent('RS7x:Tcheck')
AddEventHandler('RS7x:Tcheck', function()
    for i=1, #Currentstates do
        updateStates()
        if Currentstates[i]["timer"] > 0 then
            local msg = Currentstates[i]["text"] .. " "
            if Currentstates[i]["timer"] > 360 then
                msg = msg .. "(Very noticable)"
                TriggerServerEvent('RS7x:TargetResult', msg)
            elseif Currentstates[i]["timer"] > 180 then
                msg = msg .. "(Noticable)"
                TriggerServerEvent('RS7x:TargetResult', msg)
            elseif Currentstates[i]["timer"] > 60 then
                msg = msg .. "(Very Light)"
                TriggerServerEvent('RS7x:TargetResult', msg)
			end
		end
	end
end)

InjuryList = {
	[1] = { "WEAPON_UNARMED","-1569615261", "Fist Marks" },
	[2] = { "WEAPON_ANIMAL","-100946242", "Animal Bites and Claws" },
	[3] = { "WEAPON_COUGAR","148160082", "Animal Bites and Claws" },
	[4] = { "WEAPON_KNIFE","-1716189206", "Knife Wounds" },
	[5] = { "WEAPON_NIGHTSTICK","1737195953", "Blunt Object (Metal)" },
	[6] = { "WEAPON_HAMMER","1317494643", "Small Blunt Object (Metal)" },
	[7] = { "WEAPON_BAT","-1786099057", "Large Blunt Object (Wooden)" },
	[8] = { "WEAPON_GOLFCLUB","1141786504", "Long Thing Blunt Object" },
	[9] = { "WEAPON_CROWBAR","-2067956739", "Medium Size Jagged Metal Object" },
	[10] = { "WEAPON_PISTOL","453432689", "Pistol Bullets" },
	[11] = { "WEAPON_COMBATPISTOL","1593441988", "Combat Pistol Bullets" },
	[12] = { "WEAPON_APPISTOL","584646201", "AP Pistol Bullets" },
	[13] = { "WEAPON_PISTOL50","-1716589765", "50 Cal Pistol Bullets" },
	[14] = { "WEAPON_MICROSMG","324215364", "Micro SMG Bullets" },
	[15] = { "WEAPON_SMG","736523883", "SMG Bullets" },
	[16] = { "WEAPON_ASSAULTSMG","-270015777", "Assault SMG Bullets" },
	[17] = { "WEAPON_ASSAULTRIFLE","-1074790547", "Assault Rifle Bullets" },
	[18] = { "WEAPON_CARBINERIFLE","-2084633992", "Carbine Rifle Bullets" },
	[19] = { "WEAPON_ADVANCEDRIFLE","-1357824103", "Advanced Rifle bullets" },
	[20] = { "WEAPON_MG","-1660422300", "Machine Gun Bullets" },
	[21] = { "WEAPON_COMBATMG","2144741730", "Combat MG Bullets" },
	[22] = { "WEAPON_PUMPSHOTGUN","487013001", "Pump Shotgun Bullets" },
	[23] = { "WEAPON_SAWNOFFSHOTGUN","2017895192", "Sawn Off Bullets" },
	[24] = { "WEAPON_ASSAULTSHOTGUN","-494615257", "Assault Shotgun Bullets" },
	[25] = { "WEAPON_BULLPUPSHOTGUN","-1654528753", "Bullpup Shotgun Bullets" },
	[26] = { "WEAPON_STUNGUN","911657153", "Stun Gun Damage" },
	[27] = { "WEAPON_SNIPERRIFLE","100416529", "Sniper Rifle Wounds" },
	[28] = { "WEAPON_HEAVYSNIPER","205991906", "Sniper Rifle Wounds" },
	[29] = { "WEAPON_REMOTESNIPER","856002082", "Sniper Rifle Wounds" },
	[30] = { "WEAPON_GRENADELAUNCHER","-1568386805", "Explosive Damage (Grenades)" },
	[31] = { "WEAPON_GRENADELAUNCHER_SMOKE","1305664598", "Smoke Damage" },
	[32] = { "WEAPON_RPG","-1312131151", "RPG damage" },
	[33] = { "WEAPON_STINGER","1752584910", "RPG damage" },
	[34] = { "WEAPON_MINIGUN","1119849093", "Minigun Wounds" },
	[35] = { "WEAPON_GRENADE","-1813897027", "Grenade Wounds" },
	[36] = { "WEAPON_STICKYBOMB","741814745", "Sticky Bomb Wounds" },
	[37] = { "WEAPON_SMOKEGRENADE","-37975472", "Smoke Damage" },
	[38] = { "WEAPON_BZGAS","-1600701090", "Gas Damage" },
	[39] = { "WEAPON_MOLOTOV","615608432", "Molotov/Accelerant Burns" },
	[40] = { "WEAPON_FIREEXTINGUISHER","101631238", "Fire Extenguisher Damage" },
	[41] = { "WEAPON_PETROLCAN","883325847", "Petrol Can Damage" },
	[42] = { "WEAPON_FLARE","1233104067", "Flare Damage" },
	[43] = { "WEAPON_BARBED_WIRE","1223143800", "Barbed Wire Damage" },
	[44] = { "WEAPON_DROWNING","-10959621", "Drowning" },
	[45] = { "WEAPON_DROWNING_IN_VEHICLE","1936677264", "Drowned in Vehicle" },
	[46] = { "WEAPON_BLEEDING","-1955384325", "Died to Blood Loss" },
	[47] = { "WEAPON_ELECTRIC_FENCE","-1833087301", "Electric Fence Wounds" },
	[48] = { "WEAPON_EXPLOSION","539292904", "Explosion Damage" },
	[49] = { "WEAPON_FALL","-842959696", "Fall / Impact Damage" },
	[50] = { "WEAPON_EXHAUSTION","910830060", "Died of Exhaustion" },
	[51] = { "WEAPON_HIT_BY_WATER_CANNON","-868994466", "Water Cannon Pelts" },
	[52] = { "WEAPON_RAMMED_BY_CAR","133987706", "Vehicular Accident" },
	[53] = { "WEAPON_RUN_OVER_BY_CAR","-1553120962", "Runover by Vehicle" },
	[54] = { "WEAPON_HELI_CRASH","341774354", "Heli Crash" },
	[55] = { "WEAPON_FIRE","-544306709", "Fire Victim" }
}