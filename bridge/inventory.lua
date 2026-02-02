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
║                  🐺 LXR BLACKOUT - INVENTORY BRIDGE 🐺                       ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝

    Multi-Inventory System Bridge with Auto-Detection
    Unified inventory interface for all supported inventory systems
    
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
-- █  INVENTORY AUTO-DETECTION SYSTEM                                        █
-- █                                                                          █
-- ████████████████████████████████████████████████████████████████████████████

Inventory = {}
Inventory.Name = nil

-- Auto-Detection
local function DetectInventory()
    if GetResourceState('ox_inventory') == 'started' then
        Inventory.Name = 'ox_inventory'
        return true
    end
    
    if GetResourceState('tgiann-inventory') == 'started' then
        Inventory.Name = 'tgiann'
        return true
    end
    
    if GetResourceState('qb-inventory') == 'started' then
        Inventory.Name = 'qb-inventory'
        return true
    end
    
    if GetResourceState('ps-inventory') == 'started' then
        Inventory.Name = 'ps-inventory'
        return true
    end
    
    if GetResourceState('qs-inventory') == 'started' then
        Inventory.Name = 'qs-inventory'
        return true
    end
    
    if GetResourceState('core_inventory') == 'started' then
        Inventory.Name = 'core_inventory'
        return true
    end
    
    return false
end

-- Initialize
CreateThread(function()
    if not DetectInventory() then
        error('[HM_BLACKOUT] No supported inventory found!')
        return
    end
    
    print(string.format('^2[HM_BLACKOUT]^7 Inventory detected: ^3%s^7', Inventory.Name))
end)

-- SERVER-ONLY Functions
if IsDuplicityVersion() == 1 then
    
    function Inventory:GetItemCount(source, item)
        if Inventory.Name == 'ox_inventory' then
            local count = exports.ox_inventory:GetItemCount(source, item)
            return count or 0
            
        elseif Inventory.Name == 'tgiann' then
            -- tgiann-inventory ist server-only, pcall wrapping!
            local success, result = pcall(function()
                return exports['tgiann-inventory']:GetItemCount(source, item)
            end)
            return success and result or 0
            
        elseif Inventory.Name == 'qb-inventory' or Inventory.Name == 'ps-inventory' then
            local player = Framework:GetPlayer(source)
            if not player then return 0 end
            
            local itemData = player.Functions.GetItemByName(item)
            return itemData and itemData.amount or 0
            
        elseif Inventory.Name == 'qs-inventory' then
            local count = exports['qs-inventory']:GetItemTotalAmount(source, item)
            return count or 0
            
        elseif Inventory.Name == 'core_inventory' then
            local count = exports.core_inventory:getItem(source, item)
            return count or 0
        end
        
        return 0
    end
    
    function Inventory:AddItem(source, item, amount, metadata)
        amount = amount or 1
        metadata = metadata or {}
        
        if Inventory.Name == 'ox_inventory' then
            local success = exports.ox_inventory:AddItem(source, item, amount, metadata)
            return success ~= false
            
        elseif Inventory.Name == 'tgiann' then
            local success, result = pcall(function()
                return exports['tgiann-inventory']:AddItem(source, item, amount, nil, metadata)
            end)
            return success and result
            
        elseif Inventory.Name == 'qb-inventory' or Inventory.Name == 'ps-inventory' then
            local player = Framework:GetPlayer(source)
            if not player then return false end
            
            return player.Functions.AddItem(item, amount, false, metadata)
            
        elseif Inventory.Name == 'qs-inventory' then
            return exports['qs-inventory']:AddItem(source, item, amount, nil, metadata)
            
        elseif Inventory.Name == 'core_inventory' then
            return exports.core_inventory:addItem(source, item, amount, metadata)
        end
        
        return false
    end
    
    function Inventory:RemoveItem(source, item, amount, slot)
        amount = amount or 1
        
        if Inventory.Name == 'ox_inventory' then
            local success = exports.ox_inventory:RemoveItem(source, item, amount, nil, slot)
            return success ~= false
            
        elseif Inventory.Name == 'tgiann' then
            local success, result = pcall(function()
                return exports['tgiann-inventory']:RemoveItem(source, item, amount, slot)
            end)
            return success and result
            
        elseif Inventory.Name == 'qb-inventory' or Inventory.Name == 'ps-inventory' then
            local player = Framework:GetPlayer(source)
            if not player then return false end
            
            return player.Functions.RemoveItem(item, amount, slot)
            
        elseif Inventory.Name == 'qs-inventory' then
            return exports['qs-inventory']:RemoveItem(source, item, amount, slot)
            
        elseif Inventory.Name == 'core_inventory' then
            return exports.core_inventory:removeItem(source, item, amount)
        end
        
        return false
    end
    
    function Inventory:GetItem(source, item)
        if Inventory.Name == 'ox_inventory' then
            return exports.ox_inventory:GetItem(source, item, nil, true)
            
        elseif Inventory.Name == 'tgiann' then
            local success, result = pcall(function()
                return exports['tgiann-inventory']:GetItem(source, item)
            end)
            return success and result or nil
            
        elseif Inventory.Name == 'qb-inventory' or Inventory.Name == 'ps-inventory' then
            local player = Framework:GetPlayer(source)
            if not player then return nil end
            
            return player.Functions.GetItemByName(item)
            
        elseif Inventory.Name == 'qs-inventory' then
            return exports['qs-inventory']:GetFirstSlotItemByName(source, item)
            
        elseif Inventory.Name == 'core_inventory' then
            return exports.core_inventory:getItem(source, item)
        end
        
        return nil
    end
    
end
