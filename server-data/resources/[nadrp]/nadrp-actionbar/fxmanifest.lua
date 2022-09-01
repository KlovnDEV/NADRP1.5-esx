fx_version 'bodacious'
games { 'rdr3', 'gta5' }

client_script "@nadrp-errorlog/client/cl_errorlog.lua"

client_script 'client.lua'

server_script {
    'server.lua',
    "@mysql-async/lib/MySQL.lua",
}
