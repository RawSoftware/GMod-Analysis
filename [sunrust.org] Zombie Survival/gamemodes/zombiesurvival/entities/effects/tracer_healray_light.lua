function EFFECT:Init( data )     self.Position = data:GetStart()     self.WeaponEnt = data:GetEntity()     self.Attachment = data:GetAttachment()      self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )     self.EndPos = data:GetOrigin()      self.Life = 0      self.BeamColor = self.WeaponEnt.BeamColor      self:SetRenderBoundsWS( self.StartPos, self.EndPos ) end  function EFFECT:Think( )     self.Life = self.Life + FrameTime() * 6     self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )      return self.Life < 1 end  local beammat = Material("trails/physbeam") local glowmat = Material("sprites/light_glow02_add") function EFFECT:Render()     local texcoord = math.Rand(0, 1)      local norm = (self.StartPos - self.EndPos) * self.Life     local nlen = norm:Length()      local alpha = (1 - self.Life) * 0.6      render.SetMaterial(beammat)      local vec = Vector(math.cos(CurTime() * 0.5) * 8, math.sin(CurTime() * 0.5) * 10, 0)     local cubicone = CosineInterpolation(self.StartPos - vec * 1, self.EndPos, 0.2)     local cubictwo = CosineInterpolation(cubicone, self.EndPos - vec * 1, 0.4)      local r,g,b = self.BeamColor[1], self.BeamColor[2], self.BeamColor[3]      render.DrawBeam(self.StartPos, cubicone, 7, texcoord, texcoord + nlen / 128, Color(r, g, b, 210 * alpha))     render.DrawBeam(cubicone, cubictwo, 7, texcoord, texcoord + nlen / 128, Color(r, g, b, 210 * alpha))     render.DrawBeam(cubictwo, self.EndPos, 7, texcoord, texcoord + nlen / 128, Color(r, g, b, 210 * alpha))      render.SetMaterial(glowmat)     render.DrawSprite(self.StartPos, 7, 7, Color(190, 255, 190, 148 * alpha))     render.DrawSprite(self.EndPos, 7, 7, Color(190, 255, 190, 148 * alpha)) end 