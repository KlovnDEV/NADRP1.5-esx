ESX = nil
local Licenses = {}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
	end
end)

local fixingvehicle = false
local justUsed = false
local retardCounter = 0
local lastCounter = 0 
local HeadBone = 0x796e;
local job = ''
local isDisabled = false

local validWaterItem = {
    ["oxygentank"] = true,
    ["water"] = true,
    ["vodka"] = true,
    ["beer"] = true,
    ["guiness"] = true,
    ["whiskey"] = true,
    ["coffee"] = true,
    ["fishtaco"] = true,
    ["taco"] = true,
    ["burrito"] = true,
    ["churro"] = true,
    ["hotdog"] = true,
    ["greencow"] = true,
    ["donut"] = true,
    ["eggsbacon"] = true,
    ["icecream"] = true,
    ["mshake"] = true,
    ["sandwich"] = true,
    ["hamburger"] = true,
    ["cola"] = true,
    ["jailfood"] = true,
    ["bleederburger"] = true,
    ["heartstopper"] = true,
    ["torpedo"] = true,
    ["meatfree"] = true,
    ["moneyshot"] = true,
    ["fries"] = true,
    ["slushy"] = true,

}

Citizen.CreateThread(function()
    TriggerServerEvent("inv:playerSpawned");
end)

