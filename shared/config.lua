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
║                   🐺 LXR BLACKOUT SYSTEM - CONFIGURATION 🐺                  ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝

    Regional Blackout System with Generator Management & Intel NPCs
    Designed for hardcore roleplay with immersive power outage mechanics
    
    🌟 SERVER INFORMATION
    ════════════════════════════════════════════════════════════════════════════
    Server:           The Land of Wolves 🐺
    Community:        Georgian RP 🇬🇪 | მგლების მიწა
    Description:      ისტორია ცოცხლდება აქ! (History Lives Here!)
    Type:             Serious Hardcore Roleplay
    Access:           Discord & Whitelisted
    ════════════════════════════════════════════════════════════════════════════
    
    📦 VERSION & PERFORMANCE
    ════════════════════════════════════════════════════════════════════════════
    Version:          3.0.0 (LXR Edition)
    Performance:      Optimized for 0.00ms idle / < 0.05ms active
    Cache Strategy:   Event-based synchronization, 1s interval checks
    ════════════════════════════════════════════════════════════════════════════
    
    🔧 FRAMEWORK SUPPORT (Multi-Framework Auto-Detection)
    ════════════════════════════════════════════════════════════════════════════
    Primary Frameworks:
      • LXR-Core        ✅ Full Support (Priority 1)
      • RSG-Core        ✅ Full Support (Priority 2)
    
    Supported / Legacy:
      • VORP Core       ✅ Full Support (Legacy)
    
    Optional (Auto-Detected):
      • QBox, QBCore, ESX (if present)
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
-- ██████╗ ███████╗███████╗ ██████╗ ██╗   ██╗██████╗  ██████╗███████╗
-- ██╔══██╗██╔════╝██╔════╝██╔═══██╗██║   ██║██╔══██╗██╔════╝██╔════╝
-- ██████╔╝█████╗  ███████╗██║   ██║██║   ██║██████╔╝██║     █████╗  
-- ██╔══██╗██╔══╝  ╚════██║██║   ██║██║   ██║██╔══██╗██║     ██╔══╝  
-- ██║  ██║███████╗███████║╚██████╔╝╚██████╔╝██║  ██║╚██████╗███████╗
-- ╚═╝  ╚═╝╚══════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚══════╝
-- ███╗   ██╗ █████╗ ███╗   ███╗███████╗    ██████╗ ██████╗  ██████╗ ████████╗███████╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗
-- ████╗  ██║██╔══██╗████╗ ████║██╔════╝    ██╔══██╗██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║
-- ██╔██╗ ██║███████║██╔████╔██║█████╗      ██████╔╝██████╔╝██║   ██║   ██║   █████╗  ██║        ██║   ██║██║   ██║██╔██╗ ██║
-- ██║╚██╗██║██╔══██║██║╚██╔╝██║██╔══╝      ██╔═══╝ ██╔══██╗██║   ██║   ██║   ██╔══╝  ██║        ██║   ██║██║   ██║██║╚██╗██║
-- ██║ ╚████║██║  ██║██║ ╚═╝ ██║███████╗    ██║     ██║  ██║╚██████╔╝   ██║   ███████╗╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║
-- ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚══════╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
-- ══════════════════════════════════════════════════════════════════════════════

local REQUIRED_RESOURCE_NAME = 'lxr_blackout'
local currentResourceName = GetCurrentResourceName()

if currentResourceName ~= REQUIRED_RESOURCE_NAME then
    error(string.format([[
        
        ╔═══════════════════════════════════════════════════════════════════════╗
        ║                      ⚠️  RESOURCE NAME ERROR ⚠️                        ║
        ╠═══════════════════════════════════════════════════════════════════════╣
        ║                                                                       ║
        ║  This resource MUST be named exactly:                                ║
        ║                                                                       ║
        ║      Expected: %s                               ║
        ║      Got:      %-42s ║
        ║                                                                       ║
        ║  Please rename the resource folder to match the expected name.       ║
        ║  Then restart your server.                                           ║
        ║                                                                       ║
        ╚═══════════════════════════════════════════════════════════════════════╝
        
    ]], REQUIRED_RESOURCE_NAME, currentResourceName))
    return
end

-- ══════════════════════════════════════════════════════════════════════════════
-- Initialize Configuration Table
-- ══════════════════════════════════════════════════════════════════════════════

Config = {}

