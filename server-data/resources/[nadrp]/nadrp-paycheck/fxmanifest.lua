fx_version 'adamant'

game 'gta5'

client_scripts {
   "@nadrp-errorlog/client/cl_errorlog.lua",
   'client/main.lua',
}

server_scripts {
   'server/main.lua',
   '@mysql-async/lib/MySQL.lua'
}