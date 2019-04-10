function EFFECT:Think()  return false end  function EFFECT:Render() end  local function CollideCallback(particle, hitpos, hitnormal)  if particle:GetDieTime() == 0 then return end   if math.random(3) == 3 then  sound.Play("physics/flesh/flesh_squishy_impact_hard"..math.random(4)..".wav", hitpos, 50, math.Rand(75, 80))  end    if math.random(3) == 3 then  util.Decal("Decal.Gunk", hitpos + hitnormal, hitpos - hitnormal)  end end  function EFFECT:Init(data)  local pos = data:GetOrigin()  local normal = data:GetNormal() * -1   local emitter = ParticleEmitter(pos)  emitter:SetNearClip(28, 32)  local grav = Vector(0, 0, -500)  for i=1, math.random(7, 10) do  local particle = emitter:Add("particles/smokey", pos)  particle:SetDieTime(math.Rand(2,3.5))  particle:SetVelocity(VectorRand():GetNormalized() * math.Rand(100, 120))  particle:SetColor(20, 20, 20)  particle:SetAirResistance(10)  particle:SetStartAlpha(255)  particle:SetEndAlpha(255)  particle:SetStartSize(math.Rand(1.5,2.5))  particle:SetEndSize(0)  particle:SetRoll(math.Rand(0, 360))  particle:SetRollDelta(math.Rand(-1, 1))  particle:SetGravity(grav)  particle:SetCollide(true)  particle:SetBounce(0.5)  particle:SetCollideCallback(CollideCallback)  end     emitter:Finish() emitter = nil collectgarbage("step", 64)  util.Decal("Decal.Gunk", pos + normal, pos - normal)   sound.Play("physics/flesh/flesh_squishy_impact_hard"..math.random(4)..".wav", pos, 80, math.Rand(75, 80)) end