local SpawnedNPCs = {}

local function SpawnIntelNPC(npcId, npcData)
    local modelHash = GetHashKey(npcData.model)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(100)
    end
    
    local npc = CreatePed(4, modelHash, 
        npcData.coords.x, npcData.coords.y, npcData.coords.z, 
        npcData.heading, false, true)
    
    -- SetEntityAsCriminal is deprecated - removed
    SetPedRandomComponentVariation(npc, 0)
    SetBlockingOfNonTemporaryEvents(npc, true)
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)
    SetPedCanRagdoll(npc, false)
    SetPedFleeAttributes(npc, 0, false)
    
    if npcData.scenario then
        TaskStartScenarioInPlace(npc, npcData.scenario, 0, true)
    end
    
    SpawnedNPCs[npcId] = npc
    
    exports.ox_target:addLocalEntity(npc, {
        {
            name = 'intel_npc_' .. npcId,
            icon = 'fa-solid fa-comment-dollar',
            label = npcData.label,
            distance = npcData.distance,
            onSelect = function()
                OpenIntelMenu(npcId, npcData)
            end
        }
    })
end

function OpenIntelMenu(npcId, npcData)
    local options = {}
    
    for _, zoneId in ipairs(npcData.intelZones) do
        local zoneData = Config.PowerZones[zoneId]
        local price = npcData.pricePerZone[zoneId]
        
        table.insert(options, {
            label = string.format('%s - $%s', zoneData.label, price),
            value = zoneId,
            description = string.format('Kaufe Intel über %s für $%s', zoneData.label, price)
        })
    end
    
    local input = lib.inputDialog(Locale('intel_npc_title'), {
        {
            type = 'select',
            label = Locale('select_zone'),
            options = options,
            required = true
        }
    })
    
    if not input then return end
    
    local selectedZone = input[1]
    local price = npcData.pricePerZone[selectedZone]
    
    local confirm = lib.alertDialog({
        header = Locale('confirm_purchase'),
        content = string.format(Locale('intel_price_confirm'), 
            Config.PowerZones[selectedZone].label, price),
        centered = true,
        cancel = true
    })
    
    if confirm == 'confirm' then
        TriggerServerEvent('hm_blackout:buyIntel', npcId, selectedZone)
    end
end

RegisterNetEvent('hm_blackout:receiveIntel', function(zoneId, intelData)
    local zoneData = Config.PowerZones[zoneId]
    
    local content = string.format([[
**Zone:** %s
**Generatoren:** %d
**Schwierigkeit:** %s
**Geschätzte Zeit:** %s

**Hinweise:**
• %s
    ]], 
        zoneData.label,
        intelData.generators,
        intelData.difficulty,
        intelData.estimatedTime,
        table.concat(intelData.hints, '\n• ')
    )
    
    lib.alertDialog({
        header = Locale('intel_received'),
        content = content,
        centered = true
    })
    
    if Config.ShowGeneratorsAfterIntel then
        ShowGeneratorBlips(zoneId, 30000)
    end
end)

function ShowGeneratorBlips(zoneId, duration)
    local blips = {}
    
    for genId, genData in pairs(Config.Generators) do
        if genData.zone == zoneId then
            local blip = AddBlipForCoord(genData.coords.x, genData.coords.y, genData.coords.z)
            SetBlipSprite(blip, genData.blip.sprite)
            SetBlipColour(blip, genData.blip.color)
            SetBlipScale(blip, genData.blip.scale)
            SetBlipAsShortRange(blip, false)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(genData.label)
            EndTextCommandSetBlipName(blip)
            
            table.insert(blips, blip)
        end
    end
    
    SetTimeout(duration, function()
        for _, blip in ipairs(blips) do
            RemoveBlip(blip)
        end
    end)
end

CreateThread(function()
    Wait(2000)
    
    for npcId, npcData in pairs(Config.IntelNPCs) do
        SpawnIntelNPC(npcId, npcData)
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for _, npc in pairs(SpawnedNPCs) do
            DeleteEntity(npc)
        end
    end
end)
