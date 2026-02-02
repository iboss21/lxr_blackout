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
║                   🐺 LXR BLACKOUT - ADMIN COMMANDS 🐺                        ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝

    Admin Command System
    Manual blackout control, generator management, and debugging tools
    
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
-- █  ADMIN COMMANDS                                                         █
-- █                                                                          █
-- ████████████████████████████████████████████████████████████████████████████

lib.addCommand('blackout', {
    help = 'Blackout manuell steuern',
    params = {
        {name = 'action', type = 'string', help = 'start/stop'},
        {name = 'zone', type = 'string', help = 'Zone ID', optional = true},
        {name = 'duration', type = 'number', help = 'Dauer in Sekunden', optional = true}
    },
    restricted = 'group.admin'
}, function(source, args)
    -- Guard: Check if action is provided
    if not args.action then
        Utils.Notify(source, 'Verwendung: /blackout [start/stop] [zone] [duration]', 'error')
        return
    end
    
    if args.action == 'start' then
        local zoneId = args.zone or 'downtown'
        local duration = args.duration or 1800
        
        if not Config.PowerZones[zoneId] then 
            Utils.Notify(source, Locale('invalid_zone'), 'error') 
            return 
        end
        
        for genId, genData in pairs(Config.Generators) do
            if genData.zone == zoneId then
                GeneratorStates[genId] = {repaired = false, sabotagedBy = 'admin', sabotagedAt = os.time()}
                TriggerClientEvent('hm_blackout:generatorSabotaged', -1, genId)
            end
        end
        
        CheckZoneBlackout(zoneId)
        Utils.Notify(source, Locale('admin_blackout_started', zoneId), 'success')
        exports.hm_blackout:SendDiscordLog('blackout', '⚡ Admin Blackout', string.format('Admin %s startete Blackout in Zone: %s', GetPlayerName(source), zoneId), SVConfig.Discord.colors.warning, {{name = 'Admin', value = GetPlayerName(source), inline = true}, {name = 'Zone', value = zoneId, inline = true}})
        
    elseif args.action == 'stop' then
        local zoneId = args.zone or 'downtown'
        
        if not Config.PowerZones[zoneId] then 
            Utils.Notify(source, Locale('invalid_zone'), 'error') 
            return 
        end
        
        for genId, genData in pairs(Config.Generators) do
            if genData.zone == zoneId then
                GeneratorStates[genId] = {repaired = true, repairedBy = 'admin', repairedAt = os.time()}
                TriggerClientEvent('hm_blackout:generatorRepaired', -1, genId)
            end
        end
        
        CheckZoneBlackout(zoneId)
        Utils.Notify(source, Locale('admin_blackout_stopped', zoneId), 'success')
        
    else
        Utils.Notify(source, 'Verwendung: /blackout [start/stop] [zone] [duration]', 'error')
    end
end)

lib.addCommand('resetgenerators', {help = 'Alle Generatoren zurücksetzen', restricted = 'group.admin'}, function(source)
    for genId, _ in pairs(Config.Generators) do
        GeneratorStates[genId] = {repaired = true, sabotagedBy = nil, sabotagedAt = 0, repairedBy = 'admin', repairedAt = os.time()}
        TriggerClientEvent('hm_blackout:generatorRepaired', -1, genId)
    end
    for zoneId, _ in pairs(Config.PowerZones) do CheckZoneBlackout(zoneId) end
    Utils.Notify(source, 'Alle Generatoren wurden zurückgesetzt', 'success')
end)
