include("shared.lua") ENT.NextEmit = 0  function ENT:GetPower()  return math.Clamp(self:GetStartTime() + self:GetDuration() - CurTime(), 0, 1) end  function ENT:Draw()  if CurTime() < self.NextEmit then return end  self.NextEmit = CurTime() + 0.1   local owner = self:GetOwner()  if not owner:IsValid() or owner == MySelf and not owner:ShouldDrawLocalPlayer() then return end  local pos = owner:WorldSpaceCenter()    local particle  local emitter = ParticleEmitter(owner:GetPos())    emitter:SetNearClip(12, 16)   local dir = (VectorRand() * 16 + Vector(0, 0, 40)):GetNormal()   particle = emitter:Add("particles/smokey", pos)  particle:SetDieTime(math.Rand(1.3, 1.6))  particle:SetVelocity(Vector(math.random(-16,16), math.random(-16,16), -4))  particle:SetColor(0, 0, 0)  particle:SetAirResistance(10)  particle:SetStartAlpha(230)  particle:SetEndAlpha(200)  particle:SetStartSize(math.random(1, 2))  particle:SetEndSize(0)  particle:SetRoll(math.Rand(0, 360))  particle:SetRollDelta(math.Rand(-8, 8))  particle:SetGravity(Vector(0, 0, -165))  particle:SetBounce(0.3)    emitter:Finish() emitter = nil collectgarbage("step", 64) end