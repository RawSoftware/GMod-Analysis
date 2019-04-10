SWEP.PrintName = "'Nova Blaster' Pulse Revolver" SWEP.Description = "A pulse revolver that shoots a bouncing pulse projectile and also slows zombies."  SWEP.Base = "weapon_zs_baseproj"  SWEP.HoldType = "revolver"  SWEP.ViewModel = "models/weapons/c_357.mdl" SWEP.WorldModel = "models/weapons/w_357.mdl" SWEP.ShowViewModel = false SWEP.ShowWorldModel = false SWEP.UseHands = true  SWEP.CSMuzzleFlashes = false  SWEP.Primary.Sound = Sound("weapons/357/357_fire2.wav") SWEP.Primary.Delay = 0.6 SWEP.Primary.Damage = 62 SWEP.Primary.NumShots = 1  SWEP.Primary.ClipSize = 24 SWEP.Primary.Automatic = false SWEP.Primary.Ammo = "pulse" SWEP.Primary.DefaultClip = 24  SWEP.RequiredClip = 3  SWEP.ConeMax = 3.5 SWEP.ConeMin = 1.75  SWEP.WalkSpeed = SPEED_SLOW  SWEP.IronSightsPos = Vector(-4.65, 4, 0.25) SWEP.IronSightsAng = Vector(0, 0, 1)  SWEP.Tier = 2 SWEP.LegDamage = 5.5  GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MAX_SPREAD, -0.7, 1) GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MIN_SPREAD, -0.4, 1) GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.05) GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Nova Helix' Pulse Revolver", "Fires two projectiles in a wavy formation. Has a smaller clip size and reduced fire rate.", function(wept)  wept.Primary.Damage = wept.Primary.Damage * 0.55     wept.Primary.Delay = wept.Primary.Delay * 1.2  wept.Primary.ProjVelocity = 450  wept.Primary.NumShots = 2  wept.Primary.ClipSize = 18  wept.SameSpread = true  if SERVER then  wept.EntModify = function(self, ent)  ent:SetDTBool(0, true)  ent.Branched = true  end  end   wept.VElements = {  ["spinner"] = { type = "Model", model = "models/props_borealis/bluebarrel001.mdl", bone = "Bullet1", rel = "", pos = Vector(0, 0.676, 1.648), angle = Angle(-180, 0, 0), size = Vector(0.078, 0.078, 0.041), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["barrel11"] = { type = "Model", model = "models/items/boxflares.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "barrel10", pos = Vector(0.888, 0, 0.159), angle = Angle(10, 0, 0), size = Vector(0.101, 0.273, 0.642), color = Color(100, 115, 75, 255), surpresslightning = false, material = "models/props_junk/shoe001a", skin = 0, bodygroup = {} },  ["chamber"] = { type = "Model", model = "models/items/boxmrounds.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(100, 115, 75, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["barrel7-2"] = { type = "Model", model = "models/props_borealis/bluebarrel001.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "barrel7", pos = Vector(0.238, -3.609, 0), angle = Angle(0, 0, -180), size = Vector(0.018, 0.018, 0.018), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["uragan"] = { type = "Model", model = "models/items/357ammo.mdl", bone = "Python", rel = "", pos = Vector(0, 1.615, 0), angle = Angle(90, 0, -90), size = Vector(0.009, 0.009, 0.009), color = Color(100, 115, 75, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["barrel7-3"] = { type = "Model", model = "models/props_borealis/bluebarrel001.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "barrel7-2", pos = Vector(-0.638, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.018, 0.018, 0.018), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["ironsight"] = { type = "Model", model = "models/items/boxsrounds.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "barrel6", pos = Vector(0, -0.24, 1.692), angle = Angle(0, 0, 180), size = Vector(0.019, 0.035, 0.05), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["barrel8"] = { type = "Model", model = "models/items/boxflares.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "uragan", pos = Vector(0, 0, -0.88), angle = Angle(0, 0, 0), size = Vector(0.36, 0.245, 0.248), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["barrel7"] = { type = "Model", model = "models/props_borealis/bluebarrel001.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "uragan", pos = Vector(3.233, 0, -0.304), angle = Angle(-90, 90, 0), size = Vector(0.039, 0.039, 0.019), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["barrel13"] = { type = "Model", model = "models/props_junk/meathook001a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "uragan", pos = Vector(0.233, 0, 0.305), angle = Angle(0, -90, 15.102), size = Vector(0.286, 0.305, 0.125), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["barrel6"] = { type = "Model", model = "models/items/boxsrounds.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "barrel5", pos = Vector(0, 0.8, -0.329), angle = Angle(0, 0, 16.666), size = Vector(0.071, 0.063, 0.128), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["tube2"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "uragan", pos = Vector(3.279, 0, 2.448), angle = Angle(90, 0, 0), size = Vector(0.5, 0.273, 0.485), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["barrel5"] = { type = "Model", model = "models/items/boxsrounds.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "uragan", pos = Vector(6.534, 0, 2.262), angle = Angle(0, 89.678, -17.173), size = Vector(0.071, 0.071, 0.071), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["barrel3"] = { type = "Model", model = "models/maxofs2d/hover_plate.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "uragan", pos = Vector(2.701, 0, 2.114), angle = Angle(86.527, 180, 0), size = Vector(0.188, 0.075, 0.467), color = Color(100, 115, 75, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["barrel2"] = { type = "Model", model = "models/maxofs2d/hover_plate.mdl", bone = "Python", rel = "uragan", pos = Vector(-0.849, 0, 2.04), angle = Angle(80, 0, 0), size = Vector(0.188, 0.075, 0.467), color = Color(100, 115, 75, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["tube"] = { type = "Model", model = "models/items/boxmrounds.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "uragan", pos = Vector(5.422, 0, 0.794), angle = Angle(0, 90, 0), size = Vector(0.07, 0.261, 0.15), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["barrel1"] = { type = "Model", model = "models/maxofs2d/light_tubular.mdl", bone = "Python", rel = "uragan", pos = Vector(-0.55, 0, 1.748), angle = Angle(0, 90, -90), size = Vector(0.68, 0.68, 0.18), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["barrel9"] = { type = "Model", model = "models/items/boxsrounds.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "uragan", pos = Vector(-2.118, 0, -0.964), angle = Angle(11.454, 0, 0), size = Vector(0.356, 0.059, 0.174), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["barrel10"] = { type = "Model", model = "models/items/boxflares.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "uragan", pos = Vector(-3.944, 0, -3.618), angle = Angle(-19.883, 0, 0), size = Vector(0.101, 0.273, 0.642), color = Color(180, 190, 15, 255), surpresslightning = false, material = "models/props_junk/shoe001a", skin = 0, bodygroup = {} },  ["barrel12"] = { type = "Model", model = "models/props_junk/meathook001a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "uragan", pos = Vector(1.279, 0, -0.239), angle = Angle(0, 90, 59.189), size = Vector(0.305, 0.111, 0.111), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["barrel4"] = { type = "Model", model = "models/items/boxflares.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "uragan", pos = Vector(-1.734, 0, 1.445), angle = Angle(0, 90, -70), size = Vector(0.029, 0.092, 0.15), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["tube3"] = { type = "Model", model = "models/props_junk/flare.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "uragan", pos = Vector(5.171, 0, 0.892), angle = Angle(90, -90, -90), size = Vector(0.564, 0.564, 0.428), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["spinner2"] = { type = "Model", model = "models/items/combine_rifle_ammo01.mdl", bone = "Cylinder", rel = "spinner", pos = Vector(0, 0, 1.572), angle = Angle(-180, 0, 0), size = Vector(0.335, 0.335, 0.317), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} }  }   wept.WElements = {  ["spinner"] = { type = "Model", model = "models/props_borealis/bluebarrel001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "uragan", pos = Vector(1.45, 0, 1.529), angle = Angle(-90, 0, 0), size = Vector(0.078, 0.078, 0.041), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["barrel4"] = { type = "Model", model = "models/items/boxflares.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "uragan", pos = Vector(-1.734, 0, 1.445), angle = Angle(0, 90, -70), size = Vector(0.029, 0.092, 0.15), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["uragan"] = { type = "Model", model = "models/items/357ammo.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.559, 1.355, -2.738), angle = Angle(0, 0, 180), size = Vector(0.009, 0.009, 0.009), color = Color(100, 115, 75, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["barrel8"] = { type = "Model", model = "models/items/boxflares.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "uragan", pos = Vector(0, 0, -0.88), angle = Angle(0, 0, 0), size = Vector(0.36, 0.245, 0.248), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["barrel7"] = { type = "Model", model = "models/props_borealis/bluebarrel001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "uragan", pos = Vector(3.233, 0, -0.304), angle = Angle(-90, 90, 0), size = Vector(0.039, 0.039, 0.019), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["barrel13"] = { type = "Model", model = "models/props_junk/meathook001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "uragan", pos = Vector(-0.648, 0, 0.398), angle = Angle(0, -90, 15.102), size = Vector(0.286, 0.305, 0.125), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["tube2"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "uragan", pos = Vector(3.279, 0, 2.448), angle = Angle(90, 0, 0), size = Vector(0.5, 0.273, 0.485), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["barrel5"] = { type = "Model", model = "models/items/boxsrounds.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "uragan", pos = Vector(6.534, 0, 2.18), angle = Angle(0, 89.678, -17.173), size = Vector(0.071, 0.071, 0.071), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["barrel3"] = { type = "Model", model = "models/maxofs2d/hover_plate.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "uragan", pos = Vector(2.701, 0, 2.114), angle = Angle(86.527, 180, 0), size = Vector(0.188, 0.075, 0.467), color = Color(100, 115, 75, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["barrel2"] = { type = "Model", model = "models/maxofs2d/hover_plate.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "uragan", pos = Vector(-0.849, 0, 2.04), angle = Angle(80, 0, 0), size = Vector(0.188, 0.075, 0.467), color = Color(100, 115, 75, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["spinner2"] = { type = "Model", model = "models/items/combine_rifle_ammo01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "spinner", pos = Vector(0, 0, 1.572), angle = Angle(-180, 0, 0), size = Vector(0.335, 0.335, 0.317), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["barrel1"] = { type = "Model", model = "models/maxofs2d/light_tubular.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "uragan", pos = Vector(-0.55, 0, 1.748), angle = Angle(0, 90, -90), size = Vector(0.68, 0.68, 0.18), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["barrel9"] = { type = "Model", model = "models/items/boxsrounds.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "uragan", pos = Vector(-2.118, 0, -0.964), angle = Angle(11.454, 0, 0), size = Vector(0.356, 0.059, 0.174), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["barrel12"] = { type = "Model", model = "models/props_junk/meathook001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "uragan", pos = Vector(0.486, 0, -0.239), angle = Angle(0, 90, 59.189), size = Vector(0.305, 0.111, 0.111), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["tube"] = { type = "Model", model = "models/items/boxmrounds.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "uragan", pos = Vector(5.422, 0, 0.794), angle = Angle(0, 90, 0), size = Vector(0.07, 0.261, 0.15), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["barrel10"] = { type = "Model", model = "models/items/boxflares.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "uragan", pos = Vector(-3.944, 0, -3.618), angle = Angle(-19.883, 0, 0), size = Vector(0.101, 0.273, 0.642), color = Color(180, 190, 15, 255), surpresslightning = false, material = "models/props_junk/shoe001a", skin = 0, bodygroup = {} },  ["tube3"] = { type = "Model", model = "models/props_junk/flare.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "uragan", pos = Vector(5.171, 0, 0.892), angle = Angle(90, -90, -90), size = Vector(0.564, 0.564, 0.428), color = Color(100, 115, 75, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} }  } end).CollectiveName = "Helix"  function SWEP:EmitFireSound()  self:EmitSound("weapons/stunstick/alyx_stunner2.wav", 72, 219, 0.75)  self:EmitSound("weapons/physcannon/superphys_launch1.wav", 72, 208, 0.65, CHAN_AUTO) end 