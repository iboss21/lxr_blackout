# 🐺 LXR BLACKOUT SYSTEM - INSTALLATION GUIDE

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
║                      🐺 INSTALLATION GUIDE 🐺                                ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

---

## ⚡ QUICK START (5 Minutes)

### Step 1: Download & Extract
```bash
# Extract lxr_blackout.zip to your resources folder
resources/
└── lxr_blackout/
    ├── bridge/
    ├── client/
    ├── docs/
    ├── locales/
    ├── server/
    ├── shared/
    ├── fxmanifest.lua
    └── README.md
```

### Step 2: Check Dependencies
```bash
# Ensure ox_lib is installed
resources/
├── ox_lib/          # ✅ REQUIRED
├── oxmysql/         # ✅ REQUIRED (for database)
└── lxr_blackout/    # 🐺 This resource
```

### Step 3: Configure server.cfg
```cfg
# Add these lines to your server.cfg:
ensure ox_lib
ensure oxmysql
ensure lxr_blackout

# ACE Permissions (Admin Commands)
add_ace group.admin command.blackout allow
add_ace group.admin command.generators allow
add_ace group.admin command.resetgenerators allow
```

### Step 4: Resource Name (CRITICAL!)
```bash
# The resource folder MUST be named exactly:
lxr_blackout

# ❌ WRONG: LXR_Blackout, lxr-blackout, blackout
# ✅ CORRECT: lxr_blackout
```

### Step 5: Configure Settings
Edit `lxr_blackout/shared/config.lua`:
```lua
-- Basic settings you should check:
Config.Framework = 'auto'  -- Auto-detect framework
Config.Lang = 'en'         -- Language: 'en', 'de', 'ka'

-- Adjust coordinates for your server map
Config.PowerZones = {
    ['downtown'] = {
        -- Update polygon points for your map
    }
}
```

### Step 6: Discord Webhooks (Optional)
Edit `lxr_blackout/server/sv_config.lua`:
```lua
SVConfig.Discord.enabled = true
SVConfig.Discord.webhooks = {
    ['blackout'] = 'YOUR_WEBHOOK_URL_HERE',
    ['generator'] = 'YOUR_WEBHOOK_URL_HERE',
    ['intel'] = 'YOUR_WEBHOOK_URL_HERE'
}
```

### Step 7: Start Server
```bash
# Restart your server or use:
restart lxr_blackout

# Check console for:
# ✅ [LXR-BLACKOUT] Framework initialized: [FrameworkName]
# ✅ [LXR-BLACKOUT] System loaded successfully
```

### Step 8: Test In-Game
```
1. Join server
2. Type: /blackout start downtown 1800
3. Navigate to a generator location
4. Press E to interact (repair/sabotage)
5. Complete the minigame
```

---

## 📦 DETAILED INSTALLATION

### Framework Compatibility

**Automatic Framework Detection** - No manual configuration needed!

Supported frameworks (in priority order):
```
1. LXR-Core       ✅ Primary framework (wolves.land)
2. RSG-Core       ✅ RedM standard
3. VORP Core      ✅ RedM legacy
4. QBox           ✅ Auto-detected
5. QBCore         ✅ Auto-detected
6. ESX            ✅ Auto-detected
```

The script will automatically detect and initialize the first available framework.

### Inventory Compatibility

**Automatic Inventory Detection** - Works with all major inventory systems!

Supported inventories:
```
✅ ox_inventory
✅ tgiann-inventory
✅ qb-inventory
✅ ps-inventory
✅ qs-inventory
✅ core_inventory
```

### Required Items Setup

Add these items to your inventory system:

