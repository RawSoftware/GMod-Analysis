include("shared.lua")  function ENT:OnRemove()  self:EmitSound("items/suitchargeok1.wav", 75, 111)  self:EmitSound("weapons/slam/mine_mode.wav", 75, 50, 0.5, CHAN_AUTO)   local pos = self:GetPos()  local emitter, particle = ParticleEmitter(pos)  emitter:SetNearClip(12, 16)   for i = 1, 100 do  local axis = Angle(0, i * (360/100), 0)  for j=1, 1 do  local offset = Vector(math.cos(axis.y) * self.Radius, math.sin(axis.y) * self.Radius)   particle = emitter:Add("sprites/glow04_noz", pos + offset)  particle:SetVelocity(self:GetUp() * 355)  particle:SetGravity(Vector(0, 0, -100))  particle:SetColor(205, 160, 40)  particle:SetAirResistance(200)  particle:SetDieTime(1.2)  particle:SetStartAlpha(205)  particle:SetEndAlpha(0)  particle:SetStartSize(math.Rand(6, 10))  particle:SetEndSize(0)  particle:SetRoll(math.Rand(0, 360))  particle:SetRollDelta(math.Rand(-10, 10))  end   particle = emitter:Add("sprites/glow04_noz", pos + VectorRand() * 64)  particle:SetVelocity(VectorRand() * 16)  particle:SetColor(255, 160, 60)  particle:SetDieTime(math.Rand(0.3, 0.4))  particle:SetStartAlpha(55)  particle:SetEndAlpha(0)  particle:SetStartSize(100)  particle:SetEndSize(0)  particle:SetRoll(math.Rand(0, 360))  end  emitter:Finish() emitter = nil collectgarbage("step", 64) end 