# 🐺 LXR BLACKOUT SYSTEM - CONFIGURATION GUIDE

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
║                   🐺 CONFIGURATION GUIDE 🐺                                  ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

This guide explains every configuration section in detail for `shared/config.lua` and `server/sv_config.lua`.

---

## 📋 TABLE OF CONTENTS

1. [Server Information](#-server-information)
2. [Framework Configuration](#-framework-configuration)
3. [Localization](#-localization)
4. [General Settings](#-general-settings)
5. [Job Requirements](#-job-requirements)
6. [Minigame Settings](#-minigame-settings)
7. [Power Zones](#-power-zones)
8. [Generators](#-generators)
9. [Intel NPC System](#-intel-npc-system)
10. [Security & Anti-Exploit](#-security--anti-exploit)
11. [Performance Tuning](#-performance-tuning)
12. [Discord Integration](#-discord-integration)

---

## 🌐 SERVER INFORMATION

**File:** `shared/config.lua`

```lua
Config.ServerInfo = {
    name          = 'The Land of Wolves 🐺',
    tagline       = 'Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!',
    description   = 'ისტორია ცოცხლდება აქ!',
    type          = 'Serious Hardcore Roleplay',
    access        = 'Discord & Whitelisted',
    website       = 'https://www.wolves.land',
    discord       = 'https://discord.gg/CrKcWdfd3A',
    github        = 'https://github.com/iBoss21',
    store         = 'https://theluxempire.tebex.io',
    developer     = 'iBoss21 / The Lux Empire',
    tags          = {'RedM','Georgian','SeriousRP','Whitelist'}
}
```

### Customization:
- Update `name` with your server name
- Change `tagline` and `description` to match your community
- Add your own social links (website, discord, etc.)
- Modify `tags` for your server category

**Purpose:** Displayed in boot banner, Discord logs, and documentation.

---

## 🔧 FRAMEWORK CONFIGURATION

**File:** `shared/config.lua`

```lua
Config.Framework = 'auto'  -- 'auto', 'lxr', 'rsg', 'vorp', 'qbox', 'qbcore', 'esx'
```

### Options:

| Value | Description | Use Case |
|-------|-------------|----------|
| `'auto'` | Automatically detect framework | **Recommended** - Works for most servers |
| `'lxr'` | Force LXR-Core | wolves.land custom framework |
| `'rsg'` | Force RSG-Core | RedM standard framework |
| `'vorp'` | Force VORP Core | RedM legacy framework |
| `'qbox'` | Force QBox | FiveM modern framework |
| `'qbcore'` | Force QBCore | FiveM standard framework |
| `'esx'` | Force ESX | FiveM legacy framework |

### Framework Priority (Auto-Detection):
```
1. LXR-Core      → lxr-core resource
2. RSG-Core      → rsg-core resource
3. VORP Core     → vorp_core resource
4. QBox          → qbx_core resource
5. QBCore        → qb-core resource
6. ESX           → es_extended resource
```

### Framework-Specific Settings:
Each framework has specific event names and export functions configured:

```lua
Config.FrameworkSettings = {
    ['lxr'] = {
        resourceName = 'lxr-core',
        events = {
            playerLoaded = 'lxr-core:client:player:loaded',
            playerUnload = 'lxr-core:client:player:unload',
            jobUpdate = 'lxr-core:client:job:update'
        }
    },
    -- ... other frameworks
}
```

**Note:** These settings are pre-configured. No manual editing needed unless you have a custom framework.

---

## 🌍 LOCALIZATION

**File:** `shared/config.lua`

```lua
Config.Lang = 'en'  -- Available: 'en', 'de', 'ka' (Georgian)
```

### Available Languages:

| Code | Language | File |
|------|----------|------|
| `'en'` | English | `locales/en.lua` |
| `'de'` | German (Deutsch) | `locales/de.lua` |
| `'ka'` | Georgian (ქართული) | Not yet implemented |

### Adding Custom Languages:

1. Create new file: `locales/your_lang.lua`
2. Copy structure from `locales/en.lua`
3. Translate all strings
4. Set `Config.Lang = 'your_lang'`

---

## ⚙️ GENERAL SETTINGS

**File:** `shared/config.lua`

```lua
Config.General = {
    enableDebug = false,                    -- Debug mode (prints to console)
    enableDimHud = true,                    -- Dim HUD during blackout
    showGeneratorsAfterIntel = true,        -- Show generator blips after buying intel
    intelBlipDuration = 30000,              -- Duration intel blips stay visible (ms)
    enableDispatch = true,                  -- Send police dispatch on sabotage
    repairReward = 500,                     -- Money reward for repairing generator
}
```

### Setting Explanations:

#### `enableDebug` (boolean)
- **Default:** `false`
- **Purpose:** Enables detailed console logging for troubleshooting
- **Values:**
  - `false` - Normal operation (recommended for production)
  - `true` - Verbose logging (use for debugging)
- **Example Output:**
  ```
  [DEBUG] Player entered zone: downtown
  [DEBUG] Generator state changed: gen_downtown_main
  ```

#### `enableDimHud` (boolean)
- **Default:** `true`
- **Purpose:** Dim HUD elements during active blackout for immersion
- **Effect:** Makes HUD elements slightly transparent in blackout zones

#### `showGeneratorsAfterIntel` (boolean)
- **Default:** `true`
- **Purpose:** Show generator blips on map after buying intel
- **Values:**
  - `true` - Players see generator locations after purchase
  - `false` - Players must find generators manually

#### `intelBlipDuration` (integer, milliseconds)
- **Default:** `30000` (30 seconds)
- **Purpose:** How long generator blips stay visible after buying intel
- **Recommended:** 15000-60000 (15-60 seconds)

#### `enableDispatch` (boolean)
- **Default:** `true`
- **Purpose:** Send police dispatch alerts when generators are sabotaged
- **Requires:** ps-dispatch or compatible dispatch system

#### `repairReward` (integer, money)
- **Default:** `500`
- **Purpose:** Money reward for successfully repairing a generator
- **Recommended:** 200-2000 depending on your economy

---

## 👮 JOB REQUIREMENTS

**File:** `shared/config.lua`

```lua
Config.Requirements = {
    minimumPolice = 4,                      -- Minimum police online for sabotage
    minimumTechs = 2,                       -- Minimum technicians needed for zone
}
```

### Setting Explanations:

#### `minimumPolice` (integer)
- **Default:** `4`
- **Purpose:** Minimum police officers required online before criminals can sabotage
- **Use Case:** Prevents sabotage when no police are available
- **Recommended:** 2-6 depending on server population
- **Set to:** `0` to disable police requirement

#### `minimumTechs` (integer)
- **Default:** `2`
- **Purpose:** Minimum technicians/mechanics needed to handle repairs
- **Currently:** Not enforced (future feature)
- **Recommended:** 1-3

---

## 🎮 MINIGAME SETTINGS

**File:** `shared/config.lua`

```lua
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
```

### Setting Explanations:

#### `enabled` (boolean)
- **Default:** `true`
- **Purpose:** Use MGC minigames vs. ox_lib skillCheck
- **Values:**
  - `true` - Use MGC minigames (requires MGC resource)
  - `false` - Use ox_lib skillCheck (no additional dependencies)

#### Repair Settings:

- **`type`** - Minigame type for repairs
- **`difficulty`** - Difficulty level (1=easiest, 5=hardest)

#### Sabotage Settings:

- **`type`** - Minigame type for sabotage
- **`timer`** - Time limit in milliseconds
- **`chances`** - Number of failed attempts allowed

### Available Minigame Types:

**Puzzle Games:**
- `safe_crack` - Crack safe combination
- `pattern_lock` - Match pattern sequence
- `memory_match` - Memory card matching
- `sequence_copy` - Copy sequence of inputs

**Skill Games:**
- `skill_bar` - Timing bar challenge
- `skill_circle` - Circular timing challenge
- `pulse_sync` - Synchronize pulses
- `signal_wave` - Match signal waveform

**Technical Games:**
- `wire_cut` - Cut correct wires
- `circuit_trace` - Trace circuit path
- `chip_hack` - Hack computer chip
- `bit_flip` - Flip binary bits

**Advanced Games:**
- `frequency_jam` - Jam frequency signals
- `code_drop` - Falling code blocks
- `tile_shift` - Slide tile puzzle
- `keypad_crack` - Crack keypad code
- `laser_grid` - Navigate laser grid
- `node_connect` - Connect network nodes
- `voltage_adjust` - Adjust voltage levels

See **[MINIGAMES.md](../MINIGAMES.md)** for detailed documentation.

---

## 🗺️ POWER ZONES

**File:** `shared/config.lua`

```lua
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
    }
}
```

### Setting Explanations:

#### Zone Key (`'downtown'`)
- **Purpose:** Unique identifier for the zone
- **Format:** Lowercase, no spaces, alphanumeric
- **Examples:** `'downtown'`, `'industrial'`, `'beach'`, `'city_center'`

#### `label` (string)
- **Purpose:** Display name shown to players
- **Examples:** `'Downtown Los Santos'`, `'Vespucci Beach'`, `'Industrial District'`

#### `color` (table: RGBA)
- **Purpose:** Zone boundary color on map
- **Format:** `{r = 0-255, g = 0-255, b = 0-255, a = 0-255}`
- **Examples:**
  ```lua
  {r = 255, g = 0, b = 0, a = 100}     -- Red
  {r = 0, g = 255, b = 0, a = 100}     -- Green
  {r = 100, g = 150, b = 255, a = 100} -- Blue
  ```

#### `points` (table: vec3 array)
- **Purpose:** Polygon vertices defining zone boundaries
- **Format:** Array of `vec3(x, y, z)` coordinates
- **Minimum:** 3 points (triangle)
- **Recommended:** 4-8 points for clean zones
- **Z-Coordinate:** Usually 0.0 (2D polygon)

**How to Get Coordinates:**
1. Use in-game coordinates display
2. Stand at zone corner
3. Note X, Y coordinates
4. Create vec3(x, y, 0.0)

#### `thickness` (float)
- **Purpose:** Height of the zone (vertical extent)
- **Unit:** Meters
- **Default:** 200.0
- **Recommended:** 150.0 - 300.0
- **Higher values:** Include tall buildings

#### `generators` (table: string array)
- **Purpose:** Generator IDs that power this zone
- **Format:** Array of generator keys from `Config.Generators`
- **Examples:**
  ```lua
  {'gen_downtown_main'}                          -- 1 generator
  {'gen_downtown_main', 'gen_downtown_backup'}   -- 2 generators
  ```
- **Blackout Rule:** Zone goes dark when ALL generators are sabotaged

#### `lightIntensity` (float: 0.0 - 1.0)
- **Purpose:** Darkness level during blackout
- **Range:** 0.0 (pitch black) to 1.0 (normal light)
- **Recommended:**
  - `0.1-0.2` - Very dark (minimal ambient light)
  - `0.3-0.4` - Dark (some visibility)
  - `0.5+` - Dim (noticeable but not dramatic)

#### `timecycleModifier` (string)
- **Purpose:** Visual filter applied during blackout
- **Options:**
  - `'cinema'` - Dark blue tint (recommended)
  - `'default'` - No filter
  - `'dying'` - Desaturated look
  - `'BlackOut'` - High contrast
  - `'MP_Corona_heist_night'` - Night tint

#### `streetLightsOff` (boolean)
- **Purpose:** Disable street lights in zone
- **Effect:** Calls `SetArtificialLightsState(true)`
- **Recommended:** `true` for realism

#### `vehicleLightsBoost` (boolean)
- **Purpose:** Boost vehicle headlight brightness
- **Effect:** Makes vehicle lights more effective in darkness
- **Recommended:** `true` for downtown, `false` for open areas

---

## ⚡ GENERATORS

**File:** `shared/config.lua`

```lua
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
    }
}
```

### Setting Explanations:

#### Generator Key (`'gen_downtown_main'`)
- **Purpose:** Unique identifier for generator
- **Format:** Lowercase, underscores, descriptive
- **Examples:** `'gen_downtown_main'`, `'gen_beach_backup'`, `'gen_industrial_01'`

#### `coords` (vec3)
- **Purpose:** Generator location in world
- **Format:** `vec3(x, y, z)`
- **How to Get:** Stand at location, use `/getcoords` or similar

#### `heading` (float)
- **Purpose:** Generator rotation (0-360 degrees)
- **Default:** 0.0 (north)

#### `label` (string)
- **Purpose:** Display name for generator
- **Shown:** Interaction prompts, notifications, Discord logs

#### `zone` (string)
- **Purpose:** Zone ID this generator powers
- **Must Match:** A zone key in `Config.PowerZones`

#### `repairTime` (integer, seconds)
- **Purpose:** Time required to complete repair
- **Recommended:** 60-300 seconds
- **Affects:** Minigame duration or progress bar

#### `requiredItems` (table: item array)
- **Purpose:** Items needed to repair generator
- **Format:**
  ```lua
  {
      {item = 'repair_kit', amount = 1},
      {item = 'fuel_can', amount = 2}
  }
  ```
- **Items Consumed:** Yes, on successful repair

#### `requiredJob` (table: string array)
- **Purpose:** Jobs allowed to repair
- **Examples:**
  ```lua
  {'mechanic'}                        -- Only mechanics
  {'mechanic', 'electrician'}         -- Multiple jobs
  {}                                  -- Anyone can repair
  ```

#### `canBeSabotaged` (boolean)
- **Purpose:** Allow criminals to sabotage
- **Values:**
  - `true` - Can be sabotaged
  - `false` - Repair-only generator

#### `sabotageTime` (integer, seconds)
- **Purpose:** Time required to sabotage
- **Recommended:** 30-60 seconds

#### `sabotageItem` (string)
- **Purpose:** Item required for sabotage
- **Default:** `'weapon_stickybomb'`
- **Item Consumed:** Yes, on successful sabotage

#### `blip` (table)
Generator map blip configuration:

- **`sprite`** - Blip icon ID (354 = generator icon)
- **`color`** - Blip color (1-85)
- **`scale`** - Blip size (0.5-1.5)
- **`showWhenOffline`** - Show blip when generator is offline

**Common Blip Colors:**
- `1` - Red (offline)
- `2` - Green (online)
- `3` - Blue
- `5` - Yellow
- `46` - Orange

---

## 🕵️ INTEL NPC SYSTEM

**File:** `shared/config.lua`

```lua
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

Config.IntelData = {
    ['downtown'] = {
        generators = 2,
        difficulty = 'hard',
        estimatedTime = '3-5 Min per Generator',
        hints = {
            'The main generator is located on a high-rise near downtown',
            'A backup generator is hidden near the hospital'
        }
    }
}
```

### Intel NPC Settings:

#### `coords` (vec3)
- **Purpose:** NPC spawn location

#### `heading` (float)
- **Purpose:** NPC facing direction

#### `model` (string)
- **Purpose:** Ped model name
- **Examples:** `'a_m_m_business_01'`, `'s_m_m_scientist_01'`, `'a_m_y_business_02'`

#### `scenario` (string)
- **Purpose:** NPC animation
- **Options:** `'WORLD_HUMAN_SMOKING'`, `'WORLD_HUMAN_STAND_MOBILE'`, `'WORLD_HUMAN_CLIPBOARD'`

#### `intelZones` (table)
- **Purpose:** Zones this NPC has information about
- **Format:** Array of zone IDs

#### `pricePerZone` (table)
- **Purpose:** Cost of intel per zone
- **Format:** `{['zone_id'] = price}`

#### `cooldown` (integer, seconds)
- **Purpose:** Cooldown between intel purchases
- **Default:** 1800 (30 minutes)

### Intel Data Settings:

#### `generators` (integer)
- **Purpose:** Number of generators to repair

#### `difficulty` (string)
- **Purpose:** Difficulty rating shown to player
- **Options:** `'easy'`, `'medium'`, `'hard'`, `'extreme'`

#### `estimatedTime` (string)
- **Purpose:** Time estimate shown to player

#### `hints` (table: string array)
- **Purpose:** Hints/clues about generator locations

---

## 🔒 SECURITY & ANTI-EXPLOIT

**File:** `shared/config.lua`

```lua
Config.Security = {
    maxDistanceFromGenerator = 10.0,       -- Max distance to interact (meters)
    cooldownPerPlayer = 60,                -- Cooldown per player between actions (seconds)
    rateLimit = 5,                         -- Max actions per timeWindow
    timeWindow = 60,                       -- Time window for rate limiting (seconds)
    validateCoords = true,                 -- Validate player coordinates server-side
    logSuspiciousActivity = true,          -- Log potential exploits to Discord
}
```

### Setting Explanations:

#### `maxDistanceFromGenerator` (float, meters)
- **Purpose:** Maximum interaction distance from generator
- **Default:** 10.0
- **Prevents:** Teleport exploits
- **Recommended:** 5.0 - 15.0

#### `cooldownPerPlayer` (integer, seconds)
- **Purpose:** Per-player cooldown between repair/sabotage actions
- **Default:** 60
- **Prevents:** Spam and rapid exploits

#### `rateLimit` (integer)
- **Purpose:** Maximum actions allowed in time window
- **Default:** 5 actions per 60 seconds
- **Prevents:** Bot/script abuse

#### `timeWindow` (integer, seconds)
- **Purpose:** Time window for rate limiting
- **Default:** 60 seconds

#### `validateCoords` (boolean)
- **Purpose:** Validate player position server-side
- **Default:** `true`
- **Prevents:** Coordinate spoofing

#### `logSuspiciousActivity` (boolean)
- **Purpose:** Log potential exploits to Discord
- **Default:** `true`
- **Requires:** Discord webhook configured

---

## ⚡ PERFORMANCE TUNING

**File:** `shared/config.lua`

```lua
Config.Performance = {
    zoneCheckInterval = 1000,              -- Zone check interval (ms)
    effectUpdateInterval = 500,            -- Visual effect update rate (ms)
    blipUpdateInterval = 5000,             -- Blip update rate (ms)
    cacheTimeout = 300,                    -- Cache timeout (seconds)
    useThreadOptimization = true,          -- Optimize threads
}
```

### Setting Explanations:

#### `zoneCheckInterval` (integer, ms)
- **Purpose:** How often to check if player is in blackout zone
- **Default:** 1000 (1 second)
- **Lower:** More responsive, higher CPU usage
- **Higher:** Less responsive, lower CPU usage
- **Recommended:** 500-2000

#### `effectUpdateInterval` (integer, ms)
- **Purpose:** Visual effect update frequency
- **Default:** 500 (0.5 seconds)
- **Affects:** Timecycle, lights, HUD dim

#### `blipUpdateInterval` (integer, ms)
- **Purpose:** Map blip update frequency
- **Default:** 5000 (5 seconds)
- **Higher values:** Better performance

#### `cacheTimeout` (integer, seconds)
- **Purpose:** Cache expiration time
- **Default:** 300 (5 minutes)

#### `useThreadOptimization` (boolean)
- **Purpose:** Enable advanced thread optimizations
- **Default:** `true`
- **Recommended:** Keep enabled

---

## 📡 DISCORD INTEGRATION

**File:** `server/sv_config.lua`

```lua
SVConfig.Discord = {
    enabled = true,
    botName = 'LXR Blackout System',
    botAvatar = 'https://i.imgur.com/yourlogo.png',
    
    webhooks = {
        ['blackout'] = 'YOUR_WEBHOOK_URL',
        ['generator'] = 'YOUR_WEBHOOK_URL',
        ['intel'] = 'YOUR_WEBHOOK_URL'
    },
    
    colors = {
        success = 3066993,   -- Green
        error = 15158332,    -- Red
        warning = 15105570,  -- Orange
        info = 3447003       -- Blue
    }
}
```

### Setting Explanations:

#### `enabled` (boolean)
- **Purpose:** Enable/disable Discord logging
- **Default:** `true`

#### `botName` (string)
- **Purpose:** Name shown in Discord messages

#### `botAvatar` (string)
- **Purpose:** Avatar URL for Discord bot

#### `webhooks` (table)
- **Purpose:** Discord webhook URLs for different event types
- **Types:**
  - `'blackout'` - Zone blackout events
  - `'generator'` - Generator sabotage/repair
  - `'intel'` - Intel purchase events

#### `colors` (table)
- **Purpose:** Discord embed colors (decimal format)
- **Convert:** Hex to decimal (e.g., `#00FF00` → `65280`)

---

## 💡 CONFIGURATION TIPS

### Best Practices:

1. **Start Simple**
   - Begin with 1-2 zones
   - Add more zones once tested
   - Gradually increase complexity

2. **Balance Economy**
   - Repair rewards should be reasonable
   - Intel prices should feel valuable
   - Item costs should match server economy

3. **Test Coordinates**
   - Always test zone boundaries in-game
   - Verify generator locations are accessible
   - Check NPC spawn points

4. **Performance**
   - Start with default performance settings
   - Adjust intervals if needed
   - Monitor server performance

5. **Security**
   - Keep all security features enabled
   - Monitor Discord logs for exploits
   - Adjust cooldowns if needed

### Common Mistakes:

❌ **Zone polygon not closed** - First and last points should connect  
❌ **Duplicate generator IDs** - Each generator needs unique key  
❌ **Wrong zone reference** - Generator `zone` must match zone key  
❌ **Missing items** - Ensure required items exist in inventory  
❌ **Invalid job names** - Job names must match framework jobs  

---

## 🆘 SUPPORT

Need help with configuration?

**Discord:** https://discord.gg/CrKcWdfd3A  
**GitHub:** https://github.com/iBoss21  
**Website:** https://www.wolves.land

---

**Built with 🐺 by The Land of Wolves Community**

```
════════════════════════════════════════════════════════════════════════════
© 2026 The Lux Empire | wolves.land | All Rights Reserved
════════════════════════════════════════════════════════════════════════════
```
