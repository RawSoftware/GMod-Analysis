CLASS.Name = "Sanity Sentinel" CLASS.TranslationName = "class_sanity_sentinel" CLASS.Description = "description_eradicator" CLASS.Help = "controls_eradicator"  CLASS.Wave = 6 / 6  CLASS.Health = 12250 CLASS.Speed = 240 CLASS.Unlocked = true CLASS.Hidden = true  CLASS.GreatEvil = true  CLASS.CanTaunt = true  CLASS.KnockbackScale = 0 CLASS.FearPerInstance = 1  CLASS.Points = (CLASS.Health/GM.HumanoidZombiePointRatio)/1.5  CLASS.SWEP = "weapon_zs_sanity_sentinel"  CLASS.Model = Model("models/antlion_guard.mdl")  CLASS.VoicePitch = 0.6  CLASS.NoHideMainModel = true CLASS.CanFeignDeath = true  CLASS.ViewOffset = DEFAULT_VIEW_OFFSET CLASS.ViewOffsetDucked = DEFAULT_VIEW_OFFSET_DUCKED  function CLASS:Move(pl, mv)  local wep = pl:GetActiveWeapon()  if wep.Move and wep:Move(mv) then  return true  end   if mv:GetForwardSpeed() <= 0 then  mv:SetMaxSpeed(math.min(mv:GetMaxSpeed(), 70))  mv:SetMaxClientSpeed(math.min(mv:GetMaxClientSpeed(), 70))  end end  local CurTime = CurTime local math_random = math.random local ACT_HL2MP_ZOMBIE_SLUMP_RISE = ACT_HL2MP_ZOMBIE_SLUMP_RISE local ACT_HL2MP_SWIM_PISTOL = ACT_HL2MP_SWIM_PISTOL local ACT_HL2MP_RUN_ZOMBIE = ACT_HL2MP_RUN_ZOMBIE local ACT_HL2MP_IDLE_CROUCH_ZOMBIE = ACT_HL2MP_IDLE_CROUCH_ZOMBIE local ACT_HL2MP_IDLE_ZOMBIE = ACT_HL2MP_IDLE_ZOMBIE local ACT_HL2MP_WALK_CROUCH_ZOMBIE_01 = ACT_HL2MP_WALK_CROUCH_ZOMBIE_01 local ACT_HL2MP_WALK_ZOMBIE_01 = ACT_HL2MP_WALK_ZOMBIE_01 local GESTURE_SLOT_ATTACK_AND_RELOAD = GESTURE_SLOT_ATTACK_AND_RELOAD local PLAYERANIMEVENT_ATTACK_PRIMARY = PLAYERANIMEVENT_ATTACK_PRIMARY local ACT_GMOD_GESTURE_RANGE_ZOMBIE = ACT_GMOD_GESTURE_RANGE_ZOMBIE local ACT_INVALID = ACT_INVALID local PLAYERANIMEVENT_RELOAD = PLAYERANIMEVENT_RELOAD local ACT_GMOD_GESTURE_TAUNT_ZOMBIE = ACT_GMOD_GESTURE_TAUNT_ZOMBIE local STEPSOUNDTIME_NORMAL = STEPSOUNDTIME_NORMAL local STEPSOUNDTIME_WATER_FOOT = STEPSOUNDTIME_WATER_FOOT local STEPSOUNDTIME_ON_LADDER = STEPSOUNDTIME_ON_LADDER local STEPSOUNDTIME_WATER_KNEE = STEPSOUNDTIME_WATER_FOOT local HITGROUP_HEAD = HITGROUP_HEAD local HITGROUP_LEFTLEG = HITGROUP_LEFTLEG local HITGROUP_RIGHTLEG = HITGROUP_RIGHTLEG local DMG_ALWAYSGIB = DMG_ALWAYSGIB local DMG_BURN = DMG_BURN local DMG_CRUSH = DMG_CRUSH  function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)  pl:EmitSound("physics/glass/glass_sheet_impact_hard"..math_random(3)..".wav", 90, math.Rand(45, 47), CHAN_WEAPON)   if iFoot == 0 then  pl:EmitSound("^npc/strider/strider_step4.wav", 90, math_random(90, 100), 0.7, CHAN_AUTO + 1)  else  pl:EmitSound("^npc/strider/strider_step5.wav", 90, math_random(90, 100), 0.7, CHAN_AUTO + 1)  end   return true end  function CLASS:PlayPainSound(pl)  pl:EmitSound("npc/combine_soldier/pain"..math_random(3)..".wav", 75, math.Rand(60, 65))  pl.NextPainSound = CurTime() + 0.5   return true end  function CLASS:PlayDeathSound(pl)  pl:EmitSound("npc/antlion_guard/antlion_guard_die1.wav", 85, math.Rand(70, 75), 0.75)  pl:EmitSound("npc/antlion_guard/antlion_guard_die2.wav", 85, math.Rand(70, 75), 0.75, CHAN_AUTO + 1)   return true end  function CLASS:PlayerStepSoundTime(pl, iType, bWalking)  if iType == STEPSOUNDTIME_NORMAL or iType == STEPSOUNDTIME_WATER_FOOT then  return 455 - pl:GetVelocity():Length()  elseif iType == STEPSOUNDTIME_ON_LADDER then  return 400  elseif iType == STEPSOUNDTIME_WATER_KNEE then  return 650  end   return 450 end  function CLASS:CalcMainActivity(pl, velocity)  local wep = pl:GetActiveWeapon()  if wep:IsValid() and wep.IsSwinging and wep:IsSwinging() then  return 1, 32  end   local len = velocity:Length2DSqr()  if len > 1 then  if pl:Crouching() and pl:OnGround() then  return 1, 17  else  return 1, len >= 22500 and 37 or 16  end  elseif pl:Crouching() and pl:OnGround() then  return 1, 17  end   return 1, 1 end  function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)  local wep = pl:GetActiveWeapon()  if wep:IsValid() and wep.IsSwinging and wep:IsSwinging() and wep.GetAnimEnd then  pl:SetPlaybackRate(0)  pl:SetCycle(1 - (wep:GetAnimEnd() - CurTime()) / wep.AnimTime)   return true  end   local len = velocity:Length2DSqr()  if len >= 256 then  GAMEMODE.BaseClass.UpdateAnimation(GAMEMODE.BaseClass, pl, velocity, maxseqgroundspeed)   local aimdir = pl:GetAimVector()  aimdir.z = 0  aimdir:Normalize()   if pl:Crouching() then  pl:SetPoseParameter("move_yaw", 0)  else  pl:SetPlaybackRate(pl:GetPlaybackRate() * 2.5)  pl:SetPoseParameter("move_yaw", aimdir:Angle().y)  end   return true  end   if pl:Crouching() then  pl:SetCycle(1 + math.sin(CurTime() * 2) * 0.025)  pl:SetPlaybackRate(0)   return true  end   return true end  function CLASS:DoAnimationEvent(pl, event, data)  if event == PLAYERANIMEVENT_ATTACK_PRIMARY then  pl:DoZombieAttackAnim(data)  return ACT_INVALID  elseif event == PLAYERANIMEVENT_RELOAD then  pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_TAUNT_ZOMBIE, true)  return ACT_INVALID  end end  if SERVER then  function CLASS:OnSpawned(pl)  pl:CreateAmbience("sanitysentinelambience")  end   function CLASS:OnKilled(pl, attacker, inflictor, suicide, headshot, dmginfo)  local pos = pl:WorldSpaceCenter()   local effectdata = EffectData()  effectdata:SetOrigin(pos)  effectdata:SetNormal(pl:GetUp())  effectdata:SetEntity(pl)  util.Effect("explosion_sanity", effectdata, nil, true)   return true  end   function CLASS:ProcessDamage(pl, dmginfo)  if not pl.NextBlue or pl.NextBlue < CurTime() then  local effectdata = EffectData()  effectdata:SetOrigin(pl:WorldSpaceCenter())  effectdata:SetNormal(pl:GetUp())  effectdata:SetEntity(pl)  util.Effect("blueblood", effectdata, nil, true)   pl.NextBlue = CurTime() + 0.1  end  end end  if not CLIENT then return end  CLASS.Icon = "zombiesurvival/killicons/sanity_sentinel"  function CLASS:PrePlayerDraw(pl)  render.SetBlend(0) end  function CLASS:PostPlayerDraw(pl)  render.SetBlend(1) end 