# 🐺 LXR BLACKOUT SYSTEM - FRAMEWORK GUIDE

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
║                 🐺 MULTI-FRAMEWORK ADAPTER SYSTEM 🐺                         ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

---

## 📋 OVERVIEW

LXR Blackout features a **sophisticated multi-framework adapter system** that provides seamless compatibility across all major FiveM and RedM frameworks. The system automatically detects your framework and provides a unified API, eliminating compatibility issues.

---

## 🎯 SUPPORTED FRAMEWORKS

### ✅ **Fully Supported**

| Framework | Version | Priority | Resource Name | Type |
|-----------|---------|----------|---------------|------|
| **LXR-Core** | Latest | 🥇 Priority 1 | `lxr-core` | RedM Custom |
| **RSG-Core** | Latest | 🥈 Priority 2 | `rsg-core` | RedM Standard |
| **VORP Core** | 1.0+ | ✅ Supported | `vorp_core` | RedM Legacy |
| **QBox** | Latest | ✅ Auto-detect | `qbx_core` | FiveM Modern |
| **QBCore** | Latest | ✅ Auto-detect | `qb-core` | FiveM Standard |
| **ESX** | Legacy/1.x | ✅ Auto-detect | `es_extended` | FiveM Legacy |

---

## 🔍 AUTO-DETECTION SYSTEM

### How It Works

The framework bridge automatically detects your framework on resource start:

```lua
-- Detection Priority Order:
1. LXR-Core      → Check for 'lxr-core' resource
2. RSG-Core      → Check for 'rsg-core' resource
3. VORP Core     → Check for 'vorp_core' resource
4. QBox          → Check for 'qbx_core' resource
5. QBCore        → Check for 'qb-core' resource
6. ESX           → Check for 'es_extended' resource
```

### Console Output

When the resource starts, you'll see:

```
[LXR-BLACKOUT] 🔍 Detecting framework...
[LXR-BLACKOUT] ✅ Found RSG-Core (resource: rsg-core)
[LXR-BLACKOUT] 🎯 Framework initialized: RSG-Core
```

### Manual Override

If auto-detection fails, set manually in `shared/config.lua`:

```lua
Config.Framework = 'rsg'  -- Force RSG-Core
-- Options: 'auto', 'lxr', 'rsg', 'vorp', 'qbox', 'qbcore', 'esx'
```

---

## 🔧 FRAMEWORK ADAPTER LAYER

### Unified API

The adapter provides consistent functions regardless of framework:

```lua
-- These work the same across ALL frameworks:
Framework.GetPlayerData(source)      -- Get player data
Framework.GetPlayerJob(source)       -- Get player job
Framework.AddMoney(source, amount)   -- Add money
Framework.RemoveMoney(source, amount)-- Remove money
Framework.HasItem(source, item)      -- Check inventory
Framework.RemoveItem(source, item)   -- Remove item
Framework.Notify(source, message)    -- Send notification
```

### Behind the Scenes

The adapter translates calls to framework-specific implementations:

```lua
-- Example: AddMoney() translation

-- LXR-Core:    Player.Functions.AddMoney('cash', amount)
-- RSG-Core:    Player.Functions.AddMoney('cash', amount)
-- VORP:        Character.addCurrency(0, amount)
-- QBCore:      Player.Functions.AddMoney('cash', amount)
-- ESX:         xPlayer.addMoney(amount)
```

---

## 📚 FRAMEWORK-SPECIFIC DETAILS

### 🐺 LXR-Core (wolves.land Custom)

**Priority:** 1 (Highest)  
**Resource:** `lxr-core`  
**Type:** RedM Custom Framework

**Key Features:**
- Custom Georgian RP mechanics
- Specialized for wolves.land server
- Extended player data structures
- Custom job system

**Events:**
```lua
'lxr-core:client:player:loaded'    -- Player loaded
'lxr-core:client:player:unload'    -- Player unload
'lxr-core:client:job:update'       -- Job changed
```

**Export:**
```lua
local LXR = exports['lxr-core']:GetCoreObject()
```

