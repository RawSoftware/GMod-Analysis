AddCSLuaFile()  SWEP.Base = "weapon_zs_zombie" local BaseClass = baseclass.Get("weapon_zs_zombie")  SWEP.MeleeDamage = 18 SWEP.SlowDownScale = 0  SWEP.AlertDelay = 3.5  SWEP.PassiveMoan = false  function SWEP:MeleeHitEntity(ent, trace, damage, forcescale)  BaseClass.MeleeHitEntity(self, ent, trace, damage, forcescale)   if ent:IsValid() then  if SERVER then  util.PoisonBlastDamage(self, self:GetOwner(), self:GetOwner():GetShootPos(), 52, 22, true, true)  end   local effectdata = EffectData()  effectdata:SetOrigin(trace.HitPos)  effectdata:SetMagnitude(0.5)  util.Effect("explosion_chem", effectdata, true)  end end  function SWEP:Reload()  self:SecondaryAttack() end  function SWEP:PlayAlertSound()  self:GetOwner():EmitSound("npc/combine_gunship/gunship_moan.wav", 75, math.random(145,165)) end SWEP.PlayIdleSound = SWEP.PlayAlertSound  function SWEP:PlayAttackSound()  self:EmitSound("npc/metropolice/pain2.wav", 55, math.random(50,55))  self:EmitSound("npc/zombie_poison/pz_warn1.wav", 75, math.Rand(60, 75), 0.5, CHAN_WEAPON + 1) end  local matSkin = Material("Models/headcrab_classic/headcrabsheet")  function SWEP:PreDrawViewModel(vm)  render.ModelMaterialOverride(matSkin)  render.SetColorModulation(0.45, 0.85, 0.45) end  function SWEP:PostDrawViewModel(vm)  render.ModelMaterialOverride()  render.SetColorModulation(1, 1, 1) end