-- ██████████████████████████████████████████████████████████████████████████████
-- █████████████████  SERVER INFORMATION (CANONICAL)  ████████████████████████████
-- ██████████████████████████████████████████████████████████████████████████████

Config.ServerInfo = {
    name          = 'The Land of Wolves 🐺',
    tagline       = 'Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!',
    description   = 'ისტორია ცოცხლდება აქ!', -- History Lives Here!
    type          = 'Serious Hardcore Roleplay',
    access        = 'Discord & Whitelisted',
    website       = 'https://www.wolves.land',
    discord       = 'https://discord.gg/CrKcWdfd3A',
    github        = 'https://github.com/iBoss21',
    store         = 'https://theluxempire.tebex.io',
    serverListing = 'https://servers.redm.net/servers/detail/8gj7eb',
    developer     = 'iBoss21 / The Lux Empire',
    tags          = {'RedM','Georgian','SeriousRP','Whitelist','Economy','RPG','Blackout'}
}

-- ██████████████████████████████████████████████████████████████████████████████
-- ███████████████  FRAMEWORK CONFIGURATION (AUTO-DETECT)  ███████████████████████
-- ██████████████████████████████████████████████████████████████████████████████

--[[
    Framework Priority (in order):
    1) LXR-Core      - Primary framework (wolves.land)
    2) RSG-Core      - Primary RedM framework
    3) VORP Core     - Supported / Legacy
    4) QBox          - Auto-detected if present
    5) QBCore        - Auto-detected if present
    6) ESX           - Auto-detected if present
    
    Set to 'auto' for automatic detection (recommended)
    Set to specific framework name to force that framework
]]

Config.Framework = 'auto'  -- 'auto', 'lxr', 'rsg', 'vorp', 'qbox', 'qbcore', 'esx'

Config.FrameworkSettings = {
    ['lxr'] = {
        resourceName = 'lxr-core',
        events = {
            playerLoaded = 'lxr-core:client:player:loaded',
            playerUnload = 'lxr-core:client:player:unload',
            jobUpdate = 'lxr-core:client:job:update'
        },
        exports = {
            getCore = 'GetCoreObject',
            getPlayer = 'GetPlayer'
        }
    },
    ['rsg'] = {
        resourceName = 'rsg-core',
        events = {
            playerLoaded = 'RSGCore:Client:OnPlayerLoaded',
            playerUnload = 'RSGCore:Client:OnPlayerUnload',
            jobUpdate = 'RSGCore:Client:OnJobUpdate'
        },
        exports = {
            getCore = 'GetCoreObject',
            getPlayer = 'GetPlayer'
        }
    },
    ['vorp'] = {
        resourceName = 'vorp_core',
        events = {
            playerLoaded = 'vorp:SelectedCharacter',
            playerUnload = 'vorp:PlayerLogout'
        },
        callback = 'vorp:getCharacter'
    },
    ['qbox'] = {
        resourceName = 'qbx_core',
        events = {
            playerLoaded = 'QBCore:Client:OnPlayerLoaded',
            playerUnload = 'QBCore:Client:OnPlayerUnload',
            jobUpdate = 'QBCore:Client:OnJobUpdate'
        },
        exports = {
            getCore = 'GetCoreObject'
        }
    },
    ['qbcore'] = {
        resourceName = 'qb-core',
        events = {
            playerLoaded = 'QBCore:Client:OnPlayerLoaded',
            playerUnload = 'QBCore:Client:OnPlayerUnload',
            jobUpdate = 'QBCore:Client:OnJobUpdate'
        },
        exports = {
            getCore = 'GetCoreObject'
        }
    },
    ['esx'] = {
        resourceName = 'es_extended',
        events = {
            playerLoaded = 'esx:playerLoaded',
            playerUnload = 'esx:onPlayerLogout'
        },
        exports = {
            getShared = 'getSharedObject'
        }
    }
}

-- ██████████████████████████████████████████████████████████████████████████████
-- ████████████████████████  LOCALIZATION  ██████████████████████████████████████
-- ██████████████████████████████████████████████████████████████████████████████

Config.Lang = 'en'  -- Available: 'en', 'de', 'ka' (Georgian)

-- ██████████████████████████████████████████████████████████████████████████████
-- █████████████████████  GENERAL SETTINGS  ██████████████████████████████████████
-- ██████████████████████████████████████████████████████████████████████████████

