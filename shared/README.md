```
╔══════════════════════════════════════════════════════════════════════════════╗
║                                                                              ║
║    ██╗     ██╗  ██╗██████╗     ██████╗ ██╗      █████╗  ██████╗██╗  ██╗    ║
║    ██║     ╚██╗██╔╝██╔══██╗    ██╔══██╗██║     ██╔══██╗██╔════╝██║ ██╔╝    ║
║    ██║      ╚███╔╝ ██████╔╝    ██████╔╝██║     ███████║██║     █████╔╝     ║
║    ██║      ██╔██╗ ██╔══██╗    ██╔══██╗██║     ██╔══██║██║     ██╔═██╗     ║
║    ███████╗██╔╝ ██╗██║  ██║    ██████╔╝███████╗██║  ██║╚██████╗██║  ██╗    ║
║    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝    ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ║
║                                                                              ║
║                    🐺 SHARED MODULES - Land of Wolves 🐺                      ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

# 🐺 Shared Folder

**The Land of Wolves** | wolves.land  
Regional Blackout System - Shared Configuration & Localization

---

## 📋 Overview

The **shared** folder contains configuration files and utilities that are accessible to **both client and server** scripts. These files define system-wide settings, zone configurations, gameplay parameters, and localization strings that ensure consistency across all game instances.

**Key Responsibilities:**
- Centralized configuration management
- Zone definitions and boundaries
- Gameplay mechanics tuning
- Item and cost configurations
- Localization and translation strings
- System-wide constants and defaults

**Shared Context:**
- Loaded on both client and server startup
- Ensures synchronized behavior across all players
- Single source of truth for game parameters
- Reduces configuration drift between environments

---

## 📂 File Structure

### ⚙️ **config.lua**
**Main Configuration File - System Settings**

The heart of the LXR Blackout System, containing all configurable parameters for the entire resource. This file is extensively documented with ASCII art branding and detailed explanations.

#### 🎯 **Configuration Sections**

##### 1. **Server Information**
```lua
Server:      The Land of Wolves 🐺
Community:   Georgian RP 🇬🇪 | მგლების მიწა
Type:        Serious Hardcore Roleplay
Version:     3.0.0 (LXR Edition)
```

##### 2. **Framework Support**
Auto-detects and supports multiple frameworks:
- ✅ **LXR-Core** (Priority 1 - Land of Wolves Custom)
- ✅ **RSG-Core** (Priority 2 - RedM Standard)
- ✅ **VORP Core** (Legacy Support)
- ✅ **QBox, QBCore, ESX** (Auto-detected if present)

##### 3. **Performance Settings**
```lua
Config.Performance = {
    idleMs = 0.00,           -- Idle resource usage
    activeMs = 0.05,         -- Active resource usage
    syncInterval = 1000,     -- Zone sync interval (1s)
    cacheStrategy = 'event'  -- Event-based sync
}
```

##### 4. **Blackout Zones Configuration**
Defines regional blackout zones with polygon boundaries:

```lua
Config.BlackoutZones = {
    ['Zone_ID'] = {
        label = "Zone Display Name",
        enabled = true,
        
        -- Polygon boundary points (vector2 format)
        points = {
            vector2(x1, y1),
            vector2(x2, y2),
            -- ... more points
        },
        
        -- Generator locations within zone
        generators = {
            {
                coords = vector4(x, y, z, heading),
                label = "Generator Location Name",
                type = 'prop_name'  -- Optional prop override
            }
        },
        
        -- Zone-specific settings
        blackoutDuration = 600,  -- Duration in seconds
        repairTimeMin = 30,      -- Min repair time
        repairTimeMax = 60       -- Max repair time
    }
}
```

**Example Zones:**
- `valentine` - Valentine Town & Surroundings
- `rhodes` - Rhodes Town Area
- `blackwater` - Blackwater Region
- `strawberry` - Strawberry Settlement
- `saintdenis` - Saint Denis Metropolitan
- `tumbleweed` - Tumbleweed Desert Region

##### 5. **Generator Settings**
```lua
Config.GeneratorSettings = {
    repairItem = 'repair_kit',      -- Required item to repair
    sabotageTime = 10,              -- Time to sabotage (seconds)
    repairTimeMin = 30,             -- Min repair duration
    repairTimeMax = 60,             -- Max repair duration
    cooldown = 300,                 -- Cooldown between actions (5 min)
    notifyPolice = true,            -- Alert police on sabotage
    propModel = 'prop_generator'    -- Default generator prop
}
```

##### 6. **Intel NPC Configuration**
```lua
Config.IntelNPCs = {
    {
        coords = vector4(x, y, z, heading),
        model = 'npc_model_hash',
        label = "Intel Dealer Name",
        
        -- Target interaction settings
        targetIcon = 'fas fa-info-circle',
        targetLabel = "Purchase Intel"
    }
}

Config.IntelCost = 500  -- Cost to buy generator locations
```

##### 7. **Visual Effects Settings**
```lua
Config.Effects = {
    darknessLevel = 0.8,         -- Darkness intensity (0.0 - 1.0)
    timecycle = 'NG_blackout',   -- Timecycle modifier
    transitionSpeed = 2.0,       -- Fade transition speed
    showBlips = true,            -- Show zone blips on map
    blipColor = 1,               -- Map blip color
    blipSprite = 354             -- Map blip icon
}
```

##### 8. **Notification Settings**
```lua
Config.Notifications = {
    enabled = true,
    type = 'ox_lib',  -- ox_lib, qb, esx, custom
    position = 'top-right',
    duration = 5000   -- milliseconds
}
```

##### 9. **Admin Permissions**
```lua
Config.AdminGroups = {
    'admin',
    'superadmin',
    'moderator'
}

