include("shared.lua")  ENT.NextEmit = 0  local vec_up = vector_up function ENT:Draw()  local owner = self:GetOwner()  if not self:ShouldDrawStatusEffect(owner) then return end       local pos = owner:WorldSpaceCenter()   if CurTime() < self.NextEmit then return end  self.NextEmit = CurTime() + 0.05      local p_type = math.random(2) == 1      local emitter = ParticleEmitter(pos, p_type)     emitter:SetNearClip(24, 32)      local tex = p_type and "effects/fleck_glass"..math.random(3) or "effects/blueflare1"     local particle = emitter:Add(tex, pos + VectorRand()*math.random( 11, 15 ))     particle:SetVelocity( VectorRand() * math.random( 30, 50 ) )     particle:SetDieTime(math.Rand(0.4, 0.8))     particle:SetStartSize((p_type and 1 or 2) * math.Rand(2,4))     particle:SetEndSize(p_type and particle:GetStartSize() or 0 )     particle:SetStartAlpha(240)     particle:SetEndAlpha(0)     particle:SetRoll(math.Rand(0, 360))     particle:SetRollDelta(math.Rand(-90, 90))     particle:SetColor(60, 164, 255)     particle:SetAirResistance(1000)     particle:SetGravity( vec_up * 300 )          emitter:Finish() emitter = nil collectgarbage("step", 64) end 