---

### 🐎 RSG-Core (RedM Standard)

**Priority:** 2  
**Resource:** `rsg-core`  
**Type:** RedM Standard Framework

**Key Features:**
- RedM 1899 optimized
- Standard RedM job system
- Full inventory integration
- Stable and widely used

**Events:**
```lua
'RSGCore:Client:OnPlayerLoaded'    -- Player loaded
'RSGCore:Client:OnPlayerUnload'    -- Player unload
'RSGCore:Client:OnJobUpdate'       -- Job changed
```

**Export:**
```lua
local RSGCore = exports['rsg-core']:GetCoreObject()
```

---

### 🤠 VORP Core (RedM Legacy)

**Priority:** 3  
**Resource:** `vorp_core`  
**Type:** RedM Legacy Framework

**Key Features:**
- Established RedM framework
- Large ecosystem of scripts
- Mature and stable
- Wide community support

**Events:**
```lua
'vorp:SelectedCharacter'           -- Player loaded
'vorp:PlayerLogout'                -- Player logout
```

**Callback:**
```lua
TriggerEvent('vorp:getCharacter', source, function(user)
    -- Character data
end)
```

---

### 📦 QBox (FiveM Modern)

**Priority:** 4  
**Resource:** `qbx_core`  
**Type:** FiveM Modern Framework

**Key Features:**
- Modern QBCore fork
- Optimized performance
- Enhanced features
- Active development

**Events:**
```lua
'QBCore:Client:OnPlayerLoaded'     -- Player loaded
'QBCore:Client:OnPlayerUnload'     -- Player unload
'QBCore:Client:OnJobUpdate'        -- Job changed
```

**Export:**
```lua
local QBX = exports['qbx_core']:GetCoreObject()
```

---

### 🎮 QBCore (FiveM Standard)

**Priority:** 5  
**Resource:** `qb-core`  
**Type:** FiveM Standard Framework

**Key Features:**
- Most popular FiveM framework
- Huge script ecosystem
- Extensive documentation
- Large community

**Events:**
```lua
'QBCore:Client:OnPlayerLoaded'     -- Player loaded
'QBCore:Client:OnPlayerUnload'     -- Player unload
'QBCore:Client:OnJobUpdate'        -- Job changed
```

**Export:**
```lua
local QBCore = exports['qb-core']:GetCoreObject()
```

---

### 🏛️ ESX (FiveM Legacy)

**Priority:** 6  
**Resource:** `es_extended`  
**Type:** FiveM Legacy Framework

**Key Features:**
- Original FiveM framework
- Massive script library
- Well-documented
- Stable and reliable

**Events:**
```lua
'esx:playerLoaded'                 -- Player loaded
'esx:onPlayerLogout'               -- Player logout
```

**Export:**
```lua
ESX = exports['es_extended']:getSharedObject()
```

---

## 🌉 BRIDGE ARCHITECTURE

### File Structure

```
bridge/
├── framework.lua      # Framework detection & adapter
├── inventory.lua      # Inventory system adapter
├── target.lua         # Target system adapter (ox_target, qb-target)
└── utils.lua          # Utility functions
```

### Framework Bridge (`bridge/framework.lua`)

**Responsibilities:**
- Auto-detect framework
- Provide unified API
- Handle framework events
- Manage player data

**Key Functions:**
```lua
Framework.GetPlayerData(source)
Framework.GetPlayerJob(source)
Framework.GetPlayerJobLabel(source)
Framework.AddMoney(source, amount, account)
Framework.RemoveMoney(source, amount, account)
Framework.Notify(source, message, type)
Framework.GetOnlineJobCount(jobName)
```

### Inventory Bridge (`bridge/inventory.lua`)

**Supported Inventories:**
- ox_inventory
- tgiann-inventory
- qb-inventory
- ps-inventory
- qs-inventory
- core_inventory

**Key Functions:**
```lua
Inventory.HasItem(source, item, amount)
Inventory.RemoveItem(source, item, amount)
Inventory.AddItem(source, item, amount)
Inventory.GetItemCount(source, item)
```

