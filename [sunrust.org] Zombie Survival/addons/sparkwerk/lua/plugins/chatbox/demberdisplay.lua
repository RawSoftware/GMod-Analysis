local Name        = "DEmberDisplay"
local BaseName    = "DPanel"
local Description = "Displays given amount of Ember"

local PANEL = {}
PANEL.IconWidth    = 16
PANEL.DefaultColor = SparkWerk.Color.SunrustOrange
PANEL.Color        = PANEL.DefaultColor

local function FontScale(size)
    return math.max(size * (ScrW() / 2560), 8)
end

surface.CreateFont("CurDisp", {
    font = "HalfLife2",
    size = 16.5,
    weight = 900,
    antialias = true,
    shadow = false,
    extended = true,
    outline = false
})

surface.CreateFont("CurDispLarge", {
    font = "HalfLife2",
    size = FontScale(20),
    weight = 900,
    antialias = true,
    shadow = false,
    extended = true,
    outline = false
})

surface.CreateFont("CurDispLarger", {
    font = "HalfLife2",
    size = FontScale(40),
    weight = 900,
    antialias = true,
    shadow = false,
    extended = true,
    outline = false
})

surface.CreateFont("CurDispHuge", {
    font = "HalfLife2",
    size = FontScale(68 + 4),
    weight = 900,
    antialias = true,
    shadow = false,
    extended = true,
    outline = false
})

local sunrust_orange = SparkWerk.Color.SunrustOrange

function PANEL:GetUniqueName()
    return Name .. self.ID
end

local ID = 0

local function NewID()
    ID = ID + 1
    return ID
end

function PANEL:Init()
    self.ID = NewID()
    local self_name = self:GetUniqueName()

    hook.Add("SR.LocalCurrencySet", self_name, function(amt)
        if not IsValid(self) then
            hook.Remove("SR.LocalCurrencySet", self_name)
            return
        end
        self:SetAmountInternal(amt)
    end)

    self.Paint = nil
    self.IconWidth = 16
    self.IconHeight = self.IconWidth

    self.Display =
    sui.Build("DLabel", self)
        :Set("Paint", nil)
        :SetAutoStretchVertical(true)
        :SetToolTip("Your Ember. This is currency you can earn on Sunrust servers. Spend it with the !shop command.")
        :SetMouseInputEnabled(true)
        :DockPadding(0, 0, 0, 0)
        :SetFont("CurDisp")
        :SetText(SparkWerk.GetMyStringCurrency())
        :SetColor(self.DefaultColor)
        :Build()

    self.IconPanel =
    sui.Build("DImage", self)
        :DockPadding(0, 0, 0, 0)
        :SetImage("sparkwerk/ember-16")
        :SetKeepAspect(true)
        :Set("OnToggle", function(panel, visible)
            self.IconPanel:SetVisible(visible)
            self.Display:SetVisible(visible)
        end)
        :Build()

    self:SizeToChildren(true, true)
end

function PANEL:PerformLayout()
    local bx, _ = self.Display:GetPos()

    if not self.Display:IsVisible() then
        bx = 0
    end

    sui.Edit(self.IconPanel)
        :SetSize(self.IconWidth, self.IconHeight)
        :SetPos(bx, 0)

    sui.Edit(self.Display)
        :SetTextInset((self.IconWidth * 1.1) + 2, 0)
        :SizeToContentsX()

    self:SetHeight(self.IconHeight)
    self.Display:CenterVertical()

    self:SizeToChildren(true, true)
end

function PANEL:CenterHorizontal()
    self.Display:CenterHorizontal()
end

function PANEL:SetDisplayVisible(visible)
    self.Display:SetVisible(visible)
end

function PANEL:SetMySize(size)
    local image
    local font

    if size <= 8 then
        image = "sparkwerk/ember-16"
        font = "CurDisp"
    elseif size <= 16 then
        image = "sparkwerk/ember-64"
        font = "CurDispLarge"
    elseif size <= 32 then
        image = "sparkwerk/ember-64"
        font = "CurDispLarger"
    else
        image = "sparkwerk/ember-64"
        font = "CurDispHuge"
    end

    self.IconWidth = (size * ScrH() / 1440)
    self.IconHeight = self.IconWidth * 2

    sui.Edit(self.IconPanel)
        :SetImage(image)
        :SetImageColor(self.DefaultColor)
        :SizeToChildren(true, true)

    sui.Edit(self.Display)
        :SetFont(font)
        :SizeToContents()

    self:InvalidateLayout(true)
end


function PANEL:SetColor(color)
    self.Color = color or self.Color
    self.Display:SetTextColor(self.Color)
end

function PANEL:SetAmountInternal(amt)
    sui.Edit(self.Display)
        :SetText(string_comma_value(amt))
        :SizeToContents()

    self:InvalidateLayout()
end

function PANEL:SetAmount(amt)
    self:SetAmountInternal(amt)
    self.Display:SetToolTip("This is Ember. It is a currency you can earn by playing on Sunrust servers.")
    hook.Remove("SR.LocalCurrencySet", self:GetUniqueName())
end

vgui.Register(Name, PANEL, BaseName)
