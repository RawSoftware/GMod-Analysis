include("shared.lua")  ENT.RenderGroup = RENDERGROUP_TRANSLUCENT  ENT.NextEmit = 0  function ENT:Initialize()  self:DrawShadow(false)   self.AmbientSound = CreateSound(self, "npc/combine_gunship/gunship_moan.wav")  self.AmbientSound:PlayEx(0.55, 55) end  function ENT:OnRemove()  self.AmbientSound:Stop() end  function ENT:Think()  local owner = self:GetOwner()  if owner:IsValid() then  self.AmbientSound:PlayEx(1, 145 + math.sin(RealTime() * 150) * 35)  end end  function ENT:Draw()  local owner = self:GetOwner()  if not self:ShouldDrawStatusEffect(owner) then return end   local pos = owner:WorldSpaceCenter()  pos.z = pos.z - 55   if CurTime() < self.NextEmit then return end   self.NextEmit = CurTime() + 0.04   local emitter = ParticleEmitter(pos)  emitter:SetNearClip(16, 24)   for i=1, 2 do  local particle = emitter:Add("!sprite_bloodspray"..math.random(8), pos + VectorRand() * 5)  particle:SetDieTime(1)  particle:SetColor(155,11,11)  particle:SetStartAlpha(255)  particle:SetEndAlpha(0)  particle:SetStartSize(math.random(8, 14))  particle:SetEndSize(0)  particle:SetVelocity(vector_origin)  particle:SetGravity(VectorRand() * 20 + Vector(0, 0, -600))  particle:SetAirResistance(12)  particle:SetCollide(true)  end   emitter:Finish() emitter = nil collectgarbage("step", 64) end 