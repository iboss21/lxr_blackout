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
║                   🐺 LXR BLACKOUT - USER INTERFACE 🐺                        ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝

    User Interface System
    Handles on-screen notifications, timers, and UI elements
    
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
-- █  USER INTERFACE SYSTEM                                                  █
-- █                                                                          █
-- ████████████████████████████████████████████████████████████████████████████

local BlackoutTimerActive = false
local BlackoutEndTime = 0

local function ShowBlackoutTimer(duration)
    BlackoutTimerActive = true
    BlackoutEndTime = GetGameTimer() + (duration * 1000)
    
    CreateThread(function()
        while BlackoutTimerActive do
            local remaining = math.max(0, BlackoutEndTime - GetGameTimer())
            local seconds = math.floor(remaining / 1000)
            local minutes = math.floor(seconds / 60)
            local displaySeconds = seconds % 60
            
            SetTextFont(4)
            SetTextProportional(1)
            SetTextScale(0.5, 0.5)
            SetTextColour(255, 100, 100, 255)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextEdge(1, 0, 0, 0, 255)
            SetTextDropShadow()
            SetTextOutline()
            SetTextEntry('STRING')
            AddTextComponentString(string.format('~r~BLACKOUT~s~\n%02d:%02d', minutes, displaySeconds))
            DrawText(0.95, 0.02)
            
            if remaining <= 0 then
                BlackoutTimerActive = false
            end
            
            Wait(0)
        end
    end)
end

local function HideBlackoutTimer()
    BlackoutTimerActive = false
end

RegisterNetEvent('hm_blackout:zoneStateChanged', function(zoneId, active, intensity)
    if active then
        local zoneData = Config.PowerZones[zoneId]
        if zoneData then
            ShowBlackoutTimer(1800)
        end
    else
        HideBlackoutTimer()
    end
end)

exports('ShowBlackoutTimer', ShowBlackoutTimer)
exports('HideBlackoutTimer', HideBlackoutTimer)
