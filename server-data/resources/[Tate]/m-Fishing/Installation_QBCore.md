######################
#  INSTALL - QBCORE  #
######################

# Required
- qb-core/shared/items.lua
```
	-- Fishing rods
	['cananivel1'] 					= {['name'] = 'cananivel1', 			['label'] = 'Fishingrod Nivel 1', 		['weight'] = 1000, ['type'] = 'item', ['image'] = 'cananivel1.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['cananivel2'] 					= {['name'] = 'cananivel2', 			['label'] = 'Fishingrod Nivel 2', 		['weight'] = 1000, ['type'] = 'item', ['image'] = 'cananivel2.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['cananivel3'] 					= {['name'] = 'cananivel3', 			['label'] = 'Fishingrod Nivel 3', 		['weight'] = 1000, ['type'] = 'item', ['image'] = 'cananivel3.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['cananivel4'] 					= {['name'] = 'cananivel4', 			['label'] = 'Fishingrod Nivel 4', 		['weight'] = 1000, ['type'] = 'item', ['image'] = 'cananivel4.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['cananivel5'] 					= {['name'] = 'cananivel5', 			['label'] = 'Fishingrod Nivel 5', 		['weight'] = 1000, ['type'] = 'item', ['image'] = 'cananivel5.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},

	-- Regular Fish
	['cavala'] 			     	 	= {['name'] = 'cavala', 				['label'] = 'Mackerel',            		['weight'] = 25,      ['type'] = 'item',      	['image'] = 'cavala.png',         		['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = ''},
	['bacalhau'] 			     	= {['name'] = 'bacalhau', 				['label'] = 'Cod',            		['weight'] = 25,      ['type'] = 'item',      	['image'] = 'bacalhau.png',         	['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = ''},
	['robalo'] 			     	 	= {['name'] = 'robalo', 				['label'] = 'Sea Bass',            		['weight'] = 25,      ['type'] = 'item',      	['image'] = 'robalo.png',         		['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = ''},
	['linguado'] 			     	= {['name'] = 'linguado', 				['label'] = 'Sole',            		['weight'] = 25,      ['type'] = 'item',      	['image'] = 'linguado.png',         	['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = ''},
	['raia'] 			 		 	= {['name'] = 'raia', 					['label'] = 'Stingray',                     ['weight'] = 25,      ['type'] = 'item',      	['image'] = 'raia.png',                 ['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = ''},
	['salmao'] 			 		 	= {['name'] = 'salmao', 				['label'] = 'Salmon',                   ['weight'] = 25,      ['type'] = 'item',     	['image'] = 'salmao.png',               ['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = ''},
	['atum'] 			 		 	= {['name'] = 'atum', 					['label'] = 'Tuna fish',                   	['weight'] = 25,      ['type'] = 'item',     	['image'] = 'atum.png',               	['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = ''},
	['sardinha'] 			 		= {['name'] = 'sardinha', 				['label'] = 'Sardine',                 ['weight'] = 25,      ['type'] = 'item',     	['image'] = 'sardinha.png',             ['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = ''},
	['peixegato'] 			 		= {['name'] = 'peixegato', 				['label'] = 'Catfish',               ['weight'] = 25,      ['type'] = 'item',     	['image'] = 'peixegato.png',            ['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = ''},
	['tamboril'] 			 		= {['name'] = 'tamboril', 				['label'] = 'Monkfish',               ['weight'] = 25,      ['type'] = 'item',     	['image'] = 'tamboril.png',             	['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = ''},

	-- Trash Items
	['fishingtin'] 			 	 	= {['name'] = 'fishingtin', 			['label'] = 'Fishing Tin', 				['weight'] = 2500, 		['type'] = 'item', 		['image'] = 'fishingtin.png', 			['unique'] = false,    ['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['description'] = 'Fishing Tin'},	
	['fishingboot'] 			 	= {['name'] = 'fishingboot', 			['label'] = 'Fishing Boot', 			['weight'] = 2500, 		['type'] = 'item', 		['image'] = 'fishingboot.png', 			['unique'] = false,    ['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['description'] = 'Fishing Boot'},	
	
	-- Exotic Fish
	['golfinho'] 			 	 	= {['name'] = 'golfinho', 				['label'] = 'Dolphin', 					['weight'] = 15000, 	['type'] = 'item', 		['image'] = 'golfinho.png', 			['unique'] = false, 	   ['useable'] = false, 	['shouldClose'] = false,   	['combinable'] = nil,   ['description'] = ''},	
	['tubaraotigre'] 			 	= {['name'] = 'tubaraotigre', 			['label'] = 'Tiger shark',          	['weight'] = 5000,      ['type'] = 'item',      ['image'] = 'tubaraotigre.png',       	['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,   	['combinable'] = nil,   ['description'] = ''},
	['tubaraomartelo'] 			 	= {['name'] = 'tubaraomartelo', 		['label'] = 'Hammer shark',         	['weight'] = 5000,      ['type'] = 'item',      ['image'] = 'tubaraomartelo.png',       ['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,   	['combinable'] = nil,   ['description'] = ''},
	['baleia'] 			     	 	= {['name'] = 'baleia', 				['label'] = 'Whale',          			['weight'] = 5000,      ['type'] = 'item',      ['image'] = 'baleia.png',       		['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,   	['combinable'] = nil,   ['description'] = ''},
	
	-- Gear
	['fishbait'] 			     	= {['name'] = 'fishbait', 				['label'] = 'Fish Bait', 				['weight'] = 400, 		['type'] = 'item', 		['image'] = 'fishbait.png', 			['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   	['combinable'] = nil,   ['description'] = 'Fishing bait'},
	['fishbaitilegal'] 			    = {['name'] = 'fishbaitilegal', 		['label'] = 'Fish Bait Ilegal', 		['weight'] = 400, 		['type'] = 'item', 		['image'] = 'fishbaitilegal.png', 			['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   	['combinable'] = nil,   ['description'] = 'Fishing bait'},
	['anchor'] 			 	 		= {['name'] = 'anchor', 				['label'] = 'Boat Anchor', 				['weight'] = 2500, 		['type'] = 'item', 		['image'] = 'anchor.png', 				['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   	['combinable'] = nil,   ['description'] = 'Boat Anchor'},	
	['fishicebox'] 			 	 	= {['name'] = 'fishicebox', 			['label'] = 'Fishing Ice Chest', 		['weight'] = 2500, 		['type'] = 'item', 		['image'] = 'fishicebox.png', 			['unique'] = true,     ['useable'] = true, 	   ['shouldClose'] = true,	   	['combinable'] = nil,   ['description'] = 'Ice Box to store all of your fish'},	
	
	-- Rewards
	['fishingloot'] 			 	= {['name'] = 'fishingloot', 			['label'] = 'Metal Box', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'fishingloot.png', 			['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   	['combinable'] = nil,   ['description'] = 'Seems to be a corroded from the salt water, Should be easy to open'},	
	['fishinglootbig'] 			 	= {['name'] = 'fishinglootbig', 		['label'] = 'Treasure Chest', 			['weight'] = 2500, 		['type'] = 'item', 		['image'] = 'fishinglootbig.png', 		['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   	['combinable'] = nil,   ['description'] = 'The lock seems to be intact, Might need a key'},	
	['fishingkey'] 			 	 	= {['name'] = 'fishingkey', 			['label'] = 'Corroded Key', 			['weight'] = 100, 		['type'] = 'item', 		['image'] = 'fishingkey.png', 		    ['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   	['combinable'] = nil,   ['description'] = 'A weathered key that looks usefull'},	

	-- Cooking fish
	['bacalhaucozido'] 			 	= {['name'] = 'bacalhaucozido', 		['label'] = 'Cooked Cod', 			['weight'] = 20, 		['type'] = 'item', 		['image'] = 'bacalhaucozido.png', 		    ['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   	['combinable'] = nil,   ['description'] = ''},	
	['cavalacozida'] 			 	= {['name'] = 'cavalacozida', 			['label'] = 'Cooked Mackerel', 			['weight'] = 20, 		['type'] = 'item', 		['image'] = 'cavalacozida.png', 		    ['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   	['combinable'] = nil,   ['description'] = ''},	
	['salmaocozido'] 			 	= {['name'] = 'salmaocozido', 			['label'] = 'Cooked Salmon', 			['weight'] = 20, 		['type'] = 'item', 		['image'] = 'salmaocozido.png', 		    ['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   	['combinable'] = nil,   ['description'] = ''},	
	['sardinhacozida'] 			 	= {['name'] = 'sardinhacozida', 		['label'] = 'Cooked Sardines', 			['weight'] = 20, 		['type'] = 'item', 		['image'] = 'sardinhacozida.png', 		    ['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   	['combinable'] = nil,   ['description'] = ''},	
	
	-- Campfire
	['fogueira'] 			 		= {['name'] = 'fogueira', 				['label'] = 'Campfire', 				['weight'] = 20, 		['type'] = 'item', 		['image'] = 'fogueira.png', 		    ['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   	['combinable'] = nil,   ['description'] = ''},	
	['rededepescanivel1'] 			= {['name'] = 'rededepescanivel1', 		['label'] = 'Fishing net Nivel 1', 			['weight'] = 20, 		['type'] = 'item', 		['image'] = 'rededepescanivel1.png', 		    ['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   	['combinable'] = nil,   ['description'] = ''},	
	['rededepescanivel2'] 			= {['name'] = 'rededepescanivel2', 		['label'] = 'Fishing net Nivel 2', 			['weight'] = 20, 		['type'] = 'item', 		['image'] = 'rededepescanivel2.png', 		    ['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   	['combinable'] = nil,   ['description'] = ''},	
	['rededepescanivel3'] 			= {['name'] = 'rededepescanivel3', 		['label'] = 'Fishing net Nivel 3', 			['weight'] = 20, 		['type'] = 'item', 		['image'] = 'rededepescanivel3.png', 		    ['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   	['combinable'] = nil,   ['description'] = ''},	
	['rededepescanivel4'] 			= {['name'] = 'rededepescanivel4', 		['label'] = 'Fishing net Nivel 4', 			['weight'] = 20, 		['type'] = 'item', 		['image'] = 'rededepescanivel4.png', 		    ['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   	['combinable'] = nil,   ['description'] = ''},	
	['rededepescanivel5'] 			= {['name'] = 'rededepescanivel5', 		['label'] = 'Fishing net Nivel 5', 			['weight'] = 20, 		['type'] = 'item', 		['image'] = 'rededepescanivel5.png', 		    ['unique'] = false,    ['useable'] = true, 	   ['shouldClose'] = true,	   	['combinable'] = nil,   ['description'] = ''},	
	

 ``` 

