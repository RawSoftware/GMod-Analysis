local COSMETIC = {}

function COSMETIC:ApplyToEntity(entity, size)
    if not entity then
        return
    end

    local bone_correction = Cosmetics.GetCorrection(entity, self.Properties.Bone)
    local bone = Cosmetics.BoneShort[self.Properties.Bone or "head"]

    if bone_correction then
        bone = bone_correction.name or bone
    end

    local boneid
    if bone then
        boneid = entity:LookupBone(bone)
    end

    if boneid then
        entity:ManipulateBoneScale(boneid, size * Vector(1, 1, 1))
    end
end

function COSMETIC:SetDraw(draw)
    local size = draw and self.Properties.Size or 1
    self:ApplyToEntity(self.Parent, size)
end

function COSMETIC:SetAlpha(alpha)
end

function COSMETIC:SetParent(parent, newmodel)
    self:ApplyToEntity(parent, self.Properties.Size)
    self.Parent = parent
end

function COSMETIC:Create(owner)
end

function COSMETIC:Remove()
    if self.Parent then self:ApplyToEntity(self.Parent, 1) end
end

--Cosmetics.RegisterType("bone", COSMETIC)
