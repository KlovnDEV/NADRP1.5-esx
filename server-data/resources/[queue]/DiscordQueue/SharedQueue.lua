Queue = {};
Queue.Players = {}
Queue.Messages = {}
Queue.SortedIndexes = {}
Queue.Ranks = {}
Queue.Timer = {}
offset = 0;
debugg = Config.Debug;

function debug(message)
    if debugg then 
        print(message);
    end
end

function Queue:AddPlayer(user) 
    debug("[DiscordQueue:AddPlayer] Function triggered");
    local ids = ExtractIdentifiers(user);
    local disc = ids.discord;
    local license = ids.license;
    debug("[DiscordQueue:AddPlayer] Discord is: " .. disc);
    debug("[DiscordQueue:AddPlayer] License is " .. license);
    local name = nil;
    local discordName = nil;
    if (user ~= nil) then 
        name = GetPlayerName(user);
        discordName = exports.Badger_Discord_API:GetDiscordName(user);
        if (discordName == nil or discordName == false) then 
            discordName = "N/A";
            debug("[DiscordQueue:AddPlayer] Discord Name is N/A");
        end
    end
    offset = offset + 1;
    if (disc ~= nil) then 
        debug("[DiscordQueue:AddPlayer] Discord is not nil");
        local roles = exports.Badger_Discord_API:GetDiscordRoles(user)
        local lastRolePrio = 99999999999999999999;
        local msg = nil;
        local theirPrios = {};
		local msgs = {};
        local rank = Config.Default_Role_Name;
        if not (roles == false) then
            for i = 1, #roles do
                for roleID, list in pairs(Config.Rankings) do
                    local rolePrio = list[1];
                    if exports.Badger_Discord_API:CheckEqual(roles[i], roleID) then
                        -- Return the index back to the Client script
                        table.insert(theirPrios, rolePrio);
                        if lastRolePrio > tonumber(rolePrio) then 
                            msg = list[2];
                            rank = list[3];
                            lastRolePrio = rolePrio;
                        end 
                    end
                end
            end
        else 
            -- They have no roles for this Discord, default prio
            Queue.Players[license] = tonumber(Config.Default_Prio) + offset;
			Queue.Messages[license] = Config.Displays.Messages.MSG_CONNECTING;
        end
        if #theirPrios > 0 then 
            table.sort(theirPrios);
            Queue.Players[license] = tonumber(theirPrios[1])  + offset;
        end 
        if msg ~= nil then 
            Queue.Messages[license] = msg;
        end
        if Queue.Players[license] == nil then 
			Queue.Players[license] = tonumber(Config.Default_Prio) + offset;
		end
		if Queue.Messages[license] == nil then 
			Queue.Messages[license] = Config.Displays.Messages.MSG_CONNECTING;
		end
        Queue.Timer[license] = Config.Timer;
        Queue.SortedIndexes = getKeysSortedByValue(Queue.Players, function(a, b) return a < b end);
        if user ~= nil then 
            -- Set up their rank info 
            Queue.Ranks[license] = { ['username'] = name, ['rank'] = rank, ['discordName'] = discordName };
            debug("[DiscordQueue:AddPlayer] Player has been added to queue...");
        else 
            -- Pop them from the queue
            Queue:RemovePlayer(license);
            debug("[DiscordQueue:AddPlayer] Player has been popped from the queue due to a nil user ID...");
        end
        return true;
    else 
        -- No discord, give them default
        Queue.Players[license] = tonumber(Config.Default_Prio) + offset;
        Queue.Messages[license] = Config.Displays.Messages.MSG_CONNECTING;
        Queue.Timer[license] = Config.Timer;
        Queue.SortedIndexes = getKeysSortedByValue(Queue.Players, function(a, b) return a < b end);
        if user ~= nil then 
            -- Set up their rank info 
            Queue.Ranks[license] = { ['username'] = name, ['rank'] = rank, ['discordName'] = discordName };
            debug("[DiscordQueue:AddPlayer] Player has been added to queue...");
        else 
            -- Pop them from the queue
            Queue:RemovePlayer(license);
            debug("[DiscordQueue:AddPlayer] Player has been popped from the queue due to a nil user ID...");
        end
        return true;
    end
    return false; -- Didn't set them up, something went wrong
end

function Queue:GetAhead(num)
    local ahead = {};
    local count = 0;
    for i = 1, #Queue.SortedIndexes do 
        if count < num then 
            local license = Queue.SortedIndexes[i];
            local rank = Queue.Ranks[license].rank;
            local username = Queue.Ranks[license].username;
            local discordName = Queue.Ranks[license].discordName;
            table.insert(ahead, { ['username'] = username, ['rank'] = rank, ['discordName'] = discordName});
        end
        count = count + 1;
    end
    return ahead;
end

function Queue:IsWhitelisted(user)
	local ids = ExtractIdentifiers(user);
    local disc = ids.discord;
    local license = ids.license;

	if disc then
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

function Queue:CheckQueue(license)
    --Queue.Timer[license] = Config.Timer;
    --Queue:RemoveGhostUsers();
    debug("[Queue:CheckQueue] Checking your license `" .. license .. "` to `" .. Queue.SortedIndexes[1] .. "`");
    if tostring(Queue.SortedIndexes[1]) == tostring(license) then 
        return true;
    end
    return false
end

function Queue:RemoveGhostUsers()
    for license, _ in pairs(Queue.Players) do 
        local exists = true;
        for license, time in pairs(Queue.Timer) do 
            if time <= 0 then 
                exists = false;
            end
        end
        if not exists then 
            Queue:RemovePlayer(license);
        else 
            Queue.Timer[license] = Queue.Timer[license] - 1;
        end
    end
end

function Queue:GetMessage(license)
    local msg = Config.Displays.Messages.MSG_CONNECTING;
	if (Queue.Messages[license] ~= nil) then 
		return Queue.Messages[license];
	else 
		return msg;
	end
end

function Queue:GetQueueNum(license)
    local count = 0;
    for i = 1, #Queue.SortedIndexes do
        local lic = Queue.SortedIndexes[i]; 
        count = count + 1;
        if (tostring(lic) == tostring(license)) then 
            return count;
        end
    end
    return count;
end

function Queue:Contains(license)
    if Queue.Players[license] ~= nil then 
        return true;
    end
    return false;
end

function Queue:GetMax()
    local count = 0;
    for discord, data in pairs(Queue.Players) do
        count = count + 1;
    end
    return count;
end

function Queue:RemovePlayer(license)
    Queue.Players[license] = nil;
    Queue.Messages[license] = nil;
    Queue.Ranks[license] = nil;
    Queue.SortedIndexes = getKeysSortedByValue(Queue.Players, function(a, b) return a < b end);
    debug("[DiscordQueue:RemovePlayer] Player has been removed from queue...");
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

    return identifiers
end

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