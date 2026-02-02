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
║              🐺 LXR BLACKOUT SYSTEM - FRAMEWORK BRIDGE (NEW) 🐺              ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝

    Multi-Framework Bridge with Auto-Detection & Unified API
    Provides consistent framework interface across all supported frameworks
    
    🌟 SERVER INFORMATION
    ════════════════════════════════════════════════════════════════════════════
    Server:           The Land of Wolves 🐺
    Community:        Georgian RP 🇬🇪 | მგლების მიწა
    Description:      ისტორია ცოცხლდება აქ! (History Lives Here!)
    Type:             Serious Hardcore Roleplay
    ════════════════════════════════════════════════════════════════════════════
    
    🔧 SUPPORTED FRAMEWORKS (Priority Order)
    ════════════════════════════════════════════════════════════════════════════
    1. LXR-Core       ✅ Primary Framework (Land of Wolves Custom)
    2. RSG-Core       ✅ Primary Framework (RedM Standard)
    3. VORP Core      ✅ Full Support (Legacy)
    4. QBox           ✅ Auto-Detected
    5. QBCore         ✅ Auto-Detected
    6. ESX            ✅ Auto-Detected
    ════════════════════════════════════════════════════════════════════════════
]]--

-- ████████████████████████████████████████████████████████████████████████████
-- █                                                                          █
-- █  FRAMEWORK AUTO-DETECTION SYSTEM                                        █
-- █                                                                          █
-- ████████████████████████████████████████████████████████████████████████████

Framework = {}
Framework.Name = nil
Framework.Object = nil
Framework.Ready = false

local FrameworkPriority = {
    { name = 'LXR-Core', resource = 'lxr-core', export = 'GetCoreObject' },
    { name = 'RSG-Core', resource = 'rsg-core', export = 'GetCoreObject' },
    { name = 'VORP', resource = 'vorp_core', export = 'getCore' },
    { name = 'QBox', resource = 'qbx_core', export = 'GetCoreObject' },
    { name = 'QBCore', resource = 'qb-core', export = 'GetCoreObject' },
    { name = 'ESX', resource = 'es_extended', export = 'getSharedObject' }
}

-- ████████████████████████████████████████████████████████████████████████████
-- █                                                                          █
-- █  DETECTION & INITIALIZATION                                             █
-- █                                                                          █
-- ████████████████████████████████████████████████████████████████████████████

local function DetectFramework()
    print('^5[LXR-BLACKOUT]^0 🔍 Detecting framework...')
    
    for _, fw in ipairs(FrameworkPriority) do
        local status = GetResourceState(fw.resource)
        
        if status == 'started' or status == 'starting' then
            print('^2[LXR-BLACKOUT]^0 ✅ Found ' .. fw.name .. ' (resource: ' .. fw.resource .. ')')
            
            local success, coreObject = pcall(function()
                return exports[fw.resource][fw.export]()
            end)
            
            if success and coreObject then
                Framework.Name = fw.name
                Framework.Object = coreObject
                Framework.Ready = true
                
                print('^2[LXR-BLACKOUT]^0 🎯 Framework initialized: ' .. fw.name)
                return true
            else
                print('^3[LXR-BLACKOUT]^0 ⚠️  Found ' .. fw.name .. ' but failed to get core object')
            end
        end
    end
    
    print('^1[LXR-BLACKOUT]^0 ❌ No framework detected!')
    return false
end

-- Wait for framework to be ready
local function WaitForFramework()
    local timeout = 0
    while not Framework.Ready and timeout < 50 do
        if DetectFramework() then
            break
        end
        timeout = timeout + 1
        Wait(100)
    end
    
    if not Framework.Ready then
        print('^1[LXR-BLACKOUT]^0 ❌ Framework failed to initialize after 5 seconds!')
    end
    
    return Framework.Ready
end

-- Initialize on resource start
CreateThread(function()
    WaitForFramework()
end)

-- ████████████████████████████████████████████████████████████████████████████
-- █                                                                          █
-- █  CLIENT-SIDE FUNCTIONS                                                  █
-- █                                                                          █
-- ████████████████████████████████████████████████████████████████████████████

