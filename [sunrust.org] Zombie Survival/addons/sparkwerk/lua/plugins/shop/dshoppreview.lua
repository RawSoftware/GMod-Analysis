local Name = "DShopPreview"
local BaseName = "DPanel"

local PANEL = {}

local mat_gradient_r  = Material("VGUI/gradient-r")
local mat_gradient_l  = Material("VGUI/gradient-l")
local mat_gradient_d  = Material("VGUI/gradient-d")
local mat_gradient_u  = Material("VGUI/gradient-u")
local mat_sunrust_512 = Material("sparkwerk/sr-512")

function PANEL:Init()
    sui.Edit(self)
        :DockPadding(0, 0, 0, 0)
        :Set("Paint", nil)

    self.Equipped = {}

    self:InitPreview()
    self:InitOverlay()
    self:SetPreviewItem()
end

local function DrawDarkerBg(p, w, h)
    surface.SetDrawColor(Color(17, 17, 34, 128))
    surface.DrawRect(0, 0, w, h)
end

function PANEL:InitPreview()
    local cl_playermodel = GetConVar("cl_playermodel"):GetString()
    local model_name = player_manager.TranslatePlayerModel(cl_playermodel)

    self.PlayerPreview =
    sui.Build("DPlayerFrame", self)
        :Dock(TOP)
        :SetPlayerInfo{
            Model = model_name,
            PlayerColor = LocalPlayer():GetPlayerColor(),
            WeaponColor = LocalPlayer():GetWeaponColor(),
            CostumeNames = {}
        }
        :SetCamPos(Vector(40, 0, 60))
        :SetFOV(20)
        :SetVisible(true)
        :SetSequences("gesture_wave_original", "idle_all_02")
        :Build()

    local ent = self.PlayerPreview.Entity
    local cam_look_at = Cosmetics.GetCorrectedBonePos(ent, "ValveBiped.Bip01_Head1") - ent:GetPos()
    self.PlayerPreview:SetLookAt(cam_look_at)

    local old_preview_paint = self.PlayerPreview.Paint
    self.PlayerPreview.Paint = function(p, w, h)
        local size = h / 2
        local imgw, imgh = size, size

        surface.SetDrawColor(ColorAlpha(SparkWerk.Color.SunrustOrange, 8))
        surface.SetMaterial(mat_sunrust_512)
        surface.DrawTexturedRect((w / 2) - imgw + 8, (h / 2) - imgh, imgw, imgh)
        render.OverrideBlend(false)

        surface.SetDrawColor(10, 10, 20, 150)

        surface.SetMaterial(mat_gradient_u)
        surface.DrawTexturedRect(0, 0, w, size)
        surface.SetMaterial(mat_gradient_d)
        surface.DrawTexturedRect(0, h - size, w, size)

        surface.SetDrawColor(10, 10, 20, 128)

        surface.SetMaterial(mat_gradient_l)
        surface.DrawTexturedRect(0, 0, w/4, h)

        surface.SetMaterial(mat_gradient_r)
        surface.DrawTexturedRect(w - w/4, 0, w/4, h)

        old_preview_paint(p, w, h)
    end

    for name, _ in pairs(self.Equipped) do
        self.PlayerPreview:AddCostume(name)
    end
end

function PANEL:OnPurchase()
end

function PANEL:OnEquip()
end

function PANEL:OnPurchaseButtonClicked(item)
    if not Shop.IsOwned(self.PreviewItem) then
        self:OnPurchase(item)
    else
        self:OnEquip(item)
    end
end

