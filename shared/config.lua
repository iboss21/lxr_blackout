Config = {}

-- Locale
Config.Locale = 'de'

-- Features
Config.Debug = true
Config.DimHud = true
Config.RepairReward = 500
Config.EnableDispatch = true
Config.ShowGeneratorsAfterIntel = true
Config.IntelBlipDuration = 30000

-- Requirements
Config.MinimumPolice = 4
Config.MinimumTechs = 2

-- Minigame Settings (mgc - Mini Game Center)
-- ECHTE verfügbare Games aus MGC Dokumentation
Config.Minigames = {
    enabled = true,  -- Set to false to use ox_lib skillCheck fallback
    
    repair = {
        type = 'bit_flip',     -- Siehe MINIGAMES.md für alle 20 Games
        difficulty = 3,          -- Game-spezifisch (siehe docs)
    },
    
    sabotage = {
        type = 'bit_flip',       -- Siehe MINIGAMES.md für alle 20 Games
        timer = 30000,           -- 30 Sekunden
        chances = 3              -- 3 Fehler erlaubt
    }
}

-- Power Zones (ox_lib PolyZones)
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

-- Generators
Config.Generators = {
    ['gen_downtown_main'] = {
        coords = vec3(2862.47, 1510.1, 24.57),
        heading = 169.4,
        label = 'Downtown Hauptgenerator',
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
        label = 'Downtown Backup-Generator',
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

-- Intel NPCs
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
        label = '[E] Mit Informant sprechen',
        distance = 2.5
    }
}

-- Intel Data
Config.IntelData = {
    ['downtown'] = {
        generators = 2,
        difficulty = 'hard',
        estimatedTime = '3-5 Min pro Generator',
        hints = {
            'Der Hauptgenerator befindet sich auf einem Hochhaus nahe der Innenstadt',
            'Ein Backup-Generator ist in der Nähe des Krankenhauses versteckt',
            'Du brauchst mindestens 2 Kraftstoffkanister für den Hauptgenerator'
        }
    },
    
    ['vespucci'] = {
        generators = 1,
        difficulty = 'medium',
        estimatedTime = '2-4 Min',
        hints = {
            'Ein Generator steht direkt am Strand',
            'Vorsicht: Polizei patrouilliert oft in dieser Gegend'
        }
    }
}
