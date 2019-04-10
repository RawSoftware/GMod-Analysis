local Name = "DShop"
local BaseName = "DFrame"

local PANEL = {}
PANEL.NumColumns = 4
PANEL.ItemGroups = {}

local scanline = Material("sparkwerk/scanline2")
local mat_gradient_d  = Material("VGUI/gradient-d")
local mat_gradient_u  = Material("VGUI/gradient-u")

local function DrawCenteredPretty(panel, width, height)
    local w, h = panel:GetSize()
    local text = panel:GetText()
    local font = panel:GetFont()
    surface.SetFont(font)

    local fw, fh = surface.GetTextSize(text)
    --draw.SimpleTextOutlined(text, font .. "blur", (w/2) - (fw/2) + 1, 1, Color(0, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color( 0, 0, 0, 128 ) )
    --draw.SimpleTextOutlined(text, font, (w/2) - (fw/2), 0, panel:GetColor(), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color( 0, 0, 0, 255 ) )
end

local function PurchaseConfirmWindow(item, item_panel, preview_panel, shop_panel)
    local price, mult = Shop.GetPrice(item)
    local pricecom = string_comma_value(price)

    local confirm_question_text = string.format("Are you sure you want to buy %s for %s Ember?", item.name, pricecom)
    local confirm_button_text = string.format("Purchase (%s Ember)", pricecom)

    local confirm_window = Derma_Query(confirm_question_text, "Confirm Purchase", "Cancel", nil, confirm_button_text, function()
        local mycurrency = SparkWerk.GetMyCurrency()
        if mycurrency < price then
            chat.AddText(true, string.format(":icon=information: Not enough Ember to buy %s. You have <color=255,64,0>%s Ember</>."
                                    .. " Earn more Ember by playing and winning on Sunrust servers.", item.name, string_comma_value(mycurrency)))
            return
        end

        net.Start("Shop.RequestPurchase")
            net.WriteString(item.cosmetic_name)
        net.SendToServer()

        hook.Add("OnCosmeticOwn", "Shop.OwnItem", function(name)
            if name ~= item.cosmetic_name then
                return
            end

            item_panel:SetOwned(true)
            item_panel:SetEquipped(true)
            preview_panel:SetPreviewItem()

            chat.AddText(true, string.format("Purchased %s for %s Ember.", item.name, pricecom))

            shop_panel:OnItemPurchase(item, item_panel)
            hook.Remove("OnCosmeticOwn", "Shop.OwnItem")
        end)
    end)

    confirm_window:SetSkin("sunrust")
end

function PANEL:Init()
    self.ItemGroups = {}
    sui.Edit(self)
        :Set("Base", vgui.GetControlTable(BaseName))
        :SetTitle("")
        :SetDraggable(false)
        :SetSizable(false)
        :ShowCloseButton(true)
        :DockPadding(8, 16, 8, 8)
        :NoClipping(true)

    self.TopPanel =
        sui.Build("DPanel", self)
        :Dock(TOP)
        :Set("Paint", nil)
        :DockPadding(8, 0, 0, 0)
        :Build()

    self.MyEmber =
    sui.Build("DEmberDisplay", self.TopPanel)
        :SetMySize(32)
        :SizeToChildren(true, false)
        :Build()

    self.Title =
    sui.Build("DLabel", self.TopPanel)
        :SetContentAlignment(5)
        :CenterHorizontal()
        :SetFont("hugeshop")
        :SetText("Shop")
        :SizeToContents()
        :Build()

    local ew, eh = self.MyEmber:GetSize()
    self.TopPanel:SetSize(ew, eh + 8)

    self.PreviewPanel =
    sui.Build("DPanel", self)
        :Dock(LEFT)
        :DockPadding(0, 0, 8, 0)
        :Set("Paint", nil)
        :Build()

    self.PlayerPreview =
    sui.Build("DShopPreview", self.PreviewPanel)
        :Dock(TOP)
        :SetSize(ScrW() / 4, ScrH() / 1.55)
        :Set("OnPurchase", function(panel, item)
            PurchaseConfirmWindow(item, self.PreviewItemPanel, self.PlayerPreview, self)
        end)
        :Set("OnEquip", function(panel, item)
            self:EquipItem(item, 1)
        end)
        :Build()

    local overlay =
    sui.Build("DPanelOverlay", self.PlayerPreview)
        :SetType(1)
        :SetColor(SparkWerk.Color.SunrustLightBlue)
        :Build()

    self.PreviewPanel:SetSize(self.PlayerPreview:GetSize())
    overlay:SetSize(self.PlayerPreview:GetSize())

    self.Inventory =
    sui.Build("DPanel", self.PreviewPanel)
        :Dock(FILL)
        :DockPadding(0, 8, 0, 8)
        :Set("Paint", nil)
        :Build()

    self.InventoryTitle =
    sui.Build("DLabel", self.Inventory)
        :SetFont("largeshop")
        :SetText("Equipped")
        :SizeToContents()
        :SetContentAlignment(2)
        :Set("Paint", nil)
        :Build()

    self.Inventory:SetSize(1, ScrH() / 8)

    self.InventorySlots = {}

    self.EquipGrid =
    sui.Build("DIconLayout", self.Inventory)
        :SetLayoutDir(LEFT)
        :SetStretchWidth(true)
        :SetSpaceX(8)
        :SetSpaceY(8)
        :Build()

    self:CreateSlot()
    self.TargetSlot = 1

    local ScrollPanelBack =
    sui.Build("DPanel", self)
        :Dock(FILL)
        :Set("Paint", function(p, w, h)
            local size = h / 2
            surface.SetDrawColor(10, 10, 20, 150)
            surface.SetMaterial(mat_gradient_u)
            surface.DrawTexturedRect(0, 0, w, size)

            surface.SetMaterial(mat_gradient_d)
            surface.DrawTexturedRect(0, h - size, w, size)
        end)
        :Build()

    sui.Build("DPanelOverlay", ScrollPanelBack)
        :SetType(1)
        :SetColor(SparkWerk.Color.SunrustLightBlue)
        :SetZPos(100)
        :Build()

    self.ItemPane =
    sui.Build("DScrollPanel", ScrollPanelBack)
        :Dock(FILL)
        :Build()

    self.OnClose = function()
        self:SetMouseInputEnabled(false)
        self:SetKeyboardInputEnabled(false)
        gui.EnableScreenClicker(false)
    end

    hook.Add("OnCosmeticEquip", "ShopUpdateCosmetic", function(userid, name, doequip)
        if not IsValid(self) then
            hook.Remove("OnCosmeticEquip", "ShopUpdateCosmetic")
            return
        end

        local ply = Player(userid)

        if ply == LocalPlayer() then
            local item = Shop.GetCosmetic(name)
            if doequip then
                self:DoEquip(item, 1)
            else
                self:DoUnEquip(1)
            end
        end
    end)
end

function PANEL:EquipItem(item, slot_number)
    self:ResetPreview()
    self:DoEquip(item, slot_number)
    net.Start("Shop.RequestWear")
        net.WriteString(item.cosmetic_name)
    net.SendToServer()
end

function PANEL:OnItemPurchase(item, item_panel)
end

function PANEL:DisplayEntries()
    for _, group in ipairs(self.ItemGroups) do
        group:DisplayEntries()
    end

    local i = 1
    for name, _ in pairs(Cosmetics.EquippedCostumes) do
        local slot = self.InventorySlots[i]
        if not slot then
            break
        end
        self.PlayerPreview:SetEquipped(name, true)
        slot:SetUp(Shop.GetCosmetic(name))
        slot:SetOwned(true)
        slot:SetEquipped(true)
        i = i + 1
    end
end

function PANEL:AddEntry(item_panel, item)
    self.ItemPanels[item.cosmetic_name] = item_panel
end

function PANEL:AddItemGroup(title)
    local spacing = (ScrW() / 2560) * 8

    local group =
    sui.Build("DShopItemGroup", self.ItemPane)
        :Dock(TOP)
        :SetTitle(title)
        :Set("OnAddEntry", function(group_panel, item_panel, item)
            self:AddEntry(item_panel, item)
        end)
        :Set("DoPreview", function(group_panel, item_panel, item)
            if item_panel == self.PreviewItemPanel then
                item_panel:SetPreview(false)
                self.PreviewItemPanel = nil
                self.PlayerPreview:SetPreviewItem()
                return
            end

            if IsValid(self.PreviewItemPanel) then
                self.PreviewItemPanel:SetPreview(false)
            end

            item_panel:SetPreview(true)

            self.PlayerPreview:SetPreviewItem(item)
            self.PreviewItemPanel = item_panel
        end)
        :SetSpacing(spacing)
        :Build()

    table.insert(self.ItemGroups, group)

    return group
end

function PANEL:PerformLayout()
    self.ColumnHeight = ScrH() / 8
    self.ColumnWidth = self.ColumnHeight / 0.5625

    if not self.PlayerPreview then return end

    local preview_width, _ = self.PlayerPreview:GetSize()
    local other_width = preview_width + 36

    self.NumColumns = math.floor((ScrW() - other_width) / self.ColumnWidth)

    local spacing = (ScrW() / 2560) * 8
    local total_spacing = (self.NumColumns - 1) * spacing

    sui.Edit(self)
        :SetWidth(other_width + total_spacing + (self.ColumnWidth * self.NumColumns))
        :SetHeight(ScrH() * 0.9)

    self.EquipGrid:Center()

    sui.Edit(self.InventoryTitle)
        :MoveBelow(self.EquipGrid, 8)
        :CenterHorizontal()

    self.Base.PerformLayout(self)

    local px, py = self.PreviewPanel:GetPos()
    self.Title:CenterHorizontal()

    self.MyEmber:CenterHorizontal()
    self.MyEmber:SetPos(8, 0)
end

function PANEL:GetTargetSlot()
    if self.TargetSlot <= #self.InventorySlots then
        return self.InventorySlots[self.TargetSlot]
    end
end

function PANEL:OccupyTargetSlot()
    if self.TargetSlot > #self.InventorySlots then
        return
    end
    self.TargetSlot = self.TargetSlot + 1
end

local function DrawDarkerBg(p, w, h)
    draw.RoundedBoxEx(0, 0, 0, w, h, Color(17, 17, 34, 255), true, true, true, true)
end

function PANEL:Paint(w, h)
    DrawDarkerBg(self, w, h)
    surface.SetMaterial(scanline)
    local pad = 4
    w = w - (pad * 2)
    h = h - (pad * 2)
    local sw, sh = scanline:Width() * ScreenScale(0.3), scanline:Height() * ScreenScale(0.3)
    surface.SetDrawColor(SparkWerk.Color.SunrustLightBlue)
    --surface.DrawTexturedRectUV(0, 0, w, h, 0, 0, w / sw * 1.5, h / sh * 1.5)
    surface.DrawTexturedRectUV(pad, pad, w, h, 0, 0, w / sw, h / sh)
end

function PANEL:DoUnEquip(slot_number)
    assert(slot_number <= #self.InventorySlots, "Invalid slot to equip")

    local slot = self.InventorySlots[slot_number]

    if slot.Item then
        self.PlayerPreview:SetEquipped(slot.Item.cosmetic_name, false)
    end

    slot:SetUp()
end

function PANEL:DoEquip(item, slot_number)
    assert(slot_number <= #self.InventorySlots, "Invalid slot to equip")

    local slot = self.InventorySlots[slot_number]

    if slot.Item then
        if slot.Item.cosmetic_name == item.cosmetic_name then
            return
        end
        self.PlayerPreview:SetEquipped(slot.Item.cosmetic_name, false)
    end

    self.PlayerPreview:SetEquipped(item.cosmetic_name, true)

    slot:SetUp(item)
end

function PANEL:ResetPreview()
    if IsValid(self.PreviewItemPanel) then
        self.PreviewItemPanel:SetPreview(false)
        self.PreviewItemPanel = nil
    end

    self.PlayerPreview:SetPreviewItem()
end

function PANEL:CreateSlot()
    local slot_number = (#self.InventorySlots + 1)

    local entry =
    sui.Build("DShopItem", self.EquipGrid)
        :EnableAsSlot()
        :Set("SlotRemove", function(panel)
            net.Start("Shop.RequestWear")
                net.WriteString(panel.Item.cosmetic_name)
            net.SendToServer()
            self:DoUnEquip(slot_number)
        end)
        :Set("SlotTogglePreview", function(panel, value)
            if panel.Item then
                self.PlayerPreview:SetEquipped(panel.Item.cosmetic_name, value)
            end
            panel:SetPreview(false)
        end)
        :Receiver("InventorySlot", function(panel, panels, dropped)
            if not dropped then return end

            local panel = panels[1]
            if panel and panel.Item and dropped then
                self:EquipItem(panel.Item, 1)
            end
        end, {})
        :Build()

    table.insert(self.InventorySlots, entry)
end

vgui.Register(Name, PANEL, BaseName)
