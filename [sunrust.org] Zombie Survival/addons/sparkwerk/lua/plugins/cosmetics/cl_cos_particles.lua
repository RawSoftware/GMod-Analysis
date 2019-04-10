local COSMETIC = {}

COSMETIC.CosmeticAlpha = 255
COSMETIC.DefaultProperties = {
    DieTime = 3,
    StartSize = 2,
    EndSize = 20,
    NoDraw = false,
    Color1 = Color(255, 255, 255),
    Color2 = Color(255, 255, 255),
    RandomColor = false,
    AirResistance = 5,
    Gravity = Vector(0, 0, -50),
    Collide = true,
    Velocity = 250,
    StartAlpha = 255,
    EndAlpha = 0,
    RandomRollSpeed = 0,
    StartLength = 0,
    EndLength = 0,
    PositionSpread = 0,
    Position = Vector(0, 0, 0),
    Spread = 0.1,
    Material = "",
    RollDelta = 0,
    ParticleAngle = Angle(0, 0, 0),
    Angles = Angle(0, 0, 0),
    NumberParticles = 1,
    FireDelay = 2
}

function COSMETIC:SetDraw(draw)
    if IsValid(self.CosmeticEmitter) then
        self.CosmeticEmitter:SetNoDraw(not draw)
    end
end

function COSMETIC:SetAlpha(alpha)
    self.CosmeticAlpha = alpha
end

function COSMETIC:SetParent(parent, newmodel)
    self.CosmeticParent = parent
end

function COSMETIC:EmitParticles(pos, ang)
    local cosmetic_alpha = self.CosmeticAlpha < 255 and 0 or 1

    -- a bunch of this logic was taken directly from pac3 code with minor changes
    for _ = 1, self.NumberParticles do
        local part = self.CosmeticEmitter:Add(self.Material, pos)
        if part then
            if self.PositionSpread ~= 0 then
                local p, y, r = math.Rand(-180, 180),
                                math.Rand(-180, 180),
                                math.Rand(-180, 180)
                pos = pos + Angle(p, y, r):Forward() * self.PositionSpread
            end

            local color
            local color1 = self.Color1
            if self.RandomColor then
                local color2 = self.Color2
                color = {
                    math.random(math.min(color1.r, color2.r), math.max(color1.r, color2.r)),
                    math.random(math.min(color1.g, color2.g), math.max(color1.g, color2.g)),
                    math.random(math.min(color1.b, color2.b), math.max(color1.b, color2.b))
                }
            else
                color = {color1.r, color1.g, color1.b}
            end

            local spread_component = Vector(0)
            local spread = self.Spread or 0.1
            if spread ~= 0 then
                spread_component = Vector(
                    math.sin(math.Rand(0, 360)) * math.Rand(-spread, spread),
                    math.cos(math.Rand(0, 360)) * math.Rand(-spread, spread),
                    math.sin(math.random()) * math.Rand(-spread, spread)
                )
            end

            local roll_delta = self.RollDelta
            local roll = roll_delta + math.Rand(-roll_delta, roll_delta)

            part:SetDieTime(self.DieTime)
            part:SetStartSize(self.StartSize)
            part:SetEndSize(self.EndSize)
            part:SetColor(unpack(color))
            part:SetAirResistance(self.AirResistance)
            part:SetGravity(self.Gravity)
            part:SetCollide(self.Collide)
            part:SetVelocity((ang + spread_component) * self.Velocity)
            part:SetStartAlpha(self.StartAlpha * cosmetic_alpha)
            part:SetEndAlpha(self.EndAlpha * cosmetic_alpha)
            part:SetRoll(self.RandomRollSpeed * 36)
            part:SetRollDelta(roll)
            part:SetPos(pos)
            part:SetStartLength(self.StartLength)
            part:SetEndLength(self.EndLength)
            part:SetAngles(part:GetAngles() + ang:Angle() + self.ParticleAngle)
        end
    end
end

local pos_0 = Vector(0, 0, 0)
local ang_0 = Angle(0, 0, 0)

function COSMETIC:Draw(time_now)
    time_now = time_now or CurTime()
    if not IsValid(self.CosmeticEmitter) then return end
    local pos = self.CosmeticParent:GetPos() + self.Position
    local ang = Vector(0, 1, 0)
    ang:Rotate(self.Angles)
    ang:Rotate(self.CosmeticParent:GetAngles())

    if self.Follow and false then
        cam.Start3D(WorldToLocal(EyePos(), EyeAngles(), pos, ang:Angle()))
            self.CosmeticEmitter:Draw()
        cam.End3D()

        pos = pos_0
        ang = pos_0
    elseif self.ManualDraw then
        self.CosmeticEmitter:Draw()
    end

    if self.NextEmission <= time_now then
        self:EmitParticles(pos, ang)
        self.NextEmission = time_now + self.FireDelay
    end
end

local components = {}
hook.Add("PostDrawEffects", "CosmeticsParticleDriver", function()
    local now = CurTime()
    for i = 1, #components do
        components[i]:Draw(now)
    end
end)

function COSMETIC:Create(owner)
    self.CosmeticsOwner = owner

    self.CosmeticEmitter = ParticleEmitter(self.CosmeticsOwner:GetPos(), false)
    self.CosmeticEmitter:SetNoDraw(false)
    self.NextEmission = 0

    local ownerinfo = owner.HatInfo and owner:HatInfo() or {}
    local nodraw = ownerinfo.CosmeticsNoDraw or false
    local alpha = ownerinfo.CosmeticsAlpha or 255

    if nodraw then
        self.CosmeticsNoDraw = true
    end

    self:SetAlpha(alpha)
    table.insert(components, self)
end

function COSMETIC:Remove()
    if IsValid(self.CosmeticEmitter) then
        self.CosmeticEmitter:Finish()
    end

    self.CosmeticEmitter = nil
    table.RemoveByValue(components, self)
end

Cosmetics.RegisterType("particles", COSMETIC)
