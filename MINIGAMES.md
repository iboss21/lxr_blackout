# 🎮 MGC - ALLE 20 ECHTEN MINIGAMES

## 🔥 WICHTIG: Ich hatte komplett falsche Games!

**MGC hat NICHT:** thermite, lockpick, untangle, memory, etc.  
**MGC hat TATSÄCHLICH:** Diese 20 Games!

Quelle: https://github.com/playingintraffic/mgc/blob/main/docs/game_settings.md

---

## 📦 Installation

```bash
git clone https://github.com/playingintraffic/mgc
```

```cfg
ensure mgc
ensure hm_blackout
```

---

## 🎯 Export-Struktur

```lua
exports.mgc:start_game({
    game = 'game_name',
    data = { 
        -- Game-spezifische Settings
    }
}, function(result)
    if result.success then
        -- Erfolg!
    end
end)
```

---

## 🎲 ALLE 20 VERFÜGBAREN GAMES

### 🔐 Lock & Security (Empfohlen für Repair/Sabotage)

#### 1. **safe_crack** ⭐⭐⭐
Safe knacken - perfekt für Repair!
```lua
type = 'safe_crack',
difficulty = 3  -- Anzahl Tumblers
```
**Empfohlen für:** Repair (Generator-Schloss öffnen)

#### 2. **wire_cut** ⭐⭐⭐
Kabel durchschneiden - perfekt für Sabotage!
```lua
type = 'wire_cut',
timer = 30000,   -- 30 Sekunden
chances = 4      -- 4 Fehler erlaubt
```
**Empfohlen für:** Sabotage (Kabel zerschneiden)

#### 3. **pattern_lock**
Muster-Lock wie Android
```lua
type = 'pattern_lock',
timer = 15000
```

#### 4. **pincode**
PIN-Code eingeben
```lua
type = 'pincode',
difficulty = 4  -- 4-stelliger Code
```

---

### 🎯 Skill & Timing

#### 5. **skill_bar**
Timing-Bar (wie Fischen in vielen Games)
```lua
type = 'skill_bar',
icon = "fa-solid fa-wrench",
area_size = 20,
speed = 1.0
```

#### 6. **skill_circle**
Kreis-Timing
```lua
type = 'skill_circle',
icon = "fa-solid fa-gear",
speed = 0.8,
area_size = 4
```

#### 7. **pulse_sync**
Pulse synchronisieren
```lua
type = 'pulse_sync',
rounds = 3,
zone_width = 10
```

---

### 🧠 Memory & Puzzle

#### 8. **tile_shift**
Schiebe-Puzzle
```lua
type = 'tile_shift',
grid_size = 3,
timer = 30000
```

#### 9. **circuit_trace**
Schaltkreis nachzeichnen
```lua
type = 'circuit_trace',
timer = 15000
```

#### 10. **chip_hack**
Chips finden
```lua
type = 'chip_hack',
chips = 3,
timer = 30000
```

---

### 💻 Hacking & Tech

#### 11. **signal_wave**
Wellen angleichen
```lua
type = 'signal_wave',
match_threshold = 0.1,
timer = 500
```

#### 12. **frequency_jam**
Frequenzen abstimmen
```lua
type = 'frequency_jam',
dials = 3,
timer = 150000,
precision = 3
```

#### 13. **bit_flip**
Bit-Sequenz lösen
```lua
type = 'bit_flip',
length = 3,
timer = 30000
```

#### 14. **code_drop**
Fallende Codes fangen
```lua
type = 'code_drop',
target_score = 10,
max_misses = 5
```

#### 15. **packet_snatch**
Pakete fangen
```lua
type = 'packet_snatch',
packet_count = 25,
allowed_misses = 5,
duration = 15000
```

---

### 📝 Wort & Text

#### 16. **anagram**
Anagramme lösen
```lua
type = 'anagram',
difficulty = 1,
guesses = 5,
timer = 30000
```

#### 17. **hangman**
Galgenmännchen
```lua
type = 'hangman',
difficulty = 3,
timer = 45000
```

