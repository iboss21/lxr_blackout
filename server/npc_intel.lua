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
║                 🐺 LXR BLACKOUT - INTEL NPC HANDLER 🐺                       ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝

    Intel NPC Management System
    Handles intel purchases, cooldowns, and location reveals
    
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
-- █  INTEL NPC HANDLER                                                      █
-- █                                                                          █
-- ████████████████████████████████████████████████████████████████████████████

local PlayerIntelCooldowns = {}

RegisterNetEvent('hm_blackout:buyIntel', function(npcId, zoneId)
    local source = source
    local npcData = Config.IntelNPCs[npcId]
    if not npcData then return end
    local zoneData = Config.PowerZones[zoneId]
    if not zoneData then return end
    local hasZone = false
    for _, z in ipairs(npcData.intelZones) do if z == zoneId then hasZone = true break end end
    if not hasZone then return end
    local identifier = source .. '_' .. npcId
    if PlayerIntelCooldowns[identifier] then
        local elapsed = os.time() - PlayerIntelCooldowns[identifier]
        if elapsed < npcData.cooldown then Utils.Notify(source, Locale('intel_cooldown', math.ceil((npcData.cooldown - elapsed) / 60)), 'error') return end
    end
    local price = npcData.pricePerZone[zoneId]
    if Framework:GetMoney(source, 'cash') < price then Utils.Notify(source, Locale('not_enough_money'), 'error') return end
    Framework:RemoveMoney(source, 'cash', price)
    PlayerIntelCooldowns[identifier] = os.time()
    local intelData = Config.IntelData[zoneId]
    TriggerClientEvent('hm_blackout:receiveIntel', source, zoneId, intelData)
    Utils.Notify(source, Locale('intel_purchased', price), 'success')
    exports.hm_blackout:SendDiscordLog('intel', 'Intel Gekauft', string.format('%s kaufte Intel über %s für $%s', GetPlayerName(source), zoneData.label, price), SVConfig.Discord.colors.info, {{name = 'Spieler', value = GetPlayerName(source), inline = true}, {name = 'Zone', value = zoneData.label, inline = true}})
end)
