fx_version 'adamant'
-- MADE BY Renzuzu
game 'gta5'

lua54 'on'

ui_page {
    'html/index.html',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',	
	'config.lua',
	'server/server.lua',
}

client_scripts {
	'config.lua',
	'components.lua',
	'client/client.lua',
}

files {
	'html/index.html',
	'html/script.js',
	'html/*.css',
	'html/img/**/*.png',
	'gago.json',
}