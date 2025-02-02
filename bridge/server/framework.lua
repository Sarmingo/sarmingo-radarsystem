local Core = {}

-- ANSI Color Codes
local Colors = {
    Green = "32",
    Blue = "34",
    Yellow = "33",
    Red = "31"
}

--- Prints colored text to the console
---@param text string The message to print
---@param color string The ANSI color code
local function printColored(text, color)
    print(string.format("\27[%sm%s\27[0m", color, text))
end

--- Framework Detection & Integration
if GetResourceState('qbox') == 'started' then
    local QBox = exports.qbx_core
    Core.GetPlayer = function(source) return QBox:GetPlayer(source) end
    Core.RemoveMoney = function(player, amount) player.removeMoney(amount) end
    printColored("[INFO] QBOX Framework Loaded Successfully!", Colors.Green)

elseif GetResourceState('qb-core') == 'started' then
    local QBCore = exports['qb-core']:GetCoreObject()
    Core.GetPlayer = function(source) return QBCore.Functions.GetPlayer(source) end
    Core.RemoveMoney = function(player, amount) player.Functions.RemoveMoney('cash', amount) end
    printColored("[INFO] QB-Core Framework Loaded Successfully!", Colors.Blue)

elseif GetResourceState('es_extended') == 'started' then
    local ESX = exports['es_extended']:getSharedObject()
    Core.GetPlayer = function(source) return ESX.GetPlayerFromId(source) end
    Core.RemoveMoney = function(player, amount) player.removeMoney(amount) end
    printColored("[INFO] ESX Framework Loaded Successfully!", Colors.Yellow)

else
    printColored("[ERROR] No supported framework found! (qbox, qb-core, esx)", Colors.Red)
end

-- Store Core globally
GlobalState.Core = Core
printColored("[DEBUG] Core module initialized and set in GlobalState.", Colors.Green)
