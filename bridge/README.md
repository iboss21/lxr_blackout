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
║                   🐺 BRIDGE ADAPTERS - Land of Wolves 🐺                      ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

# 🐺 Bridge Folder

**The Land of Wolves** | wolves.land  
Regional Blackout System - Framework & Inventory Bridge Adapters

---

## 📋 Overview

The **bridge** folder contains adapter modules that provide a **unified API** for interacting with different frameworks, inventory systems, and target resources. These bridges enable the LXR Blackout System to work seamlessly across multiple server frameworks without code duplication.

**Key Responsibilities:**
- Multi-framework detection and auto-configuration
- Unified player data access across frameworks
- Inventory system abstraction and item management
- Target system integration for interactions
- Currency/money operations normalization
- Permission and job checking standardization

**Design Philosophy:**
- **Write once, run anywhere** - Single codebase for all frameworks
- **Auto-detection** - Automatically detects available resources
- **Graceful fallback** - Works even if optional systems are missing
- **Performance first** - Minimal overhead from abstraction layer

---

## 📂 File Structure

### 🎮 **framework.lua**
**Multi-Framework Bridge & Auto-Detection System**

The core framework adapter that provides a consistent API for player management, regardless of the underlying framework being used.

#### 🔍 **Auto-Detection Priority**

The system detects frameworks in this order:
1. **LXR-Core** (Priority 1) - Land of Wolves Custom Framework
2. **RSG-Core** (Priority 2) - RedM Standard Framework
3. **VORP Core** (Legacy) - VORP Framework Support
4. **QBox** (Auto-detected) - QBCore Fork
5. **QBCore** (Auto-detected) - QB Framework
6. **ESX** (Auto-detected) - ESX Framework

#### 📡 **Unified Framework API**

```lua
Framework.Name              -- Returns detected framework name
Framework.Object            -- Direct framework object access

-- Player Management
Framework:GetPlayerData()           -- Get current player data
Framework:GetPlayer(source)         -- Get player object (server)
Framework:GetPlayerIdentifier(src)  -- Get unique identifier
Framework:GetPlayerJob(source)      -- Get player job info
Framework:HasPermission(src, perm)  -- Check admin permissions

-- Money Operations (Server)
Framework:GetMoney(source, type)    -- Get player money
Framework:AddMoney(source, amount)  -- Add money to player
Framework:RemoveMoney(src, amount)  -- Remove money from player

-- Item Operations (Server)
Framework:GetItem(source, item)     -- Get item count
Framework:AddItem(source, item, amt) -- Add item to player
Framework:RemoveItem(src, item, amt) -- Remove item from player
```

#### 🔧 **Framework-Specific Implementations**

##### **LXR-Core / RSG-Core**
```lua
Framework.Name = 'lxr-core' or 'rsg-core'
Framework.Object = exports['lxr-core']:GetCoreObject()

-- Uses modern exports-based architecture
-- Job system integrated
-- Permission system via player metadata
```

##### **VORP Core**
```lua
Framework.Name = 'vorp'
Framework.Object = exports.vorp_core:GetCore()

-- Legacy VORP API support
-- Character-based system
-- Inventory integration via VORP inventory
```

##### **QBCore / QBox**
```lua
Framework.Name = 'qbcore' or 'qbox'
Framework.Object = exports['qb-core']:GetCoreObject()

-- QB-style player management
-- Job and gang system support
-- Metadata and item handling
```

##### **ESX**
```lua
Framework.Name = 'esx'
Framework.Object = exports['es_extended']:getSharedObject()

-- ESX player object handling
-- Account system (cash, bank)
-- Job and society integration
```

#### 🎯 **Usage Examples**

**Client-side:**
```lua
-- Check if player is loaded
if Framework:IsPlayerLoaded() then
    local playerData = Framework:GetPlayerData()
    print("Player job:", playerData.job.name)
end
```

**Server-side:**
```lua
-- Get player and check money
local Player = Framework:GetPlayer(source)
if Player then
    local money = Framework:GetMoney(source, 'cash')
    if money >= 500 then
        Framework:RemoveMoney(source, 500)
        Framework:AddItem(source, 'intel_map', 1)
    end
end
```

