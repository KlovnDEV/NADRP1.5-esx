resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_script "@ffrp-errorlog/client/cl_errorlog.lua"

client_scripts {
  '@es_extended/locale.lua',
  'locales/en.lua',
  'client/chicken_c.lua',
  'client/pizza_c.lua',
  'client/fishing_c.lua',
  'config.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  '@es_extended/locale.lua',
  'locales/en.lua',
  'server/chicken_s.lua',
  'server/pizza_s.lua',
  'server/fishing_s.lua',
  'config.lua'
}

dependencies {
	'es_extended'
}

files {
	'data/vehicles.meta',
	'data/carvariations.meta',
	'data/carcols.meta',
	'data/handling.meta',
}

data_file 'HANDLING_FILE' 'data/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/carvariations.meta'

