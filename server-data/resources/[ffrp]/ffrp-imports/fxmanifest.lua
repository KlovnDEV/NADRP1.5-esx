fx_version 'adamant'

game 'gta5'

client_script "@ffrp-errorlog/client/cl_errorlog.lua"

client_scripts {
  'client/vehshop.lua',
}

server_scripts {
  'server/vehshop_s.lua',
  "@mysql-async/lib/MySQL.lua"
}