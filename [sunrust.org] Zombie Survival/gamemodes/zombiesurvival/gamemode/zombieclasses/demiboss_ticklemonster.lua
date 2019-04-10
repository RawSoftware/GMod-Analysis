 CLASS.Name = "Tickle Monster" CLASS.TranslationName = "class_the_tickle_monster" CLASS.Description = "description_the_tickle_monster" CLASS.Help = "controls_the_tickle_monster"  CLASS.Demiboss = true  CLASS.KnockbackScale = 0  CLASS.Health = 950 CLASS.Speed = 160  CLASS.FearPerInstance = 0.5 CLASS.KnockbackScale = 0.5  CLASS.CanTaunt = true  CLASS.Points = CLASS.Health/GM.HumanoidZombiePointRatio CLASS.Cat = ZCLASSCAT_DESTRUC  CLASS.SWEP = "weapon_zs_ticklemonster"  CLASS.Model = Model("models/zombiesurvival/ticklemonster.mdl")  CLASS.VoicePitch = 0.8  CLASS.PainSounds = {"npc/zombie/zombie_pain1.wav", "npc/zombie/zombie_pain2.wav", "npc/zombie/zombie_pain3.wav", "npc/zombie/zombie_pain4.wav", "npc/zombie/zombie_pain5.wav", "npc/zombie/zombie_pain6.wav"} CLASS.DeathSounds = {"npc/zombie/zombie_die1.wav", "npc/zombie/zombie_die2.wav", "npc/zombie/zombie_die3.wav"}  CLASS.ViewOffset = Vector(0, 0, 72) CLASS.ViewOffsetDucked = Vector(0, 0, 40) CLASS.Hull = {Vector(-16, -16, 0), Vector(16, 16, 86)} CLASS.HullDuck = {Vector(-16, -16, 0), Vector(16, 16, 48)}  local math_random = math.random local math_min = math.min local math_ceil = math.ceil local CurTime = CurTime  local STEPSOUNDTIME_NORMAL = STEPSOUNDTIME_NORMAL local STEPSOUNDTIME_WATER_FOOT = STEPSOUNDTIME_WATER_FOOT local STEPSOUNDTIME_ON_LADDER = STEPSOUNDTIME_ON_LADDER local STEPSOUNDTIME_WATER_KNEE = STEPSOUNDTIME_WATER_KNEE local ACT_HL2MP_SWIM_PISTOL = ACT_HL2MP_SWIM_PISTOL local ACT_HL2MP_IDLE_CROUCH_ZOMBIE = ACT_HL2MP_IDLE_CROUCH_ZOMBIE local ACT_HL2MP_WALK_CROUCH_ZOMBIE_01 = ACT_HL2MP_WALK_CROUCH_ZOMBIE_01 local ACT_HL2MP_RUN_ZOMBIE = ACT_HL2MP_RUN_ZOMBIE  local StepSounds = {  "npc/zombie/foot1.wav",  "npc/zombie/foot2.wav",  "npc/zombie/foot3.wav" } local ScuffSounds = {  "npc/zombie/foot_slide1.wav",  "npc/zombie/foot_slide2.wav",  "npc/zombie/foot_slide3.wav" } function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)  if math_random() < 0.15 then  pl:EmitSound(ScuffSounds[math_random(#ScuffSounds)], 70)  else  pl:EmitSound(StepSounds[math_random(#StepSounds)], 70)  end   return true end  function CLASS:PlayerStepSoundTime(pl, iType, bWalking)  if iType == STEPSOUNDTIME_NORMAL or iType == STEPSOUNDTIME_WATER_FOOT then  return 625 - pl:GetVelocity():Length()  elseif iType == STEPSOUNDTIME_ON_LADDER then  return 600  elseif iType == STEPSOUNDTIME_WATER_KNEE then  return 750  end   return 450 end  function CLASS:CalcMainActivity(pl, velocity)  if pl:WaterLevel() >= 3 then  return ACT_HL2MP_SWIM_PISTOL, -1  end   if pl:Crouching() and pl:OnGround() then  if velocity:Length2DSqr() <= 1 then  return ACT_HL2MP_IDLE_CROUCH_ZOMBIE, -1  end   return ACT_HL2MP_WALK_CROUCH_ZOMBIE_01 - 1 + math_ceil((CurTime() / 4 + pl:EntIndex()) % 3), -1  end   return ACT_HL2MP_RUN_ZOMBIE, -1 end  function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)  local len2d = velocity:Length2D()  if len2d > 1 then  pl:SetPlaybackRate(math_min(len2d / maxseqgroundspeed, 3))  else  pl:SetPlaybackRate(1)  end   return true end  function CLASS:DoAnimationEvent(pl, event, data)  if event == PLAYERANIMEVENT_ATTACK_PRIMARY then  pl:DoZombieAttackAnim(data)  return ACT_INVALID  elseif event == PLAYERANIMEVENT_RELOAD then  pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_TAUNT_ZOMBIE, true)  return ACT_INVALID  end end  if SERVER then  function CLASS:OnSpawned(pl)  pl:CreateAmbience("ticklemonsterambience")  end end  if not CLIENT then return end  CLASS.Icon = "zombiesurvival/killicons/tickle"