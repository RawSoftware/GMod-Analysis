AddCSLuaFile()  SWEP.PrintName = "Zombie Kung Fu"  SWEP.Base = "weapon_zs_zombie"  SWEP.MeleeDelay = 0.32 SWEP.MeleeReach = 40 SWEP.MeleeDamage = 17  SWEP.DelayWhenDeployed = true  SWEP.Secondary.Delay = 3.5 SWEP.NextPuke = 0 SWEP.NextPukeRelease = 0 SWEP.PukeLeft = 0  SWEP.PassiveMoan = false  function SWEP:PrimaryAttack(fromsecondary)  local n = self:GetNextPrimaryAttack()   if self:GetOwner():IsOnGround() or self:GetOwner():WaterLevel() >= 2 or self:GetOwner():GetMoveType() ~= MOVETYPE_WALK then  self.BaseClass.PrimaryAttack(self)  end   if not fromsecondary and n ~= self:GetNextPrimaryAttack() then  self:SetDTBool(3, false)  end end  function SWEP:SecondaryAttack()  local n = self:GetNextPrimaryAttack()  self:PrimaryAttack(true)  if n ~= self:GetNextPrimaryAttack() then  self:SetDTBool(3, true)  end end  function SWEP:PlayHitSound()  self:EmitSound("npc/zombie/zombie_pound_door.wav", nil, nil, nil, CHAN_AUTO) end  function SWEP:PlayAttackSound()  self:EmitSound("npc/zombie/foot_slide"..math.random(3)..".wav", nil, nil, nil, CHAN_AUTO) end  function SWEP:Reload() end  function SWEP:StartMoaning() end  function SWEP:StopMoaning() end  function SWEP:IsMoaning()  return false end  function SWEP:Think()  self.BaseClass.Think(self)   local pl = self:GetOwner()   if SERVER then  if self.NextPukeRelease < CurTime() then  self.NextPukeRelease = CurTime() + 2  timer.Simple(0.8, function()  if self:IsValid() then  self.PukeLeft = 3  end  end)  end  end      if self.PukeLeft > 0 and CurTime() >= self.NextPuke then  self.PukeLeft = self.PukeLeft - 1  self.NextPuke = CurTime() + 0.1  pl.LastRangedAttack = CurTime()   local ent = ents.Create("projectile_gunk")  if ent:IsValid() then  ent:SetPos(pl:EyePos())  ent:SetOwner(pl)  ent:Spawn()   local phys = ent:GetPhysicsObject()  if phys:IsValid() then  local ang = pl:EyeAngles()  ang:RotateAroundAxis(ang:Forward(), math.Rand(-16, 16))  ang:RotateAroundAxis(ang:Up(), math.Rand(-8, 8))  phys:SetVelocityInstantaneous(ang:Up() * 300)  end  end  end   self:NextThink(CurTime())  return true end