resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"


client_scripts  {
  "@nadrp-errorlog/client/cl_errorlog.lua",
  'client/hotel_client.lua',
  --'client/apart_client.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/hotel_server.lua'
}

ui_page 'index.html'

files {
  "index.html",
  "scripts.js",
  "css/style.css"
}

exports {
  'nearClothingMotel'
}
