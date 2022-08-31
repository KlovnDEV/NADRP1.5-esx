fx_version 'bodacious'
games { 'rdr3', 'gta5' }

client_script "@nadrp-errorlog/client/cl_errorlog.lua"
shared_script "shared/sh_doors.lua"

server_script "server/sv_doors.lua"
client_script "client/cl_doors.lua"

server_export 'isDoorLocked'