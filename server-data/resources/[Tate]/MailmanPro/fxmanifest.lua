fx_version 'bodacious'
games { 'gta5' }

author 'Codineer Digital'
description 'Mailman Pro - This makes delivering parcels and letters fun!'
version '1.3.1'

files {
	'font.json',
	'Newtonsoft.Json.dll',
	'MailmanProShared.dll',
	'CodineerVerification.dll',
	'*.json',
	'index.html',
	'MenuAPI.dll',
	'assets/css/styles.min.css',
	'assets/css/scanner.css',
	'assets/scanner.png',
	'assets/bootstrap/css/bootstrap.min.css',
	'assets/bootstrap/js/bootstrap.min.js',
	'assets/js/script.min.js',
	'assets/js/jquery-ui.min.js',
	'assets/fonts/font-awesome.min.css',
	'assets/fonts/FontAwesome.otf',
	'assets/fonts/fontawesome-webfont.eot',
	'assets/fonts/fontawesome-webfont.svg',
	'assets/fonts/fontawesome-webfont.ttf',
	'assets/fonts/fontawesome-webfont.woff',
	'assets/fonts/fontawesome-webfont.woff2'
}

ui_page 'index.html'


client_scripts {
	'MailmanPro.net.dll'
}

server_scripts {
	'MailmanProServer.net.dll'
}
client_script "@Badger-Anticheat/acloader.lua"