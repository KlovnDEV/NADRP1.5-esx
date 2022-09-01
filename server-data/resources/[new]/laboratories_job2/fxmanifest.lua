fx_version "adamant"
game "gta5"

client_scripts {
	"config.lua",
}

client_scripts {
  'config.lua',
  'utils.lua',
  'client/main.lua',
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'langs/main.lua',
  'langs/en.lua',
  'config.lua',
  'utils.lua',
  'server/main.lua',
}
