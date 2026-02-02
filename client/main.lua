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
║                    🐺 LXR BLACKOUT - CLIENT MAIN 🐺                          ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝

    Client Initialization & Core Logic
    Handles player state, framework detection, and client loops
    
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
-- █  CLIENT INITIALIZATION                                                  █
-- █                                                                          █
-- ████████████████████████████████████████████████████████████████████████████

local PlayerLoaded = false
local PlayerData = {}

-- Wait for Framework to be ready
CreateThread(function()
    while not Framework or not Framework.Name do
        Wait(100)
    end
    
    if Framework.Name == 'qbox' then
        AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
            PlayerLoaded = true
            PlayerData = Framework:GetPlayerData()
        end)
        
        AddEventHandler('QBCore:Client:OnPlayerUnload', function()
            PlayerLoaded = false
            PlayerData = {}
        end)
        
    elseif Framework.Name == 'qbcore' then
        RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
            PlayerLoaded = true
            PlayerData = Framework:GetPlayerData()
        end)
        
        RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
            PlayerLoaded = false
            PlayerData = {}
        end)
        
    elseif Framework.Name == 'esx' then
        RegisterNetEvent('esx:playerLoaded', function(xPlayer)
            PlayerLoaded = true
            PlayerData = xPlayer
        end)
        
        RegisterNetEvent('esx:onPlayerLogout', function()
            PlayerLoaded = false
            PlayerData = {}
        end)
    end
end)

-- Check if player is loaded
function IsPlayerLoaded()
    return PlayerLoaded
end

-- Get current player data
function GetPlayerData()
    return PlayerData
end
