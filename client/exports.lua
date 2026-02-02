--[[
╔══════════════════════════════════════════════════════════════════════════════╗
║                                                                              ║
║    ██╗     ██╗  ██╗██████╗     ██████╗ ██╗      █████╗  ██████╗██╗  ██╗    ║
║    ██║     ╚██╗██╔╝██╔══██╗    ██╔══██╗██║     ██╔══██╗██╔════╝██║ ██╔╝    ║
║    ██║      ╚███╔╝ ██████╔╝    ██████╔╝██║     ███████║██║     █████╔╝     ║
║    ██║      ██╔██╗ ██╔══██╗    ██╔══██╗██║     ██╔══██║██║     ██╔═██╗     ║
║    ███████╗██╔╝ ██╗██║  ██║    ██████╔╝███████╗██║  ██║╚██████╗██║  ██╗    ║
║    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝    ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ║
║     ██████╗ ██╗   ██╗████████╗                                              ║
║    ██╔═══██╗██║   ██║╚══██╔══╝                                              ║
║    ██║   ██║██║   ██║   ██║                                                 ║
║    ██║   ██║██║   ██║   ██║                                                 ║
║    ╚██████╔╝╚██████╔╝   ██║                                                 ║
║     ╚═════╝  ╚═════╝    ╚═╝                                                 ║
║                                                                              ║
║                   🐺 LXR BLACKOUT - CLIENT EXPORTS 🐺                        ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝

    Client-Side Export Functions
    External API for other resources to interact with blackout system
    
    🌟 SERVER INFORMATION
    ════════════════════════════════════════════════════════════════════════════
    Server:           The Land of Wolves 🐺
    Community:        Georgian RP 🇬🇪 | მგლების მიწა
    Description:      ისტორია ცოცხლდება აქ! (History Lives Here!)
    Type:             Serious Hardcore Roleplay
    ════════════════════════════════════════════════════════════════════════════
    
    📦 VERSION & CREDITS
    ════════════════════════════════════════════════════════════════════════════
    Version:          3.0.0 (LXR Edition)
    Created By:       iBoss21 / The Lux Empire
    Modified For:     Land of Wolves Server
    ════════════════════════════════════════════════════════════════════════════
]]--

-- ████████████████████████████████████████████████████████████████████████████
-- █                                                                          █
-- █  CLIENT EXPORTS                                                         █
-- █                                                                          █
-- ████████████████████████████████████████████████████████████████████████████

-- CLIENT EXPORTS
-- These functions can be called from other scripts

-- Check if ANY zone is currently in blackout
-- Usage: local hasBlackout = exports.hm_blackout:GetBlackoutStatus()
-- Returns: boolean
function GetBlackoutStatus()
    for zoneId, state in pairs(BlackoutZoneStates or {}) do
        if state.active then
            return true
        end
    end
    return false
end

-- Check if a specific zone is in blackout
-- Usage: local isBlackout = exports.hm_blackout:IsZoneInBlackout('downtown')
-- Returns: boolean
function IsZoneInBlackout(zoneId)
    if not BlackoutZoneStates then return false end
    return BlackoutZoneStates[zoneId] and BlackoutZoneStates[zoneId].active or false
end

-- Get state of a specific generator
-- Usage: local state = exports.hm_blackout:GetGeneratorState('gen_downtown_main')
-- Returns: table {repaired = bool, sabotagedBy = string, sabotagedAt = number}
function GetGeneratorState(genId)
    if not GeneratorStates then return nil end
    return GeneratorStates[genId]
end

-- Check if player is currently in a blackout zone
-- Usage: local inZone = exports.hm_blackout:IsPlayerInBlackoutZone()
-- Returns: boolean
function IsPlayerInBlackoutZone()
    return PlayerInBlackoutZone or false
end

-- Get list of all active blackout zones
-- Usage: local zones = exports.hm_blackout:GetActiveBlackoutZones()
-- Returns: table {zoneId = true, ...}
function GetActiveBlackoutZones()
    return ActiveBlackoutZones or {}
end

-- Get all zones with their blackout status
-- Usage: local zones = exports.hm_blackout:GetAllZonesStatus()
-- Returns: table {{zoneId = 'downtown', label = 'Downtown', active = true}, ...}
function GetAllZonesStatus()
    local result = {}
    for zoneId, zoneData in pairs(Config.PowerZones) do
        table.insert(result, {
            zoneId = zoneId,
            label = zoneData.label,
            active = IsZoneInBlackout(zoneId),
            generators = zoneData.generators
        })
    end
    return result
end

-- Export functions
exports('GetBlackoutStatus', GetBlackoutStatus)
exports('IsZoneInBlackout', IsZoneInBlackout)
exports('GetGeneratorState', GetGeneratorState)
exports('IsPlayerInBlackoutZone', IsPlayerInBlackoutZone)
exports('GetActiveBlackoutZones', GetActiveBlackoutZones)
exports('GetAllZonesStatus', GetAllZonesStatus)
