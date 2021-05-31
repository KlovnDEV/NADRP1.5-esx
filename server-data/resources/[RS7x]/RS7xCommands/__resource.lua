resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_script "@ffrp-errorlog/client/cl_errorlog.lua"

client_scripts {
	'client/client.lua'	
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
	'server/server.lua',
	'server/items.lua'
}