AddCSLuaFile()  SWEP.Base = "weapon_zs_gunturret"  SWEP.PrintName = "Rocket Turret" SWEP.Description = "An automated turret that fires explosive missiles."  SWEP.Primary.Damage = 94  SWEP.GhostStatus = "ghost_gunturret_rocket" SWEP.DeployClass = "prop_gunturret_rocket" SWEP.TurretAmmoType = "impactmine" SWEP.TurretAmmoStartAmount = 12 SWEP.TurretSpread = 1 SWEP.TurretFireRate = 2.35  SWEP.Primary.Ammo = "turret_rocket"  SWEP.Tier = 5  GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_TURRET_SPREAD, -0.45) GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_TURRET_DELAY, -0.2, 1)