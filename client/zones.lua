local GeneratorZones = {}
local GeneratorBlips = {}
local ActiveGenerators = {}

-- Create ox_lib zone for each generator
local function CreateGeneratorZone(genId, genData)
    if GeneratorZones[genId] then return end
    
    local zoneId = lib.zones.sphere({
        name = 'generator_' .. genId,
        coords = genData.coords,
        radius = 2.5,
        debug = Config.Debug,
        
        onEnter = function()
            local playerJob = Framework:GetJob()
            local hasJob = false
            
            if genData.requiredJob then
                for _, job in ipairs(genData.requiredJob) do
                    if playerJob == job then
                        hasJob = true
                        break
                    end
                end
            else
                hasJob = true
            end
            
            local genState = ActiveGenerators[genId]
            
            if genState and not genState.repaired and hasJob then
                lib.showTextUI(Locale('repair_generator'), {
                    position = 'right-center',
                    icon = 'fa-solid fa-wrench'
                })
            elseif genState and genState.repaired and genData.canBeSabotaged then
                lib.showTextUI(Locale('sabotage_generator'), {
                    position = 'right-center',
                    icon = 'fa-solid fa-bomb'
                })
            end
        end,
        
        onExit = function()
            lib.hideTextUI()
        end,
        
        inside = function()
            if IsControlJustPressed(0, 38) then
                local genState = ActiveGenerators[genId]
                
                if genState and not genState.repaired then
                    TriggerServerEvent('hm_blackout:repairGenerator', genId)
                elseif genState and genState.repaired and genData.canBeSabotaged then
                    TriggerServerEvent('hm_blackout:sabotageGenerator', genId)
                end
            end
        end
    })
    
    GeneratorZones[genId] = zoneId
    
    if Config.Debug then
        print(string.format('^2[Blackout]^7 Zone created for generator: %s', genId))
    end
end

local function CreateGeneratorBlip(genId, genData)
    if GeneratorBlips[genId] then return end
    if not genData.blip or not genData.blip.showWhenOffline then return end
    
    local blip = AddBlipForCoord(genData.coords.x, genData.coords.y, genData.coords.z)
    SetBlipSprite(blip, genData.blip.sprite or 354)
    SetBlipColour(blip, genData.blip.color or 1)
    SetBlipScale(blip, genData.blip.scale or 0.8)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(genData.label)
    EndTextCommandSetBlipName(blip)
    
    GeneratorBlips[genId] = blip
end

local function RemoveGeneratorBlip(genId)
    if GeneratorBlips[genId] then
        RemoveBlip(GeneratorBlips[genId])
        GeneratorBlips[genId] = nil
    end
end

RegisterNetEvent('hm_blackout:generatorSabotaged', function(genId)
    if not Config.Generators[genId] then return end
    
    ActiveGenerators[genId] = {
        repaired = false,
        timestamp = GetGameTimer()
    }
    
    CreateGeneratorBlip(genId, Config.Generators[genId])
    
    lib.notify({
        title = Locale('generator_title'),
        description = Locale('generator_sabotaged', Config.Generators[genId].label),
        type = 'error',
        duration = 5000
    })
end)

RegisterNetEvent('hm_blackout:generatorRepaired', function(genId)
    if not Config.Generators[genId] then return end
    
    ActiveGenerators[genId] = {
        repaired = true,
        timestamp = GetGameTimer()
    }
    
    RemoveGeneratorBlip(genId)
    
    lib.notify({
        title = Locale('generator_title'),
        description = Locale('generator_repaired', Config.Generators[genId].label),
        type = 'success',
        duration = 5000
    })
end)

RegisterNetEvent('hm_blackout:startRepair', function(genId, repairTime)
    local genData = Config.Generators[genId]
    if not genData then return end
    
    -- Check if mgc is available and enabled in config
    local useMGC = Config.Minigames.enabled and GetResourceState('mgc') == 'started'
    
    if useMGC then
        -- Use mgc (Mini Game Center) with game-specific settings
        local minigameType = Config.Minigames.repair.type
        local gameData = Config.Minigames.repair
        
        -- Build data table (exclude 'type' field)
        local data = {}
        for k, v in pairs(gameData) do
            if k ~= 'type' then
                data[k] = v
            end
        end
        
        -- Wrap in pcall for safety
        local success, err = pcall(function()
            exports.mgc:start_game({
                game = minigameType,
                data = data
            }, function(result)
                if result and result.success then
                    StartRepairProgress(genId, genData, repairTime)
                else
                    lib.notify({
                        description = Locale('repair_failed'),
                        type = 'error'
                    })
                end
            end)
        end)
        
        if not success then
            -- MGC failed to start, use fallback
            print('[HM_BLACKOUT] MGC Error: ' .. tostring(err))
            lib.notify({
                description = 'Minigame Error - using fallback',
                type = 'warning'
            })
            
            local skillSuccess = lib.skillCheck({'easy', 'easy', {areaSize = 60, speedMultiplier = 1.5}, 'medium'}, {'w', 'a', 's', 'd'})
            if skillSuccess then
                StartRepairProgress(genId, genData, repairTime)
            else
                lib.notify({
                    description = Locale('repair_failed'),
                    type = 'error'
                })
            end
        end
    else
        -- Fallback to ox_lib
        local success = lib.skillCheck({'easy', 'easy', {areaSize = 60, speedMultiplier = 1.5}, 'medium'}, {'w', 'a', 's', 'd'})
        
        if not success then
            lib.notify({
                description = Locale('repair_failed'),
                type = 'error'
            })
            return
        end
        
        StartRepairProgress(genId, genData, repairTime)
    end
end)

