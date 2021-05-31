fx_version 'bodacious'
games { 'rdr3', 'gta5' }


server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua',
}

client_script {
	"@ffrp-errorlog/client/cl_errorlog.lua",
  	"client.lua",
}



export "GetClosestNPC"
export "IsPedNearCoords"
export "isPed"
export "GroupRank"
export "GlobalObject"
export "retreiveBusinesses"