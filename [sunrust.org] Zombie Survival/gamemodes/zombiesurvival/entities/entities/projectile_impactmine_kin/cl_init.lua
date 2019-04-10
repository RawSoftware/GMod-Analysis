include("shared.lua")  local matBeam = Material("trails/physbeam") local matGlow = Material("sprites/glow04_noz") local colBeam = Color(255, 128, 40, 255) local trace = {mask = MASK_SHOT} function ENT:DrawTranslucent()  if not self:IsActive() then return end   local owner = self:GetOwner()  local me_owner = owner == MySelf or MySelf:Team() ~= TEAM_HUMAN   local pos = self:GetStartPos()   render.SetMaterial(matGlow)  render.DrawSprite(pos, 8, 8, colBeam)   if not me_owner then return end   if CurTime() >= self.NextTrace then  self.NextTrace = CurTime() + 0.15   local forward = self:GetUp()  trace.start = pos  trace.endpos = pos + forward * self.Range  trace.filter = self:GetCachedScanFilter()   self.LastPos = util.TraceLine(trace).HitPos  end   local hitpos = self.LastPos  render.SetMaterial(matBeam)  render.DrawBeam(pos, hitpos, 1.3, 0, 1, colBeam)  render.SetMaterial(matGlow)  render.DrawSprite(hitpos, 4, 4, colBeam) end 