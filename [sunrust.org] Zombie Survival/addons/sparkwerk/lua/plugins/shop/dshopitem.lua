local Name = "DShopItem"
local BaseName = "DButton"

local PANEL = {}

PANEL.IsOwned = false
PANEL.IsEquipped = false
PANEL.IsPreviewed = false
PANEL.CornerRadius = 0

function PANEL:SetItem(item)
    self.Item = item
end

function PANEL:DoPreview(item)
    return false
end

local scanline = Material("sparkwerk/scanline2")
local mat_gradient_d  = Material("VGUI/gradient-d")

function PANEL:Paint()
    local w, h = self:GetSize()
    local r, g, b = 40, 40, 40

    if self.Legendary then
        r, g, b = 40, 0, 90
    elseif self.IsOwned then
        r, g, b = 40, 40, 60
    end

    self.Name:SetColor(Color(255, 255, 255))

    if self.IsPreviewed then
        r, g, b = r, g * 2, b * 2
    elseif self:IsHovered() and not self.Slot and not dragndrop.IsDragging() then
        r, g, b = r * 2, g * 2, b * 2
    elseif self:IsHovered() and self.Slot and dragndrop.IsDragging() then
        if self.Item then
            r, g, b = 80, 40, 40
        else
            r, g, b = 80, 80, 120
        end
    else
        self.Name:SetColor(Color(220, 220, 230))
    end

    local alpha = 200
    local pad = 2
    draw.RoundedBoxEx(self.CornerRadius, 0, 0, w, h, Color(r * 0.5, g* 0.5, b * 0.5, alpha), true, true, true, true)
    draw.RoundedBoxEx(self.CornerRadius, pad, pad, w - (pad * 2), h - (pad * 2), Color(r, g, b, alpha), true, true, true, true)

    surface.SetMaterial(scanline)

    local sw, sh = scanline:Width(), scanline:Height()
    local mul = 0.85

    pad = 4
    w = w - (pad * 2)
    h = h - (pad * 2)

    local sw, sh = scanline:Width(), scanline:Height()

    surface.SetDrawColor(r * mul, g * mul, b * mul, 255)
    surface.DrawTexturedRectUV(pad, pad, w, h, w / sw * 1.5, 0, 0, h / sh * 1.5)

    if not self.Slot or self.Slot and self.Item then
        local size = h / 3
        surface.SetDrawColor(Color(0, 0, 0, 80))
        surface.SetMaterial(mat_gradient_d)
        surface.DrawTexturedRect(pad, pad + h - size - self.TopSection:GetTall() + 1, w, size)
    end
end

function PANEL:SetEquipped(equip)
    if not self.IsOwned then
        return
    end

    self.IsEquipped = equip
end

function PANEL:SetOwned(owned)
    self.IsOwned = owned

    if self.Item.award_lock and not self.IsOwned then
        self:SetAwardLock(self.Item)
    else
        self:SetAwardLock{}
    end

    if owned then
        self.Price:SetVisible(false)
        return
    end

    local price, _ = Shop.GetPrice(self.Item)

    if price then
        self.Price:SetVisible(true)
        self.Price:SetAmount(price)
    else
        self.Price:SetVisible(false)
    end

    if Shop.CanAfford(self.Item) then
       self.Price:SetColor(Color(0,255,128,255))
       self.Affordable = true
    else
       self.Price:SetColor(Color(255,128,0,255))
       self.Affordable = false
    end
end

function PANEL:SetPreview(prev)
    self.IsPreviewed = prev
end

function PANEL:OnRemove()
    if IsValid(self.PlayerPreview) then
        self.PlayerPreview:Remove()
    end
end

local CurrentlyBuilding = {}
local function IsBuilding(name)
    return CurrentlyBuilding[name]
end

local function SetBuilding(name, building)
    CurrentlyBuilding[name] = building
end

function PANEL:RebuildPreview()
    local icon = self.PreviewIcon

    self.PlayerPreview =
    sui.Build("DPlayerFrame")
        :SetPlayerInfo{
            Model = "models/player/breen.mdl",
            PlayerColor = Vector(0, 0, 0),
            CostumeNames = {self.Item.cosmetic_name}
        }
        :SetSequences("idle_all_01", "idle_all_01")
        :SetVisible(true)
        :Build()

    self.PlayerPreview.Entity:SetMaterial("models/shadertest/shield")

    local icon_name = "_cosmetic/" .. self.Item.cosmetic_name

    SetBuilding(icon_name, true)

    hook.Add("SpawniconGenerated", icon_name, function(last_icon, imagename, modelsleft)
        if last_icon ~= icon_name then
            return
        end

        self.PlayerPreview:Remove()

        SetBuilding(icon_name, false)
        hook.Remove("SpawniconGenerated", icon_name)
    end)

    local cam_focal_point = Vector(0, 0, 66)
    local cam_view_distance = 32

    local cosmetic = Shop.GetCosmetic(self.Item.cosmetic_name)
    if cosmetic.face_wear then
        cam_focal_point = cam_focal_point - Vector(0, 0, 2)
        cam_view_distance = 36
    end

    local cam_view_angle = Angle(5, 165, 0)
    local cam_position = cam_focal_point
        + cam_view_angle:Forward() * -cam_view_distance
        - cam_view_angle:Right() * 2

    -- give time to emit particles so we can see them, if applicable
    local generate_delay = cosmetic.particles and 1 or 0

    timer.Simple(generate_delay, function()
        icon:RebuildSpawnIconEx{
            ent     = self.PlayerPreview.Entity,
            cam_pos = cam_position,
            cam_ang = cam_view_angle,
            cam_fov = 60
        }
    end)
