displayIndex = 1;
displays = Config.Displays.ConnectingLoop;
prefix = Config.Displays.Prefix;
currentConnectors = 0;
maxConnectors = Config.AllowedPerTick;
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
card = '{"type": "AdaptiveCard","$schema": "http://adaptivecards.io/schemas/adaptive-card.json","version": "1.3","body": [{"type": "Container","items": [{"type": "TextBlock","text": "FadeFusionRP","wrap": true,"horizontalAlignment": "Center","size": "Large","color": "' .. cardColors[Config.Card.TitleColor] .. '","weight": "Bolder"},{"type": "TextBlock","text": "{HEADING2}","wrap": true,"size": "Medium","horizontalAlignment": "Center","color": "' .. cardColors[Config.Card.Heading2Color] .. '"},{"type": "TextBlock","text": "{QUEUE_MESSAGE}","wrap": true,"size": "Medium","horizontalAlignment": "Center","color": "' .. cardColors[Config.Card.MessageColor] .. '"},{"type": "TextBlock","text": "' .. Config.Card.Heading4 .. '","wrap": true,"horizontalAlignment": "Center","size": "Medium","color": "' .. cardColors[Config.Card.Heading4Color] .. '"}],"style": "warning","backgroundImage": {"url": "https://wallpaperaccess.com/full/707055.jpg"}},{"type": "ActionSet","actions": [{"type": "Action.OpenUrl","title": "Join Discord","style": "destructive","iconUrl": "https://cdn.discordapp.com/attachments/705817451245600798/793492968962261052/modcheck.gif","url": "https://discord.gg/ceZZ8e5cck"}]}],"backgroundImage": {"url": "https://wallpaperaccess.com/full/707055.jpg"}}'

