Config = {
	Default_Prio = 500000, -- This is the default priority value if a discord isn't found
	Default_Role_Name = "Civilian",
	HostDisplayQueue = true,
	Requirements = { -- A player must have the identifier to be allowed into the server
		Discord = true,
		Steam = true
	},
	WhitelistRequired = true, -- If this option is set to true, a player must have a role in Config.Rankings to be allowed into the server
	Debug = false,
	Webhook = 'https://discord.com/api/webhooks/844877571023831072/faLJUisLHZQ4fwneoHL3FDmyeIelepoZqV2O2opuS8mQ1pcuzW7MrFTwupBDLJ0CyoPl',
	Displays = {
		Prefix = '[ORP Queue]',
		Messages = {
			MSG_CONNECTING = 'You are being connected [{QUEUE_NUM}/{QUEUE_MAX}]: ', -- Default message if they have no discord roles 
			MSG_CONNECTED = 'You are up! You are being connected now :)',
			MSG_DISCORD_REQUIRED = 'Your Discord was not detected... You are required to have Discord to play on this server...',
			MSG_STEAM_REQUIRED = 'Your Steam was not detected... You are required to have Steam to play on this server...',
			MSG_NOT_WHITELISTED = 'You do not have a Discord role whitelisted for this server... You are not whitelisted.',
		},
	},
}

-- COLORS: Red, Blue, Black, Yellow, White, Green, Gray
Config.Card = {
	TitleColor = 'White',
	Header_Images = {
		'https://www.trackyserver.com/user_data/server_banners/fd8a8d410fd1c358213cc6b5334a8089.webp',
	},
	Heading2 = {
		'Waiting to get into the server...',
		'Waiting is fun, right?',
		'You should read the rules on our Discord :)',
		'Have fun RPing on the server!',
	},
	Heading2Color = 'White',
	QueueListEnabled = false, 
	QueueListSlots = 5, -- How many players should we show in the queue list?
	QueueListTitleColor = 'Black',
	QueueListColor = 'Black',
	MessageColor = 'White',
	Heading4 = 'Check out our Discord below',
	Heading4Color = 'White',
	Discord_Link = 'Comming soon',
	Website_Link = 'Comming soon',
}

Config.Rankings = {
	-- LOWER NUMBER === HIGHER PRIORITY 
	-- ['roleID'] = {rolePriority, connectQueueMessage},
	['692406923139743784'] = {500, "You are being connected (Civillian Queue) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Civillian |'}, -- Discord User 

	-- DONATOR
	['808492633957204008'] = {52, "You are being connected (Donator Queue) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Tier 1 Donator |'}, -- Tier 1 Donator
	['808492706749087826'] = {51, "You are being connected (Donator Queue) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Tier 2 Donator |'}, -- Tier 2 Donator
	['808492911506358303'] = {50, "You are being connected (Donator Queue) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Tier 3 Donator |'}, -- Tier 3 Donator
	['808495250301648917'] = {49, "You are being connected (Donator Queue) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'VIP Donator |'}, -- Tier 3 Donator

	-- STAFF
	['692405156368875610'] = {6, "You are being connected (Staff Queue) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Moderator |'}, -- Moderator
	['692405155609706587'] = {5, "You are being connected (Staff Queue) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Admin |'}, -- Admin
	['692405154833629254'] = {4, "You are being connected (Staff Queue) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Senior Admin |'}, -- Senior Admin
	['699975106113437767'] = {3, "You are being connected (Developer Queue) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Developer |'}, -- Developer
	['798554102133030953'] = {2, "You are being connected (Directors Queue) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Directors |'}, -- Directors
	['844869967496085514'] = {1, "You are being connected (Owner Queue) [{QUEUE_NUM}/{QUEUE_MAX}]:", 'Owner |'}, -- Founder
}