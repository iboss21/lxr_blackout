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
║                  🐺 LXR BLACKOUT - GENERATOR SYSTEM 🐺                       ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝

    Generator Management & Sabotage System
    Handles generator states, repairs, sabotage, and cooldowns
    
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
-- █  GENERATOR MANAGEMENT & ANTI-EXPLOIT                                    █
-- █                                                                          █
-- ████████████████████████████████████████████████████████████████████████████

local PlayerCooldowns = {}
local RateLimits = {}

local function CheckRateLimit(source, action, max, window)
    local identifier = action .. '_' .. source
    local currentTime = os.time()
    if not RateLimits[identifier] then RateLimits[identifier] = {requests = {}} end
    local limit = RateLimits[identifier]
    local validRequests = {}
    for _, timestamp in ipairs(limit.requests) do
        if currentTime - timestamp < window then table.insert(validRequests, timestamp) end
    end
    limit.requests = validRequests
    if #limit.requests >= max then return false end
    table.insert(limit.requests, currentTime)
    return true
end

local function CheckCooldown(source, action, seconds)
    local identifier = action .. '_' .. source
    local currentTime = os.time()
    if PlayerCooldowns[identifier] then
        local elapsed = currentTime - PlayerCooldowns[identifier]
        if elapsed < seconds then return false, seconds - elapsed end
    end
    PlayerCooldowns[identifier] = currentTime
    return true, 0
end

function InitializeGenerators()
    for genId, genData in pairs(Config.Generators) do
        -- Start with generators sabotaged (offline) so blackout is active from the start
        GeneratorStates[genId] = {
            repaired = false,  -- Changed to false = sabotaged
            sabotagedBy = 'system',
            sabotagedAt = os.time(),
            repairedBy = nil,
            repairedAt = 0
        }
    end
    
    -- Trigger initial blackout check for all zones
    for zoneId, _ in pairs(Config.PowerZones) do
        CheckZoneBlackout(zoneId)
    end
end

CreateThread(function()
    Wait(1000)
    InitializeGenerators()
end)

RegisterNetEvent('hm_blackout:sabotageGenerator', function(genId)
    local source = source
    if not CheckRateLimit(source, 'sabotage', 5, 300) then Utils.Notify(source, Locale('rate_limit'), 'error') return end
    local canSabotage, remaining = CheckCooldown(source, 'sabotage_' .. genId, 600)
    if not canSabotage then Utils.Notify(source, Locale('cooldown_active', math.ceil(remaining / 60)), 'error') return end
    local genData = Config.Generators[genId]
    if not genData or not genData.canBeSabotaged then return end
    if GeneratorStates[genId] and not GeneratorStates[genId].repaired then Utils.Notify(source, Locale('already_sabotaged'), 'error') return end
    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    if #(playerCoords - genData.coords) > 10.0 then Utils.Notify(source, Locale('too_far'), 'error') return end
    if genData.sabotageItem and Inventory:GetItemCount(source, genData.sabotageItem) <= 0 then Utils.Notify(source, Locale('need_item', genData.sabotageItem), 'error') return end
    TriggerClientEvent('hm_blackout:startSabotageMinigame', source, genId, genData.sabotageTime or 30)
end)

RegisterNetEvent('hm_blackout:repairGenerator', function(genId)
    local source = source
    if not CheckRateLimit(source, 'repair', 10, 60) then Utils.Notify(source, Locale('rate_limit'), 'error') return end
    local genData = Config.Generators[genId]
    if not genData then return end
    if GeneratorStates[genId] and GeneratorStates[genId].repaired then Utils.Notify(source, Locale('already_repaired'), 'error') return end
    if genData.requiredJob then
        local job = Framework:GetJob(source)
        local hasJob = false
        for _, allowedJob in ipairs(genData.requiredJob) do if job == allowedJob then hasJob = true break end end
        if not hasJob then Utils.Notify(source, Locale('wrong_job'), 'error') return end
    end
    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    if #(playerCoords - genData.coords) > 10.0 then Utils.Notify(source, Locale('too_far'), 'error') return end
    for _, itemReq in ipairs(genData.requiredItems) do
        if Inventory:GetItemCount(source, itemReq.item) < itemReq.amount then Utils.Notify(source, Locale('need_item', itemReq.item), 'error') return end
    end
    TriggerClientEvent('hm_blackout:startRepair', source, genId, genData.repairTime or 120)
end)
