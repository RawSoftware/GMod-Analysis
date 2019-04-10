ENT.Type = "anim"  ENT.m_NoNailUnfreeze = true ENT.NoNails = true  ENT.OpenTime = 0.5  AccessorFuncDT(ENT, "OpenStartTime", "Float", 3) AccessorFuncDT(ENT, "CloseStartTime", "Float", 4)  ENT.CanPackUp = true  ENT.IsBarricadeObject = true ENT.AlwaysGhostable = true  ENT.SWEP = "weapon_zs_fridge"  function ENT:SetObjectHealth(health)  self:SetDTFloat(0, health)  if health <= 0 and not self.Destroyed then  self.Destroyed = true  self:FakePropBreak()  end end  function ENT:GetObjectHealth()  return self:GetDTFloat(0) end  function ENT:SetMaxObjectHealth(health)  self:SetDTFloat(1, health) end  function ENT:GetMaxObjectHealth()  return self:GetDTFloat(1) end  function ENT:SetObjectOwner(ent)  self:SetDTEntity(0, ent) end  function ENT:GetObjectOwner()  return self:GetDTEntity(0) end  function ENT:ClearObjectOwner()  self:SetObjectOwner(NULL) end  function ENT:GetOpenedPercent()  if self:IsClosing() then  return 1 - math.Clamp((CurTime() - self:GetCloseStartTime()) / self.OpenTime, 0, 1)  elseif self:IsOpening() then  return math.Clamp((CurTime() - self:GetOpenStartTime()) / self.OpenTime, 0, 1)  else return 0 end end  function ENT:IsOpened()  return self:GetOpenStartTime() ~= 0 and CurTime() >= self:GetOpenStartTime() + self.OpenTime end  function ENT:IsClosed()  return self:GetCloseStartTime() ~= 0 and CurTime() >= self:GetCloseStartTime() + self.OpenTime end  function ENT:IsOpening()  return self:GetOpenStartTime() ~= 0 end  function ENT:IsClosing()  return self:GetCloseStartTime() ~= 0 end 