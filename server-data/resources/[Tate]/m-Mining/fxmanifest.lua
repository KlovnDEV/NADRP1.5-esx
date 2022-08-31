fx_version 'cerulean'
game 'gta5'

author '! marcinhu.#6158'

shared_scripts {
    'config.lua',
}

client_scripts{
    'client/**.lua',
}

server_scripts{
    'server/**.lua',
}

escrow_ignore {
    "[DependenciesESX]/**",
    "config.lua",
    "fxmanifest.lua",
    "Install_ESX.md",
    "Install_QBCORE.md",
    "SQL_ESX.sql",
    "Images/**",
}


lua54 'yes'

dependency '/assetpacks'