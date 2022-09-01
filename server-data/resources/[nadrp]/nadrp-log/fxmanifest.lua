fx_version 'adamant'

game 'gta5'

client_scripts {
    'client/main.lua',
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    'server/main.lua',
    --'server/identlogger.lua',
    'server/config.lua'
}

export {
    'AddLog'
}

server_export "DiscordLog"
