ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

local function checkExistenceClothes(cid, cb)
   -- MySQL.Async.fetchAll("SELECT cid FROM character_current WHERE cid = @cid LIMIT 1;", {["cid"] = cid}, function(result)
        MySQL.Async.fetchAll('SELECT cid FROM character_current WHERE cid = @cid LIMIT 1', {['@cid'] = cid}, function(result)
        local exists = result and result[1] and true or false
        cb(exists)
    end)
end

local function checkExistenceFace(cid, cb)
    MySQL.Async.fetchAll('SELECT identifier FROM character_face WHERE identifier = @identifier LIMIT 1', {['@identifier'] = cid}, function(result)
        local exists = result and result[1] and true or false
        --print(json.encode(result))
        cb(exists)
    end)
end

RegisterServerEvent("ffrp-clothes:insert_character_current")
AddEventHandler("ffrp-clothes:insert_character_current",function(data)
    if not data then return end
    local src = source
    local user = ESX.GetPlayerFromId(source)
    local characterId = user.identifier
    if not characterId then return end

    checkExistenceClothes(characterId, function(exists)
        local values = {
            ["@identifier"] = characterId,
            ["@model"] = json.encode(data.model),
            ["@drawables"] = json.encode(data.drawables),
            ["@props"] = json.encode(data.props),
            ["@drawtextures"] = json.encode(data.drawtextures),
            ["@proptextures"] = json.encode(data.proptextures),
        }

        if not exists then
            local cols = "cid, model, drawables, props, drawtextures, proptextures"
            local vals = "@identifier, @model, @drawables, @props, @drawtextures, @proptextures"
            local set = "model = @model,drawables = @drawables,props = @props,drawtextures = @drawtextures,proptextures = @proptextures"
            MySQL.Async.execute("INSERT INTO character_current ("..cols..") VALUES ("..vals..")", values, function()
            end)
            return
        end
        local set = "model = @model,drawables = @drawables,props = @props,drawtextures = @drawtextures,proptextures = @proptextures"
        MySQL.Async.execute("UPDATE character_current SET "..set.." WHERE cid = @identifier", values)
    end)
end)

RegisterServerEvent("ffrp-clothes:insert_character_skin")
AddEventHandler("ffrp-clothes:insert_character_skin",function(data)
    if not data then return end
    local src = source
    local user = ESX.GetPlayerFromId(source)
    local characterId = user.identifier
    if not characterId then return end
    checkExistenceClothes(characterId, function(exists)
        MySQL.Async.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
            ['@skin'] = json.encode(data.drawables)..json.encode(data.props)..json.encode(data.drawtextures)..json.encode(data.proptextures),
            ['@identifier'] =characterId
        })
    end)
end)

RegisterServerEvent("ffrp-clothes:insert_character_face")
AddEventHandler("ffrp-clothes:insert_character_face",function(data)
    if not data then return end
    local src = source
    local user = ESX.GetPlayerFromId(source)
    local characterId = user.identifier
    if not characterId then return end
    checkExistenceFace(characterId, function(exists)
        local values = {
            ["identifier"] = characterId,
            ["hairColor"] = json.encode(data.hairColor),
            ["headBlend"] = json.encode(data.headBlend),
            ["headOverlay"] = json.encode(data.headOverlay),
            ["headStructure"] = json.encode(data.headStructure),
        }

        if not exists then
            local cols = "identifier, hairColor, headBlend, headOverlay, headStructure"
            local vals = "@identifier, @hairColor, @headBlend, @headOverlay, @headStructure"
            local set = "hairColor = @hairColor,headBlend = @headBlend,headOverlay = @headOverlay,headStructure = @headStructure"
            --MySQL.Async.execute("UPDATE character_face SET "..set.." WHERE identifier = @identifier", values)
            MySQL.Async.execute("INSERT INTO character_face ("..cols..") VALUES ("..vals..")", values, function()
            end)
            return
        end

        local set = "hairColor = @hairColor,headBlend = @headBlend,headOverlay = @headOverlay,headStructure = @headStructure"
        MySQL.Async.execute("UPDATE character_face SET "..set.." WHERE identifier = @identifier", values)
    end)
end)

