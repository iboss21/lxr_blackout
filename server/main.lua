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
║                    🐺 LXR BLACKOUT - SERVER MAIN 🐺                          ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝

    Server Initialization & Core Logic
    Handles startup checks, framework detection, and main server loops
    
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
-- █  SERVER INITIALIZATION                                                  █
-- █                                                                          █
-- ████████████████████████████████████████████████████████████████████████████

local REQUIRED_OX_LIB = '3.0.0'

CreateThread(function()
    local oxVersion = GetResourceMetadata('ox_lib', 'version', 0)
    
    if not oxVersion then
        error('[HM_BLACKOUT] ox_lib nicht gefunden! Bitte installiere ox_lib.')
        return
    end
    
    print(string.format([[
^2╔═══════════════════════════════════════╗
║   HM BLACKOUT - v1.0.0                ║
║   by MopsScripts                      ║
║                                       ║
║   Framework: %-24s║
║   Inventory: %-24s║
║                                       ║
║   Status: ^2RUNNING^7                     ║
╚═══════════════════════════════════════╝^7
    ]], Framework.Name, Inventory.Name))
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        print('^3[HM_BLACKOUT]^7 Resource gestoppt. Cleanup durchgeführt.')
    end
end)
