# 🐺 LXR BLACKOUT SYSTEM - SECURITY GUIDE

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
║                🐺 SECURITY & ANTI-EXPLOIT GUIDE 🐺                           ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

---

## 🔒 SECURITY OVERVIEW

LXR Blackout is built with **security-first principles** to prevent exploits, cheating, and abuse. Every action is validated server-side with multiple layers of protection.

---

## 🛡️ SERVER AUTHORITY MODEL

### Core Principle
**ALL gameplay-affecting decisions are made on the server.**

```
❌ Client decides: "I repaired the generator"
✅ Server decides: "Your repair is valid, generator repaired"
```

### What This Means

**Client Side:**
- Display UI elements
- Play visual effects
- Show notifications
- Handle player input
- **NEVER** makes authoritative decisions

**Server Side:**
- Validates all actions
- Manages generator states
- Controls zone blackouts
- Processes rewards
- Logs all events
- **ALWAYS** has final authority

---

## 🔐 SECURITY FEATURES

### 1. Distance Validation

**Purpose:** Prevent teleport hacking and coordinate spoofing

```lua
Config.Security.maxDistanceFromGenerator = 10.0  -- Maximum interaction distance
```

**How It Works:**
```lua
-- Server-side validation
local playerCoords = GetEntityCoords(GetPlayerPed(source))
local generatorCoords = Config.Generators[genId].coords
local distance = #(playerCoords - generatorCoords)

if distance > Config.Security.maxDistanceFromGenerator then
    -- REJECT: Player too far away
    SendSecurityLog('Distance exploit attempt', source, genId)
    return false
end
```

**Prevents:**
- Teleport hacking to generators
- Coordinate spoofing
- Remote interaction exploits

---

### 2. Rate Limiting

**Purpose:** Prevent spam and bot abuse

```lua
Config.Security.rateLimit = 5       -- Max actions per time window
Config.Security.timeWindow = 60     -- Time window (seconds)
```

**How It Works:**
```lua
-- Track actions per player
local playerActions = {}

function CheckRateLimit(source)
    if not playerActions[source] then
        playerActions[source] = {count = 0, timestamp = os.time()}
    end
    
    local now = os.time()
    local elapsed = now - playerActions[source].timestamp
    
    if elapsed >= Config.Security.timeWindow then
        -- Reset window
        playerActions[source] = {count = 1, timestamp = now}
        return true
    end
    
    if playerActions[source].count >= Config.Security.rateLimit then
        -- REJECT: Rate limit exceeded
        SendSecurityLog('Rate limit exceeded', source)
        return false
    end
    
    playerActions[source].count = playerActions[source].count + 1
    return true
end
```

**Prevents:**
- Spam clicking
- Bot/script rapid actions
- Server overload attacks

---

### 3. Per-Player Cooldowns

**Purpose:** Prevent repeated exploits by same player

```lua
Config.Security.cooldownPerPlayer = 60  -- Cooldown between actions (seconds)
```

**How It Works:**
```lua
-- Track cooldowns per player
local playerCooldowns = {}

function CheckCooldown(source)
    local now = os.time()
    
    if playerCooldowns[source] then
        local elapsed = now - playerCooldowns[source]
        
        if elapsed < Config.Security.cooldownPerPlayer then
            -- REJECT: Still on cooldown
            local remaining = Config.Security.cooldownPerPlayer - elapsed
            TriggerClientEvent('notify', source, 
                'Wait ' .. remaining .. ' seconds', 'error')
            return false
        end
    end
    
    playerCooldowns[source] = now
    return true
end
```

**Prevents:**
- Rapid sabotage/repair cycling
- Cooldown bypassing
- Resource abuse

---

### 4. Item Validation

**Purpose:** Ensure players have required items server-side

```lua
-- Required items checked server-side
requiredItems = {
    {item = 'repair_kit', amount = 1},
    {item = 'fuel_can', amount = 2}
}
```

