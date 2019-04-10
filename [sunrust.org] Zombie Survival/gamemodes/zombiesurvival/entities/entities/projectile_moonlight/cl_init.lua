include("shared.lua")  local matGlow2 = Material("sprites/glow04_noz") local matWhite = Material("models/debug/debugwhite") local vector_origin = vector_origin  function ENT:Draw()  local pos = self:GetPos()   render.ModelMaterialOverride(matWhite)  render.SetColorModulation(0.6, 0.2, 0.2)     render.SetColorModulation(1, 1, 1)  render.ModelMaterialOverride(nil)   local emitter = ParticleEmitter(pos)  emitter:SetNearClip(24, 32)  local particle  for i=0, 5 do  pos = pos + self:GetAngles():Right() * math.random(20, -20)   particle = emitter:Add(matGlow2, pos)  particle:SetVelocity(VectorRand() * 15)  particle:SetDieTime(0.3)  particle:SetStartAlpha(255)  particle:SetEndAlpha(0)  particle:SetStartSize(20)  particle:SetEndSize(0)  particle:SetRollDelta(math.Rand(-10, 10))  particle:SetColor(120, 200, 195)  end  emitter:Finish() emitter = nil collectgarbage("step", 64)   if self:GetVelocity() ~= vector_origin then  render.SetMaterial(matGlow2)  render.DrawSprite(pos, 165, 16, Color(80, 190, 175, 100))  render.DrawSprite(pos, 165, 16, Color(120, 230, 185, 100))  end end  function ENT:OnRemove()  local pos = self:GetPos()   local emitter = ParticleEmitter(pos)  emitter:SetNearClip(24, 32)  local particle  for i=0, 15 do  particle = emitter:Add(matGlow2, pos)  particle:SetVelocity(VectorRand() * 225)  particle:SetDieTime(0.7)  particle:SetStartAlpha(255)  particle:SetEndAlpha(0)  particle:SetStartSize(math.Rand(7, 9))  particle:SetEndSize(0)  particle:SetRoll(math.Rand(-0.8, 0.8))  particle:SetRollDelta(math.Rand(-3, 3))  particle:SetColor(120, 230, 185)  end  for i=0,5 do  particle = emitter:Add(matGlow2, pos)  particle:SetVelocity(VectorRand() * 5)  particle:SetDieTime(0.6)  particle:SetStartAlpha(255)  particle:SetEndAlpha(0)  particle:SetStartSize(math.Rand(127, 129))  particle:SetEndSize(0)  particle:SetRoll(math.Rand(-0.8, 0.8))  particle:SetRollDelta(math.Rand(-3, 3))  particle:SetColor(120, 230, 185)  end  for i=1, 75 do  particle = emitter:Add("effects/splash2", pos)  particle:SetDieTime(1.2)  particle:SetColor(120, 230, 185)  particle:SetStartAlpha(255)  particle:SetEndAlpha(0)  particle:SetStartSize(5)  particle:SetEndSize(0)  particle:SetStartLength(1)  particle:SetEndLength(15)  particle:SetVelocity(VectorRand():GetNormal() * 160)  end  emitter:Finish() emitter = nil collectgarbage("step", 64) end 