Config.General = {
    enableDebug = false,                    -- Debug mode (prints to console)
    enableDimHud = true,                    -- Dim HUD during blackout
    showGeneratorsAfterIntel = true,        -- Show generator blips after buying intel
    intelBlipDuration = 30000,              -- Duration intel blips stay visible (ms)
    enableDispatch = true,                  -- Send police dispatch on sabotage
    repairReward = 500,                     -- Money reward for repairing generator
}

-- ██████████████████████████████████████████████████████████████████████████████
-- ███████████████████  JOB REQUIREMENTS  ████████████████████████████████████████
-- ██████████████████████████████████████████████████████████████████████████████

Config.Requirements = {
    minimumPolice = 4,                      -- Minimum police online for sabotage
    minimumTechs = 2,                       -- Minimum technicians needed for zone
}

-- ██████████████████████████████████████████████████████████████████████████████
-- ████████████████████  MINIGAME SETTINGS  ██████████████████████████████████████
-- ██████████████████████████████████████████████████████████████████████████████

--[[
    Minigame System: MGC (Mini Game Center) Integration
    
    Available Game Types (20+ options):
    • safe_crack      • wire_cut        • pattern_lock    • pincode
    • skill_bar       • skill_circle    • pulse_sync      • signal_wave
    • frequency_jam   • bit_flip        • code_drop       • tile_shift
    • circuit_trace   • chip_hack       • keypad_crack    • laser_grid
    • memory_match    • sequence_copy   • node_connect    • voltage_adjust
    
    See MINIGAMES.md for full documentation
]]

Config.Minigames = {
    enabled = true,  -- Set to false to use ox_lib skillCheck fallback
    
    repair = {
        type = 'bit_flip',       -- Game type for repair
        difficulty = 3,          -- Difficulty level (1-5)
    },
    
    sabotage = {
        type = 'bit_flip',       -- Game type for sabotage
        timer = 30000,           -- Time limit (ms)
        chances = 3              -- Number of attempts allowed
    }
}

-- ██████████████████████████████████████████████████████████████████████████████
-- ████████████████  POWER ZONES (POLYZONE-BASED)  ███████████████████████████████
-- ██████████████████████████████████████████████████████████████████████████████

--[[
    Power Zones: Regional areas that can experience blackouts
    
    Each zone configuration:
    • label:               Display name
    • color:               Zone color (RGBA)
    • points:              Polygon vertices (vec3)
    • thickness:           Zone height
    • generators:          Array of generator IDs for this zone
    • lightIntensity:      Darkness level (0.0 - 1.0)
    • timecycleModifier:   Visual filter ('cinema', 'default', etc.)
    • streetLightsOff:     Disable street lights
    • vehicleLightsBoost:  Boost vehicle light brightness
]]

Config.PowerZones = {
    ['downtown'] = {
        label = 'Downtown Los Santos',
        color = {r = 255, g = 100, b = 100, a = 100},
        points = {
            vec3(-431.0, -344.0, 0.0),
            vec3(184.0, -344.0, 0.0),
            vec3(184.0, -1044.0, 0.0),
            vec3(-431.0, -1044.0, 0.0)
        },
        thickness = 200.0,
        generators = {'gen_downtown_main', 'gen_downtown_backup'},
        lightIntensity = 0.2,
        timecycleModifier = 'cinema',
        streetLightsOff = true,
        vehicleLightsBoost = true
    },
    
    ['vespucci'] = {
        label = 'Vespucci Beach',
        color = {r = 100, g = 200, b = 255, a = 100},
        points = {
            vec3(-1500.0, -1000.0, 0.0),
            vec3(-800.0, -1000.0, 0.0),
            vec3(-800.0, -1450.0, 0.0),
            vec3(-1500.0, -1450.0, 0.0)
        },
        thickness = 150.0,
        generators = {'gen_vespucci_beach'},
        lightIntensity = 0.3,
        timecycleModifier = 'default',
        streetLightsOff = true,
        vehicleLightsBoost = false
    }
}

-- ██████████████████████████████████████████████████████████████████████████████
-- ██████████████████████  GENERATOR CONFIGURATION  ██████████████████████████████
-- ██████████████████████████████████████████████████████████████████████████████