#### ox_inventory (`ox_inventory/data/items.lua`):
```lua
['repair_kit'] = {
    label = 'Repair Kit',
    weight = 1000,
    stack = true,
    close = true,
    description = 'Tool kit for repairing generators',
    client = {
        image = 'repair_kit.png',
    }
},

['fuel_can'] = {
    label = 'Fuel Canister',
    weight = 2000,
    stack = true,
    close = true,
    description = 'Fuel for powering generators',
    client = {
        image = 'fuel_can.png',
    }
},

['weapon_stickybomb'] = {
    label = 'Sticky Bomb',
    weight = 500,
    stack = false,
    close = true,
    description = 'Explosive device for sabotage',
    client = {
        image = 'weapon_stickybomb.png',
    }
},
```

#### QBCore (`qb-core/shared/items.lua`):
```lua
repair_kit = {
    name = 'repair_kit',
    label = 'Repair Kit',
    weight = 1000,
    type = 'item',
    image = 'repair_kit.png',
    unique = false,
    useable = false,
    shouldClose = true,
    combinable = nil,
    description = 'Tool kit for repairing generators'
},

fuel_can = {
    name = 'fuel_can',
    label = 'Fuel Canister',
    weight = 2000,
    type = 'item',
    image = 'fuel_can.png',
    unique = false,
    useable = false,
    shouldClose = true,
    combinable = nil,
    description = 'Fuel for powering generators'
},
```

#### ESX (`es_extended/config.lua` or database):
```sql
-- Add to your items database
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('repair_kit', 'Repair Kit', 1, 0, 1),
('fuel_can', 'Fuel Canister', 2, 0, 1),
('weapon_stickybomb', 'Sticky Bomb', 1, 0, 1);
```

### Database Setup (Optional)

If you want persistent generator states across restarts:

