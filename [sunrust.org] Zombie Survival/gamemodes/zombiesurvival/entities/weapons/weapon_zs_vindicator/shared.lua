SWEP.PrintName = "'Vindicator' Grenade Launcher" SWEP.Description = "Rapidly fires highly explosive grenades with low taper. Unparalleled for clearing a horde. Can eventually launch a cluster bomb for 6 ammo, dealing massive damage."  SWEP.Base = "weapon_zs_baseproj" local BaseClass = baseclass.Get("weapon_zs_baseproj")  SWEP.HoldType = "smg"  SWEP.ViewModel = "models/weapons/cstrike/c_rif_m4a1.mdl" SWEP.WorldModel = "models/weapons/w_smg_ump45.mdl" SWEP.UseHands = true  SWEP.CSMuzzleFlashes = false  SWEP.Primary.ClipSize = 7 SWEP.Primary.Automatic = true SWEP.Primary.Ammo = "impactmine" SWEP.Primary.Delay = 0.55 SWEP.Primary.DefaultClip = 7 SWEP.Primary.Damage = 93 SWEP.Primary.NumShots = 1  SWEP.ConeMax = 3.5 SWEP.ConeMin = 3  SWEP.WalkSpeed = SPEED_SLOW  SWEP.Tier = 6  SWEP.Taper = 0.82 SWEP.Radius = 75  SWEP.FireAnimSpeed = 0.8 SWEP.ReloadSpeed   = 0.675  SWEP.MaxStock = 2  SWEP.WeaponBuildup = {     Colour  = {150, 150, 30, 255},     Name    = "Assists" }  GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_RELOAD_SPEED, 0.025, 1) GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.03) GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_CLIP_SIZE, 1)  function SWEP:OnAssist(zombie)     local assister = self:GetOwner()      if assister:IsValid() then         self:SetWeaponBuildup(math.min(1, self:GetWeaponBuildup() + 0.06))     end end  function SWEP:SecondaryAttack()     if not self:CanPrimaryAttack() or self:Clip1() < 6 then return end      if self:GetWeaponBuildup() >= 1 then         local owner = self:GetOwner()          self:SetNextPrimaryFire(CurTime() + self:GetFireDelay() * 2)          self:EmitFireSound(true)         self:SendWeaponAnimation()         self:TakePrimaryAmmo(6)         self:SetWeaponBuildup(0)          owner:DoAttackEvent()          if SERVER then             local ent = self:ShootProjectile(self.Primary.Damage * 0.6, 0, "projectile_flakbomb", 900)             ent.SubProjectile = "projectile_grenade_ch"             ent.FlakVelocity = 45         end     end end  function SWEP:EmitFireSound()  self:EmitSound("weapons/grenade_launcher1.wav", 75, math.random(85, 90), 0.6)  self:EmitSound("weapons/zs_gren/grenade_launcher.ogg", 75, 100, 0.9, CHAN_AUTO + 20) end 