AddCSLuaFile()  SWEP.PrintName = "'Razor' Kriss Vector" SWEP.Description = "Fairly precise SMG capable of dealing considerable damage output. Right clicking with the Buff firemode grants 8 players near you the slipstream buff."  SWEP.Slot = 2 SWEP.SlotPos = 0  if CLIENT then  SWEP.ViewModelFlip = false  SWEP.ShowViewModel = false  SWEP.ShowWorldModel = false  SWEP.ViewModelFOV = 63   SWEP.HUD3DBone = "v_weapon.ump45_Release"  SWEP.HUD3DPos = Vector(-1.8, -2.5, 2)  SWEP.HUD3DAng = Angle(0, 0, 0)  SWEP.HUD3DScale = 0.02   SWEP.VElements = {  ["middlebetter1"] = { type = "Model", model = "models/XQM/quad1.mdl", bone = "v_weapon.ump45_Parent", rel = "shaft", pos = Vector(-8.617, -4.654, 0.763), angle = Angle(180, 0, 0), size = Vector(0.261, 0.2, 0.745), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["grip/trigger"] = { type = "Model", model = "models/weapons/w_pist_usp.mdl", bone = "v_weapon.ump45_Parent", rel = "shaft", pos = Vector(-4.973, -16.43, 0.847), angle = Angle(180, 90, 90), size = Vector(1.735, 1.424, 1.062), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["sight_base_3"] = { type = "Model", model = "models/Mechanics/roboticslarge/g1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "sight_base_2", pos = Vector(-0.429, 0, -0.663), angle = Angle(0, -90, 0), size = Vector(0.016, 0.009, 0.079), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["ramp_between"] = { type = "Model", model = "models/props_junk/cardboard_box001a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "shaft", pos = Vector(-5.132, -14.29, 0.694), angle = Angle(0, -14.308, 0), size = Vector(0.009, 0.109, 0.057), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["stock"] = { type = "Model", model = "models/gibs/helicopter_brokenpiece_03.mdl", bone = "v_weapon.ump45_Parent", rel = "shaft", pos = Vector(0.097, -26.122, 0.884), angle = Angle(-1.17, 81.236, 40.909), size = Vector(0.2, 0.174, 0.174), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["grip"] = { type = "Model", model = "models/props_c17/woodbarrel001.mdl", bone = "v_weapon.ump45_Parent", rel = "shaft", pos = Vector(0.1, -1.366, 0.737), angle = Angle(90, 0, 0), size = Vector(0.061, 0.061, 0.125), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["sight_base"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "v_weapon.ump45_Parent", rel = "shaft", pos = Vector(2.657, -5.27, 0.755), angle = Angle(0, 0, 0), size = Vector(0.068, 0.312, 0.125), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["laser_scope"] = { type = "Model", model = "models/XQM/panel360.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "sight_top", pos = Vector(0, 0, 0.28), angle = Angle(90, 180, 0), size = Vector(0.187, 0.029, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_smg1/texture5", skin = 0, bodygroup = {} },  ["slider1"] = { type = "Model", model = "models/props_phx/mechanics/slider2.mdl", bone = "v_weapon.ump45_Parent", rel = "shaft", pos = Vector(2.147, -10.816, 0.778), angle = Angle(0, 90, 90), size = Vector(0.129, 0.224, 0.063), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["mag"] = { type = "Model", model = "models/phxtended/bar1x.mdl", bone = "v_weapon.ump45_Clip", rel = "", pos = Vector(-0.911, 12.704, -2.612), angle = Angle(0, -1, -13.978), size = Vector(0.2, 0.211, 0.3), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["barreltip"] = { type = "Model", model = "models/props_c17/pipe_cap003.mdl", bone = "v_weapon.ump45_Parent", rel = "shaft", pos = Vector(0.999, -0.069, 0.734), angle = Angle(0, -90, 0), size = Vector(0.398, 0.059, 0.059), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["sight_top"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "v_weapon.ump45_Parent", rel = "sight_base", pos = Vector(0.967, 1.361, 0), angle = Angle(0, 180, -90), size = Vector(0.016, 0.016, 0.009), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["safety"] = { type = "Model", model = "models/props_vents/vent_large_blower002.mdl", bone = "v_weapon.ump45_Parent", rel = "grip", pos = Vector(-0.709, -17.705, -0.5), angle = Angle(60, -90, 0), size = Vector(0.013, 0.013, 0.018), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["shaft"] = { type = "Model", model = "models/phxtended/bar1x.mdl", bone = "v_weapon.ump45_Parent", rel = "middlebetter2", pos = Vector(-2.881, -9.575, 0.762), angle = Angle(0, 0, 180), size = Vector(0.375, 0.449, 0.25), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["middlebetter2"] = { type = "Model", model = "models/XQM/quad1.mdl", bone = "v_weapon.ump45_Parent", rel = "", pos = Vector(0, -6.723, -4.843), angle = Angle(0, 90, -90), size = Vector(0.261, 0.25, 0.75), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["sight_base_2"] = { type = "Model", model = "models/hunter/plates/platehole1x2.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "sight_base", pos = Vector(0.939, 1.598, 0), angle = Angle(0, 0, 90), size = Vector(0.014, 0.016, 0.162), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} }  }   SWEP.WElements = {  ["middlebetter1"] = { type = "Model", model = "models/XQM/quad1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shaft", pos = Vector(-6.861, -3.6, 0.6), angle = Angle(180, 0, 0), size = Vector(0.209, 0.159, 0.597), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["grip/trigger"] = { type = "Model", model = "models/weapons/w_pist_usp.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shaft", pos = Vector(-3.922, -13, 0.606), angle = Angle(180, 90, 90), size = Vector(1.388, 1.139, 0.85), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["slider1"] = { type = "Model", model = "models/props_phx/mechanics/slider2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shaft", pos = Vector(1.649, -7.7, 0.6), angle = Angle(0, 90, 90), size = Vector(0.093, 0.18, 0.05), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["ramp_between"] = { type = "Model", model = "models/props_junk/cardboard_box001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shaft", pos = Vector(-4.051, -11.296, 0.546), angle = Angle(0, -13, 0), size = Vector(0.009, 0.087, 0.046), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["stock"] = { type = "Model", model = "models/gibs/helicopter_brokenpiece_03.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shaft", pos = Vector(-0.301, -19, 0.699), angle = Angle(-1.17, 85.324, 40.909), size = Vector(0.159, 0.14, 0.14), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["sight_base_3"] = { type = "Model", model = "models/Mechanics/roboticslarge/g1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "sight_base_2", pos = Vector(-0.429, 0, -0.533), angle = Angle(0, -90, 0), size = Vector(0.013, 0.009, 0.064), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["middlebetter2"] = { type = "Model", model = "models/XQM/quad1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7, 1, -5.036), angle = Angle(-72.639, 180, -90), size = Vector(0.209, 0.2, 0.6), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["shaft"] = { type = "Model", model = "models/phxtended/bar1x.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "middlebetter2", pos = Vector(-2.401, -7.5, 0.6), angle = Angle(0, 0, 180), size = Vector(0.3, 0.319, 0.2), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["grip"] = { type = "Model", model = "models/props_c17/woodbarrel001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shaft", pos = Vector(0.1, -0.9, 0.6), angle = Angle(90, 0, 0), size = Vector(0.05, 0.05, 0.1), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["barreltip"] = { type = "Model", model = "models/props_c17/pipe_cap003.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shaft", pos = Vector(0.677, -0.242, 0.6), angle = Angle(0, -90, 0), size = Vector(0.128, 0.048, 0.048), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["mag"] = { type = "Model", model = "models/phxtended/bar1x.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shaft", pos = Vector(-1, -4.325, 0.064), angle = Angle(90, 90, -18), size = Vector(0.159, 0.17, 0.3), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["sight_top"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "sight_base", pos = Vector(0.943, 1.097, 0), angle = Angle(0, 180, -90), size = Vector(0.013, 0.013, 0.009), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["safety"] = { type = "Model", model = "models/props_vents/vent_large_blower002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "grip", pos = Vector(-0.791, -13, -0.5), angle = Angle(60, -90, 0), size = Vector(0.009, 0.009, 0.014), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["LASer_scope"] = { type = "Model", model = "models/XQM/panel360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "sight_top", pos = Vector(0, 0, 0.237), angle = Angle(90, 180, 0), size = Vector(0.15, 0.024, 0.024), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_smg1/texture5", skin = 0, bodygroup = {} },  ["sight_base"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shaft", pos = Vector(1.949, -4.482, 0.583), angle = Angle(0, 0, 0), size = Vector(0.054, 0.25, 0.1), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },  ["sight_base_2"] = { type = "Model", model = "models/hunter/plates/platehole1x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "sight_base", pos = Vector(0.896, 1.281, 0), angle = Angle(0, 0, 90), size = Vector(0.01, 0.013, 0.129), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} }  } end  sound.Add( {  name = "vectorfiringnoise1",  channel = CHAN_WEAPON,  volume = 0.4,  level = 75,  pitch = { 140, 145 },    sound = ")weapons/galil/galil-1.wav" } )  sound.Add( {  name = "vectorfiringnoise2",  channel = CHAN_ITEM,  volume = 0.2,  level = 75,  pitch = { 115, 120},  sound = ")weapons/zs_scar/scar_fire1.ogg" } )  SWEP.Base = "weapon_zs_base" local BaseClass = baseclass.Get("weapon_zs_base")  SWEP.HoldType = "smg"  SWEP.ViewModel = "models/weapons/cstrike/c_smg_ump45.mdl" SWEP.WorldModel = "models/weapons/w_smg_ump45.mdl" SWEP.UseHands = true  SWEP.Primary.Damage = 26 SWEP.Primary.NumShots = 1 SWEP.Primary.Delay = 0.09  SWEP.Primary.ClipSize = 35 SWEP.Primary.Automatic = true SWEP.Primary.Ammo = "smg1" GAMEMODE:SetupDefaultClip(SWEP.Primary)  SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SMG1  SWEP.ConeMax = 3.4 SWEP.ConeMin = 2.1  SWEP.WalkSpeed = SPEED_NORMAL  SWEP.Tier = 5  SWEP.IronSightsPos = Vector(-8.3, 0, 5) SWEP.IronSightsAng = Vector(0, 0, 0)  SWEP.FireModes = 3 SWEP.FireModeNames = {"Full-Auto", "Semi-Auto", "Buff"} SWEP.FireModeNames3D = {"AUTO", "SEMI", "BUFF"}  SWEP.WeaponBuildup = {     Colour = {150, 150, 30, 255},     Name = "Assists" }  SWEP.ResistanceAmmoAs = "highsmg" SWEP.ReloadConsumption = 0.88  GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_RELOAD_SPEED, 0.06, 1) GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_CLIP_SIZE, 2, 1)  function SWEP:EmitFireSound()  self:EmitSound("vectorfiringnoise1")  self:EmitSound("vectorfiringnoise2") end  function SWEP:OnAssist(zombie)     local assister = self:GetOwner()      if assister:IsValid() then         self:SetWeaponBuildup(math.min(1, self:GetWeaponBuildup() + 0.07))     end end  function SWEP:SecondaryAttack()  local fm = self:GetFireMode()  if fm == 2 then  if self:CanSecondaryAttack() and self:GetWeaponBuildup() >= 1 then  self:SetNextSecondaryFire(CurTime() + 1)              if SERVER and self:GetWeaponBuildup() >= 1 then                 local owner = self:GetOwner()                 local count = 0                 local hit_pos = owner:WorldSpaceCenter()                  owner:GiveStatus("buff_slipstream", 12)                  for _, ent in pairs(ents.FindInSphere(hit_pos, 100)) do                     if ent and ent:IsValidLivingHuman() and ent ~= owner and WorldVisible(hit_pos, ent:NearestPoint(hit_pos)) then                         count = count + 1                          ent:GiveStatus("buff_slipstream", 12)                          net.Start("zs_buffby")                             net.WriteEntity(owner)                             net.WriteString("'Razor' Kriss Vector")                         net.Send(ent)                          if count >= 8 then break end                     end                 end                  self:EmitSound("items/suitchargeok1.wav", 75, 111)                 self:EmitSound("weapons/slam/mine_mode.wav", 75, 50, 0.5, CHAN_AUTO)                  self:SetWeaponBuildup(0)                 self:SetFireMode(0)             end  end  else  BaseClass.SecondaryAttack(self)  end end