include("shared.lua")  ENT.NextEmit = 0  function ENT:Draw()  local ent = self:GetOwner()  if not ent:IsValid() then return end   if CurTime() < self.NextEmit then return end  self.NextEmit = CurTime() + 0.1   local emitter = ParticleEmitter(self:GetPos())  emitter:SetNearClip(24, 32)   for i = 1, 10 do  local pos = self:GetPos()  pos.z = pos.z - math.random(10, 60)   local particle = emitter:Add("effects/fire_embers"..math.random(1, 3), pos + VectorRand():GetNormalized() * 14)  particle:SetDieTime(math.Rand(0.4, 0.5))  particle:SetStartSize(3)  particle:SetEndSize(6)  particle:SetStartAlpha(255)  particle:SetEndAlpha(0)  particle:SetGravity(Vector(0, 0, -60))  particle:SetVelocity(ent:GetVelocity() + Vector(0, 0, 30))  particle:SetAirResistance(32)  particle:SetRoll(math.Rand(0, 360))  particle:SetStartLength(5)  particle:SetEndLength(15)  particle:SetColor(255, 255, 160)  particle:SetRollDelta(math.Rand(-1.5, 1.5))  end   emitter:Finish()   self.Owner = ent end  DMGTYPE_FIRE = 1  function ENT:OnRemove()  self.BaseClass.OnRemove(self)   local ent = self.Owner    timer.Simple(0.15, function()  if not IsValid(ent) then return end  local rag = ent.GetRagdollEntity and ent:GetRagdollEntity()  if IsValid(rag) and not rag.Burnt and IsValid(rag:GetPhysicsObject()) then  local phys = rag:GetPhysicsObject()  local effectdata = EffectData()  effectdata:SetOrigin(phys:GetPos())  effectdata:SetEntity(ent)  util.Effect("fire_death", effectdata)  rag:EmitSound("ambient/fire/mtov_flame2.wav", 50, math.random(105, 110))  end  end) end