function PANEL:InitOverlay()
    self.OverlayFrame =
    sui.Build("DPanel", self.PlayerPreview)
        :Dock(FILL)
        :SetMouseInputEnabled(false)
        :Set("Paint", nil)
        :Build()

    self.OverlayCenter =
    sui.Build("DPanel", self.OverlayFrame)
        :Dock(FILL)
        :DockPadding(0, 32, 0, 0)
        :SetSize(200, 200)
        :SetMouseInputEnabled(false)
        :Set("Paint", nil)
        :Build()

    self.Author =
    sui.Build("DLabel", self.OverlayCenter)
        :Dock(BOTTOM)
        :DockPadding(0, 0, 0, 0)
        :SetFont("largeshop")
        :SizeToContents()
        :SetContentAlignment(2)
        :SetExpensiveShadow(1, Color(0, 0, 0))
        :Set("Paint", function(panel, w, h)
            local size = 128
            surface.SetDrawColor(ColorAlpha(SparkWerk.Color.SunrustBlue, 200))
            surface.DrawRect(0, h - size, w, size)
        end)
        :Build()

    self.OverlayTitle =
    sui.Build("DLabel", self.OverlayCenter)
        :Dock(BOTTOM)
        :SetFont("humungoshop")
        :SizeToContents()
        :SetExpensiveShadow(2, Color(0, 0, 0))
        :SetContentAlignment(8)
        :Set("Paint", function(panel, w, h)
            local size = 128
            surface.SetDrawColor(ColorAlpha(SparkWerk.Color.SunrustLightBlue, 200))
            surface.DrawRect(0, h - size, w, size)
        end)
        :Build()

    self.OverlayPrice =
    sui.Build("DPanel", self.OverlayCenter)
        :Dock(TOP)
        :DockPadding(0, 32, 0, 0)
        :SetMouseInputEnabled(false)
        :Build()

    self.PriceDisplay =
    sui.Build("DEmberDisplay", self.OverlayPrice)
        :SetMySize(48)
        :Set("Paint", nil)
        :Build()

    self.OverlayAward =
    sui.BuildCategory(self.OverlayCenter)
        :Dock(TOP)
        :Build()

    self.AwardDisplayMed =
        sui.Build("DLabel", self.OverlayAward)
            :Dock(TOP)
            :SetText("Requires award")
            :SetColor(Color(128,128,128))
            :Set("Paint", function(panel, w, h)
                local size = 128
                surface.SetDrawColor(ColorAlpha(SparkWerk.Color.SunrustLightBlue, 200))
                surface.DrawRect(0, h - size, w, size)
            end)
            :SetFont("smallshop")
            :SetContentAlignment(2)
            :DockPadding(0, 0, 0, 0)
            :SetMouseInputEnabled(false)
            :SizeToContents()
            :Build()

    self.AwardDisplay =
        sui.Build("DLabel", self.OverlayAward)
            :Dock(TOP)
            :SetText("")
            :SetColor(SparkWerk.Color.SunrustOrange)
            :Set("Paint", function(panel, w, h)
                local size = 128
                surface.SetDrawColor(ColorAlpha(SparkWerk.Color.SunrustLightBlue, 200))
                surface.DrawRect(0, h - size, w, size)
            end)
            :SetFont("largeshop")
            :SetContentAlignment(8)
            :SetMouseInputEnabled(false)
            :SizeToContents()
            :Build()

    self.OverlayAward:SetSize(100, 100)
    self.OverlayAward:SetVisible(false)

    self.PurchaseButton =
    sui.Build("DButton", self)
        :SetText("Purchase")
        :SetFont("largeshop")
        :SetMouseInputEnabled(true)
        :SizeToContents()
        :SetContentAlignment(5)
        :SetZPos(1000)
        :SetFocusTopLevel(true)
        :SetVisible(false)
        :Set("DoClick", function(panel)
            self:OnPurchaseButtonClicked(self.PreviewItem)
        end)
        :Set("Paint", function(panel, w, h)
            if panel:IsHovered() then
                draw.RoundedBoxEx(4, 0, 0, w, h, Color(17, 100, 34, 200), true, true, true, true)
            else
                draw.RoundedBoxEx(4, 0, 0, w, h, Color(17, 68, 34, 200), true, true, true, true)
            end
        end)
        :SetColor(Color(0,255,0))
        :Build()
end

