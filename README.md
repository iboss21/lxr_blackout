# ⚡ HM_BLACKOUT - Regional Blackout System

Ein umfassendes Stromausfall-System für FiveM, das dynamische Blackouts in konfigurierbaren Zonen ermöglicht [file:11]. Spieler können Generatoren sabotieren oder reparieren – mit immersiven visuellen Effekten und vollständiger Framework-Integration [file:11].

![HM_BLACKOUT Banner](banner.png)

## 🎯 Überblick

**HM_BLACKOUT** bietet ein vollständiges Gameplay-System mit Generator-Management, Intel-NPCs, 20+ Minigames und umfangreichen Exports für andere Scripts [file:11].

---

## ⭐ Haupt-Features

### 🗺️ Regionale Blackout-Zonen
- Polyzone-basierte definierbare Stadtgebiete (Downtown, Vespucci, etc.) [file:11]
- Mehrere Zonen gleichzeitig unterstützt [file:11]
- Dynamische Grenzen mit ox_lib PolyZones [file:11]
- Visuelle Markierungen mit Blips & Radien auf der Map [file:11]

### ⚡ Generator-Management
- Mehrere Generatoren pro Zone (Haupt- & Backup-Systeme) [file:11]
- Reparatur-System für Techniker/Mechaniker [file:11]
- Sabotage-System für Kriminelle [file:11]
- Vollständige Statusverfolgung (Wer, Wann, Was) [file:11]
- Job-Beschränkungen konfigurierbar [file:11]

### 🎮 Minigame-Integration
- **20+ verfügbare Minigame-Typen** via MGC [file:11]
- Komplett konfigurierbar (Typ, Schwierigkeit, Timer) [file:11]
- ox_lib Fallback für volle Kompatibilität [file:11]
- Unterschiedliche Games für Repair & Sabotage [file:11]

**Verfügbare Typen:** safe_crack, wire_cut, pattern_lock, pincode, skill_bar, skill_circle, pulse_sync, signal_wave, frequency_jam, bit_flip, code_drop, tile_shift, circuit_trace, chip_hack und viele mehr [file:11]!

### 🎨 Visuelle Effekte
- Map Blips mit roten Warnungen bei aktiven Blackouts [file:11]
- Radius-Blips zeigen Blackout-Zonengröße [file:11]
- Server-weite Benachrichtigungen [file:11]
- Partikel-Effekte (Funken & Rauch) bei Sabotage/Repair [file:11]
- Sound-Effekte (Alarm, Power-Down, Power-Up) [file:11]

### 🌃 Immersive Blackout-Effekte
- Straßenlaternen aus (SetArtificialLightsState) [file:11]
- Dunkler Timecycle mit Cinema-Modifier [file:11]
- Zone-basierte Aktivierung [file:11]
- Smooth Transitions beim Betreten/Verlassen [file:11]

### 🕵️ Intel-System
- NPC-Informanten platzierbar in der Welt [file:11]
- Bezahlte Informationen für Generator-Locations [file:11]
- Zeigt Blips nach Kauf [file:11]
- Cooldown-System verhindert Spam [file:11]
- Zeitlimit – Blips verschwinden automatisch [file:11]

### 🔧 Framework-Unterstützung
- ✅ **QBox** - Native Unterstützung [file:11]
- ✅ **QBCore** - Vollständig kompatibel [file:11]
- ✅ **ESX** - Vollständig kompatibel [file:11]
- ✅ **Auto-Detection** - Erkennt Framework automatisch [file:11]

### 💰 Wirtschafts-System
- Reparatur-Belohnungen für erfolgreiche Reparaturen [file:11]
- Item-Requirements (repair_kit, fuel_can, etc.) [file:11]
- Sabotage-Items (weapon_stickybomb required) [file:11]
- Job-basierte Preise für Intel pro Zone [file:11]

### 🚨 Polizei-Integration
- Minimum Police Check (benötigt X Cops online) [file:11]
- Dispatch-System optional einschaltbar [file:11]
- Discord-Logging für alle Events [file:11]
- Job-Counter zählt aktive Polizisten [file:11]

### 🔌 Export-System
- **15+ Exports** für andere Scripts [file:11]
- Client & Server beide Seiten abgedeckt [file:11]
- Blackout-Checks: `IsZoneInBlackout()` [file:11]
- Manuelle Kontrolle: `StartBlackout()`, `EndBlackout()` [file:11]
- Generator-Kontrolle für Sabotage/Repair [file:11]

---

## 🎮 Gameplay-Flow

### Für Techniker/Mechaniker [file:11]:
1. Blackout wird aktiv → Notification erhalten
2. Intel kaufen (Optional) → Generator-Locations erhalten
3. Zum Generator fahren → Mit erforderlichen Items
4. Generator reparieren → Minigame spielen
5. Belohnung erhalten → Zone wiederhergestellt

### Für Kriminelle [file:11]:
1. Generator sabotieren → Sabotage-Item + Minigame
2. Alle Generatoren sabotiert → Blackout aktiv!
3. Bank-Überfall möglich → Keine Kameras/Alarme
4. Höheres Risiko = Höhere Belohnung

---

## 💻 Technische Features

### Performance [file:11]
- ✅ Optimierte Point-in-Polygon Checks (1s Intervall)
- ✅ Event-basierte Synchronisation
- ✅ Minimale CPU-Last
- ✅ Keine SQL-Queries im Loop

### Sicherheit [file:11]
- ✅ Rate-Limiting gegen Spam
- ✅ Cooldown-System pro Spieler
- ✅ Distance-Checks
- ✅ Job-Validierung server-side
- ✅ Item-Checks server-side

### Konfiguration [file:11]
- ✅ Alles in einer Config
- ✅ Mehrsprachig (Locale-System)
- ✅ Debug-Modus
- ✅ Feature-Toggles
- ✅ Vollständig dokumentiert

---

## 📦 Dependencies

### Required [file:11]:
- **ox_lib** - UI, Zones, Callbacks
- **oxmysql** - Datenbank (optional)
- **Framework** - QBox/QBCore/ESX

### Optional [file:11]:
- **mgc** - Minigames (20+ Games)
- **ox_target** - Interaction
- **qb-target** - Interaction (alternative)
- **Discord Webhook** - Logging

---

## 🔌 Export-Beispiele

### Bank-Überfall nur bei Blackout [file:11]
```lua
RegisterNetEvent('bank:startHeist', function()
    local blackout = exports.hm_blackout:IsZoneInBlackout('downtown')
    
    if not blackout then
        return
    end
    
    -- Starten...
end)
