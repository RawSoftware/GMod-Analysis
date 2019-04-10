local COSMETIC = {}

function COSMETIC:Draw(time_now)
    if self.ParticleSystem then
        self.ParticleSystem:Render()
    end
end

function COSMETIC:SetDraw(draw)
    self.ShouldDraw = draw
    if self.ParticleSystem then
        self.ParticleSystem:SetShouldDraw(draw and self.Alpha == 255)
    end
end

function COSMETIC:SetAlpha(alpha)
    self.Alpha = alpha
    if alpha < 255 then
        self:SetDraw(false)
    else
        self:SetDraw(self.ShouldDraw)
    end
end

function COSMETIC:SetParent(parent, newmodel)
    self:Remove()
    self.ParticleSystem = CreateParticleSystem(parent, self.Properties.Effect, PATTACH_POINT_FOLLOW)
    self.ParticleSystem:SetShouldDraw(self.ShouldDraw)
end

function COSMETIC:Create(owner)
    self.Owner = owner
    self.Alpha = self.Alpha or 255

    if self.ShouldDraw == nil then
        self.ShouldDraw = true
    end

    PrecacheParticleSystem(self.Properties.Effect)
end

function COSMETIC:Remove()
    if self.ParticleSystem then
        self.ParticleSystem:StopEmissionAndDestroyImmediately()
    end
    self.ParticleSystem = nil
end

Cosmetics.RegisterType("effect", COSMETIC)
