AddCSLuaFile()  SWEP.PrintName = "'Peashooter' Handgun" SWEP.Description = "A low damage output pistol that only uses half the ammo."  SWEP.Slot = 1 SWEP.SlotPos = 0  if CLIENT then  SWEP.ViewModelFOV = 60  SWEP.ViewModelFlip = false   SWEP.HUD3DBone = "v_weapon.p228_Slide"  SWEP.HUD3DPos = Vector(-0.88, 0.35, 1)  SWEP.HUD3DAng = Angle(0, 0, 0)  SWEP.HUD3DScale = 0.015 end  SWEP.Base = "weapon_zs_base"  SWEP.HoldType = "pistol"  SWEP.ViewModel = "models/weapons/cstrike/c_pist_p228.mdl" SWEP.WorldModel = "models/weapons/w_pist_p228.mdl" SWEP.UseHands = true  SWEP.Primary.Sound = Sound(")weapons/p228/p228-1.wav") SWEP.Primary.Damage = 16.5 SWEP.Primary.NumShots = 1 SWEP.Primary.Delay = 0.18  SWEP.Primary.ClipSize = 9 SWEP.Primary.Automatic = false SWEP.Primary.Ammo = "pistol" SWEP.Primary.ClipMultiplier = 12/18 * 2   GAMEMODE:SetupDefaultClip(SWEP.Primary)  SWEP.ConeMax = 4 SWEP.ConeMin = 0.75  SWEP.HeadshotMulti = 2  SWEP.DamageScaling = 1.1  GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_CLIP_SIZE, 1) GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MAX_SPREAD, -0.25, 1) GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_HEADSHOT_MULTI, 0.05)  local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Peashooter' Auto Handgun", "Fully automatic, increased clip size at the cost of accuracy", function(wept)  wept.Primary.Delay = 0.15  wept.Primary.Automatic = true  wept.Primary.ClipSize = wept.Primary.ClipSize + 3     wept.Primary.Damage = wept.Primary.Damage * (15/16.5)   wept.ConeMin = 2.25 end)  branch.CollectiveName = "Auto" branch.DamageScaling = 0.85  SWEP.IronSightsPos = Vector(-6, -1, 2.25)  function SWEP:SetAltUsage(usage)  self:SetDTBool(1, usage) end  function SWEP:GetAltUsage()  return self:GetDTBool(1) end  function SWEP:PrimaryAttack()  if not self:CanPrimaryAttack() then return end  self:SetNextPrimaryFire(CurTime() + self:GetFireDelay())  self:EmitFireSound()   local altuse = self:GetAltUsage()  if not altuse then  self:TakeAmmo()  end  self:SetAltUsage(not altuse)   self:ShootBullets(self.Primary.Damage, self.Primary.NumShots, self:GetCone())  self.IdleAnimation = CurTime() + self:SequenceDuration() end  if not CLIENT then return end  function SWEP:GetDisplayAmmo(clip, spare, maxclip)  local minus = self:GetAltUsage() and 0 or 1  return math.max(0, (clip * 2) - minus), spare * 2, maxclip * 2 end 