displayIndex = 1;
displays = Config.Displays.ConnectingLoop;
prefix = Config.Displays.Prefix;
hostname = GetConvar("sv_hostname")
slots = GetConvarInt('sv_maxclients', 32)

StopResource('hardcap')

AddEventHandler('onResourceStop', function(resource)
  if resource == GetCurrentResourceName() then
    if GetResourceState('hardcap') == 'stopped' then
      StartResource('hardcap')
    end
  end
end)

webhookURL = Config.Webhook;
function sendToDisc(title, message, footer)
	local embed = {}
	embed = {
		{
			["color"] = 65280, -- GREEN = 65280 --- RED = 16711680
			["title"] = "**".. title .."**",
			["description"] = "" .. message ..  "",
			["footer"] = {
				["text"] = footer,
			},
		}
	}
	-- Start
	-- TODO Input Webhook
	PerformHttpRequest(webhookURL, 
	function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
  -- END
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
function sendToDiscQueue(title, message, footer)
	local embed = {}
	embed = {
		{
			["color"] = 16711680, -- GREEN = 65280 --- RED = 16711680
			["title"] = "**".. title .."**",
			["description"] = "" .. message ..  "",
			["footer"] = {
				["text"] = footer,
			},
		}
	}
	-- Start
	-- TODO Input Webhook
	PerformHttpRequest(webhookURL, 
	function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
  -- END
end

Citizen.CreateThread(function()
  while true do 
    Wait((1000 * 30)); -- Every 30 seconds
    --print("sv_maxclients is set to: " .. tostring(slots));
    --print("Queue:GetMax() is set to: " .. tostring(Queue:GetMax())); 
    if Config.HostDisplayQueue then 
      if hostname ~= "default FXServer" and Queue:GetMax() > 0 then 
        SetConvar("sv_hostname", "[" .. Queue:GetMax() .. "/" .. (Queue:GetMax() + 1) .. "] " .. hostname);
        --print(prefix .. " Set server title: '" .. "[" .. "1" .. "/" .. (Queue:GetMax() + 1) .. "] " .. hostname .. "'")
      end
      if hostname ~= "default FXServer" and Queue:GetMax() == 0 then 
        SetConvar("sv_hostname", hostname);
        --print(prefix .. " Set server title: '" .. hostname .. "'")
      end
    end
  end
end)
notSet = true;
Citizen.CreateThread(function()
  while notSet do 
    if hostname == "default FXServer" then 
      hostname = GetConvar("sv_hostname");
    else 
      notSet = false;
    end
  end 
end)

function GetPlayerCount() 
  local cout = 0;
  for _, id in pairs(GetPlayers()) do 
    cout = cout + 1;
  end
  return cout;
end
cardColors = {['Red'] = 'Attention', ['Blue'] = 'Accent', ['Black'] = 'Dark', ['Yellow'] = 'Warning', ['White'] = 'Light', ['Green'] = 'Good', ['Gray'] = 'Default'}
card = '{"type": "AdaptiveCard","$schema": "http://adaptivecards.io/schemas/adaptive-card.json","version": "1.3","body": [{"type": "Container","items": [{"type": "TextBlock","text": "NightAndDayRP","wrap": true,"horizontalAlignment": "Center","size": "Large","color": "' .. cardColors[Config.Card.TitleColor] .. '","weight": "Bolder"},{"type": "TextBlock","text": "{HEADING2}","wrap": true,"size": "Medium","horizontalAlignment": "Center","color": "' .. cardColors[Config.Card.Heading2Color] .. '"},{"type": "TextBlock","text": "{QUEUE_MESSAGE}","wrap": true,"size": "Medium","horizontalAlignment": "Center","color": "' .. cardColors[Config.Card.MessageColor] .. '"},{"type": "TextBlock","text": "' .. Config.Card.Heading4 .. '","wrap": true,"horizontalAlignment": "Center","size": "Medium","color": "' .. cardColors[Config.Card.Heading4Color] .. '"}],"style": "warning","backgroundImage": {"url": "https://wallpaperaccess.com/full/707055.jpg"}},{"type": "ActionSet","actions": [{"type": "Action.OpenUrl","title": "Join Discord","style": "destructive","iconUrl": "https://cdn.discordapp.com/attachments/705817451245600798/793492968962261052/modcheck.gif","url": "https://discord.gg/ceZZ8e5cck"}]}],"backgroundImage": {"url": "https://wallpaperaccess.com/full/707055.jpg"}}'
connecting = {};
function removeExpiredConnectors()
  for license, src in pairs(connecting) do 
    local exists = true;
    if GetPlayerName(src) == nil then 
      exists = false;
    end
    if not exists then 
      connecting[license] = nil;
    end
  end
end
function getConnectorCount()
  local count = 0;
  for license, connecting in pairs(connecting) do 
    count = count + 1;
  end
  return count;
end
function getPlayerCount()
  local count = 0;
  for id, _ in pairs(GetPlayers()) do 
    count = count + 1;
  end
  return count;
end
AddEventHandler('playerConnecting', function(name, setKickReason, def)
  def.defer()
  local src = source;
  local discord = ExtractIdentifiers(src).discord;
  local license = ExtractIdentifiers(src).license;
  local steam = ExtractIdentifiers(src).steam;
  local currentServerCount = getPlayerCount() + getConnectorCount();
  local whitelistRequired = Config.WhitelistRequired;
  local steamRequired = Config.Requirements.Steam;
  local discordRequired = Config.Requirements.Discord;
  slots = GetConvarInt('sv_maxclients', 32)
  Wait(0);
  if (steamRequired) then 
    if (steam == nil) then 
      -- They need steam to play
      def.done(prefix .. Config.Displays.Messages.MSG_STEAM_REQUIRED);
      Wait(0);
      CancelEvent();
    end
  end
  if (discordRequired) then
    if (discord == nil) then
      def.done(prefix .. Config.Displays.Messages.MSG_DISCORD_REQUIRED);
      Wait(0);
      CancelEvent();
    end
  end
  if (whitelistRequired) then
    if (not Queue:IsWhitelisted(src)) then 
      def.done(prefix .. Config.Displays.Messages.MSG_NOT_WHITELISTED);
      Wait(0);
      CancelEvent();
    end 
  end
 -- print("[DiscordQueue:Connecting] Slots = " .. slots .. " and currentServerCount = " .. currentServerCount);
  if ( (currentServerCount >= slots) or (Queue:GetMax() > 0) ) then 
    -- There is a queue to get in the server
   -- print("[DiscordQueue:Connecting] Gets here 1"); -- DEBUG - Get rid of
    if (not Queue:Contains(license)) then 
      -- Does not contain them yet, add them 
      --print("[DiscordQueue:Connecting] Gets here 2"); -- DEBUG - Get rid of
      local result = false;
      if (GetPlayerName(src) ~= nil) then 
       -- print("[DiscordQueue:Connecting] Gets here 3"); -- DEBUG - Get rid of
        result = Queue:AddPlayer(src);
        sendToDiscQueue(prefix, "Player `" .. GetPlayerName(src) .. "` has been set to the queue...", 'Bad-DiscordQueue by Badger#0002')
        --print("[DiscordQueue:Connecting] Gets here 4"); -- DEBUG - Get rid of
      end
    end
    --print("[DiscordQueue:Connecting] Gets here 5"); -- DEBUG - Get rid of
    if result or Queue:Contains(license) then 
      -- The player was added successfully
      local headingIndex = 1;
      local imageIndex = 1;
      Wait(1000);
      while ( ( (not Queue:CheckQueue(license)) or (currentServerCount + 1 > slots) ) ) do 
       -- print("CurrentServerCount+1: `" .. (currentServerCount + 1) .. "` ||| CurrentServerCount: `" .. currentServerCount .. "`"  );
        -- They are waiting in the queue still
        currentServerCount = getPlayerCount() + getConnectorCount();
        removeExpiredConnectors();
        local cardPres = card .. "";
        if headingIndex > #Config.Card.Heading2 then 
          headingIndex = 1;
        end
        if imageIndex > #Config.Card.Header_Images then 
          imageIndex = 1;
        end
        cardPres = cardPres:gsub("{IMAGE}", Config.Card.Header_Images[imageIndex]);
        cardPres = cardPres:gsub("{HEADING2}", Config.Card.Heading2[headingIndex]);
        cardPres = cardPres:gsub("{QUEUE_MESSAGE}", Queue:GetMessage(license):gsub("{QUEUE_NUM}", Queue:GetQueueNum(license)):gsub("{QUEUE_MAX}", Queue:GetMax()));
        local textblock = '{"type":"TextBlock","text":"{TEXT}","wrap":true,"size":"Medium","horizontalAlignment":"Center", "color": "' .. cardColors[Config.Card.QueueListColor] .. '"},';
        local playerList = "";
        if Config.Card.QueueListEnabled then 
          -- Show the queue list
          local usersAhead = Queue:GetAhead(Config.Card.QueueListSlots);
          for i = 1, #usersAhead do 
            local data = usersAhead[i];
            local username = data['username'];
            local discordName = data['discordName'];
            local rank = data['rank'];
            local block = textblock;
            local name = username:gsub("%%", ""):gsub('"', ""):gsub("'", "");
            local roleName = rank:gsub("%%", ""):gsub('"', ""):gsub("'", "");
            block = block:gsub("{TEXT}", "[" .. tostring(i) .. "] " .. roleName .. " " .. name .. " (" .. discordName .. ")");
            playerList = playerList .. block;
          end
          playerList = '{"type":"TextBlock","text":"CURRENT QUEUE:","wrap":true,"size":"Medium","horizontalAlignment":"Center", "color": "' .. cardColors[Config.Card.QueueListTitleColor] .. '", "weight": "Bolder"},' .. playerList;
          cardPres = cardPres:gsub("{QUEUE_LIST}", playerList);
        end
        Wait(0);
        def.presentCard(cardPres,
        function(data, rawData)
        end)
        headingIndex = headingIndex + 1;
        imageIndex = imageIndex + 1;
        Wait(3000);
      end
      -- They waited through the queue and are next, pop them 
      connecting[license] = src;
      if (GetPlayerName(src) ~= nil) then 
        sendToDisc(prefix, "Player `" .. GetPlayerName(src) .. "` is now joining the server...", 'Bad-DiscordQueue by Badger#0002');
      end
      Wait(1000);
      Queue:RemovePlayer(license);
      Wait(0);
      def.done();
    else 
      Wait(0);
      def.done(prefix .. "The Queue system failed... Please try again in a few minutes.");
      CancelEvent();
    end 
  else
    connecting[license] = src;
    Wait(0);
    def.done(); 
  end
end)

RegisterNetEvent('DiscordQueue:Activated')
AddEventHandler('DiscordQueue:Activated', function()
  local src = source;
  local license = ExtractIdentifiers(src).license;
  if (connecting[license] ~= nil) then 
    connecting[license] = nil;
    if (GetPlayerName(src) ~= nil) then 
      sendToDisc(prefix, "Player `" .. GetPlayerName(src) .. "` has loaded into the server...", 'Bad-DiscordQueue by Badger#0002');
    end
  end
end)

AddEventHandler('playerDropped', function(reason)
  local src = source;
  local license = ExtractIdentifiers(src).license;
  Queue:RemovePlayer(license);
end)