RegisterNetEvent('RunUseItem')
AddEventHandler('RunUseItem', function(itemid, slot, inventoryName, isWeapon)
    if itemid == nil then
        return
    end

    local ItemInfo = GetItemInfo(slot)
    if tonumber(ItemInfo.quality) <= 1 then
        exports['mythic_notify']:SendAlert('error', 'This item is not useable anymore')
        if isWeapon then
            TriggerEvent("brokenWeapon")
        end
        return
    end

    if justUsed then
        retardCounter = retardCounter + 1
        if retardCounter > 10 and retardCounter > lastCounter+5 then
            lastCounter = retardCounter
            TriggerServerEvent("exploiter", "Tried using " .. retardCounter .. " items in < 500ms ")
        end
        return
    end

    justUsed = true

    -- if (not hasEnoughOfItem(itemid,1,false)) then
    --     TriggerEvent("notification","You dont appear to have this item on you?",2) 
    --     justUsed = false
    --     retardCounter = 0
    --     lastCounter = 0
    --     return
    -- end

    if itemid == "-72657034" then
        TriggerEvent("equipWeaponID",itemid,ItemInfo.information,ItemInfo.id)
        TriggerEvent("inventory:removeItem",itemid, 1)
        justUsed = false
        retardCounter = 0
        lastCounter = 0
        return
    end

    if not isValidUseCase(itemid,isWeapon) then
        justUsed = false
        retardCounter = 0
        lastCounter = 0
        return
    end

    if (itemid == nil) then
        justUsed = false
        retardCounter = 0
        lastCounter = 0
        return
    end

    if (isWeapon) then
        TriggerEvent("equipWeaponID",itemid,ItemInfo.information,ItemInfo.id)
        justUsed = false
        retardCounter = 0
        lastCounter = 0
        return
    end

    TriggerEvent("hud-display-item",itemid,"Used")

    Wait(800)

    local player = PlayerPedId()
    local playerVeh = GetVehiclePedIsIn(player, false)

    if (not IsPedInAnyVehicle(player)) then
        if (itemid == "Suitcase") then
            TriggerEvent('attach:suitcase')
        end

        if (itemid == "Boombox") then
            TriggerEvent('attach:boombox')
        end

        if (itemid == "Box") then
            TriggerEvent('attach:box')
        end

        if (itemid == "DuffelBag") then
            TriggerEvent('attach:blackDuffelBag')
        end

        if (itemid == "MedicalBag") then
            TriggerEvent('attach:medicalBag')
        end
        if (itemid == "Galaxy") then
            TriggerEvent('attach:galaxy')
        end



        if (itemid == "SecurityCase") then
            TriggerEvent('attach:securityCase')
        end
        if (itemid == "Toolbox") then
            TriggerEvent('attach:toolbox')
        end
        if (itemid == "cone") then
            TriggerEvent('attach:cone')
        end
    end

    local remove = false
    local drugitem = false
    local fooditem = false
    local drinkitem = false
    local healitem = false

    if (itemid == "joint" or itemid == "weed5oz" or itemid == "weedq" or itemid == "beer" or itemid == "guiness" or itemid == "vodka" or itemid == "whiskey" or itemid == "peakyb" or itemid == "lsdtab") then
        drugitem = true
    end

    if (itemid == "fakeplate") then
      TriggerEvent("fakeplate:change")
    end

    if (itemid == "redb") then
        TriggerEvent("elrp-bandana:bloodsbandana")
    end

    if (itemid == "blueb") then
        TriggerEvent("elrp-bandana:cripsbandana")
    end

    if (itemid == "greenb") then
        TriggerEvent("elrp-bandana:greenbandana")
    end

    if (itemid == "purpleb") then
        TriggerEvent("elrp-bandana:ballasbandana")
    end

    if (itemid == "yellowb") then
        TriggerEvent("elrp-bandana:vagosbandana")
    end

    if (itemid == "whiteb") then
        TriggerEvent("elrp-bandana:whitebandana")
    end

    if (itemid == "tealb") then
        TriggerEvent("elrp-bandana:whitebandana")
    end

    if (itemid == "fishingrod") then
        TriggerEvent('fishing:fishstart')
    end

    if (itemid == "uvlight") then
        TriggerEvent('core_evidence:getData')
    end

    if (itemid == "sponge") then
        TriggerEvent('RS7x:OnClean')
        remove = true
    end

    if (itemid == "bait") then
      TriggerEvent('fishing:setbait', "fish")
      TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'You attached the bait onto the fishing rod', length = 5000})
      remove = true
    end

    if (itemid == "notepad") then
        TriggerEvent('lkrp_notepad:OpenNotepadGui')
    end

    if (itemid == "turtlebait") then
        TriggerEvent('fishing:setbait', "turtle")
        TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'You attached the turtle bait onto the fishing rod', length = 5000})
        remove = true
    end

    if (itemid == "turtle") then
        TriggerEvent('fishing:setbait', "shark")
	    TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'You attached the turtle meat onto the fishing rod', length = 5000})
        remove = true
    end

    if (itemid == "electronickit") then
        TriggerEvent("ffrp-paletorob:useEleckit")
    end

    if(itemid == "evidencebag") then
        TriggerEvent("evidence:startCollect", itemid, slot)
        local itemInfo = GetItemInfo(slot)
        local data = itemInfo.information
        if data == '{}' then
            exports['mythic_notify']:SendAlert('inform', 'Start collecting evidence!')
            TriggerEvent("inventory:updateItem", itemid, slot, '{"used": "true"}')
            --
        else
            local dataDecoded = json.decode(data)
            if(dataDecoded.used) then
            end
        end
    end

    if (itemid == "lsdtab" or itemid == "badlsdtab") then
        TriggerEvent("animation:PlayAnimation","pill")
        local finished = exports["ffrp-taskbar"]:taskBar(3000,"Taking LSD 🤯",false,false,playerVeh)
        if (finished == 100) then
            if hasEnoughOfItem(itemid, 1,false) then
                TriggerEvent("status:setState",2,1200)
                TriggerEvent("status:setState",24,1200)
                TriggerEvent("ffrp-fx:run", "lsd", 180, nil, (itemid == "badlsdtab" and true or false))
                remove = true
            else
                DumFuk = true
            end
        end
    end

    if (itemid == "decryptersess" or itemid == "decrypterfv2" or itemid == "decrypterenzo") then
        TriggerEvent("fleeca:canDecrypt")
        remove = true
    end

    if (itemid == "femaleseed") then
        TriggerEvent("status:setState",4,1600)
        TriggerEvent("ffrp-weed:startcrop","female")
    end

    if (itemid == "maleseed") then
        TriggerEvent("status:setState",4,1600)
        TriggerEvent("ffrp-weed:startcrop","male")
    end

    if (itemid == "weedoz") then
        local finished = exports["ffrp-taskbar"]:taskBar(5000,"Packing Q Bags",false,false,playerVeh)
        if (finished == 100) then
            CreateCraftOption("weedq", 40, true)
        end
    end
    if (itemid == "weed") then
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 0, true)
        end
        local finished = exports["ffrp-taskbar"]:taskBar(10000,"Packing into Bags",false,false,playerVeh)
        if (finished == 100) then
            CreateCraftOption("weedq2", 10, true)
        end
    end

    if (itemid == "weedq") then
        local finished = exports["ffrp-taskbar"]:taskBar(1000,"Rolling Joints",false,false,playerVeh)
        if (finished == 100) then
            CreateCraftOption("joint", 80, true)
        end
    end

    if (itemid == "lighter") then
        TriggerEvent("animation:PlayAnimation","lighter")
        local finished = exports["ffrp-taskbar"]:taskBar(2000,"Starting Fire",false,false,playerVeh)
        if (finished == 100) then
        end
    end

    if (itemid == "joint") then
        TriggerEvent("status:setState",3,600)
        TriggerEvent("status:setState",4,600)
        TriggerEvent('client:useJoint')
        remove = true
    end


    if (itemid == "vodka" or itemid == "beer" or itemid == "guiness" or itemid == "whiskey") or itemid == "peakyb" then
        AttachPropAndPlayAnimation("amb@world_human_drinking@coffee@male@idle_a", "idle_c", 49,6000,"Drink","changethirst",true,itemid,playerVeh)
        TriggerEvent("Evidence:StateSet", 8, 600)
        local alcoholStrength = 0.5
        if itemid == "vodka" or itemid == "whiskey" or itemid == "peakyb"then alcoholStrength = 1.0 end
        TriggerEvent("ffrp-fx:run", "alcohol", 180, alcoholStrength)
    end
 
    if (itemid == "coffee") then
       AttachPropAndPlayAnimation("amb@world_human_drinking@coffee@male@idle_a", "idle_c", 49,6000,"Drink","coffee:drink",true,itemid,playerVeh)
       TriggerEvent('tac_status:add', 'thirst', 125000)
    end
 
    if (itemid == "fishtaco") then
       AttachPropAndPlayAnimation("mp_player_inteat@burger", "mp_player_int_eat_burger", 49,6000,"Eating","food:FishTaco",true,itemid,playerVeh)
    end
 
    if (itemid == "taco" or itemid == "burrito") then
       AttachPropAndPlayAnimation("mp_player_inteat@burger", "mp_player_int_eat_burger", 49,6000,"Eating","food:Taco",true,itemid,playerVeh)
    end
 
    if (itemid == "churro" or itemid == "hotdog" or itemid == "sushiplate" or itemid == "sushiroll") then
        TaskItem("mp_player_inteat@burger", "mp_player_int_eat_burger", 49,6000,"Eating","food:Condiment",true,itemid,playerVeh)
        TriggerEvent('tac_status:add', 'hunger', 200000)
    end
 
    if (itemid == "greencow") then
        AttachPropAndPlayAnimation("amb@world_human_drinking@coffee@male@idle_a", "idle_c", 49,6000,"Drink","food:Condiment",true,itemid,playerVeh)
    end
 
 
    if (itemid == "icecream" or itemid == "mshake") then
        AttachPropAndPlayAnimation("amb@world_human_drinking@coffee@male@idle_a", "idle_c", 49,6000,"Drink","coffee:drink",true,itemid,playerVeh)
    end

    if (itemid == "advlockpick") then
        if #(GetEntityCoords(PlayerPedId()) - vector3(-104.8828,6472.442,30.727)) < 10.0 then
            TriggerEvent('ffrp-paletorob:useAdvlockpick')
        else
            TriggerEvent('stores:onUse', 1)
            local myJob = exports["ffrp-ped"]:isPed("myJob")
            if myJob ~= "news" then
                TriggerEvent('inv:advancedLockpick',inventoryName,slot)
            else
                exports['mythic_notify']:SendAlert('inform', 'Nice news reporting.')
            end
        end
    end

    if (itemid == "weed12oz") then
        TriggerEvent("inv:weedPacking")
        remove = true
    end

    if (itemid == "heavyammo") then
        local finished = exports["ffrp-taskbar"]:taskBar(5000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            if hasEnoughOfItem(itemid, 1, false) then
                TriggerEvent("actionbar:ammo",1788949567,50,true)
                remove = true
            else
                DumFuk = true
            end
        end
    end

    if (itemid == "pistolammo") then
        local finished = exports["ffrp-taskbar"]:taskBar(5000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            if hasEnoughOfItem(itemid, 1, false) then
                TriggerEvent("actionbar:ammo",1950175060,50,true)
                remove = true
            else
                DumFuk = true
            end
        end
    end



    if (itemid == "usbdevice") then
        --local finished = exports["ffrp-taskbar"]:taskBar(15000,"Scanning For Networks",false,false,playerVeh)
        --if (finished == 100) then
            TriggerEvent("esx_atmRobbery:isRobbingPossible")
        --end
    end


    if (itemid == "rifleammo") then
        local finished = exports["ffrp-taskbar"]:taskBar(5000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            if hasEnoughOfItem(itemid, 1, false) then
                TriggerEvent("actionbar:ammo",218444191,50,true)
                remove = true
            else
                DumFuk = true
            end
        end
    end

    if (itemid == "shotgunammo") then
        local finished = exports["ffrp-taskbar"]:taskBar(5000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            if hasEnoughOfItem(itemid, 1, false) then
                TriggerEvent("actionbar:ammo",-1878508229,50,true)
                remove = true
            else
                DumFuk = true
            end
        end
    end

    if (itemid == "subammo") then
        local finished = exports["ffrp-taskbar"]:taskBar(5000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            if hasEnoughOfItem(itemid, 1, false) then
                TriggerEvent("actionbar:ammo",1820140472,50,true)
                remove = true
            else
                DumFuk = true
            end
        end
    end

    if (itemid == "stungunammo") then
        local finished = exports["ffrp-taskbar"]:taskBar(5000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
        TriggerEvent("ford:tazer")
        remove = true
        end
    end

    if (itemid == "armor") or (itemid == "armor2")then
        local finished = exports["ffrp-taskbar"]:taskBar(10000,"Armor",true,false,playerVeh)
        if (finished == 100) then
            if hasEnoughOfItem(itemid, 1, false) then
                SetPlayerMaxArmour(PlayerId(), 100 )
                SetPedArmour( player, 100 )
                remove = true
            else
                DumFuk = true
            end
        end
    end

    if (itemid == "binoculars") then
        TriggerEvent("binoculars:Activate2")
    end

    if (itemid == "camera") then
        TriggerEvent("camera:Activate2")
    end

    if (itemid == "radio") or (itemid == "radio2") then
        TriggerEvent('ffrp-radio:use', source)
    end

    if (itemid == "mobilephone") then
        TriggerEvent('phoneGui2')
    end

    if (itemid == "nitrous") then
        local currentVehicle = GetVehiclePedIsIn(player, false)
        if not IsToggleModOn(currentVehicle,18) then
            exports['mythic_notify']:SendAlert('inform', 'You need a Turbo to use NOS!')
        else
            local finished = 0
            local cancelNos = false
            Citizen.CreateThread(function()
                while finished ~= 100 and not cancelNos do
                    Citizen.Wait(100)
                    if GetEntitySpeed(GetVehiclePedIsIn(player, false)) > 11 then
                        exports["ffrp-taskbar"]:closeGuiFail()
                        cancelNos = true
                    end
                end
            end)
            finished = exports["ffrp-taskbar"]:taskBar(5000,"Nitrous")
            if (finished == 100 and not cancelNos) then
                if hasEnoughOfItem(itemid, 1, false) then
                    TriggerEvent("NosStatus")
                    TriggerEvent("noshud", 100, false)
                    remove = true
                else
                    DumFuk = true
                end
            else
                exports['mythic_notify']:SendAlert('inform', 'You can\'t drive and hook up nos at the same time.')
            end
        end
    end

    if (itemid == "lockpick") then
        local myJob = exports["ffrp-ped"]:isPed("myJob")
        if myJob ~= "news" then
            TriggerEvent("inv:lockPick",false,inventoryName,slot)
        else
            exports['mythic_notify']:SendAlert('error', "Nice news reporting, you stoopid fuck.")
        end
    end

    if (itemid == "umbrella") then
        TriggerEvent('dpemotes:doEmote', 'umbrella')
    end

    if (itemid == "repairkit") then
        TriggerEvent('RS7x:OnRepair',itemid, false)
    end

    if (itemid == "advrepairkit") then
        TriggerEvent('RS7x:OnRepair',itemid, true)
    end

    if (itemid == "securityblue" or itemid == "securityblack" or itemid == "securitygreen" or itemid == "securitygold" or itemid == "securityred")  then
        TriggerEvent('securitycard:OnUse', itemid)
    end

    if (itemid == "bluesec")  then
        TriggerEvent("alert:noPedCheck", "banktruck")
        TriggerServerEvent('ffrp-securityheists:banktstart')
    end

    if (itemid == "Gruppe6Card22")  then
    end

    if (itemid == "ciggy") then
        TriggerEvent('client:useCig')
        TriggerEvent('dpemotes:doEmote', 'smoke')
        remove = true
    end

    if (itemid == "cigar") then
        exports["ffrp-taskbar"]:taskBar(2500,"Lighting Up",false,false,playerVeh)
        Wait(300)
        TriggerEvent('attach:cigar')
    end

    if (itemid == "oxygentank") then
        local finished = exports["ffrp-taskbar"]:taskBar(30000,"Oxygen Tank",true,false,playerVeh)
        if (finished == 100) then
            if hasEnoughOfItem(itemid, 1, false) then
                TriggerEvent("UseOxygenTank")
                remove = true
            else
                DumFuk = true
            end
        end
    end

    if (itemid == "bandage") then
        TaskItem("amb@world_human_clipboard@male@idle_a", "idle_c", 49,10000,"Healing","mythic_hospital:items:bandage",true,itemid,playerVeh)
    end

    if (itemid == "coke50g") then
        CreateCraftOption("coke5g", 80, true)
    end

    if (itemid == "bakingsoda") then
        CreateCraftOption("1gcrack", 80, true)
    end

    if (itemid == "glucose") then
        CreateCraftOption("1gcocaine", 80, true)
    end

    if (itemid == "idcard") or  (itemid == "greencard") then
        local data = GetItemInfo(slot)
        TriggerEvent('RS7x:showid', data.information)
    end

    if (itemid == "drivingtest") then 
        local ItemInfo = GetItemInfo(slot)
        if (ItemInfo.information ~= "No information stored") then
            local data = json.decode(ItemInfo.information)
            TriggerServerEvent("driving:getResults", data.ID)
        end
    end

    if (itemid == "1gcocaine") then
        TriggerEvent("attachItemObjectnoanim","drugpackage01")
        TriggerEvent("status:setState",2,1200)
        TriggerEvent("status:setState",6,1200)
        TaskItem("anim@amb@nightclub@peds@", "missfbi3_party_snort_coke_b_male3", 49, 5000, "Coke Gaming", "hadcocaine", true,itemid,playerVeh)
    end

    if (itemid == "1gcrack") then
        TriggerEvent("attachItemObjectnoanim","crackpipe01")
        TriggerEvent("status:setState",2,1200)
        TriggerEvent("status:setState",6,1200)
        TaskItem("switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 49, 5000, "Smoking Quack", "hadcrack", true,itemid,playerVeh)
    end

    if (itemid == "treat") then
        local model = GetEntityModel(player)
        if model == GetHashKey("a_c_chop") then
            TaskItem("mp_player_inteat@burger", "mp_player_int_eat_burger", 49, 1200, "Treat Num's", "hadtreat", true,itemid,playerVeh)
        end
    end

    if (itemid == "IFAK") then
        TriggerEvent('mythic_hospital:items:ifak')
        remove = true
    end


    if (itemid == "oxy") then
        TriggerEvent('mythic_hospital:items:oxy', 1)
        remove = true
    end
  

    if (itemid == "sandwich" or itemid == "hamburger" or itemid == "pizza") then
        AttachPropAndPlayAnimation("mp_player_inteat@burger", "mp_player_int_eat_burger", 49,6000,"Eating","",true,itemid,playerVeh)
        TriggerEvent('tac_status:add', 'hunger', 200000)
    end

    if (itemid == "cola" or itemid == "water" or itemid == "milkshake") then
        AttachPropAndPlayAnimation("friends@frl@ig_1", "drink_lamar", 49,6000,"Drink","",true,itemid,playerVeh)
        TriggerEvent('tac_status:add', 'thirst', 125000)
    end

    if (itemid == "jailfood" or itemid == "bleederburger" or itemid == "heartstopper" or itemid == "torpedo" or itemid == "meatfree" or itemid == "moneyshot" or itemid == "fries") then
        AttachPropAndPlayAnimation("mp_player_inteat@burger", "mp_player_int_eat_burger", 49,6000,"Eating","inv:wellfed",true,itemid,playerVeh)
        TriggerEvent('tac_status:add', 'hunger', 200000)
    end

    if (itemid == "methbag") then
        local finished = exports["ffrp-skillbar"]:taskBar(2500,10)
        if (finished == 100) then
            if hasEnoughOfItem(itemid, 1, false) then
                TriggerEvent("attachItemObjectnoanim","crackpipe01")
                TriggerEvent("status:setState",2,1200)
                TriggerEvent("status:setState",6,1200)
                TaskItem("switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 49, 1500, "Smoking Meth", "hadcocaine", true, itemid,playerVeh)
            else
                DumFuk = true
            end
        end
    end
    if itemid == "slushy" then
        AttachPropAndPlayAnimation("amb@world_human_drinking@beer@female@idle_a", "idle_e", 49, 6000,"Eating", "inv:wellfed",true,itemid,playerVeh)
    end

    if (itemid == "shitlockpick") then
        lockpicking = true
        TriggerEvent("animation:lockpickinvtestoutside") 
        local finished = exports["ffrp-skillbar"]:taskBar(2500,math.random(5,20))
        if (finished == 100) then
            if hasEnoughOfItem(itemid, 1, false) then
                TriggerEvent("police:uncuffMenu")
            else
                DumFuk = true
            end
        end
        lockpicking = false
        remove = true
    end

    if (itemid == "watch" or itemid == "dwatch") then
        TriggerEvent("carHud:compass")
    end

    if (itemid == "shipcrate") then
        TriggerEvent('shipcrate:OnUse')
    end

    if (itemid == "harness") then
        local veh = GetVehiclePedIsIn(player, false)
        local driver = GetPedInVehicleSeat(veh, -1)
        if (PlayerPedId() == driver) then
            TriggerEvent("ffrp-vehdamage:useHarnessItem")
        end
    end

    if DumFuk == true then
		local data = {
			name = GetPlayerName(PlayerId()),
			reason = 'Attempted to exploit inventory',
			info = string.format("Item: **%s**", itemid)
		}
        TriggerServerEvent("ffrp-log:SendDiscordLog", data)
    end

    if remove == true then
        TriggerEvent("inventory:removeItem",itemid, 1)
    end
    Wait(500)
    retardCounter = 0
    justUsed = false
    DumFuk = false
end)

function AttachPropAndPlayAnimation(dictionary,animation,typeAnim,timer,message,func,remove,itemid,vehicle)
    if itemid == "hamburger" or itemid == "heartstopper" or itemid == "bleederburger" then
        TriggerEvent("attachItem", itemid)
        TriggerEvent('tac_status:add', 'hunger', 145000)
    elseif itemid == "sandwich" then
        TriggerEvent("attachItem", "sandwich")
        TriggerEvent('tac_status:add', 'hunger', 200000)
        TriggerEvent('tac_status:add', 'thirst', 125000)
    elseif itemid == "donut" then
        TriggerEvent("attachItem", "donut")
        TriggerEvent('tac_status:add', 'thirst', 100000)
        TriggerEvent('tac_status:add', 'hunger', 175000)
    elseif itemid == "water" or itemid == "cola" or itemid == "vodka" or itemid == "whiskey" or itemid == "beer" or itemid == "coffee" or itemid == "peakyb" or itemid == "guiness" then
        TriggerEvent("attachItem", itemid)
        TriggerEvent('tac_status:add', 'thirst', 185000)
    elseif itemid == "fishtaco" or itemid == "taco" then
        TriggerEvent("attachItem", "taco")
        TriggerEvent('tac_status:add', 'hunger', 155000)
    elseif itemid == "greencow" then
        TriggerEvent("attachItem", "energydrink")
        TriggerEvent('tac_status:add', 'thirst', 150000)
    elseif itemid == "slushy" then
        TriggerEvent("attachItem", "cup")
        TriggerEvent('tac_status:add', 'thirst', 200000)
    end
    TaskItem(dictionary, animation, typeAnim, timer, message, func, remove, itemid,vehicle)
end

RegisterNetEvent('randPickupAnim')
AddEventHandler('randPickupAnim', function()
    loadAnimDict('pickup_object')
    TaskPlayAnim(PlayerPedId(),'pickup_object', 'putdown_low',5.0, 1.5, 1.0, 48, 0.0, 0, 0, 0)
    Wait(1000)
    ClearPedSecondaryTask(PlayerPedId())
end)



local clientInventory = {};
RegisterNetEvent('current-items')
AddEventHandler('current-items', function(inv)
    clientInventory = inv
end)

RegisterNetEvent('SniffRequestCID')
AddEventHandler('SniffRequestCID', function(src)
    local cid = exports["ffrp-ped"]:isPed("steamid")
    TriggerServerEvent("SniffCID",cid,src)
end)

function GetItemInfo(checkslot)
    for i,v in pairs(clientInventory) do
        if (tonumber(v.slot) == tonumber(checkslot)) then
            local quality = exports["ffrp-inventory"]:ConvertQuality(v.item_id,v.creationDate)
            local info = {["information"] = v.information, ["id"] = v.id, ["quality"] = quality }
            return info
        end
    end
    return "No information stored";
end

-- item id, amount allowed, crafting.
function CreateCraftOption(id, add, craft)
    TriggerEvent("CreateCraftOption", id, add, craft)
end

-- Animations
function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function TaskItem(dictionary,animation,typeAnim,timer,message,func,remove,itemid,playerVeh)
    loadAnimDict( dictionary ) 
    TaskPlayAnim( PlayerPedId(), dictionary, animation, 8.0, 1.0, -1, typeAnim, 0, 0, 0, 0 )
    local timer = tonumber(timer)
    if timer > 0 then
        local finished = exports["ffrp-taskbar"]:taskBar(timer,message,true,false,playerVeh)
        if finished == 100 or timer == 0 then
            TriggerEvent(func)
            ClearPedTasks(PlayerPedId())
            TriggerEvent("destroyProp")
        end
    else
        TriggerEvent(func)
    end

    if remove then
        if hasEnoughOfItem(itemid, 1, false) then
            TriggerEvent("inventory:removeItem",itemid, 1)
        end
    end
end

function GetCurrentWeapons()
    local returnTable = {}
    for i,v in pairs(clientInventory) do
        if (tonumber(v.item_id)) then
            local t = { ["hash"] = v.item_id, ["id"] = v.id, ["information"] = v.information, ["name"] = v.item_id, ["slot"] = v.slot }
            returnTable[#returnTable+1]=t
        end
    end  
    if returnTable == nil then 
        return {}
    end
    return returnTable
end

function getQuantity(itemid)
    local amount = 0
    for i,v in pairs(clientInventory) do
        if v.quality > 0 then
            if (v.item_id == itemid) then
                amount = amount + v.amount
            end
        end
    end
    return amount
end

function hasEnoughOfItem(itemid,amount,shouldReturnText)
    if shouldReturnText == nil then shouldReturnText = true end
    if itemid == nil or itemid == 0 or amount == nil or amount == 0 then
        if shouldReturnText then
            exports['mythic_notify']:SendAlert('error', "I dont seem to have " .. itemid .. " in my pockets.")
        end
        return false
    end
    amount = tonumber(amount)
    local slot = 0
    local found = false

    if getQuantity(itemid) >= amount then
        return true
    end
    if (shouldReturnText) then
        exports['mythic_notify']:SendAlert('error', "You dont have enough of that item.")
    end
    return false
end

function isValidUseCase(itemID,isWeapon)
    local player = PlayerPedId()
    local playerVeh = GetVehiclePedIsIn(player, false)
    if playerVeh ~= 0 then
        local model = GetEntityModel(playerVeh)
        if IsThisModelACar(model) or IsThisModelABike(model) or IsThisModelAQuadbike(model) then
            if IsEntityInAir(playerVeh) then
                Wait(1000)
                if IsEntityInAir(playerVeh) then
                    exports['mythic_notify']:SendAlert('error', "You appear to be flying through the air")
                    return false
                end
            end
        end
    end

    if not validWaterItem[itemID] and not isWeapon then
        if IsPedSwimming(player) then
            local targetCoords = GetEntityCoords(player, 0)
            Wait(700)
            local plyCoords = GetEntityCoords(player, 0)
            if #(targetCoords - plyCoords) > 1.3 then
                exports['mythic_notify']:SendAlert('error', "Cannot be moving while swimming to use this.")
                return false
            end
        end

        if IsPedSwimmingUnderWater(player) then
            exports['mythic_notify']:SendAlert('error', "Cannot be underwater to use this.")
            return false
        end
    end

    return true
end



RegisterNetEvent('evidence:addDnaSwab')
AddEventHandler('evidence:addDnaSwab', function(dna)
    exports['mythic_notify']:SendAlert('error', "DNA Result: " .. dna)
end)

RegisterNetEvent('CheckDNA')
AddEventHandler('CheckDNA', function()
    TriggerServerEvent("Evidence:checkDna")
end)

RegisterNetEvent('evidence:dnaSwab')
AddEventHandler('evidence:dnaSwab', function()
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 5) then
        TriggerServerEvent("police:dnaAsk", GetPlayerServerId(t))
    end
end)

RegisterNetEvent('evidence:swabNotify')
AddEventHandler('evidence:swabNotify', function()
    exports['mythic_notify']:SendAlert('error', "DNA swab taken.")
end)

function GetPlayers()
    local players = {}
    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end
    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end



function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle

    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)   
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)
        
        offset = offset - 1

        if vehicle ~= 0 then break end
    end
    
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    
    if distance > 25 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)

end

local burgies = 0
RegisterNetEvent('inv:wellfed')
AddEventHandler('inv:wellfed', function()
    burgies = 0
end)

RegisterNetEvent('animation:lockpickinvtestoutside')
AddEventHandler('animation:lockpickinvtestoutside', function()
    local lPed = PlayerPedId()
    RequestAnimDict("veh@break_in@0h@p_m_one@")
    while not HasAnimDictLoaded("veh@break_in@0h@p_m_one@") do
        Citizen.Wait(0)
    end
    
    while lockpicking do
        TaskPlayAnim(lPed, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
        Citizen.Wait(2500)
    end
    ClearPedTasks(lPed)
end)

RegisterNetEvent('animation:lockpickinvtest')
AddEventHandler('animation:lockpickinvtest', function(disable)
    local lPed = PlayerPedId()
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(0)
    end
    if disable ~= nil then
        if not disable then
            lockpicking = false
            return
        else
            lockpicking = true
        end
    end
    while lockpicking do

        if not IsEntityPlayingAnim(lPed, "mini@repair", "fixing_a_player", 3) then
            ClearPedSecondaryTask(lPed)
            TaskPlayAnim(lPed, "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end
    ClearPedTasks(lPed)
end)



RegisterNetEvent('inv:lockPick')
AddEventHandler('inv:lockPick', function(isForced,inventoryName,slot)
    TriggerEvent("robbery:scanLock",true)
    if lockpicking then return end

    lockpicking = true
    playerped = PlayerPedId()
    targetVehicle = GetVehiclePedIsUsing(playerped)
    local itemid = 21

    if targetVehicle == 0 then
        coordA = GetEntityCoords(playerped, 1)
        coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
        targetVehicle = getVehicleInDirection(coordA, coordB)
        local driverPed = GetPedInVehicleSeat(targetVehicle, -1)
        if targetVehicle == 0 then
            lockpicking = false
            TriggerServerEvent("houseRobberies:attempt", 1)
            return
        end

        if driverPed ~= 0 then
            lockpicking = false
            return
        end
        local d1,d2 = GetModelDimensions(GetEntityModel(targetVehicle))
        local leftfront = GetOffsetFromEntityInWorldCoords(targetVehicle, d1["x"]-0.25,0.25,0.0)

        local count = 5000
        local dist = #(vector3(leftfront["x"],leftfront["y"],leftfront["z"]) - GetEntityCoords(PlayerPedId()))
        while dist > 2.0 and count > 0 do
            dist = #(vector3(leftfront["x"],leftfront["y"],leftfront["z"]) - GetEntityCoords(PlayerPedId()))
            Citizen.Wait(1)
            count = count - 1
            DrawText3Ds(leftfront["x"],leftfront["y"],leftfront["z"],"Move here to lockpick.")
        end

        if dist > 2.0 then
            lockpicking = false
            return
        end

        TaskTurnPedToFaceEntity(PlayerPedId(), targetVehicle, 1.0)
        Citizen.Wait(1000)
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.4)
        local triggerAlarm = GetVehicleDoorLockStatus(targetVehicle) > 1
        if triggerAlarm then
            SetVehicleAlarm(targetVehicle, true)
            StartVehicleAlarm(targetVehicle)
        end

        --TriggerServerEvent('tac_outlawalert:carJackInProgress', playerCoords, streetName, vehicleLabel, inVeh)
        --TriggerEvent("civilian:alertPolice",20.0,"lockpick",targetVehicle)
        TriggerEvent('tac-dispatch:carjacking')
        TriggerEvent("animation:lockpickinvtestoutside")
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.4)

        local finished = exports["ffrp-skillbar"]:taskBar(25000,3)
        if finished ~= 100 then
            lockpicking = false
            return
        end

        local finished = exports["ffrp-skillbar"]:taskBar(2200,10)
        if finished ~= 100 then
            lockpicking = false
            return
        end

        if finished == 100 then
            if triggerAlarm then
                SetVehicleAlarm(targetVehicle, false)
            end
            local chance = math.random(50)
            if #(GetEntityCoords(targetVehicle) - GetEntityCoords(PlayerPedId())) < 10.0 and targetVehicle ~= 0 and GetEntitySpeed(targetVehicle) < 5.0 then
                SetVehicleDoorsLocked(targetVehicle, 1)
                exports['mythic_notify']:SendAlert('inform', 'Vehicle Unlocked.')
                TriggerEvent('InteractSound_CL:PlayOnOne', 'unlock', 0.1)
            end
        end
        lockpicking = false
    else
        if targetVehicle ~= 0 and not isForced then

            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.4)
            local triggerAlarm = GetVehicleDoorLockStatus(targetVehicle) > 1
            if triggerAlarm then
                SetVehicleAlarm(targetVehicle, true)
                StartVehicleAlarm(targetVehicle)
            end

            SetVehicleHasBeenOwnedByPlayer(targetVehicle,true)
            --TriggerEvent("civilian:alertPolice",20.0,"lockpick",targetVehicle)
            TriggerEvent('tac-dispatch:carjacking')
            TriggerEvent("animation:lockpickinvtest")
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.4)

            local carTimer = GetVehicleHandlingFloat(targetVehicle, 'CHandlingData', 'nMonetaryValue')
            if carTimer == nil then
                carTimer = math.random(25000,180000)
            end
            if carTimer < 25000 then
                carTimer = 25000
            end

            if carTimer > 180000 then
                carTimer = 180000
            end

            carTimer = math.ceil(carTimer / 3)

            local myJob = exports["ffrp-ped"]:isPed("myJob")
            if myjob == "towtruck" then
                carTimer = 4000
            end

            TriggerEvent("civilian:alertPolice",20.0,"lockpick",targetVehicle)

            local finished = exports["ffrp-skillbar"]:taskBar(math.random(5000,25000),math.random(10,20))
            if finished ~= 100 then
                 lockpicking = false
                return
            end

            local finished = exports["ffrp-skillbar"]:taskBar(math.random(5000,25000),math.random(10,20))
            if finished ~= 100 then
                lockpicking = false
                return
            end

            TriggerEvent("civilian:alertPolice",20.0,"lockpick",targetVehicle)
            local finished = exports["ffrp-skillbar"]:taskBar(1500,math.random(5,15))
            if finished ~= 100 then
                exports['mythic_notify']:SendAlert('error', 'The lockpick bent out of shape.')
                TriggerEvent("inventory:removeItem","lockpick", 1)
                lockpicking = false
                return
            end

            Citizen.Wait(500)
            if finished == 100 then
                if triggerAlarm then
                    SetVehicleAlarm(targetVehicle, false)
                end
                local chance = math.random(50)
                if #(GetEntityCoords(targetVehicle) - GetEntityCoords(PlayerPedId())) < 10.0 and targetVehicle ~= 0 and GetEntitySpeed(targetVehicle) < 5.0 then
                    local plate = GetVehicleNumberPlateText(targetVehicle)
                    SetVehicleDoorsLocked(targetVehicle, 1)
                    TriggerEvent("ARPF:spawn:recivekeys",targetVehicle,plate)
                    TriggerEvent("civilian:alertPolice",20.0,"lockpick",targetVehicle)
                    exports['mythic_notify']:SendAlert('inform', 'Ignition Working.')
                    SetEntityAsMissionEntity(targetVehicle,false,true)
                    SetVehicleHasBeenOwnedByPlayer(targetVehicle,true)
                end
                lockpicking = false
            end
        elseif isForced then 
            local hasLockpick = export['ffrp-inventory']:hasEnoughOfItem('lockpick', 1, false)
            if hasLockpick then 
                TriggerEvent('disc-hotwire:hotwire', true)
            else
                exports['mythic_notify']:SendAlert('inform', 'You dont have this item on you?')
            end
        end
    end
    lockpicking = false
end)

-- Animations
RegisterNetEvent('animation:load')
AddEventHandler('animation:load', function(dict)
    RequestAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end)

RegisterNetEvent('animation:repair')
AddEventHandler('animation:repair', function(veh)
    SetVehicleDoorOpen(veh, 4, 0, 0)
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(0)
    end

    TaskTurnPedToFaceEntity(PlayerPedId(), veh, 1.0)
    Citizen.Wait(1000)

    while fixingvehicle do
        local anim3 = IsEntityPlayingAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 3)
        if not anim3 then
            TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end
    SetVehicleDoorShut(veh, 4, 1, 1)
end)

RegisterNetEvent('police:targetCheckInventory')
AddEventHandler('police:targetCheckInventory', function(bool, isFrisk)
    local _bool = bool

    if _bool == nil or _bool == false then 
        _bool = false 
    else 
        _bool = true
    end
    if isFrisk == nil then isFrisk = false end
    t, distance, closestPed = GetClosestPlayer()
    if(distance ~= -1 and distance < 5) then
        TriggerServerEvent("server-inventory-openPlayer", GetPlayerServerId(t), isFrisk, _bool)
    else
        exports['mythic_notify']:SendAlert('inform', 'No player near you!')
    end
end)

RegisterCommand("search", function(source, args)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if job == 'police' then
        if closestPlayer ~= -1 and closestDistance <= 2.0 then
            local searchPlayerPed = GetPlayerPed(closestPlayer)
            TriggerServerEvent("people-search", GetPlayerServerId(closestPlayer)) --COPY THIS
            --TriggerServerEvent("polzice:SeieCash",  GetPlayerServerId(closestPlayer))
        end
    end
end)

--[[RegisterCommand("sieze", function(source, args)
    local player = ESX.GetPlayerData()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 2.0 then
        local searchPlayerPed = GetPlayerPed(closestPlayer)
        --TriggerServerEvent("people-search", GetPlayerServerId(closestPlayer)) --COPY THIS
        TriggerServerEvent("police:SeizeCash",  GetPlayerServerId(closestPlayer))
    end
end)]]

--[[RegisterCommand("steal", function(source, args)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 1.0 then
        local playerPed = PlayerPedId()
        local searchPlayerPed = GetPlayerPed(closestPlayer)

        if IsEntityPlayingAnim(searchPlayerPed, 'missminuteman_1ig_2', 'handsup_enter', 3) or (IsEntityPlayingAnim(searchPlayerPed, "dead", "dead_a", 3)) then
            RequestAnimDict("random@shop_robbery")

            while not HasAnimDictLoaded("random@shop_robbery") do
                Citizen.Wait(0)
            end
            TaskPlayAnim(PlayerPedId(), "random@shop_robbery" , "robbery_action_b", 8.0, -8, -1, 16, 0, 0, 0, 0)

            local finished = exports["ffrp-taskbar"]:taskBar(3500, "Robbing")
            TriggerServerEvent("people-search", GetPlayerServerId(closestPlayer))
            --TriggerServerEvent('steal:takeCash', GetPlayerServerId(closestPlayer))
        else
            exports['mythic_notify']:SendAlert('inform', 'They need to do /e handsup or be dead')
        end
    end
end)]]

RegisterCommand("frisk", function(source, args)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if job == 'police' then
        if closestPlayer ~= -1 and closestDistance <= 2.0 then
            local searchPlayerPed = GetPlayerPed(closestPlayer)
            TriggerServerEvent("people-frisk", GetPlayerServerId(closestPlayer))
        end
    end
end)

RegisterNetEvent('searching-person')
AddEventHandler('searching-person', function(target)
    TriggerEvent("server-inventory-open", "1", target)
end)

RegisterNetEvent('shipcrate:OnUse')
AddEventHandler('shipcrate:OnUse', function()
    local hasItem = exports['ffrp-inventory']:hasEnoughOfItem('shipcrate',1)
    if hasItem then
        local materials = {'plastic', 'aluminium', 'rubber', 'electronics', 'steel'}
        for i=1, #materials, 3 do
            TriggerEvent('player:receiveItem', materials[i], math.random(100,150))
        end
        TriggerEvent('inventory:removeItem', 'shipcrate', 1)
    end
end)

--[[Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
        if #(vector3(15.72802066803,-1598.2983398438,29.377981185913) - GetEntityCoords(PlayerPedId())) <= 1.2 then
            Citizen.Wait(5)
            DrawText3D(15.72802066803,-1598.2983398438,29.377981185913, "Open inventory to cook here")
        else
            Citizen.Wait(1000)
        end
    end
end)]]


