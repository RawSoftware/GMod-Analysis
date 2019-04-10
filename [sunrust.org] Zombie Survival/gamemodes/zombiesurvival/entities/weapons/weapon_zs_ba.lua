AddCSLuaFile()  SWEP.PrintName = "Blood Angel"  SWEP.Base = "weapon_zs_zombie"  SWEP.MeleeDamage = 26 SWEP.MeleeDamageVsProps = 65 SWEP.BleedDamage = 15 SWEP.SlowDownScale = 0 SWEP.Primary.Delay = 1.3  SWEP.AlertDelay = 3.5  SWEP.MeleeReach = 64  SWEP.GreatEvil = true  SWEP.FakeAttackMulti = 4 SWEP.TryAlt = true  AccessorFuncDT(SWEP, "BlastTime", "Float", 1)  SWEP.PassiveMoan = false  function SWEP:ApplyMeleeDamage(ent, trace, damage)  self.BaseClass.ApplyMeleeDamage(self, ent, trace, damage)   local owner = self:GetOwner()   if SERVER and ent:IsPlayer() then  ent:GiveStatus("debuff_enfeeble", 7, owner)      ent:AddBleedDamage(self.BleedDamage, owner)  end end  function SWEP:MeleeHit(ent, trace, damage, forcescale)  if not ent:IsPlayer() then  damage = self.MeleeDamageVsProps  end   self.BaseClass.MeleeHit(self, ent, trace, damage, forcescale) end  function SWEP:Blast()  local owner = self:GetOwner()   owner.LastRangedAttack = CurTime()   local ent = ents.Create("projectile_ba")  if ent:IsValid() then  local ang = owner:EyeAngles()  ang:RotateAroundAxis(ang:Up(), 90)   ent:SetPos(owner:GetShootPos())  ent:SetAngles(ang)  ent:SetOwner(owner)  ent:Spawn()   local phys = ent:GetPhysicsObject()  if phys:IsValid() then  phys:SetVelocityInstantaneous(owner:GetAimVector() * 800)  end  end end  function SWEP:PrimaryAttack()  if CurTime() < self:GetNextPrimaryFire() then return end  local owner = self:GetOwner()   local armdelay = owner:GetMeleeSpeedMul()   self:SetNextPrimaryFire(CurTime() + self.Primary.Delay * armdelay)  self:StartSwinging()   local vel = owner:GetAimVector()  vel.z = math.max(math.min(vel.z, 0.7), 0.6)  vel:Normalize()   owner:SetGroundEntity(NULL)  owner:SetVelocity(vel * 280)   self.BaseClass.Swung(self) end  function SWEP:SecondaryAttack()  if CurTime() < self:GetNextPrimaryFire() or CurTime() < self:GetNextSecondaryFire() then return end   self:SetNextSecondaryFire(CurTime() + 1.6)  self:SetNextPrimaryFire(CurTime() + 1.6)  self:StartSwinging()   self:EmitSound("npc/headcrab_poison/ph_poisonbite2.wav", 75, 46)  self:EmitSound("npc/zombie/zombie_die"..math.random(3)..".wav", 75, math.random(70,75), 0.6, CHAN_WEAPON + 1)   local owner = self:GetOwner()   self:SetBlastTime(CurTime() + 1)   local pos, ang = owner:GetBonePositionMatrixed(5)   local effectdata = EffectData()  effectdata:SetOrigin(LocalToWorld(Vector(-4, -2, 1.5), angle_zero, pos, ang))  effectdata:SetNormal(ang:Forward())  effectdata:SetEntity(owner)  util.Effect("danger_warning", effectdata) end  function SWEP:Think()  if self:GetBlastTime() > 0 and CurTime() >= self:GetBlastTime() then  self:SetBlastTime(0)   self:EmitSound("physics/flesh/flesh_squishy_impact_hard"..math.random(2, 4)..".wav", 72, math.random(60, 63))  self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)   if SERVER then  self:Blast()  end  end   return self.BaseClass.Think(self) end  function SWEP:Reload()  self:SecondaryAttack() end  function SWEP:PlayAlertSound()  self:GetOwner():EmitSound("npc/combine_gunship/gunship_moan.wav", 75, math.random(70,75)) end SWEP.PlayIdleSound = SWEP.PlayAlertSound  function SWEP:PlayAttackSound()  self:EmitSound("npc/antlion_guard/angry"..math.random(3)..".wav", 75, math.random(80,85), 0.8, CHAN_WEAPON)  self:EmitSound("npc/zombie/zombie_die"..math.random(3)..".wav", 75, math.random(70,75), 0.6, CHAN_WEAPON + 1)  self:EmitSound("npc/combine_soldier/die"..math.random(1,3)..".wav", 75, math.random(75,80), 0.5, CHAN_WEAPON + 2) end  if not CLIENT then return end  function SWEP:ViewModelDrawn()  render.ModelMaterialOverride(0) end  local matSheet = Material("Models/charple/charple4_sheet.vtf") function SWEP:PreDrawViewModel(vm)  render.ModelMaterialOverride(matSheet) end  function SWEP:SetSwingAnimTime(time)  self:SetDTFloat(3, time) end  function SWEP:GetSwingAnimTime()  return self:GetDTFloat(3) end  function SWEP:StartSwinging()  self.BaseClass.StartSwinging(self)  self:SetSwingAnimTime(CurTime() + 1) end