local connecting = {}
headingIndex = 1;
imageIndex = 1;
local playerConnecting = {}
--[[
function CheckForGhostUsers()
  for license, data in pairs(playerConnecting) do 
    local found = false;
    local user = data.ID;
    local name = data.PlayerName;
    local connectingg = data.Connection;
    --if Config.Debug then 
      --print("[Bad-DiscordQueue] (MASS DEBUG)")
      --print("[Bad-DiscordQueue] PlayerName: " .. tostring(name) .. " || ID:" .. tostring(user) .. " || GetPlayerName(user): " .. tostring(GetPlayerName(user) ) );
    --end
    if GetPlayerName(user) == nil or GetPlayerName(user) ~= name or GetPlayerPing(user) == 0 then 
      -- They no longer exist
      Queue:PopLicense(license)
      if Config.Debug then 
        print(prefix .. " (Thread : NO LONGER EXISTS) Popped player " .. name .. " from queue...");
      end
      if connecting[license] ~= nil then 
        connecting[license] = nil;
        if (currentConnectors > 0) then 
          currentConnectors = currentConnectors - 1;
        end
      end
      if Config.Debug then 
        print(prefix .. " (Thread : NO LONGER EXISTS) currentConnectors is == " .. tostring(currentConnectors) )
      end
      playerConnecting[license] = nil;
    end
  end
end
Citizen.CreateThread(function()
  while true do 
    Wait((Config.CheckForGhostUsers * 1000));
    CheckForGhostUsers();
  end
end)
]]--

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals) 
  deferrals.defer();
  local user = source;
  local ids = ExtractIdentifiers(user);
  local license = ids.license;
  local playerName = GetPlayerName(user);
  local allowed = true;
  slots = GetConvarInt('sv_maxclients', 32)
  Citizen.Wait(100); -- Waiting for deferral
  if Config.Requirements.Steam then 
    -- Check if they have Steam
    if #ids.steam <= 1 then 
      deferrals.done(Config.Displays.Prefix .. " " .. Config.Displays.Messages.MSG_STEAM_REQUIRED);
      allowed = false;
      CancelEvent();
      return;
    end
  end
  if Config.Requirements.Discord then 
    -- Check if they have Discord
    if #ids.discord <= 1 then 
      deferrals.done(Config.Displays.Prefix .. " " .. Config.Displays.Messages.MSG_DISCORD_REQUIRED);
      allowed = false;
      CancelEvent();
      return;
    end
  end
  if Config.WhitelistRequired then 
    if not Queue:IsWhitelisted(user) then 
      -- Not whitelisted, return 
      deferrals.done(Config.Displays.Prefix .. " " .. Config.Displays.Messages.MSG_NOT_WHITELISTED);
      allowed = false;
      CancelEvent();
      return;
    end
  end
  Queue:CheckGhostUsers(); -- Check for ghost users
  if allowed then 
    playerConnecting[license] = {Connection = false, ID = user, PlayerName = playerName, Timeout = 0};
    if Config.onlyActiveWhenFull == true then 
      -- It's only active when server is full so lets check 
      if (GetPlayerCount() + 1) > slots or (GetPlayerCount() + Queue:GetMax()) > slots then  
        -- It's full, activate
        if not Queue:IsSetUp(license) then 
          -- Set them up 
          Queue:SetupPriority(user, license);
          if GetPlayerName(user) ~= nil then
            sendToDiscQueue("QUEUED USER", "Player `" .. GetPlayerName(user):gsub("`", "") .. "` has been added to the queue...", "Bad-DiscordQueue created by Badger");
          end 
          local message = GetMessage(user);
          local msg = message:gsub("{QUEUE_NUM}", Queue:GetQueueNum(user)):gsub("{QUEUE_MAX}", Queue:GetMax());
          if GetPlayerName(user) ~= nil then
            print(prefix .. " " .. "Player " .. GetPlayerName(user) .. " has been set to the QUEUE [" .. msg .. "]");
          end
        end
        Wait(3000);
        while ( ( (not Queue:CheckQueue(user, currentConnectors, slots)) or (currentConnectors == maxConnectors) ) or (GetPlayerCount() == slots) or 
        ((GetPlayerCount() + currentConnectors + 1) > slots) or ( (GetPlayerCount() + currentConnectors ) >= slots) ) do  
          -- They are still in the queue 
          Wait(3000);
          --if displayIndex > #displays then
            --displayIndex = 1;
          --end 
          if headingIndex > #Config.Card.Heading2 then 
            headingIndex = 1;
          end
          if imageIndex > #Config.Card.Header_Images then 
            imageIndex = 1;
          end
          local textblock = '{"type":"TextBlock","text":"{TEXT}","wrap":true,"size":"Medium","horizontalAlignment":"Center", "color": "' .. cardColors[Config.Card.QueueListColor] .. '"},';
          local playerList = "";
          local countRows = 0;
          for j = 1, Config.Card.QueueListSlots do  
            local userInfo = Queue:GetUserAt(j);
            if userInfo and userInfo[1] ~= nil then 
              -- Valid data, add it
              local block = textblock;
              local name = userInfo[1]:gsub("%%", ""):gsub('"', ""):gsub("'", "");
              local roleName = userInfo[2]:gsub("%%", ""):gsub('"', ""):gsub("'", "");
              if #userInfo == 3 then 
                local discordName = userInfo[3]:gsub("%%", ""):gsub('"', ""):gsub("'", "");
                block = block:gsub("{TEXT}", "[" .. tostring(j) .. "] " .. roleName .. " " .. name .. " (" .. discordName .. ")");
                playerList = playerList .. block;
              else 
                block = block:gsub("{TEXT}", "[" .. tostring(j) .. "] " .. roleName .. " " .. name .. "");
                playerList = playerList .. block;
              end
              countRows = countRows + 1;
            end
          end

          local heading2 = Config.Card.Heading2[headingIndex]:gsub("{QUEUE_LIST}", playerList);
          local image = Config.Card.Header_Images[imageIndex];
          local message = GetMessage(user);
          local msg = message:gsub("{QUEUE_NUM}", Queue:GetQueueNum(user)):gsub("{QUEUE_MAX}", Queue:GetMax());
          local cardPres = card .. "";
          cardPres = cardPres:gsub("{QUEUE_MESSAGE}", msg):gsub("{HEADING2}", heading2):gsub("{IMAGE}", image);
          if Config.Card.QueueListEnabled and countRows > 0 then 
            -- Replace it with values
            playerList = '{"type":"TextBlock","text":"CURRENT QUEUE:","wrap":true,"size":"Medium","horizontalAlignment":"Center", "color": "' .. cardColors[Config.Card.QueueListTitleColor] .. '", "weight": "Bolder"},' .. playerList;
            cardPres = cardPres:gsub("{QUEUE_LIST}", playerList);
          else 
            -- Replace it with nothing
            cardPres = cardPres:gsub("{QUEUE_LIST}", "");
          end
          imageIndex = imageIndex + 1;
          headingIndex = headingIndex + 1;
          deferrals.presentCard(cardPres,
          function(data, rawData)
          end)
          Queue:CheckGhostUsers(); -- Check for ghost users
          CancelEvent();
          --deferrals.update(prefix .. " " .. msg .. displays[displayIndex]);
        end
        -- If it got down here, they are now allowed to join the server 
        if connecting[license] == nil or connecting[license] ~= true then 
          Queue:PopLicense(license)
          currentConnectors = currentConnectors + 1;
          connecting[license] = true;
          if GetPlayerName(user) ~= nil then
            print(prefix .. " " .. "Player " .. GetPlayerName(user) .. " is allowed to join now!");
          end
          Wait(1000);
          if GetPlayerName(user) ~= nil then
            sendToDisc("NEW CONNECTOR", "Player `" .. GetPlayerName(user):gsub("`", "") .. "` is allowed to join now!", "Bad-DiscordQueue created by Badger");
          end
          if playerConnecting[license] ~= nil then 
            playerConnecting[license].Timeout = Config.Timeout;
            playerConnecting[license].Connection = true;
          end
        end -- connecting[license] == nil 
        deferrals.done();
      else	 
        deferrals.done();--deferrals done if server is not full as we don't want the queue
      end
    else 
      if not Queue:IsSetUp(license) then 
        -- Set them up 
        Queue:SetupPriority(user, license);
        if GetPlayerName(user) ~= nil then
          sendToDiscQueue("QUEUED USER", "Player `" .. GetPlayerName(user):gsub("`", "") .. "` has been added to the queue...", "Bad-DiscordQueue created by Badger");
        end
        local message = GetMessage(user);
        local msg = message:gsub("{QUEUE_NUM}", Queue:GetQueueNum(user)):gsub("{QUEUE_MAX}", Queue:GetMax());
        if GetPlayerName(user) ~= nil then
          print(prefix .. " " .. "Player " .. GetPlayerName(user) .. " has been set to the QUEUE [" .. msg .. "]");
        end
      end
      Wait(3000);
      while ( ( (not Queue:CheckQueue(user, currentConnectors, slots)) or (currentConnectors == maxConnectors) ) or (GetPlayerCount() == slots) or 
        ((GetPlayerCount() + currentConnectors + 1) > slots) or ( (GetPlayerCount() + currentConnectors ) >= slots) ) do 
          -- They are still in the queue 
          Wait(3000);
          --if displayIndex > #displays then
            --displayIndex = 1;
          --end 
          if headingIndex > #Config.Card.Heading2 then 
            headingIndex = 1;
          end
          if imageIndex > #Config.Card.Header_Images then 
            imageIndex = 1;
          end
          local textblock = '{"type":"TextBlock","text":"{TEXT}","wrap":true,"size":"Medium","horizontalAlignment":"Center", "color": "' .. cardColors[Config.Card.QueueListColor] .. '"},';
          local playerList = "";
          local countRows = 0;
          for j = 1, Config.Card.QueueListSlots do 
            local userInfo = Queue:GetUserAt(j);
            if userInfo and userInfo[1] ~= nil then 
              -- Valid data, add it
              local block = textblock;
              local name = userInfo[1]:gsub("%%", ""):gsub('"', ""):gsub("'", "");
              local roleName = userInfo[2]:gsub("%%", ""):gsub('"', ""):gsub("'", "");
              if #userInfo == 3 then 
                local discordName = userInfo[3]:gsub("%%", ""):gsub('"', ""):gsub("'", "");
                block = block:gsub("{TEXT}", "[" .. tostring(j) .. "] " .. roleName .. " " .. name .. " (" .. discordName .. ")");
                playerList = playerList .. block;
              else 
                block = block:gsub("{TEXT}", "[" .. tostring(j) .. "] " .. roleName .. " " .. name .. "");
                playerList = playerList .. block;
              end
              countRows = countRows + 1;
            end
          end

          local heading2 = Config.Card.Heading2[headingIndex]:gsub("{QUEUE_LIST}", playerList);
          local image = Config.Card.Header_Images[imageIndex];
          local message = GetMessage(user);
          local msg = message:gsub("{QUEUE_NUM}", Queue:GetQueueNum(user)):gsub("{QUEUE_MAX}", Queue:GetMax());
          local cardPres = card .. "";
          cardPres = cardPres:gsub("{QUEUE_MESSAGE}", msg):gsub("{HEADING2}", heading2):gsub("{IMAGE}", image);
          if Config.Card.QueueListEnabled and countRows > 0 then 
            -- Replace it with values
            playerList = '{"type":"TextBlock","text":"CURRENT QUEUE:","wrap":true,"size":"Medium","horizontalAlignment":"Center", "color": "' .. cardColors[Config.Card.QueueListTitleColor] .. '", "weight": "Bolder"},' .. playerList;
            cardPres = cardPres:gsub("{QUEUE_LIST}", playerList);
          else 
            -- Replace it with nothing
            cardPres = cardPres:gsub("{QUEUE_LIST}", "");
          end
          imageIndex = imageIndex + 1;
          headingIndex = headingIndex + 1;
          deferrals.presentCard(cardPres,
          function(data, rawData)
          end)
          CancelEvent();
          --deferrals.update(prefix .. " " .. msg .. displays[displayIndex]);
      end
      -- If it got down here, they are now allowed to join the server 
      if connecting[license] == nil or connecting[license] ~= true then 
        Queue:PopLicense(license)
        currentConnectors = currentConnectors + 1;
        connecting[license] = true;
        if GetPlayerName(user) ~= nil then
          print(prefix .. " " .. "Player " .. GetPlayerName(user) .. " is allowed to join now!");
        end
        Wait(1000);
        if GetPlayerName(user) ~= nil then
          sendToDisc("NEW CONNECTOR", "Player `" .. GetPlayerName(user):gsub("`", "") .. "` is allowed to join now!", "Bad-DiscordQueue created by Badger");
        end
        if playerConnecting[license] ~= nil then 
          playerConnecting[license].Timeout = Config.Timeout;
          playerConnecting[license].Connection = true;
        end
      end -- connecting[license] == nil
      deferrals.done();
    end
  end
