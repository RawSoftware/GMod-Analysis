include("shared.lua")  ENT.LastPos = Vector(0, 0, 0) ENT.NextTrace = 0  function ENT:SetObjectHealth(health)  self:SetDTFloat(3, health) end  function ENT:SetObjectOwner(ent)  self:SetDTEntity(1, ent) end  local matBeam = Material("trails/laser") local colBeam = Color(255, 0, 0, 255) local matGlow = Material("sprites/glow04_noz") local trace = {mask = MASK_SHOT} local render_SetBlend = render.SetBlend function ENT:Draw()  if MySelf and MySelf:Team() == TEAM_UNDEAD then  local dist = EyePos():DistToSqr(self:GetPos())  if dist > 15000 then return end   render_SetBlend(math.Clamp(1 - dist / 7500, 0, 1))   self:DrawModel()   render_SetBlend(1)  else  self:DrawModel()  if MySelf == self:GetObjectOwner() and MySelf:Team() == TEAM_HUMAN then  local pos = self:WorldSpaceCenter() - self:GetUp() * 5  if CurTime() >= self.NextTrace then  self.NextTrace = CurTime() + 0.15   local forward = self:GetForward()  trace.start = pos  trace.endpos = trace.start + self:GetForward() * self.Range  trace.filter = self:GetCachedScanFilter()   self.LastPos = util.TraceLine(trace).HitPos  end   local hitpos = self.LastPos  if not self.RenderBoundsAdjusted then  self:SetRenderBoundsWS(pos, hitpos, Vector(8, 8, 8))  self.RenderBoundsAdjusted = true  end   render.SetMaterial(matGlow)  render.DrawSprite(pos, 4, 4, colBeam)  render.DrawSprite(hitpos, 4, 4, colBeam)  render.SetMaterial(matBeam)  render.DrawBeam(pos, hitpos, 2, 0, 1, colBeam)  end  end end 