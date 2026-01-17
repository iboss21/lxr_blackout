-- SERVER EXPORTS
-- These functions can be called from other scripts

-- Manually start a blackout in a zone (sabotage all generators)
-- Usage: exports.hm_blackout:StartBlackout('downtown')
-- Returns: boolean (success)
function StartBlackout(zoneId)
    local zoneData = Config.PowerZones[zoneId]
    if not zoneData then
        print('^3[HM_BLACKOUT] StartBlackout failed: Zone "' .. tostring(zoneId) .. '" not found^7')
        return false
    end
    
    -- Sabotage all generators in the zone
    for _, genId in ipairs(zoneData.generators) do
        if GeneratorStates[genId] then
            GeneratorStates[genId] = {
                repaired = false,
                sabotagedBy = 'system',
                sabotagedAt = os.time(),
                repairedBy = nil,
                repairedAt = 0
            }
            TriggerClientEvent('hm_blackout:generatorSabotaged', -1, genId)
        end
    end
    
    -- Trigger blackout check
    CheckZoneBlackout(zoneId)
    
    print('^2[HM_BLACKOUT] Blackout started in zone: ' .. zoneId .. '^7')
    return true
end

-- Manually end a blackout in a zone (repair all generators)
-- Usage: exports.hm_blackout:EndBlackout('downtown')
-- Returns: boolean (success)
function EndBlackout(zoneId)
    local zoneData = Config.PowerZones[zoneId]
    if not zoneData then
        print('^3[HM_BLACKOUT] EndBlackout failed: Zone "' .. tostring(zoneId) .. '" not found^7')
        return false
    end
    
    -- Repair all generators in the zone
    for _, genId in ipairs(zoneData.generators) do
        if GeneratorStates[genId] then
            GeneratorStates[genId] = {
                repaired = true,
                sabotagedBy = nil,
                sabotagedAt = 0,
                repairedBy = 'system',
                repairedAt = os.time()
            }
            TriggerClientEvent('hm_blackout:generatorRepaired', -1, genId)
        end
    end
    
    -- Trigger blackout check
    CheckZoneBlackout(zoneId)
    
    print('^2[HM_BLACKOUT] Blackout ended in zone: ' .. zoneId .. '^7')
    return true
end

-- Check if a zone is currently in blackout
-- Usage: local isBlackout = exports.hm_blackout:IsZoneInBlackout('downtown')
-- Returns: boolean
function IsZoneInBlackout(zoneId)
    return BlackoutZoneStates[zoneId] and BlackoutZoneStates[zoneId].active or false
end

-- Get all zones with their blackout status
-- Usage: local zones = exports.hm_blackout:GetAllZonesStatus()
-- Returns: table {{zoneId = 'downtown', active = true, generators = {...}}, ...}
function GetAllZonesStatus()
    local result = {}
    for zoneId, zoneData in pairs(Config.PowerZones) do
        local generatorStates = {}
        for _, genId in ipairs(zoneData.generators) do
            generatorStates[genId] = GeneratorStates[genId]
        end
        
        table.insert(result, {
            zoneId = zoneId,
            label = zoneData.label,
            active = IsZoneInBlackout(zoneId),
            generators = generatorStates,
            generatorCount = #zoneData.generators
        })
    end
    return result
end

-- Get state of a specific generator
-- Usage: local state = exports.hm_blackout:GetGeneratorState('gen_downtown_main')
-- Returns: table {repaired = bool, sabotagedBy = string, sabotagedAt = number}
function GetGeneratorState(genId)
    return GeneratorStates[genId]
end

-- Sabotage a specific generator
-- Usage: exports.hm_blackout:SabotageGenerator('gen_downtown_main')
-- Returns: boolean (success)
function SabotageGenerator(genId)
    local genData = Config.Generators[genId]
    if not genData then return false end
    
    GeneratorStates[genId] = {
        repaired = false,
        sabotagedBy = 'system',
        sabotagedAt = os.time(),
        repairedBy = nil,
        repairedAt = 0
    }
    
    TriggerClientEvent('hm_blackout:generatorSabotaged', -1, genId)
    CheckZoneBlackout(genData.zone)
    
    return true
end

-- Repair a specific generator
-- Usage: exports.hm_blackout:RepairGenerator('gen_downtown_main')
-- Returns: boolean (success)
function RepairGenerator(genId)
    local genData = Config.Generators[genId]
    if not genData then return false end
    
    GeneratorStates[genId] = {
        repaired = true,
        sabotagedBy = nil,
        sabotagedAt = 0,
        repairedBy = 'system',
        repairedAt = os.time()
    }
    
    TriggerClientEvent('hm_blackout:generatorRepaired', -1, genId)
    CheckZoneBlackout(genData.zone)
    
    return true
end

-- Export functions
exports('StartBlackout', StartBlackout)
exports('EndBlackout', EndBlackout)
exports('IsZoneInBlackout', IsZoneInBlackout)
exports('GetAllZonesStatus', GetAllZonesStatus)
exports('GetGeneratorState', GetGeneratorState)
exports('SabotageGenerator', SabotageGenerator)
exports('RepairGenerator', RepairGenerator)
exports('GetJobCount', Framework.GetJobCount)
exports('SendDiscordLog', SendDiscordLog)
