AddCSLuaFile()  SWEP.PrintName = "'Owens' Handgun" SWEP.Description = "A somewhat less accurate pistol that fires two shots that deal respectable total damage."  SWEP.Slot = 1 SWEP.SlotPos = 0  if CLIENT then  SWEP.ViewModelFlip = false  SWEP.ViewModelFOV = 60   SWEP.HUD3DBone = "ValveBiped.square"  SWEP.HUD3DPos = Vector(1.1, 0.25, -2)  SWEP.HUD3DScale = 0.015 end  SWEP.Base = "weapon_zs_base"  SWEP.HoldType = "pistol"  SWEP.ViewModel = "models/weapons/c_pistol.mdl" SWEP.WorldModel = "models/weapons/w_pistol.mdl" SWEP.UseHands = true  SWEP.CSMuzzleFlashes = false  SWEP.ReloadSound = Sound("weapons/pistol/pistol_reload1.wav") SWEP.Primary.Sound = Sound("^weapons/pistol/pistol_fire3.wav") SWEP.Primary.Damage = 14.2 SWEP.Primary.NumShots = 2 SWEP.Primary.Delay = 0.25  SWEP.Primary.ClipSize = 10 SWEP.Primary.Automatic = false SWEP.Primary.Ammo = "pistol" SWEP.Primary.ClipMultiplier = 12/10 GAMEMODE:SetupDefaultClip(SWEP.Primary)  SWEP.ReloadSpeed = 0.7  SWEP.ConeMax = 4 SWEP.ConeMin = 2.5  SWEP.IronSightsPos = Vector(-5.95, 3, 2.75) SWEP.IronSightsAng = Vector(-0.15, -1, 2)  GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MAX_SPREAD, -0.46, 1) GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MIN_SPREAD, -0.22, 1) GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.0175, 1) 