---

### 🎒 **inventory.lua**
**Multi-Inventory System Bridge**

Provides a unified interface for item management across different inventory systems, eliminating the need for system-specific code.

#### 🔍 **Auto-Detection Priority**

The system detects inventory systems in this order:
1. **ox_inventory** (Priority 1) - Modern ox_lib inventory
2. **tgiann-inventory** - TGiann's custom inventory
3. **qb-inventory** - QBCore standard inventory
4. **ps-inventory** - Project Sloth inventory
5. **qs-inventory** - Quasar inventory
6. **Framework Default** - Falls back to framework inventory

#### 📦 **Unified Inventory API**

```lua
Inventory.Name              -- Returns detected inventory name

-- Item Operations
Inventory:HasItem(source, item, count)     -- Check if player has item
Inventory:GetItemCount(source, item)       -- Get item quantity
Inventory:AddItem(source, item, count)     -- Add item to inventory
Inventory:RemoveItem(source, item, count)  -- Remove item from inventory
Inventory:CanCarryItem(source, item, amt)  -- Check if player has space

-- Metadata Operations
Inventory:SetItemMetadata(src, slot, data) -- Set item metadata
Inventory:GetItemMetadata(src, slot)       -- Get item metadata

-- Inventory State
Inventory:GetInventory(source)             -- Get full inventory
Inventory:GetWeight(source)                -- Get current weight
Inventory:GetMaxWeight(source)             -- Get max carry weight
```

#### 🎯 **Usage Examples**

**Check and consume repair item:**
```lua
-- Server-side generator repair
if Inventory:HasItem(source, 'repair_kit', 1) then
    Inventory:RemoveItem(source, 'repair_kit', 1)
    -- Proceed with repair
else
    TriggerClientEvent('ox_lib:notify', source, {
        title = 'Missing Item',
        description = 'You need a repair kit',
        type = 'error'
    })
end
```

**Add intel map to player:**
```lua
-- Server-side intel purchase
if Inventory:CanCarryItem(source, 'intel_map', 1) then
    Inventory:AddItem(source, 'intel_map', 1)
else
    -- Notify player inventory is full
end
```

#### 🔧 **Inventory-Specific Features**

##### **ox_inventory**
- Modern exports-based API
- Metadata support for items
- Weight-based carry limits
- Item durability system
- Shop integration

##### **qb-inventory / ps-inventory / qs-inventory**
- QB-style item management
- Slot-based inventory
- Item images and labels
- Crafting integration

##### **tgiann-inventory**
- Custom inventory system
- Advanced item properties
- Weight and slot management

---

### 🎯 **target.lua**
**Multi-Target System Bridge**

Provides unified interaction system for generator targeting and NPC interactions across different target resources.

#### 🔍 **Auto-Detection Priority**

1. **ox_target** (Priority 1) - Modern ox_lib target system
2. **qb-target** - QBCore target system
3. **qtarget** - Alternative QB target
4. **Framework Default** - Native interaction fallback

#### 🎯 **Unified Target API**

```lua
Target.Name                 -- Returns detected target system

-- Entity Targeting
Target:AddEntityZone(entity, options)     -- Add target to entity
Target:RemoveEntityZone(entity)           -- Remove entity target

-- Box Zones
Target:AddBoxZone(name, coords, options)  -- Create box zone
Target:RemoveZone(name)                   -- Remove zone

-- Circle Zones
Target:AddCircleZone(name, coords, opts)  -- Create circle zone

-- Model Targeting
Target:AddTargetModel(models, options)    -- Target specific models
Target:RemoveTargetModel(models)          -- Remove model targeting
```

#### 🎯 **Usage Examples**

