local QBCore = exports['qb-core']:GetCoreObject()
local ped = nil
local pedCoords = vector3(2437.34, 4966.62, 41.35)
local pedHeading = 96.5


CreateThread(function()
    RequestModel(`ig_orleans`)
    while not HasModelLoaded(`ig_orleans`) do Wait(0) end

    ped = CreatePed(0, `ig_orleans`, pedCoords.x, pedCoords.y, pedCoords.z, pedHeading, false, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    exports['qb-target']:AddTargetEntity(ped, {
        options = {
            {
                icon = "fas fa-hand-sparkles",
                label = "طلب علاج من الساحر (1500$)",
                action = function(entity)
                    if entity == ped then
                        
                        TriggerServerEvent('SE-magician:healRequest')
                    else
                        QBCore.Functions.Notify("لا يمكنك التفاعل الآن.", "error")
                    end
                end
            }
        },
        distance = 2.0
    })
end)


local function playCPRAnimation()
    local playerPed = PlayerPedId()
    RequestAnimDict("mini@cpr@char_a@cpr_def")
    while not HasAnimDictLoaded("mini@cpr@char_a@cpr_def") do Wait(10) end
    TaskPlayAnim(playerPed, "mini@cpr@char_a@cpr_def", "cpr_def", 8.0, -8, 7000, 49, 0, false, false, false)
end


RegisterNetEvent('SE-magician:beginHealing', function()

    DoScreenFadeOut(1000)
    Wait(1000)


    playCPRAnimation()

    Wait(7000)

    local playerPed = PlayerPedId()


    TriggerEvent('hospital:client:Revive')


    Citizen.InvokeNative(0x4E91A6ECC7F63140, playerPed, true)

    SetEntityHealth(playerPed, 200)
    ClearPedBloodDamage(playerPed)

    DoScreenFadeIn(1500)

    QBCore.Functions.Notify("تم علاجك بالكامل بواسطة الساحر!", "success")
end)



local extraPeds = {
    { model = "ig_orleans", coords = vector4(2434.76, 4969.48, 41.35, 189.22) },
    { model = "ig_orleans", coords = vector4(2433.68, 4963.35, 41.35, 3.03) },
    { model = "ig_orleans", coords = vector4(2430.61, 4965.97, 41.35, 313.94) },
    { model = "ig_orleans", coords = vector4(2430.51, 4968.31, 41.35, 200.32) }

}

CreateThread(function()
    for _, pedInfo in pairs(extraPeds) do
        local model = GetHashKey(pedInfo.model)
        RequestModel(model)
        while not HasModelLoaded(model) do Wait(0) end

        local ped = CreatePed(0, model, pedInfo.coords.x, pedInfo.coords.y, pedInfo.coords.z, pedInfo.coords.w, false, true)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
    end
end)