--[[
    Generators: Power sources that can be repaired or sabotaged
    
    Each generator configuration:
    • coords:              Generator location (vec3)
    • heading:             Generator rotation
    • label:               Display name
    • zone:                Zone ID this generator powers
    • repairTime:          Time to repair (seconds)
    • requiredItems:       Items needed for repair
    • requiredJob:         Jobs allowed to repair
    • canBeSabotaged:      Can criminals sabotage this?
    • sabotageTime:        Time to sabotage (seconds)
    • sabotageItem:        Item required for sabotage
    • blip:                Map blip configuration
]]

Config.Generators = {
    ['gen_downtown_main'] = {
        coords = vec3(2862.47, 1510.1, 24.57),
        heading = 169.4,
        label = 'Downtown Main Generator',
        zone = 'downtown',
        repairTime = 180,
        requiredItems = {
            {item = 'repair_kit', amount = 1},
            {item = 'fuel_can', amount = 2}
        },
        requiredJob = {'mechanic', 'electrician'},
        canBeSabotaged = true,
        sabotageTime = 45,
        sabotageItem = 'weapon_stickybomb',
        blip = {
            sprite = 354,
            color = 5,
            scale = 0.8,
            showWhenOffline = true
        }
    },
    
    ['gen_downtown_backup'] = {
        coords = vec3(2463.08, 1481.89, 36.2),
        heading = 356.97,
        label = 'Downtown Backup Generator',
        zone = 'downtown',
        repairTime = 120,
        requiredItems = {
            {item = 'repair_kit', amount = 1}
        },
        requiredJob = {'mechanic'},
        canBeSabotaged = true,
        sabotageTime = 30,
        sabotageItem = 'weapon_stickybomb',
        blip = {
            sprite = 354,
            color = 46,
            scale = 0.6,
            showWhenOffline = true
        }
    },
    
    ['gen_vespucci_beach'] = {
        coords = vec3(-1200.0, -1300.0, 5.0),
        heading = 270.0,
        label = 'Vespucci Beach Generator',
        zone = 'vespucci',
        repairTime = 150,
        requiredItems = {
            {item = 'repair_kit', amount = 1},
            {item = 'fuel_can', amount = 1}
        },
        requiredJob = {'mechanic'},
        canBeSabotaged = true,
        sabotageTime = 40,
        sabotageItem = 'weapon_stickybomb',
        blip = {
            sprite = 354,
            color = 3,
            scale = 0.7,
            showWhenOffline = true
        }
    }
}

-- ██████████████████████████████████████████████████████████████████████████████
-- █████████████████████  INTEL NPC SYSTEM  ██████████████████████████████████████
-- ██████████████████████████████████████████████████████████████████████████████

--[[
    Intel NPCs: Informants who sell generator locations
    
    Each NPC configuration:
    • coords:              NPC spawn location
    • heading:             NPC rotation
    • model:               Ped model
    • scenario:            NPC animation scenario
    • intelZones:          Zones this NPC has intel for
    • pricePerZone:        Cost of intel per zone
    • cooldown:            Cooldown between purchases (seconds)
    • label:               Interaction prompt text
    • distance:            Interaction distance
]]

Config.IntelNPCs = {
    ['downtown_intel'] = {
        coords = vec3(-58.0, -1098.0, 26.0),
        heading = 90.0,
        model = 'a_m_m_business_01',
        scenario = 'WORLD_HUMAN_SMOKING',
        intelZones = {'downtown', 'vespucci'},
        pricePerZone = {
            ['downtown'] = 5000,
            ['vespucci'] = 3500
        },
        cooldown = 1800,
        label = '[E] Speak with Informant',
        distance = 2.5
    }
}

-- ██████████████████████████████████████████████████████████████████████████████
-- ████████████████████  INTEL DATA (HINTS)  █████████████████████████████████████
-- ██████████████████████████████████████████████████████████████████████████████

--[[
    Intel Data: Information provided by NPCs about zones
    
    Each zone intel:
    • generators:          Number of generators
    • difficulty:          Difficulty rating
    • estimatedTime:       Time estimate text
    • hints:               Array of hint strings
]]

Config.IntelData = {
    ['downtown'] = {
        generators = 2,
        difficulty = 'hard',
        estimatedTime = '3-5 Min per Generator',
        hints = {
            'The main generator is located on a high-rise near downtown',
            'A backup generator is hidden near the hospital',
            'You need at least 2 fuel canisters for the main generator'
        }
    },
    
    ['vespucci'] = {
        generators = 1,
        difficulty = 'medium',
        estimatedTime = '2-4 Min',
        hints = {
            'A generator stands directly on the beach',
            'Caution: Police often patrol this area'
        }
    }
}

