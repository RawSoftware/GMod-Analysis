AddCSLuaFile()  SWEP.PrintName = "Frigid Ghoul"  SWEP.Base = "weapon_zs_zombie"  SWEP.MeleeDamage = 19 SWEP.MeleeForceScale = 0.5 SWEP.SlowDownScale = 0.1 SWEP.TryAlt = true SWEP.TryAltAimUp = 64  SWEP.Secondary.Delay = 3  SWEP.PassiveMoan = false  function SWEP:ApplyMeleeDamage(ent, trace, damage)  if SERVER and ent:IsPlayer() then  local owner = self:GetOwner()  local gt = ent:GiveStatus("debuff_frost", 6, owner)   if gt and gt:IsValid() then  gt.Applier = owner  end  end   self.BaseClass.ApplyMeleeDamage(self, ent, trace, damage) end  function SWEP:Reload()  self.BaseClass.SecondaryAttack(self) end  function SWEP:PlayAlertSound()  self:GetOwner():EmitSound("npc/fast_zombie/fz_frenzy1.wav", 75, math.Rand(70, 80)) end SWEP.PlayIdleSound = SWEP.PlayAlertSound  function SWEP:PlayAttackSound()  self:EmitSound("npc/metropolice/pain"..math.random(4)..".wav", 74, math.Rand(110, 130)) end  local Spread = {  {0, 0},  {-0.5, 0},  {0.5, 0} } local function DoFleshThrow(pl, wep)  if pl:IsValid() and pl:Alive() and wep:IsValid() then  pl:ResetSpeed()  pl.LastRangedAttack = CurTime()   if SERVER then  local startpos = pl:GetShootPos()  local aimang = pl:EyeAngles()  local ang   for _, spr in pairs(Spread) do  ang = Angle(aimang.p, aimang.y, aimang.r)  ang:RotateAroundAxis(ang:Up(), spr[1] * 5)  ang:RotateAroundAxis(ang:Right(), spr[2] * 5)   local ent = ents.Create("projectile_ghoulfleshchilled")  if ent:IsValid() then  ent:SetPos(startpos)  ent:SetOwner(pl)  ent:Spawn()   local phys = ent:GetPhysicsObject()  if phys:IsValid() then  phys:SetVelocityInstantaneous(ang:Forward() * 750)  end  end  end   pl:EmitSound(string.format("physics/body/body_medium_break%d.wav", math.random(2, 4)), 72, math.Rand(85, 95))  end  end end  function SWEP:SecondaryAttack()  local owner = self:GetOwner()  if CurTime() < self:GetNextPrimaryFire() or CurTime() < self:GetNextSecondaryFire() or IsValid(owner.FeignDeath) then return end   self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)  self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)   self:GetOwner():DoZombieEvent()  self:EmitSound("npc/fast_zombie/leap1.wav", 74, math.Rand(110, 130))  self:EmitSound(string.format("physics/body/body_medium_break%d.wav", math.random(2, 4)), 72, math.Rand(85, 95))     self:SendWeaponAnim(ACT_VM_HITCENTER)  self.IdleAnimation = CurTime() + self:SequenceDuration()      local status = owner:GetStatus("buff_zombie_secondwind")     if status then         status:SetHealLeft(0)     end   timer.Simple(0.7, function() DoFleshThrow(owner, self) end) end  if not CLIENT then return end  function SWEP:ViewModelDrawn()  render.ModelMaterialOverride(0) end  local matSheet = Material("models/weapons/v_zombiearms/ghoulsheet") function SWEP:PreDrawViewModel(vm)  render.ModelMaterialOverride(matSheet) end 