function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end


WeaponLiscence = {x = 237.7892, y = -415.4703, z = 47.94809}

Citizen.CreateThread(function()
    while true do
        player = GetPlayerPed(-1)
        coords = GetEntityCoords(player)
        local dist = #(vector3(WeaponLiscence.x, WeaponLiscence.y, WeaponLiscence.z) - coords)
        if dist < 5.0 then
            Citizen.Wait(0)
            DrawMarker(27,WeaponLiscence.x, WeaponLiscence.y, WeaponLiscence.z - 0.9, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.7, 0, 0, 255, 100, false, false, 2, false, false, false, false)
            DrawText3D(WeaponLiscence.x, WeaponLiscence.y, WeaponLiscence.z, "[E] - Weapon License Shop")
            if dist < 1.0 then
                if IsControlJustReleased(0, 46) then
                    if Licenses['weapon'] == nil then
                        OpenBuyLicenseMenu()
                    else
                        exports['mythic_notify']:SendAlert('inform', 'You already got a weapons license')
                    end
                    Citizen.Wait(2000)
                end
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

RegisterNetEvent('suku:GetLicenses')
AddEventHandler('suku:GetLicenses', function (licenses)
    for i = 1, #licenses, 1 do
        Licenses[licenses[i].type] = true
    end
end)

function OpenBuyLicenseMenu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ffrp-inventory',{
        title = 'Firearms License',
        elements = {
          { label = 'yes' ..' ($' .. 5000 ..')', value = 'yes' },
          { label = 'no', value = 'no' },
        }
    },function (data, menu)
        if data.current.value == 'yes' then
            TriggerServerEvent('suku:buyLicense')
        end
        menu.close()
    end,
    function (data, menu)
        menu.close()
    end)
