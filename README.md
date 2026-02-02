```
╔══════════════════════════════════════════════════════════════════════════════╗
║                                                                              ║
║    ██╗      █████╗ ███╗   ██╗██████╗      ██████╗ ███████╗                  ║
║    ██║     ██╔══██╗████╗  ██║██╔══██╗    ██╔═══██╗██╔════╝                  ║
║    ██║     ███████║██╔██╗ ██║██║  ██║    ██║   ██║█████╗                    ║
║    ██║     ██╔══██║██║╚██╗██║██║  ██║    ██║   ██║██╔══╝                    ║
║    ███████╗██║  ██║██║ ╚████║██████╔╝    ╚██████╔╝██║                       ║
║    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝      ╚═════╝ ╚═╝                       ║
║                                                                              ║
║    ██╗    ██╗ ██████╗ ██╗    ██╗   ██╗███████╗███████╗                      ║
║    ██║    ██║██╔═══██╗██║    ██║   ██║██╔════╝██╔════╝                      ║
║    ██║ █╗ ██║██║   ██║██║    ██║   ██║█████╗  ███████╗                      ║
║    ██║███╗██║██║   ██║██║    ╚██╗ ██╔╝██╔══╝  ╚════██║                      ║
║    ╚███╔███╔╝╚██████╔╝███████╗╚████╔╝ ███████╗███████║                      ║
║     ╚══╝╚══╝  ╚═════╝ ╚══════╝ ╚═══╝  ╚══════╝╚══════╝                      ║
║                                                                              ║
║                    🐺 LXR BLACKOUT SYSTEM 🐺                                 ║
║              Regional Blackout System with Generator Management             ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

<div align="center">

[![RedM](https://img.shields.io/badge/RedM-1899-d32936?style=for-the-badge&logo=rockstargames&logoColor=white)](https://redm.net)
[![FiveM](https://img.shields.io/badge/FiveM-Compatible-00c3ff?style=for-the-badge&logo=fivem&logoColor=white)](https://fivem.net)
[![Version](https://img.shields.io/badge/Version-3.0.0-blue?style=for-the-badge)](https://github.com/iBoss21/lxr_blackout)
[![License](https://img.shields.io/badge/License-Commercial-gold?style=for-the-badge)](LICENSE)

[![LXR-Core](https://img.shields.io/badge/Framework-LXR--Core-purple?style=for-the-badge)](https://wolves.land)
[![RSG-Core](https://img.shields.io/badge/Framework-RSG--Core-red?style=for-the-badge)](https://github.com/Rexshack-RedM)
[![VORP](https://img.shields.io/badge/Framework-VORP-orange?style=for-the-badge)](https://github.com/VORPCORE)
[![QBCore](https://img.shields.io/badge/Framework-QBCore-green?style=for-the-badge)](https://github.com/qbcore-framework)
[![ESX](https://img.shields.io/badge/Framework-ESX-yellow?style=for-the-badge)](https://github.com/esx-framework)

**[🐺 Website](https://www.wolves.land)** • 
**[💬 Discord](https://discord.gg/CrKcWdfd3A)** • 
**[🛒 Store](https://theluxempire.tebex.io)** • 
**[📚 Documentation](docs/)** • 
**[📸 Screenshots](docs/screenshots.md)**

</div>

---

## 🌟 Server Information

```
════════════════════════════════════════════════════════════════════════════
Server:           The Land of Wolves 🐺
Community:        Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!
Tagline:          ისტორია ცოცხლდება აქ! (History Lives Here!)
Type:             Serious Hardcore Roleplay
Access:           Discord & Whitelisted
Website:          https://www.wolves.land
Discord:          https://discord.gg/CrKcWdfd3A
Server Listing:   https://servers.redm.net/servers/detail/8gj7eb
════════════════════════════════════════════════════════════════════════════
```

## 📋 Overview

**LXR Blackout** is a comprehensive regional blackout system for **FiveM/RedM** that creates immersive power outage gameplay through generator sabotage and repair mechanics. Designed for hardcore roleplay servers, it provides a dynamic and engaging criminal vs. civilian ecosystem with **full multi-framework support**.

Experience authentic power grid failures, generator management, intel gathering, and strategic gameplay - all optimized for **0.00ms idle performance** and built for production servers.

---

## ⚡ Quick Start

1. **Download** the latest release
2. **Extract** `lxr_blackout` to your resources folder
3. **Add** `ensure lxr_blackout` to your `server.cfg`
4. **Import** SQL file (if using database features)
5. **Configure** `shared/config.lua` to your needs
6. **Restart** your server

📖 **Detailed Setup Guide:** [Installation Documentation](docs/installation.md)

---

## ✨ Key Features

### 🗺️ **Regional Blackout Zones**
🐺 **PolyZone-Based Boundaries** - Define custom regional areas with polygon zones  
🐺 **Multiple Simultaneous Zones** - Support for downtown, industrial, beach areas, etc.  
🐺 **Dynamic Visual Boundaries** - Map blips and radius markers show affected areas  
🐺 **Zone-Specific Configuration** - Each zone has unique settings and generators

### ⚡ **Generator Management System**
🔧 **Multiple Generators Per Zone** - Main and backup power systems  
🔧 **Repair Mechanics** - Technicians/mechanics can restore power  
💣 **Sabotage Mechanics** - Criminals can cause blackouts  
📊 **Full Status Tracking** - Track who sabotaged/repaired, when, and where  
🛡️ **Job Restrictions** - Configurable job requirements for repairs

### 🎮 **Advanced Minigame Integration**
🎯 **20+ Minigame Types** via MGC (Mini Game Center)  
⚙️ **Fully Configurable** - Type, difficulty, timer, attempts  
🔄 **ox_lib Fallback** - Automatic fallback for compatibility  
🎪 **Different Games** - Separate minigames for repair vs. sabotage

**Available Minigame Types:**
```
safe_crack • wire_cut • pattern_lock • pincode • skill_bar • skill_circle
pulse_sync • signal_wave • frequency_jam • bit_flip • code_drop • tile_shift
circuit_trace • chip_hack • keypad_crack • laser_grid • memory_match
sequence_copy • node_connect • voltage_adjust
```

### 🎨 **Immersive Visual Effects**
🚨 **Map Blips** - Red warning blips show active blackout zones  
📍 **Radius Indicators** - Visual zone size indicators on map  
📢 **Server-Wide Notifications** - All players notified of blackouts  
✨ **Particle Effects** - Sparks and smoke during sabotage/repair  
🔊 **Sound Effects** - Alarms, power-down, and power-up sounds  
💡 **Street Lights Disabled** - SetArtificialLightsState for realism  
🌃 **Dark Timecycle** - Cinema modifier for atmospheric darkness  
🌊 **Smooth Transitions** - Gradual effects when entering/leaving zones

### 🕵️ **Intel NPC System**
🗣️ **World-Placed Informants** - NPCs that sell generator locations  
💰 **Paid Information** - Buy intel for specific zones  
📍 **Dynamic Blip Reveals** - Generator locations shown after purchase  
⏱️ **Cooldown System** - Prevents spam and abuse  
⏳ **Time-Limited Intel** - Blips disappear after configured duration

### 🔧 **Multi-Framework Support**
```
✅ LXR-Core         - Primary framework (wolves.land custom)
✅ RSG-Core         - Full RedM support  
✅ VORP Core        - Legacy RedM support
✅ QBox             - Auto-detected
✅ QBCore           - Auto-detected
✅ ESX              - Auto-detected
✅ Auto-Detection   - Automatic framework detection at runtime
```

### 💰 **Economy Integration**
💵 **Repair Rewards** - Money for successful generator repairs  
🛠️ **Item Requirements** - repair_kit, fuel_can, etc.  
�� **Sabotage Items** - weapon_stickybomb required for sabotage  
💼 **Job-Based Pricing** - Different intel prices per zone and job

### 🚨 **Police Integration**
👮 **Minimum Police Check** - Requires X cops online for sabotage  
📡 **Dispatch System** - Optional ps-dispatch integration  
📝 **Discord Logging** - All events logged to Discord webhooks  
👥 **Job Counter** - Tracks active police officers  
📊 **txAdmin Integration** - Performance monitoring and logging

### 🔌 **Extensive Export System**
**15+ Exports** for seamless integration with other scripts

**Client Exports:**
```lua
exports.lxr_blackout:GetBlackoutStatus()              -- Check if any zone is in blackout
exports.lxr_blackout:IsZoneInBlackout(zoneId)        -- Check specific zone status
exports.lxr_blackout:GetGeneratorState(genId)        -- Get generator status details
exports.lxr_blackout:IsPlayerInBlackoutZone()        -- Check if player is in blackout
exports.lxr_blackout:GetActiveBlackoutZones()        -- Get all active blackout zones
exports.lxr_blackout:GetAllZonesStatus()             -- Get comprehensive zone status
```

**Server Exports:**
```lua
exports.lxr_blackout:StartBlackout(zoneId)           -- Manually trigger blackout
exports.lxr_blackout:EndBlackout(zoneId)             -- Manually end blackout
exports.lxr_blackout:IsZoneInBlackout(zoneId)        -- Server-side zone check
exports.lxr_blackout:SabotageGenerator(genId)        -- Sabotage specific generator
exports.lxr_blackout:RepairGenerator(genId)          -- Repair specific generator
exports.lxr_blackout:GetJobCount(jobName)            -- Count online players with job
```

📖 **Full Export Documentation:** [EXPORTS.md](EXPORTS.md)

---

## 🎮 Gameplay Flow

### 🔧 For Technicians/Mechanics:
1. **Blackout Activated** → Receive notification
2. **Buy Intel (Optional)** → Purchase generator locations from NPC
3. **Travel to Generator** → Navigate to repair location with required items
4. **Complete Minigame** → Repair generator with skill-based challenge
5. **Receive Reward** → Get paid for restoring power to the zone

### 💣 For Criminals:
1. **Check Police Count** → Ensure minimum cops online
2. **Acquire Sabotage Items** → Get weapon_stickybomb
3. **Sabotage Generator** → Complete sabotage minigame at generator
4. **Cause Blackout** → When all generators in zone are sabotaged
5. **Exploit Darkness** → Rob banks, stores during outage (no cameras/alarms)
6. **Evade Police** → Higher risk = higher reward

---

## 💻 Technical Excellence

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

## 📦 Dependencies

### Required:
- **[ox_lib](https://github.com/overextended/ox_lib)** - UI, Zones, Callbacks, Notifications
- **[oxmysql](https://github.com/overextended/oxmysql)** - Database operations (optional)
- **Framework** - LXR-Core/RSG-Core/VORP/QBox/QBCore/ESX

### Optional:
- **[mgc](https://github.com/MopsScripts/mgc)** - Minigames (20+ game types)
- **[ox_target](https://github.com/overextended/ox_target)** - Interaction system
- **[qb-target](https://github.com/qbcore-framework/qb-target)** - Interaction system (alternative)
- **[ps-dispatch](https://github.com/Project-Sloth/ps-dispatch)** - Police dispatch alerts
- **Discord Webhook** - Event logging

---

## 🚀 Integration Examples

### 🏦 Bank Heist During Blackout
```lua
-- Bank security systems offline during blackout
RegisterNetEvent('bank:startHeist', function()
    local isBlackout = exports.lxr_blackout:IsZoneInBlackout('downtown')
    
    if not isBlackout then
        lib.notify({
            title = 'Security Active',
            description = 'Security systems are online!',
            type = 'error'
        })
        return
    end
    
    -- Start heist with disabled cameras/alarms
    StartBankHeist()
end)
```

### 💰 Dynamic Shop Prices
```lua
-- Increase prices during blackouts (scarcity!)
local function GetItemPrice(itemName)
    local basePrice = Config.Prices[itemName]
    local shopZone = GetCurrentShopZone()
    
    if exports.lxr_blackout:IsZoneInBlackout(shopZone) then
        return basePrice * 1.5 -- 50% markup during blackouts
    end
    
    return basePrice
