# 🐺 LXR BLACKOUT SYSTEM - OVERVIEW

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
║                      🐺 THE LAND OF WOLVES 🐺                                ║
║                   Georgian RP 🇬🇪 | მგლების მიწა                             ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

## 📋 WHAT IS LXR BLACKOUT?

**LXR Blackout** is a comprehensive regional blackout system for FiveM/RedM that creates immersive power outage gameplay through generator sabotage and repair mechanics. Designed for hardcore roleplay servers, it provides a dynamic and engaging criminal vs. civilian ecosystem with full framework integration.

---

## 🌟 SERVER INFORMATION

```
════════════════════════════════════════════════════════════════════════════
Server:           The Land of Wolves 🐺
Community:        Georgian RP 🇬🇪 | მგლების მიწა
Tagline:          ისტორია ცოცხლდება აქ! (History Lives Here!)
Type:             Serious Hardcore Roleplay
Access:           Discord & Whitelisted
Website:          https://www.wolves.land
Discord:          https://discord.gg/CrKcWdfd3A
GitHub:           https://github.com/iBoss21
Developer:        iBoss21 / The Lux Empire
════════════════════════════════════════════════════════════════════════════
```

---

## 🎯 KEY FEATURES

### ⚡ Regional Blackout Zones
- **PolyZone-Based Boundaries** - Define custom regional areas with polygon zones
- **Multiple Simultaneous Zones** - Support for downtown, industrial, beach areas, etc.
- **Dynamic Visual Boundaries** - Map blips and radius markers show affected areas
- **Zone-Specific Configuration** - Each zone has unique settings, generators, and effects

### 🔧 Generator Management System
- **Multiple Generators Per Zone** - Main and backup power systems
- **Repair Mechanics** - Technicians/mechanics can restore power
- **Sabotage Mechanics** - Criminals can cause blackouts
- **Full Status Tracking** - Track who sabotaged/repaired, when, and where
- **Job Restrictions** - Configurable job requirements for repairs

### 🎮 Advanced Minigame Integration
- **20+ Minigame Types** via MGC (Mini Game Center)
- **Fully Configurable** - Type, difficulty, timer, attempts
- **ox_lib Fallback** - Automatic fallback for compatibility
- **Different Games** - Separate minigames for repair vs. sabotage

**Available Minigame Types:**
```
• safe_crack      • wire_cut        • pattern_lock    • pincode
• skill_bar       • skill_circle    • pulse_sync      • signal_wave
• frequency_jam   • bit_flip        • code_drop       • tile_shift
• circuit_trace   • chip_hack       • keypad_crack    • laser_grid
• memory_match    • sequence_copy   • node_connect    • voltage_adjust
```

### 🎨 Immersive Visual Effects
- **Map Blips** - Red warning blips show active blackout zones
- **Radius Indicators** - Visual zone size indicators on map
- **Server-Wide Notifications** - All players notified of blackouts
- **Particle Effects** - Sparks and smoke during sabotage/repair
- **Sound Effects** - Alarms, power-down, and power-up sounds
- **Street Lights Disabled** - SetArtificialLightsState for realism
- **Dark Timecycle** - Cinema modifier for atmospheric darkness
- **Smooth Transitions** - Gradual effects when entering/leaving zones

### 🕵️ Intel NPC System
- **World-Placed Informants** - NPCs that sell generator locations
- **Paid Information** - Buy intel for specific zones
- **Dynamic Blip Reveals** - Generator locations shown after purchase
- **Cooldown System** - Prevents spam and abuse
- **Time-Limited Intel** - Blips disappear after configured duration

### 🔧 Multi-Framework Support
```
✅ LXR-Core         - Primary framework (wolves.land custom)
✅ RSG-Core         - Full RedM support
✅ VORP Core        - Legacy RedM support
✅ QBox             - Auto-detected
✅ QBCore           - Auto-detected
✅ ESX              - Auto-detected
✅ Auto-Detection   - Automatic framework detection
```

### 💰 Economy Integration
- **Repair Rewards** - Money for successful generator repairs
- **Item Requirements** - repair_kit, fuel_can, etc.
- **Sabotage Items** - weapon_stickybomb required for sabotage
- **Job-Based Pricing** - Different intel prices per zone and job

### 🚨 Police Integration
- **Minimum Police Check** - Requires X cops online for sabotage
- **Dispatch System** - Optional ps-dispatch integration
- **Discord Logging** - All events logged to Discord webhooks
- **Job Counter** - Tracks active police officers
- **txAdmin Integration** - Performance monitoring and logging

### 🔌 Extensive Export System
**15+ Exports** for seamless integration with other scripts:

**Client Exports:**
- `GetBlackoutStatus()` - Check if any zone is in blackout
- `IsZoneInBlackout(zoneId)` - Check specific zone status
- `GetGeneratorState(genId)` - Get generator status details
- `IsPlayerInBlackoutZone()` - Check if player is in blackout
- `GetActiveBlackoutZones()` - Get all active blackout zones
- `GetAllZonesStatus()` - Get comprehensive zone status

