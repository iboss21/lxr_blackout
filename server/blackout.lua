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
