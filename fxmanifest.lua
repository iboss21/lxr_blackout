fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'hm_blackout'
author 'MopsScripts <henry.mops89@gmail.com>'
description 'Regional Blackout System mit Generator-Management & NPC-Informanten'
version '2.3.0'

dependencies {
    '/server:5848',
    '/onesync',
    'ox_lib',
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared/locale.lua',
    'shared/config.lua'
}

client_scripts {
    'bridge/framework.lua',
    'bridge/inventory.lua',
    'bridge/target.lua',
    'bridge/utils.lua',
    'client/main.lua',
    'client/zones.lua',
    'client/blackout_zones.lua',
    'client/effects.lua',
    'client/npcs.lua',
    'client/ui.lua',
    'client/exports.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'bridge/framework.lua',
    'bridge/inventory.lua',
    'bridge/utils.lua',
    'server/sv_config.lua',
    'server/main.lua',
    'server/blackout.lua',
    'server/generator.lua',
    'server/npc_intel.lua',
    'server/callbacks.lua',
    'server/discord.lua',
    'server/commands.lua',
    'server/exports.lua'
}

files {
    'locales/*.lua'
}

escrow_ignore {
    'shared/config.lua',
    'server/sv_config.lua',
    'locales/*.lua',
    'bridge/*.lua',
    'README.md',
    'INSTALLATION.md'
}

exports {
    'GetBlackoutStatus',
    'IsZoneInBlackout',
    'GetGeneratorState',
    'IsPlayerInBlackoutZone',
    'GetActiveBlackoutZones',
    'GetAllZonesStatus'
}

server_exports {
    'StartBlackout',
    'EndBlackout',
    'IsZoneInBlackout',
    'GetAllZonesStatus',
    'GetGeneratorState',
    'SabotageGenerator',
    'RepairGenerator',
    'GetJobCount',
    'SendDiscordLog'
}

provides {
    'blackout_system',
    'generator_management'
}
