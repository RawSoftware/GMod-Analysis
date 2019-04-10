CLASS.Name = "Viper" CLASS.TranslationName = "class_viper" CLASS.Description = "description_viper" CLASS.Help = "controls_viper"  CLASS.Health = 760 CLASS.Speed = 160  CLASS.JumpPower = DEFAULT_JUMP_POWER CLASS.Mass = DEFAULT_MASS  CLASS.Demiboss = true CLASS.Cat = ZCLASSCAT_DESTRUC  CLASS.CanTaunt = true  CLASS.Points = CLASS.Health/GM.HumanoidZombiePointRatio  CLASS.SWEP = "weapon_zs_viper"  CLASS.Model = Model("models/player/breen.mdl") CLASS.NoHideMainModel = true  CLASS.VoicePitch = 1 CLASS.CanFeignDeath = false  CLASS.BloodColor = BLOOD_COLOR_GREEN  local math_random = math.random local math_min = math.min local CurTime = CurTime  local ACT_HL2MP_SWIM_PISTOL = ACT_HL2MP_SWIM_PISTOL  function CLASS:Move(pl, move)  local frenzy = pl:GetStatus("viper_frenzy")  if frenzy then         local new_max_speed = move:GetMaxSpeed() + 30   move:SetMaxSpeed(new_max_speed)  move:SetMaxClientSpeed(new_max_speed)  end end  function CLASS:PlayDeathSound(pl)  local sndname = "ambient/creatures/town_child_scream1.wav"  for i = 1, 4 do  timer.Simple(0.04 * i,  function() if pl:IsValid() then pl:EmitSound(sndname, 75, 40 + i*8, 0.4, CHAN_AUTO) end  end)  end  return true end  function CLASS:PlayPainSound(pl)  local sndname = "vo/npc/alyx/hurt0"..math.random(4,6)..".wav"  for i = 1, 4 do  timer.Simple(0.04 * i,  function() if pl:IsValid() then pl:EmitSound(sndname, 75, 40 + i*8, 0.4, CHAN_AUTO) end  end)  end  pl.NextPainSound = CurTime() + 0.5  return true end  local StepSounds = {  "npc/zombie/foot1.wav",  "npc/zombie/foot2.wav",  "npc/zombie/foot3.wav" } local ScuffSounds = {  "npc/zombie/foot_slide1.wav",  "npc/zombie/foot_slide2.wav",  "npc/zombie/foot_slide3.wav" } function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)  if math_random() < 0.15 then  pl:EmitSound(ScuffSounds[math_random(#ScuffSounds)], 70, 75)  else  pl:EmitSound(StepSounds[math_random(#StepSounds)], 70, 75)  end  return true end  function CLASS:CalcMainActivity(pl, velocity)  if pl:WaterLevel() >= 3 then  return ACT_HL2MP_SWIM_PISTOL, -1  end   local len = velocity:Length2DSqr()  if len <= 1 then  if pl:Crouching() and pl:OnGround() then  return ACT_HL2MP_IDLE_CROUCH_FIST, -1  end   return ACT_HL2MP_IDLE_KNIFE, -1  end   if pl:Crouching() and pl:OnGround() then  return ACT_HL2MP_WALK_CROUCH_KNIFE, -1  end   if len < 2800 then  return ACT_HL2MP_WALK_KNIFE, -1  end   return ACT_HL2MP_RUN_KNIFE, -1 end  function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)  local len2d = velocity:Length()  if len2d > 1 then  pl:SetPlaybackRate(math_min(len2d / maxseqgroundspeed, 3))  else  pl:SetPlaybackRate(1)  end  return true end  function CLASS:DoAnimationEvent(pl, event, data)  if event == PLAYERANIMEVENT_ATTACK_PRIMARY then  pl:DoZombieAttackAnim(data)  return ACT_INVALID  elseif event == PLAYERANIMEVENT_RELOAD then  pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_TAUNT_ZOMBIE, true)  return ACT_INVALID  end end  function CLASS:DoesntGiveFear(pl)  return pl.FeignDeath and pl.FeignDeath:IsValid() end  function CLASS:AltUse(pl)  self:ThrowTrap(pl) end  function CLASS:ThrowTrap(pl)  local wep = pl:GetActiveWeapon()  if pl:IsValid() and pl:Alive() and wep:IsValid() then  wep:AltAttack()  end end 