### Target Bridge (`bridge/target.lua`)

**Supported Systems:**
- ox_target
- qb-target

**Key Functions:**
```lua
Target.AddBoxZone(id, coords, options)
Target.RemoveZone(id)
```

---

## 📋 FRAMEWORK CONFIGURATION

### Config Structure

Each framework has specific settings in `shared/config.lua`:

```lua
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
    -- ... other frameworks
}
```

### Adding Custom Frameworks

To add support for a custom framework:

1. **Add framework to config:**
```lua
Config.FrameworkSettings['myframework'] = {
    resourceName = 'my-framework',
    events = {
        playerLoaded = 'myframework:playerLoaded',
        playerUnload = 'myframework:playerUnload'
    },
    exports = {
        getCore = 'GetCore'
    }
}
```

2. **Add detection in priority list:**
```lua
local FrameworkPriority = {
    { name = 'MyFramework', resource = 'my-framework', export = 'GetCore' },
    -- ... existing frameworks
}
```

3. **Implement adapter functions** in `bridge/framework.lua`

---

## 🔄 EVENT SYNCHRONIZATION

### Player Events

The adapter listens to framework-specific events and provides unified handlers:

```lua
-- Automatically translated to framework-specific events:
'blackout:playerLoaded'    -- Player spawned and ready
'blackout:playerUnload'    -- Player left server
'blackout:jobUpdate'       -- Player job changed
```

### Example Event Mapping

```lua
-- RSG-Core Event:
RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
    -- Trigger unified event
    TriggerEvent('blackout:playerLoaded')
end)

-- VORP Event:
RegisterNetEvent('vorp:SelectedCharacter', function()
    -- Trigger unified event
    TriggerEvent('blackout:playerLoaded')
end)
```

---

## 🧪 TESTING FRAMEWORK DETECTION

### In-Game Commands

Test framework detection with these commands:

```lua
-- Check detected framework
/lua print(Framework.Name)

-- Check framework object
/lua print(json.encode(Framework.Object))

-- Test player data
/lua local data = Framework.GetPlayerData(GetPlayerServerId(PlayerId()))
/lua print(json.encode(data))
```

### Console Verification

Check server console for:
```
[LXR-BLACKOUT] ✅ Framework initialized: [Framework Name]
```

---

## ⚠️ TROUBLESHOOTING

### Framework Not Detected

**Problem:** `❌ No framework detected!`

**Solutions:**
1. Verify framework resource is started
2. Check resource name matches supported list
3. Force framework manually:
   ```lua
   Config.Framework = 'your_framework'
   ```

### Wrong Framework Detected

**Problem:** Script detects wrong framework

**Solutions:**
1. Check multiple frameworks aren't running
2. Adjust detection priority
3. Force correct framework in config

### Export Errors

**Problem:** `attempt to call a nil value (global 'exports')`

**Solutions:**
1. Ensure framework is fully started
2. Check export function name
3. Verify framework version compatibility

### Event Not Firing

**Problem:** Player events not triggering

**Solutions:**
1. Check event names match framework
2. Verify framework events are working
3. Enable debug mode to see event logs

---

## 📖 DEVELOPER REFERENCE

### Adding New Framework Functions

To extend the adapter with new functions:

```lua
-- In bridge/framework.lua

function Framework.CustomFunction(source, args)
    if Framework.Name == 'RSG-Core' then
        -- RSG-Core implementation
    elseif Framework.Name == 'VORP' then
        -- VORP implementation
    elseif Framework.Name == 'QBCore' then
        -- QBCore implementation
    -- ... other frameworks
    end
end
```

### Framework-Specific Code

When you need framework-specific code:

```lua
if Framework.Name == 'LXR-Core' then
    -- LXR-Core specific code
elseif Framework.Name == 'RSG-Core' then
    -- RSG-Core specific code
else
    -- Fallback for other frameworks
end
```

---

## 🆘 SUPPORT

Need help with framework integration?

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
