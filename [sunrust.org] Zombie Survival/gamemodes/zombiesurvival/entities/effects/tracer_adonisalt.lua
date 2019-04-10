function EFFECT:Init( data )  self.Position = data:GetStart()  self.WeaponEnt = data:GetEntity()  self.Attachment = data:GetAttachment()   self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )  self.EndPos = data:GetOrigin()   self.Life = 0  self.EndLife = 1.5   self:SetRenderBoundsWS( self.StartPos, self.EndPos ) end  function EFFECT:Think( )  self.Life = self.Life + FrameTime() * 9    self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )   return self.Life < self.EndLife end  local beammat = Material("trails/plasma") local beammat2 = Material("trails/laser") local glowmat = Material("effects/combinemuzzle2") function EFFECT:Render()  local texcoord = math.Rand(0, 1)   local delta = self.Life / self.EndLife  local rdelta = 1 - delta   local norm = (self.StartPos - self.EndPos) * self.Life  local nlen = norm:Length()   render.SetMaterial(beammat)  render.DrawBeam(self.EndPos, self.StartPos, 3, texcoord, texcoord + nlen / 240, Color(238, 255, 242, 255 * rdelta))  render.DrawBeam(self.EndPos, self.StartPos, 7, texcoord, texcoord + nlen / 240, Color(255, 255, 255, 120 * rdelta))   render.SetMaterial(beammat2)  render.DrawBeam(self.EndPos, self.StartPos, 19 * rdelta, texcoord, texcoord + nlen / 128, Color(170, 240, 255, 255 * rdelta))   render.SetMaterial(glowmat)  render.DrawSprite(self.StartPos, 40, 40, Color(255, 255, 255, 148 * rdelta))  render.DrawSprite(self.EndPos, 35 * rdelta, 35 * rdelta, Color(255, 255, 255, 200 * rdelta)) end 