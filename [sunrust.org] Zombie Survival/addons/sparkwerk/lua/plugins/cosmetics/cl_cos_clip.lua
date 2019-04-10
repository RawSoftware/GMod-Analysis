local COSMETIC = {}

function COSMETIC:Draw()
end

function COSMETIC:SetDraw(draw)
end

function COSMETIC:SetAlpha(alpha)
end

function COSMETIC:SetParent(parent, newmodel)
    if not IsValid(parent) then return end
    if self.SetupClipPlane then return end
    if not parent.HatTable then return end

    parent.HatTable:AddClipPlane(self.Properties.Position or Vector(0,0,0),
                                 self.Properties.Angles or Angle(0,0,0))

    self.SetupClipPlane = true
end

function COSMETIC:Create(owner)
    self.Owner = owner
end

function COSMETIC:Remove()
    self.SetupClipPlane = false
end

Cosmetics.RegisterType("clip", COSMETIC)
