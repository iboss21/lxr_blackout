--[[
╔══════════════════════════════════════════════════════════════════════════════╗
║                                                                              ║
║    ██╗     ██╗  ██╗██████╗     ██████╗ ██╗      █████╗  ██████╗██╗  ██╗    ║
║    ██║     ╚██╗██╔╝██╔══██╗    ██╔══██╗██║     ██╔══██╗██╔════╝██║ ██╔╝    ║
║    ██║      ╚███╔╝ ██████╔╝    ██████╔╝██║     ███████║██║     █████╔╝     ║
║    ██║      ██╔██╗ ██╔══██╗    ██╔══██╗██║     ██╔══██║██║     ██╔═██╗     ║
║    ███████╗██╔╝ ██╗██║  ██║    ██████╔╝███████╗██║  ██║╚██████╗██║  ██╗    ║
║    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝    ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ║
║     ██████╗ ██╗   ██╗████████╗                                              ║
║    ██╔═══██╗██║   ██║╚══██╔══╝                                              ║
║    ██║   ██║██║   ██║   ██║                                                 ║
║    ██║   ██║██║   ██║   ██║                                                 ║
║    ╚██████╔╝╚██████╔╝   ██║                                                 ║
║     ╚═════╝  ╚═════╝    ╚═╝                                                 ║
║                                                                              ║
║                    🐺 LXR BLACKOUT SYSTEM - MANIFEST 🐺                      ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝

    Regional Blackout System with Generator Management & Intel NPCs
    Designed for hardcore roleplay with immersive power outage mechanics
    
    🌟 SERVER INFORMATION
    ════════════════════════════════════════════════════════════════════════════
    Server:           The Land of Wolves 🐺
    Community:        Georgian RP 🇬🇪 | მგლების მიწა
    Type:             Serious Hardcore Roleplay
    Access:           Discord & Whitelisted
    ════════════════════════════════════════════════════════════════════════════
    
    📦 VERSION & METADATA
    ════════════════════════════════════════════════════════════════════════════
    Version:          3.0.0 (LXR Edition)
    Performance:      Optimized for 0.00ms idle / < 0.05ms active
    RedM Ready:       ✅ Full RedM 1899 Support
    Framework:        LXR-Core, RSG-Core, VORP (Multi-Framework)
    ════════════════════════════════════════════════════════════════════════════
    
    🎯 FEATURES
    ════════════════════════════════════════════════════════════════════════════
    • Regional Blackout Zones (PolyZone-Based)
    • Generator Sabotage & Repair System
    • Intel NPC System (Buy Generator Locations)
    • 20+ Minigame Support (MGC Integration)
    • Immersive Visual & Audio Effects
    • Multi-Framework Auto-Detection
    • Server Authority & Anti-Exploit Protection
    • Discord Logging & txAdmin Integration
    ════════════════════════════════════════════════════════════════════════════
    
    🏷️ TAGS
    ════════════════════════════════════════════════════════════════════════════
    #RedM #Georgian #SeriousRP #Blackout #Generator #Economy #RPG #LXR
    ════════════════════════════════════════════════════════════════════════════
    
    👤 CREDITS
    ════════════════════════════════════════════════════════════════════════════
    Developer:        iBoss21 / The Lux Empire
    Original:         MopsScripts (Concept Base)
    Organization:     wolves.land
    GitHub:           https://github.com/iBoss21
    Store:            https://theluxempire.tebex.io
    Discord:          https://discord.gg/CrKcWdfd3A
    ════════════════════════════════════════════════════════════════════════════
    
    © 2026 The Lux Empire | wolves.land | All Rights Reserved
    ════════════════════════════════════════════════════════════════════════════
]]

-- ══════════════════════════════════════════════════════════════════════════════
-- FIVEM / REDM MANIFEST CONFIGURATION
-- ══════════════════════════════════════════════════════════════════════════════

fx_version 'cerulean'
games { 'gta5', 'rdr3' }
lua54 'yes'

-- RedM Prerelease Acknowledgment (Required for RedM 1899)
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources WILL become incompatible once RedM ships.'

-- ══════════════════════════════════════════════════════════════════════════════
-- RESOURCE METADATA
-- ══════════════════════════════════════════════════════════════════════════════

name 'lxr_blackout'
author 'iBoss21 / The Lux Empire <https://wolves.land>'
description '🐺 Regional Blackout System | LXR/RSG/VORP | Generator Management & Intel NPCs | wolves.land'
version '3.0.0'

-- ══════════════════════════════════════════════════════════════════════════════
-- DEPENDENCIES (Runtime Detection - No Hard Requirements)
-- ══════════════════════════════════════════════════════════════════════════════
-- Frameworks are auto-detected at runtime
-- ox_lib is required for core functionality

dependencies {
    '/server:5848',
    '/onesync',
    'ox_lib',
}

-- ══════════════════════════════════════════════════════════════════════════════
-- SHARED SCRIPTS (Both Client & Server)
-- ══════════════════════════════════════════════════════════════════════════════
-- Responsibility: Configuration, Localization, Utilities

shared_scripts {
    '@ox_lib/init.lua',
    'shared/locale.lua',
    'shared/config.lua'
}

-- ══════════════════════════════════════════════════════════════════════════════
-- CLIENT SCRIPTS (Player-Side Logic)
-- ══════════════════════════════════════════════════════════════════════════════
-- Responsibility: UI, Effects, Zones, NPCs, Player Interactions

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

-- ══════════════════════════════════════════════════════════════════════════════
-- SERVER SCRIPTS (Game Server Logic)
-- ══════════════════════════════════════════════════════════════════════════════
-- Responsibility: Authority, Validation, Database, Economy, Security

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

-- ══════════════════════════════════════════════════════════════════════════════
-- FILES (Streamed to Client)
-- ══════════════════════════════════════════════════════════════════════════════

files {
    'locales/*.lua'
}

-- ══════════════════════════════════════════════════════════════════════════════
-- ESCROW IGNORE (Public / Editable Files)
-- ══════════════════════════════════════════════════════════════════════════════

escrow_ignore {
    'shared/config.lua',
    'server/sv_config.lua',
    'locales/*.lua',
    'bridge/*.lua',
    'docs/*.md',
    'README.md',
    'INSTALLATION.md',
    'client/README.md',
    'server/README.md',
    'shared/README.md',
    'bridge/README.md'
}

-- ══════════════════════════════════════════════════════════════════════════════
-- CLIENT EXPORTS (Available to Other Resources)
-- ══════════════════════════════════════════════════════════════════════════════

exports {
    'GetBlackoutStatus',
    'IsZoneInBlackout',
    'GetGeneratorState',
    'IsPlayerInBlackoutZone',
    'GetActiveBlackoutZones',
    'GetAllZonesStatus'
}

-- ══════════════════════════════════════════════════════════════════════════════
-- SERVER EXPORTS (Available to Other Resources)
-- ══════════════════════════════════════════════════════════════════════════════

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

-- ══════════════════════════════════════════════════════════════════════════════
-- PROVIDES (System Identification)
-- ══════════════════════════════════════════════════════════════════════════════

provides {
    'blackout_system',
    'generator_management',
    'lxr_blackout'
}
