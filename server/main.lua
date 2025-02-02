local Core = GlobalState.Core

RegisterNetEvent("applyFine", function(amount)
    local xPlayer = Core.GetPlayer(source)
    if xPlayer then
        Core.RemoveMoney(xPlayer, amount)
    end
end)
