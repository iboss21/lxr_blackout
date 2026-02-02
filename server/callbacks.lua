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
║                 🐺 LXR BLACKOUT - SERVER CALLBACKS 🐺                        ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝

    Server Callback System
    Handles callbacks for sabotage, repair, and state queries
    
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
-- █  SERVER CALLBACKS                                                       █
-- █                                                                          █
-- ████████████████████████████████████████████████████████████████████████████

lib.callback.register('hm_blackout:completeSabotage', function(source, genId)
    local genData = Config.Generators[genId]
    if not genData then return false end
    if genData.sabotageItem then Inventory:RemoveItem(source, genData.sabotageItem, 1) end
    GeneratorStates[genId] = {repaired = false, sabotagedBy = Framework:GetIdentifier(source), sabotagedAt = os.time(), repairedBy = nil, repairedAt = 0}
    TriggerClientEvent('hm_blackout:generatorSabotaged', -1, genId)
    CheckZoneBlackout(genData.zone)
    exports.hm_blackout:SendDiscordLog('generator', 'Generator Sabotiert', string.format('%s wurde von %s sabotiert', genData.label, GetPlayerName(source)), SVConfig.Discord.colors.error, {{name = 'Generator', value = genData.label, inline = true}, {name = 'Zone', value = genData.zone, inline = true}})
    if Config.EnableDispatch then TriggerEvent('hm_blackout:sendDispatch', genData.coords, genData.label) end
    return true
end)

lib.callback.register('hm_blackout:completeRepair', function(source, genId)
    local genData = Config.Generators[genId]
    if not genData then return false end
    for _, itemReq in ipairs(genData.requiredItems) do Inventory:RemoveItem(source, itemReq.item, itemReq.amount) end
    GeneratorStates[genId] = {repaired = true, sabotagedBy = nil, sabotagedAt = 0, repairedBy = Framework:GetIdentifier(source), repairedAt = os.time()}
    TriggerClientEvent('hm_blackout:generatorRepaired', -1, genId)
    CheckZoneBlackout(genData.zone)
    if Config.RepairReward and Config.RepairReward > 0 then Framework:AddMoney(source, 'cash', Config.RepairReward) Utils.Notify(source, Locale('repair_reward', Config.RepairReward), 'success') end
    exports.hm_blackout:SendDiscordLog('generator', 'Generator Repariert', string.format('%s wurde von %s repariert', genData.label, GetPlayerName(source)), SVConfig.Discord.colors.success, {{name = 'Generator', value = genData.label, inline = true}})
    return true
end)
