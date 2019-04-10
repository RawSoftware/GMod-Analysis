function EFFECT:Think()  return false end  function EFFECT:Render() end  local function CollideCallback(particle, hitpos, hitnormal)  if particle:GetDieTime() == 0 then return end  particle:SetDieTime(0)   if math.random(3) == 3 then  sound.Play("physics/flesh/flesh_bloody_impact_hard1.wav", hitpos, 50, math.Rand(95, 105))  end   if math.random(3) == 3 then  util.Decal("Impact.Antlion", hitpos + hitnormal, hitpos - hitnormal)  end end  function EFFECT:Init(data)  local pos = data:GetOrigin()  local normal = data:GetNormal() * -1   local emitter = ParticleEmitter(pos)  emitter:SetNearClip(28, 32)  local grav = Vector(0, 0, -500)  for i = 1, math.random(50, 60) do  particle = emitter:Add("particles/smokey", pos)  particle:SetVelocity(VectorRand():GetNormalized() * math.Rand(64, 128))  particle:SetAirResistance(100)  particle:SetDieTime(math.Rand(1.1, 2))  particle:SetStartAlpha(230)  particle:SetEndAlpha(0)  particle:SetStartSize(math.Rand(1, 2))  particle:SetEndSize(0)  particle:SetRoll(math.Rand(0, 360))  particle:SetRollDelta(math.Rand(-30, 30))  particle:SetColor(0, 150, 0)  particle:SetLighting(false)  particle:SetGravity(grav)  particle:SetBounce(0)  particle:SetCollide(true)  end  emitter:Finish() emitter = nil collectgarbage("step", 64)   util.Decal("YellowBlood", pos + normal, pos - normal)   sound.Play("physics/flesh/flesh_squishy_impact_hard"..math.random(4)..".wav", pos, 80, math.Rand(95, 110)) end 