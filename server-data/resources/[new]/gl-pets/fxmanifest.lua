fx_version 'bodacious'
game 'gta5'
author 'Kallock - The Goodlife RP Server'
version '1.0.0'

client_script {
    'client.lua',
}

server_script {
    '@mysql-async/lib/MySQL.lua',
	'server.lua',
}

shared_script 'shared.lua'
