# 📦 HM BLACKOUT - INSTALLATION GUIDE

## Quick Start (5 Minuten)

### Schritt 1: Download & Extract
```bash
# Entpacke hm_blackout.zip in deinen resources Ordner
resources/
└── hm_blackout/
```

### Schritt 2: Dependencies prüfen
```bash
# Stelle sicher, dass ox_lib installiert ist
resources/
├── ox_lib/        # ✅ REQUIRED
└── hm_blackout/
```

### Schritt 3: server.cfg
```cfg
# Füge diese Zeilen hinzu:
ensure ox_lib
ensure hm_blackout

# ACE Permissions (Admin Commands)
add_ace group.admin command.blackout allow
add_ace group.admin command.generators allow
add_ace group.admin command.resetgenerators allow
```

### Schritt 4: Config anpassen (Optional)
Bearbeite `hm_blackout/shared/config.lua`:
- Passe Zonen-Koordinaten an
- Passe Generator-Locations an
- Passe NPC-Locations an

### Schritt 5: Discord Webhooks (Optional)
Bearbeite `hm_blackout/server/sv_config.lua`:
```lua
SVConfig.Discord.webhooks = {
    ['blackout'] = 'DEIN_WEBHOOK_HIER',
    ['generator'] = 'DEIN_WEBHOOK_HIER',
    ['intel'] = 'DEIN_WEBHOOK_HIER'
}
```

### Schritt 6: Server starten
```bash
restart hm_blackout
```

### Schritt 7: Testen
```
Ingame:
1. /blackout start downtown 1800
2. Gehe zu einem Generator
3. Drücke E zum Reparieren/Sabotieren
```

## Detaillierte Installation

### Framework Check
Script funktioniert automatisch mit:
- ✅ QBox (qbx_core)
- ✅ QBCore (qb-core)
- ✅ ESX (es_extended)

Keine manuelle Konfiguration nötig - Auto-Detection!

### Inventory Check
Script funktioniert automatisch mit:
- ✅ ox_inventory
- ✅ tgiann-inventory
- ✅ qb-inventory
- ✅ ps-inventory
- ✅ qs-inventory
- ✅ core_inventory

Keine manuelle Konfiguration nötig - Auto-Detection!

### Items hinzufügen
Füge diese Items zu deinem Inventory hinzu:

**ox_inventory** (`ox_inventory/data/items.lua`):
```lua
['repair_kit'] = {
    label = 'Reparatur-Kit',
    weight = 1000,
    stack = true,
    close = true,
    description = 'Werkzeug zum Reparieren von Generatoren'
},

['fuel_can'] = {
    label = 'Kraftstoffkanister',
    weight = 2000,
    stack = true,
    close = true,
    description = 'Kraftstoff für Generatoren'
},

['explosive_charge'] = {
    label = 'Sprengladung',
    weight = 3000,
    stack = true,
    close = true,
    description = 'Zum Sabotieren von Generatoren'
}
```

**QBCore/QBox** (`qb-core/shared/items.lua`):
```lua
['repair_kit'] = {
    name = 'repair_kit',
    label = 'Reparatur-Kit',
    weight = 1000,
    type = 'item',
    image = 'repair_kit.png',
    unique = false,
    useable = false,
    shouldClose = true,
    description = 'Werkzeug zum Reparieren von Generatoren'
},
-- (analog für fuel_can und explosive_charge)
```

### Database Setup (Optional)
Nur nötig wenn du Persistence möchtest:

```bash
# MySQL importieren
mysql -u root -p deine_datenbank < hm_blackout/sql/install.sql

# In server/sv_config.lua aktivieren
SVConfig.Database.enabled = true
```

### Zonen anpassen
Nutze den PolyZone Creator: https://github.com/mkafrin/PolyZone

1. Ingame `/polyzone create poly`
2. Setze Punkte mit Marker
3. Kopiere Koordinaten
4. Füge in `shared/config.lua` ein

### Dispatch Integration (Optional)
**ps-dispatch:**
```lua
-- Bereits integriert! Keine Änderungen nötig
-- Funktioniert automatisch wenn ps-dispatch läuft
```

**cd_dispatch oder andere:**
```lua
-- Bearbeite server/discord.lua, Zeile 20-30
-- Passe den Export an dein Dispatch-System an
```

## Fertig! 🎉

Teste das Script mit:
```
/blackout start downtown 1800
```

Bei Problemen: Discord https://dsc.gg/mopsscripts
