function EFFECT:Init( data )  self.Position = data:GetStart()  self.WeaponEnt = data:GetEntity()  self.Attachment = data:GetAttachment()   self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )  self.EndPos = data:GetOrigin()   self.Life = 0   self:SetRenderBoundsWS( self.StartPos, self.EndPos ) end  function EFFECT:Think( )  self.Life = self.Life + FrameTime() * 10    self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )   return self.Life < 1 end  local beammat = Material("trails/smoke") local glowmat = Material("sprites/glow04_noz") function EFFECT:Render()  local texcoord = math.Rand( 0, 1 )   local norm = (self.StartPos - self.EndPos) * self.Life  local dir = (self.StartPos - self.EndPos):Angle()  local dfwd = dir:Forward()  local dup = dir:Up()  local drgt = dir:Right()  local nlen = norm:Length()   local prevspinpos = self.StartPos  local alpha = 1 - self.Life   local emitter = ParticleEmitter(self.EndPos)  emitter:SetNearClip(24, 32)   local particle = emitter:Add("effects/fleck_glass"..math.random(1, 3), self.EndPos - (self.EndPos - self.StartPos) * math.Rand(0, 1))  local vel = VectorRand():GetNormal() * 160  particle:SetDieTime(1)  particle:SetColor(0,0,0)  particle:SetStartAlpha(200)  particle:SetEndAlpha(0)  particle:SetStartSize(2)  particle:SetEndSize(0)  particle:SetVelocity(vel)  particle:SetGravity(vel * -1.7)  particle:SetRoll(math.random(360))   emitter:Finish() emitter = nil collectgarbage("step", 64)   render.SetMaterial(beammat)  for i = 0, nlen, 32 do  if i > 704 then break end     local set = i - CurTime() * 15   local basebeampos = self.StartPos - dfwd * i  local spinbeampos = basebeampos + dup * math.sin(set) * 6 + drgt * math.cos(set) * 6   if i == 704 then spinbeampos = basebeampos end     render.DrawBeam(prevspinpos, spinbeampos, 3, texcoord + i, texcoord + nlen / 128 + i, Color(150, 150, 150, 155 * alpha))   prevspinpos = spinbeampos  end   for i = 0, 4 do  render.DrawBeam(self.StartPos, self.EndPos, 6, texcoord, texcoord + nlen / 128, Color(0, 0, 0, 115 * alpha))  end  render.DrawBeam(self.StartPos, self.EndPos, 2, texcoord, texcoord + nlen / 128, Color(125, 125, 125, 60 * alpha))   render.SetMaterial(glowmat)  render.DrawSprite(self.StartPos, 45, 45, Color(160, 160, 160, 38 * alpha))  render.DrawSprite(self.EndPos, 45, 45, Color(160, 160, 160, 128 * alpha)) end 