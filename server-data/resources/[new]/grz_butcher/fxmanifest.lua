fx_version   'cerulean'
lua54        'yes'
game         'gta5'

name         'Butcher activity'
version      '1.0.0'
description  'Get dead people and bring them to the butcher!'
author       'Grizy'

shared_script 'shared/config.lua'

client_scripts {
	'client/function_cl.lua',
	'client/main_cl.lua'
}

server_scripts 'server/framework.lua'

dependencies {
    '/server:4500',
    '/onesync',
}

escrow_ignore {
	'shared/config.lua',
	'server/framework.lua'
}

dependency '/assetpacks'