**Server Exports:**
- `StartBlackout(zoneId)` - Manually trigger blackout
- `EndBlackout(zoneId)` - Manually end blackout
- `IsZoneInBlackout(zoneId)` - Server-side zone check
- `GetAllZonesStatus()` - Server-side status query
- `GetGeneratorState(genId)` - Server-side generator status
- `SabotageGenerator(genId)` - Sabotage specific generator
- `RepairGenerator(genId)` - Repair specific generator
- `GetJobCount(jobName)` - Count online players with job
- `SendDiscordLog(type, title, message, color, fields)` - Discord logging

---

## 🎮 GAMEPLAY FLOW

### For Technicians/Mechanics 🔧:
1. **Blackout Activated** → Receive notification
2. **Buy Intel (Optional)** → Purchase generator locations from NPC
3. **Travel to Generator** → Navigate to repair location
4. **Complete Minigame** → Repair generator with required items
5. **Receive Reward** → Get paid for restoring power

### For Criminals 💣:
1. **Check Police Count** → Ensure minimum cops online
2. **Acquire Sabotage Items** → Get weapon_stickybomb
3. **Sabotage Generator** → Complete sabotage minigame
4. **Cause Blackout** → When all generators sabotaged
5. **Exploit Darkness** → Rob banks, stores during outage
6. **Evade Police** → Higher risk = higher reward

---

## 💻 TECHNICAL EXCELLENCE

### ⚡ Performance Optimizations
```
• 0.00ms idle performance
• < 0.05ms active performance
• Point-in-polygon checks @ 1s interval
• Event-based synchronization
• Minimal CPU load
• No SQL queries in loops
• Optimized for 500+ player servers
```

### 🔒 Security Features
```
✅ Rate-limiting against spam
✅ Per-player cooldown system
✅ Distance validation checks
✅ Server-side job validation
✅ Server-side item checks
✅ Anti-exploit protection
✅ Server authority model
```

### 🛠️ Configuration
```
✅ Single unified config file
✅ Multi-language support (en, de, ka)
✅ Debug mode for troubleshooting
✅ Feature toggles
✅ Comprehensive documentation
✅ Example configurations included
```

---

## 📦 DEPENDENCIES

### Required Dependencies:
- **ox_lib** - UI, Zones, Callbacks, Notifications
- **oxmysql** - Database operations (optional)
- **Framework** - LXR-Core/RSG-Core/VORP/QBox/QBCore/ESX

### Optional Dependencies:
- **mgc** - Minigames (20+ game types)
- **ox_target** - Interaction system
- **qb-target** - Interaction system (alternative)
- **ps-dispatch** - Police dispatch alerts
- **Discord Webhook** - Event logging

---

## 🚀 USE CASES & INTEGRATION EXAMPLES

### Bank Heist During Blackout
```lua
-- Bank security systems offline during blackout
local isBlackout = exports.lxr_blackout:IsZoneInBlackout('downtown')
if isBlackout then
    -- Disable cameras, alarms, security systems
    StartHeist()
end
```

### Dynamic Shop Prices
```lua
-- Increase prices during blackouts (scarcity!)
if exports.lxr_blackout:IsZoneInBlackout(shopZone) then
    price = basePrice * 1.5
end
```

### Blackout-Only Quests
```lua
-- Special NPCs/quests only appear during blackouts
if exports.lxr_blackout:IsPlayerInBlackoutZone() then
    ShowSpecialQuestNPC()
end
```

### Delayed Police Dispatch
```lua
-- Police alerts delayed during blackouts (no cameras!)
if isBlackout then
    SetTimeout(30000, function() SendDispatch() end)
end
```

---

## 🏷️ TAGS

```
#RedM #FiveM #Georgian #SeriousRP #Blackout #Generator 
#Economy #RPG #LXR #Whitelist #Hardcore #PowerOutage
```

---

## 📖 DOCUMENTATION STRUCTURE

This comprehensive documentation suite includes:

1. **[overview.md](overview.md)** - This file - System overview
2. **[installation.md](installation.md)** - Step-by-step setup guide
3. **[configuration.md](configuration.md)** - Detailed config explanations
4. **[frameworks.md](frameworks.md)** - Framework auto-detection guide
5. **[events.md](events.md)** - Events and unified adapter functions
6. **[security.md](security.md)** - Security and anti-exploit measures
7. **[performance.md](performance.md)** - Performance optimization details
8. **[screenshots.md](screenshots.md)** - Screenshot requirements and assets

---

## 👤 CREDITS & SUPPORT

```
════════════════════════════════════════════════════════════════════════════
Developer:        iBoss21 / The Lux Empire
Original:         MopsScripts (Concept Base)
Organization:     wolves.land
GitHub:           https://github.com/iBoss21
Store:            https://theluxempire.tebex.io
Discord Support:  https://discord.gg/CrKcWdfd3A
════════════════════════════════════════════════════════════════════════════

© 2026 The Lux Empire | wolves.land | All Rights Reserved
════════════════════════════════════════════════════════════════════════════
```

---

## 🐺 JOIN THE PACK

**Experience hardcore Georgian RP at The Land of Wolves:**
- 🌍 Authentic RedM 1899 experience
- 🎭 Serious roleplay community
- 🇬🇪 Georgian cultural immersion
- 🔒 Whitelisted for quality
- 💬 Active Discord community

**Join us:** https://discord.gg/CrKcWdfd3A

---

*Built with 🐺 by The Land of Wolves Community*
