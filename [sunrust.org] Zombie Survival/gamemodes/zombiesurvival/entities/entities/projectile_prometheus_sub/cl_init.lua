include("shared.lua")  ENT.NextEmit = 0  ENT.RenderGroup = RENDERGROUP_TRANSLUCENT  local matGlow = Material("effects/yellowflare")  function ENT:Initialize()  self:DrawShadow(false) end  local matWhite = Material("models/debug/debugwhite") function ENT:Draw()  render.ModelMaterialOverride(matWhite)  render.SuppressEngineLighting(true)     render.SetColorModulation(0.8, 0.5, 0.1)  self:DrawModel()     render.SetColorModulation(1, 1, 1)  render.SuppressEngineLighting(false)  render.ModelMaterialOverride(nil)   local pos = self:GetPos()   render.SetMaterial(matGlow)  render.DrawSprite(pos, 32, 32, Color(170, 100, 0))   local emitter = ParticleEmitter(pos)  emitter:SetNearClip(24, 32)  local particle   for i=0, 1 do  particle = emitter:Add(matGlow, pos)  particle:SetVelocity(VectorRand() * 5)  particle:SetDieTime(0.2)  particle:SetStartAlpha(175)  particle:SetEndAlpha(0)  particle:SetStartSize(5)  particle:SetEndSize(0)  particle:SetRollDelta(math.Rand(-10, 10))  particle:SetColor(255, 155, 55)  end   emitter:Finish() emitter = nil collectgarbage("step", 64) end  function ENT:Think() end function ENT:OnRemove()  local pos = self:GetPos()   sound.Play("weapons/physcannon/energy_sing_explosion2.wav", pos, 65, math.Rand(245, 250))   local emitter = ParticleEmitter(pos)  emitter:SetNearClip(24, 32)  local particle   for i=0,4 do  particle = emitter:Add(matGlow, pos)  particle:SetVelocity(VectorRand() * 5)  particle:SetDieTime(0.2)  particle:SetStartAlpha(255)  particle:SetEndAlpha(0)  particle:SetStartSize(math.Rand(34, 36))  particle:SetEndSize(0)  particle:SetRoll(math.Rand(-0.8, 0.8))  particle:SetRollDelta(math.Rand(-3, 3))  particle:SetColor(255, 155, 55)  end   emitter:Finish() emitter = nil collectgarbage("step", 64) end 