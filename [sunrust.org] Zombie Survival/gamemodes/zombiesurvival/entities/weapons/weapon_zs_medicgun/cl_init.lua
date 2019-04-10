include("shared.lua")  local BaseClass = baseclass.Get("weapon_zs_baseproj")  SWEP.ViewModelFlip = false SWEP.ViewModelFOV = 60  SWEP.HUD3DBone = "ValveBiped.square" SWEP.HUD3DPos = Vector(1.1, 0.25, -2) SWEP.HUD3DScale = 0.015  SWEP.WElements = {  ["base"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.5, 2, -3.701), angle = Angle(0, -90, -8), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["2"] = { type = "Model", model = "models/airboatgun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, -3, 0), angle = Angle(0, 90, 180), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["2+"] = { type = "Model", model = "models/airboatgun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, -3, 0), angle = Angle(0, 90, 180), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} } } SWEP.VElements = {     ["base"] = { type = "Model", model = "", bone = "ValveBiped.square", rel = "", pos = Vector(0, 0.5, 3), angle = Angle(0, 0, 90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },     ["2"] = { type = "Model", model = "models/airboatgun.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0, -3, 0), angle = Angle(0, 90, 180), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },     ["base+"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.clip", rel = "", pos = Vector(0, -2.491, 5.231), angle = Angle(0, 0, 90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },     ["2+"] = { type = "Model", model = "models/airboatgun.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0, -3, 0), angle = Angle(0, 90, 180), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} } }  SWEP.ViewModelBoneMods = {     ["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 4, 0), angle = Angle(-1.941, 16.229, 0) },     ["ValveBiped.clip"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) } }  function SWEP:Draw2DHUD()  BaseClass.Draw2DHUD(self)   local owner = self:GetOwner()  if owner:IsSkillActive(SKILL_RASHTARGETING) then return end   local player = self:GetSeekedPlayer()  local screenscale = BetterScreenScale()  surface.SetFont("ZSHUDFont")  local text = player:IsValidLivingHuman() and player:Name() or "No Target"  local _, nTEXH = surface.GetTextSize(text)   draw.SimpleTextBlurry(text, "ZSHUDFont", ScrW() - 218 * screenscale, ScrH() - nTEXH * 5.5, text ~= "No Target" and COLOR_LIMEGREEN or COLOR_RED, TEXT_ALIGN_CENTER)  if text ~= "No Target" then         local hptxt = GAMEMODE.HealthTargetDisplay == 1 and math.ceil(player:Health()).. " / " .. player:GetMaxHealth() .. " HP" or                                                              math.ceil((player:Health() / player:GetMaxHealth()) * 100)  .. "%"          draw.SimpleTextBlurry(hptxt, "ZSHUDFontSmall", ScrW() - 218 * screenscale, ScrH() - nTEXH * 4.5, COLOR_LIMEGREEN, TEXT_ALIGN_CENTER)     end end  function SWEP:Draw3DHUD(vm, pos, ang)  BaseClass.Draw3DHUD(self, vm, pos, ang)   local owner = self:GetOwner()  if owner:IsSkillActive(SKILL_RASHTARGETING) then return end   local wid, hei = 180, 200  local x, y = wid * 0, hei * -1   local player = self:GetSeekedPlayer()  surface.SetFont("ZS3D2DFontSmall")  local text = player:IsValidLivingHuman() and player:Name() or "No Target"   cam.Start3D2D(pos, ang, self.HUD3DScale / 2)  draw.SimpleTextBlurry(text, "ZS3D2DFontSmall", x, y, text ~= "No Target" and COLOR_LIMEGREEN or COLOR_RED, TEXT_ALIGN_CENTER)         if text ~= "No Target" then             local hptxt = GAMEMODE.HealthTargetDisplay == 1 and math.ceil(player:Health()).. " / " .. player:GetMaxHealth() .. " HP" or                                                                  math.ceil((player:Health() / player:GetMaxHealth()) * 100)  .. "%"              draw.SimpleTextBlurry(hptxt, "ZS3D2DFontSmaller", x, y + 60, COLOR_LIMEGREEN, TEXT_ALIGN_CENTER)         end  cam.End3D2D() end 