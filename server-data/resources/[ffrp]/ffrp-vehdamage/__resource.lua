resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
    "@ffrp-errorlog/client/cl_errorlog.lua",
    'client/main.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua',
}

