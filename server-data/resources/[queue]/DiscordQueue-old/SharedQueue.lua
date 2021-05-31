Queue = {}
Queue.Players = {}
Queue.PlayerInfo = {}
Queue.Sources = {};
Queue.SortedKeys = {}
Queue.Messages = {}
debugg = true;



function getKeysSortedByValue(tbl, sortFunction)
  local keys = {}
  for key in pairs(tbl) do
    table.insert(keys, key)
  end

  table.sort(keys, function(a, b)
    return sortFunction(tbl[a], tbl[b])
  end)

  return keys
end

function Queue:IsWhitelisted(user)
	local discordId = nil;
	local license = nil;

	for _, id in ipairs(GetPlayerIdentifiers(user)) do
	    if string.match(id, "discord:") then
	        discordId = string.gsub(id, "discord:", "")
	        --print("Found discord id: "..discordId)
	    end
	    if string.match(id, "license") then 
	    	license = id;
	    end
	end
	local identifierDiscord = discordId;

	if identifierDiscord then
		local roles = exports.Badger_Discord_API:GetDiscordRoles(user);
		if not (roles == false) then 
			for i = 1, #roles do 
				for roleID, list in pairs(Config.Rankings) do
					if exports.Badger_Discord_API:CheckEqual(roles[i], roleID) then 
						return true;
					end
				end
			end
		end
	end
	return false;
end

queueIndex = 0;
function Queue:SetupPriority(user, lic) 
	local discordId = nil;
	local license = lic;

	for _, id in ipairs(GetPlayerIdentifiers(user)) do
	    if string.match(id, "discord:") then
	        discordId = string.gsub(id, "discord:", "")
	        --print("Found discord id: "..discordId)
	    end
	end
	if license ~= nil then 
		-- Reset their account
		Queue.Players[license] = nil;
		local identifierDiscord = discordId;
		queueIndex = queueIndex + 1;
		local theirPrios = {};
		local msgs = {};
		local roleName = Config.Default_Role_Name;
		if identifierDiscord and (Queue.Players[license] == nil) then
			local roles = exports.Badger_Discord_API:GetDiscordRoles(user)
			local lastRolePrio = 99999999999999999999;
			local msg = nil;
			if not (roles == false) then
				for i = 1, #roles do
					for roleID, list in pairs(Config.Rankings) do
						local rolePrio = list[1];
						if exports.Badger_Discord_API:CheckEqual(roles[i], roleID) then
							-- Return the index back to the Client script
							table.insert(theirPrios, rolePrio);
							if lastRolePrio > tonumber(rolePrio) then 
								msg = list[2];
								lastRolePrio = rolePrio;
								roleName = list[3]; -- Only for AdaptiveCards version
							end 
						end
					end
				end
			else
				Queue.Players[license] = tonumber(Config.Default_Prio) + queueIndex;;
				Queue.Messages[license] = Config.Displays.Messages.MSG_CONNECTING;
			end
			if #theirPrios > 0 then 
				table.sort(theirPrios);
				Queue.Players[license] = tonumber(theirPrios[1])  + queueIndex;
			end 
			if msg ~= nil then 
				Queue.Messages[license] = msg;
			end
		elseif identifierDiscord == nil then
			Queue.Players[license] = tonumber(Config.Default_Prio) + queueIndex;
			Queue.Messages[license] = Config.Displays.Messages.MSG_CONNECTING;
		end
		if Queue.Players[license] == nil then 
			Queue.Players[license] = tonumber(Config.Default_Prio) + queueIndex;
		end
		if Queue.Messages[license] == nil then 
			Queue.Messages[license] = Config.Displays.Messages.MSG_CONNECTING;
		end
		local SortedKeys = getKeysSortedByValue(Queue.Players, function(a, b) return a < b end)
		Queue.SortedKeys = SortedKeys;
		local username = GetPlayerName(user);
		if identifierDiscord then 
			local discordName = exports.Badger_Discord_API:GetDiscordName(user);
			Queue.PlayerInfo[license] = { username, Queue.Players[license], roleName, discordName};
		else 
			Queue.PlayerInfo[license] = { username, Queue.Players[license], roleName };
		end 
		Queue.Sources[license] = {user, username};
	else -- License == nil, don't run
		if debugg then 
			print('[Bad-DiscordQueue] USER LICENSE IS NIL (' .. GetPlayerName(user) .. ')');
		end
	end
end
function GetMessage(user)
	local license = ExtractIdentifiers(user).license;
	local msg = Config.Displays.Messages.MSG_CONNECTING;
	if (Queue.Messages[license] ~= nil) then 
		return Queue.Messages[license];
	else 
		return msg;
	end
end

function Queue:IsSetUp(lic)
	local license = lic;
	if license ~= nil then 
		if (Queue.Players[license] ~= nil) then 
			return true;
		end 
	end
	return false;
end

function Queue:CheckGhostUsers()
	-- Check for ghost users first
	local toRemove = {};
	local count = 1;
	for k, v in pairs(Queue.SortedKeys) do 
		local license = Queue.SortedKeys[count];
		if (Queue.Sources[license] ~= nil) then 
			if tostring( GetPlayerName(Queue.Sources[license][1]) ) ~= tostring( Queue.Sources[license][2] ) then 
				-- Not valid
				table.insert(toRemove, license);
			end
		else 
			-- Invalid
			table.insert(toRemove, license);
		end
		count = count + 1;
	end
	for i = 1, #toRemove do 
		Queue:PopLicense(toRemove[i]);
	end
