AddCSLuaFile()  ENT.Type = "anim" ENT.Base = "status__base"  AccessorFuncDT(ENT, "Duration", "Float", 0) AccessorFuncDT(ENT, "StartTime", "Float", 4)  function ENT:Initialize()  self.BaseClass.Initialize(self)   self.Seed = math.Rand(0, 10)      if CLIENT and MySelf and IsValid(self) and IsValid(self:GetOwner()) or SERVER then      self:GetOwner().SpawnProtection = true     end end  function ENT:PlayerSet(pl)  if CLIENT and MySelf and IsValid(self) and IsValid(pl) or SERVER then      pl.SpawnProtection = true          self:SetStartTime(CurTime())     end end  function ENT:OnRemove()  self.BaseClass.OnRemove(self)   self:GetOwner().SpawnProtection = false  self:GetOwner().SpawnedFromGas = CurTime() + 1.75 end  function ENT:SetDie(fTime)  if fTime == 0 or not fTime then  self.DieTime = 0  elseif fTime == -1 then  self.DieTime = 999999999  elseif self.DieTime < CurTime() + fTime then  self.DieTime = CurTime() + fTime         self:SetDuration(fTime)  end end 