**How It Works:**
```lua
-- Server-side item check
function HasRequiredItems(source, items)
    for _, itemData in ipairs(items) do
        local count = Inventory.GetItemCount(source, itemData.item)
        
        if count < itemData.amount then
            -- REJECT: Missing items
            SendSecurityLog('Missing required items', source)
            TriggerClientEvent('notify', source, 
                'Missing: ' .. itemData.item, 'error')
            return false
        end
    end
    
    return true
end
```

**Prevents:**
- Item duplication exploits
- Inventory bypassing
- Free repairs/sabotage

---

### 5. Job Validation

**Purpose:** Ensure players have correct job for repairs

```lua
requiredJob = {'mechanic', 'electrician'}
```

**How It Works:**
```lua
-- Server-side job check
function HasRequiredJob(source, allowedJobs)
    if not allowedJobs or #allowedJobs == 0 then
        return true  -- No job requirement
    end
    
    local playerJob = Framework.GetPlayerJob(source)
    
    for _, job in ipairs(allowedJobs) do
        if playerJob == job then
            return true
        end
    end
    
    -- REJECT: Wrong job
    SendSecurityLog('Job requirement not met', source)
    TriggerClientEvent('notify', source, 
        'Required job: ' .. table.concat(allowedJobs, ', '), 'error')
    return false
end
```

**Prevents:**
- Unauthorized repairs
- Job bypass exploits

---

### 6. State Validation

**Purpose:** Ensure generator is in correct state for action

```lua
-- Check generator state before allowing action
function ValidateGeneratorState(genId, action)
    local state = GeneratorStates[genId]
    
    if action == 'repair' and state.repaired then
        -- REJECT: Already repaired
        return false
    end
    
    if action == 'sabotage' and not state.repaired then
        -- REJECT: Already sabotaged
        return false
    end
    
    return true
end
```

**Prevents:**
- Double repairs
- Invalid state transitions
- Duplicate rewards

---

### 7. Coordinate Validation

**Purpose:** Prevent coordinate manipulation

```lua
Config.Security.validateCoords = true  -- Server-side coordinate validation
```

**How It Works:**
```lua
-- Validate player is actually at location
function ValidatePlayerCoords(source, expectedCoords, maxDistance)
    if not Config.Security.validateCoords then
        return true
    end
    
    local playerPed = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(playerPed)
    local distance = #(playerCoords - expectedCoords)
    
    if distance > maxDistance then
        -- REJECT: Coordinate mismatch
        SendSecurityLog('Coordinate validation failed', source, {
            expected = expectedCoords,
            actual = playerCoords,
            distance = distance
        })
        return false
    end
    
    return true
end
```

**Prevents:**
- Coordinate spoofing
- Teleport exploits
- Position manipulation

---

### 8. Police Count Validation

**Purpose:** Ensure minimum police online for sabotage

```lua
Config.Requirements.minimumPolice = 4
```

**How It Works:**
```lua
-- Server-side police count
function CheckPoliceCount()
    local policeCount = Framework.GetOnlineJobCount('police')
    
    if policeCount < Config.Requirements.minimumPolice then
        -- REJECT: Not enough police
        return false, policeCount
    end
    
    return true, policeCount
end
```

**Prevents:**
- Sabotage during low police hours
- Unbalanced gameplay
- Off-hours griefing

---

### 9. Suspicious Activity Logging

**Purpose:** Log potential exploits to Discord

```lua
Config.Security.logSuspiciousActivity = true
```

**What Gets Logged:**
- Distance violations
- Rate limit exceeded
- Cooldown bypasses
- Item validation failures
- Job requirement failures
- Coordinate mismatches
- Invalid state transitions

