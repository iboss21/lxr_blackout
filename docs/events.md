# 🐺 LXR BLACKOUT SYSTEM - EVENTS REFERENCE

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
║                      🐺 EVENTS REFERENCE 🐺                                  ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

---

## 📋 OVERVIEW

This document provides a comprehensive reference for all events used in the LXR Blackout system, including client events, server events, and framework-specific events.

---

## 📡 CLIENT EVENTS

### Zone Events

#### `hm_blackout:zoneStateChanged`
**Type:** Client Event (Broadcast)  
**Triggered:** When a zone's blackout state changes

```lua
RegisterNetEvent('hm_blackout:zoneStateChanged', function(zoneId, active, intensity)
    -- Parameters:
    -- zoneId (string): Zone identifier ('downtown', 'vespucci', etc.)
    -- active (boolean): true = blackout active, false = power restored
    -- intensity (float): Light intensity during blackout (0.0-1.0)
end)
```

**Example Usage:**
```lua
RegisterNetEvent('hm_blackout:zoneStateChanged', function(zoneId, active, intensity)
    if active then
        print('Blackout started in: ' .. zoneId)
        -- Disable security cameras in this zone
        -- Increase criminal activity spawns
    else
        print('Power restored in: ' .. zoneId)
        -- Re-enable security systems
    end
end)
```

---

### Generator Events

#### `hm_blackout:generatorSabotaged`
**Type:** Client Event (Broadcast)  
**Triggered:** When a generator is successfully sabotaged

```lua
RegisterNetEvent('hm_blackout:generatorSabotaged', function(genId)
    -- Parameters:
    -- genId (string): Generator identifier ('gen_downtown_main', etc.)
end)
```

**Example Usage:**
```lua
RegisterNetEvent('hm_blackout:generatorSabotaged', function(genId)
    -- Play explosion effects
    -- Update local generator state
    -- Check if zone is now in blackout
end)
```

---

#### `hm_blackout:generatorRepaired`
**Type:** Client Event (Broadcast)  
**Triggered:** When a generator is successfully repaired

```lua
RegisterNetEvent('hm_blackout:generatorRepaired', function(genId)
    -- Parameters:
    -- genId (string): Generator identifier
end)
```

**Example Usage:**
```lua
RegisterNetEvent('hm_blackout:generatorRepaired', function(genId)
    -- Play repair success effects
    -- Update generator blip color to green
    -- Show "Power Restored" notification
end)
```

---

#### `hm_blackout:startRepair`
**Type:** Client Event  
**Triggered:** Server tells client to start repair minigame

```lua
RegisterNetEvent('hm_blackout:startRepair', function(genId, repairTime)
    -- Parameters:
    -- genId (string): Generator identifier
    -- repairTime (integer): Time to complete repair (seconds)
end)
```

---

#### `hm_blackout:startSabotageMinigame`
**Type:** Client Event  
**Triggered:** Server tells client to start sabotage minigame

```lua
RegisterNetEvent('hm_blackout:startSabotageMinigame', function(genId, sabotageTime)
    -- Parameters:
    -- genId (string): Generator identifier
    -- sabotageTime (integer): Time to complete sabotage (seconds)
end)
```

---

### Intel Events

#### `hm_blackout:receiveIntel`
**Type:** Client Event  
**Triggered:** After player purchases intel from NPC

```lua
RegisterNetEvent('hm_blackout:receiveIntel', function(zoneId, intelData)
    -- Parameters:
    -- zoneId (string): Zone identifier
    -- intelData (table): Intel information
    --   {
    --     generators = 2,
    --     difficulty = 'hard',
    --     estimatedTime = '3-5 Min',
    --     hints = { 'hint1', 'hint2' }
    --   }
end)
```

**Example Usage:**
```lua
RegisterNetEvent('hm_blackout:receiveIntel', function(zoneId, intelData)
    -- Show generator blips on map
    -- Display intel information in UI
    -- Start timer for blip duration
end)
```

---

## 🖥️ SERVER EVENTS

### Generator Actions

#### `hm_blackout:sabotageGenerator`
**Type:** Server Event  
**Triggered:** When player attempts to sabotage generator

```lua
RegisterNetEvent('hm_blackout:sabotageGenerator', function(genId)
    -- Parameters:
    -- genId (string): Generator identifier
    -- source (implicit): Player server ID
end)
```

