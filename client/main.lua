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
