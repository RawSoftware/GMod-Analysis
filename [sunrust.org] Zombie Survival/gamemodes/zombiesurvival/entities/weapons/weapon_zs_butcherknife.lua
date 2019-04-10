AddCSLuaFile()  SWEP.PrintName = "Butcher Knife" SWEP.Description = "A very fast swinging butcher knife, capable of mincing zombies very quickly up close."  if CLIENT then  SWEP.ViewModelFOV = 55  SWEP.ViewModelFlip = false   SWEP.ShowViewModel = false  SWEP.ShowWorldModel = false  SWEP.VElements = {  ["base"] = { type = "Model", model = "models/props_lab/cleaver.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 1, -1), angle = Angle(90, 0, 0), size = Vector(0.8, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }  }  SWEP.WElements = {  ["base"] = { type = "Model", model = "models/props_lab/cleaver.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 1, -3.182), angle = Angle(90, 0, 0), size = Vector(0.8, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }  } end  SWEP.Base = "weapon_zs_basemelee"  SWEP.DamageType = DMG_SLASH  SWEP.ViewModel = "models/weapons/c_crowbar.mdl" SWEP.WorldModel = "models/weapons/w_crowbar.mdl" SWEP.UseHands = true SWEP.NoDroppedWorldModel = true  SWEP.MeleeDamage = 50 SWEP.MeleeRange = 48 SWEP.MeleeSize = 0.875 SWEP.Primary.Delay = 0.45  SWEP.WalkSpeed = SPEED_FAST  SWEP.UseMelee1 = true  SWEP.HitGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE SWEP.MissGesture = SWEP.HitGesture  SWEP.HitDecal = "Manhackcut" SWEP.HitAnim = ACT_VM_MISSCENTER  SWEP.Tier = 2  SWEP.AllowQualityWeapons = true SWEP.Culinary = true  SWEP.BlockRotation = Angle(0, 40, -60) SWEP.BlockOffset = Vector(-10, 7, 5)  SWEP.Stability = 50 SWEP.BlockReduction = 0.7  SWEP.StaminaUsage = 0.11 SWEP.IsDodge = 0.75  GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.05) GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_STAMINA_USAGE, -0.005)  function SWEP:PlaySwingSound()  self:EmitSound("weapons/knife/knife_slash"..math.random(2)..".wav", 72, math.Rand(85, 95)) end  function SWEP:PlayHitSound()  self:EmitSound("weapons/knife/knife_hitwall1.wav", 72, math.Rand(75, 85)) end  function SWEP:PlayHitFleshSound()  self:EmitSound("physics/flesh/flesh_squishy_impact_hard"..math.random(4)..".wav")  self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav") end  function SWEP:PostOnMeleeHit(hitent, hitflesh, tr)    end 