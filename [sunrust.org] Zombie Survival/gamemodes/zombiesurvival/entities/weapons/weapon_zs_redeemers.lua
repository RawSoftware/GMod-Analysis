AddCSLuaFile()  SWEP.PrintName = "'Redeemers' Dual Handguns" SWEP.Description = "Dual handguns. Can dodge with right click." SWEP.Slot = 1 SWEP.SlotPos = 0  if CLIENT then  SWEP.ViewModelFlip = false  SWEP.ViewModelFOV = 50   SWEP.HUD3DBone = "v_weapon.slide_right"  SWEP.HUD3DPos = Vector(1, 0.1, -1)  SWEP.HUD3DScale = 0.015 end  SWEP.Base = "weapon_zs_base"  SWEP.HoldType = "duel"  SWEP.ViewModel = "models/weapons/cstrike/c_pist_elite.mdl" SWEP.WorldModel = "models/weapons/w_pist_elite.mdl" SWEP.UseHands = true  SWEP.Primary.Sound = Sound(")weapons/elite/elite-1.wav") SWEP.Primary.Damage = 22 SWEP.Primary.NumShots = 1 SWEP.Primary.Delay = 0.15  SWEP.Primary.ClipSize = 30 SWEP.Primary.Automatic = true SWEP.Primary.Ammo = "pistol" SWEP.Primary.DefaultClip = 150  SWEP.ConeMax = 2.75 SWEP.ConeMin = 2.5  GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_RELOAD_SPEED, 0.1)  AccessorFuncDT(SWEP, "DodgeEnd", "Float", 11) AccessorFuncDT(SWEP, "DodgeDir", "Vector", 11)  SWEP.Speed = 490 SWEP.SlowDownThreshold = 0.15  local function dodge(enty)     return function(pl, move)         if not IsValid(enty) then return end         if pl ~= enty:GetOwner() then return end          local state_end = enty:GetDodgeEnd()         local delta = state_end - CurTime()         if delta > 0 then             local vec = enty:GetDodgeDir() or -1 * pl:GetForward()              local basespeed = enty.Speed * math.Clamp(delta / enty.SlowDownThreshold, 0.2, 1)             local vel = math.max(pl:GetMaxSpeed(), basespeed) * vec             vel.z = math.Clamp(move:GetVelocity().z, -800, 256)              pl:SetGroundEntity(NULL)             move:SetVelocity(vel)         end     end end  function SWEP:CalcDodgeDir()     local owner = self:GetOwner()     local dir = Vector(0, 0, 0)     if owner:KeyDown(IN_BACK) then dir = dir - owner:GetForward() end     if owner:KeyDown(IN_MOVERIGHT) then dir = dir + owner:GetRight() end     if owner:KeyDown(IN_MOVELEFT) then dir = dir - owner:GetRight() end     dir:Normalize()     if dir == vector_origin then dir = -1 * owner:GetForward() end      return dir end  function SWEP:Dodge()     local owner = self:GetOwner()     local consume = 0.7 * (owner.DodgeStaminaMul or 1)     if owner:CurrentDecimalStamina() <= (consume * 0.33) then return end      owner:AddDecimalStamina(-consume)      if IsFirstTimePredicted() then         owner:ViewPunch(Angle(0, 0, self:GetDodgeDir() * -8))          if CLIENT then             owner:EmitSound("npc/zombie_poison/pz_right_foot1.wav", 65, 170)         end          hook.Add("Move", tostring(self), dodge(self))     end      local dodge_time = 0.33 * (owner.DodgeDurationMul or 1)      self:SetDodgeEnd(CurTime() + dodge_time)     self:SetDodgeDir(self:CalcDodgeDir())      owner.IFrames = CurTime() + dodge_time end  function SWEP:SecondaryAttack()     if self:GetNextSecondaryFire() >= CurTime() then return end      self:SetNextSecondaryFire(CurTime() + 1)     self:Dodge() end  function SWEP:SendWeaponAnimation()  self:SendWeaponAnim(self:Clip1() % 2 == 0 and ACT_VM_PRIMARYATTACK or ACT_VM_SECONDARYATTACK)     self:GetOwner():GetViewModel():SetPlaybackRate(self:GetIronsights() and self.IronsightAnimSpeed or self.FireAnimSpeed)     self.IdleAnimation = CurTime() + self:SequenceDuration() end  if not CLIENT then return end  function SWEP:GetTracerOrigin()  local owner = self:GetOwner()  if owner:IsValid() then  local vm = owner:GetViewModel()  if vm and vm:IsValid() then  local attachment = vm:GetAttachment(self:Clip1() % 2 + 3)  if attachment then  return attachment.Pos  end  end  end end 