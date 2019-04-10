include("shared.lua")  SWEP.HUD3DBone = "v_weapon.slide_right" SWEP.HUD3DPos = Vector(1, 0.1, -1) SWEP.HUD3DScale = 0.015  SWEP.ViewModelFlip = false SWEP.ViewModelFOV = 55  SWEP.ShowViewModel = false SWEP.ShowWorldModel = false  SWEP.VElements = {  ["artemis_right++++"] = { type = "Model", model = "models/weapons/w_crossbow.mdl", bone = "v_weapon.elite_right", rel = "artemis_right+++", pos = Vector(-0.9, 4.099, 0.899), angle = Angle(0, 90, 180), size = Vector(0.649, 0.449, 0.36), color = Color(165, 183, 206, 255), surpresslightning = false, material = "models/weapons/v_smg1/v_smg1_sheet", skin = 0, bodygroup = {} },  ["artemis_right++"] = { type = "Model", model = "models/props_pipes/pipe03_tjoint01.mdl", bone = "v_weapon.elite_right", rel = "artemis_right", pos = Vector(0, 3, 2), angle = Angle(-90, 0, 0), size = Vector(0.129, 0.059, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_smg1/v_smg1_sheet", skin = 0, bodygroup = {} },  ["artemis_right"] = { type = "Model", model = "models/props_c17/utilityconnecter003.mdl", bone = "v_weapon.elite_right", rel = "", pos = Vector(0, -1.8, 4), angle = Angle(0, 0, 90), size = Vector(0.37, 0.4, 0.79), color = Color(64, 69, 77, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },  ["artemis_right+++"] = { type = "Model", model = "models/props_c17/utilityconnecter003.mdl", bone = "v_weapon.elite_left", rel = "", pos = Vector(0, -1.8, 4), angle = Angle(0, 0, 90), size = Vector(0.37, 0.4, 0.79), color = Color(64, 69, 77, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },  ["artemis_right+"] = { type = "Model", model = "models/weapons/w_crossbow.mdl", bone = "v_weapon.elite_right", rel = "artemis_right", pos = Vector(-0.9, 4.099, 0.899), angle = Angle(0, 90, 180), size = Vector(0.649, 0.449, 0.36), color = Color(165, 183, 206, 255), surpresslightning = false, material = "models/weapons/v_smg1/v_smg1_sheet", skin = 0, bodygroup = {} },  ["artemis_right+++++"] = { type = "Model", model = "models/props_pipes/pipe03_tjoint01.mdl", bone = "v_weapon.elite_right", rel = "artemis_right+++", pos = Vector(0, 3, 2), angle = Angle(-90, 0, 0), size = Vector(0.129, 0.059, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_smg1/v_smg1_sheet", skin = 0, bodygroup = {} } }  SWEP.WElements = {  ["artemis_right++++"] = { type = "Model", model = "models/weapons/w_crossbow.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "artemis_right+++", pos = Vector(-0.9, 4.099, 0.899), angle = Angle(0, 90, 180), size = Vector(0.649, 0.449, 0.36), color = Color(165, 183, 206, 255), surpresslightning = false, material = "models/weapons/v_smg1/v_smg1_sheet", skin = 0, bodygroup = {} },  ["artemis_right++"] = { type = "Model", model = "models/props_pipes/pipe03_tjoint01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "artemis_right", pos = Vector(0, 3, 2), angle = Angle(-90, 0, 0), size = Vector(0.129, 0.059, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_smg1/v_smg1_sheet", skin = 0, bodygroup = {} },  ["artemis_right"] = { type = "Model", model = "models/props_c17/utilityconnecter003.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.9, 1.299, -4), angle = Angle(0, -90, 0), size = Vector(0.37, 0.4, 0.79), color = Color(64, 69, 77, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },  ["artemis_right+++"] = { type = "Model", model = "models/props_c17/utilityconnecter003.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(7.8, 1.799, 4), angle = Angle(180, -100, -5.844), size = Vector(0.37, 0.4, 0.79), color = Color(64, 69, 77, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },  ["artemis_right+"] = { type = "Model", model = "models/weapons/w_crossbow.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "artemis_right", pos = Vector(-0.9, 4.099, 0.899), angle = Angle(0, 90, 180), size = Vector(0.649, 0.449, 0.36), color = Color(165, 183, 206, 255), surpresslightning = false, material = "models/weapons/v_smg1/v_smg1_sheet", skin = 0, bodygroup = {} },  ["artemis_right+++++"] = { type = "Model", model = "models/props_pipes/pipe03_tjoint01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "artemis_right+++", pos = Vector(0, 3, 2), angle = Angle(-90, 0, 0), size = Vector(0.129, 0.059, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_smg1/v_smg1_sheet", skin = 0, bodygroup = {} } }  local ghostlerp = 0 function SWEP:CalcViewModelView(vm, oldpos, oldang, pos, ang)  if self:GetOwner():GetBarricadeGhosting() or self:GetReloadFinish() > 0 then  ghostlerp = math.min(1, ghostlerp + FrameTime() * 1)  elseif ghostlerp > (self.Zealot and 0.15 or 0) then  ghostlerp = math.max(self.Zealot and 0.15 or 0, ghostlerp - FrameTime() * 1.3)  end   if ghostlerp > 0 then  ang:RotateAroundAxis(ang:Right(), -35 * ghostlerp)  end   return pos, ang end 