if IsDuplicityVersion() == 0 then -- CLIENT SIDE ONLY
    
    local PlayerData = {}
    
    -- ═══════════════════════════════════════════════════════════════════════
    -- Get Player Data
    -- ═══════════════════════════════════════════════════════════════════════
    function Framework:GetPlayerData()
        if not self.Ready then
            print('^3[LXR-BLACKOUT]^0 ⚠️  Framework not ready in GetPlayerData')
            return {}
        end
        
        if self.Name == 'LXR-Core' or self.Name == 'RSG-Core' or self.Name == 'QBox' or self.Name == 'QBCore' then
            return self.Object.Functions.GetPlayerData() or {}
        elseif self.Name == 'VORP' then
            return PlayerData or {}
        elseif self.Name == 'ESX' then
            return self.Object.GetPlayerData() or {}
        end
        
        return {}
    end
    
    -- ═══════════════════════════════════════════════════════════════════════
    -- Get Player Job
    -- ═══════════════════════════════════════════════════════════════════════
    function Framework:GetJob()
        local playerData = self:GetPlayerData()
        
        if self.Name == 'LXR-Core' or self.Name == 'RSG-Core' or self.Name == 'QBox' or self.Name == 'QBCore' then
            return playerData.job or {}
        elseif self.Name == 'VORP' then
            return playerData.job or {}
        elseif self.Name == 'ESX' then
            return playerData.job or {}
        end
        
        return {}
    end
    
    -- ═══════════════════════════════════════════════════════════════════════
    -- Get Player Job Grade
    -- ═══════════════════════════════════════════════════════════════════════
    function Framework:GetJobGrade()
        local job = self:GetJob()
        
        if self.Name == 'LXR-Core' or self.Name == 'RSG-Core' or self.Name == 'QBox' or self.Name == 'QBCore' then
            return job.grade and job.grade.level or 0
        elseif self.Name == 'VORP' then
            return job.grade or 0
        elseif self.Name == 'ESX' then
            return job.grade or 0
        end
        
        return 0
    end
    
    -- ═══════════════════════════════════════════════════════════════════════
    -- Check if Player Has Specific Job
    -- ═══════════════════════════════════════════════════════════════════════
    function Framework:HasJob(jobName)
        if not jobName then return false end
        
        local job = self:GetJob()
        
        if self.Name == 'LXR-Core' or self.Name == 'RSG-Core' or self.Name == 'QBox' or self.Name == 'QBCore' then
            return job.name == jobName
        elseif self.Name == 'VORP' then
            return job.name == jobName
        elseif self.Name == 'ESX' then
            return job.name == jobName
        end
        
        return false
    end
    
    -- ═══════════════════════════════════════════════════════════════════════
    -- Framework Event Handlers (CLIENT)
    -- ═══════════════════════════════════════════════════════════════════════
    
    if Framework.Name == 'LXR-Core' then
        -- LXR-Core Events
        RegisterNetEvent('lxr-core:client:player:loaded', function(playerData)
            PlayerData = playerData
            print('^2[LXR-BLACKOUT]^0 ✅ LXR-Core player loaded')
        end)
        
        RegisterNetEvent('lxr-core:client:player:unload', function()
            PlayerData = {}
            print('^3[LXR-BLACKOUT]^0 ⚠️  LXR-Core player unloaded')
        end)
        
        RegisterNetEvent('lxr-core:client:player:update', function(playerData)
            PlayerData = playerData
        end)
        
    elseif Framework.Name == 'RSG-Core' then
        -- RSG-Core Events
        RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
            PlayerData = Framework.Object.Functions.GetPlayerData()
            print('^2[LXR-BLACKOUT]^0 ✅ RSG-Core player loaded')
        end)
        
        RegisterNetEvent('RSGCore:Client:OnPlayerUnload', function()
            PlayerData = {}
            print('^3[LXR-BLACKOUT]^0 ⚠️  RSG-Core player unloaded')
        end)
        
        RegisterNetEvent('RSGCore:Player:SetPlayerData', function(playerData)
            PlayerData = playerData
        end)
        
    elseif Framework.Name == 'VORP' then
        -- VORP Events
        RegisterNetEvent('vorp:SelectedCharacter', function(charid)
            TriggerEvent('vorp:getCharacter', function(user)
                PlayerData = user
                print('^2[LXR-BLACKOUT]^0 ✅ VORP character loaded')
            end)
        end)
        
        RegisterNetEvent('vorp:PlayerLogout', function()
            PlayerData = {}
            print('^3[LXR-BLACKOUT]^0 ⚠️  VORP player logged out')
        end)
        
    elseif Framework.Name == 'QBox' or Framework.Name == 'QBCore' then
        -- QBCore/QBox Events
        RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
            PlayerData = Framework.Object.Functions.GetPlayerData()
            print('^2[LXR-BLACKOUT]^0 ✅ ' .. Framework.Name .. ' player loaded')
        end)
        
        RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
            PlayerData = {}
            print('^3[LXR-BLACKOUT]^0 ⚠️  ' .. Framework.Name .. ' player unloaded')
        end)
        
        RegisterNetEvent('QBCore:Player:SetPlayerData', function(playerData)
            PlayerData = playerData
        end)
        
    elseif Framework.Name == 'ESX' then
        -- ESX Events
        RegisterNetEvent('esx:playerLoaded', function(playerData)
            PlayerData = playerData
            print('^2[LXR-BLACKOUT]^0 ✅ ESX player loaded')
        end)
        
        RegisterNetEvent('esx:onPlayerLogout', function()
            PlayerData = {}
            print('^3[LXR-BLACKOUT]^0 ⚠️  ESX player logged out')
        end)
        
        RegisterNetEvent('esx:setJob', function(job)
            if PlayerData then
                PlayerData.job = job
            end
        end)
    end
