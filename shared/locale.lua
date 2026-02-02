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
║                 🐺 LXR BLACKOUT - LOCALIZATION SYSTEM 🐺                     ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝

    Multi-Language Localization System
    Dynamic locale loading with fallback support
    
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
-- █  LOCALIZATION ENGINE                                                    █
-- █                                                                          █
-- ████████████████████████████████████████████████████████████████████████████

Locales = {}
Locale = {}

CreateThread(function()
    local locale = Config.Locale or 'de'
    local localeFile = ('locales/%s.lua'):format(locale)
    
    local success, result = pcall(function()
        return LoadResourceFile(GetCurrentResourceName(), localeFile)
    end)
    
    if success and result then
        local func = load(result)
        if func then
            Locales = func() or {}
        end
    end
    
    if not success or not next(Locales) then
        print(string.format('^3[HM_BLACKOUT]^7 Locale file not found: %s - Using fallback', localeFile))
        Locales = {}
    else
        print(string.format('^2[HM_BLACKOUT]^7 Loaded locale: %s', locale))
    end
end)

function Locale(key, ...)
    local text = Locales[key]
    if not text then
        print(string.format('^3[HM_BLACKOUT]^7 Missing locale: %s', key))
        return key
    end
    local args = {...}
    if #args > 0 then
        text = text:format(...)
    end
    return text
end

_T = Locale
exports('Locale', Locale)
exports('_T', _T)
