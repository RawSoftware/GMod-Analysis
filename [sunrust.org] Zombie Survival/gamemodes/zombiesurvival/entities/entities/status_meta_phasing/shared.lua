ENT.Type = "anim" ENT.Base = "status__base"  ENT.Ephemeral = true  function ENT:Initialize()  self.BaseClass.Initialize(self)   if SERVER then  self:SetDTInt(1, 0)  end      local enty = self  hook.Add("Move", tostring(enty), function(pl, move)         if not IsValid(enty) then return end         if pl ~= enty:GetOwner() then return end          local speed = (CurTime() % 2 <= 0.1) and 12 or 0.6          move:SetMaxSpeed(move:GetMaxSpeed() * speed)         move:SetVelocity(move:GetVelocity():GetNormalized() * move:GetMaxSpeed())         move:SetMaxClientSpeed(move:GetMaxSpeed())     end) end  function ENT:OnRemove()     self.BaseClass.OnRemove(self)      hook.Remove("Move", tostring(self)) end