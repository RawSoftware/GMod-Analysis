
net.Receive("SR.Currency", function()
    local cash = net.ReadInt(32)
    LocalPlayer().Ember = cash
    hook.Run("SR.LocalCurrencySet", cash)
end)

function SparkWerk.GetMyCurrency()
    return LocalPlayer().Ember or 0
end

function SparkWerk.GetMyStringCurrency()
    local my_currency = LocalPlayer().Ember
    return my_currency and string_comma_value(my_currency) or "?"
end
