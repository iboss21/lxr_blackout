# 🐛 BUGFIXES v1.0.3

## Behobene Fehler

### Version 1.0.3 (2025-01-17) - Utils Function Scope

#### 🔧 Utils.ProgressBar Fix

**6. bridge/utils.lua - Function Scope Error**
```
ERROR: attempt to call a nil value (field 'ProgressBar')
```
**Fix:** Utils-Funktionen waren nicht korrekt im Scope verfügbar
- Geändert von `function Utils.ProgressBar()` zu `Utils.ProgressBar = function()`
- Alle Client-Utils-Funktionen konsistent gemacht
- Server-Utils ebenfalls angepasst

**Betroffene Funktionen:**
- `Utils.Notify()`
- `Utils.ProgressBar()`
- `Utils.InputDialog()`
- `Utils.AlertDialog()`
- `Utils.NormalizeTimestamp()`

---

### Version 1.0.2 (2025-01-17) - QBox Compatibility

#### 🔧 QBox Framework Fix

**5. bridge/framework.lua - QBox Player() Function**
```
ERROR: No such export GetPlayer in resource qbx_core
```
**Fix:** QBox nutzt globale `Player()` Funktion statt Export
- Server-Side: `Player(source)` statt `exports.qbx_core:GetPlayer(source)`
- GetJobCount: Nutzt jetzt `GetPlayers()` Loop für alle Frameworks
- AddMoney/RemoveMoney: QBox benötigt 'reason' Parameter

**Änderungen:**
```lua
-- Vorher (falsch):
return exports.qbx_core:GetPlayer(source)

-- Nachher (richtig):
return Player(source)
```

---

### Version 1.0.1 (2025-01-17)

#### 🔧 Client-Side Fixes

**1. client/npcs.lua - Deprecated Native**
```
ERROR: attempt to call a nil value (global 'SetEntityAsCriminal')
```
**Fix:** `SetEntityAsCriminal` entfernt (deprecated native)
- Ersetzt durch `SetPedFleeAttributes(npc, 0, false)`
- Model wird jetzt korrekt mit `GetHashKey()` geladen

**2. client/main.lua - Framework Detection**
```
ERROR: attempt to call a nil value (method 'GetPlayerData')
```
**Fix:** Warte auf Framework-Initialisierung
- `while not Framework or not Framework.Name do Wait(100) end`
- Framework muss erst von bridge/framework.lua geladen werden

**3. client/zones.lua - Sabotage Prop**
```
ERROR: Beim Legen der Bombe
```
**Fix:** Problematisches Prop entfernt
- `prop_bomb_01` entfernt aus Progress-Bar
- Sabotage funktioniert jetzt ohne Prop-Fehler

#### 🖥️ Server-Side Fixes

**4. server/commands.lua - Missing Parameters**
```
ERROR: command 'blackout' received an invalid string for argument 1 (action), received 'nil'
```
**Fix:** Parameter-Validierung hinzugefügt
- Check ob `args.action` existiert
- Bessere Fehlermeldungen mit Verwendungshinweisen

---

## QBox Framework Support

### Jetzt vollständig kompatibel:
✅ Player() Funktion korrekt  
✅ Money Functions mit 'reason' Parameter  
✅ Job Count über GetPlayers() Loop  
✅ Alle Framework-Funktionen getestet  

---

## Migration von v1.0.1 → v1.0.2

### Nur für QBox-Server wichtig!
QBCore und ESX User müssen nicht updaten (außer sie wollen).

```bash
# Update
rm -rf resources/hm_blackout
unzip hm_blackout.zip -d resources/
restart hm_blackout
```

---

## Bekannte Probleme (Work in Progress)

Keine bekannten Probleme in v1.0.2 ✅

---

**Changelog:**
- v1.0.2: QBox Framework Compatibility (Player() function, Money functions)
- v1.0.1: Bugfixes (SetEntityAsCriminal, Framework Detection, Prop Error, Command Validation)
- v1.0.0: Initial Release
