fx_version 'adamant'

game 'gta5'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/server.lua'
}

client_scripts {
	"@nadrp-errorlog/client/cl_errorlog.lua",
	'client/client.lua'
}