end

function AnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

function LoadPropDict(model)
    while not HasModelLoaded(GetHashKey(model)) do
        RequestModel(GetHashKey(model))
        Wait(10)
    end
end

Citizen.CreateThread(function()
    while true do
        local pos = GetEntityCoords(PlayerPedId())
        --[[if #(pos - vector3(51.504,6485.803,31.428)) <= 1.2 then
            DrawText3D(51.504,6485.803,31.428, "[~p~E~w~] - What dis?")
            if IsControlJustReleased(0, 86) then
                local finished = exports["ffrp-taskbar"]:taskBar(15000, "Knocking On Door")
                if (finished == 100) then
                    TriggerEvent("server-inventory-open", "31", "Craft");
                    exports['mythic_notify']:SendAlert('inform', 'Get what you need, and leave.')
                end
            end
        end]]

        

        if #(vector3(479.176, -996.776, 30.692) - pos) <= 1.2 then
            found = true
			if job == 'police' then
                DrawText3D(479.176, -996.776, 30.692, "[E] - Open Police Armory")
                if IsControlJustReleased(0, 86) then
                    Citizen.Wait(1)
                    TriggerEvent("server-inventory-open", "10", "Shop");
                end
            end
        end

      --Davis PD
      if #(vector3(381.931,-1606.961,29.332) - pos) <= 1.2 then
        found = true
        if job == 'police' then
            DrawText3D(381.931,-1606.961,29.332, "[E] - Open Police Armory")
            if IsControlJustReleased(0, 86) then
                Citizen.Wait(1)
                TriggerEvent("server-inventory-open", "10", "Shop");
            end
        end
    end

        if #(vector3(467.63592529297,-993.21063232422,24.920820236206) - pos) <= 1.2 then
            found = true
			if job == 'police' then
                DrawText3D(467.63592529297,-993.21063232422,24.920820236206, "~r~[E]~w~ - Open Evidence Locker")
                if IsControlJustReleased(0, 86) then
                    Citizen.Wait(1)
                    TriggerEvent("server-inventory-open", "1", "evidenceLocker-1")
                end
            end
        end

        if #(vector3(-1545.632,  137.983, 55.653) - pos) <= 0.8 then
            found = true
			if job == 'mechanic' or job == 'offmechanic' then
                DrawText3D(-1545.632,  137.983, 55.653, "~r~[E]~w~ - Stash")
                if IsControlJustReleased(0, 86) then
                    Citizen.Wait(1)
                    TriggerEvent("server-inventory-open", "1", "house-929")
                end
            end
        end



        if #(vector3(1391.508, 1158.898, 114.3335) - pos) <= 0.8 then
            found = true
			if job == 'cartel' then
                DrawText3D(1391.508, 1158.898, 114.3335, "~r~[E]~w~ - Stash")
                if IsControlJustReleased(0, 86) then
                    Citizen.Wait(1)
                    TriggerEvent("server-inventory-open", "1", "stash5-cartelstash")
                end
            end
        end


        if #(vector3(1174.67, 2635.94,37.76) - pos) <= 1.2 then
            found = true
			if job == 'mechanic' then
                DrawText3D(1174.67, 2635.94,37.76, "[E] - Mechanic Craft")
                if IsControlJustReleased(0, 86) then
                    TriggerEvent("server-inventory-open", "55", "Craft");
                end
            end
        end

        if #(vector3(-1172.252,-1572.145,4.664) - pos) <= 1.2 then
            found = true
            DrawText3D(-1172.252,-1572.145,4.664, "[E] - Open Shop")
            if IsControlJustReleased(0, 86) then
                TriggerEvent("server-inventory-open", "420", "Shop");
            end
        end
        if found then
            Citizen.Wait(0)
        else
            Citizen.Wait(1000)
        end
        found = false
    end
end)

RegisterCommand('inventory', function(source, args, raw)
    if not isDisabled then
        TriggerEvent("OpenInv")
    else
        exports['mythic_notify']:SendAlert('error', 'Currently performing action!')
    end
end, true)

RegisterKeyMapping('inventory', 'Opens Inventory', 'keyboard', 'F2')

RegisterNetEvent('ffrp:playerBecameJob')
AddEventHandler('ffrp:playerBecameJob', function(jobpassed)
    job = jobpassed.name
end)

RegisterNetEvent('ffrp-inventory:DisableInventory')
AddEventHandler('ffrp-inventory:DisableInventory', function(toggle)
    isDisabled = toggle
end)