function PANEL:PerformLayout()
    self.PlayerPreview:SetSize(self:GetSize())

    self.PriceDisplay:SizeToChildren(true, false)
    local _, ph = self.PriceDisplay:GetSize()
    self.OverlayPrice:SetTall(ph)

    if not self.PreviewItem then
        self:SetPreviewVisible(false)
        return
    end

    self:SetPreviewVisible(true)

    if not Shop.IsOwned(self.PreviewItem) then
        sui.MoveToHorizontalCenter(self.PriceDisplay, self.PriceDisplay:GetParent())
        sui.Edit(self.PriceDisplay)
            :SetVisible(true)
            :SizeToChildren(true, false)

        if Shop.CanPurchaseItem(self.PreviewItem) then
            sui.MoveToVerticalCenter(self.PurchaseButton, self.PriceDisplay)
            sui.Edit(self.PurchaseButton)
                :SetText("Purchase")
                :SetVisible(true)
                :MoveRightOf(self.PriceDisplay, 8)
        else
            self.PurchaseButton:SetVisible(false)
        end
    else
        self.PriceDisplay:SetVisible(false)
        self.OverlayAward:SetVisible(false)
        sui.Edit(self.PurchaseButton)
            :SetVisible(true)
            :SetText("Equip")

        sui.MoveToHorizontalCenter(self.PurchaseButton, self.PriceDisplay:GetParent())
        sui.MoveToVerticalCenter(self.PurchaseButton, self.PriceDisplay:GetParent())
    end
end

function PANEL:SetPreviewVisible(visible)
    self.Author:SetVisible(visible)
    self.OverlayTitle:SetVisible(visible)
    self.PriceDisplay:SetVisible(visible)
    self.PurchaseButton:SetVisible(visible)

    if visible then
        self.OverlayPrice.Paint = function(panel, w, h)
            local size = 100
            surface.SetDrawColor(ColorAlpha(SparkWerk.Color.SunrustLightBlue, 200))
            surface.DrawRect(0, h - size, w, size)
        end
    else
        self.OverlayPrice.Paint = nil
    end
end

function PANEL:SetEquipped(cosname, equipped)
    self.Equipped[cosname] = equipped
    self:InvalidateCostumes()
end

function PANEL:InvalidateCostumes()
    if self.PreviewItem then
        self.PlayerPreview:ResetCostume{self.PreviewItem.cosmetic_name}
    else
        self.PlayerPreview:ResetCostume{}
    end

    for name, equipped in pairs(self.Equipped) do
        if equipped then
            self.PlayerPreview:AddCostume(name)
        end
    end
end

function PANEL:SetPreviewItem(item)
    self.PreviewItem = item
    self:InvalidateCostumes()
    self:InvalidateLayout()

    if item and item.award_lock then
        self.OverlayAward:SetVisible(true)
        self.OverlayAward:SetVisible(item.award_lock_name)
    else
        self.OverlayAward:SetVisible(false)
    end

    if not item then
        return
    end

    self.OverlayTitle:SetText(item.name)

    if item.legendary then
        self.Author:SetText("Legendary Item")
        self.OverlayTitle:SetTextColor(SparkWerk.Color.SunrustOrange)
    else
        self.Author:SetText("")
        self.Author:SetTextColor(Color(255, 255, 255))
        self.OverlayTitle:SetTextColor(Color(255, 255, 255))
    end

    if item.award_lock then
        self.AwardDisplay:SetText(item.award_lock_name)
        if Shop.HaveRequiredAward(item) then
            self.AwardDisplay:SetColor(Color(0, 255, 0))
        else
            self.AwardDisplay:SetColor(SparkWerk.Color.SunrustOrange)
        end
    end

    local price = Shop.GetPrice(item)
    if price then
        self.PriceDisplay:SetAmount(price)
    end

    if Shop.CanAfford(item) then
        self.PriceDisplay:SetColor(Color(0,255,0,255))
    else
        self.PriceDisplay:SetColor(Color(255,0,0,255))
    end

    if not item.author then
        return
    end

    steamworks.RequestPlayerInfo(item.author, function(name)
        if not IsValid(self) or not IsValid(self.Author) then
            return
        end

        sui.Edit(self.Author)
            :SetText("By " .. name)
            :SizeToContents()
            :Center()
            :SetTooltip("Author")
            :Set("DoClick", function(p)
                gui.OpenURL("http://steamcommunity.com/profiles/" .. item.author)
            end)
    end)

    self.Author:SizeToContents()
    self.Author:Center()
end

vgui.Register(Name, PANEL, BaseName)