# Required
- Inside**qb-smallresources/config.lua** (search for `ConsumeablesEat = {` and add this)
```lua
		["bacalhaucozido"] = math.random(35, 50),
	    ["cavalacozida"] = math.random(35, 50),
	    ["salmaocozido"] = math.random(35, 50),
	    ["sardinhacozida"] = math.random(35, 50),
```

- Inside **qb-inventory/server/main.lua** (around line 842 search for `elseif type == "stash" then` and replace) 
```lua 
	elseif type == "stash" then
		local indexstart, indexend = string.find(id, "FishingBox_") -- Default: "FishingBox_" or your Config.Stash.Name
		if indexstart and indexend then
			TriggerEvent("m-Fishing:server:saveFishingBox", source, id, Stashes[id].items, function(close)
				Stashes[id].isOpen = close
			end)
		else
			SaveStashItems(id, Stashes[id].items)
		end
```

- Inside **qb-inventory/server/main.lua** (search for `elseif QBCore.Shared.SplitStr(shopType, "_")[1] == "Itemshop" then` and add this to the line before)
```lua
		elseif itemData.name == 'fishicebox' then
         	local info = {
                boxid = math.random(111,999),
				boxOwner = Player.PlayerData.charinfo.firstname
            }
			Player.Functions.AddItem('fishicebox', 1, nil, info, {["quality"] = 100})
```

- Inside **qb-inventory/html/js/app.js** (search for `} else if (itemData.name == ` and add this)
```js
		} else if (itemData.name == "fishicebox") {
			$(".item-info-title").html('<p>' + itemData.label + ' ' + itemData.info.boxid + '</p>')
			$(".item-info-description").html('<p><strong>Box Owner: </strong><span>' + itemData.info.boxOwner + '</span></p> Ice Box to store all of your fish');
```