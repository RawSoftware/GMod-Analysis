CLASS.Name = "Bonemesh" CLASS.TranslationName = "class_bonemesh" CLASS.Description = "description_bonemesh" CLASS.Help = "controls_bonemesh"  CLASS.Boss = true  CLASS.KnockbackScale = 0  CLASS.CanTaunt = true  CLASS.Health = 2000 CLASS.Speed = 195  CLASS.FearPerInstance = 1  CLASS.Points = CLASS.Health/GM.NoHeadboxZombiePointRatio CLASS.Cat = ZCLASSCAT_SUPPORT  CLASS.SWEP = "weapon_zs_bonemesh"  CLASS.Model = Model("models/Zombie/Poison.mdl")  CLASS.VoicePitch = 0.8  CLASS.Hull = {Vector(-16, -16, 0), Vector(16, 16, 58)} CLASS.HullDuck = {Vector(-16, -16, 0), Vector(16, 16, 32)} CLASS.ViewOffset = Vector(0, 0, 50) CLASS.ViewOffsetDucked = Vector(0, 0, 24)  local math_random = math.random  local STEPSOUNDTIME_NORMAL = STEPSOUNDTIME_NORMAL local STEPSOUNDTIME_WATER_FOOT = STEPSOUNDTIME_WATER_FOOT local STEPSOUNDTIME_ON_LADDER = STEPSOUNDTIME_ON_LADDER local STEPSOUNDTIME_WATER_KNEE = STEPSOUNDTIME_WATER_KNEE local ACT_ZOMBIE_LEAPING = ACT_ZOMBIE_LEAPING local ACT_HL2MP_RUN_ZOMBIE_FAST = ACT_HL2MP_RUN_ZOMBIE_FAST  function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)     if iFoot == 0 then         pl:EmitSound("npc/antlion_guard/foot_light1.wav", 70, math_random(115, 120))     else         pl:EmitSound("npc/antlion_guard/foot_light2.wav", 70, math_random(115, 120))     end      return true end  function CLASS:PlayerStepSoundTime(pl, iType, bWalking)     if iType == STEPSOUNDTIME_NORMAL or iType == STEPSOUNDTIME_WATER_FOOT then         return 600 - pl:GetVelocity():Length()     elseif iType == STEPSOUNDTIME_ON_LADDER then         return 700     elseif iType == STEPSOUNDTIME_WATER_KNEE then         return 600     end      return 600 end  function CLASS:CalcMainActivity(pl, velocity)     if velocity:Length2DSqr() <= 1 then         return ACT_IDLE, -1     end      return -1, pl:LookupSequence( "Run" ) end  function CLASS:ScalePlayerDamage(pl, hitgroup, dmginfo)     return true end  function CLASS:IgnoreLegDamage(pl, dmginfo)     return true end  function CLASS:DoAnimationEvent(pl, event, data)     if event == PLAYERANIMEVENT_ATTACK_PRIMARY then         pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_MELEE_ATTACK1, true)         return ACT_INVALID     elseif event == PLAYERANIMEVENT_ATTACK_SECONDARY then         pl:AnimSetGestureWeight(GESTURE_SLOT_GRENADE, 1)         pl:AddVCDSequenceToGestureSlot(GESTURE_SLOT_GRENADE, 12, 0, true)         return ACT_INVALID     end end   function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)  local len2d = velocity:Length2D()  if len2d > 1 then  pl:SetPlaybackRate(math.min(len2d / maxseqgroundspeed * 0.75 / 2, 3))  else  pl:SetPlaybackRate(1)  end   return true end  function CLASS:PlayDeathSound(pl)     local rn = math_random(3)     pl:EmitSound("npc/zombie/zombie_die"..rn..".wav", 75, 87)     pl:EmitSound("npc/zombie/zombie_die"..rn..".wav", 75, 93)      return true end  function CLASS:PlayPainSound(pl)     local rn = math_random(6)     pl:EmitSound("npc/zombie/zombie_pain"..rn..".wav", 75, 87)     pl:EmitSound("npc/zombie/zombie_pain"..rn..".wav", 75, 93)     pl.NextPainSound = CurTime() + 1      return true end  if SERVER then     function CLASS:OnSpawned(pl)         pl:CreateAmbience("bonemeshambience")     end end  if not CLIENT then return end  CLASS.Icon = "zombiesurvival/killicons/bonemesh3"  function CLASS:PrePlayerDraw(pl)     render.SetBlend(0) end  function CLASS:PostPlayerDraw(pl)     render.SetBlend(1) end