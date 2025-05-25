local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('SE-magician:healRequest', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local isDead = false
    if Player.PlayerData.metadata["isdead"] or Player.PlayerData.metadata["inlaststand"] then
        isDead = true
    end

    if isDead then
        if Player.PlayerData.money.cash >= 1500 then
            Player.Functions.RemoveMoney('cash', 1500, "magic-heal-payment")
            TriggerClientEvent('SE-magician:beginHealing', src)
        else
            TriggerClientEvent('QBCore:Notify', src, "ما معك 1500$ كاش للعلاج!", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "أنت بصحة جيدة، لا تحتاج علاج!", "error")
    end
end)
