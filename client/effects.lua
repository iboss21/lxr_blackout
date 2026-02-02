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
║                   🐺 LXR BLACKOUT - VISUAL EFFECTS 🐺                        ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝

    Visual Effects & Timecycle System
    Handles blackout visuals, lighting effects, and atmosphere
    
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
-- █  VISUAL EFFECTS ENGINE                                                  █
-- █                                                                          █
-- ████████████████████████████████████████████████████████████████████████████

local ActiveBlackoutZones = {}
local ActiveTimecycle = nil
local PlayerInBlackoutZone = false
local BlackoutBlips = {}

-- Point-in-polygon check (ray casting algorithm)
local function IsPointInPolygon(point, polygon)
    local x, y = point.x, point.y
    local inside = false
    local j = #polygon
    
    for i = 1, #polygon do
        local xi, yi = polygon[i].x, polygon[i].y
        local xj, yj = polygon[j].x, polygon[j].y
        
        if ((yi > y) ~= (yj > y)) and (x < (xj - xi) * (y - yi) / (yj - yi) + xi) then
            inside = not inside
        end
        j = i
    end
    
    return inside
end

local function CreateBlackoutBlip(zoneId, zoneData)
    -- Calculate center of zone for blip
    local centerX, centerY = 0, 0
    for _, point in ipairs(zoneData.points) do
        centerX = centerX + point.x
        centerY = centerY + point.y
    end
    centerX = centerX / #zoneData.points
    centerY = centerY / #zoneData.points
    
    -- Create blip
    local blip = AddBlipForCoord(centerX, centerY, 0.0)
    SetBlipSprite(blip, 354) -- Warning icon
    SetBlipColour(blip, 1) -- Red
    SetBlipAlpha(blip, 200)
    SetBlipScale(blip, 1.2)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('⚠️ BLACKOUT: ' .. zoneData.label)
    EndTextCommandSetBlipName(blip)
    SetBlipFlashes(blip, true)
    SetBlipFlashTimer(blip, 5000)
    
    -- Create radius blip to show zone
    local radiusBlip = AddBlipForRadius(centerX, centerY, 0.0, 500.0)
    SetBlipColour(radiusBlip, 1) -- Red
    SetBlipAlpha(radiusBlip, 100)
    
    BlackoutBlips[zoneId] = {blip = blip, radius = radiusBlip}
end

local function RemoveBlackoutBlip(zoneId)
    if BlackoutBlips[zoneId] then
        if DoesBlipExist(BlackoutBlips[zoneId].blip) then
            RemoveBlip(BlackoutBlips[zoneId].blip)
        end
        if DoesBlipExist(BlackoutBlips[zoneId].radius) then
            RemoveBlip(BlackoutBlips[zoneId].radius)
        end
        BlackoutBlips[zoneId] = nil
    end
end

local function ApplyBlackoutEffects()
    -- Only apply if player is actually in a blackout zone
    if not PlayerInBlackoutZone then return end
    
    SetArtificialLightsState(true)
    SetArtificialLightsStateAffectsVehicles(false)
    
    if not ActiveTimecycle then
        SetTimecycleModifier('cinema')
        SetTimecycleModifierStrength(0.3)
        ActiveTimecycle = 'cinema'
    end
    
    if Config.DimHud then
        SetMinimapComponentPosition('minimap', 'L', 'B', -0.0045, 0.002, 0.150, 0.188888)
    end
end

local function RemoveBlackoutEffects()
    SetArtificialLightsState(false)
    
    if ActiveTimecycle then
        ClearTimecycleModifier()
        ActiveTimecycle = nil
    end
    
    PlayerInBlackoutZone = false
end

