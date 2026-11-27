fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'chubby_notify'
author 'ChubbyDevNull'
description 'Små notifikationer i siden af skærmen: info, succes og fejl'
version '1.1.0'
repository 'https://github.com/freddiebjorn/chubby_notify'

shared_script 'config.lua'
client_script 'client.lua'

ui_page 'web/index.html'

files {
	'web/index.html',
	'web/style.css',
	'web/app.js',
	'web/fonts/*.woff2',
}
