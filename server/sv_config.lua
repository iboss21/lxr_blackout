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
║                🐺 LXR BLACKOUT - SERVER CONFIGURATION 🐺                     ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝

    Server-Side Configuration & Security Settings
    Discord webhooks, rate limiting, and sensitive server data
    
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
-- █  SERVER CONFIGURATION (DO NOT SHARE)                                    █
-- █                                                                          █
-- ████████████████████████████████████████████████████████████████████████████

SVConfig = {}

-- Discord Webhooks (NIEMALS in shared/!)
SVConfig.Discord = {
    enabled = true,
    
    webhooks = {
        ['blackout'] = 'https://discord.com/api/webhooks/YOUR_WEBHOOK_HERE',
        ['generator'] = 'https://discord.com/api/webhooks/YOUR_WEBHOOK_HERE',
        ['intel'] = 'https://discord.com/api/webhooks/YOUR_WEBHOOK_HERE'
    },
    
    botName = 'HM Blackout System',
    botAvatar = 'https://i.imgur.com/YOURIMAGE.png',
    
    colors = {
        success = 3066993,
        error = 15158332,
        info = 3447003,
        warning = 16776960
    }
}

-- Database Settings (optional)
SVConfig.Database = {
    enabled = false,
    tableName = 'hm_blackout_generators'
}

-- Admin Identifiers
SVConfig.Admins = {
    -- 'license:abc123',
}

-- Rate Limiting
SVConfig.RateLimit = {
    enabled = true,
    maxRequests = 10,
    timeWindow = 60
}
