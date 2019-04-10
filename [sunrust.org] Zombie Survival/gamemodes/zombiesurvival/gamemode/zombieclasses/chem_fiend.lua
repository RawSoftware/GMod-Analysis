CLASS.Name = "Chem Fiend" CLASS.TranslationName = "class_chem_fiend" CLASS.Description = "description_chem_fiend" CLASS.Help = "controls_chem_fiend"  CLASS.BetterVersion = "Chem Breacher"  CLASS.Model = Model("models/player/skeleton.mdl") CLASS.OverrideModel = Model("models/player/zelpa/stalker.mdl")  CLASS.CanTaunt = true  CLASS.SWEP = "weapon_zs_chemfiend" CLASS.Cat = ZCLASSCAT_DESTRUC  CLASS.Wave = 4 / 6  CLASS.Health = 325 CLASS.HealthPerWave = 35 CLASS.Speed = 165  CLASS.Points = CLASS.Health/GM.HumanoidZombiePointRatio  CLASS.VoicePitch = 1.45  CLASS.CanFeignDeath = true  CLASS.NoHideMainModel = true CLASS.UsePrimaryRagdoll = true  CLASS.Skeletal = true  local math_random = math.random local math_min = math.min local math_max = math.max local DMG_BULLET = DMG_BULLET local ACT_HL2MP_ZOMBIE_SLUMP_RISE = ACT_HL2MP_ZOMBIE_SLUMP_RISE local ACT_HL2MP_SWIM_PISTOL = ACT_HL2MP_SWIM_PISTOL local ACT_HL2MP_IDLE_CROUCH_FIST = ACT_HL2MP_IDLE_CROUCH_FIST local ACT_HL2MP_IDLE_KNIFE = ACT_HL2MP_IDLE_KNIFE local ACT_HL2MP_WALK_CROUCH_KNIFE = ACT_HL2MP_WALK_CROUCH_KNIFE local ACT_HL2MP_RUN_KNIFE = ACT_HL2MP_RUN_KNIFE  function CLASS:KnockedDown(pl, status, exists)  pl:AnimResetGestureSlot(GESTURE_SLOT_ATTACK_AND_RELOAD) end  function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)  if math_random(2) == 1 then  pl:EmitSound("npc/barnacle/neck_snap1.wav", 65, math_random(55, 60), 0.28)  else  pl:EmitSound("npc/barnacle/neck_snap2.wav", 65, math_random(55, 60), 0.28)  end   return true end  function CLASS:CalcMainActivity(pl, velocity)  if velocity:Length2DSqr() <= 1 then  return ACT_IDLE, -1  end   return ACT_WALK, -1 end  function CLASS:PlayPainSound(pl)  pl:EmitSound("npc/barnacle/barnacle_pull"..math_random(3)..".wav", 70, math_random(65, 75))  pl.NextPainSound = CurTime() + 0.5   return true end  function CLASS:PlayDeathSound(pl)  pl:EmitSound("npc/zombie/zombie_die"..math_random(3)..".wav", 70, math_random(50, 55))   return true end   function CLASS:CalcMainActivity(pl, velocity)  local feign = pl.FeignDeath  if feign and feign:IsValid() then  if feign:GetDirection() == DIR_BACK then  return 1, pl:LookupSequence("zombie_slump_rise_02_fast")  end   return ACT_HL2MP_ZOMBIE_SLUMP_RISE, -1  end   if pl:WaterLevel() >= 3 then  return ACT_HL2MP_SWIM_PISTOL, -1  end   if velocity:Length2DSqr() <= 1 then  if pl:Crouching() and pl:OnGround() then  return ACT_HL2MP_IDLE_CROUCH_FIST, -1  end   return ACT_HL2MP_IDLE_KNIFE, -1  end   if pl:Crouching() and pl:OnGround() then  return ACT_HL2MP_WALK_CROUCH_KNIFE, -1  end   return ACT_HL2MP_RUN_KNIFE, -1 end  function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)  local feign = pl.FeignDeath  if feign and feign:IsValid() then  if feign:GetState() == 1 then  pl:SetCycle(1 - math_max(feign:GetStateEndTime() - CurTime(), 0) * 0.666)  else  pl:SetCycle(math_max(feign:GetStateEndTime() - CurTime(), 0) * 0.666)  end  pl:SetPlaybackRate(0)  return true  end   local len = velocity:Length()  if len > 1 then     pl:SetPlaybackRate(math_min(len / maxseqgroundspeed, 3))  else  pl:SetPlaybackRate(1)  end   return true end  function CLASS:DoAnimationEvent(pl, event, data)  if event == PLAYERANIMEVENT_ATTACK_PRIMARY then  pl:DoZombieAttackAnim(data)  return ACT_INVALID  elseif event == PLAYERANIMEVENT_RELOAD then  pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_TAUNT_ZOMBIE, true)  return ACT_INVALID  end end  function CLASS:DoesntGiveFear(pl)  return pl.FeignDeath and pl.FeignDeath:IsValid() end  if SERVER then     function CLASS:AltUse(pl)         pl:StartFeignDeath()     end end  if not CLIENT then return end  CLASS.Icon = "zombiesurvival/killicons/skeletal_walker" CLASS.IconColor = Color(50, 145, 50)  local render_SetBlend = render.SetBlend local render_SetColorModulation = render.SetColorModulation local render_SetMaterial = render.SetMaterial local render_DrawSprite = render.DrawSprite local render_ModelMaterialOverride = render.ModelMaterialOverride local angle_zero = angle_zero local LocalToWorld = LocalToWorld  local colGlow = Color(145, 255, 145) local matGlow = Material("sprites/glow04_noz") local matSkin = CreateMaterial("chemfiendsheet", "VertexLitGeneric", {["$basetexture"] = "Models/headcrab_classic/headcrabsheet", ["$model"] = 1}) local vecEyeLeft = Vector(5, -3.5, -1) local vecEyeRight = Vector(5, -3.5, 1)  function CLASS:PrePlayerDraw(pl)  render_SetBlend(1)  render_SetColorModulation(0.35, 0.65, 0.35) end  function CLASS:PostPlayerDraw(pl)  render_SetBlend(1)  render_SetColorModulation(1, 1, 1) end  function CLASS:PrePlayerDrawOverrideModel(pl)  render_ModelMaterialOverride(matSkin)  render.SetColorModulation(0.45, 0.85, 0.45) end  function CLASS:PostPlayerDrawOverrideModel(pl)  render_ModelMaterialOverride(nil)  render_SetColorModulation(1, 1, 1)   if pl == MySelf and not pl:ShouldDrawLocalPlayer() or pl.SpawnProtection or not pl:Alive() then return end   local pos, ang = pl:GetBonePositionMatrixed(6)  if pos then  render_SetMaterial(matGlow)  render_DrawSprite(LocalToWorld(vecEyeLeft, angle_zero, pos, ang), 4, 4, colGlow)  render_DrawSprite(LocalToWorld(vecEyeRight, angle_zero, pos, ang), 4, 4, colGlow)  end end 