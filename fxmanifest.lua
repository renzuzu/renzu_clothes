-- MADE BY Renzuzu

fx_version 'bodacious'
game 'gta5'

use_experimental_fxv2_oal 'yes'
lua54 'yes'
ui_page {
    'html/index.html',
}

shared_script '@renzu_shield/init.lua'
shared_script '@ox_lib/init.lua'

server_scripts {
	'bridge/framework/server/*.lua',
	'@mysql-async/lib/MySQL.lua',	
	'server/**.lua',
}

client_scripts {
	'bridge/framework/client/*.lua',
	'components.lua',
	'client/**.lua',
}

shared_script 'config.lua'

files {
	'html/index.html',
	'html/script.js',
	'html/*.css',
	'html/img/**/*.png',
	'gago.json',
}