end
```

### 🎯 Blackout-Only Quests
```lua
-- Special NPCs/quests only appear during blackouts
CreateThread(function()
    while true do
        Wait(5000)
        
        if exports.lxr_blackout:IsPlayerInBlackoutZone() then
            SpawnBlackoutQuestNPC()
        else
            RemoveBlackoutQuestNPC()
        end
    end
end)
```

### 🚨 Delayed Police Dispatch
```lua
-- Police alerts delayed during blackouts (no cameras!)
function SendPoliceAlert(location, crime)
    local isBlackout = exports.lxr_blackout:IsZoneInBlackout(GetZoneFromCoords(location))
    
    if isBlackout then
        -- 30 second delay during blackouts
        SetTimeout(30000, function()
            TriggerDispatch(location, crime)
        end)
    else
        -- Instant dispatch with working systems
        TriggerDispatch(location, crime)
    end
end
```

---

## 📸 Screenshots

![Blackout System Banner](https://s1.directupload.eu/images/260117/s7ygcb82.png)

### 📷 More Screenshots & Media
For comprehensive screenshots including:
- System initialization & console output
- Configuration examples
- In-game UI interactions
- Framework detection
- Discord webhook logs
- Performance metrics

**👉 View Full Gallery:** [Screenshots Documentation](docs/screenshots.md)

---

## 📚 Documentation

Comprehensive documentation is available in the `/docs` directory:

- **[📖 Overview](docs/overview.md)** - System overview and features
- **[📥 Installation](docs/installation.md)** - Step-by-step setup guide
- **[⚙️ Configuration](docs/configuration.md)** - Detailed config explanations
- **[🔧 Frameworks](docs/frameworks.md)** - Framework auto-detection guide
- **[📡 Events](docs/events.md)** - Events and unified adapter functions
- **[🔒 Security](docs/security.md)** - Security and anti-exploit measures
- **[⚡ Performance](docs/performance.md)** - Performance optimization details
- **[📸 Screenshots](docs/screenshots.md)** - Screenshot requirements and assets

📘 **Quick Links:**
- [INSTALLATION.md](INSTALLATION.md) - Quick setup guide
- [EXPORTS.md](EXPORTS.md) - Full export documentation
- [MINIGAMES.md](MINIGAMES.md) - Minigame configuration
- [BUGFIX.md](BUGFIX.md) - Known issues and fixes

---

## 🏷️ Tags & Keywords

```
#RedM #FiveM #Georgian #SeriousRP #Blackout #Generator #PowerOutage
#Economy #RPG #LXR #Whitelist #Hardcore #RoleplayServer #wolves.land
#LXRCore #RSGCore #VORP #QBCore #ESX #MultiFramework
```

---

## 🐺 Community & Support

### Join The Land of Wolves

Experience hardcore **Georgian RP** at **The Land of Wolves**:

🌍 **Authentic RedM 1899 Experience**  
🎭 **Serious Roleplay Community**  
🇬🇪 **Georgian Cultural Immersion** - მგლების მიწა  
🔒 **Whitelisted for Quality**  
💬 **Active Discord Community**  
📚 **Professional Development Resources**

### Links

🌐 **Website:** [https://www.wolves.land](https://www.wolves.land)  
💬 **Discord:** [https://discord.gg/CrKcWdfd3A](https://discord.gg/CrKcWdfd3A)  
🎮 **Server Listing:** [https://servers.redm.net/servers/detail/8gj7eb](https://servers.redm.net/servers/detail/8gj7eb)  
🛒 **Store:** [https://theluxempire.tebex.io](https://theluxempire.tebex.io)  
💻 **GitHub:** [https://github.com/iBoss21](https://github.com/iBoss21)

### Support

Need help? We've got you covered:

- 📖 **Documentation** - Check the `/docs` directory first
- 💬 **Discord Support** - Join our Discord for live help
- 🐛 **Bug Reports** - Open an issue on GitHub
- 💡 **Feature Requests** - Discuss in our Discord community

---

## 👤 Credits

```
════════════════════════════════════════════════════════════════════════════
Developer:        iBoss21 / The Lux Empire
Original:         MopsScripts (Concept Base)
Organization:     wolves.land - The Land of Wolves
Community:        Georgian RP 🇬🇪 | მგლების მიწა
GitHub:           https://github.com/iBoss21
Store:            https://theluxempire.tebex.io
Discord Support:  https://discord.gg/CrKcWdfd3A
════════════════════════════════════════════════════════════════════════════
```

### Special Thanks

🙏 **MopsScripts** - Original blackout concept inspiration  
🙏 **Overextended** - ox_lib & oxmysql frameworks  
🙏 **The Land of Wolves Community** - Testing and feedback  
🙏 **Georgian RP Community** - Cultural authenticity guidance

---

## 📜 License

**Commercial License** - © 2026 The Lux Empire | wolves.land

This resource is licensed for use on **The Land of Wolves** server and authorized partners. Unauthorized redistribution, resale, or modification for commercial purposes is prohibited without explicit written permission from The Lux Empire.

For licensing inquiries: [Discord Support](https://discord.gg/CrKcWdfd3A)

---

## 🌟 Georgian RP Theme

**მგლების მიწა - რჩეულთა ადგილი!** (The Land of Wolves - Place of the Chosen!)

This system is built for hardcore roleplay servers emphasizing:

🐺 **Wolf Pack Mentality** - Community-driven gameplay  
⚔️ **High-Stakes Consequences** - Actions have weight  
🎭 **Immersive Storytelling** - Every blackout tells a story  
🇬🇪 **Cultural Authenticity** - Georgian pride and heritage  
🏔️ **Wilderness Survival** - Power failures in harsh environments

**ისტორია ცოცხლდება აქ!** - *History Lives Here!*

---

<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════════╗
║                                                                              ║
║               Built with 🐺 by The Land of Wolves Community                  ║
║                                                                              ║
║                    © 2026 The Lux Empire | wolves.land                       ║
║                          All Rights Reserved                                 ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

**[⬆ Back to Top](#)**

</div>
