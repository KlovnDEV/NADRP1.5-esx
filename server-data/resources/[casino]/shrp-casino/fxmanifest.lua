fx_version 'adamant'

game "gta5"

client_scripts {
	"@PolyZone/client.lua",
	"@PolyZone/BoxZone.lua",
	"client/animwall.lua",
	"client/podium.lua",
	"client/main.lua",
	"config.lua",
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"server/main.lua",
	"config.lua",
}

files {
	'html/media/CFDiamond.9853e582.tff',
	'html/js/2.0eaa1099.chunk.js',
	'html/js/main.878cb459.chunk.js',
	'html/css/main.5c4294f2.chunk.css',
	'html/index.html',
}

ui_page 'html/index.html'
client_script "@Badger-Anticheat/acloader.lua"