end)
AddEventHandler('playerDropped', function (reason)
  local user = source;
  local license = ExtractIdentifiers(user).license;
  if (connecting[license] ~= nil) then 
    if (currentConnectors > 0) then 
      currentConnectors = currentConnectors - 1;
    end
    connecting[license] = nil;
  end
  playerConnecting[license] = nil;
  if (Queue:IsSetUp(license)) then 
    Queue:PopLicense(license);
    sendToDiscQueue("REMOVED QUEUE USER", "Player `" .. GetPlayerName(user):gsub("`", "") .. "` has been removed from the queue...", "Bad-DiscordQueue created by Badger");
    if Config.Debug then 
      print(prefix .. " (playerDropped) " .. "Player " .. GetPlayerName(user) .. " has been removed from QUEUE");
      print(prefix .. " (playerDropped) currentConnectors is == " .. tostring(currentConnectors) )
    end
  end
end)

RegisterNetEvent('DiscordQueue:Activated')
AddEventHandler('DiscordQueue:Activated', function()
  -- They were activated, pop them from Queue 
  local user = source;
  local license = ExtractIdentifiers(user).license;
  if (Queue:IsSetUp(license)) then 
    Queue:Pop(user);
    connecting[license] = nil;
    playerConnecting[license] = nil;
    sendToDiscQueue("REMOVED QUEUE USER", "Player `" .. GetPlayerName(user):gsub("`", "") .. "` has been removed from the queue...", "Bad-DiscordQueue created by Badger");
    if Config.Debug then 
      print(prefix .. " (DiscordQueue:Activated) " .. "Player " .. GetPlayerName(user) .. " has been removed from QUEUE");
      print(prefix .. " (DiscordQueue:Activated) currentConnectors is == " .. tostring(currentConnectors) )
    end
  end
  if (connecting[license] ~= nil) then 
    if (currentConnectors > 0) then 
      currentConnectors = currentConnectors - 1;
    end
    connecting[license] = nil;
  end
  playerConnecting[license] = nil;
end)