**Server-Side Validation:**
- Distance check from generator
- Police count requirement
- Item possession check
- Cooldown validation
- Rate limiting

---

#### `hm_blackout:repairGenerator`
**Type:** Server Event  
**Triggered:** When player attempts to repair generator

```lua
RegisterNetEvent('hm_blackout:repairGenerator', function(genId)
    -- Parameters:
    -- genId (string): Generator identifier
    -- source (implicit): Player server ID
end)
```

**Server-Side Validation:**
- Distance check from generator
- Job requirement check
- Item possession check
- Cooldown validation
- Generator state check

---

### Intel Purchase

#### `hm_blackout:buyIntel`
**Type:** Server Event  
**Triggered:** When player purchases intel from NPC

```lua
RegisterNetEvent('hm_blackout:buyIntel', function(npcId, zoneId)
    -- Parameters:
    -- npcId (string): NPC identifier
    -- zoneId (string): Zone to get intel for
    -- source (implicit): Player server ID
end)
```

**Server-Side Validation:**
- Money check
- Cooldown check
- Distance from NPC check

---

### Dispatch Event

#### `hm_blackout:sendDispatch`
**Type:** Server Event (Internal)  
**Triggered:** When generator sabotage triggers police dispatch

```lua
RegisterNetEvent('hm_blackout:sendDispatch', function(coords, label)
    -- Parameters:
    -- coords (vector3): Location of sabotage
    -- label (string): Generator label
end)
```

---

## 🔧 FRAMEWORK-SPECIFIC EVENTS

### Player Lifecycle Events

The adapter system translates these framework events to unified blackout events:

#### LXR-Core Events
```lua
'lxr-core:client:player:loaded'    -- Player spawned
'lxr-core:client:player:unload'    -- Player left
'lxr-core:client:job:update'       -- Job changed
```

#### RSG-Core Events
```lua
'RSGCore:Client:OnPlayerLoaded'    -- Player spawned
'RSGCore:Client:OnPlayerUnload'    -- Player left
'RSGCore:Client:OnJobUpdate'       -- Job changed
```

#### VORP Events
```lua
'vorp:SelectedCharacter'           -- Character selected
'vorp:PlayerLogout'                -- Player logout
```

#### QBCore/QBox Events
```lua
'QBCore:Client:OnPlayerLoaded'     -- Player spawned
'QBCore:Client:OnPlayerUnload'     -- Player left
'QBCore:Client:OnJobUpdate'        -- Job changed
```

#### ESX Events
```lua
'esx:playerLoaded'                 -- Player loaded
'esx:onPlayerLogout'               -- Player logout
```

---

## 🔄 EVENT FLOW DIAGRAMS

### Generator Sabotage Flow

```
[Player] → Press Interaction Key
    ↓
[Client] → TriggerServerEvent('hm_blackout:sabotageGenerator', genId)
    ↓
[Server] → Validate (distance, police, items, cooldown)
    ↓
[Server] → TriggerClientEvent('hm_blackout:startSabotageMinigame', source)
    ↓
[Client] → Play Minigame
    ↓ (Success)
[Client] → Complete Sabotage
    ↓
[Server] → TriggerClientEvent('hm_blackout:generatorSabotaged', -1, genId)
    ↓
[All Clients] → Update Generator State
    ↓
[Server] → Check Zone Blackout Status
    ↓ (All generators sabotaged)
[Server] → TriggerClientEvent('hm_blackout:zoneStateChanged', -1, zoneId, true)
    ↓
[All Clients] → Activate Blackout Effects
```

### Generator Repair Flow

```
[Player] → Press Interaction Key
    ↓
[Client] → TriggerServerEvent('hm_blackout:repairGenerator', genId)
    ↓
[Server] → Validate (distance, job, items, cooldown)
    ↓
[Server] → TriggerClientEvent('hm_blackout:startRepair', source)
    ↓
[Client] → Play Minigame / Progress Bar
    ↓ (Success)
[Client] → Complete Repair
    ↓
[Server] → TriggerClientEvent('hm_blackout:generatorRepaired', -1, genId)
    ↓
[All Clients] → Update Generator State
    ↓
[Server] → Check Zone Blackout Status
    ↓ (At least one generator online)
[Server] → TriggerClientEvent('hm_blackout:zoneStateChanged', -1, zoneId, false)
    ↓
[All Clients] → Deactivate Blackout Effects
```

