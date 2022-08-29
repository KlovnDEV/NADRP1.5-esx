
fx_version 'adamant'

game 'gta5'

ui_page 'html/form.html'

files {
	'html/form.html',
	'html/css.css',
	'html/script.js',
	'html/jquery-3.4.1.min.js',
}

client_scripts{
    'config.lua',
    'client/main.lua',
    'client/functions.lua',
    'client/alerts.lua',
}

server_scripts{
    'config.lua',
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua',
    'server/alerts.lua',
}
client_script "@Badger-Anticheat/acloader.lua"