end

local function DrawCenteredPretty(panel, width, height)
    local w, h = panel:GetSize()
    local text = panel:GetText()

    surface.SetFont(panel:GetFont())

    local fw, fh = surface.GetTextSize(text)
    for i = 1, 2 do
        draw.SimpleTextOutlined(
            text,
            "largeshopblur",
            (w / 2) - (fw / 2) + 0,
            0,
            Color(0, 0, 0),
            TEXT_ALIGN_LEFT,
            TEXT_ALIGN_TOP,
            0,
            Color(0, 0, 0, 255)
        )
    end
end

function PANEL:Init()
    local h = ScrH() / 8
    local w = h / 0.5625

    sui.Edit(self)
        :DockMargin(3, 3, 3, 3)
        :DockPadding(4, 4, 4, 4)
        :SetText("")
        :SetMouseInputEnabled(true)
        :SetSize(w, h)

    self.MidLowerSection =
    sui.BuildCategory(self)
        :SetMouseInputEnabled(false)
        :SetSize(w, h)
        :Build()

    -- create preview without docking so it can be visible
    -- behind other elements
    self.PreviewIcon =
    sui.Build("SpawnIcon" , self.MidLowerSection)
        :SetMouseInputEnabled(false)
        :Set("PaintOver", nil)
        :SetVisible(false)
        :Build()

    self.PriceSection =
    sui.BuildCategory(self)
        :Dock(TOP)
        :DockPadding(4, 4, 4, 4)
        :SetSize(1, ScrH()/40)
        :SetMouseInputEnabled(false)
        :Build()

    self.Price =
    sui.Build("DEmberDisplay", self.PriceSection)
        :Dock(TOP)
        :SetMySize(14)
        :SetVisible(false)
        :SetAmount(0)
        :SetZPos(100)
        :SizeToChildren(true, true)
        :Build()

    self.PriceSection:SetSize(self.Price:GetSize())
    local pad = ScrW()/1080*2

    self.TopSection =
    sui.BuildCategory(self)
        :Dock(BOTTOM)
        :SetMouseInputEnabled(false)
        :Set("Paint", function(panel, w, h)
            if self.Item then
                surface.SetDrawColor(17, 17, 34, 105)
                draw.RoundedBoxEx(self.CornerRadius - 2, 0, 0, w, h, Color(17, 17, 17, 125), false, false, true, true)
            end
        end)
        :Build()

    self.Name =
    sui.Build("DLabel", self.TopSection)
        :Dock(TOP)
        :SetFont("largeshop")
        :SetTextColor(Color(250, 250, 250))
        :SetContentAlignment(8)
        :SetMouseInputEnabled(false)
        :SetExpensiveShadow(1.5, Color(0, 0, 0))
        --:Set("Paint", DrawCenteredPretty)
        :SetVisible(false)
        :Build()

    self:SetUp()
end

function PANEL:PerformLayout(width, height)
    if self.lock then
        self.lock:Center()
    end

    if self.Slot then
        self.RemoveButton:SetPos(self:GetWide() - 24, 8)
        self.PreviewToggle:SetPos(8, 8)
    end

    local award_lock = 0
    if self.AwardLock then
        award_lock = self.AwardLockBack:GetTall() * 1.3
    end

    self.PriceSection:SetHeight(self.Price:GetTall() * 1.2 + award_lock)

    local w, h = height * 2, height
    sui.Edit(self.PreviewIcon)
        :SetSize(w, h - 4)
        :SetPos(0, 2)
        :CenterHorizontal()
end

function PANEL:HidePrice()
    self.PriceHidden = true
end

function PANEL:SetLocked()
    self.PreviewIcon:SetVisible(false)
    self.Name:SetVisible(false)
    self.Price:SetVisible(false)
    self.TopSection.Paint = nil
    self.lock =
    sui.Build("DImage", self)
        :SetSize(64, 64)
        :SetImageColor(Color(64, 64, 64))
        :SetImage("sparkwerk/padlock-closed")
        :SetTooltip("This inventory slot is locked.")
        :SetMouseInputEnabled(true)
        :Build()
end

function PANEL:SetLegendary()
    self.Legendary = true
