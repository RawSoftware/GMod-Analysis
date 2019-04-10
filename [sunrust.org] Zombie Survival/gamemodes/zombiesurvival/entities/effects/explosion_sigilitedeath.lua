function EFFECT:Init(data)  local pos = data:GetOrigin()  local norm = data:GetNormal() * -1  sound.Play("physics/concrete/concrete_break"..math.random(2,3)..".wav", pos, 85, math.Rand(80, 95))   local emitter, particle = ParticleEmitter(pos)  emitter:SetNearClip(16, 24)   for i=1, 6 do  particle = emitter:Add("particles/smokey", pos)  particle:SetVelocity(VectorRand():GetNormal() * 190)  particle:SetDieTime(math.Rand(0.7, 0.85))  particle:SetStartAlpha(math.Rand(50, 70))  particle:SetStartSize(math.Rand(80,96))  particle:SetEndSize(math.Rand(164, 168))  particle:SetRoll(math.Rand(-360, 360))  particle:SetRollDelta(math.Rand(-4.5, 4.5))  particle:SetColor(255, 255, 255)  end  for i=1, 12 do  particle = emitter:Add("particles/smokey", pos)  particle:SetVelocity(VectorRand():GetNormal() * 240)  particle:SetDieTime(math.Rand(0.3, 0.6))  particle:SetStartAlpha(math.Rand(90, 110))  particle:SetStartSize(1)  particle:SetEndSize(math.Rand(118, 150))  particle:SetRoll(math.Rand(-360, 360))  particle:SetRollDelta(math.Rand(-4.5, 4.5))  particle:SetColor(40, 160, 255)  end   emitter:Finish() emitter = nil collectgarbage("step", 64)   local random_props = {  "models/props_wasteland/rockcliff01f.mdl",  "models/props_wasteland/rockcliff01c.mdl",  "models/props_wasteland/rockgranite02c.mdl"  }   local maxbound = Vector(3, 3, 3)  local minbound = maxbound * -1  for i=1, math.random(8,12) do  local dir = VectorRand() * 5  dir.z = dir.z * 5  dir:Normalize()   local ent = ClientsideModel(table.Random(random_props), RENDERGROUP_OPAQUE)  if ent:IsValid() then  ent:SetModelScale(math.Rand(0.1, 0.3), 0)  ent:SetMaterial("models/props_wasteland/concretewall064b")  ent:SetColor(Color(60, 164, 255, 255))  ent:SetPos(pos + dir * 6)  ent:PhysicsInitBox(minbound, maxbound)  ent:SetCollisionBounds(minbound, maxbound)   local phys = ent:GetPhysicsObject()  if phys:IsValid() then  phys:SetMaterial("rock")  phys:ApplyForceCenter(dir * math.Rand(1200, 1500))  end   SafeRemoveEntityDelayed(ent, math.Rand(4, 8))  end  end end  function EFFECT:Think()  return false end  function EFFECT:Render() end 