-- Update active blackout zones
RegisterNetEvent('hm_blackout:zoneStateChanged', function(zoneId, active, lightIntensity)
    local zoneData = Config.PowerZones[zoneId]
    
    if active then
        ActiveBlackoutZones[zoneId] = true
        
        -- Create visual indicators for ALL players
        CreateBlackoutBlip(zoneId, zoneData)
        
        -- Show notification
        lib.notify({
            title = '⚠️ BLACKOUT ALARM',
            description = 'Stromausfall in ' .. zoneData.label .. '!\nAlle Generatoren offline!',
            type = 'error',
            duration = 8000,
            icon = 'bolt',
            iconColor = '#ff0000'
        })
        
        -- Play alarm sound
        PlaySoundFrontend(-1, 'CHECKPOINT_MISSED', 'HUD_MINI_GAME_SOUNDSET', true)
        
    else
        ActiveBlackoutZones[zoneId] = nil
        
        -- Remove visual indicators
        RemoveBlackoutBlip(zoneId)
        
        -- Show notification
        lib.notify({
            title = '✅ Strom wiederhergestellt',
            description = 'Stromversorgung in ' .. zoneData.label .. ' läuft wieder!',
            type = 'success',
            duration = 5000,
            icon = 'bolt',
            iconColor = '#00ff00'
        })
        
        -- Play success sound
        PlaySoundFrontend(-1, 'CHECKPOINT_PERFECT', 'HUD_MINI_GAME_SOUNDSET', true)
    end
end)

-- Spawn visual effects at generators
RegisterNetEvent('hm_blackout:generatorSabotaged', function(genId)
    local genData = Config.Generators[genId]
    if not genData then return end
    
    -- Spawn sparks/smoke particles
    CreateThread(function()
        for i = 1, 10 do
            UseParticleFxAssetNextCall('core')
            StartNetworkedParticleFxNonLoopedAtCoord(
                'exp_air_molotov',
                genData.coords.x, genData.coords.y, genData.coords.z,
                0.0, 0.0, 0.0,
                0.5, false, false, false
            )
            Wait(200)
        end
    end)
    
    -- Play electrical sound nearby
    local playerCoords = GetEntityCoords(PlayerPedId())
    if #(playerCoords - genData.coords) < 50.0 then
        PlaySoundFromCoord(-1, 'POWER_DOWN', genData.coords.x, genData.coords.y, genData.coords.z, 'COMPUTER_SOUNDS', false, 50.0, false)
    end
end)

RegisterNetEvent('hm_blackout:generatorRepaired', function(genId)
    local genData = Config.Generators[genId]
    if not genData then return end
    
    -- Spawn success particles
    CreateThread(function()
        for i = 1, 5 do
            UseParticleFxAssetNextCall('core')
            StartNetworkedParticleFxNonLoopedAtCoord(
                'ent_dst_elec_fire_sp',
                genData.coords.x, genData.coords.y, genData.coords.z + 1.0,
                0.0, 0.0, 0.0,
                0.3, false, false, false
            )
            Wait(300)
        end
    end)
    
    -- Play power up sound nearby
    local playerCoords = GetEntityCoords(PlayerPedId())
    if #(playerCoords - genData.coords) < 50.0 then
        PlaySoundFromCoord(-1, 'POWER_UP', genData.coords.x, genData.coords.y, genData.coords.z, 'COMPUTER_SOUNDS', false, 50.0, false)
    end
end)

-- Check if player is in any blackout zone
CreateThread(function()
    while true do
        Wait(1000) -- Check every second
        
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local wasInZone = PlayerInBlackoutZone
        PlayerInBlackoutZone = false
        
        -- Check each active blackout zone
        for zoneId, _ in pairs(ActiveBlackoutZones) do
            local zone = Config.PowerZones[zoneId]
            if zone and zone.points then
                -- Check if player is inside the polygon
                if IsPointInPolygon(playerCoords, zone.points) then
                    PlayerInBlackoutZone = true
                    break
                end
            end
        end
        
        -- Apply or remove effects based on zone status
        if PlayerInBlackoutZone and not wasInZone then
            -- Entered blackout zone
            ApplyBlackoutEffects()
            lib.notify({
                description = '⚠️ Du betrittst eine Blackout-Zone',
                type = 'warning'
            })
        elseif not PlayerInBlackoutZone and wasInZone then
            -- Left blackout zone
            RemoveBlackoutEffects()
            lib.notify({
                description = '✅ Du hast die Blackout-Zone verlassen',
                type = 'success'
            })
        elseif PlayerInBlackoutZone then
            -- Still in zone, keep applying (needed because SetArtificialLightsState needs constant refresh)
            SetArtificialLightsState(true)
        end
    end
end)
