SWEP.PrintName = "'Slinger' Bolt Pistol" SWEP.Description = "A slow loading, inaccurate bolt pistol with no special properties."  SWEP.Base = "weapon_zs_baseproj"  SWEP.HoldType = "revolver"  SWEP.ViewModel = "models/weapons/cstrike/c_pist_usp.mdl" SWEP.WorldModel = "models/weapons/w_pist_p228.mdl" SWEP.UseHands = true  SWEP.ShowViewModel = true SWEP.ShowWorldModel = true SWEP.ViewModelBoneMods = {}  SWEP.CSMuzzleFlashes = false  SWEP.Primary.Sound = Sound("weapons/crossbow/fire1.wav") SWEP.Primary.Delay = 1 SWEP.Primary.Automatic = true SWEP.Primary.Damage = 75  SWEP.Primary.ClipSize = 1 SWEP.Primary.Ammo = "XBowBolt" SWEP.Primary.ClipMultiplier = 2 GAMEMODE:SetupDefaultClip(SWEP.Primary)  SWEP.ConeMax = 2.5 SWEP.ConeMin = 1.2  SWEP.NextZoom = 0  SWEP.ReloadSpeed = 1.77  SWEP.OverkillFactor = 0.3  GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_RELOAD_SPEED, 0.07) GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Darter' Bolt Pistol", "Deals less damage but has much higher velocity", function(wept)  wept.Primary.Damage = wept.Primary.Damage * 0.91  wept.Primary.ProjVelocity = 2300  if SERVER then  wept.EntModify = function(self, ent)  ent:SetDTBool(0, true)  end  end end).CollectiveName = "Darter" local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 2, "'Hurler' Bolt Pistol", "Greater maximum accuracy, less damage at close range and more damage from afar", function(wept)  wept.Primary.Damage = wept.Primary.Damage * 0.76  wept.ConeMin = 0.3  wept.Primary.ProjVelocity = 1100  if SERVER then  wept.EntModify = function(self, ent)  ent:SetDTBool(1, true)  end  end end) branch.Colors = {Color(255, 190, 180), Color(255, 160, 150), Color(215, 120, 150), Color(175, 100, 140)} branch.NewNames = {"Range", "Seeker", "Searcher"} branch.CollectiveName= "Hurler"  function SWEP:Deploy()  self:SendWeaponAnim( self:Clip1() <= 0 and ACT_VM_DRAW or ACT_VM_DRAW_SILENCED )  return self.BaseClass.Deploy(self) end  function SWEP:SendReloadAnimation()  self:SendWeaponAnim(ACT_VM_ATTACH_SILENCER) end  function SWEP:EmitReloadFinishSound()  if IsFirstTimePredicted() then  self:EmitSound("weapons/galil/galil_boltpull.wav", 70, 190)  end end  function SWEP:EmitReloadSound()  if IsFirstTimePredicted() then  self:EmitSound(")weapons/usp/usp_silencer_on.wav", 70, math.min( 120 * self:GetReloadSpeedMultiplier(), 255 ) , 0.9, CHAN_AUTO)  end end  function SWEP:EmitFireSound()  self:EmitSound("weapons/crossbow/fire1.wav", 70, 230, 0.9, CHAN_WEAPON) end  function SWEP:Think()  if self:GetIronsights() and not self:GetOwner():KeyDown(IN_ATTACK2) then  self:SetIronsights(false)  end   if self:GetReloadFinish() > 0 then  if CurTime() >= self:GetReloadFinish() then  self:FinishReload()  end  elseif self.IdleAnimation and self.IdleAnimation <= CurTime() then  self.IdleAnimation = nil  self:SendWeaponAnim( self:Clip1() <= 0 and ACT_VM_IDLE or ACT_VM_IDLE_SILENCED )  end end     function SWEP:FinishReload()  self:SendWeaponAnim(ACT_VM_IDLE_SILENCED)  self:SetNextReload(0)  self:SetReloadStart(0)  self:SetReloadFinish(0)  self:EmitReloadFinishSound()   local owner = self:GetOwner()  if not owner:IsValid() then return end   local max1 = self:GetPrimaryClipSize()  local max2 = self:GetMaxClip2()   if max1 > 0 then  local ammotype = self:GetPrimaryAmmoType()  local spare = owner:GetAmmoCount(ammotype)  local current = self:Clip1()  local needed = max1 - current   needed = math.min(spare, needed)   self:SetClip1(current + needed)  if SERVER then  owner:RemoveAmmo(needed, ammotype)  end  end   if max2 > 0 then  local ammotype = self:GetSecondaryAmmoType()  local spare = owner:GetAmmoCount(ammotype)  local current = self:Clip2()  local needed = max2 - current   needed = math.min(spare, needed)   self:SetClip2(current + needed)  if SERVER then  owner:RemoveAmmo(needed, ammotype)  end  end end  util.PrecacheSound("weapons/crossbow/bolt_load1.wav") util.PrecacheSound("weapons/crossbow/bolt_load2.wav") 