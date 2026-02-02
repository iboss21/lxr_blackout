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
║                   🐺 LXR BLACKOUT - BLACKOUT ZONES 🐺                        ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝

    Blackout Zone Detection & Tracking
    Manages power zone polygons and player location tracking
    
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
-- █  BLACKOUT ZONE DETECTION                                                █
-- █                                                                          █
-- ████████████████████████████████████████████████████████████████████████████

local ActiveBlackoutZones = {}
local InsideZones = {}
local ZonePolys = {}

local function CreatePowerZones()
    for zoneId, zoneData in pairs(Config.PowerZones) do
        local poly = lib.zones.poly({
            name = 'power_zone_' .. zoneId,
            points = zoneData.points,
            thickness = zoneData.thickness,
            debug = Config.Debug,
            
            onEnter = function()
                InsideZones[zoneId] = true
                if ActiveBlackoutZones[zoneId] and ActiveBlackoutZones[zoneId].active then
                    ApplyZoneBlackoutEffects(zoneId, zoneData)
                end
            end,
            
            onExit = function()
                InsideZones[zoneId] = nil
                if ActiveBlackoutZones[zoneId] and ActiveBlackoutZones[zoneId].active then
                    RemoveZoneBlackoutEffects(zoneId)
                end
            end
        })
        
        ZonePolys[zoneId] = poly
    end
end

function ApplyZoneBlackoutEffects(zoneId, zoneData)
    CreateThread(function()
        while InsideZones[zoneId] and ActiveBlackoutZones[zoneId] and ActiveBlackoutZones[zoneId].active do
            if zoneData.streetLightsOff then
                SetArtificialLightsState(true)
            end
            
            if zoneData.timecycleModifier then
                SetTimecycleModifier(zoneData.timecycleModifier)
                SetTimecycleModifierStrength(1.0 - zoneData.lightIntensity)
            end
            
            if zoneData.vehicleLightsBoost then
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                if vehicle ~= 0 then
                    SetVehicleLightMultiplier(vehicle, 2.0)
                end
            end
            
            Wait(1000)
        end
        
        SetArtificialLightsState(false)
        ClearTimecycleModifier()
    end)
end

function RemoveZoneBlackoutEffects(zoneId)
    SetArtificialLightsState(false)
    ClearTimecycleModifier()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= 0 then
        SetVehicleLightMultiplier(vehicle, 1.0)
    end
end

RegisterNetEvent('hm_blackout:zoneStateChanged', function(zoneId, active, intensity)
    if not Config.PowerZones[zoneId] then return end
    
    ActiveBlackoutZones[zoneId] = {
        active = active,
        intensity = intensity or 0.0
    }
    
    if InsideZones[zoneId] and active then
        ApplyZoneBlackoutEffects(zoneId, Config.PowerZones[zoneId])
    elseif InsideZones[zoneId] and not active then
        RemoveZoneBlackoutEffects(zoneId)
    end
    
    local zoneData = Config.PowerZones[zoneId]
    if active then
        lib.notify({
            title = Locale('blackout_title'),
            description = Locale('zone_blackout_started', zoneData.label),
            type = 'error',
            duration = 5000
        })
    else
        lib.notify({
            title = Locale('power_restored_title'),
            description = Locale('zone_power_restored', zoneData.label),
            type = 'success',
            duration = 5000
        })
    end
end)

CreateThread(function()
    Wait(1000)
    CreatePowerZones()
end)
