Framework = {}
Framework.Name = nil
Framework.Object = nil

-- Auto-Detection
local function DetectFramework()
    -- QBox (Priority 1)
    if GetResourceState('qbx_core') == 'started' then
        Framework.Name = 'qbox'
        Framework.Object = exports.qbx_core
        return true
    end
    
    -- QBCore (Priority 2)
    if GetResourceState('qb-core') == 'started' then
        Framework.Name = 'qbcore'
        Framework.Object = exports['qb-core']:GetCoreObject()
        return true
    end
    
    -- ESX (Priority 3)
    if GetResourceState('es_extended') == 'started' then
        Framework.Name = 'esx'
        Framework.Object = exports['es_extended']:getSharedObject()
        return true
    end
    
    return false
end

-- Initialize
CreateThread(function()
    if not DetectFramework() then
        error('[HM_BLACKOUT] No supported framework found!')
        return
    end
    
    print(string.format('^2[HM_BLACKOUT]^7 Framework detected: ^3%s^7', Framework.Name))
end)

-- Universal Functions (CLIENT)
if IsDuplicityVersion() == 0 then  -- CLIENT
    
    function Framework:GetPlayerData()
        if Framework.Name == 'qbox' then
            return exports.qbx_core:GetPlayerData()
        elseif Framework.Name == 'qbcore' then
            return Framework.Object.Functions.GetPlayerData()
        elseif Framework.Name == 'esx' then
            return Framework.Object.GetPlayerData()
        end
    end
    
    function Framework:GetJob()
        local playerData = self:GetPlayerData()
        
        if Framework.Name == 'qbox' or Framework.Name == 'qbcore' then
            return playerData.job.name
        elseif Framework.Name == 'esx' then
            return playerData.job.name
        end
    end
    
    function Framework:GetJobGrade()
        local playerData = self:GetPlayerData()
        
        if Framework.Name == 'qbox' or Framework.Name == 'qbcore' then
            return playerData.job.grade.level
        elseif Framework.Name == 'esx' then
            return playerData.job.grade
        end
    end
    
    function Framework:HasJob(jobName)
        return self:GetJob() == jobName
    end

else  -- SERVER
    
    function Framework:GetPlayer(source)
        if Framework.Name == 'qbox' then
            -- QBox uses global Player() function
            return Player(source)
        elseif Framework.Name == 'qbcore' then
            return Framework.Object.Functions.GetPlayer(source)
        elseif Framework.Name == 'esx' then
            return Framework.Object.GetPlayerFromId(source)
        end
    end
    
    function Framework:GetIdentifier(source)
        local player = self:GetPlayer(source)
        if not player then return nil end
        
        if Framework.Name == 'qbox' or Framework.Name == 'qbcore' then
            -- QBox: PlayerData might not be loaded yet, wait a bit
            local attempts = 0
            while not player.PlayerData and attempts < 10 do
                Wait(100)
                attempts = attempts + 1
            end
            
            if not player.PlayerData then
                print('^3[HM_BLACKOUT] Warning: PlayerData not loaded for source ' .. source .. ' after 1 second^7')
                return nil
            end
            return player.PlayerData.citizenid
        elseif Framework.Name == 'esx' then
            return player.identifier
        end
    end
    
    function Framework:GetJob(source)
        local player = self:GetPlayer(source)
        if not player then return nil end
        
        if Framework.Name == 'qbox' or Framework.Name == 'qbcore' then
            -- Wait for PlayerData to load
            local attempts = 0
            while not player.PlayerData and attempts < 10 do
                Wait(100)
                attempts = attempts + 1
            end
            
            if not player.PlayerData then
                return nil
            end
            return player.PlayerData.job.name
        elseif Framework.Name == 'esx' then
            return player.job.name
        end
    end
    
    function Framework:GetMoney(source, moneyType)
        local player = self:GetPlayer(source)
        if not player then return 0 end
        
        moneyType = moneyType or 'cash'
        
        if Framework.Name == 'qbox' or Framework.Name == 'qbcore' then
            if not player.PlayerData then return 0 end
            return player.PlayerData.money[moneyType] or 0
        elseif Framework.Name == 'esx' then
            if moneyType == 'cash' then moneyType = 'money' end
            local account = player.getAccount(moneyType)
            return account and account.money or 0
        end
    end
    
    function Framework:AddMoney(source, moneyType, amount)
        local player = self:GetPlayer(source)
        if not player then return false end
        
        moneyType = moneyType or 'cash'
        
        if Framework.Name == 'qbox' then
            -- QBox uses different money functions
            if not player.Functions then return false end
            player.Functions.AddMoney(moneyType, amount, 'blackout-reward')
        elseif Framework.Name == 'qbcore' then
            if not player.Functions then return false end
            player.Functions.AddMoney(moneyType, amount)
        elseif Framework.Name == 'esx' then
            if moneyType == 'cash' then moneyType = 'money' end
            player.addAccountMoney(moneyType, amount)
        end
        
        return true
    end
    
    function Framework:RemoveMoney(source, moneyType, amount)
        local player = self:GetPlayer(source)
        if not player then return false end
        
        moneyType = moneyType or 'cash'
        
        if Framework.Name == 'qbox' then
            -- QBox uses different money functions
            if not player.Functions then return false end
            player.Functions.RemoveMoney(moneyType, amount, 'blackout-purchase')
        elseif Framework.Name == 'qbcore' then
            if not player.Functions then return false end
            player.Functions.RemoveMoney(moneyType, amount)
        elseif Framework.Name == 'esx' then
            if moneyType == 'cash' then moneyType = 'money' end
            player.removeAccountMoney(moneyType, amount)
        end
        
        return true
    end
        end
    
    -- Utility: Count players with specific job
    function Framework:GetJobCount(jobName)
        local count = 0
        local players = GetPlayers()
        
        for _, playerId in ipairs(players) do
            local player = self:GetPlayer(tonumber(playerId))
            if player and player.PlayerData and player.PlayerData.job then
                if player.PlayerData.job.name == jobName and player.PlayerData.job.onduty then
                    count = count + 1
                end
            elseif Framework.Name == 'esx' and player and player.job then
                if player.job.name == jobName then
                    count = count + 1
                end
            end
        end
        
        return count
    end