```sql
-- Execute this SQL in your database:
CREATE TABLE IF NOT EXISTS `lxr_blackout_generators` (
    `id` VARCHAR(50) NOT NULL,
    `repaired` TINYINT(1) DEFAULT 1,
    `sabotaged_by` VARCHAR(50) DEFAULT NULL,
    `sabotaged_at` BIGINT DEFAULT NULL,
    `repaired_by` VARCHAR(50) DEFAULT NULL,
    `repaired_at` BIGINT DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

**Note:** Database is optional. Without it, generator states reset on server restart.

---

## 🔧 CONFIGURATION CHECKLIST

### Essential Configuration Steps:

- [ ] **Resource Name** - Verify folder is named `lxr_blackout`
- [ ] **Dependencies** - Ensure ox_lib and oxmysql are installed
- [ ] **server.cfg** - Add resource and ACE permissions
- [ ] **Framework** - Verify your framework is supported
- [ ] **Items** - Add repair_kit, fuel_can to inventory
- [ ] **Coordinates** - Update zone and generator locations for your map
- [ ] **Jobs** - Configure job requirements in config
- [ ] **Discord** - Set up webhooks (optional)
- [ ] **Minigames** - Install MGC if you want 20+ minigame options (optional)

### Optional Configuration Steps:

- [ ] **Language** - Set `Config.Lang` to your preferred language
- [ ] **Intel NPCs** - Configure informant locations
- [ ] **Police Requirements** - Set minimum police count
- [ ] **Rewards** - Adjust repair reward amounts
- [ ] **Timings** - Configure repair/sabotage durations
- [ ] **Visual Effects** - Customize timecycle modifiers
- [ ] **Dispatch** - Set up ps-dispatch integration

---

## 🎮 MINIGAME INTEGRATION (Optional)

### Option 1: Using ox_lib (Default)
No additional setup required. The script uses ox_lib's built-in skillCheck by default.

### Option 2: Using MGC (Mini Game Center)
For 20+ advanced minigame types:

1. **Install MGC** (Mini Game Center)
2. **Enable in config:**
```lua
Config.Minigames = {
    enabled = true,  -- Set to true to use MGC
    repair = {
        type = 'bit_flip',  -- Choose from 20+ types
        difficulty = 3,     -- 1-5
    },
    sabotage = {
        type = 'circuit_trace',
        timer = 30000,
        chances = 3
    }
}
```

3. **Available game types:**
```
safe_crack, wire_cut, pattern_lock, pincode, skill_bar,
skill_circle, pulse_sync, signal_wave, frequency_jam,
bit_flip, code_drop, tile_shift, circuit_trace, chip_hack,
keypad_crack, laser_grid, memory_match, sequence_copy,
node_connect, voltage_adjust
```

See **[MINIGAMES.md](../MINIGAMES.md)** for detailed documentation.

---

## 🚨 TROUBLESHOOTING

### Resource Name Error
```
ERROR: This resource MUST be named exactly: lxr_blackout
```
**Solution:** Rename the resource folder to exactly `lxr_blackout`

### Framework Not Detected
```
❌ No framework detected!
```
**Solution:** 
- Ensure your framework resource is started
- Check framework resource name matches supported list
- Try setting `Config.Framework = 'your_framework'` manually

### Items Not Found
```
Player doesn't have required items
```
**Solution:**
- Add repair_kit and fuel_can to your inventory
- Check item names match your inventory system
- Give items manually: `/giveitem [id] repair_kit 5`

### Minigame Not Working
```
Minigame failed to start
```
**Solution:**
- If using MGC, ensure it's installed and started
- Set `Config.Minigames.enabled = false` to use ox_lib fallback
- Check console for errors

### Discord Webhooks Not Working
```
Discord logs not appearing
```
**Solution:**
- Verify webhook URLs are correct
- Ensure `SVConfig.Discord.enabled = true`
- Check Discord server webhook permissions
- Test webhook with curl/Postman

### Performance Issues
```
Server lag or high resource usage
```
**Solution:**
- Check `Config.General.enableDebug = false`
- Reduce number of zones if needed
- Optimize zone polygon points
- Check for conflicting resources

---

## 📞 SUPPORT

### Getting Help

1. **Check Documentation**
   - Read all docs in `/docs/` folder
   - Check [BUGFIX.md](../BUGFIX.md) for known issues
   - Review [EXPORTS.md](../EXPORTS.md) for integration

2. **Discord Support**
   - Join: https://discord.gg/CrKcWdfd3A
   - Open a support ticket
   - Provide: console logs, config, errors

3. **GitHub Issues**
   - Report bugs: https://github.com/iBoss21
   - Include: FiveM/RedM version, framework, error logs
   - Provide: steps to reproduce

---

## ✅ POST-INSTALLATION VERIFICATION

After installation, verify everything works:

### 1. Console Check
```
✅ [LXR-BLACKOUT] Framework initialized: [Name]
✅ [LXR-BLACKOUT] System loaded successfully
✅ [LXR-BLACKOUT] Loaded X zones
✅ [LXR-BLACKOUT] Loaded X generators
```

### 2. In-Game Commands
```
/blackout start downtown 1800  - Start blackout
/generators                    - List all generators
/resetgenerators              - Reset generator states
```

### 3. Test Gameplay
- Navigate to generator location
- Use target system (E key)
- Complete minigame
- Check notifications work
- Verify money reward

### 4. Test Exports
```lua
-- In F8 console:
local status = exports.lxr_blackout:GetBlackoutStatus()
print(status)
```

---

## 🎉 INSTALLATION COMPLETE!

You're ready to experience immersive blackout gameplay! 🐺

**Next Steps:**
- Read [configuration.md](configuration.md) for advanced setup
- Review [events.md](events.md) for integration options
- Check [security.md](security.md) for anti-exploit features
- Join our Discord: https://discord.gg/CrKcWdfd3A

---

**Built with 🐺 by The Land of Wolves Community**

```
════════════════════════════════════════════════════════════════════════════
Discord:          https://discord.gg/CrKcWdfd3A
GitHub:           https://github.com/iBoss21
Website:          https://www.wolves.land
════════════════════════════════════════════════════════════════════════════
© 2026 The Lux Empire | wolves.land | All Rights Reserved
════════════════════════════════════════════════════════════════════════════
```
