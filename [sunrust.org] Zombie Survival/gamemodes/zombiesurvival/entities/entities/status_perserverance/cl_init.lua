include("shared.lua")  ENT.NextEmit = 0  function ENT:Draw()  local owner = self:GetOwner()  if not self:ShouldDrawStatusEffect(owner) then return end   if CurTime() < self.NextEmit then return end  self.NextEmit = CurTime() + 0.3   local pos = owner:WorldSpaceCenter()   local emitter = ParticleEmitter(pos)  emitter:SetNearClip(16, 24)   for i = 1, 5 do  particle = emitter:Add("sprites/light_glow02_add", pos + VectorRand() * 12)  particle:SetDieTime(math.Rand(1.1, 1.2))  particle:SetStartAlpha(230)  particle:SetEndAlpha(0)  particle:SetStartSize(5)  particle:SetEndSize(0)  particle:SetGravity(Vector(0, 0, 75))  particle:SetAirResistance(300)  particle:SetStartLength(36)  particle:SetEndLength(0)  particle:SetColor(200, 200, 200)  end   emitter:Finish() emitter = nil collectgarbage("step", 64) end  function ENT:GetPower()  return math.Clamp(self:GetStartTime() + self:GetDuration() - CurTime(), 0, 1.5) end