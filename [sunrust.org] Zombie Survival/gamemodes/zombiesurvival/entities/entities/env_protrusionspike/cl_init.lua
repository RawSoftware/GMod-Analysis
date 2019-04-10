include("shared.lua")  function ENT:DrawTranslucent()  local delta = math.max(0, self.DieTime - CurTime())  local size = math.min(1, (0.65 - delta) * 3)  local normal = -self:GetUp()   local icea  if size == 1 then  icea = delta * 0.6  self.Rotation = self.Rotation + FrameTime() * 90  else  icea = 0.8  self.Rotation = self.Rotation + FrameTime() * 220  end  self:SetAngles(Angle(180, self.Rotation, 0))  self:SetModelScale(size*0.6, 0)   if render.SupportsVertexShaders_2_0() then  render.EnableClipping(true)  render.PushCustomClipPlane(normal, normal:Dot(self:GetPos()))  end   render.SetBlend(icea)  self:DrawModel()  render.SetBlend(1)   if render.SupportsVertexShaders_2_0() then  render.PopCustomClipPlane()  render.EnableClipping(false)  end end  function ENT:Initialize()  self:DrawShadow(false)  self.DieTime = CurTime() + 0.75  self.Rotation = math.Rand(0, 360)  self:SetColor(Color(30, 150, 255, 255))  self:SetMaterial("models/shadertest/shader2")      self:EmitSound("physics/glass/glass_largesheet_break"..math.random(1, 3)..".wav", 70, math.random(160, 180))  self:EmitSound("physics/glass/glass_largesheet_break"..math.random(1, 3)..".wav", 70, math.random(160, 180))   local emitter = ParticleEmitter(self:GetPos())  emitter:SetNearClip(40, 48)   local ang = Angle(0,0,0)  local up = Vector(0,0,1)  local pos = self:GetPos()  for i=1, 30 do  ang:RotateAroundAxis(up, 12)  local fwd = ang:Forward()  local particle = emitter:Add("particle/snow", pos + Vector(0, 0, 16) + fwd * 8)  particle:SetVelocity(fwd * 54)  particle:SetAirResistance(-64)  particle:SetDieTime(1.7)  particle:SetLifeTime(1)  particle:SetStartAlpha(30)  particle:SetEndAlpha(0)  particle:SetStartSize(6)  particle:SetEndSize(6)  particle:SetRoll(math.Rand(0, 360))  particle:SetRollDelta(math.Rand(-2, 2))  end  emitter:Finish() emitter = nil collectgarbage("step", 64) end 