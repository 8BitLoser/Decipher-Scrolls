local configPath = "Decipher Scrolls"
---@class bsDecipherConfig<K, V>: { [K]: V }
local defaults = {
    costMult = 1.05,
    spellPrefix = true,
    key = { --Keycode to trigger menu
        keyCode = tes3.scanCode.i,
        isShiftDown = false,
        isAltDown = false,
        isControlDown = false,
    },
}


---@class bsDecipherConfig
local config = mwse.loadConfig(configPath, defaults)

local function registerModConfig()
    local template = mwse.mcm.createTemplate({ name = configPath, defaultConfig = defaults, config = config })
    template:saveOnClose(configPath, config)

    local settings = template:createPage({ label = "Settings" })
    settings.showReset = true

    settings:createYesNoButton({
        label = "Prefix Spell Name with [D]",
        configKey = "spellPrefix"
    })

    settings:createSlider({
        label = "Soul/Cast Cost Multiplier",
        configKey = "costMult",
        min = 0.1, max = 10, step = 0.01, jump = 0.10, decimalPlaces = 2,
    })

    settings:createKeyBinder({
        label = "Decipher Menu Hotkey",
        configKey = "key",
        allowCombinations = false
    })

    template:register()
end
event.register(tes3.event.modConfigReady, registerModConfig)

return config