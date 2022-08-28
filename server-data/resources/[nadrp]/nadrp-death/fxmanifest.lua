fx_version 'adamant'

game 'gta5'

client_script "@nadrp-errorlog/client/cl_errorlog.lua"

client_scripts {
    'config.lua',
    'client/main.lua',
    'client/death.lua',
}

server_scripts {
    'config.lua',
    'server/main.lua',
    'server/death.lua',
    "@mysql-async/lib/MySQL.lua"
}

exports {
    'GetDeath',
}