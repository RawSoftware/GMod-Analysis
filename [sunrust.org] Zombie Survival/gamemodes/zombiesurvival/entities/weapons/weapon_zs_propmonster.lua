AddCSLuaFile()  SWEP.Base = "weapon_zs_zombie" local BaseClass = baseclass.Get("weapon_zs_zombie")  SWEP.PrintName = "Corrupted Amalgam" SWEP.WorldModel = Model("models/Weapons/v_zombiearms.mdl")  SWEP.MeleeDelay = 0.37 SWEP.MeleeReach = 78 SWEP.MeleeDamage = 51 SWEP.ThornsDuration = 20 / SWEP.MeleeDamage SWEP.MeleeSize = 6  SWEP.GreatEvil = true  SWEP.TryAlt = true  SWEP.DelayWhenDeployed = true  SWEP.ShowViewModel = false SWEP.ShowWorldModel = false     SWEP.WElements = {  ["main+"] = { type = "Model", model = "models/props_c17/tv_monitor01.mdl", bone = "Dog_Model.Spine3", rel = "", pos = Vector(2.441, -7.216, 1.256), angle = Angle(5.512, -61.644, 95.058), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["r_arm++"] = { type = "Model", model = "models/weapons/w_rocket_launcher.mdl", bone = "Dog_Model.Arm1_R", rel = "", pos = Vector(32.148, 0.565, -3.814), angle = Angle(10.317, 174.598, 91.987), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["r_arm++++++++"] = { type = "Model", model = "models/props_combine/breenbust.mdl", bone = "Dog_Model.Hand_R", rel = "", pos = Vector(4.875, -9.886, 8.402), angle = Angle(176.365, 126.138, -116.38), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["main++"] = { type = "Model", model = "models/props_c17/chair02a.mdl", bone = "Dog_Model.Spine3", rel = "", pos = Vector(-12.787, 21.006, 8.991), angle = Angle(-46.82, -10.297, -36.959), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["nail++++"] = { type = "Model", model = "models/crossbow_bolt.mdl", bone = "Dog_Model.Arm1_R", rel = "", pos = Vector(3.661, -7.321, 1.435), angle = Angle(-43.783, -107.948, -165.976), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["dummy1+"] = { type = "Model", model = "models/props_junk/PopCan01a.mdl", bone = "Dog_Model.Thumb2_L", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["dummy3+"] = { type = "Model", model = "models/props_junk/PopCan01a.mdl", bone = "Dog_Model.Index2_L", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["nail++++++++"] = { type = "Model", model = "models/crossbow_bolt.mdl", bone = "Dog_Model.Spine1", rel = "", pos = Vector(38.278, -32.501, -2.302), angle = Angle(-20.511, -134.088, 9.633), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["r_arm++++"] = { type = "Model", model = "models/items/healthkit.mdl", bone = "Dog_Model.Arm2_R", rel = "", pos = Vector(12.689, 4.012, 1.833), angle = Angle(18.263, -1.821, 18.179), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["gib+"] = { type = "Model", model = "models/gibs/antlion_gib_large_1.mdl", bone = "Dog_Model.Arm2_R", rel = "", pos = Vector(29.906, 7.565, -8.395), angle = Angle(-44.457, 93.265, 90.545), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/flesh", skin = 0, bodygroup = {} },  ["r_arm+++++"] = { type = "Model", model = "models/props_c17/BriefCase001a.mdl", bone = "Dog_Model.Arm2_R", rel = "", pos = Vector(19.757, 1.531, -2.939), angle = Angle(165.388, -157.87, -81.85), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["eye++"] = { type = "Sprite", sprite = "sprites/orangeflare1", bone = "Dog_Model.Eye", rel = "", pos = Vector(7.684, 2.68, -0.434), size = { x = 44.208, y = 2 }, color = Color(255, 0, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},  ["shard"] = { type = "Model", model = "models/props_junk/rock001a.mdl", bone = "Dog_Model.Spine3", rel = "", pos = Vector(9.864, 0.939, -0.921), angle = Angle(-17.466, 5.879, -82.69), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!sigil_green", skin = 0, bodygroup = {} },  ["nail++"] = { type = "Model", model = "models/crossbow_bolt.mdl", bone = "Dog_Model.Spine1", rel = "", pos = Vector(14.064, -0.392, 1.292), angle = Angle(9.781, -117.509, -152.864), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["main++++"] = { type = "Model", model = "models/props_junk/sawblade001a.mdl", bone = "Dog_Model.Spine3", rel = "", pos = Vector(11.637, -1.459, -14.874), angle = Angle(9.192, 151.671, 5.098), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["r_arm+++"] = { type = "Model", model = "models/props_c17/chair_stool01a.mdl", bone = "Dog_Model.Arm2_R", rel = "", pos = Vector(37.478, -0.299, 7.346), angle = Angle(-2.296, -77.641, 104.253), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["eye"] = { type = "Sprite", sprite = "sprites/orangeflare1", bone = "Dog_Model.Eye", rel = "", pos = Vector(7.684, 2.68, -0.434), size = { x = 21.416, y = 21.416 }, color = Color(255, 0, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},  ["head"] = { type = "Model", model = "models/gibs/scanner_gib05.mdl", bone = "Dog_Model.Eye", rel = "", pos = Vector(-3.948, -1.418, -0.784), angle = Angle(0, -18.251, 111.708), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["dummy2++"] = { type = "Model", model = "models/props_junk/PopCan01a.mdl", bone = "Dog_Model.Pinky3_L", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["back"] = { type = "Model", model = "models/props_junk/propanecanister001a.mdl", bone = "Dog_Model.Spine2", rel = "", pos = Vector(-5.586, 5.201, 0), angle = Angle(-30.445, 15.534, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["nail"] = { type = "Model", model = "models/crossbow_bolt.mdl", bone = "Dog_Model.Spine1", rel = "", pos = Vector(38.278, 5.453, -2.302), angle = Angle(0, -130.737, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["main"] = { type = "Model", model = "models/props_c17/trappropeller_engine.mdl", bone = "Dog_Model.Spine3", rel = "", pos = Vector(21.124, 11.027, 1.085), angle = Angle(-13.469, -49.063, 73.834), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["shard_arm++"] = { type = "Model", model = "models/props_debris/concrete_chunk02b.mdl", bone = "Dog_Model.Arm2_L", rel = "", pos = Vector(0, 0, 0), angle = Angle(4.905, 109.275, 2.91), size = Vector(0.165, 0.275, 0.476), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!sigil_green", skin = 0, bodygroup = {} },  ["shard_arm+"] = { type = "Model", model = "models/props_debris/concrete_chunk08a.mdl", bone = "Dog_Model.Arm2_L", rel = "", pos = Vector(28.247, 2.517, -0.793), angle = Angle(0, 104.101, 0), size = Vector(0.785, 0.785, 0.785), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!sigil_green", skin = 0, bodygroup = {} },  ["r_arm+"] = { type = "Model", model = "models/props_junk/trafficcone001a.mdl", bone = "Dog_Model.Arm1_R", rel = "", pos = Vector(-0.95, 0.157, -1.563), angle = Angle(87.996, -10.049, -3.307), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["dummy3++"] = { type = "Model", model = "models/props_junk/PopCan01a.mdl", bone = "Dog_Model.Index3_L", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["nail+++++"] = { type = "Model", model = "models/crossbow_bolt.mdl", bone = "Dog_Model.Arm2_R", rel = "", pos = Vector(15.619, 4.565, 2.43), angle = Angle(-107.324, -97.166, -165.976), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["dummy3"] = { type = "Model", model = "models/props_junk/PopCan01a.mdl", bone = "Dog_Model.Index1_L", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["main+++++"] = { type = "Model", model = "models/props_c17/metalpot002a.mdl", bone = "Dog_Model.Spine3", rel = "", pos = Vector(32.492, -5.414, 1.554), angle = Angle(-26.168, 114.068, -83.676), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["shard_arm"] = { type = "Model", model = "models/props_debris/concrete_chunk03a.mdl", bone = "Dog_Model.Arm1_L", rel = "", pos = Vector(4.243, 0.814, 6.808), angle = Angle(0, 28.52, 0), size = Vector(1.184, 1.184, 1.184), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!sigil_green", skin = 0, bodygroup = {} },  ["dummy1"] = { type = "Model", model = "models/props_junk/PopCan01a.mdl", bone = "Dog_Model.Thumb1_L", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["nail+++++++++"] = { type = "Model", model = "models/crossbow_bolt.mdl", bone = "Dog_Model.Arm1_R", rel = "", pos = Vector(30.236, -6.342, 2.101), angle = Angle(-82.897, -125.718, 49.784), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["r_arm+++++++"] = { type = "Model", model = "models/props_junk/cinderblock01a.mdl", bone = "Dog_Model.Hand_R", rel = "", pos = Vector(8.232, 1.06, 12.51), angle = Angle(108.014, -94.554, -31.767), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["nail+++++++"] = { type = "Model", model = "models/crossbow_bolt.mdl", bone = "Dog_Model.Hand_R", rel = "", pos = Vector(11.98, 1.952, 4.326), angle = Angle(28.187, 123.794, -165.976), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["r_arm"] = { type = "Model", model = "models/props_debris/wood_chunk06d.mdl", bone = "Dog_Model.Arm1_R", rel = "", pos = Vector(7.722, 0.527, -9.53), angle = Angle(76.67, 4.065, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["dummy2+"] = { type = "Model", model = "models/props_junk/PopCan01a.mdl", bone = "Dog_Model.Pinky2_L", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["gib"] = { type = "Model", model = "models/gibs/antlion_gib_medium_2.mdl", bone = "Dog_Model.Arm1_R", rel = "", pos = Vector(31.563, -1.78, -10.794), angle = Angle(-168.997, 98.204, 165.945), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/flesh", skin = 0, bodygroup = {} },  ["dummy2"] = { type = "Model", model = "models/props_junk/PopCan01a.mdl", bone = "Dog_Model.Pinky1_L", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["main+++"] = { type = "Model", model = "models/props_junk/cinderblock01a.mdl", bone = "Dog_Model.Spine3", rel = "", pos = Vector(18.121, -13.122, -2.757), angle = Angle(3.933, 155.595, -4.794), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["nail+"] = { type = "Model", model = "models/crossbow_bolt.mdl", bone = "Dog_Model.Spine1", rel = "", pos = Vector(27.506, -21.673, -20.917), angle = Angle(39.083, -32.738, -152.864), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["eye+"] = { type = "Sprite", sprite = "sprites/orangeflare1", bone = "Dog_Model.Eye", rel = "", pos = Vector(7.684, 2.68, -0.434), size = { x = 2.721, y = 43.44 }, color = Color(255, 0, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false} }  AccessorFuncDT(SWEP, "PoundCounter", "Int", 10) AccessorFuncDT(SWEP, "NextPound", "Float", 20)  function SWEP:Initialize()  if CLIENT then  self:SCKInit()  end end  function SWEP:ApplyMeleeDamage(ent, trace, damage)  local owner = self:GetOwner()  if SERVER and ent:IsPlayer() then  ent:GiveStatus("debuff_corruptedthorns", damage * self.ThornsDuration, owner)  end   BaseClass.ApplyMeleeDamage(self, ent, trace, damage) end  function SWEP:Think()  BaseClass.Think(self)   if self:GetNextPound() ~= 0 and CurTime() >= self:GetNextPound() then  self:SetNextPound(0)   local owner = self:GetOwner()   owner:ResetSpeed()  owner:RawCapLegDamage(CurTime() + 1.5)   if SERVER then  local radius = 245  local worldspace = owner:WorldSpaceCenter()   for _, ent in pairs(util.BlastAlloc(self, owner, worldspace, radius)) do  if IsValid(ent) and ent ~= owner then  local nearest = ent:NearestPoint(worldspace)  local dist = (radius - nearest:Distance(worldspace)) / radius   ent:TakeSpecialDamage(dist * 24, DMG_GENERIC, owner, self)   if ent:IsHuman() and ent:Alive() then  ent:GiveStatus("debuff_corruptedthorns", math.max(20, dist * 80), owner)  end  end  end   util.ScreenShake(worldspace, 6, 1.5, 1.5, 900)  owner:EmitSound("physics/concrete/concrete_break2.wav", 80, 50)   local effectdata = EffectData()  effectdata:SetOrigin(worldspace)  effectdata:SetNormal(Vector(0, 0, 1))  util.Effect("explosion_corruptedthorns", effectdata, true, true)  util.Effect("ThumperDust", effectdata, true, true)  end  end end    for k, v in pairs( SWEP.WElements ) do  if v and v.model then  util.PrecacheModel( v.model )  end end  function SWEP:PlayHitSound()  self:EmitSound("npc/zombie/claw_strike"..math.random(1, 3)..".wav", 75, 80, nil, CHAN_AUTO)  self:EmitSound("npc/dog/dog_drop_gate1.wav", 75, math.random( 95, 105 ), nil, CHAN_AUTO) end  function SWEP:PlayMissSound()  self:EmitSound("npc/zombie/claw_miss"..math.random(1, 2)..".wav", 75, 80, nil, CHAN_AUTO) end  function SWEP:PlayAttackSound()  self:EmitSound("npc/dog/dog_straining"..math.random(3)..".wav", 80, math.random( 150, 165 ), nil, CHAN_AUTO)  self:EmitSound("npc/strider/striderx_pain8.wav", 80, math.random(90, 115), nil, CHAN_AUTO) end  function SWEP:PrimaryAttack()  if CurTime() < self:GetNextPrimaryFire() then return end   if self:GetPoundCounter() >= 4 then  self:Reload()  self:SetPoundCounter(0)  else  local owner = self:GetOwner()  local armdelay = owner:GetMeleeSpeedMul()   self:SetNextPrimaryFire(CurTime() + self.Primary.Delay * armdelay)  self:StartSwinging()  self:SetPoundCounter(self:GetPoundCounter() + 1)  end end  function SWEP:Reload()  if CurTime() < self:GetNextPrimaryFire() then return end   local owner = self:GetOwner()   self:SetNextPound(CurTime() + 1.2)  self:SetNextPrimaryFire(CurTime() + 2)   owner:SetSpeed(1)  owner:DoCustomAnimEvent( PLAYERANIMEVENT_ATTACK_SECONDARY, 1 )   local pos, ang = owner:GetBonePositionMatrixed(17)  local effectdata = EffectData()  effectdata:SetOrigin(LocalToWorld(Vector(5, -3, 0), angle_zero, pos, ang))  effectdata:SetNormal(ang:Forward())  effectdata:SetEntity(owner)  util.Effect("danger_warning", effectdata) end  function SWEP:SecondaryAttack()  self.NextThrow = self.NextThrow or 0  if self.NextThrow > CurTime() then return end   self:SetNextPrimaryFire(CurTime() + 4.1)  self.NextThrow = CurTime() + 8.2   local owner = self:GetOwner()   owner:DoReloadEvent()   local vStart = owner:GetShootPos()  local vEnd = vStart + owner:GetForward() * 60   local tr = util.TraceHull({start=vStart, endpos=vEnd, filter=owner, mins=owner:OBBMins()/1.2, maxs=owner:OBBMaxs()/1.2})   owner:SetSpeed(1)   if SERVER then  local rock = ents.Create("projectile_largeconcrete")  if rock:IsValid() then  local pos = owner:GetPos() - owner:GetForward() * 5 + Vector(0, 0, 12)  if not tr.Hit then  pos = pos + owner:GetForward() * 100  end   rock:SetAngles(Angle(0, owner:EyeAngles().y, 0))  rock:SetPos(pos)  rock:SetOwner(owner)  rock:Spawn()   local con = ents.Create("env_propmonstercontrol")  if con:IsValid() then  con:Spawn()  con:SetOwner(owner)  con:AttachTo(rock)  rock.Control = con   util.ScreenShake(owner:GetPos(), 8, 2, 1, 1200)   con:EmitSound("physics/concrete/concrete_break3.wav", 85, 60)  rock:EmitSound(")weapons/physcannon/physcannon_claws_close.wav")   owner.LastRangedAttack = CurTime()  end   local effectdata = EffectData()  effectdata:SetOrigin( rock:GetPos() )  effectdata:SetEntity( rock )  effectdata:SetRadius( owner:EntIndex() )  effectdata:SetMagnitude( 3.3 )  util.Effect("propmonster_grab", effectdata, nil, true)  effectdata:SetAngles(owner:GetAngles())  util.Effect("propmonster_rock_pull", effectdata, nil, true)  end  end end  if CLIENT then  function SWEP:PreDrawViewModel(vm)      if self.ShowViewModel == false then          render.SetBlend(0)      end  end   function SWEP:DrawViewModel(vm)      if self.ShowViewModel == false then          render.SetBlend(1)      end  end   function SWEP:DrawWorldModel()  self:SCKWorldModel()  end end 