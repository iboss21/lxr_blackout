local REQUIRED_OX_LIB = '3.0.0'

CreateThread(function()
    local oxVersion = GetResourceMetadata('ox_lib', 'version', 0)
    
    if not oxVersion then
        error('[HM_BLACKOUT] ox_lib nicht gefunden! Bitte installiere ox_lib.')
        return
    end
    
    print(string.format([[
^2╔═══════════════════════════════════════╗
║   HM BLACKOUT - v1.0.0                ║
║   by MopsScripts                      ║
║                                       ║
║   Framework: %-24s║
║   Inventory: %-24s║
║                                       ║
║   Status: ^2RUNNING^7                     ║
╚═══════════════════════════════════════╝^7
    ]], Framework.Name, Inventory.Name))
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        print('^3[HM_BLACKOUT]^7 Resource gestoppt. Cleanup durchgeführt.')
    end
end)