-- Helper function for repair progress
function StartRepairProgress(genId, genData, repairTime)
    -- Use lib.progressBar directly instead of Utils wrapper
    if lib.progressBar({
        duration = repairTime * 1000,
        label = Locale('repairing_generator'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
            mouse = false
        },
        anim = {
            dict = 'mini@repair',
            clip = 'fixing_a_player'
        }
    }) then
        -- Success - not cancelled
        lib.callback('hm_blackout:completeRepair', false, function(success)
            if success then
                lib.notify({
                    description = Locale('repair_success'),
                    type = 'success'
                })
            else
                lib.notify({
                    description = Locale('repair_error'),
                    type = 'error'
                })
            end
        end, genId)
    else
        -- Cancelled
        lib.notify({
            description = Locale('repair_cancelled'),
            type = 'error'
        })
    end
end

RegisterNetEvent('hm_blackout:startSabotageMinigame', function(genId, sabotageTime)
    local genData = Config.Generators[genId]
    if not genData then return end
    
    -- Check if mgc is available and enabled in config
    local useMGC = Config.Minigames.enabled and GetResourceState('mgc') == 'started'
    
    if useMGC then
        -- Use mgc (Mini Game Center) with game-specific settings
        local minigameType = Config.Minigames.sabotage.type
        local gameData = Config.Minigames.sabotage
        
        -- Build data table (exclude 'type' field)
        local data = {}
        for k, v in pairs(gameData) do
            if k ~= 'type' then
                data[k] = v
            end
        end
        
        -- Wrap in pcall for safety
        local success, err = pcall(function()
            exports.mgc:start_game({
                game = minigameType,
                data = data
            }, function(result)
                if result and result.success then
                    StartSabotageProgress(genId, genData, sabotageTime)
                else
                    lib.notify({
                        description = Locale('sabotage_failed'),
                        type = 'error'
                    })
                end
            end)
        end)
        
        if not success then
            -- MGC failed to start, use fallback
            print('[HM_BLACKOUT] MGC Error: ' .. tostring(err))
            lib.notify({
                description = 'Minigame Error - using fallback',
                type = 'warning'
            })
            
            local skillSuccess = lib.skillCheck({'medium', 'hard', {areaSize = 40, speedMultiplier = 2.0}, 'hard'}, {'w', 'a', 's', 'd'})
            if skillSuccess then
                StartSabotageProgress(genId, genData, sabotageTime)
            else
                lib.notify({
                    description = Locale('sabotage_failed'),
                    type = 'error'
                })
            end
        end
    else
        -- Fallback to ox_lib (harder skill check)
        local success = lib.skillCheck({'medium', 'hard', {areaSize = 40, speedMultiplier = 2.0}, 'hard'}, {'w', 'a', 's', 'd'})
        
        if not success then
            lib.notify({
                description = Locale('sabotage_failed'),
                type = 'error'
            })
            return
        end
        
        StartSabotageProgress(genId, genData, sabotageTime)
    end
end)

-- Helper function for sabotage progress
function StartSabotageProgress(genId, genData, sabotageTime)
    -- Use lib.progressBar directly instead of Utils wrapper
    if lib.progressBar({
        duration = sabotageTime * 1000,
        label = Locale('sabotaging_generator'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true
        },
        anim = {
            dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
            clip = 'machinic_loop_mechandplayer'
        }
    }) then
        -- Success - not cancelled
        lib.callback('hm_blackout:completeSabotage', false, function(success)
            if success then
                lib.notify({
                    description = Locale('sabotage_success'),
                    type = 'success'
                })
            else
                lib.notify({
                    description = Locale('sabotage_error'),
                    type = 'error'
                })
            end
        end, genId)
    else
        -- Cancelled
        lib.notify({
            description = Locale('sabotage_cancelled'),
            type = 'error'
        })
    end
end

CreateThread(function()
    Wait(2000)
    
    for genId, genData in pairs(Config.Generators) do
        CreateGeneratorZone(genId, genData)
        
        ActiveGenerators[genId] = {
            repaired = true,
            timestamp = GetGameTimer()
        }
    end
    
    if Config.Debug then
        print(string.format('^2[Blackout]^7 Created %d generator zones', #Config.Generators))
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for _, blip in pairs(GeneratorBlips) do
            RemoveBlip(blip)
        end
    end
end)
