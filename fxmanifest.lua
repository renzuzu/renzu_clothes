-- MADE BY Renzuzu

fx_version 'bodacious'
game 'gta5'

lua54 'on'

ui_page {
    'html/index.html',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',	
	'server/server.lua',
}

client_scripts {
	'components.lua',
	'client/client.lua',
}

shared_script 'config.lua'

files {
	'html/index.html',
	'html/script.js',
	'html/*.css',
	'html/img/**/*.png',
	'gago.json',
}
