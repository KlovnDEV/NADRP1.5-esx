DiscordWebhookSystemInfos = 'https://discord.com/api/webhooks/844848534113091584/fKoimAtCCVI8GFPB72fJaMPMmsDXfUTWWa8RMXUeoM-rdxUVvvwqsP45N8TSa1KmeX-V'
DiscordWebhookKillinglogs = 'https://discordapp.com/api/webhooks/770296993687011330/tLIxgZSI2e4G6BgD-4KpQJrGAAOYKBLM20W84d1wRlaTOjQD2iyVSkovJn3syeo_w47b'
DiscordWebhookChat = 'https://discord.com/api/webhooks/844848109586219038/exIV4aOxL4LWsz6IVaayIVEm2LfzeKOL9Gi8Tm4LH3qmC0cev9qbZzWp2fX1vY6Onam-'

SystemAvatar = 'https://wiki.fivem.net/w/images/d/db/FiveM-Wiki.png'

UserAvatar = 'https://i.imgur.com/KIcqSYs.png'

SystemName = 'SYSTEM'


--[[ Special Commands formatting
		 *YOUR_TEXT*			--> Make Text Italics in Discord
		**YOUR_TEXT**			--> Make Text Bold in Discord
	   ***YOUR_TEXT***			--> Make Text Italics & Bold in Discord
		__YOUR_TEXT__			--> Underline Text in Discord
	   __*YOUR_TEXT*__			--> Underline Text and make it Italics in Discord
	  __**YOUR_TEXT**__			--> Underline Text and make it Bold in Discord
	 __***YOUR_TEXT***__		--> Underline Text and make it Italics & Bold in Discord
		~~YOUR_TEXT~~			--> Strikethrough Text in Discord
]]
-- Use 'USERNAME_NEEDED_HERE' without the quotes if you need a Users Name in a special command
-- Use 'USERID_NEEDED_HERE' without the quotes if you need a Users ID in a special command


-- These special commands will be printed differently in discord, depending on what you set it to
SpecialCommands = {
				   {'/ooc', '**[OOC]:**'},
				   {'/911', '**[911]: (CALLER ID: [ USERNAME_NEEDED_HERE | USERID_NEEDED_HERE ])**'},
				  }

						
-- These blacklisted commands will not be printed in discord
BlacklistedCommands = {
					   '/AnyCommand',
					   '/AnyCommand2',
					  }

-- These Commands will use their own webhook
OwnWebhookCommands = {
					  {'/unjail', 'https://discord.com/api/webhooks/844848990163697664/7RYLZl6BrAoNRKDanJ9HQhy1xohxu3jBRSbW78_A-qF-O_s9Tt00aMieMH_zwam7VKn1'},
					  {'/fine', 'https://discordapp.com/api/webhooks/770298424876073010/oARWwO1LKZoMiRzlSytKJH5l6ujSWUSu114koBS9bS3dtUuopTbO-ry9_zEi15ba7kc8'},
					  {'/verbalwarning', 'https://discordapp.com/api/webhooks/668375704479596545/JyeNXX12UvEiiIF2EDjQFIB17plksvu1j2pqu6q9wWlwUHriVCBYA5xMpQl0x1u7H9Tt'},
						{'/ticket', 'https://discordapp.com/api/webhooks/668376170622091274/BjpAx3Z6kj1eqVtZn6Kv0Lc3WlMyHph0BjZCvJQ-p28HtVgMiVZ9KFORL3tnK9C_X-gy'},
						{'/ban', 'https://discordapp.com/api/webhooks/673698713608126465/Y2dBMmspSc8GUgg6SsYWaQRnJlDlgad3PlxPt2UC18b4-GWyKc5lb5VjyoLvatNScw8j'},
						{'/warn', 'https://discordapp.com/api/webhooks/673698713608126465/Y2dBMmspSc8GUgg6SsYWaQRnJlDlgad3PlxPt2UC18b4-GWyKc5lb5VjyoLvatNScw8j'},
						{'/kick', 'https://discordapp.com/api/webhooks/673698713608126465/Y2dBMmspSc8GUgg6SsYWaQRnJlDlgad3PlxPt2UC18b4-GWyKc5lb5VjyoLvatNScw8j'},
						{'/car', 'https://discord.com/api/webhooks/844849265432199200/jYUh_2eQtJLE8ROpHGcH26ont07NNJKhzY4N3-2kCRwAHwZj5evWT0oE1hLZW9tP-SNV'},
						{'/setmoney', 'https://discordapp.com/api/webhooks/770297174772285470/w5-SCiMCivAg6yGzLNg6qZSdqkGRVFo6d_r0KXvRAKNrxJeXxIVBT_g5_G8EseF2CrY_'},
						{'/ooc', 'https://discord.com/api/webhooks/844849554016829450/mbmdudMv4NJ2FhXgmOStoSCgM4D6syElTLwSl15GZOSqc1keKtgVsmQZKqZaygCsks4h'},
						{'/911', 'https://discord.com/api/webhooks/844849824440516618/b6Q2I8g5tgA0zHGRFuWTnWYMX5tK2Me1W6XQKfRH6ZSzKdWFX10bwxh_S_HhMOUmXNt2'},
						

					 }

-- These Commands will be sent as TTS messages
TTSCommands = {
			   '/Whatever',
			   '/Whatever2',
			  }

