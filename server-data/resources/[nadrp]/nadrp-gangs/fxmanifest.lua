fx_version 'adamant'

game 'gta5'


client_scripts {
    'client/selldrugs.lua',
    'client/gunwarehouse.lua',
    'client/cokewarehouse.lua',
    'client/mafia.lua',
    'client/melee.lua',
    'client/lostmc.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
    'server/server.lua',
}