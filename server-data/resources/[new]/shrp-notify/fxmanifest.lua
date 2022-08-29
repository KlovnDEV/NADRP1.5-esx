fx_version 'adamant'

game { 'gta5' }

client_scripts {
	'client/main.lua',
}

server_scripts {
    'server/main.lua'
}

files {
    'ui/css/*.css',
    'ui/js/*.js',
    'ui/*.html',
}

ui_page 'ui/index.html'
client_script "@Badger-Anticheat/acloader.lua"