**Discord Log Example:**
```json
{
    "title": "🚨 SECURITY ALERT",
    "description": "Distance exploit attempt detected",
    "fields": [
        {
            "name": "Player",
            "value": "PlayerName [ID: 42]"
        },
        {
            "name": "Generator",
            "value": "gen_downtown_main"
        },
        {
            "name": "Distance",
            "value": "245.6 meters (max: 10.0)"
        },
        {
            "name": "Timestamp",
            "value": "2025-01-17 15:30:45"
        }
    ],
    "color": 15158332
}
```

---

## 🔍 EXPLOIT PREVENTION

### Common Exploits & Prevention

#### 1. Teleport Hacking
**Exploit:** Player teleports to generator from across map  
**Prevention:** Distance validation (10m max)  
**Detection:** Coordinate mismatch logging

#### 2. Item Duplication
**Exploit:** Duplicate required items  
**Prevention:** Server-side item checks before and after  
**Detection:** Item count validation

#### 3. Infinite Money
**Exploit:** Spam repair actions for unlimited rewards  
**Prevention:** Per-player cooldowns, rate limiting  
**Detection:** Action frequency monitoring

#### 4. Job Bypass
**Exploit:** Repair without correct job  
**Prevention:** Server-side job validation  
**Detection:** Job requirement logs

#### 5. Coordinate Spoofing
**Exploit:** Fake player coordinates  
**Prevention:** Server gets coordinates directly from player ped  
**Detection:** Coordinate validation logging

#### 6. State Manipulation
**Exploit:** Repair already-repaired generator  
**Prevention:** Server-authoritative state management  
**Detection:** Invalid state transition logs

#### 7. Minigame Bypass
**Exploit:** Skip minigame client-side  
**Prevention:** Server validates completion time  
**Detection:** Suspiciously fast completions logged

#### 8. Discord Webhook Spam
**Exploit:** Spam fake Discord logs  
**Prevention:** Only server can send Discord logs  
**Detection:** N/A - server-only

---

## 📊 SECURITY CONFIGURATION

### Recommended Settings

**High Security (Strict):**
```lua
Config.Security = {
    maxDistanceFromGenerator = 5.0,   -- Very close
    cooldownPerPlayer = 120,          -- 2 minutes
    rateLimit = 3,                    -- Only 3 actions
    timeWindow = 120,                 -- Per 2 minutes
    validateCoords = true,
    logSuspiciousActivity = true,
}
```

**Balanced Security (Recommended):**
```lua
Config.Security = {
    maxDistanceFromGenerator = 10.0,  -- Reasonable distance
    cooldownPerPlayer = 60,           -- 1 minute
    rateLimit = 5,                    -- 5 actions
    timeWindow = 60,                  -- Per minute
    validateCoords = true,
    logSuspiciousActivity = true,
}
```

**Relaxed Security (Casual):**
```lua
Config.Security = {
    maxDistanceFromGenerator = 15.0,  -- More forgiving
    cooldownPerPlayer = 30,           -- 30 seconds
    rateLimit = 10,                   -- 10 actions
    timeWindow = 60,                  -- Per minute
    validateCoords = true,
    logSuspiciousActivity = false,    -- Less logging
}
```

---

## 🚨 MONITORING & ALERTS

### Discord Integration

Enable Discord logging to monitor security events:

```lua
-- server/sv_config.lua
SVConfig.Discord.enabled = true
SVConfig.Discord.webhooks = {
    ['security'] = 'YOUR_SECURITY_WEBHOOK_URL'
}
```

### Security Events Logged

1. **Distance Violations**
   - Player too far from generator
   - Coordinate: Player location vs. generator

2. **Rate Limit Exceeded**
   - Too many actions in time window
   - Action count and time remaining

3. **Cooldown Bypass Attempts**
   - Action during cooldown period
   - Cooldown remaining time

4. **Item Validation Failures**
   - Missing required items
   - Item names and amounts

5. **Job Requirement Failures**
   - Wrong job for repair
   - Required vs. actual job