end

-- ████████████████████████████████████████████████████████████████████████████
-- █                                                                          █
-- █  SERVER-SIDE FUNCTIONS                                                  █
-- █                                                                          █
-- ████████████████████████████████████████████████████████████████████████████

if IsDuplicityVersion() == 1 then -- SERVER SIDE ONLY
    
    -- ═══════════════════════════════════════════════════════════════════════
    -- Get Player Object
    -- ═══════════════════════════════════════════════════════════════════════
    function Framework:GetPlayer(source)
        if not self.Ready then
            print('^3[LXR-BLACKOUT]^0 ⚠️  Framework not ready in GetPlayer')
            return nil
        end
        
        if not source then
            print('^3[LXR-BLACKOUT]^0 ⚠️  Invalid source in GetPlayer')
            return nil
        end
        
        if self.Name == 'LXR-Core' or self.Name == 'RSG-Core' or self.Name == 'QBox' or self.Name == 'QBCore' then
            return self.Object.Functions.GetPlayer(source)
        elseif self.Name == 'VORP' then
            local Core = self.Object
            local user = Core.getUser(source)
            return user and user.getUsedCharacter()
        elseif self.Name == 'ESX' then
            return self.Object.GetPlayerFromId(source)
        end
        
        return nil
    end
    
    -- ═══════════════════════════════════════════════════════════════════════
    -- Get Player Identifier
    -- ═══════════════════════════════════════════════════════════════════════
    function Framework:GetIdentifier(source)
        local player = self:GetPlayer(source)
        
        if not player then
            return nil
        end
        
        if self.Name == 'LXR-Core' or self.Name == 'RSG-Core' or self.Name == 'QBox' or self.Name == 'QBCore' then
            return player.PlayerData.citizenid
        elseif self.Name == 'VORP' then
            return tostring(player.charIdentifier)
        elseif self.Name == 'ESX' then
            return player.identifier
        end
        
        return nil
    end
    
    -- ═══════════════════════════════════════════════════════════════════════
    -- Get Player Job (Server)
    -- ═══════════════════════════════════════════════════════════════════════
    function Framework:GetJob(source)
        local player = self:GetPlayer(source)
        
        if not player then
            return nil
        end
        
        if self.Name == 'LXR-Core' or self.Name == 'RSG-Core' or self.Name == 'QBox' or self.Name == 'QBCore' then
            return player.PlayerData.job
        elseif self.Name == 'VORP' then
            return player.job
        elseif self.Name == 'ESX' then
            return player.job
        end
        
        return nil
    end
    
    -- ═══════════════════════════════════════════════════════════════════════
    -- Get Player Money
    -- ═══════════════════════════════════════════════════════════════════════
    function Framework:GetMoney(source, moneyType)
        local player = self:GetPlayer(source)
        
        if not player then
            return 0
        end
        
        moneyType = moneyType or 'cash'
        
        if self.Name == 'LXR-Core' or self.Name == 'RSG-Core' or self.Name == 'QBox' or self.Name == 'QBCore' then
            return player.PlayerData.money[moneyType] or 0
        elseif self.Name == 'VORP' then
            if moneyType == 'cash' then
                return player.money or 0
            elseif moneyType == 'gold' then
                return player.gold or 0
            end
        elseif self.Name == 'ESX' then
            local account = player.getAccount(moneyType == 'cash' and 'money' or moneyType)
            return account and account.money or 0
        end
        
        return 0
    end
    
    -- ═══════════════════════════════════════════════════════════════════════
    -- Add Money to Player
    -- ═══════════════════════════════════════════════════════════════════════
    function Framework:AddMoney(source, moneyType, amount)
        local player = self:GetPlayer(source)
        
        if not player or not amount or amount <= 0 then
            return false
        end
        
        moneyType = moneyType or 'cash'
        
        if self.Name == 'LXR-Core' or self.Name == 'RSG-Core' or self.Name == 'QBox' or self.Name == 'QBCore' then
            return player.Functions.AddMoney(moneyType, amount)
        elseif self.Name == 'VORP' then
            if moneyType == 'cash' then
                player.addCurrency(0, amount)
            elseif moneyType == 'gold' then
                player.addCurrency(1, amount)
            end
            return true
        elseif self.Name == 'ESX' then
            player.addAccountMoney(moneyType == 'cash' and 'money' or moneyType, amount)
            return true
        end
        
        return false
    end
    
    -- ═══════════════════════════════════════════════════════════════════════
    -- Remove Money from Player
    -- ═══════════════════════════════════════════════════════════════════════
    function Framework:RemoveMoney(source, moneyType, amount)
        local player = self:GetPlayer(source)
        
        if not player or not amount or amount <= 0 then
            return false
        end
        
        moneyType = moneyType or 'cash'
        
        if self.Name == 'LXR-Core' or self.Name == 'RSG-Core' or self.Name == 'QBox' or self.Name == 'QBCore' then
            return player.Functions.RemoveMoney(moneyType, amount)
        elseif self.Name == 'VORP' then
            if moneyType == 'cash' then
                player.removeCurrency(0, amount)
            elseif moneyType == 'gold' then
                player.removeCurrency(1, amount)
            end
            return true
        elseif self.Name == 'ESX' then
            player.removeAccountMoney(moneyType == 'cash' and 'money' or moneyType, amount)
            return true
        end
        
        return false
    end
    
    -- ═══════════════════════════════════════════════════════════════════════
    -- Get Job Player Count
    -- ═══════════════════════════════════════════════════════════════════════
    function Framework:GetJobCount(jobName)
        if not self.Ready or not jobName then
            return 0
        end
        
        local count = 0
        
        if self.Name == 'LXR-Core' or self.Name == 'RSG-Core' or self.Name == 'QBox' or self.Name == 'QBCore' then
            local players = self.Object.Functions.GetPlayers()
            for _, playerId in pairs(players) do
                local player = self:GetPlayer(playerId)
                if player then
                    local job = self:GetJob(playerId)
                    if job and job.name == jobName then
                        count = count + 1
                    end
                end
            end
        elseif self.Name == 'VORP' then
            local Core = self.Object
            for _, player in pairs(GetPlayers()) do
                local user = Core.getUser(tonumber(player))
                if user then
                    local character = user.getUsedCharacter()
                    if character and character.job == jobName then
                        count = count + 1
                    end
                end
            end
        elseif self.Name == 'ESX' then
            local xPlayers = self.Object.GetPlayers()
            for _, playerId in pairs(xPlayers) do
                local xPlayer = self:GetPlayer(playerId)
                if xPlayer and xPlayer.job.name == jobName then
                    count = count + 1
                end
            end
        end
        
        return count
    end
