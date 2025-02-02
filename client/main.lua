lib.locale()

local function createBlip(data)
    if data.enableBlip then
        local blip = AddBlipForCoord(data.coords.x, data.coords.y, data.coords.z)
        SetBlipSprite(blip, data.blipConfig.sprite)
        SetBlipColour(blip, data.blipConfig.color)
        SetBlipScale(blip, data.blipConfig.scale)
        SetBlipDisplay(blip, 4)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(data.blipConfig.name)
        EndTextCommandSetBlipName(blip)
    end
end

local function cameraFlash(effect)
    StartScreenEffect(effect.name, 0, true)
    Citizen.Wait(effect.duration)
    StopScreenEffect(effect.name)
end

local function getVehicleSpeed(vehicle)
    local speed = GetEntitySpeed(vehicle)
    return math.floor(speed * 3.6)
end

local function radar(data)
    createBlip(data)
    lib.zones.sphere({
        coords = data.coords,
        radius = data.radius,
        debug = data.debug,
        onEnter = function(self)
            Config.Notify("inform", locale('speed_limit', data.speedLimit))
        end,
        onExit = function(self)
            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(ped, false)
            if vehicle ~= 0 then
                local driverPed = GetPedInVehicleSeat(vehicle, -1)
                if driverPed == ped then
                local speed = getVehicleSpeed(vehicle)
                if speed > data.speedLimit then
                    Config.Notify("success", locale('speeding', data.fineAmount))
                    TriggerServerEvent("applyFine", data.fineAmount)
                    cameraFlash(data.screenEffect)
                end
            end
            end
        end,
    })
end

CreateThread(function()
    for _, data in pairs(Config.Radar) do
        radar(data)
    end
end)
