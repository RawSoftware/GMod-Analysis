ENT.Type = "anim" ENT.Base = "status__base"  ENT.DamagePerTick = 3  function ENT:Initialize()  self:DrawShadow(false)  if self:GetDTFloat(1) == 0 then  self:SetDTFloat(1, CurTime())  end  end  function ENT:AddDamage(damage, attacker)  self:SetDamage(self:GetDamage() + damage)  if SERVER and attacker then  self.Attackers[attacker] = (self.Attackers[attacker] or 0) + damage  end end  function ENT:SetDamage(damage)  self:SetDTFloat(0, math.min(500, damage)) end  function ENT:SetHitPos(vHitPos)  self:SetDTVector(0, vHitPos) end  function ENT:SetHitNormal(vHitNormal)  self:SetDTVector(1, vHitNormal) end  function ENT:GetDamage()  return self:GetDTFloat(0) end  function ENT:GetHitPos()  return self:GetDTVector(0) end  function ENT:GetHitNormal(vHitNormal)  return self:GetDTVector(1) end 