end

function Queue:CheckQueue(user, currentConnectors, slots) 
	local discordId = nil;
	local license = ExtractIdentifiers(user).license;
	if (license ~= nil) then 
		if (tostring(Queue.SortedKeys[1]) == tostring(license) ) then 
			return true; -- They can login 
		end
	end
	-- Added 12/10/20
	--[[]]-- 120 - 72 - 30 = 18
	local openSlots = (slots - GetNumPlayerIndices()) - currentConnectors;
	if (license ~= nil) then
		local count = 1;
		-- Check Queue 
		for k, v in pairs(Queue.SortedKeys) do 
			if Queue.SortedKeys[count] == license and count <= openSlots then 
				return true;
			end
			count = count + 1;
		end
	end
	--[[]]--
	-- End add
	return false; -- Still waiting in queue, not next in line 
end 

function Queue:GetMax()
	local cout = 0;
	for identifier, prio in pairs(Queue.Players) do 
		cout = cout + 1;
	end
	return cout;
end

function Queue:GetQueueNum(user)
	local license = ExtractIdentifiers(user).license;
	local cout = 1;
	for i = 1, #Queue.SortedKeys do 
		local identifier = Queue.SortedKeys[i];
		if tostring(identifier) == tostring(license) then 
			return cout;
		end
		cout = cout + 1;
	end
	if debugg then 
		local name = GetPlayerName(user)
		if name ~= nil then
			print('[Bad-DiscordQueue] USER WAS NOT IN SortedKeys (' .. GetPlayerName(user) .. ')');
		else
			print('[Bad-DiscordQueue] USER WAS NOT IN SortedKeys (Name not found)');
		end
	end
	return cout;
end

function Queue:PopLicense(license)
	-- Pop them off the Queue 
	local tempQueue = {};
	local lic = license;
	--[[
	for id, prio in pairs(Queue.Players) do 
		if tostring(id) ~= tostring(lic) then 
			tempQueue[id] = prio;
		end
	end
	]]--
	if debugg then 
		print("[DEBUG] (Queue:PopLicense) BEFORE POP = GetMax(): " .. tostring(Queue:GetMax() ) );
	end
	Queue.Sources[lic] = nil;
	Queue.Messages[lic] = nil;
	Queue.Players[lic] = nil;
	--Queue.Players = tempQueue;
	Queue.PlayerInfo[lic] = nil;
	if debugg then 
		print("[DEBUG] (Queue:PopLicense) " .. tostring(lic) .. " has been POPPED from QUEUE")
		print("[DEBUG] (Queue:PopLicense) GetMax(): " .. tostring(Queue:GetMax() ) );
    end
	local SortedKeys = getKeysSortedByValue(Queue.Players, function(a, b) return a < b end)
    Queue.SortedKeys = SortedKeys;
end

function Queue:GetUserAt(index)
	local licenseKey = Queue.SortedKeys[index];
	if licenseKey ~= nil and Queue.PlayerInfo[licenseKey] ~= nil then 
		local playerInfo = Queue.PlayerInfo[licenseKey];
		local name = playerInfo[1];
		local roleName = playerInfo[3];
		if #playerInfo == 4 then 
			local discordName = playerInfo[4] 
			return {name, roleName, discordName};
		else 
			return {name, roleName};
		end
	end
	return false; -- None there 
end

function Queue:Pop(user)
	-- Pop them off the Queue 
	local lic = ExtractIdentifiers(user).license;
	local tempQueue = {};
	--[[
	for id, prio in pairs(Queue.Players) do 
		if tostring(id) ~= tostring(lic) then 
			tempQueue[id] = prio;
		end
	end
	]]--
	if debugg then 
		print("[DEBUG] (Queue:PopLicense) BEFORE POP = GetMax(): " .. tostring(Queue:GetMax() ) );
    end
	Queue.Messages[lic] = nil;
	Queue.Players[lic] = nil;
	Queue.Sources[lic] = nil;
	--Queue.Players = tempQueue;
	Queue.PlayerInfo[lic] = nil;
	local SortedKeys = getKeysSortedByValue(Queue.Players, function(a, b) return a < b end)
    Queue.SortedKeys = SortedKeys;
    if debugg then 
		print("[DEBUG] (Queue:Pop) " .. GetPlayerName(user) .. " has been POPPED from QUEUE")
		print("[DEBUG] (Queue:Pop) GetMax(): " .. tostring(Queue:GetMax() ) );
    end
end

function ExtractIdentifiers(src)
	local identifiers = {
		steam = "",
		ip = "",
		discord = "",
		license = "",
		xbl = "",
		live = ""
	}
  
	--Loop over all identifiers
	for i = 0, GetNumPlayerIdentifiers(src) - 1 do
		local id = GetPlayerIdentifier(src, i)
  
		--Convert it to a nice table.
		if string.find(id, "steam") then
			identifiers.steam = id
		elseif string.find(id, "ip") then
			identifiers.ip = id
		elseif string.find(id, "discord") then
			identifiers.discord = id
		elseif string.find(id, "license") then
			identifiers.license = id
		elseif string.find(id, "xbl") then
			identifiers.xbl = id
		elseif string.find(id, "live") then
			identifiers.live = id
		end
	end
end