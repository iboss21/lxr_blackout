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
║                   🐺 CLIENT-SIDE MODULES - Land of Wolves 🐺                  ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

# 🐺 Client Folder

**The Land of Wolves** | wolves.land  
Regional Blackout System - Client-Side Components

---

## 📋 Overview

The **client** folder contains all client-side scripts responsible for managing the player's experience during blackout events. These modules handle visual effects, user interfaces, zone detection, NPC interactions, and synchronization with server events.

**Key Responsibilities:**
- Visual blackout effects (darkness, timecycles, lighting)
- Player zone detection and proximity checks
- NPC spawning and interaction management
- UI rendering (timers, notifications, progress bars)
- Client-side event handlers and exports
- Generator interaction interfaces

---

## 📂 File Structure

### 🎯 **main.lua**
**Core Client Initialization & Framework Integration**

- Initializes player state and framework detection
- Handles player load/unload events across frameworks (QBCore, QBox, ESX, LXR-Core, RSG-Core)
- Manages player data synchronization
- Provides utility functions for player status checks
- Sets up framework-specific event listeners

**Key Functions:**
```lua
IsPlayerLoaded()     -- Check if player is loaded
GetPlayerData()      -- Retrieve current player data
```

---

### 🌑 **effects.lua**
**Visual Blackout Effects & Zone Detection**

- Implements point-in-polygon algorithm for zone boundary detection
- Manages blackout zone blips on the map
- Applies visual darkness effects using timecycle modifiers
- Controls lighting intensity and ambient effects during blackouts
- Handles zone entry/exit detection for players
- Creates and removes blackout zone indicators

**Visual Effects Applied:**
- `NG_blackout` timecycle modifier for darkness
- Dynamic lighting intensity adjustments
- Blackout zone blips with configurable colors
- Smooth transitions between normal and blackout states

---

### 🎨 **ui.lua**
**User Interface & HUD Elements**

- Displays blackout countdown timer on-screen
- Renders real-time blackout duration display
- Shows interactive progress bars for generator actions
- Manages notification system for blackout events
- Handles UI text rendering and positioning
- Provides visual feedback during generator interactions

**UI Components:**
- Countdown timer (top-right corner display)
- Progress circles for generator sabotage/repair
- Notification system for zone events
- Custom text overlays with styling

---

### 🗺️ **zones.lua**
**Zone Management & Synchronization**

- Synchronizes blackout zones from server to client
- Manages active zone states and configurations
- Handles zone updates and removals
- Coordinates with effects.lua for visual updates
- Caches zone data for performance optimization
- Listens for server-side zone state changes

**Event Handlers:**
```lua
RegisterNetEvent('hm_blackout:syncZones')
RegisterNetEvent('hm_blackout:updateZone')
RegisterNetEvent('hm_blackout:removeZone')
```

---

### ⚙️ **blackout_zones.lua**
**Client-Side Zone State Management**

- Maintains local cache of blackout zone states
- Handles zone boundary calculations
- Manages zone-specific configurations
- Provides helper functions for zone queries
- Tracks active/inactive zone status
- Supports dynamic zone updates

---

### 👥 **npcs.lua**
**NPC Spawning & Interaction Logic**

- Spawns intel NPCs at configured locations
- Manages NPC behavior and interactions
- Handles NPC targeting system integration
- Controls NPC dialogue and menu systems
- Coordinates with server for intel purchases
- Manages NPC entity lifecycle (spawn/despawn)

**NPC Features:**
- Target system integration (ox_target, qb-target, qtarget)
- Intel purchasing interface
- Dynamic NPC spawning based on configuration
- Networked NPC entities for multiplayer sync

---

### 📤 **exports.lua**
**Client-Side Export Functions**

- Exposes client functions to other resources
- Provides API for external script integration
- Enables third-party resource compatibility
- Offers utility functions for zone queries
- Allows custom UI trigger functions

**Available Exports:**
```lua
exports['lxr_blackout']:IsPlayerInBlackoutZone()
exports['lxr_blackout']:GetActiveBlackoutZones()
exports['lxr_blackout']:ShowNotification(text, type)
```

---

## 🔄 Event Flow

1. **Player Loads** → `main.lua` initializes player state
2. **Server Sends Zones** → `zones.lua` receives and caches zone data
3. **Player Enters Zone** → `effects.lua` detects and applies visual effects
4. **UI Updates** → `ui.lua` displays countdown timer and notifications
5. **Player Interacts** → `npcs.lua` handles NPC interactions
6. **Exports Available** → Other resources can query blackout status

---

## 🎮 Performance Considerations

- **Zone Detection:** Runs at 1-second intervals (configurable)
- **Visual Effects:** Smooth transitions to prevent FPS drops
- **NPC Rendering:** Distance-based culling for optimization
- **UI Rendering:** Only active when blackout is present
- **Event-Based Sync:** Reduces constant server polling

---

## 🌟 Integration Points

### Framework Support
- ✅ LXR-Core (Primary)
- ✅ RSG-Core (Primary)
- ✅ VORP Core (Legacy)
- ✅ QBCore / QBox
- ✅ ESX

### Target Systems
- ✅ ox_target
- ✅ qb-target
- ✅ qtarget

### Notification Systems
- ✅ ox_lib (Primary)
- ✅ QBCore notifications
- ✅ ESX notifications

---

## 🐺 Land of Wolves

**Server:** The Land of Wolves 🐺  
**Community:** Georgian RP 🇬🇪 | მგლების მიწა  
**Website:** [wolves.land](https://wolves.land)  
**Type:** Serious Hardcore Roleplay

---

*Client-side modules designed for immersive blackout gameplay with optimal performance.*
