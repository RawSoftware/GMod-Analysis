include("shared.lua")  ENT.NextEmit = 0  local matGlow = Material("sprites/light_glow02_add")  function ENT:Initialize()  local pos = self:GetPos()  pos.z = pos.z + 32   local emitter = ParticleEmitter(pos)  emitter:SetNearClip(24, 32)  local particle   for i=0,2 do  particle = emitter:Add(matGlow, pos)  particle:SetVelocity(VectorRand() * 5)  particle:SetDieTime(0.2)  particle:SetStartAlpha(255)  particle:SetEndAlpha(0)  particle:SetStartSize(math.Rand(87, 89))  particle:SetEndSize(0)  particle:SetRoll(math.Rand(-0.8, 0.8))  particle:SetRollDelta(math.Rand(-3, 3))  particle:SetColor(245, 65, 60)  end   emitter:Finish() emitter = nil collectgarbage("step", 64)   self.BaseClass.Initialize(self) end  local radius = 6 function ENT:Draw()  local owner = self:GetOwner()  if not self:ShouldDrawStatusEffect(owner) then return end   if CurTime() < self.NextEmit then return end  self.NextEmit = CurTime() + 0.1   local pos = owner:WorldSpaceCenter()  pos.z = pos.z + 48   local emitter = ParticleEmitter(pos)  emitter:SetNearClip(16, 24)   for i = 1, 33 do         local axis = Angle(0, i * (360/33), 0)         local offset = Vector(math.cos(axis.y) * radius, math.sin(axis.y) * radius)   particle = emitter:Add("sprites/light_glow02_add", pos + offset)  particle:SetDieTime(0.2)  particle:SetStartAlpha(230)  particle:SetEndAlpha(0)  particle:SetStartSize(1)  particle:SetEndSize(0)  particle:SetGravity(Vector(0, 0, -1))  particle:SetAirResistance(300)  particle:SetStartLength(11)  particle:SetEndLength(12)  particle:SetColor(255, 30, 30)  end   emitter:Finish() emitter = nil collectgarbage("step", 64) end 