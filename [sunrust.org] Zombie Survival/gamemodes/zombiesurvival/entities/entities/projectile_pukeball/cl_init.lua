include("shared.lua")  ENT.NextEmit = 0  function ENT:Initialize()  self:SetColor(Color(140, 250, 0, 255))  self:SetModelScale(3, 0)  self:SetMaterial("Models/Barnacle/barnacle_sheet")   for i = 1, 15 do  local emitter = ParticleEmitter(self:GetPos())  emitter:SetNearClip(16, 24)   local particle = emitter:Add("!sprite_bloodspray"..math.random(8), self:GetPos())  particle:SetVelocity(VectorRand():GetNormalized() * math.Rand(140, 150))  particle:SetDieTime(1)  particle:SetStartAlpha(230)  particle:SetEndAlpha(0)  particle:SetStartSize(25)  particle:SetEndSize(0)  particle:SetRoll(math.Rand(0, 360))  particle:SetColor(155, 255, 30)   emitter:Finish() emitter = nil collectgarbage("step", 64)  end end  function ENT:Draw()  self:DrawModel()   if CurTime() >= self.NextEmit then  self.NextEmit = CurTime() + 0.03   local emitter = ParticleEmitter(self:GetPos())  emitter:SetNearClip(16, 24)   local particle = emitter:Add("!sprite_bloodspray"..math.random(8), self:GetPos())  particle:SetVelocity(VectorRand():GetNormalized() * math.Rand(12, 36))  particle:SetDieTime(3)  particle:SetStartAlpha(230)  particle:SetEndAlpha(0)  particle:SetStartSize(10)  particle:SetEndSize(0)  particle:SetRoll(math.Rand(0, 360))  particle:SetRollDelta(math.Rand(-25, 25))  particle:SetColor(95, 155, 30)   emitter:Finish() emitter = nil collectgarbage("step", 64)  end end 