include("shared.lua")  ENT.NextEmit = 0 ENT.DoEmit = false  function ENT:Initialize()  self.AmbientSound = CreateSound(self, "ambient/machines/gas_loop_1.wav") end  function ENT:Think()  if self.DoEmit then  self.DoEmit = false  end   self.AmbientSound:PlayEx(0.60, 250 + CurTime() % 1) end  function ENT:OnRemove()  self.AmbientSound:Stop() end  function ENT:Draw()  local time = CurTime()  local pos = self:GetPos()   if time < self.NextEmit then return end  self.NextEmit = time + 0.15  self.DoEmit = true   local particle  local emitter = ParticleEmitter(pos)  emitter:SetNearClip(12, 16)   local type = self:GetDTInt(0)   if type == 0 then  for i=1, 2 do  particle = emitter:Add("effects/fire_cloud"..math.random(1, 2), pos + VectorRand() * 3)  particle:SetColor(145, 100, 80)  particle:SetDieTime(math.Rand(1.25, 1.8))  particle:SetVelocity(VectorRand() * 20)  particle:SetStartAlpha(52)  particle:SetEndAlpha(0)  particle:SetStartSize(0)  particle:SetEndSize(math.Rand(11, 12))  particle:SetRoll(math.Rand(0, 360))  end  elseif type == 1 then  for i=1, 8 do  particle = emitter:Add("sprites/glow04_noz", pos + VectorRand() * 22)  particle:SetColor(160, 130, 250)  particle:SetDieTime(math.Rand(0.01, 0.2))  particle:SetVelocity(VectorRand() * 10)  particle:SetStartAlpha(200)  particle:SetEndAlpha(0)  particle:SetStartSize(math.Rand(5, 6))  particle:SetEndSize(math.Rand(0, 1))  particle:SetRoll(math.Rand(0, 360))  particle:SetStartLength(0)  particle:SetEndLength(15)  end  elseif type == 2 then  for i=1, 6 do  particle = emitter:Add("particles/smokey", pos + VectorRand() * 22)  particle:SetColor(150, 190, 250)  particle:SetDieTime(math.Rand(0.05, 0.2))  particle:SetVelocity(VectorRand() * 10)  particle:SetStartAlpha(200)  particle:SetEndAlpha(0)  particle:SetStartSize(math.Rand(5, 6))  particle:SetEndSize(math.Rand(0, 1))  particle:SetRoll(math.Rand(0, 360))  particle:SetStartLength(0)  particle:SetEndLength(15)  end  end   emitter:Finish() emitter = nil collectgarbage("step", 64) end 