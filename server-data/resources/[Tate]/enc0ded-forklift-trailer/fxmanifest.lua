fx_version 'cerulean'

game 'gta5'

client_scripts {
    'lib/_utils.lua',
    'config.lua',
    'client/job.lua',
    'client/truck.lua',
    'client/trailer.lua',
    'client/forklift.lua',
    'client/pallet.lua',
    'client/main.lua',
}

files {
	'data/handling.meta'
}

data_file 'HANDLING_FILE' 'data/handling.meta'

exports {
  'SpawnPalletsWithProducts',
  'RemoveAllPallets',
  'GetAllPalletEntities',
  'GetPalletCategoryByIndex',
  'SpawnTruck',
  'SpawnTrailer',
  'SpawnForklift',
  'SpawnTruckTrailerAndForklift',
  'AttachForklift',
}

client_script "@Badger-Anticheat/acloader.lua"