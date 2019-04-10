Shop.Default = {
    x = ScrW() * 0.84,
    y = ScrH() * 0.0,
    w = ScrW() * 0.16,
    h = ScrH() * 1
}

local function NotifyPurchase(purchaser_name, purchase)
    local commission = string_comma_value(Shop.GetCommission(purchase.purchase_price))

    local player = {
        Player = true,
        Name = purchaser_name,
        SteamID = util.SteamIDFrom64(purchase.SteamID64)
    }

    local template_message = " purchased <color=128,255,0>%s</color>."
                          .. " You have received a commission of <color=255,64,0>%s</color> Ember."
    local formatted_message = string.format(template_message,
                                            Shop.GetPrettyName(purchase.cosmetic_name),
                                            commission)

    chat.AddText(true, ":icon=information: ", player, formatted_message)
end

local function NotifyTotalCommission(amount)
    chat.AddText(true, string.format(
        ":icon=information: Commissions total: <color=255,64,0>%s</color> Ember",
        string_comma_value(amount)
    ))
end

net.Receive("Shop.NotifyAuthorCommission", function(len)
    local total_commission = net.ReadInt(32)
    local purchases        = net.ReadTable()

    local printed_purchases = 0
    for _, purchase in pairs(purchases) do

        steamworks.RequestPlayerInfo(purchase.SteamID64, function(name)
            NotifyPurchase(name, purchase)

            -- steamworks requested player names can arrive in any order, so we rely on the amount
            -- of received names to determine if we have them all
            printed_purchases = printed_purchases + 1
            if #purchases > 1 and printed_purchases == #purchases then
                NotifyTotalCommission(total_commission)
            end
        end)
    end
end)

local function DrawDarkerBg(p,w,h)
    draw.RoundedBoxEx(8, 0, 0, w, h, Color(17, 17, 34, 240), true, true, true, true)
end

function Shop.GetPrice(item)
    local mult = Members.GetMyGroup().ShopPriceMultiplier or 1
    if not item.price then return nil, mult end
    return item.price * mult, mult
end

function Shop.CanAfford(item)
    return SparkWerk.GetMyCurrency() >= (Shop.GetPrice(item) or 0)
end

function Shop.HaveRequiredAward(item)
    if not item.award_lock then
        return true
    end

    if Awards.GetMyAwards()[item.award_lock] then
        return true
    end

    return false
end

function Shop.CanPurchaseItem(item)
    if not Shop.CanAfford(item) then
        return false
    end

    if not Shop.HaveRequiredAward(item) then
        return false
    end

    return true
end

function Shop.IsOwned(item)
    assert(item)
    assert(item.type == "cosmetic", "non-cosmetic shop items aren't supported yet")
    return Cosmetics.LocalOwnCostume(item.cosmetic_name)
end

function Shop.RequestWear(item)
    net.Start("Shop.RequestWear")
        net.WriteString(item.cosmetic_name)
    net.SendToServer()
end

function Shop.MakeWindow()
    local shop_window = vgui.Create("DShop")
    shop_window:SetSkin("sunrust")

    local owned_items = shop_window:AddItemGroup("Inventory")
    owned_items.Container:SetDnD("InventorySlot")
    local sale_items = shop_window:AddItemGroup("For Sale")

    for name, _ in pairs(Cosmetics.OwnedCostumes) do
        local item = Shop.GetCosmetic(name)
        owned_items:AddEntry(item)
    end

    for k, item in pairs(Shop.Items) do
        if not Shop.IsOwned(item) then
            sale_items:AddEntry(item)
        end
    end

    shop_window.OnItemPurchase = function(panel, item, item_panel)
        item_panel:SetParent(owned_items.Container)
        item_panel:SetPreview(false)
        owned_items.Container:InvalidateLayout()
    end

    sui.Edit(shop_window)
        :DisplayEntries()
        :MakePopup()
        :Center()
end

net.Receive("Shop.Open", function()
    RunConsoleCommand("spark_cosmetics", "1")
    Shop.MakeWindow()
end)

net.Receive("Shop.NewItem", function()
    local item = net.ReadTable()
    Shop.AddItem(item)
end)

concommand.Add("shop", function() Shop.MakeWindow() end)
