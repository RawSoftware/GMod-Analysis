SWEP.PrintName = "Tar Monster"  SWEP.Base = "weapon_zs_zombie"  SWEP.MeleeDamage = 49 SWEP.MeleeForceScale = 1.25  SWEP.Primary.Delay = 1.4 SWEP.Secondary.Delay = 3.7  SWEP.NextPuke = 0 SWEP.PukeLeft = 0  SWEP.TryAlt = true SWEP.TryAltAimUp = 64  SWEP.PassiveMoan = false  AccessorFuncDT(SWEP, "Gunking", "Float", 1)  function SWEP:ApplyMeleeDamage(ent, trace, damage)  if ent:IsPlayer() then  ent:GiveStatus("debuff_gunk", 7.5)  self.BaseClass.ApplyMeleeDamage(self, ent, trace, damage / 1.1)  else  self.BaseClass.ApplyMeleeDamage(self, ent, trace, damage)  end end  function SWEP:Reload()  self.BaseClass.SecondaryAttack(self) end  function SWEP:PlayAlertSound()  self:PlayAttackSound() end  function SWEP:PlayIdleSound()  self:GetOwner():EmitSound("npc/barnacle/barnacle_tongue_pull"..math.random(3)..".wav") end  function SWEP:PlayAttackSound()  if SERVER then  local owner = self:GetOwner()   local sndname = "npc/ichthyosaur/attack_growl"..math.random(3)..".wav"  for i = 1, 4 do  timer.Simple(0.04 * i,  function() if owner:IsValid() then owner:EmitSound(sndname, 75, 90 + i*8, 0.3, CHAN_AUTO) end  end)  end  end end  function SWEP:SecondaryAttack()  local owner = self:GetOwner()  if CurTime() < self:GetNextPrimaryFire() or CurTime() < self:GetNextSecondaryFire() or IsValid(owner.FeignDeath) then return end   self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)  self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)   owner:DoReloadEvent()  self:EmitSound(string.format("npc/headcrab_poison/ph_scream%d.wav", math.random(3)), 72, math.random(29, 32),0.65, CHAN_AUTO)  self:EmitSound(string.format("npc/ichthyosaur/attack_growl%d.wav", math.random(3)), 72, math.random(112, 116),0.65, CHAN_WEAPON + 20)   if SERVER then  self:SetGunking(CurTime())  timer.Simple(1, function()  if self:IsValid() then  self.PukeLeft = 5   if owner:IsValidLivingZombie() then  owner:EmitSound("npc/barnacle/barnacle_die2.wav", 75, 120)  owner:EmitSound("npc/barnacle/barnacle_digesting1.wav", 75, 120)  owner:EmitSound("npc/barnacle/barnacle_digesting2.wav", 75, 120)  end  end  end)  end end 