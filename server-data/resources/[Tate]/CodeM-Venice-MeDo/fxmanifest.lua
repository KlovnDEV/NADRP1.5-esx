fx_version 'adamant'
game 'gta5'


author 'Aiakos#8317'


server_scripts {
	'config.lua',
	'server/main.lua',
	
}

client_scripts {
	'config.lua',
	'client/main.lua',
	}


files({
	"html/html.html",
	"html/style.css",
	"html/Heebo-Bold.ttf",
	"html/app.js"
})

ui_page "html/html.html"

lua54 'yes'


shared_script 'config.lua'


lua54 'yes'

escrow_ignore {
	'config.lua',
	
}
dependency '/assetpacks'