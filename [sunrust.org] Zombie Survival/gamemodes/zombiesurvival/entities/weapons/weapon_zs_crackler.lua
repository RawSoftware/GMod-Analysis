AddCSLuaFile()  SWEP.PrintName = "'Crackler' Assault Rifle" SWEP.Description = "An unsophisticated assault rifle which has good damage and accuracy."  SWEP.Slot = 2 SWEP.SlotPos = 0  if CLIENT then  SWEP.ViewModelFlip = false  SWEP.ViewModelFOV = 60   SWEP.HUD3DBone = "v_weapon.famas"  SWEP.HUD3DPos = Vector(1.1, -3.5, 10)  SWEP.HUD3DScale = 0.02 end  SWEP.Base = "weapon_zs_base" local BaseClass = baseclass.Get("weapon_zs_base")  SWEP.HoldType = "ar2"  SWEP.ViewModel = "models/weapons/cstrike/c_rif_famas.mdl" SWEP.WorldModel = "models/weapons/w_rif_famas.mdl" SWEP.UseHands = true  SWEP.ReloadSound = Sound("weapons/famas/famas_clipout.wav") SWEP.Primary.Sound = Sound(")weapons/famas/famas-1.wav") SWEP.Primary.Damage = 15.6 SWEP.Primary.NumShots = 1 SWEP.Primary.Delay = 0.175  SWEP.Primary.ClipSize = 22 SWEP.Primary.Automatic = true SWEP.Primary.Ammo = "ar2" GAMEMODE:SetupDefaultClip(SWEP.Primary)  SWEP.ConeMax = 3.25 SWEP.ConeMin = 1.55  SWEP.ReloadSpeed = 1.1  SWEP.WalkSpeed = SPEED_SLOW  SWEP.IronSightsPos = Vector(-3, 3, 2)  SWEP.HeadshotMulti = 2  SWEP.FireModes = 2 SWEP.FireModeNames = {"Full-Auto", "Semi-Auto"} SWEP.FireModeNames3D = {"AUTO", "SEMI"}  GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MAX_SPREAD, -0.375, 1) GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.01, 1) local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Snapper' Combat Rifle", "Loses automatic fire rate but gains a bit of damage, headshot multiplier and accuracy", function(wept)  wept.Primary.Damage = wept.Primary.Damage * (19/15.6)  wept.Primary.Delay = wept.Primary.Delay * 1.9  wept.Primary.ClipSize = wept.Primary.ClipSize - 7  wept.ConeMin = wept.ConeMin * 0.5  wept.ConeMax = wept.ConeMax * 0.5  wept.Primary.Automatic = false  wept.FireModes = 1     wept.HeadshotMulti = wept.HeadshotMulti + 0.1 end) branch.CollectiveName = "Combat" GAMEMODE:AttachWeaponModifierToBranch(branch, WEAPON_MODIFIER_CLIP_SIZE, 2) GAMEMODE:AttachWeaponModifierToBranch(branch, WEAPON_MODIFIER_FIRE_DELAY, -0.0275, 1) GAMEMODE:AttachWeaponModifierToBranch(branch, WEAPON_MODIFIER_HEADSHOT_MULTI, 0.05)  branch = GAMEMODE:AddNewRemantleBranch(SWEP, 2, "'Fizzler' Twin Rifle", "Fires two shots in parallel that can pierce but more slowly, less accurately.", function(wept)  wept.Primary.Damage = wept.Primary.Damage * 0.53     wept.Primary.NumShots = 2     wept.Primary.Delay = wept.Primary.Delay * 1.7     wept.Pens = 1     wept.PenTaper = 0.17     wept.ConeMin = wept.ConeMin * (1.9/1.55)     wept.ConeMax = wept.ConeMax * (3.7/3.25)     wept.FireAnimSpeed = 0.75      function wept:ShootBullets(dmg, numbul, cone)         local owner = self:GetOwner()         local sprd = 0.32*cone          self:SendWeaponAnimation()         owner:DoAttackEvent()          DO_BULLET_LAG_COMP = true         for i = 0, numbul - 1 do             local angle = owner:GetAimVector():Angle()             local index = i == 0 and -1 or 1             angle:RotateAroundAxis(angle:Up(), index * sprd)              owner:FireBulletsLua(owner:GetShootPos(), angle:Forward(), cone, 1, dmg, nil, self.Primary.KnockbackScale, self.TracerName, self.BulletCallback, self.Primary.HullSize, nil, self.Primary.MaxDistance, nil, self)         end         DO_BULLET_LAG_COMP = nil     end      function wept:EmitFireSound()         self:EmitSound(self.Primary.Sound, 75, math.random(85, 91))     end      local mat = Material("phoenix_storms/future_vents")  wept.PreDrawViewModel = function(self, vm)  render.MaterialOverrideByIndex(0, mat)         render.SetColorModulation(111/255, 135/255, 111/255)   BaseClass.PreDrawViewModel(self, vm)  end  wept.PostDrawViewModel = function(self, vm)  render.MaterialOverrideByIndex(0)         render.SetColorModulation(1, 1, 1)   BaseClass.PostDrawViewModel(self, vm)  end end) branch.CollectiveName = "Twin" branch.Colors = {Color(135, 240, 120), Color(85, 190, 70), Color(55, 180, 35), Color(30, 160, 30)} GAMEMODE:AttachWeaponModifierToBranch(branch, WEAPON_MODIFIER_FIRE_DELAY, -0.03)