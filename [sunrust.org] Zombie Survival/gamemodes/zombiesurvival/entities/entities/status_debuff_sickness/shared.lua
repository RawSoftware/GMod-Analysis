AddCSLuaFile()  ENT.Type = "anim" ENT.Base = "status__base"  AccessorFuncDT(ENT, "Duration", "Float", 0) AccessorFuncDT(ENT, "StartTime", "Float", 4)  function ENT:PlayerSet()  self:SetStartTime(CurTime())      local owner = self:GetOwner()     if IsValid(owner) then         owner:ResetStaminaRegen()          self.EndOwner = owner     end end  function ENT:OnRemove()  self.BaseClass.OnRemove(self)      local owner = self.EndOwner     timer.Simple(0, function()         if not IsValid(owner) then return end          owner:ResetStaminaRegen()     end) end