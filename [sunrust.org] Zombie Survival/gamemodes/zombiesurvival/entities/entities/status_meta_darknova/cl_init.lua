include("shared.lua")  ENT.NextEmit = 0  function ENT:Draw()  local owner = self:GetOwner()  if not self:ShouldDrawStatusEffect(owner) then return end       local pos = owner:WorldSpaceCenter()   if CurTime() < self.NextEmit then return end  self.NextEmit = CurTime() + 0.15   local emitter = ParticleEmitter(pos)  emitter:SetNearClip(16, 24)   local dir = (VectorRand() * 30 + Vector(0, 0, 30)):GetNormal()   for i = 1, 10 do  local particle = emitter:Add("effects/yellowflare", pos)  particle:SetVelocity(dir * 73)  particle:SetDieTime(math.Rand(1.1, 1.4))  particle:SetStartAlpha(170)  particle:SetEndAlpha(0)  particle:SetStartSize(math.Rand(6, 7))  particle:SetEndSize(12)  particle:SetRoll(math.Rand(0, 360))  particle:SetRollDelta(math.Rand(-5, 5))  particle:SetGravity(Vector(0, 0, 135))  particle:SetBounce(0.45)  particle:SetAirResistance(300)  particle:SetColor(48, 20, 60)  end   emitter:Finish() emitter = nil collectgarbage("step", 64) end 