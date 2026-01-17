# 🔌 HM_BLACKOUT EXPORTS

## Nutze diese Exports um andere Scripts mit dem Blackout-System zu verbinden!

---

## 📋 CLIENT EXPORTS

### 1. **GetBlackoutStatus()**
Prüft ob IRGENDEINE Zone im Blackout ist.

```lua
local hasBlackout = exports.hm_blackout:GetBlackoutStatus()

if hasBlackout then
    print("Es gibt einen aktiven Blackout!")
end
```

**Returns:** `boolean`

---

### 2. **IsZoneInBlackout(zoneId)**
Prüft ob eine BESTIMMTE Zone im Blackout ist.

```lua
local downtownBlackout = exports.hm_blackout:IsZoneInBlackout('downtown')

if downtownBlackout then
    print("Downtown ist im Blackout!")
end
```

**Parameters:**
- `zoneId` (string) - Zone ID aus der Config

**Returns:** `boolean`

**Beispiel - Bank-Überfall nur bei Blackout:**
```lua
-- In deinem Bank-Script:
RegisterNetEvent('bank:startHeist', function()
    local source = source
    
    -- Check ob Downtown im Blackout ist
    local blackout = exports.hm_blackout:IsZoneInBlackout('downtown')
    
    if not blackout then
        TriggerClientEvent('notify', source, 'Der Banküberfall funktioniert nur bei Stromausfall!', 'error')
        return
    end
    
    -- Start heist...
    print('Heist started during blackout!')
end)
```

---

### 3. **GetGeneratorState(genId)**
Gibt den Status eines Generators zurück.

```lua
local state = exports.hm_blackout:GetGeneratorState('gen_downtown_main')

if state then
    print('Generator Status:')
    print('- Repaired:', state.repaired)
    print('- Sabotaged by:', state.sabotagedBy)
    print('- Sabotaged at:', state.sabotagedAt)
end
```

**Parameters:**
- `genId` (string) - Generator ID aus der Config

**Returns:** `table` or `nil`
```lua
{
    repaired = boolean,
    sabotagedBy = string or nil,
    sabotagedAt = number (timestamp),
    repairedBy = string or nil,
    repairedAt = number (timestamp)
}
```

---

### 4. **IsPlayerInBlackoutZone()**
Prüft ob der SPIELER aktuell in einer Blackout-Zone ist.

```lua
local inBlackout = exports.hm_blackout:IsPlayerInBlackoutZone()

if inBlackout then
    print("Du befindest dich in einer Blackout-Zone!")
end
```

**Returns:** `boolean`

---

### 5. **GetActiveBlackoutZones()**
Gibt alle aktiven Blackout-Zonen zurück.

```lua
local zones = exports.hm_blackout:GetActiveBlackoutZones()

for zoneId, _ in pairs(zones) do
    print('Aktiver Blackout in:', zoneId)
end
```

**Returns:** `table` 
```lua
{
    ['downtown'] = true,
    ['vespucci'] = true
}
```

---

### 6. **GetAllZonesStatus()**
Gibt ALLE Zonen mit Status zurück.

```lua
local zones = exports.hm_blackout:GetAllZonesStatus()

for _, zone in ipairs(zones) do
    print(zone.label .. ': ' .. (zone.active and 'BLACKOUT' or 'OK'))
end
```

**Returns:** `table`
```lua
{
    {
        zoneId = 'downtown',
        label = 'Downtown Los Santos',
        active = true,
        generators = {'gen_downtown_main', 'gen_downtown_backup'}
    },
    -- ...
}
```

---

## 🖥️ SERVER EXPORTS

### 1. **StartBlackout(zoneId)**
Startet manuell einen Blackout (sabotiert alle Generatoren).

```lua
-- Manuell Blackout starten
exports.hm_blackout:StartBlackout('downtown')
```

**Parameters:**
- `zoneId` (string) - Zone ID

**Returns:** `boolean` (success)

**Beispiel - Event-System:**
```lua
-- In deinem Event-Script:
RegisterCommand('startevent', function(source, args)
    if not IsPlayerAceAllowed(source, 'admin') then return end
    
    -- Starte Blackout-Event
    exports.hm_blackout:StartBlackout('downtown')
    
    TriggerClientEvent('notify', -1, 'SERVER EVENT: Downtown Blackout!', 'warning')
end)
```

---

### 2. **EndBlackout(zoneId)**
Beendet manuell einen Blackout (repariert alle Generatoren).

```lua
-- Manuell Blackout beenden
exports.hm_blackout:EndBlackout('downtown')
```

**Parameters:**
- `zoneId` (string) - Zone ID

**Returns:** `boolean` (success)

---

### 3. **IsZoneInBlackout(zoneId)**
Server-seitige Zone-Check.

```lua
local blackout = exports.hm_blackout:IsZoneInBlackout('downtown')
```

**Returns:** `boolean`

---

### 4. **GetAllZonesStatus()**
Server-seitige Zone-Status Abfrage.

