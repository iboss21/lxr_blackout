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
║                   🐺 SERVER-SIDE MODULES - Land of Wolves 🐺                  ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

# 🐺 Server Folder

**The Land of Wolves** | wolves.land  
Regional Blackout System - Server-Side Components

---

## 📋 Overview

The **server** folder contains all server-side scripts responsible for managing blackout events, generator states, player permissions, logging, and data persistence. These modules handle the core game logic, database operations, and synchronization across all clients.

**Key Responsibilities:**
- Blackout event management and scheduling
- Generator state tracking and manipulation
- Player action authorization and validation
- Database operations and data persistence
- Discord webhook logging and notifications
- Admin command processing
- Server-wide event broadcasting

---

## 📂 File Structure

### 🎯 **main.lua**
**Core Server Initialization & Resource Management**

- Resource startup validation and version checks
- ox_lib dependency verification
- Framework and inventory detection display
- Resource shutdown cleanup handlers
- Startup banner with system information
- Core initialization sequence

**Startup Display:**
```lua
HM BLACKOUT - v1.0.0
Framework: LXR-Core
Inventory: ox_inventory
Status: RUNNING
```

---

### ⚡ **blackout.lua**
**Blackout Event Logic & Zone Management**

- Manages active blackout zones and states
- Handles blackout start/stop/toggle operations
- Coordinates zone-wide power outages
- Tracks blackout duration and expiration
- Broadcasts zone state changes to all clients
- Implements automatic blackout termination
- Manages zone-specific blackout configurations

**Core Functions:**
```lua
StartBlackout(zoneId)      -- Initiate blackout in zone
StopBlackout(zoneId)       -- End blackout in zone
ToggleBlackout(zoneId)     -- Toggle zone blackout state
GetActiveBlackouts()       -- Query active blackout zones
```

**Event Broadcasting:**
- Syncs blackout states to all connected clients
- Notifies players when entering/exiting blackout zones
- Updates zone timers in real-time

---

### ⚙️ **generator.lua**
**Generator State Management & Interactions**

- Tracks generator online/offline status per zone
- Handles generator sabotage actions
- Manages generator repair operations
- Validates player proximity to generators
- Implements item consumption for repairs
- Controls generator respawn timers
- Enforces cooldowns between actions

**Generator Actions:**
- **Sabotage:** Takes generator offline, triggers blackout
- **Repair:** Restores generator, ends blackout (requires repair items)
- **Status Check:** Query generator operational state

**Item Integration:**
```lua
Config.GeneratorRepairItem   -- Required item for repairs
Config.GeneratorCooldown      -- Action cooldown period
```

---

### 🎮 **commands.lua**
**Admin Commands & Management Interface**

- Registers admin commands for blackout control
- Permission-based command access
- Manual blackout triggering/stopping
- Generator state manipulation
- Debug commands for testing
- Player notification systems

**Available Commands:**
```lua
/blackout [zone]           -- Toggle blackout in zone
/blackout-start [zone]     -- Start blackout
/blackout-stop [zone]      -- Stop blackout
/generator-reset [zone]    -- Reset all generators
/blackout-status           -- Show all blackout states
```

**Permission Groups:**
- Configurable via `Config.AdminGroups`
- Framework-specific permission integration
- ACE permission support

---

### 🔌 **callbacks.lua**
**Client-Server Communication Bridge**

- Registers ox_lib callbacks for client requests
- Handles intel purchase transactions
- Processes generator interaction requests
- Validates player actions before execution
- Returns generator locations to clients
- Manages player currency/item checks

**Registered Callbacks:**
```lua
'hm_blackout:buyIntel'        -- Purchase generator intel
'hm_blackout:sabotageGen'     -- Sabotage generator
'hm_blackout:repairGen'       -- Repair generator
'hm_blackout:getGenerators'   -- Get generator locations
```

---

### 🔍 **npc_intel.lua**
**Intel System & Information Trading**

- Manages NPC intel purchase system
- Validates player funds for purchases
- Provides generator location information
- Coordinates with inventory bridge for payments
- Handles intel cooldowns per player
- Sends generator coordinates to clients