### Intel Purchase Flow

```
[Player] → Interact with NPC
    ↓
[Client] → Show Zone Selection Menu
    ↓
[Player] → Select Zone
    ↓
[Client] → TriggerServerEvent('hm_blackout:buyIntel', npcId, zoneId)
    ↓
[Server] → Validate (money, cooldown, distance)
    ↓
[Server] → Deduct Money
    ↓
[Server] → TriggerClientEvent('hm_blackout:receiveIntel', source, zoneId, data)
    ↓
[Client] → Show Generator Blips
    ↓
[Client] → Display Intel Information
    ↓
[Timer] → Remove Blips After Duration
```

---

## 🔌 UNIFIED ADAPTER FUNCTIONS

The bridge system provides unified functions that work across all frameworks:

### Player Functions
```lua
Framework.GetPlayerData(source)          -- Get player data
Framework.GetPlayerJob(source)           -- Get player job
Framework.GetPlayerJobLabel(source)      -- Get job label
Framework.GetPlayerName(source)          -- Get player name
```

### Money Functions
```lua
Framework.AddMoney(source, amount)       -- Add money
Framework.RemoveMoney(source, amount)    -- Remove money
Framework.GetMoney(source)               -- Get player money
```

### Inventory Functions
```lua
Inventory.HasItem(source, item, amount)  -- Check item
Inventory.RemoveItem(source, item, amt)  -- Remove item
Inventory.AddItem(source, item, amount)  -- Add item
Inventory.GetItemCount(source, item)     -- Get item count
```

### Notification Functions
```lua
Framework.Notify(source, message, type)  -- Send notification
-- type: 'success', 'error', 'info', 'warning'
```

### Job Functions
```lua
Framework.GetOnlineJobCount(jobName)     -- Count online players with job
Framework.HasJob(source, jobName)        -- Check if player has job
```

---

## 📝 INTEGRATION EXAMPLES

### Example 1: Custom Blackout Detection

```lua
-- In your custom script
RegisterNetEvent('hm_blackout:zoneStateChanged', function(zoneId, active, intensity)
    if zoneId == 'downtown' and active then
        -- Downtown blackout active
        -- Disable ATM machines
        DisableATMs()
        
        -- Increase criminal NPC spawns
        IncreaseGangActivity()
        
        -- Disable security cameras
        for _, camera in ipairs(DowntownCameras) do
            camera:SetDisabled(true)
        end
    elseif not active then
        -- Power restored
        EnableATMs()
        RestoreNormalActivity()
    end
end)
```

### Example 2: Custom Dispatch System

```lua
-- In your dispatch resource
RegisterNetEvent('hm_blackout:sendDispatch', function(coords, label)
    local source = source
    
    -- Send custom dispatch alert
    TriggerEvent('my-dispatch:alert', {
        title = 'Generator Sabotage',
        coords = coords,
        description = label .. ' has been sabotaged!',
        icon = 'generator',
        color = 'red',
        jobs = {'police', 'sheriff'}
    })
end)
```

### Example 3: Bank Heist Integration

```lua
-- In your bank heist script
RegisterNetEvent('bank:attemptHeist', function(bankId)
    local source = source
    local bankZone = Banks[bankId].zone
    
    -- Check if zone is in blackout using export
    local isBlackout = exports.lxr_blackout:IsZoneInBlackout(bankZone)
    
    if not isBlackout then
        TriggerClientEvent('bank:notify', source, 
            'Security systems online! Wait for blackout.', 
            'error'
        )
        return
    end
    
    -- Start heist with no security
    StartHeist(source, bankId, {
        cameras = false,
        alarms = false,
        doors = 'unlocked'
    })
end)
```

### Example 4: Dynamic Pricing

```lua
-- In your shop script
RegisterNetEvent('shop:buyItem', function(shopId, itemId)
    local source = source
    local shop = Shops[shopId]
    local item = Items[itemId]
    
    -- Check if shop is in blackout zone
    local zoneId = GetShopZone(shopId)
    local isBlackout = exports.lxr_blackout:IsZoneInBlackout(zoneId)
    
    local price = item.basePrice
    
    if isBlackout then
        -- 50% markup during blackout (scarcity!)
        price = price * 1.5
    end
    
    -- Process purchase
    ProcessPurchase(source, itemId, price)
end)
```

---

## 🆘 SUPPORT

Need help with events or integration?

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
