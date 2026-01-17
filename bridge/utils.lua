Utils = {}

-- CLIENT-SIDE Utils
if IsDuplicityVersion() == 0 then
    
    print('^2[HM_BLACKOUT] Loading client-side Utils...^7')
    
    -- Notification Wrapper
    Utils.Notify = function(message, type, duration)
        type = type or 'info'
        duration = duration or 5000
        
        if GetResourceState('ox_lib') == 'started' then
            lib.notify({
                description = message,
                type = type,
                duration = duration
            })
            
        elseif Framework.Name == 'qbox' or Framework.Name == 'qbcore' then
            Framework.Object.Functions.Notify(message, type, duration)
            
        elseif Framework.Name == 'esx' then
            Framework.Object.ShowNotification(message)
            
        else
            -- Fallback
            print(string.format('^3[NOTIFY]^7 %s', message))
        end
    end
    
    -- Progress Bar Wrapper
    Utils.ProgressBar = function(data, callback)
        if GetResourceState('ox_lib') == 'started' then
            if lib.progressBar({
                duration = data.duration,
                label = data.label,
                useWhileDead = data.useWhileDead or false,
                canCancel = data.canCancel or true,
                disable = data.disable or {
                    move = true,
                    car = true,
                    combat = true
                },
                anim = data.anim or {},
                prop = data.prop or {}
            }) then
                if callback then callback(true) end
            else
                if callback then callback(false) end
            end
            
        elseif Framework.Name == 'qbox' or Framework.Name == 'qbcore' then
            Framework.Object.Functions.Progressbar(data.name or 'progress', data.label, data.duration, data.useWhileDead or false, data.canCancel or true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true
            }, data.anim or {}, data.prop or {}, {}, function()
                if callback then callback(true) end
            end, function()
                if callback then callback(false) end
            end)
            
        else
            -- Fallback: Simple Wait
            Wait(data.duration)
            if callback then callback(true) end
        end
    end
    
    print('^2[HM_BLACKOUT] Utils.ProgressBar loaded successfully^7')
    
    -- Input Dialog Wrapper
    Utils.InputDialog = function(header, rows, callback)
        if GetResourceState('ox_lib') == 'started' then
            local input = lib.inputDialog(header, rows)
            if callback then callback(input) end
            return input
            
        elseif Framework.Name == 'qbox' or Framework.Name == 'qbcore' then
            local dialog = exports['qb-input']:ShowInput({
                header = header,
                submitText = 'Bestätigen',
                inputs = rows
            })
            if callback then callback(dialog) end
            return dialog
            
        else
            -- Fallback
            print('^3[INPUT]^7 Input dialogs not supported without ox_lib or qb-input')
            return nil
        end
    end
    
    -- Alert Dialog Wrapper
    Utils.AlertDialog = function(data, callback)
        if GetResourceState('ox_lib') == 'started' then
            local response = lib.alertDialog(data)
            if callback then callback(response) end
            return response
            
        elseif Framework.Name == 'qbox' or Framework.Name == 'qbcore' then
            -- Fallback zu Notification
            Utils.Notify(data.content, 'info')
            return 'confirm'
            
        else
            return 'confirm'
        end
    end
    
end

-- SERVER-SIDE Utils
if IsDuplicityVersion() == 1 then
    
    -- Notification Wrapper (Server → Client)
    Utils.Notify = function(source, message, type, duration)
        type = type or 'info'
        duration = duration or 5000
        
        if GetResourceState('ox_lib') == 'started' then
            TriggerClientEvent('ox_lib:notify', source, {
                description = message,
                type = type,
                duration = duration
            })
            
        elseif Framework.Name == 'qbox' or Framework.Name == 'qbcore' then
            TriggerClientEvent('QBCore:Notify', source, message, type, duration)
            
        elseif Framework.Name == 'esx' then
            TriggerClientEvent('esx:showNotification', source, message)
            
        else
            print(string.format('^3[NOTIFY]^7 %s', message))
        end
    end
    
    -- Timestamp Normalization (aus Master Guide)
    Utils.NormalizeTimestamp = function(timestamp)
        if type(timestamp) ~= 'number' then return nil end
        
        -- Convert milliseconds to seconds if needed
        if timestamp > 10000000000 then
            return math.floor(timestamp / 1000)
        end
        
        return timestamp
    end
    
end
