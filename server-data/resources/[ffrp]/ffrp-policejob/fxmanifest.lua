fx_version 'adamant'

game 'gta5'

client_scripts {
	"@ffrp-errorlog/client/cl_errorlog.lua",
	'client/config.lua',
   	'client/main.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua'
}