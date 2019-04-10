AddCSLuaFile()  SWEP.PrintName = "Multi-Tool" SWEP.Description = "An advanced tool used for managing deployables. Left fills a selected deployable up. Right click selects a deployable near where you're facing."  if CLIENT then  SWEP.ViewModelFOV = 55  SWEP.ViewModelFlip = false   SWEP.ShowViewModel = false  SWEP.ShowWorldModel = false     SWEP.VElements = {         ["multitool+++"] = { type = "Model", model = "models/props_wasteland/panel_leverhandle001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "multitool", pos = Vector(3, 0, -2.597), angle = Angle(0, 90, 0), size = Vector(0.4, 0.8, 0.4), color = Color(55, 42, 27, 255), surpresslightning = false, material = "phoenix_storms/spheremappy", skin = 0, bodygroup = {} },         ["multitool++++"] = { type = "Model", model = "models/props_wasteland/panel_leverhandle001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "multitool", pos = Vector(3, 0, -0.519), angle = Angle(0, 90, 0), size = Vector(0.4, 0.8, 0.899), color = Color(55, 42, 27, 255), surpresslightning = false, material = "phoenix_storms/spheremappy", skin = 0, bodygroup = {} },         ["multitool+++++"] = { type = "Model", model = "models/props_wasteland/interior_fence002c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "multitool", pos = Vector(3, 0, 4), angle = Angle(0, 90, 0), size = Vector(0.05, 0.05, 0.05), color = Color(255, 97, 11, 47), surpresslightning = true, material = "phoenix_storms/train_wheel", skin = 0, bodygroup = {} },         ["multitool++"] = { type = "Model", model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "multitool", pos = Vector(6.5, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.1, 0.3, 0.4), color = Color(67, 44, 11, 255), surpresslightning = false, material = "phoenix_storms/spheremappy", skin = 0, bodygroup = {} },         ["multitool"] = { type = "Model", model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.5, 2, -3), angle = Angle(180, 78.311, 0), size = Vector(0.1, 0.3, 0.4), color = Color(67, 40, 11, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },         ["multitool+"] = { type = "Model", model = "models/props_combine/combine_intwallunit.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "multitool", pos = Vector(3.049, 0, 4), angle = Angle(0, 90, 0), size = Vector(0.119, 0.18, 0.2), color = Color(255, 255, 0, 255), surpresslightning = true, material = "phoenix_storms/airboat_blur02", skin = 0, bodygroup = {} }     }     SWEP.WElements = {         ["multitool+++"] = { type = "Model", model = "models/props_wasteland/panel_leverhandle001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "multitool", pos = Vector(3, 0, -2.597), angle = Angle(0, 90, 0), size = Vector(0.4, 0.8, 0.4), color = Color(55, 42, 27, 255), surpresslightning = false, material = "phoenix_storms/spheremappy", skin = 0, bodygroup = {} },         ["multitool++++"] = { type = "Model", model = "models/props_wasteland/panel_leverhandle001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "multitool", pos = Vector(3, 0, -0.519), angle = Angle(0, 90, 0), size = Vector(0.4, 0.8, 0.899), color = Color(55, 42, 27, 255), surpresslightning = false, material = "phoenix_storms/spheremappy", skin = 0, bodygroup = {} },         ["multitool+++++"] = { type = "Model", model = "models/props_wasteland/interior_fence002c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "multitool", pos = Vector(3, 0, 4), angle = Angle(0, 90, 0), size = Vector(0.05, 0.05, 0.05), color = Color(255, 97, 11, 47), surpresslightning = true, material = "phoenix_storms/train_wheel", skin = 0, bodygroup = {} },         ["multitool++"] = { type = "Model", model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "multitool", pos = Vector(6.5, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.1, 0.3, 0.4), color = Color(67, 44, 11, 255), surpresslightning = false, material = "phoenix_storms/spheremappy", skin = 0, bodygroup = {} },         ["multitool"] = { type = "Model", model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.869, 1, -2.714), angle = Angle(180, 87.662, 0), size = Vector(0.1, 0.3, 0.4), color = Color(67, 40, 11, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },         ["multitool+"] = { type = "Model", model = "models/props_combine/combine_intwallunit.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "multitool", pos = Vector(3.049, 0, 4), angle = Angle(0, 90, 0), size = Vector(0.119, 0.18, 0.2), color = Color(255, 255, 0, 255), surpresslightning = true, material = "phoenix_storms/airboat_blur02", skin = 0, bodygroup = {} }     }      SWEP.ViewModelBoneMods = {         ["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(12.222, 50, -58.889) },         ["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(7.777, -50, 43.333) }     }      SWEP.HUD3DBone = "ValveBiped.Bip01_R_Hand"     SWEP.HUD3DPos = Vector(3, 5, -7)     SWEP.HUD3DAng = Angle(0, 80, -90)     SWEP.HUD3DScale = 0.017 end  SWEP.Base = "weapon_zs_basemelee"  SWEP.ViewModel = "models/weapons/c_stunstick.mdl" SWEP.WorldModel = "models/weapons/w_stunbaton.mdl" SWEP.UseHands = true  SWEP.HoldType = "duel"  SWEP.WalkSpeed = SPEED_FAST  SWEP.AllowQualityWeapons = false  SWEP.Primary.Delay = 1  AccessorFuncDT(SWEP, "DetectedEnt", "Entity", 10)  function SWEP:PrimaryAttack()  if not self:CanPrimaryAttack() then return end  self:SetNextPrimaryFire(CurTime() + self.Primary.Delay * 0.3)      local det_ent = self:GetDetectedEnt()     if not IsValid(det_ent) then return end          if SERVER then         det_ent:Fill(self:GetOwner())     end end  function SWEP:SecondaryAttack()  if not self:CanPrimaryAttack() then return end  self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)      if SERVER then         local owner = self:GetOwner()         local shootpos = owner:GetShootPos()         local tr = util.TraceLine({start = shootpos, endpos = shootpos + owner:GetAimVector() * 400, mask = MASK_SOLID_BRUSHONLY, filter = owner})          local tr_pos = tr.HitPos          local ent, min = NULL, math.huge         for _, v in pairs(ents.GetAll()) do             if v.Fill then                 local dist = v:GetPos():DistToSqr(tr_pos)                 if dist <= 8100 and dist <= min then                     ent = v                     min = dist                 end             end         end          local valid = IsValid(ent)         owner:EmitSound(valid and "npc/scanner/combat_scan4.wav" or "npc/scanner/scanner_scan5.wav", 65, valid and 75 or 250)         self:SetDetectedEnt(ent)     end end  if not CLIENT then return end  local colBG = Color(16, 16, 16, 90) local colRed = Color(220, 0, 0, 230) local colWhite = Color(220, 220, 220, 230) local scrap = Material("zombiesurvival/killicons/pulse_ammo_icon") function SWEP:DrawHUD()     local owner = self:GetOwner()     local screenscale = BetterScreenScale()      local wid, hei = 180 * screenscale, 64 * screenscale     local x, y = ScrW() - wid - screenscale * 128, ScrH() - hei - screenscale * 72      local spare = owner:GetAmmoCount("pulse")      draw.RoundedBox(16, x, y, wid, hei, colBG)     draw.SimpleTextBlurry(spare, spare >= 1000 and "ZSHUDFont" or "ZSHUDFontBig", x + wid * 0.3, y + hei * 0.55, spare == 0 and colRed or colWhite, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)      surface.SetMaterial(scrap)     surface.SetDrawColor(150, 200, 255, 150)     surface.DrawTexturedRect(x + wid * 0.66, y + hei * 0.12, 48 * screenscale, 48 * screenscale)      if GetConVar("crosshair"):GetInt() ~= 1 then return end     self:DrawCrosshairDot()      local fm = self:GetFireMode()     if self.FireModes > 1 then         local fmname = self.FireModeNames[fm + 1] or "-"         draw.SimpleTextBlurry(fmname, "ZSHUDFont", x + wid * 0.5, y + hei + 32 * screenscale, colWhite, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)     end end  function SWEP:GetHUD3DPos(vm)     local bone = vm:LookupBone(self.HUD3DBone)     if not bone then return end      local m = vm:GetBoneMatrix(bone)     if not m then return end      local pos, ang = m:GetTranslation(), m:GetAngles()      if self.ViewModelFlip then         ang.r = -ang.r     end      local offset = self.HUD3DPos     local aoffset = self.HUD3DAng      pos = pos + ang:Forward() * offset.x + ang:Right() * offset.y + ang:Up() * offset.z      if aoffset.yaw ~= 0 then ang:RotateAroundAxis(ang:Up(), aoffset.yaw) end     if aoffset.pitch ~= 0 then ang:RotateAroundAxis(ang:Right(), aoffset.pitch) end     if aoffset.roll ~= 0 then ang:RotateAroundAxis(ang:Forward(), aoffset.roll) end      return pos, ang end  local obj_names = {     prop_ffemitter = "Force Field",     prop_repairfield = "Repair Field",     prop_nullifier = "Nullifier",     prop_zapper = "Zapper",     prop_zapper_arc = "Arc Zapper" }  function SWEP:PostDrawViewModel(vm)     if self.ShowViewModel == false then         render.SetBlend(1)     end      local wid, hei = 180, 200     local x, y = wid * -0.45, hei * -0.5      local pos, ang = self:GetHUD3DPos(vm)      cam.Start3D2D(pos, ang, self.HUD3DScale / 2)         local det_ent = self:GetDetectedEnt()         if IsValid(det_ent) then             local spare = det_ent:GetAmmo()              draw.SimpleTextBlurry(obj_names[det_ent.BaseDeployClass or det_ent:GetClass()], "ZS3D2DFontSmall", x + wid * 0.5, y - hei * 0.6, spare == 0 and colRed or colWhite, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)             draw.SimpleTextBlurry(spare .. " / " .. det_ent.MaxAmmo, "ZS3D2DFont", x + wid * 0.5, y - hei * 0.1, spare == 0 and colRed or colWhite, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)                          local det_owner = det_ent:GetObjectOwner()             if det_owner:IsValidLivingHuman() then                 draw.SimpleTextBlurry(det_owner:ClippedName(), "ZS3D2DFont", x + wid * 0.5, y + hei * 0.3, spare == 0 and colRed or colWhite, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)             end              local ki_get = killicon.Get(det_ent:GetClass())             if ki_get then                 local cols = ki_get[2]                 local mat = Material(ki_get[1])                  local capped_hei = math.min(128, hei)                 local capped_wid = math.min(capped_hei, wid)                  surface.SetMaterial(mat)                 surface.SetDrawColor(cols.r, cols.g, cols.b, 200)                 surface.DrawTexturedRect(x + capped_wid/4, y + hei * 1, capped_wid, capped_hei)             end         end     cam.End3D2D() end