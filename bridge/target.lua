Target = {}
Target.Name = nil

-- Auto-Detection
local function DetectTarget()
    if GetResourceState('ox_target') == 'started' then
        Target.Name = 'ox_target'
        return true
    end
    
    if GetResourceState('qb-target') == 'started' then
        Target.Name = 'qb-target'
        return true
    end
    
    if GetResourceState('qtarget') == 'started' then
        Target.Name = 'qtarget'
        return true
    end
    
    return false
end

-- Initialize (CLIENT ONLY)
if IsDuplicityVersion() == 0 then
    CreateThread(function()
        if not DetectTarget() then
            print('^3[HM_BLACKOUT]^7 No target system found - using fallback (ox_lib zones)')
            Target.Name = 'fallback'
            return
        end
        
        print(string.format('^2[HM_BLACKOUT]^7 Target system detected: ^3%s^7', Target.Name))
    end)
end

-- Universal Functions (CLIENT)
if IsDuplicityVersion() == 0 then
    
    function Target:AddBoxZone(name, coords, length, width, options)
        if Target.Name == 'ox_target' then
            exports.ox_target:addBoxZone({
                coords = coords,
                size = vec3(length, width, 2.0),
                rotation = options.heading or 0.0,
                debug = options.debug or false,
                options = options.targetOptions
            })
            
        elseif Target.Name == 'qb-target' or Target.Name == 'qtarget' then
            local resource = Target.Name == 'qb-target' and 'qb-target' or 'qtarget'
            exports[resource]:AddBoxZone(name, coords, length, width, {
                name = name,
                heading = options.heading or 0.0,
                debugPoly = options.debug or false,
                minZ = coords.z - 1.0,
                maxZ = coords.z + 1.0
            }, {
                options = options.targetOptions,
                distance = options.distance or 2.5
            })
            
        elseif Target.Name == 'fallback' then
            -- Fallback zu ox_lib zones (bereits in zones.lua implementiert)
            return false
        end
        
        return true
    end
    
    function Target:AddSphereZone(name, coords, radius, options)
        if Target.Name == 'ox_target' then
            exports.ox_target:addSphereZone({
                coords = coords,
                radius = radius,
                debug = options.debug or false,
                options = options.targetOptions
            })
            
        elseif Target.Name == 'qb-target' or Target.Name == 'qtarget' then
            local resource = Target.Name == 'qb-target' and 'qb-target' or 'qtarget'
            exports[resource]:AddCircleZone(name, coords, radius, {
                name = name,
                debugPoly = options.debug or false,
                useZ = true
            }, {
                options = options.targetOptions,
                distance = options.distance or 2.5
            })
            
        elseif Target.Name == 'fallback' then
            return false
        end
        
        return true
    end
    
    function Target:AddLocalEntity(entity, options)
        if Target.Name == 'ox_target' then
            exports.ox_target:addLocalEntity(entity, options.targetOptions)
            
        elseif Target.Name == 'qb-target' or Target.Name == 'qtarget' then
            local resource = Target.Name == 'qb-target' and 'qb-target' or 'qtarget'
            exports[resource]:AddTargetEntity(entity, {
                options = options.targetOptions,
                distance = options.distance or 2.5
            })
            
        elseif Target.Name == 'fallback' then
            return false
        end
        
        return true
    end
    
    function Target:RemoveZone(name)
        if Target.Name == 'ox_target' then
            exports.ox_target:removeZone(name)
            
        elseif Target.Name == 'qb-target' or Target.Name == 'qtarget' then
            local resource = Target.Name == 'qb-target' and 'qb-target' or 'qtarget'
            exports[resource]:RemoveZone(name)
        end
    end
    
end
