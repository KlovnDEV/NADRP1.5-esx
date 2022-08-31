fx_version 'cerulean'
author '! marcinhu.#6158'
Description 'Fishing'
game 'gta5'

shared_scripts {
    'configs/**.lua',
}

client_scripts{
    'client/**.lua',
}

server_script {
	'@oxmysql/lib/MySQL.lua',
	'server/**.lua',
}

escrow_ignore {
    "[DependenciesESX]/**",
    "Installation_ESX.md",
    "Installation_QBCore.md",
    "About.md",
    "SQL_ESX.sql",
    "client/c_targets.lua",
    "server/s_editable.lua",
    "client/c_menus.lua",
    "configs/**.lua",
    "Images/**",
}


lua54 'yes'

dependency '/assetpacks'