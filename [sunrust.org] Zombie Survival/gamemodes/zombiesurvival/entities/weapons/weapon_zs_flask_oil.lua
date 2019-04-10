 SWEP.PrintName = "Flask of Oil" SWEP.Description = "A flask of oil. Zombies in radius when doused with oil, become ignited if they take explosive damage."  SWEP.ViewModelFlip = false SWEP.ViewModelFOV = 70  SWEP.Base = "weapon_zs_basethrown"  SWEP.ViewModel = "models/weapons/c_grenade.mdl" SWEP.WorldModel = "models/weapons/w_grenade.mdl"  SWEP.ShowViewModel = false SWEP.ShowWorldModel = false  SWEP.Primary.Ammo = "flask_oil"  SWEP.MaxStock = 4  SWEP.ThrownProjectile = "projectile_flask" SWEP.ThrowAngVel = 30 SWEP.ThrowVel = 600  SWEP.VElements = {  ["base"] = { type = "Model", model = "models/props_junk/glassjug01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.381, 2.617, 2.062), angle = Angle(180, 12.243, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["base+"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 0, 4.07), angle = Angle(180, 12.243, 0), size = Vector(0.123, 0.123, 0.085), color = Color(20, 20, 20, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} } } SWEP.WElements = {  ["base"] = { type = "Model", model = "models/props_junk/glassjug01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.506, 1.82, 1.758), angle = Angle(-164.991, 19.691, 8.255), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["base+"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 0, 4.07), angle = Angle(180, 12.243, 0), size = Vector(0.123, 0.123, 0.085), color = Color(20, 20, 20, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} } }  function SWEP:ThrownModify(ent)     ent:SetDTInt(DT_FLASK_TYPE, 3) end