RegisterServerEvent("ffrp-clothes:get_character_face")
AddEventHandler("ffrp-clothes:get_character_face",function(pSrc)
    local src = (not pSrc and source or pSrc)
    local user = ESX.GetPlayerFromId(src)
    local characterId = user.identifier

    if not characterId then return end

    MySQL.Async.fetchAll("SELECT cc.model, cf.hairColor, cf.headBlend, cf.headOverlay, cf.headStructure FROM character_face cf INNER JOIN character_current cc on cc.cid = cf.identifier WHERE cf.identifier = @identifier", {['identifier'] = characterId}, function(result)
        if (result ~= nil and result[1] ~= nil) then
            local temp_data = {
                hairColor = json.decode(result[1].hairColor),
                headBlend = json.decode(result[1].headBlend),
                headOverlay = json.decode(result[1].headOverlay),
                headStructure = json.decode(result[1].headStructure),
            }
            local model = tonumber(result[1].model)
            if model == 1885233650 or model == -1667301416 then
                TriggerClientEvent("ffrp-clothes:setpedfeatures", src, temp_data)
            end
        else
            TriggerClientEvent("ffrp-clothes:setpedfeatures", src, false)
        end
	end)
end)

RegisterServerEvent("ffrp-clothes:get_character_current")
AddEventHandler("ffrp-clothes:get_character_current",function(pSrc)
    local src = (not pSrc and source or pSrc)
    local user = ESX.GetPlayerFromId(source)
    local characterId = user.identifier

    if not characterId then return end

    MySQL.Async.fetchAll('SELECT model,drawables,props,drawtextures,proptextures FROM character_current WHERE cid = @identifier', {['@identifier'] = characterId}, function(result)
        local temp_data = {
            model = tonumber(result[1].model),
            drawables = json.decode(result[1].drawables),
            props = json.decode(result[1].props),
            drawtextures = json.decode(result[1].drawtextures),
            proptextures = json.decode(result[1].proptextures),
        }
        TriggerClientEvent("ffrp-clothes:setclothes", src, temp_data,0)
	end)
end)

RegisterServerEvent("ffrp-clothes:retrieve_tats")
AddEventHandler("ffrp-clothes:retrieve_tats", function(pSrc)
    local src = (not pSrc and source or pSrc)
    local user = ESX.GetPlayerFromId(src)
    local cid = user.identifier

    MySQL.Async.fetchAll("SELECT * FROM playerstattoos WHERE identifier = @identifier", {['identifier'] = cid}, function(result)
        if(#result == 1) then
			TriggerClientEvent("ffrp-clothes:settattoos", src, json.decode(result[1].tattoos))
        else
			local tattooValue = "{}"
            MySQL.Async.execute("INSERT INTO playerstattoos (identifier, tattoos) VALUES  (@identifier, @tattoo)", {['@identifier'] = cid, ['@tattoo'] = tattooValue})
            TriggerClientEvent("ffrp-clothes:settattoos", src, {})
		end
	end)
end)

RegisterServerEvent("ffrp-clothes:set_tats")
AddEventHandler("ffrp-clothes:set_tats", function(tattoosList)
	local src = source
	local user = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('UPDATE playerstattoos SET tattoos = @tattoos WHERE identifier = @identifier', {
		['@tattoos'] = json.encode(tattoosList),
		['@identifier'] = user.identifier
	})
end)

RegisterServerEvent("ffrp-clothes:get_outfit")
AddEventHandler("ffrp-clothes:get_outfit",function(slot)
    if not slot then return end
    local src = source

    local user = ESX.GetPlayerFromId(source)
    local characterId = user.identifier

    if not characterId then return end

    MySQL.Async.fetchAll("SELECT * FROM character_outfits WHERE cid = @cid and slot = @slot", {
        ['@cid'] = characterId,
        ['@slot'] = slot
    }, function(result)
        if result and result[1] then
            if result[1].model == nil then
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Can not use'})
                return
            end

            local data = {
                model = result[1].model,
                drawables = json.decode(result[1].drawables),
                props = json.decode(result[1].props),
                drawtextures = json.decode(result[1].drawtextures),
                proptextures = json.decode(result[1].proptextures),
                hairColor = json.decode(result[1].hairColor)
            }

            TriggerClientEvent("ffrp-clothes:setclothes", src, data,0)
            local values = {
                ["@cid"] = characterId,
                ["@model"] = data.model,
                ["@drawables"] = json.encode(data.drawables),
                ["@props"] = json.encode(data.props),
                ["@drawtextures"] = json.encode(data.drawtextures),
                ["@proptextures"] = json.encode(data.proptextures),
            }

            local set = "model = @model, drawables = @drawables, props = @props,drawtextures = @drawtextures,proptextures = @proptextures"
            MySQL.Async.execute("UPDATE character_current SET "..set.." WHERE cid=@cid", values)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'No outfit on slot ' .. slot .. '.'})
            return
        end
	end)
end)