**Target generator for interaction:**
```lua
-- Client-side generator targeting
Target:AddEntityZone(generatorEntity, {
    name = 'generator_' .. zoneId,
    options = {
        {
            icon = 'fas fa-wrench',
            label = 'Sabotage Generator',
            canInteract = function()
                return not IsGeneratorOffline(zoneId)
            end,
            action = function()
                TriggerEvent('hm_blackout:sabotageGenerator', zoneId)
            end
        },
        {
            icon = 'fas fa-tools',
            label = 'Repair Generator',
            canInteract = function()
                return IsGeneratorOffline(zoneId)
            end,
            action = function()
                TriggerEvent('hm_blackout:repairGenerator', zoneId)
            end
        }
    },
    distance = 2.5
})
```

**Target NPC for intel purchase:**
```lua
-- Client-side NPC targeting
Target:AddEntityZone(npcEntity, {
    name = 'intel_npc_' .. npcId,
    options = {
        {
            icon = 'fas fa-info-circle',
            label = 'Buy Intel ($500)',
            action = function()
                TriggerEvent('hm_blackout:openIntelMenu')
            end
        }
    },
    distance = 2.0
})
```

---

### 🛠️ **utils.lua**
**Shared Utility Functions**

Common helper functions used across bridge adapters for validation, formatting, and compatibility.

#### 🔧 **Utility Functions**

```lua
-- Framework Detection
Utils.GetFrameworkName()           -- Returns current framework
Utils.IsFrameworkLoaded(name)      -- Check if framework exists

-- Data Validation
Utils.ValidateSource(source)       -- Validate player source
Utils.ValidateCoords(coords)       -- Validate coordinate data
Utils.ValidateItem(itemName)       -- Check if item exists

-- Formatting
Utils.FormatMoney(amount)          -- Format money display
Utils.FormatTime(seconds)          -- Format time (MM:SS)
Utils.FormatCoords(vector)         -- Format coordinates

-- Math & Distance
Utils.GetDistance(coords1, coords2) -- Calculate 3D distance
Utils.IsNearCoords(player, target, dist) -- Proximity check

-- String Operations
Utils.Trim(str)                    -- Remove whitespace
Utils.Split(str, delimiter)        -- Split string
Utils.Capitalize(str)              -- Capitalize first letter
```

---

### 🗂️ **framework_old.lua**
**Legacy Framework Bridge Archive**

- Contains previous framework bridge implementation
- Preserved for backward compatibility reference
- Not actively loaded by the system
- Used for migration troubleshooting
- **Do not modify unless reverting changes**

---

## 🔄 Bridge Architecture

### **Abstraction Layers**

```
┌─────────────────────────────────────────┐
│     LXR Blackout System Core Code      │
├─────────────────────────────────────────┤
│          Unified Bridge API             │
├──────────┬──────────┬──────────┬────────┤
│ Framework│ Inventory│  Target  │ Utils  │
├──────────┼──────────┼──────────┼────────┤
│ LXR-Core │ ox_inv   │ox_target │ Helpers│
│ RSG-Core │ qb-inv   │qb-target │ Format │
│ VORP     │ ps-inv   │ qtarget  │ Validate│
│ QBCore   │ qs-inv   │ native   │ Math   │
│ ESX      │ native   │          │        │
└──────────┴──────────┴──────────┴────────┘
```

### **Load Order**

1. `framework.lua` loads first
2. `inventory.lua` detects based on framework
3. `target.lua` loads and registers zones
4. `utils.lua` provides helpers to all

---

## 🎯 Adding New Framework Support

**Steps to add a new framework:**

1. **Edit framework.lua:**
```lua
-- Add detection
if GetResourceState('new-framework') == 'started' then
    Framework.Name = 'new-framework'
    Framework.Object = exports['new-framework']:GetCore()
end
```

2. **Implement required functions:**
```lua
function Framework:GetPlayer(source)
    if self.Name == 'new-framework' then
        return self.Object.GetPlayer(source)
    end
end
```

3. **Test all bridge functions**
4. **Update documentation**

---

## 🐺 Land of Wolves

**Server:** The Land of Wolves 🐺  
**Community:** Georgian RP 🇬🇪 | მგლების მიწა  
**Website:** [wolves.land](https://wolves.land)  
**Type:** Serious Hardcore Roleplay

---

*Bridge adapters engineered for maximum compatibility and zero vendor lock-in.*