-- ██████████████████████████████████████████████████████████████████████████████
-- ████████████████████  SECURITY & ANTI-EXPLOIT  ████████████████████████████████
-- ██████████████████████████████████████████████████████████████████████████████

Config.Security = {
    maxDistanceFromGenerator = 10.0,       -- Max distance to interact (meters)
    cooldownPerPlayer = 60,                -- Cooldown per player between actions (seconds)
    rateLimit = 5,                         -- Max actions per timeWindow
    timeWindow = 60,                       -- Time window for rate limiting (seconds)
    validateCoords = true,                 -- Validate player coordinates server-side
    logSuspiciousActivity = true,          -- Log potential exploits to Discord
}

-- ██████████████████████████████████████████████████████████████████████████████
-- ██████████████████████  PERFORMANCE TUNING  ███████████████████████████████████
-- ██████████████████████████████████████████████████████████████████████████████

Config.Performance = {
    zoneCheckInterval = 1000,              -- Zone check interval (ms)
    effectUpdateInterval = 500,            -- Visual effect update rate (ms)
    blipUpdateInterval = 5000,             -- Blip update rate (ms)
    cacheTimeout = 300,                    -- Cache timeout (seconds)
    useThreadOptimization = true,          -- Optimize threads
}

-- ██████████████████████████████████████████████████████████████████████████████
-- ███████████████████████  DEBUG SETTINGS  ██████████████████████████████████████
-- ██████████████████████████████████████████████████████████████████████████████

Config.Debug = Config.General.enableDebug

-- ██████████████████████████████████████████████████████████════════════════════
-- ████████████████  END OF CONFIGURATION  ████████████████████████████████████████
-- ██████████████████████████████████████████████████████████════════════════════

-- Boot Banner (Displays on resource start)
print([[

^2╔══════════════════════════════════════════════════════════════════════════════╗
^2║                                                                              ║
^2║    ██╗     ██╗  ██╗██████╗     ██████╗ ██╗      █████╗  ██████╗██╗  ██╗    ║
^2║    ██║     ╚██╗██╔╝██╔══██╗    ██╔══██╗██║     ██╔══██╗██╔════╝██║ ██╔╝    ║
^2║    ██║      ╚███╔╝ ██████╔╝    ██████╔╝██║     ███████║██║     █████╔╝     ║
^2║    ██║      ██╔██╗ ██╔══██╗    ██╔══██╗██║     ██╔══██║██║     ██╔═██╗     ║
^2║    ███████╗██╔╝ ██╗██║  ██║    ██████╔╝███████╗██║  ██║╚██████╗██║  ██╗    ║
^2║    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝    ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ║
^2║     ██████╗ ██╗   ██╗████████╗                                              ║
^2║    ██╔═══██╗██║   ██║╚══██╔══╝                                              ║
^2║    ██║   ██║██║   ██║   ██║                                                 ║
^2║    ██║   ██║██║   ██║   ██║                                                 ║
^2║    ╚██████╔╝╚██████╔╝   ██║                                                 ║
^2║     ╚═════╝  ╚═════╝    ╚═╝                                                 ║
^2║                                                                              ║
^2║                   🐺 REGIONAL BLACKOUT SYSTEM 🐺                             ║
^2║                                                                              ║
^2║  Version:  ^3v3.0.0 (LXR Edition)^2                                            ║
^2║  Server:   ^6]] .. Config.ServerInfo.name .. [[^2                                        ║
^2║  Status:   ^2●^2 RUNNING^2                                                       ║
^2║                                                                              ║
^2║  Framework Support:                                                         ║
^2║    • LXR-Core   ^3✓^2  Primary                                                 ║
^2║    • RSG-Core   ^3✓^2  Primary                                                 ║
^2║    • VORP       ^3✓^2  Supported                                               ║
^2║                                                                              ║
^2║  Performance:  ^60.00ms^2 idle ^3/^2 ^6<0.05ms^2 active                              ║
^2║                                                                              ║
^2╠══════════════════════════════════════════════════════════════════════════════╣
^2║                                                                              ║
^2║  🌐 wolves.land  ^3|^2  👥 discord.gg/CrKcWdfd3A  ^3|^2  🛒 theluxempire.tebex.io  ║
^2║                                                                              ║
^2╚══════════════════════════════════════════════════════════════════════════════╝
^7
]])
