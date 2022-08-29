fx_version "cerulean"
game "gta5"

ui_page "./ui/index.html"

files{
    "./ui/index.html",
    "./ui/main.css",
    "./ui/main.js",
    "./ui/minigame.js",
}

client_script "client.lua"
server_script "server.lua"
server_script "@mysql-async/lib/MySQL.lua"

client_script "@Badger-Anticheat/acloader.lua"