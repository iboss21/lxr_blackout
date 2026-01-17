local function SendDiscordLog(webhookType, title, message, color, fields)
    if not SVConfig.Discord.enabled then return end
    local webhook = SVConfig.Discord.webhooks[webhookType]
    if not webhook then return end
    local embed = {{['title'] = title, ['description'] = message, ['color'] = color or SVConfig.Discord.colors.info, ['fields'] = fields or {}, ['footer'] = {['text'] = 'HM Blackout System • ' .. os.date('%d.%m.%Y %H:%M:%S'), ['icon_url'] = SVConfig.Discord.botAvatar}, ['timestamp'] = os.date('!%Y-%m-%dT%H:%M:%S')}}
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = SVConfig.Discord.botName, avatar_url = SVConfig.Discord.botAvatar, embeds = embed}), {['Content-Type'] = 'application/json'})
end
exports('SendDiscordLog', SendDiscordLog)

RegisterNetEvent('hm_blackout:sendDispatch', function(coords, label)
    if GetResourceState('ps-dispatch') == 'started' then
        exports['ps-dispatch']:CustomAlert({coords = coords, message = 'Generator Sabotage: ' .. label, dispatchCode = '10-90', description = 'Ein Generator wurde sabotiert!', radius = 0, sprite = 354, color = 1, scale = 1.0, length = 3, sound = 'Lose_1st', sound2 = 'GTAO_FM_Events_Soundset', offset = false, jobs = {'police'}})
    end
    SendDiscordLog('generator', '🚨 DISPATCH ALERT', string.format('Generator-Sabotage gemeldet: %s', label), SVConfig.Discord.colors.warning, {{name = 'Location', value = label, inline = true}})
end)
