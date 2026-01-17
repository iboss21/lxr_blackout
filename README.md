# ⚡ HM_BLACKOUT - Regional Blackout System

Ein umfassendes Stromausfall-System für FiveM, das dynamische Blackouts in konfigurierbaren Zonen ermöglicht . Spieler können Generatoren sabotieren oder reparieren – mit immersiven visuellen Effekten und vollständiger Framework-Integration .

![HM_BLACKOUT Banner](banner.png)

## 🎯 Überblick

**HM_BLACKOUT** bietet ein vollständiges Gameplay-System mit Generator-Management, Intel-NPCs, 20+ Minigames und umfangreichen Exports für andere Scripts .

---

## ⭐ Haupt-Features

### 🗺️ Regionale Blackout-Zonen
- Polyzone-basierte definierbare Stadtgebiete (Downtown, Vespucci, etc.) 
- Mehrere Zonen gleichzeitig unterstützt 
- Dynamische Grenzen mit ox_lib PolyZones 
- Visuelle Markierungen mit Blips & Radien auf der Map 

### ⚡ Generator-Management
- Mehrere Generatoren pro Zone (Haupt- & Backup-Systeme) 
- Reparatur-System für Techniker/Mechaniker 
- Sabotage-System für Kriminelle 
- Vollständige Statusverfolgung (Wer, Wann, Was) 
- Job-Beschränkungen konfigurierbar 

### 🎮 Minigame-Integration
- **20+ verfügbare Minigame-Typen** via MGC 
- Komplett konfigurierbar (Typ, Schwierigkeit, Timer) 
- ox_lib Fallback für volle Kompatibilität 
- Unterschiedliche Games für Repair & Sabotage 

**Verfügbare Typen:** safe_crack, wire_cut, pattern_lock, pincode, skill_bar, skill_circle, pulse_sync, signal_wave, frequency_jam, bit_flip, code_drop, tile_shift, circuit_trace, chip_hack und viele mehr !

### 🎨 Visuelle Effekte
- Map Blips mit roten Warnungen bei aktiven Blackouts 
- Radius-Blips zeigen Blackout-Zonengröße 
- Server-weite Benachrichtigungen 
- Partikel-Effekte (Funken & Rauch) bei Sabotage/Repair 
- Sound-Effekte (Alarm, Power-Down, Power-Up) 

### 🌃 Immersive Blackout-Effekte
- Straßenlaternen aus (SetArtificialLightsState) 
- Dunkler Timecycle mit Cinema-Modifier 
- Zone-basierte Aktivierung 
- Smooth Transitions beim Betreten/Verlassen 

### 🕵️ Intel-System
- NPC-Informanten platzierbar in der Welt 
- Bezahlte Informationen für Generator-Locations 
- Zeigt Blips nach Kauf 
- Cooldown-System verhindert Spam 
- Zeitlimit – Blips verschwinden automatisch 

### 🔧 Framework-Unterstützung
- ✅ **QBox** - Native Unterstützung 
- ✅ **QBCore** - Vollständig kompatibel 
- ✅ **ESX** - Vollständig kompatibel 
- ✅ **Auto-Detection** - Erkennt Framework automatisch 

### 💰 Wirtschafts-System
- Reparatur-Belohnungen für erfolgreiche Reparaturen 
- Item-Requirements (repair_kit, fuel_can, etc.) 
- Sabotage-Items (weapon_stickybomb required) 
- Job-basierte Preise für Intel pro Zone 

### 🚨 Polizei-Integration
- Minimum Police Check (benötigt X Cops online) 
- Dispatch-System optional einschaltbar 
- Discord-Logging für alle Events 
- Job-Counter zählt aktive Polizisten 

### 🔌 Export-System
- **15+ Exports** für andere Scripts 
- Client & Server beide Seiten abgedeckt 
- Blackout-Checks: `IsZoneInBlackout()` 
- Manuelle Kontrolle: `StartBlackout()`, `EndBlackout()` 
- Generator-Kontrolle für Sabotage/Repair 

---

## 🎮 Gameplay-Flow

### Für Techniker/Mechaniker :
1. Blackout wird aktiv → Notification erhalten
2. Intel kaufen (Optional) → Generator-Locations erhalten
3. Zum Generator fahren → Mit erforderlichen Items
4. Generator reparieren → Minigame spielen
5. Belohnung erhalten → Zone wiederhergestellt

### Für Kriminelle :
1. Generator sabotieren → Sabotage-Item + Minigame
2. Alle Generatoren sabotiert → Blackout aktiv!
3. Bank-Überfall möglich → Keine Kameras/Alarme
4. Höheres Risiko = Höhere Belohnung

---

## 💻 Technische Features

### Performance 
- ✅ Optimierte Point-in-Polygon Checks (1s Intervall)
- ✅ Event-basierte Synchronisation
- ✅ Minimale CPU-Last
- ✅ Keine SQL-Queries im Loop

### Sicherheit 
- ✅ Rate-Limiting gegen Spam
- ✅ Cooldown-System pro Spieler
- ✅ Distance-Checks
- ✅ Job-Validierung server-side
- ✅ Item-Checks server-side

### Konfiguration 
- ✅ Alles in einer Config
- ✅ Mehrsprachig (Locale-System)
- ✅ Debug-Modus
- ✅ Feature-Toggles
- ✅ Vollständig dokumentiert

---

## 📦 Dependencies

### Required :
- **ox_lib** - UI, Zones, Callbacks
- **oxmysql** - Datenbank (optional)
- **Framework** - QBox/QBCore/ESX

### Optional :
- **mgc** - Minigames (20+ Games)
- **ox_target** - Interaction
- **qb-target** - Interaction (alternative)
- **Discord Webhook** - Logging

---

## 🔌 Export-Beispiele

### Bank-Überfall nur bei Blackout 
```lua
RegisterNetEvent('bank:startHeist', function()
    local blackout = exports.hm_blackout:IsZoneInBlackout('downtown')
    
    if not blackout then
        return
    end
    
    -- Starten...
end)
