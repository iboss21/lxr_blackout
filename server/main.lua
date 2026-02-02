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

-- ████████████████████████████████████████████████████████████████████████████
-- █                                                                          █
-- █  DEPENDENCY CHECKS                                                      █
-- █                                                                          █
-- ████████████████████████████████████████████████████████████████████████████

local REQUIRED_OX_LIB = '3.0.0'

CreateThread(function()
    local oxVersion = GetResourceMetadata('ox_lib', 'version', 0)
    
    if not oxVersion then
        error([[
            
            ╔═══════════════════════════════════════════════════════════════╗
            ║                    ⚠️  DEPENDENCY ERROR ⚠️                    ║
            ╠═══════════════════════════════════════════════════════════════╣
            ║                                                               ║
            ║  ox_lib is required but not found!                           ║
            ║  Please install ox_lib before starting this resource.        ║
            ║                                                               ║
            ║  Download: https://github.com/overextended/ox_lib           ║
            ║                                                               ║
            ╚═══════════════════════════════════════════════════════════════╝
            
        ]])
        return
    end
    
    -- Wait for Framework to be ready
    local attempts = 0
    while not Framework.Ready and attempts < 100 do
        Wait(100)
        attempts = attempts + 1
    end
    
    if not Framework.Ready then
        error('[LXR-BLACKOUT] Framework failed to initialize after 10 seconds!')
        return
    end
    
    print(string.format([[
        
        ^2[LXR-BLACKOUT] Server initialized successfully!^7
        ^2[LXR-BLACKOUT] Framework: ^3%s^7
        ^2[LXR-BLACKOUT] Version: ^3v3.0.0 (LXR Edition)^7
        ^2[LXR-BLACKOUT] Server: ^6%s^7
        
    ]], Framework.Name or 'Unknown', Config.ServerInfo.name))
end)

-- ████████████████████████████████████████████████████████████████████████████
-- █                                                                          █
-- █  RESOURCE LIFECYCLE                                                     █
-- █                                                                          █
-- ████████████████████████████████████████████████████████████████████████████

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        print('^3[LXR-BLACKOUT]^7 Resource stopped. Cleanup completed.')
    end
end)
