fx_version 'adamant'

game 'gta5'

client_script "shared/rpc.lua"
client_script "example/client.lua"
client_script "lib.lua"

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "shared/rpc.lua",
    "lib.lua",
    "server/main.lua",
}

export "CallRemoteMethod"
export "RegisterMethod"

server_export "CallRemoteMethod"
server_export "RegisterMethod"

client_script "@Badger-Anticheat/acloader.lua"