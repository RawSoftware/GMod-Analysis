SWEP.PrintName = "'Spinfusor' Pulse Disc Launcher" SWEP.Description = "Launches pulse projectiles that deal significant direct and AOE damage. Hold right click to charge, and the disc will penetrate targets."  SWEP.Slot = 3 SWEP.SlotPos = 0  SWEP.ShowViewModel = false SWEP.ShowWorldModel = false  SWEP.Base = "weapon_zs_baseproj" local BaseClass = baseclass.Get("weapon_zs_baseproj")  SWEP.HoldType = "crossbow"  SWEP.ViewModel = "models/weapons/c_crossbow.mdl" SWEP.WorldModel = "models/weapons/w_crossbow.mdl" SWEP.UseHands = true  SWEP.CSMuzzleFlashes = false  SWEP.Primary.Damage = 105 SWEP.Primary.Delay = 1.2 SWEP.Primary.Automatic = true SWEP.Secondary.Automatic = true SWEP.Primary.Ammo = "pulse" SWEP.Primary.Sound = Sound("weapons/physcannon/superphys_launch2.wav")  SWEP.Primary.ClipSize = 15 SWEP.Primary.DefaultClip = 30 SWEP.RequiredClip = 1  SWEP.ReloadSpeed = 0.77 SWEP.PlayerReloadSpeedEffectiveness = 0.5  SWEP.Recoil = 3  SWEP.WalkSpeed = SPEED_SLOWER  SWEP.ConeMax = 0 SWEP.ConeMin = 0  SWEP.Tier = 6 SWEP.MaxStock = 2  SWEP.FireAnimSpeed = 0.7  SWEP.ChargeDelay = 0.1  SWEP.Taper = 0.82 SWEP.Radius = 75  GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_RADIUS, 5, 1)  function SWEP:Initialize()  self.BaseClass.Initialize(self)   self.ChargeSound = CreateSound(self, "ambient/levels/citadel/field_loop2.wav") end  function SWEP:CheckCharge()  if self:GetCharging() then  local owner = self:GetOwner()  if not owner:KeyDown(IN_ATTACK2) or self:GetReloadFinish() ~= 0 then  self:EmitFireSound()   self.FireAnimSpeed = 0.3  self:ShootBullets(self.Primary.Damage * (1 + 0.04 * self:GetGunCharge()), self.Primary.NumShots, self:GetCone())  self.IdleAnimation = CurTime() + self:SequenceDuration()  self.FireAnimSpeed = 1   self:SetCharging(false)  self:SetLastChargeTime(CurTime())  self:SetGunCharge(0)  elseif self:GetGunCharge() < 10 and self:GetPrimaryAmmoCount() ~= 0 and self:GetLastChargeTime() + self.ChargeDelay < CurTime() then  self:SetGunCharge(self:GetGunCharge() + 1)  self:SetLastChargeTime(CurTime())  self:TakeCombinedPrimaryAmmo(1)  end   self.ChargeSound:PlayEx(1, math.min(255, 47 + self:GetGunCharge() * 25))  else  self.ChargeSound:Stop()  end end  function SWEP:SetLastChargeTime(lct)  self:SetDTFloat(8, lct) end  function SWEP:GetLastChargeTime()  return self:GetDTFloat(8) end  function SWEP:SetGunCharge(charge)  self:SetDTInt(1, charge) end  function SWEP:GetGunCharge(charge)  return self:GetDTInt(1) end  function SWEP:SetCharging(charge)  self:SetDTBool(1, charge) end  function SWEP:GetCharging()  return self:GetDTBool(1) end  function SWEP:Deploy()  self:SetCharging(false)  self:SetGunCharge(0)   return self.BaseClass.Holster(self) end  function SWEP:SecondaryAttack()  if not self:CanPrimaryAttack() or self:GetCharging() then return end   self:SetNextPrimaryFire(CurTime() + self:GetFireDelay())  self:SetLastChargeTime(CurTime())  self:SetCharging(true)  self:TakeAmmo() end  function SWEP:TakeAmmo()  self:TakePrimaryAmmo(15) end  function SWEP:CanPrimaryAttack()  if self:GetCharging() or self:GetOwner():IsHolding() or self:GetOwner():GetBarricadeGhosting() or self:GetReloadFinish() > 0 then return false end   if self:Clip1() < 12 then  self:EmitSound(self.DryFireSound)  self:SetNextPrimaryFire(CurTime() + math.max(0.25, self.Primary.Delay))  self:SetNextSecondaryFire(CurTime() + math.max(0.25, self.Primary.Delay))  return false  end   return self:GetNextPrimaryFire() <= CurTime() end  function SWEP:EmitReloadSound()  if IsFirstTimePredicted() then  self:EmitSound("weapons/ar2/ar2_reload.wav", 75, 100, 1, CHAN_WEAPON + 21)  self:EmitSound("weapons/smg1/smg1_reload.wav", 75, 100, 1, CHAN_WEAPON + 22)  end end  function SWEP:EmitFireSound()  local deduct = self:GetCharging() and (120 - self:GetGunCharge() * 5) or 100   self:EmitSound("weapons/physcannon/superphys_launch2.wav", 75, deduct, 1)   if self:GetGunCharge() >= 3 then  self:EmitSound("weapons/zs_dds/zs_gc.ogg", 80, deduct + 30, 0.5, CHAN_WEAPON + 23)  end end   util.PrecacheSound("weapons/ar2/ar2_reload.wav") util.PrecacheSound("weapons/smg1/smg1_reload.wav") 