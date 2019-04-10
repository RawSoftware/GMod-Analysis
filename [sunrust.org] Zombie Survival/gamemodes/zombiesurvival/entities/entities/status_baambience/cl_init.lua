include("shared.lua")  ENT.RenderGroup = RENDERGROUP_NONE ENT.NextEmit = 0  function ENT:Initialize()  self:DrawShadow(false)   self.AmbientSound = CreateSound(self, "npc/zombie/moan_loop2.wav")  self.AmbientSound:PlayEx(0.55, 110) end  function ENT:OnRemove()  self.AmbientSound:Stop() end  function ENT:Think()  local owner = self:GetOwner()  if owner.FeignDeath and owner.FeignDeath:IsValid() then  self.AmbientSound:Stop()  else  self.AmbientSound:PlayEx(1, 35 + math.sin(RealTime() * 155) * 5)  end end  local vec_up = vector_up function ENT:Draw()  local owner = self:GetOwner()  if not self:ShouldDrawStatusEffect(owner) then return end       local pos = owner:WorldSpaceCenter()   if CurTime() < self.NextEmit then return end  self.NextEmit = CurTime() + 0.2   local emitter = ParticleEmitter(pos)  local emitter2 = ParticleEmitter(pos, true)  emitter:SetNearClip(16, 24)   local dir = (VectorRand() * 20 + Vector(0, 0, 90)):GetNormal()   local particle = emitter:Add("!sprite_bloodspray"..math.random(8), pos)  for i = 1, 10 do      particle = emitter:Add("!sprite_bloodspray"..math.random(8), pos)  particle:SetVelocity(dir * 93)  particle:SetDieTime(math.Rand(0.7, 1.0))  particle:SetStartAlpha(240)  particle:SetEndAlpha(0)  particle:SetStartSize(math.Rand(6, 7))  particle:SetEndSize(20)  particle:SetRoll(math.Rand(0, 360))  particle:SetRollDelta(math.Rand(-1, 1))  particle:SetGravity(Vector(0, 0, -115))  particle:SetAirResistance(12)  particle:SetColor(150, 40, 40)          particle = emitter2:Add("effects/fleck_glass"..math.random(3), pos + VectorRand()*math.random( 14, 20 ))         particle:SetVelocity( VectorRand() * math.random( 90, 110 ) )         particle:SetDieTime(math.Rand(0.9, 0.8))         particle:SetStartSize(5)         particle:SetEndSize( particle:GetStartSize() )         particle:SetStartAlpha(240)         particle:SetEndAlpha(0)         particle:SetRoll(math.Rand(0, 360))         particle:SetRollDelta(math.Rand(-90, 90))         particle:SetColor(115, 0, 0)         particle:SetAirResistance(1000)         particle:SetGravity( vec_up * 100 )  end   emitter:Finish() emitter = nil  emitter2:Finish() emitter2 = nil collectgarbage("step", 64) end 