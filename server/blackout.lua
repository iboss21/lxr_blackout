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
║                  🐺 LXR BLACKOUT - BLACKOUT MANAGER 🐺                       ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝

    Regional Blackout System Manager
    Handles zone blackout states, power grid logic, and event synchronization
    
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
-- █  BLACKOUT STATE MANAGEMENT                                              █
-- █                                                                          █
-- ████████████████████████████████████████████████████████████████████████████

BlackoutZoneStates = {}
GeneratorStates = {}

local function CheckZoneBlackout(zoneId)
    local zoneData = Config.PowerZones[zoneId]
    if not zoneData then return end
    
    local allOffline = true
    for _, genId in ipairs(zoneData.generators) do
        if GeneratorStates[genId] and GeneratorStates[genId].repaired then
            allOffline = false
            break
        end
    end
    
    local wasActive = BlackoutZoneStates[zoneId] and BlackoutZoneStates[zoneId].active
    
    if allOffline and not wasActive then
        BlackoutZoneStates[zoneId] = {
            active = true,
            startedAt = os.time(),
            affectedGenerators = zoneData.generators
        }
        TriggerClientEvent('hm_blackout:zoneStateChanged', -1, zoneId, true, zoneData.lightIntensity)
        exports.hm_blackout:SendDiscordLog('blackout', 'Zone Blackout', string.format('Zone "%s" ist im Blackout!', zoneData.label), SVConfig.Discord.colors.error, {{name = 'Zone', value = zoneData.label, inline = true}})
    elseif not allOffline and wasActive then
        BlackoutZoneStates[zoneId].active = false
        TriggerClientEvent('hm_blackout:zoneStateChanged', -1, zoneId, false)
        exports.hm_blackout:SendDiscordLog('blackout', 'Zone Wiederhergestellt', string.format('Stromversorgung in Zone "%s" wiederhergestellt', zoneData.label), SVConfig.Discord.colors.success, {{name = 'Zone', value = zoneData.label, inline = true}})
    end
end

_G.CheckZoneBlackout = CheckZoneBlackout
