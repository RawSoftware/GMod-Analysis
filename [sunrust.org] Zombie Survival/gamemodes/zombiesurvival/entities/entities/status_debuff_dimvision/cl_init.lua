include("shared.lua")  function ENT:GetDim()  local creation_time = self:GetStartTime()  local time = CurTime()  local life_time = self:GetDuration()  local end_time = creation_time + life_time   local time_left = end_time - time  local scalar = math.min(1, time_left / 2)   if time < creation_time + 0.5 then  return math.max(0, (time - creation_time) * 2) * scalar  end   return 1 * scalar end  function ENT:Draw() end