ENT.Type = "anim" ENT.Base = "status__base"  ENT.Ephemeral = true  AccessorFuncDT(ENT, "Duration", "Float", 0) AccessorFuncDT(ENT, "StartTime", "Float", 4)  function ENT:PlayerSet()     self:SetStartTime(CurTime()) end  function ENT:Initialize()     self.BaseClass.Initialize(self)      local enty = self     if SERVER then         self:CreateSVHook(enty)          self:SetDTInt(1, 0)     end      if CLIENT then         hook.Add("RenderScreenspaceEffects", tostring(enty), function()             if not IsValid(enty) then return end             if MySelf ~= enty:GetOwner() then return end              local power = enty:GetPower() * 0.1              local time = CurTime() * 5.5             local sharpenpower = power             DrawSharpen(sharpenpower, math.sin(time) * 3)             DrawSharpen(sharpenpower, math.cos(time) * 5)         end)     end end  function ENT:OnRemove()     self.BaseClass.OnRemove(self)      if SERVER then         self:RemoveSVHook(tostring(self))     else         hook.Remove("RenderScreenspaceEffects", tostring(self))     end end