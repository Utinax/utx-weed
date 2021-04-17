ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local topluyormu = false
local isliyormu = false
local kurutuyormu = false
local paketliyormu = false

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playercoords, Config.WeedExit.x, Config.WeedExit.y, Config.WeedExit.z, true)
        local dst2 = GetDistanceBetweenCoords(playercoords, Config.WeedEntry.x, Config.WeedEntry.y, Config.WeedEntry.z, true)
        local dst3 = GetDistanceBetweenCoords(playercoords, Config.PickWeed.x, Config.PickWeed.y, Config.PickWeed.z, true)
        local dst4 = GetDistanceBetweenCoords(playercoords, Config.WeedOut.x, Config.WeedOut.y, Config.WeedOut.z, true)
        local dst5 = GetDistanceBetweenCoords(playercoords, Config.DryWeed.x, Config.DryWeed.y, Config.DryWeed.z, true)
        local dst6 = GetDistanceBetweenCoords(playercoords, Config.PackageWeed.x, Config.PackageWeed.y, Config.PackageWeed.z, true)
        if dst < 10 then
            sleep = 7
            DrawMarker(2, Config.WeedExit.x, Config.WeedExit.y, Config.WeedExit.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst < 1 then
                DrawText3D(Config.WeedExit.x, Config.WeedExit.y, Config.WeedExit.z + 0.4, '~g~E~s~ - Enter The Mysterious Place')
                if IsControlJustReleased(0, 38) then
                    SetEntityCoords(player, Config.WeedEntry.x, Config.WeedEntry.y, Config.WeedEntry.z, false, false, false, true)
                end
            end
        end
        if dst2 < 10 then
            sleep = 7
            DrawMarker(2, Config.WeedEntry.x, Config.WeedEntry.y, Config.WeedEntry.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst2 < 1 then
                DrawText3D(Config.WeedEntry.x, Config.WeedEntry.y, Config.WeedEntry.z + 0.4, '~g~E~s~ - Go Out')
                if IsControlJustReleased(0, 38) then
                    SetEntityCoords(player, Config.WeedExit.x, Config.WeedExit.y, Config.WeedExit.z, false, false, false, true)
                end
            end
        end
        if dst3 < 10 then
            sleep = 7
            DrawMarker(2, Config.PickWeed.x, Config.PickWeed.y, Config.PickWeed.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst3 < 1 then
                DrawText3D(Config.PickWeed.x, Config.PickWeed.y, Config.PickWeed.z + 0.4, '~g~E~s~ - Pick Weed Leaf')
                if IsControlJustReleased(0, 38) then
                    EsrarTopla()
                end
            end
        end
        if dst4 < 10 then
            sleep = 7
            DrawMarker(2, Config.ShellWeed.x, Config.ShellWeed.y, Config.ShellWeed.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst4 < 1 then
                DrawText3D(Config.ShellWeed.x, Config.ShellWeed.y, Config.ShellWeed.z + 0.4, '~g~E~s~ - Shell Leaf')
                if IsControlJustReleased(0, 38) then
                    EsrarIsle()
                end
            end
        end
        if dst5 < 10 then
            sleep = 7
            DrawMarker(2, Config.DryWeed.x, Config.DryWeed.y, Config.DryWeed.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst5 < 1 then
                DrawText3D(Config.DryWeed.x, Config.DryWeed.y, Config.DryWeed.z + 0.4, '~g~E~s~ - Dry Weed Leaf')
                if IsControlJustReleased(0, 38) then
                    EsrarIsle2()
                end
            end
        end
        if dst6 < 10 then
            sleep = 7
            DrawMarker(2, Config.PackageWeed.x, Config.PackageWeed.y, Config.PackageWeed.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst6 < 1 then
                DrawText3D(Config.PackageWeed.x, Config.PackageWeed.y, Config.PackageWeed.z + 0.4, '~g~E~s~ - Package Weed')
                if IsControlJustReleased(0, 38) then
                    EsrarPaketle()
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

function EsrarTopla()
    if not topluyormu then
        topluyormu = true
        exports['mythic_progbar']:Progress({
            name = "esrarver",
            duration = 10000,
            label = 'You are picking weed leaf...',
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_arresting",
                anim = "a_uncuff",
                flags = 49,
            },
        }, function(cancelled)
            if not cancelled then
                TriggerServerEvent('utx-weed:giveweed')
                topluyormu = false
                ESX.ShowNotification('You have successfully picked weed leaf!')
            else
                -- Do Something If Action Was Cancelled
            end
        end)
    end
end

function EsrarIsle()
    if not isliyormu then
        ESX.TriggerServerCallback('utx-weed:malzemekontrol', function(data)
            local player = PlayerPedId()
            isliyormu = true
            local finished = exports["reload-skillbar"]:taskBar(5000,math.random(5,15))
            if finished ~= 100 then
                TriggerServerEvent('utx-weed:removeitem', 'esrar_ham', 1)
                isliyormu = false
                ClearPedTasksImmediately(player)
                ESX.ShowNotification('You couldn\'t shell the leaf!')
            else
                local finished2 = exports["reload-skillbar"]:taskBar(4750,math.random(5,15))
                if finished2 ~= 100 then
                    TriggerServerEvent('utx-weed:removeitem', 'esrar_ham', 1)
                    isliyormu = false
                    ClearPedTasksImmediately(player)
                    ESX.ShowNotification('You couldn\'t shell the leaf!')
                else
                    local finished3 = exports["reload-skillbar"]:taskBar(4500,math.random(5,15))
                    if finished3 ~= 100 then
                        TriggerServerEvent('utx-weed:removeitem', 'esrar_ham', 1)
                        isliyormu = false
                        ClearPedTasksImmediately(player)
                        ESX.ShowNotification('You couldn\'t shell the leaf!')
                    else
                        TriggerServerEvent('utx-weed:processweed')
                        isliyormu = false
                        ClearPedTasks(player)
                        ESX.ShowNotification('You have successfully shelled the leaf!')
                    end
                end
            end
        end, "esrar_ham", 1)
    end
end

function EsrarIsle2()
    if not kurutuyormu then
        ESX.TriggerServerCallback('utx-weed:malzemekontrol', function(data)
            local player = PlayerPedId()
            kurutuyormu = true
            local finished = exports["reload-skillbar"]:taskBar(4500,math.random(5,15))
            if finished ~= 100 then
                TriggerServerEvent('utx-weed:removeitem', 'esrar_islenmis', 1)
                kurutuyormu = false
                ClearPedTasksImmediately(player)
                ESX.ShowNotification('You couldn\'t dried the weed!')
            else
                local finished2 = exports["reload-skillbar"]:taskBar(4250,math.random(5,15))
                if finished2 ~= 100 then
                    TriggerServerEvent('utx-weed:removeitem', 'esrar_islenmis', 1)
                    kurutuyormu = false
                    ClearPedTasksImmediately(player)
                    ESX.ShowNotification('You couldn\'t dried the weed!')
                else
                    local finished3 = exports["reload-skillbar"]:taskBar(4000,math.random(5,15))
                    if finished3 ~= 100 then
                        TriggerServerEvent('utx-weed:removeitem', 'esrar_islenmis', 1)
                        kurutuyormu = false
                        ClearPedTasksImmediately(player)
                        ESX.ShowNotification('You couldn\'t dried the weed!')
                    else
                        TriggerServerEvent('utx-weed:processweed2')
                        kurutuyormu = false
                        ClearPedTasks(player)
                        ESX.ShowNotification('You have successfully dried the weed!')
                    end
                end
            end
        end, "esrar_islenmis", 1)
    end
end

function EsrarPaketle()
    if not paketliyormu then
        ESX.TriggerServerCallback('utx-weed:malzemekontrol', function(data)
            ESX.TriggerServerCallback('utx-weed:malzemekontrol', function(data)
                local player = PlayerPedId()
                paketliyormu = true
                local finished = exports["reload-skillbar"]:taskBar(4000,math.random(5,15))
                if finished ~= 100 then
                    TriggerServerEvent('utx-weed:removeitem', 'esrar_islenmis2', 1)
                    paketliyormu = false
                    ClearPedTasksImmediately(player)
                    ESX.ShowNotification('You couldn\'t package the weed!')
                else
                    local finished2 = exports["reload-skillbar"]:taskBar(3750,math.random(5,15))
                    if finished2 ~= 100 then
                        TriggerServerEvent('utx-weed:removeitem', 'esrar_islenmis2', 1)
                        paketliyormu = false
                        ClearPedTasksImmediately(player)
                        ESX.ShowNotification('You couldn\'t package the weed!')
                    else
                        local finished3 = exports["reload-skillbar"]:taskBar(3500,math.random(5,15))
                        if finished3 ~= 100 then
                            TriggerServerEvent('utx-weed:removeitem', 'esrar_islenmis2', 1)
                            paketliyormu = false
                            ClearPedTasksImmediately(player)
                            ESX.ShowNotification('You couldn\'t package the weed!')
                        else
                            TriggerServerEvent('utx-weed:packweed')
                            paketliyormu = false
                            ClearPedTasks(player)
                            ESX.ShowNotification('You have successfully packaged the weed!')
                        end
                    end
                end
            end, "poset", 1)
        end, "esrar_islenmis2", 1)
    end
end

if Config.WeedBlip then
    local coords = vector3(Config.WeedExit.x, Config.WeedExit.y, Config.WeedExit.z)
    local blip = AddBlipForCoord(coords)

	SetBlipSprite(blip, 140)
	SetBlipScale(blip, 0.7)
	SetBlipColour(blip, 2)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Weed Lab')
    EndTextCommandSetBlipName(blip)
end