**Intel Features:**
- Cost: Configurable via `Config.IntelCost`
- Cooldown: Prevents spam purchases
- Data: Returns generator locations for active zones
- Payment: Framework-specific currency deduction

---

### 📤 **exports.lua**
**Server-Side Export Functions**

- Exposes server functions to other resources
- Provides API for external resource integration
- Enables custom blackout triggers from other scripts
- Allows zone state queries from external systems
- Offers generator control for advanced scenarios

**Available Exports:**
```lua
exports['lxr_blackout']:StartBlackout(zoneId)
exports['lxr_blackout']:StopBlackout(zoneId)
exports['lxr_blackout']:GetGeneratorStatus(zoneId)
exports['lxr_blackout']:IsZoneInBlackout(zoneId)
```

---

### 📊 **discord.lua**
**Discord Webhook Integration & Logging**

- Sends formatted webhook messages to Discord
- Logs generator sabotage events
- Logs generator repair events
- Logs admin command usage
- Logs blackout start/stop events
- Dispatch system integration (ps-dispatch)

**Webhook Types:**
```lua
generator     -- Generator-related events
admin         -- Admin actions
blackout      -- Blackout state changes
```

**Logged Events:**
- 🚨 Generator sabotage with player details
- 🔧 Generator repairs with timestamp
- 🌑 Blackout initiated/terminated
- 👮 Dispatch alerts for police notification

**Color Coding:**
- ✅ Success (Green)
- ⚠️ Warning (Orange)
- ❌ Error (Red)
- ℹ️ Info (Blue)

---

### ⚙️ **sv_config.lua**
**Server-Specific Configuration**

- Server-only configuration settings
- Discord webhook URLs and credentials
- Bot name and avatar configuration
- Color schemes for embed messages
- Admin permission groups
- Server-side feature toggles

**Configuration Sections:**
```lua
SVConfig.Discord.enabled          -- Enable/disable logging
SVConfig.Discord.webhooks         -- Webhook URLs
SVConfig.Discord.colors           -- Embed colors
SVConfig.Discord.botName          -- Bot display name
SVConfig.Discord.botAvatar        -- Bot avatar URL
```

**Security Notes:**
- Contains sensitive webhook URLs
- Should not be shared publicly
- Configure before deployment

---

## 🔄 Event Flow

1. **Resource Starts** → `main.lua` initializes system
2. **Player Sabotages Generator** → `generator.lua` processes action
3. **Blackout Triggered** → `blackout.lua` activates zone blackout
4. **Clients Synced** → All players receive zone state updates
5. **Discord Logged** → `discord.lua` sends webhook notification
6. **Timer Expires** → `blackout.lua` automatically ends blackout
7. **Generator Repaired** → `generator.lua` restores power

---

## 💾 Data Persistence

- Generator states saved during runtime
- Blackout timers tracked in memory
- Player intel cooldowns session-based
- Zone configurations loaded from shared config

---

## 🔒 Security Features

- **Permission Validation:** All admin commands require authorization
- **Proximity Checks:** Generator actions require player proximity
- **Item Verification:** Repair items validated before consumption
- **Cooldown Enforcement:** Prevents action spam and exploits
- **Event Validation:** Server validates all client requests

---

## 📡 Integration Points

### Framework Support
- ✅ LXR-Core (Primary)
- ✅ RSG-Core (Primary)
- ✅ VORP Core (Legacy)
- ✅ QBCore / QBox
- ✅ ESX

### Dispatch Systems
- ✅ ps-dispatch (Police notifications)
- ✅ Custom webhook logging

### Callback Libraries
- ✅ ox_lib callbacks (Primary)
- ✅ Framework-specific callbacks

---

## 🐺 Land of Wolves

**Server:** The Land of Wolves 🐺  
**Community:** Georgian RP 🇬🇪 | მგლების მიწა  
**Website:** [wolves.land](https://wolves.land)  
**Type:** Serious Hardcore Roleplay

---

*Server-side modules engineered for reliable, secure, and scalable blackout management.*
