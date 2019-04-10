SWEP.Base = "weapon_zs_zombie"  SWEP.PrintName = "Shit Slapper" SWEP.WorldModel = "models/zombiesurvival/classic_torso_big.mdl"  SWEP.MeleeDelay = 0.5 SWEP.MeleeReach = 74 SWEP.MeleeDamage = 17 SWEP.MeleeSize = 16 SWEP.SwingAnimSpeed = 1.6 SWEP.Primary.Delay = 1.35  SWEP.DelayWhenDeployed = true SWEP.NoGuardian = true  function SWEP:Initialize()  if CLIENT then  self:SCKInit()  end end  local pl_counts = 0 function SWEP:ApplyMeleeDamage(ent, trace, damage)  if ent:IsValid() then  local noknockdown = true  if CurTime() >= (ent.NextKnockdown or 0) then  noknockdown = false  ent.NextKnockdown = CurTime() + 6  end  ent:ThrowFromPositionSetZ(trace.StartPos, ent:IsPlayer() and 600 or 200, nil, noknockdown)          if pl_counts <= 1 then             damage = damage * 1.5         end  end   self.BaseClass.ApplyMeleeDamage(self, ent, trace, damage) end  function SWEP:GetZombieTraces()     local owner = self:GetOwner()      local traces, guardian_traces = {}, {}     local added = {}     pl_counts = 0      for i = -6, 6 do         local aim_vec = owner:GetAimVector():Angle()         aim_vec:RotateAroundAxis(owner:GetUp(), i * 9)          local new_traces, g_traces = owner:CompensatedZombieMeleeTrace(self.MeleeReach, self.MeleeSize, nil, aim_vec:Forward(), nil, true)          for _, new_tr in ipairs(new_traces) do             if IsValid(new_tr.Entity) and not added[new_tr.Entity] then                 traces[#traces + 1] = new_tr                 added[new_tr.Entity] = true                  if new_tr.Entity:IsPlayer() then                     pl_counts = pl_counts + 1                 end             end         end          if g_traces then             for _, new_tr in ipairs(g_traces) do                 if IsValid(new_tr.Entity) then                     guardian_traces[#guardian_traces + 1] = new_tr                 end             end         end     end      return traces, guardian_traces end  function SWEP:Reload()  self:SecondaryAttack() end  function SWEP:StartMoaning() end  function SWEP:StopMoaning() end  function SWEP:IsMoaning()  return false end  function SWEP:PlayHitSound()  self:EmitSound("npc/zombie/claw_strike"..math.random(3)..".wav", 75, math.random(80, 90), nil, CHAN_AUTO) end  function SWEP:PlayMissSound()  self:EmitSound("npc/zombie/claw_miss"..math.random(2)..".wav", 75, math.random(80, 90), nil, CHAN_AUTO) end  function SWEP:PlayAttackSound()  self:EmitSound("npc/zombie/zo_attack"..math.random(2)..".wav", 75, math.random(80, 90)) end  function SWEP:PlayAlertSound()  self:GetOwner():EmitSound("npc/zombie/zombie_alert"..math.random(3)..".wav", 75, math.random(80, 90)) end  function SWEP:PlayIdleSound()  self:GetOwner():EmitSound("npc/zombie/zombie_voice_idle"..math.random(14)..".wav", 75, math.random(80, 90)) end 