Config.AdminCommands = {
    blackout = '/blackout',
    generator = '/generator',
    status = '/blackout-status'
}
```

##### 10. **Debug & Development**
```lua
Config.Debug = false          -- Enable debug logging
Config.ShowStartupBanner = true
Config.LogLevel = 'info'      -- info, warn, error
```

---

### 🌍 **locale.lua**
**Localization & Translation System**

Manages multi-language support for all in-game messages, notifications, UI elements, and system feedback.

#### 📝 **Translation Structure**

```lua
Locale = {
    -- Notification messages
    notifications = {
        blackout_started = "Blackout initiated in %s",
        blackout_ended = "Power restored in %s",
        generator_sabotaged = "Generator destroyed!",
        generator_repaired = "Generator repaired successfully",
        entered_blackout = "Entering blackout zone: %s",
        left_blackout = "Leaving blackout zone",
        insufficient_funds = "Insufficient funds for intel",
        intel_purchased = "Generator locations received"
    },
    
    -- UI text elements
    ui = {
        countdown_label = "BLACKOUT",
        repair_progress = "Repairing Generator...",
        sabotage_progress = "Sabotaging Generator...",
        time_remaining = "Time Remaining: %s",
        generator_offline = "Generator OFFLINE",
        generator_online = "Generator ONLINE"
    },
    
    -- Target interaction labels
    target = {
        sabotage_generator = "Sabotage Generator",
        repair_generator = "Repair Generator",
        check_status = "Check Generator Status",
        buy_intel = "Purchase Intel ($%s)"
    },
    
    -- Admin command responses
    admin = {
        blackout_started = "Blackout started in zone: %s",
        blackout_stopped = "Blackout stopped in zone: %s",
        invalid_zone = "Invalid zone ID",
        no_permission = "No permission for this command",
        generator_reset = "All generators reset in zone: %s"
    },
    
    -- Error messages
    errors = {
        too_far = "Too far from generator",
        cooldown_active = "Generator cooldown active",
        missing_item = "Missing required item: %s",
        already_active = "Blackout already active",
        not_active = "No blackout active in this zone",
        invalid_action = "Cannot perform this action"
    },
    
    -- Success messages
    success = {
        action_complete = "Action completed successfully",
        item_received = "Item received: %s",
        payment_processed = "Payment processed"
    }
}
```

#### 🌐 **Language Support**

Default language: **English**

**Supported Languages:**
- 🇺🇸 English (en)
- 🇩🇪 German (de)
- 🇬🇪 Georgian (ka) - *Special for Land of Wolves*
- 🇪🇸 Spanish (es)
- 🇫🇷 French (fr)
- 🇷🇺 Russian (ru)

**Adding New Languages:**
```lua
-- Create locales/es.lua for Spanish
Locale['es'] = {
    notifications = {
        blackout_started = "Apagón iniciado en %s",
        -- ... more translations
    }
}
```

**Usage in Code:**
```lua
-- Server-side
TriggerClientEvent('ox_lib:notify', source, {
    title = Locale.notifications.blackout_started:format(zoneName),
    type = 'info'
})

-- Client-side
exports.ox_lib:notify({
    description = Locale.ui.repair_progress,
    type = 'info'
})
```

---

### 🗂️ **config_old.lua**
**Legacy Configuration Archive**

- Contains previous configuration version
- Preserved for backward compatibility reference
- Used during migration from old versions
- **Do not modify unless restoring old settings**
- Not actively loaded by the system

**Purpose:**
- Historical reference for old zone configurations
- Backup of previous settings before updates
- Migration guide for server owners
- Troubleshooting legacy issues

---

## 🔄 Configuration Best Practices

### ✅ **Do's**
- Always test configuration changes in development first
- Backup `config.lua` before making major edits
- Keep zone boundaries simple for performance
- Use meaningful zone IDs and labels
- Document custom changes with comments
- Validate vector coordinates before deployment

### ❌ **Don'ts**
- Never hardcode values in client/server scripts
- Don't create overlapping zone boundaries
- Avoid extremely complex polygon shapes
- Don't modify config while server is running (restart required)
- Never commit sensitive Discord webhooks to public repos

---

## 🔧 Configuration Workflow

1. **Edit** `config.lua` with desired changes
2. **Validate** syntax and vector formats
3. **Test** on development server
4. **Backup** current production config
5. **Deploy** to production server
6. **Restart** resource to apply changes
7. **Verify** in-game functionality

---

## 🎯 Quick Configuration Reference

| Setting | Location | Default | Impact |
|---------|----------|---------|--------|
| Zone Boundaries | `Config.BlackoutZones[].points` | Various | Defines playable area |
| Blackout Duration | `Config.BlackoutZones[].blackoutDuration` | 600s | How long blackouts last |
| Generator Props | `Config.GeneratorSettings.propModel` | Default | Visual appearance |
| Intel Cost | `Config.IntelCost` | $500 | Purchase price |
| Darkness Level | `Config.Effects.darknessLevel` | 0.8 | Visual intensity |
| Admin Groups | `Config.AdminGroups` | Array | Command permissions |

---

## 🐺 Land of Wolves

**Server:** The Land of Wolves 🐺  
**Community:** Georgian RP 🇬🇪 | მგლების მიწა  
**Website:** [wolves.land](https://wolves.land)  
**Type:** Serious Hardcore Roleplay

---

*Shared configuration designed for flexibility, scalability, and ease of customization.*
