include("shared.lua")  ENT.NextEmit = 0  function ENT:Initialize()  self:DrawShadow(false)   self.Size = math.Rand(25, 32) end  local colFlesh = Color(235, 30, 30, 255) local matFlesh = Material("zombiesurvival/blueblood2") function ENT:Draw()  local size = self.Size   render.SetMaterial(matFlesh)  local pos = self:GetPos()  render.DrawSprite(pos, size, size, colFlesh)   if CurTime() < self.NextEmit then return end  self.NextEmit = CurTime() + 0.05   local emitter = ParticleEmitter(pos)  emitter:SetNearClip(36, 44)   local particle = emitter:Add("!sprite_bloodspray"..math.random(8), pos + VectorRand():GetNormalized() * math.Rand(1, 4))  particle:SetVelocity(VectorRand():GetNormalized() * math.Rand(1, 4))  particle:SetDieTime(math.Rand(0.9, 1.1))  particle:SetStartAlpha(255)  particle:SetEndAlpha(255)  particle:SetStartSize(size * math.Rand(0.17, 0.23))  particle:SetEndSize(0)  particle:SetRoll(math.Rand(0, 360))  particle:SetRollDelta(math.Rand(-4, 4))  particle:SetColor(135, 30, 60)   emitter:Finish() emitter = nil collectgarbage("step", 64) end 