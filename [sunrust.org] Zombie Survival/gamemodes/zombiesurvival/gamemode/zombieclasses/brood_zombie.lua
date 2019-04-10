CLASS.Name = "Brood Zombie" CLASS.TranslationName = "class_brood_zombie" CLASS.Description = "description_brood_zombie" CLASS.Help = "controls_eradicator"  CLASS.BetterVersion = "Eradicator"  CLASS.Wave = 3 / 6  CLASS.Health = 280 CLASS.HealthPerWave = 40 CLASS.Speed = 160  CLASS.CanTaunt = true  CLASS.Points = CLASS.Health/GM.HumanoidZombiePointRatio CLASS.Cat = ZCLASSCAT_DESTRUC  CLASS.SWEP = "weapon_zs_bzombie"  CLASS.Model = Model("models/player/zombie_classic_hbfix.mdl")  CLASS.NoHideMainModel = true CLASS.CanFeignDeath = true  CLASS.VoicePitch = 0.6  CLASS.DeathSounds = {"npc/zombie/zombie_die1.wav", "npc/zombie/zombie_die2.wav", "npc/zombie/zombie_die3.wav"}  local CurTime = CurTime local math_random = math.random local math_ceil = math.ceil local math_Clamp = math.Clamp local math_min = math.min local math_max = math.max local ACT_HL2MP_ZOMBIE_SLUMP_RISE = ACT_HL2MP_ZOMBIE_SLUMP_RISE local ACT_HL2MP_SWIM_PISTOL = ACT_HL2MP_SWIM_PISTOL local ACT_HL2MP_RUN_ZOMBIE = ACT_HL2MP_RUN_ZOMBIE local ACT_HL2MP_IDLE_CROUCH_ZOMBIE = ACT_HL2MP_IDLE_CROUCH_ZOMBIE local ACT_HL2MP_IDLE_ZOMBIE = ACT_HL2MP_IDLE_ZOMBIE local ACT_HL2MP_WALK_CROUCH_ZOMBIE_01 = ACT_HL2MP_WALK_CROUCH_ZOMBIE_01 local ACT_HL2MP_WALK_ZOMBIE_01 = ACT_HL2MP_WALK_ZOMBIE_01 local GESTURE_SLOT_ATTACK_AND_RELOAD = GESTURE_SLOT_ATTACK_AND_RELOAD local PLAYERANIMEVENT_ATTACK_PRIMARY = PLAYERANIMEVENT_ATTACK_PRIMARY local ACT_GMOD_GESTURE_RANGE_ZOMBIE = ACT_GMOD_GESTURE_RANGE_ZOMBIE local ACT_INVALID = ACT_INVALID local PLAYERANIMEVENT_RELOAD = PLAYERANIMEVENT_RELOAD local ACT_GMOD_GESTURE_TAUNT_ZOMBIE = ACT_GMOD_GESTURE_TAUNT_ZOMBIE local STEPSOUNDTIME_NORMAL = STEPSOUNDTIME_NORMAL local STEPSOUNDTIME_WATER_FOOT = STEPSOUNDTIME_WATER_FOOT local STEPSOUNDTIME_ON_LADDER = STEPSOUNDTIME_ON_LADDER local STEPSOUNDTIME_WATER_KNEE = STEPSOUNDTIME_WATER_FOOT local HITGROUP_HEAD = HITGROUP_HEAD local HITGROUP_LEFTLEG = HITGROUP_LEFTLEG local HITGROUP_RIGHTLEG = HITGROUP_RIGHTLEG local DMG_ALWAYSGIB = DMG_ALWAYSGIB local DMG_BURN = DMG_BURN local DMG_CRUSH = DMG_CRUSH local bit_band = bit.band local string_format = string.format  function CLASS:KnockedDown(pl, status, exists)  pl:AnimResetGestureSlot(GESTURE_SLOT_ATTACK_AND_RELOAD) end  local StepLeftSounds = {  "npc/zombie/foot1.wav",  "npc/zombie/foot2.wav" } local StepRightSounds = {  "npc/zombie/foot2.wav",  "npc/zombie/foot3.wav" } function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)  if iFoot == 0 then  pl:EmitSound(StepLeftSounds[math_random(#StepLeftSounds)], 70)  else  pl:EmitSound(StepRightSounds[math_random(#StepRightSounds)], 70)  end   return true end  function CLASS:PlayPainSound(pl)  pl:EmitSound(string_format("npc/zombie_poison/pz_idle%d.wav", math_random(2, 3)), 72, 89, 0.75)  pl.NextPainSound = CurTime() + 0.5   return true end  function CLASS:PlayerStepSoundTime(pl, iType, bWalking)  if iType == STEPSOUNDTIME_NORMAL or iType == STEPSOUNDTIME_WATER_FOOT then  return 625 - pl:GetVelocity():Length()  elseif iType == STEPSOUNDTIME_ON_LADDER then  return 600  elseif iType == STEPSOUNDTIME_WATER_KNEE then  return 750  end   return 450 end  function CLASS:CalcMainActivity(pl, velocity)  local revive = pl.Revive  if revive and revive:IsValid() then  return ACT_HL2MP_ZOMBIE_SLUMP_RISE, -1  end   local feign = pl.FeignDeath  if feign and feign:IsValid() then  if feign:GetDirection() == DIR_BACK then  return 1, pl:LookupSequence("zombie_slump_rise_02_fast")  end   return ACT_HL2MP_ZOMBIE_SLUMP_RISE, -1  end   if pl:WaterLevel() >= 3 then  return ACT_HL2MP_SWIM_PISTOL, -1  end   local wep = pl:GetActiveWeapon()  if wep:IsValid() and wep.IsMoaning and wep:IsMoaning() then  return ACT_HL2MP_RUN_ZOMBIE, -1  end   if velocity:Length2DSqr() <= 1 then  if pl:Crouching() and pl:OnGround() then  return ACT_HL2MP_IDLE_CROUCH_ZOMBIE, -1  end   return ACT_HL2MP_IDLE_ZOMBIE, -1  end   if pl:Crouching() and pl:OnGround() then  return ACT_HL2MP_WALK_CROUCH_ZOMBIE_01 - 1 + math_ceil((CurTime() / 4 + pl:EntIndex()) % 3), -1  end   return ACT_HL2MP_WALK_ZOMBIE_01 - 1 + math_ceil((CurTime() / 3 + pl:EntIndex()) % 3), -1 end  function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)  local revive = pl.Revive  if revive and revive:IsValid() then  pl:SetCycle(0.4 + (1 - math_Clamp((revive:GetReviveTime() - CurTime()) / revive.AnimTime, 0, 1)) * 0.6)  pl:SetPlaybackRate(0)  return true  end   local feign = pl.FeignDeath  if feign and feign:IsValid() then  if feign:GetState() == 1 then  pl:SetCycle(1 - math_max(feign:GetStateEndTime() - CurTime(), 0) * 0.666)  else  pl:SetCycle(math_max(feign:GetStateEndTime() - CurTime(), 0) * 0.666)  end  pl:SetPlaybackRate(0)  return true  end   local len2d = velocity:Length()  if len2d > 1 then  local wep = pl:GetActiveWeapon()  if wep:IsValid() and wep.IsMoaning and wep:IsMoaning() then  pl:SetPlaybackRate(math_min(len2d / maxseqgroundspeed, 3))  else  pl:SetPlaybackRate(math_min(len2d / maxseqgroundspeed * 0.5, 3))  end  else  pl:SetPlaybackRate(1)  end   return true end  function CLASS:DoAnimationEvent(pl, event, data)  if event == PLAYERANIMEVENT_ATTACK_PRIMARY then  pl:DoZombieAttackAnim(data)  return ACT_INVALID  elseif event == PLAYERANIMEVENT_RELOAD then  pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_TAUNT_ZOMBIE, true)  return ACT_INVALID  end end  function CLASS:DoesntGiveFear(pl)  return pl.FeignDeath and pl.FeignDeath:IsValid() end  if SERVER then  function CLASS:AltUse(pl)  pl:StartFeignDeath()  end   function CLASS:ProcessDamage(pl, dmginfo)  local damage = dmginfo:GetDamage()  if damage < pl:Health() then return end          local second_wind = pl:GetStatus("buff_zombie_secondwind")         if not second_wind then return end          local slump = pl:GetStatus("revive_slump")          if second_wind and slump then             dmginfo:SetDamage(0)             return true         end   local attacker, inflictor = dmginfo:GetAttacker(), dmginfo:GetInflictor()  if attacker == pl or not attacker:IsPlayer() or inflictor.NoReviveFromKills then return end   if pl:GetStatus("dot_shock") then return end  if pl.FeignDeath and pl.FeignDeath:IsValid() then return end  if CurTime() < (pl.NextZombieRevive or 0) then return end  pl.NextZombieRevive = CurTime() + 15   dmginfo:SetDamage(0)  pl:SetHealth(10)   local status = pl:GiveStatus("revive_slump")  if status then  status:SetReviveTime(CurTime() + 1.75)  status:SetReviveHeal(115)  end   return true  end end  if not CLIENT then return end  CLASS.Icon = "zombiesurvival/killicons/zombie" CLASS.IconColor = Color(66, 40, 40)  local matFlesh = Material("Models/charple/charple3_sheet.vtf") function CLASS:PrePlayerDraw(pl)  render.ModelMaterialOverride(matFlesh)  render.SetColorModulation(1, 0.45, 0.45) end  function CLASS:PostPlayerDraw(pl)  render.SetColorModulation(1, 1, 1)  render.ModelMaterialOverride() end 