RegisterServerEvent("ffrp-clothes:set_outfit")
AddEventHandler("ffrp-clothes:set_outfit",function(slot, name, data)
    if not slot then return end
    local src = source

    local user = ESX.GetPlayerFromId(source)
    local characterId = user.identifier

    if not characterId then return end

    MySQL.Async.fetchAll("SELECT slot FROM character_outfits WHERE cid = @cid and slot = @slot", {
        ['@cid'] = characterId,
        ['@slot'] = slot
    }, function(result)
        if result and result[1] then
            local values = {
                ["@cid"] = characterId,
                ["@slot"] = slot,
                ["@name"] = name,
                ["@model"] = json.encode(data.model),
                ["@drawables"] = json.encode(data.drawables),
                ["@props"] = json.encode(data.props),
                ["@drawtextures"] = json.encode(data.drawtextures),
                ["@proptextures"] = json.encode(data.proptextures),
                ["@hairColor"] = json.encode(data.hairColor),
            }

            local set = "model = @model,name = @name,drawables = @drawables,props = @props,drawtextures = @drawtextures,proptextures = @proptextures,hairColor = @hairColor"
            MySQL.Async.execute("UPDATE character_outfits SET "..set.." WHERE cid = @cid and slot = @slot",values)
            TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Replaced outfit in slot ' .. slot})
        else
            local cols = "cid, model, name, slot, drawables, props, drawtextures, proptextures, hairColor"
            local vals = "@cid, @model, @name, @slot, @drawables, @props, @drawtextures, @proptextures, @hairColor"

            local values = {
                ["@cid"] = characterId,
                ["@name"] = name,
                ["@slot"] = slot,
                ["@model"] = data.model,
                ["@drawables"] = json.encode(data.drawables),
                ["@props"] = json.encode(data.props),
                ["@drawtextures"] = json.encode(data.drawtextures),
                ["@proptextures"] = json.encode(data.proptextures),
                ["@hairColor"] = json.encode(data.hairColor)
            }

            MySQL.Async.execute("INSERT INTO character_outfits ("..cols..") VALUES ("..vals..")", values, function()
            end)
            TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = name.. ' stored in slot ' .. slot .. "."})
        end
	end)
end)

RegisterServerEvent("ffrp-clothes:remove_outfit")
AddEventHandler("ffrp-clothes:remove_outfit",function(slot)

    local src = source
    local user = ESX.GetPlayerFromId(source)
    local cid = user.identifier
    local slot = slot

    if not cid then return end

    MySQL.Async.execute( "DELETE FROM character_outfits WHERE cid = @cid AND slot = @slot", { ['@cid'] = cid,  ["@slot"] = slot } )
    TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = ' Removed outfit in ' .. slot})
end)

RegisterServerEvent("ffrp-clothes:list_outfits")
AddEventHandler("ffrp-clothes:list_outfits",function()
    local src = source
    local user = ESX.GetPlayerFromId(source)
    local cid = user.identifier
    local slot = slot
    local name = name

    if not cid then return end

    MySQL.Async.fetchAll("SELECT slot, name FROM character_outfits WHERE cid = @cid", {['cid'] = cid}, function(skincheck)
    	TriggerClientEvent("hotel:list",src, skincheck)
	end)
end)

RegisterServerEvent("clothing:checkIfNew")
AddEventHandler("clothing:checkIfNew", function()
    local src = source
    local user = ESX.GetPlayerFromId(source)
    local cid = user.identifier
    local dateCreated = user:getCurrentCharacter()

    MySQL.Async.fetchAll("SELECT count(rank) whitelist FROM jobs_whitelist WHERE cid = @cid LIMIT 1", {
        ['@cid'] = cid
    }, function(isWhitelisted)
        exports.ghmattimysql:scalar("SELECT count(model) FROM character_current WHERE cid = @cid LIMIT 1", {
            ['@cid'] = cid
        }, function(result)
            local isService = false;
            if(isWhitelisted[1].whitelist >= 1) then isService = true end

            if result == 0 then
                MySQL.Async.fetchAll("select count(cid) assExist from (select cid  from character_current union select cid from users_clothes) a where cid =  @cid", {['@cid'] = cid}, function(clothingCheck)
                    local existsClothing = clothingCheck[1].assExist
                    TriggerClientEvent('ffrp-clothes:setclothes',src,{},existsClothing)
                end)
                return
            else
                TriggerEvent("ffrp-clothes:get_character_current", src)
            end
            TriggerClientEvent("ffrp-clothes:inService",src,isService)
    	end)
    end)
end)

RegisterServerEvent("clothing:checkMoney")
AddEventHandler("clothing:checkMoney", function(menu,askingPrice)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer ~= nil then
        if xPlayer.getMoney() >= askingPrice then
            xPlayer.removeMoney(askingPrice)
            TriggerClientEvent("ffrp-clothes:hasEnough",src,menu)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'You paid 100$'})
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'You dont have enough money!'})
        end
    end
end)