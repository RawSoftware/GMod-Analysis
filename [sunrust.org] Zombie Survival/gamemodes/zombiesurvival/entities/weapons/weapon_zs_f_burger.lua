AddCSLuaFile()  SWEP.Base = "weapon_zs_basefood"  SWEP.PrintName = "Hamburger"  if CLIENT then     SWEP.VElements = {      ["borger"] = { type = "Model", model = "models/food/burger.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-4.194, 3.151, -2.769), angle = Angle(-85.325, 0, 0), size = Vector(0.54, 0.54, 0.54), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }     }   SWEP.WElements = {  ["borger"] = { type = "Model", model = "models/food/burger.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10.437, 3.279, 2.365), angle = Angle(119.647, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }  } end  SWEP.ViewModel = "models/weapons/c_grenade.mdl" SWEP.WorldModel = "models/food/burger.mdl"  SWEP.Primary.Ammo = "foodburger"  SWEP.FoodHealth = 20 SWEP.FoodEatTime = 6.5