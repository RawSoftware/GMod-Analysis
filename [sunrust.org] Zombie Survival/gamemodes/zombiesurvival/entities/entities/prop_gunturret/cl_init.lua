include("shared.lua")  ENT.NextEmit = 0 ENT.VScreen = Vector(0, -2, 45) ENT.ScanPitch = 100 ENT.ScanSound = "npc/turret_wall/turret_loop1.wav"  function ENT:GetTargetPos(target)  if not (target:IsPlayer() and target:GetZombieClassTable().NoHead) then  local boneid = target:GetHitBoxBone(HITGROUP_HEAD, 0)  if boneid and boneid > 0 then  local bp = target:GetBonePositionMatrixed(boneid)  if bp then  return bp  end  end  end   return target:WorldSpaceCenter() end  local trace_cam = {mask = MASK_VISIBLE, mins = Vector(-4, -4, -4), maxs = Vector(4, 4, 4)} function ENT:Initialize()     self.BeamColor = Color(0, 255, 0, 255)      self.ScanningSound = CreateSound(self, self.ScanSound)     self.ShootingSound = CreateSound(self, "npc/combine_gunship/gunship_weapon_fire_loop6.wav")      local size = self.SearchDistance + 32     local nsize = -size     self:SetRenderBounds(Vector(-32, nsize, -32 * 0.25), Vector(size, size, size * 0.25))      local enty = self     hook.Add("CreateMove", tostring(enty), function(cmd)         if not IsValid(enty) then return end         if enty:GetObjectOwner() ~= MySelf then return end          if not enty:GetManualControl() then return end          local buttons = cmd:GetButtons()          cmd:ClearMovement()          if bit.band(buttons, IN_JUMP) ~= 0 then             buttons = buttons - IN_JUMP             buttons = buttons + IN_BULLRUSH         end          if bit.band(buttons, IN_DUCK) ~= 0 then             buttons = buttons - IN_DUCK             buttons = buttons + IN_GRENADE1         end          cmd:SetButtons(buttons)     end)     hook.Add("ShouldDrawLocalPlayer", tostring(enty), function(pl)         if not IsValid(enty) then return end         if enty:GetObjectOwner() ~= MySelf then return end          if enty:GetManualControl() then             return true         end     end)     hook.Add("CalcView", tostring(enty), function(pl, origin, angles, fov, znear, zfar)         if not IsValid(enty) then return end         if enty:GetObjectOwner() ~= pl or not enty:GetManualControl() then return end          local filter = player.GetAll()         filter[#filter + 1] = enty         trace_cam.start = enty:ShootPos()         trace_cam.endpos = trace_cam.start         trace_cam.filter = filter         local tr = util.TraceHull(trace_cam)          return {origin = tr.HitPos + tr.HitNormal * 3, angles = angles}     end)      GAMEMODE:CallDeployableFunction(self, "prop_gunturret", self:GetDTInt(10), "Initialize") end  function ENT:Think()     if self:GetObjectOwner():IsValid() and self:GetAmmo() > 0 and self:GetMaterial() == "" then         self.ScanningSound:PlayEx(0.55, self.ScanPitch + math.sin(CurTime()))          if self:GetDTInt(10) == 0 and (self:IsFiring() or self:GetTarget():IsValid()) then             self.ShootingSound:PlayEx(1, 100 + math.cos(CurTime()))         else             self.ShootingSound:Stop()         end     else         self.ScanningSound:Stop()         self.ShootingSound:Stop()     end end  function ENT:OnRemove()     if not GAMEMODE:CallDeployableFunction(self, "prop_gunturret", self:GetDTInt(10), "OnRemove") then         self.ScanningSound:Stop()         self.ShootingSound:Stop()     end      hook.Remove("CreateMove", tostring(self))     hook.Remove("ShouldDrawLocalPlayer", tostring(self))     hook.Remove("CalcView", tostring(self))     end  function ENT:SetObjectHealth(health)     self:SetDTFloat(3, health) end  local TEXT_ALIGN_CENTER = TEXT_ALIGN_CENTER local draw_SimpleText = draw.SimpleText local surface_SetDrawColor = surface.SetDrawColor local surface_DrawRect = surface.DrawRect local cam_Start3D2D = cam.Start3D2D local cam_End3D2D = cam.End3D2D local smokegravity = Vector(0, 0, 200) local aScreen = Angle(0, 270, 60) function ENT:Draw()     self:CalculatePoseAngles()     self:SetPoseParameter("aim_yaw", self.PoseYaw)     self:SetPoseParameter("aim_pitch", self.PosePitch)      local owner = self:GetObjectOwner()      if owner == MySelf and self:GetManualControl() then return end      local alpha = self:TransAlphaToMe()      render.SetBlend(alpha)     render.SuppressEngineLighting(alpha < 0.99)     self:DrawModel()     render.SuppressEngineLighting(false)     render.SetBlend(1)      local healthpercent = self:GetObjectHealth() / self:GetMaxObjectHealth()      if healthpercent <= 0.5 and CurTime() >= self.NextEmit then         self.NextEmit = CurTime() + 0.05          local pos = self:DefaultPos()         local sat = healthpercent * 360          local emitter = ParticleEmitter(pos)         emitter:SetNearClip(24, 32)          local particle = emitter:Add("particles/smokey", pos)         particle:SetStartAlpha(180)         particle:SetEndAlpha(0)         particle:SetStartSize(0)         particle:SetEndSize(math.Rand(8, 32))         particle:SetColor(sat, sat, sat)         particle:SetVelocity(VectorRand():GetNormalized() * math.Rand(8, 64))         particle:SetGravity(smokegravity)         particle:SetDieTime(math.Rand(0.8, 1.6))         particle:SetAirResistance(150)         particle:SetRoll(math.Rand(0, 360))         particle:SetRollDelta(math.Rand(-4, 4))         particle:SetBounce(0.2)          emitter:Finish() emitter = nil collectgarbage("step", 64)     end      if not MySelf:IsValid() or MySelf:Team() ~= TEAM_HUMAN then return end     if EyePos():DistToSqr(self:GetPos()) >= 202500 then return end      local ammo = self:GetAmmo()     local flash = math.sin(CurTime() * 15) > 0     local wid, hei = 128, 92     local x = wid / 2      cam_Start3D2D(self:LocalToWorld(self.VScreen), self:LocalToWorldAngles(aScreen), 0.075)          surface_SetDrawColor(0, 0, 0, 160)         surface_DrawRect(0, 0, wid, hei)          surface_SetDrawColor(200, 200, 200, 160)         surface_DrawRect(0, 0, 8, 16)         surface_DrawRect(wid - 8, 0, 8, 16)         surface_DrawRect(8, 0, wid - 16, 8)          surface_DrawRect(0, hei - 16, 8, 16)         surface_DrawRect(wid - 8, hei - 16, 8, 16)         surface_DrawRect(8, hei - 8, wid - 16, 8)          if owner:IsValid() and owner:IsPlayer() then             draw_SimpleText(owner:ClippedName(), "DefaultFont", x, 10, owner == MySelf and COLOR_LBLUE or COLOR_WHITE, TEXT_ALIGN_CENTER)         end         draw_SimpleText(translate.Format("integrity_x", math.ceil(healthpercent * 100)), "DefaultFontBold", x, 25, COLOR_WHITE, TEXT_ALIGN_CENTER)          if flash and self:GetManualControl() then             draw_SimpleText(translate.Get("manual_control"), "DefaultFont", x, 40, COLOR_YELLOW, TEXT_ALIGN_CENTER)         end          if ammo > 0 then             local maximum_ammo = math.ceil(self.MaxAmmo)             draw_SimpleText("["..ammo.." / "..maximum_ammo.."]", "DefaultFontBold", x, 55, COLOR_WHITE, TEXT_ALIGN_CENTER)         elseif flash then             draw_SimpleText(translate.Get("empty"), "DefaultFontBold", x, 55, COLOR_RED, TEXT_ALIGN_CENTER)         end          draw_SimpleText("CH. "..self:GetChannel().." / "..GAMEMODE.MaxChannels["turret"], "DefaultFontSmall", x, 70, COLOR_WHITE, TEXT_ALIGN_CENTER)      cam_End3D2D() end  local matBeam = Material("trails/laser") local matGlow = Material("effects/strider_muzzle") function ENT:DrawTranslucent()     if self:GetMaterial() ~= "" then return end      local lightpos = self:LightPos()     local ang = self:GetGunAngles()      local colBeam = self.BeamColor      local owner = self:GetObjectOwner()     local me_owner = owner == MySelf or MySelf:Team() ~= TEAM_HUMAN     local hasowner = owner:IsValid()     local hasammo = self:GetAmmo() > 0     local manualcontrol = self:GetManualControl()      local tr     if me_owner then         tr = util.TraceLine({             start = lightpos,             endpos = lightpos + ang:Forward() * (self.SearchDistance * (hasowner and owner.TurretRangeMul or 1)),             mask = MASK_SHOT,             filter = self:GetCachedScanFilter()         })     end      if not hasowner then         local rate = FrameTime() * 512         colBeam.r = math.Approach(colBeam.r, 90, rate)         colBeam.g = math.Approach(colBeam.g, 90, rate)         colBeam.b = math.Approach(colBeam.b, 255, rate)     elseif not hasammo or not manualcontrol and self:GetTarget():IsValid() then         local rate = FrameTime() * 512         colBeam.r = math.Approach(colBeam.r, 255, rate)         colBeam.g = math.Approach(colBeam.g, 90, rate)         colBeam.b = math.Approach(colBeam.b, 90, rate)     elseif manualcontrol then         local rate = FrameTime() * 512         colBeam.r = math.Approach(colBeam.r, 255, rate)         colBeam.g = math.Approach(colBeam.g, 255, rate)         colBeam.b = math.Approach(colBeam.b, 50, rate)     else         local rate = FrameTime() * 200         colBeam.r = math.Approach(colBeam.r, 90, rate)         colBeam.g = math.Approach(colBeam.g, 255, rate)         colBeam.b = math.Approach(colBeam.b, 90, rate)     end      if hasowner and hasammo then         if me_owner then             render.SetMaterial(matBeam)             render.DrawBeam(lightpos, tr.HitPos, 3 * self.ModelScale, 0, 1, colBeam)         end          render.SetMaterial(matGlow)         render.DrawSprite(lightpos, 3 * self.ModelScale, 3 * self.ModelScale, colBeam)          if me_owner then             render.DrawSprite(tr.HitPos, 6, 6, colBeam)         end     else         render.SetMaterial(matGlow)         render.DrawSprite(lightpos, 3 * self.ModelScale, 3 * self.ModelScale, colBeam)     end      GAMEMODE:CallDeployableFunction(self, "prop_gunturret", self:GetDTInt(10), "DrawTranslucent") end  function ENT:SetTarget(ent)     if ent:IsValid() then         self:SetTargetReceived(CurTime())     else         self:SetTargetLost(CurTime())     end      self:SetDTEntity(0, ent) end  function ENT:SetObjectOwner(ent)     self:SetDTEntity(1, ent) end