#### 18. **key_drop**
Fallende Tasten treffen
```lua
type = 'key_drop',
score_limit = 10,
miss_limit = 5
```

---

### ⚡ Reflex & Action

#### 19. **button_mash**
Button mashing
```lua
type = 'button_mash',
difficulty = 3
```

#### 20. **whack_flash**
Whack-a-mole Style
```lua
type = 'whack_flash',
total_hits = 10,
max_misses = 3,
flash_duration = 1000
```

---

## 💡 Empfohlene Kombinationen

### 🔰 Easy (Testing)
```lua
repair = {
    type = 'pincode',
    difficulty = 3  -- 3-stellig
}

sabotage = {
    type = 'skill_bar',
    area_size = 30,  -- Großes Fenster
    speed = 0.8      -- Langsam
}
```

### ⚖️ Balanced (Empfohlen)
```lua
repair = {
    type = 'safe_crack',
    difficulty = 3  -- 3 Tumblers
}

sabotage = {
    type = 'wire_cut',
    timer = 30000,
    chances = 4
}
```

### 💀 Hardcore
```lua
repair = {
    type = 'circuit_trace',
    timer = 10000  -- Nur 10 Sekunden!
}

sabotage = {
    type = 'frequency_jam',
    dials = 5,
    timer = 60000,
    precision = 1  -- Sehr eng
}
```

### 🎬 Hacker-Theme
```lua
repair = {
    type = 'signal_wave',
    match_threshold = 0.1,
    timer = 500
}

sabotage = {
    type = 'bit_flip',
    length = 5,
    timer = 20000
}
```

### 🧩 Puzzle-Focus
```lua
repair = {
    type = 'tile_shift',
    grid_size = 4,
    timer = 45000
}

sabotage = {
    type = 'pattern_lock',
    timer = 15000
}
```

---

## ⚙️ Config-Beispiel

### In shared/config.lua:

```lua
Config.Minigames = {
    enabled = true,
    
    repair = {
        type = 'safe_crack',
        difficulty = 3
    },
    
    sabotage = {
        type = 'wire_cut',
        timer = 30000,
        chances = 3
    }
}
```

**Das Script überträgt ALLE Settings außer 'type' automatisch!**

---

## 🎨 Game-Kategorien

| Kategorie | Games | Best für |
|-----------|-------|----------|
| **Lock & Security** | safe_crack, wire_cut, pattern_lock, pincode | Repair, Sabotage ⭐ |
| **Skill & Timing** | skill_bar, skill_circle, pulse_sync | Beide |
| **Memory & Puzzle** | tile_shift, circuit_trace, chip_hack | Repair |
| **Hacking & Tech** | signal_wave, frequency_jam, bit_flip, code_drop, packet_snatch | Sabotage ⭐ |
| **Wort & Text** | anagram, hangman, key_drop | Beide |
| **Reflex & Action** | button_mash, whack_flash | Sabotage |

---

## 🐛 Troubleshooting

### Game nicht gefunden
→ Prüfe Schreibweise in Config (z.B. `safe_crack` nicht `safecrack`)

### "Already running a game"
```
F8: restart mgc
```

### Settings funktionieren nicht
→ Jedes Game hat eigene Settings! Siehe Doku oben.

### Fallback zu ox_lib
```lua
Config.Minigames.enabled = false
```

---

## 📚 Vollständige Settings

Für ALLE Details zu jedem Game siehe:  
https://github.com/playingintraffic/mgc/blob/main/docs/game_settings.md

Oder die hochgeladene `game_settings.md` Datei!

---

## 🎮 Pro-Tipps

1. **safe_crack** ist perfekt für Repair (passt thematisch)
2. **wire_cut** ist perfekt für Sabotage (Kabel durchschneiden!)
3. **Teste alle 20 Games** - jedes hat unique Gameplay
4. **Settings anpassen** - zu schwer? Ändere difficulty/timer!
5. **Mix & Match** - wechsle Games regelmäßig für Abwechslung

---

**Endlich die ECHTEN MGC Games! 🎮🔥**
