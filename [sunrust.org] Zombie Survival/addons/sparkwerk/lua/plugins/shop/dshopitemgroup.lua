local Name = "DShopItemGroup"
local BaseName = "DPanel"

local PANEL = {}

function PANEL:SetSpacing(space)
    self.Container:SetSpaceX(space / 2)
    self.Container:SetSpaceY(space / 2)
    self.Container:InvalidateLayout()
    self.Spacing = space
end

function PANEL:Init()
    self.Paint = nil
    self.Entries = {}

    self:SetMouseInputEnabled(true)

    self.Title =
    sui.Build("DLabel", self)
        :Dock(TOP)
        :SetText("")
        :SetFont("largeshop")
        :SizeToContents()
        :Build()

    self.Container =
    sui.Build("DIconLayout", self)
        :Dock(TOP)
        :SetUseLiveDrag(true)
        :SetMouseInputEnabled(true)
        :SetSpaceX(4)
        :SetSpaceY(4)
        :SetStretchHeight(true)
        :Layout()
        :Build()
end

function PANEL:DoPreview(item)
    -- for override
end

function PANEL:SetTitle(name)
    self.Title:SetText(name)
end

function PANEL:PerformLayout(width, height)
    self:SizeToChildren(true, true)
end

function PANEL:DisplayEntries()
    assert(self.Entries)

    local sorted_entries = {}

    for _, panel in pairs(self.Entries) do
        table.insert(sorted_entries, panel)
    end

    table.sort(sorted_entries, function(panel_a, panel_b)
        local is_a_owned = Shop.IsOwned(panel_a.Item)
        local is_b_owned = Shop.IsOwned(panel_b.Item)

        if is_a_owned == is_b_owned then
            return panel_a.Item.cosmetic_name < panel_b.Item.cosmetic_name
        end

        if is_a_owned then return true end
        if is_b_owned then return false end
    end)

    for _, panel in ipairs(sorted_entries) do
        self.Container:Add(panel)
    end

    self.Container:SizeToChildren(true, true)
end

function PANEL:AddEntry(item)
    local is_owned = Cosmetics.LocalOwnCostume(item.cosmetic_name)
    local is_equip = Cosmetics.IsEquipped(LocalPlayer():UserID(), item.cosmetic_name)

    local entry =
    sui.Build("DShopItem")
        :SetUp(item)
        :SetOwned(is_owned)
        :SetEquipped(is_equip)
        :Set("DoPreview", function(panel, item)
            self:DoPreview(panel, item)
        end)
        :Set("CornerRadius", 0)
        :Build()

    self.Entries[item.cosmetic_name] = entry
end

vgui.Register(Name, PANEL, BaseName)