--[[
    self.LegendaryIcon =
    sui.Build("DImage", self)
        :SetImage("icon16/star.png")
        :SetSize(16, 16)
        :SetPos(8, 8)
        :SetMouseInputEnabled(true)
        :SetTooltip("Legendary Item")
        :Build()
]]
end

function PANEL:SlotTogglePreview()
end

function PANEL:SlotRemove()
end

function PANEL:SetAwardLock(item)
    local award_name = item.award_lock_name
    if not award_name then
        if self.AwardLockBack then
            self.AwardLockBack:SetVisible(false)
        end
        return
    end

    self.AwardLockBack =
    sui.BuildCategory(self.PriceSection)
        :Dock(BOTTOM)
        :Build()

    local award_icon_size = (16 * ScrH() / 1440)

    self.AwardLockIconBack =
    sui.BuildCategory(self.AwardLockBack)
        :Dock(LEFT)
        :SetSize(award_icon_size, award_icon_size)
        :Build()

    self.AwardLockIcon =
    sui.Build("DImage", self.AwardLockIconBack)
        :SetImage("icon16/award_star_gold_3.png")
        :SetSize(award_icon_size, award_icon_size)
        :SetKeepAspect(true)
        :Set("DoClick", function(panel)
        end)
        :Center()
        :Build()

    self.AwardLockIconBack:SizeToContents()

    self.AwardLock =
    sui.Build("DLabel", self.AwardLockBack)
        --:Dock(LEFT)
        :SetText(award_name)
        :SetFont("tinyshop")
        :SetColor(Color(255,128,0,255))
        :SetContentAlignment(4)
        :SetPos(award_icon_size + 4, 0)
        :SizeToContents()
        :Build()

    if Shop.HaveRequiredAward(item) then
        self.AwardLock:SetColor(Color(128,255,0,255))
    else
        self.AwardLock:SetColor(SparkWerk.Color.SunrustOrange)
    end

    self:InvalidateLayout()
end

function PANEL:EnableAsSlot()
    self.RemoveButton =
    sui.Build("DImageButton", self)
        :SetImage("icon16/cross.png")
        :SetSize(16, 16)
        :Set("DoClick", function(panel)
            self:SlotRemove()
        end)
        :Build()

    self.PreviewToggle =
    sui.Build("DCheckBoxLabel", self)
        :SetText("Display in Preview")
        :SetValue(1)
        :Set("OnChange", function(panel, value)
            self:SlotTogglePreview(value)
        end)
        :SetFont("tinyshop")
        :SetTextColor(Color(200, 200, 220, 200))
        :Build()

    self.RemoveButton:SetVisible(false)
    self.PreviewToggle:SetVisible(false)
    self.Slot = true
end

function PANEL:SetUp(item)
    self.Item = item
    self.Legendary = false

    if not item then
        if self.Slot then
            self.RemoveButton:SetVisible(false)
            self.PreviewToggle:SetVisible(false)
        end

        self.Name:SetVisible(false)
        self.Price:SetVisible(false)
        self.PreviewIcon:SetVisible(false)
        self.Affordable = true
        self.IsOwned = true
        return
    end

    if self.Slot then
        self.RemoveButton:SetVisible(true)
        self.PreviewToggle:SetVisible(true)
        self.PreviewToggle:SetChecked(true)
    end

    self.Name:SetVisible(true)
    self.PreviewIcon:SetVisible(true)

    local is_owned = Shop.IsOwned(item)

    local preview_w, preview_h = 256, 128

    -- preview is a bit blurry on 1440p, so give it some extra resolution
    -- this slows down generation a lot, but if you're running 1440p
    -- your computer should be able to handle it
    if ScrW() >= 2560 then
        preview_w, preview_h = 512, 256
    end

    self.PreviewIcon.Icon:SetSize(preview_w, preview_h)
    local icon_name = "_cosmetic/" .. item.cosmetic_name

    local long_icon_name = string.format("materials/spawnicons/_cosmetic/%s_%sx%s.png",
                                         item.cosmetic_name,
                                         preview_w,
                                         preview_h)

    self.PreviewIcon:SetModel(icon_name)

    local is_outdated = file.Time(long_icon_name, "GAME") < Shop.GetItemUpdateTime(self.Item)
    local should_rebuild = (not file.Exists(long_icon_name, "GAME") or is_outdated)

    if should_rebuild and not IsBuilding(icon_name) then
        self:RebuildPreview()
    end

    self.Name:SetText(item.name or "none")
    self.Name:SizeToContents()
    local w, h = self.Name:GetSize()
    self.TopSection:SetSize(w, h * 1.1)

    self.DoClick = function()
        local doprev = self:DoPreview(self.Item)
        if doprev then
            self:SetPreview(not self.IsPreviewed)
        end
    end

    if item.legendary then
        self:SetLegendary()
    end

    if item.award_lock and not self.IsOwned then
        self:SetAwardLock(item)
    end
end

vgui.Register(Name, PANEL, BaseName)
