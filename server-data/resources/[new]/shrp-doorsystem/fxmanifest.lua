fx_version 'cerulean'
games { 'gta5' }

server_scripts {
	--'@es_extended/locale.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	--'@es_extended/locale.lua',
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'config.lua',
	'client/main.lua'
}

dependency 'es_extended'

ui_page {
    'html/door.html',
}

files {
	'html/door.html',
	'html/main.js', 
	'html/style.css',
	'html/sounds/*.ogg',
}

client_script "@Badger-Anticheat/acloader.lua"