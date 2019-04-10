SWEP.PrintName = "Barbed Wire" SWEP.Description = "Left click on props to place barbed wire. Barbed wire damages zombies that hit or stand on nailed props. The amount of health on the prop dictates how many nails are used."  SWEP.Base = "weapon_zs_basemelee"  SWEP.ViewModel = "models/weapons/c_bugbait.mdl" SWEP.WorldModel = "models/weapons/w_pistol.mdl" SWEP.UseHands = true  SWEP.HoldType = "slam"  SWEP.WalkSpeed = SPEED_FAST  SWEP.AmmoIfHas = true  SWEP.Primary.ClipSize = 1 SWEP.Primary.Automatic = false SWEP.Primary.Ammo = "gaussenergy" SWEP.Primary.Delay = 1 SWEP.Primary.DefaultClip = 1  SWEP.Secondary.ClipSize = 1 SWEP.Secondary.DefaultClip = 1 SWEP.Secondary.Automatic = false SWEP.Secondary.Ammo = "dummy"  SWEP.BoxPhysicsMin = Vector(-4, -4, -4) SWEP.BoxPhysicsMax = Vector(4, 4, 4)  function SWEP:Initialize()  self:SetWeaponHoldType(self.HoldType)  GAMEMODE:DoChangeDeploySpeed(self)   if CLIENT then  self:SCKInit()  end end  function SWEP:CanPrimaryAttack()  if self:GetOwner():IsHolding() or self:GetOwner():GetBarricadeGhosting() then return false end   return self:GetNextPrimaryFire() <= CurTime() end  function SWEP:PrimaryAttack()  if not self:CanPrimaryAttack() then return end  self:SetNextPrimaryFire(CurTime() + 1)   local owner = self:GetOwner()  local vm = owner:GetViewModel()  if IsValid(vm) then  vm:SendViewModelMatchingSequence(vm:LookupSequence("squeeze") or 0)  end  owner:DoAttackEvent()   local tr = owner:CompensatedMeleeTrace(72, 3, nil, nil, nil, true)  local trent = tr.Entity   if trent:IsNailed() and not trent:GetDTBool(DT_PROP_BOOL_BARBEDWIRE) then  local cost = math.ceil(trent:GetMaxBarricadeHealth() / 300)   if self:GetCombinedPrimaryAmmo() >= cost then  self:TakeCombinedPrimaryAmmo(cost)  self:EmitSound("physics/metal/metal_chainlink_impact_soft2.wav")   trent:SetDTBool(DT_PROP_BOOL_BARBEDWIRE, true)  trent.BarbedWireOwner = owner  end  end end  function SWEP:SecondaryAttack() end  function SWEP:CanSecondaryAttack()  return false end  function SWEP:Reload()  return false end  function SWEP:Deploy()  GAMEMODE:WeaponDeployed(self:GetOwner(), self)   if self:GetPrimaryAmmoCount() <= 0 then  self:SendWeaponAnim(ACT_VM_THROW)  else  self:SendWeaponAnim(ACT_VM_DEPLOY)  end   self.NextIdle = CurTime() + 2   return true end  function SWEP:Holster()  return true end  function SWEP:Think() end  function SWEP:AllowsAutoSwitchTo()  return false end