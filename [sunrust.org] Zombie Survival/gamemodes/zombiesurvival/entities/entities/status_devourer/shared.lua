ENT.Type = "anim" ENT.Base = "status__base"  ENT.TurnDuration = 0.5  function ENT:Initialize()  self.BaseClass.Initialize(self)   self.Created = CurTime()   local enty = self  if CLIENT then  hook.Add("CreateMove", tostring(enty), function(cmd)  if not IsValid(enty) or not IsValid(enty:GetPuller()) then return end  if MySelf ~= enty:GetOwner() then return end   if CurTime() - enty.Created <= enty.TurnDuration then  local ft = FrameTime() * 720   local ang = cmd:GetViewAngles()  local newang = (enty:GetPuller():EyePos() - MySelf:EyePos()):Angle()  newang:Normalize()   ang.pitch = math.Approach(ang.pitch, newang.pitch, ft)  ang.yaw = math.Approach(ang.yaw, newang.yaw, ft)  cmd:SetViewAngles(ang)  end  end)  end      timer.Simple(0, function()         self:GetOwner().PostMoveChecks = true     end)       hook.Add("PostMove", tostring(enty), function(pl, move)  if not IsValid(enty) or not IsValid(enty:GetPuller()) then return end  if pl ~= enty:GetOwner() then return end   local puller = enty:GetPuller()  if CurTime() - enty.Created > enty.TurnDuration then  move:SetMoveAngles((puller:GetPos() - pl:GetPos()):Angle())  move:SetMaxSpeed(1250)  move:SetMaxClientSpeed(1250)  move:SetForwardSpeed(100000000)  move:SetSideSpeed(0)  if not pl:OnGround() then  move:SetVelocity(((puller:GetShootPos() + puller:GetAimVector() * 50) - pl:WorldSpaceCenter()):GetNormalized() * 1250)  end  else  move:SetMaxSpeed(1)  move:SetMaxClientSpeed(1)  end  end)   hook.Add("OnPlayerHitGround", tostring(enty), function(pl, inwater, hitfloater, speed)  if IsValid(enty) and IsValid(enty:GetPuller()) and pl == enty:GetOwner() then return true end  end) end  function ENT:OnRemove()  self.BaseClass.OnRemove(self)   local owner = self:GetOwner()     owner.PostMoveChecks = false  if SERVER then  owner:AddLegDamage(16)  owner:SetLocalVelocity(Vector(0))  owner:SetStepSize(self.StepSize or 18)  end   if CLIENT then hook.Remove("CreateMove", tostring(self)) end  hook.Remove("PostMove", tostring(self))  hook.Remove("OnPlayerHitGround", tostring(self)) end  function ENT:SetDamage(damage)  self:SetDTFloat(0, math.min(100, damage)) end  function ENT:GetDamage()  return self:GetDTFloat(0) end  function ENT:SetPuller(puller)  self:SetDTEntity(0, puller) end  function ENT:GetPuller()  return self:GetDTEntity(0) end 