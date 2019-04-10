function EFFECT:Think()  return CurTime() < self.DieTime end  function EFFECT:Init(data)  local normal = data:GetNormal() * -1  local pos = data:GetOrigin()   self.DieTime = CurTime() + 1   util.Decal("FadingScorch", pos - normal, pos + normal)   sound.Play("ambient/machines/thumper_hit.wav", pos, 77, 255, 1)   self.Pos = pos  self.Normal = normal  self.Col = Color(35, 10, 58, 255)   local emitter = ParticleEmitter(pos)  emitter:SetNearClip(28, 36)  self.Emitter = emitter    local particles = {}  for i=0, math.Rand(70, 130) do  local heading = VectorRand()   local particle = emitter:Add("effects/yellowflare", pos)  particle:SetVelocity(heading * 600)  particle:SetDieTime(.5)  particle:SetStartAlpha(255)  particle:SetEndAlpha(200)  particle:SetStartSize(math.Rand(48, 64))  particle:SetEndSize(0)  particle:SetRoll(math.Rand(0, 360))  particle:SetRollDelta(math.Rand(-75, 75))  particle:SetAirResistance(400)  particle:SetColor(35, 11, 60)   particles[#particles + 1] = particle  end  emitter:Finish()   self.Particles = particles end  local matGlow = Material("sprites/glow04_noz") local matBeam = Material("Effects/laser1") local dark = Color(95, 20, 110) function EFFECT:Render()  local pos = self.Pos  local normal = self.Normal   local delta = self.DieTime - CurTime()  local spread = 384   local size  if 0.25 < delta then  size = delta * spread  else  size = spread - delta * spread  end   local col = self.Col  col.a = delta * 510   render.SetMaterial(matGlow)  render.DrawQuadEasy(pos, normal, size, size, col)  render.DrawQuadEasy(pos, normal, size, size, col)  render.DrawQuadEasy(pos, normal * -1, size, size, col)  render.DrawQuadEasy(pos, normal * -1, size, size, col)  render.DrawSprite(pos, size, size, col)  render.DrawSprite(pos, size, size, col)    render.SetMaterial(matBeam)   local siz = (self.DieTime - CurTime()) * 24   for i, particle in pairs(self.Particles) do  if particle and math.random(1, 3) == 1 then  render.DrawBeam(particle:GetPos(), pos, siz, 1, 0, dark)  end  end end 