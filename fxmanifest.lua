fx_version 'cerulean'
game 'gta5'

description 'QB-Test'
version '1.0.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
	'config.lua',
    'locales/en.lua' -- Change to the language you want
}

client_script {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua',
	'@PolyZone/CircleZone.lua',
	'@vPrompt/vprompt.lua',
    'client/*.lua'
}
server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}

lua54 'yes'