6. **Invalid State Transitions**
   - Repairing already-repaired generator
   - State before and after

---

## 🛠️ ADMIN TOOLS

### Commands

```lua
-- Reset player cooldown
/resetcooldown [playerId]

-- Check generator states
/generators

-- Force reset all generators
/resetgenerators

-- View player action history
/playeractions [playerId]
```

### Banning Exploiters

If you detect a consistent exploiter:

```lua
-- In your ban system
RegisterCommand('banexploiter', function(source, args)
    local targetId = tonumber(args[1])
    local reason = table.concat(args, ' ', 2)
    
    -- Ban player
    BanPlayer(targetId, reason)
    
    -- Log to Discord
    SendDiscordLog('security', '🔨 PLAYER BANNED', 
        'Player ' .. GetPlayerName(targetId) .. ' banned for: ' .. reason,
        SVConfig.Discord.colors.error
    )
end, true)
```

---

## 📋 SECURITY CHECKLIST

Before deploying to production:

- [ ] **Distance validation enabled**
- [ ] **Rate limiting configured**
- [ ] **Per-player cooldowns active**
- [ ] **Item validation enabled**
- [ ] **Job validation enabled**
- [ ] **Coordinate validation enabled**
- [ ] **Discord logging configured**
- [ ] **Admin commands tested**
- [ ] **ACE permissions set correctly**
- [ ] **Minimum police requirement set**
- [ ] **Monitor Discord logs regularly**
- [ ] **Test all security features**

---

## 🔒 BEST PRACTICES

### Server Security

1. **Keep Framework Updated**
   - Use latest framework version
   - Apply security patches promptly

2. **Monitor Logs**
   - Check Discord logs daily
   - Watch for patterns of abuse

3. **ACE Permissions**
   - Restrict admin commands
   - Use `add_ace group.admin command.blackout allow`

4. **Regular Audits**
   - Review generator states weekly
   - Check for anomalies

5. **Community Guidelines**
   - Clearly communicate rules
   - Punish exploiters swiftly

### Configuration Security

1. **Don't Disable Validation**
   - Keep `validateCoords = true`
   - Keep `logSuspiciousActivity = true`

2. **Reasonable Cooldowns**
   - Not too short (exploitable)
   - Not too long (frustrating)

3. **Balance Police Requirements**
   - Enough to prevent griefing
   - Not so high gameplay is blocked

4. **Test In Staging**
   - Test security features before production
   - Verify all validation works

---

## 🆘 REPORTING EXPLOITS

Found a security vulnerability?

**Responsible Disclosure:**
1. **DO NOT** publicly disclose
2. **DO** report privately on Discord
3. **DO** provide reproduction steps
4. **DO** wait for patch before sharing

**Contact:**
- **Discord:** https://discord.gg/CrKcWdfd3A (Private message developers)
- **GitHub:** https://github.com/iBoss21 (Security advisory)

---

## 🏆 SECURITY FEATURES SUMMARY

```
✅ Server Authority Model           - ALL decisions server-side
✅ Distance Validation              - Prevent teleport exploits
✅ Rate Limiting                    - Prevent spam/bot abuse
✅ Per-Player Cooldowns             - Prevent rapid exploits
✅ Item Validation                  - Server-side item checks
✅ Job Validation                   - Job requirement enforcement
✅ State Validation                 - Prevent invalid transitions
✅ Coordinate Validation            - Prevent coordinate spoofing
✅ Police Count Checks              - Balanced gameplay
✅ Suspicious Activity Logging      - Discord monitoring
✅ Admin Commands                   - Management tools
✅ Comprehensive Logs               - Full audit trail
```

---

**Built with 🐺 by The Land of Wolves Community**

```
════════════════════════════════════════════════════════════════════════════
Security is not a feature, it's a foundation.
© 2026 The Lux Empire | wolves.land | All Rights Reserved
════════════════════════════════════════════════════════════════════════════
```
