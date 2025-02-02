Config = {}
    
Config.Radar = {
    ["radar1"] = {
        speedLimit = 50,  -- Speed limit in km/h
        fineAmount = 500, -- Fine amount for overspeeding
        coords = vec3(302.5405, -1056.4749, 29.2305),
        radius = 10,      -- Zone radius
        debug = false,     -- Enable debug mode for this zone
        enableBlip = true, -- Enable or disable the radar blip
        blipConfig = {
            sprite = 184,      -- Blip icon
            color = 0,         -- Blip color
            scale = 0.8,       -- Blip size
            name = "Radar Zone" -- Blip name
        },
        screenEffect = {
            name = "SwitchShortNeutralIn",
            duration = 500 -- Duration of the flash effect in milliseconds
        }
    }
}

Config.Notify = function(type, message)
    lib.notify({
        type = type,
        title = "Radar System",
        description = message
    })
end