end

-- ████████████████████████████████████████████████████████████████████████████
-- █                                                                          █
-- █  UTILITY & DEBUG FUNCTIONS                                              █
-- █                                                                          █
-- ████████████████████████████████████████████████████████████████████████████

function Framework:IsReady()
    return self.Ready
end

function Framework:GetName()
    return self.Name or 'Unknown'
end

function Framework:WaitUntilReady(timeout)
    timeout = timeout or 5000
    local waited = 0
    
    while not self.Ready and waited < timeout do
        Wait(100)
        waited = waited + 100
    end
    
    return self.Ready
end

-- ████████████████████████████████████████████████████████████████████████████
-- █                                                                          █
-- █  EXPORT FRAMEWORK OBJECT                                                █
-- █                                                                          █
-- ████████████████████████████████████████████████████████████████████████████

exports('GetFramework', function()
    return Framework
end)

-- ████████████████████████████████████████████████████████████████████████████

print('^5╔══════════════════════════════════════════════════════════════════╗^0')
print('^5║^0  ^6LXR BLACKOUT^0 - Framework Bridge Loaded                       ^5║^0')
print('^5║^0  Framework: ^2' .. (Framework.Name or 'Detecting...') .. string.rep(' ', 46 - string.len(Framework.Name or 'Detecting...')) .. '^5║^0')
print('^5║^0  Status: ^2' .. (Framework.Ready and 'Ready ✅' or 'Initializing...') .. string.rep(' ', 50 - string.len(Framework.Ready and 'Ready ✅' or 'Initializing...')) .. '^5║^0')
print('^5╚══════════════════════════════════════════════════════════════════╝^0')