```lua
local zones = exports.hm_blackout:GetAllZonesStatus()

for _, zone in ipairs(zones) do
    print(zone.label, zone.active, zone.generatorCount)
end
```

**Returns:** `table`

---

### 5. **GetGeneratorState(genId)**
Server-seitige Generator-Status Abfrage.

```lua
local state = exports.hm_blackout:GetGeneratorState('gen_downtown_main')
```

**Returns:** `table` or `nil`

---

### 6. **SabotageGenerator(genId)**
Sabotiert einen spezifischen Generator.

```lua
exports.hm_blackout:SabotageGenerator('gen_downtown_main')
```

**Parameters:**
- `genId` (string) - Generator ID

**Returns:** `boolean` (success)

---

### 7. **RepairGenerator(genId)**
Repariert einen spezifischen Generator.

```lua
exports.hm_blackout:RepairGenerator('gen_downtown_main')
```

**Parameters:**
- `genId` (string) - Generator ID

**Returns:** `boolean` (success)

---

## 🎮 BEISPIELE

### Beispiel 1: Bank-Überfall nur bei Blackout

```lua
-- bank/server.lua
RegisterNetEvent('bank:attemptHeist', function(bankId)
    local source = source
    local bankZone = Banks[bankId].zone -- z.B. 'downtown'
    
    -- Check Blackout
    local isBlackout = exports.hm_blackout:IsZoneInBlackout(bankZone)
    
    if not isBlackout then
        TriggerClientEvent('bank:notify', source, 
            'Das Sicherheitssystem ist online! Warte auf einen Stromausfall.', 
            'error'
        )
        return
    end
    
    -- Bank-Überfall starten
    StartBankHeist(source, bankId)
end)
```

---

### Beispiel 2: Dynamische Preise bei Blackout

```lua
-- shops/server.lua
function GetItemPrice(item)
    local basePrice = Items[item].price
    
    -- Check ob Shop in Blackout-Zone ist
    local shopZone = GetShopZone(item.shopId)
    local isBlackout = exports.hm_blackout:IsZoneInBlackout(shopZone)
    
    if isBlackout then
        -- 50% teurer bei Blackout (Knappheit!)
        return basePrice * 1.5
    end
    
    return basePrice
end
```

---

### Beispiel 3:Quest nur bei Blackout verfügbar

```lua
-- quests/client.lua
CreateThread(function()
    while true do
        Wait(5000)
        
        -- Check ob Spieler in Blackout-Zone ist
        local inBlackout = exports.hm_blackout:IsPlayerInBlackoutZone()
        
        if inBlackout and not QuestActive then
            -- Zeige Quest-NPC nur bei Blackout
            ShowQuestNPC()
        elseif not inBlackout and QuestActive then
            HideQuestNPC()
        end
    end
end)
```

---

### Beispiel 4: Event-System

```lua
-- events/server.lua
RegisterCommand('blackoutevent', function(source, args)
    if not IsPlayerAceAllowed(source, 'admin') then return end
    
    local zone = args[1] or 'downtown'
    
    -- Starte Blackout
    exports.hm_blackout:StartBlackout(zone)
    
    -- Notification an alle
    TriggerClientEvent('chat:addMessage', -1, {
        color = {255, 0, 0},
        multiline = true,
        args = {'[SERVER EVENT]', 'Stromausfall in ' .. zone .. '! Nutzt die Chance!'}
    })
    
    -- Auto-Ende nach 30 Minuten
    SetTimeout(30 * 60 * 1000, function()
        exports.hm_blackout:EndBlackout(zone)
        TriggerClientEvent('chat:addMessage', -1, {
            color = {0, 255, 0},
            multiline = true,
            args = {'[SERVER EVENT]', 'Strom in ' .. zone .. ' wiederhergestellt!'}
        })
    end)
end)
```

---

### Beispiel 5: Dispatch nur bei Blackout

```lua
-- dispatch/server.lua
function SendPoliceAlert(coords, message)
    -- Check ob Location in Blackout-Zone ist
    local zone = GetZoneFromCoords(coords)
    local isBlackout = exports.hm_blackout:IsZoneInBlackout(zone)
    
    if isBlackout then
        -- Verzögerter Alarm (keine Kameras!)
        SetTimeout(30000, function() -- 30 Sekunden Verzögerung
            TriggerClientEvent('dispatch:alert', -1, {
                coords = coords,
                message = message .. ' (verspäteter Alarm - Stromausfall)'
            })
        end)
    else
        -- Sofortiger Alarm
        TriggerClientEvent('dispatch:alert', -1, {
            coords = coords,
            message = message
        })
    end
end
```

---

## 📌 Zone IDs aus deiner Config:

- `'downtown'` - Downtown Los Santos
- `'vespucci'` - Vespucci Beach

## 📌 Generator IDs aus deiner Config:

- `'gen_downtown_main'` - Downtown Hauptgenerator
- `'gen_downtown_backup'` - Downtown Backup-Generator
- `'gen_vespucci_beach'` - Vespucci Beach Generator

---

**Nutze diese Exports um coole Blackout-abhängige Features zu bauen! 🚀**
