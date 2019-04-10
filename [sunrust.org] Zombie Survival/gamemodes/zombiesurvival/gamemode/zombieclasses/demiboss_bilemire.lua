CLASS.Base = "boss_pukepus"  CLASS.Name = "Bilemire" CLASS.TranslationName = "class_bilemire" CLASS.Description = "description_bilemire" CLASS.Help = "controls_pukepus"  CLASS.Demiboss = true CLASS.Boss = false  CLASS.KnockbackScale = 0.5  CLASS.FearPerInstance = 0.4  CLASS.Health = 1050 CLASS.SWEP = "weapon_zs_pukepus_bilemire"  CLASS.Model = Model("models/Zombie/Poison.mdl")  CLASS.Speed = 155 CLASS.Points = CLASS.Health/GM.PoisonZombiePointRatio CLASS.Cat = ZCLASSCAT_SUPPORT  CLASS.PainSounds = {"NPC_PoisonZombie.Pain"} CLASS.DeathSounds = {Sound("npc/zombie_poison/pz_call1.wav")}  CLASS.ViewOffset = Vector(0, 0, 50) CLASS.Hull = {Vector(-16, -16, 0), Vector(16, 16, 64)} CLASS.HullDuck = {Vector(-16, -16, 0), Vector(16, 16, 35)}  CLASS.CanFeignDeath = false  CLASS.BloodColor = BLOOD_COLOR_YELLOW  function CLASS:ProcessDamage(pl, dmginfo) end  if SERVER then  function CLASS:OnKilled(pl, attacker, inflictor, suicide, headshot, dmginfo, assister) end end  if not CLIENT then return end  CLASS.Icon = "zombiesurvival/killicons/pukepus" CLASS.IconColor = Color(170, 220, 0)  local matSkin = Material("models/zombie_classic/zombie_classic_sheet") function CLASS:PrePlayerDraw(pl)  render.ModelMaterialOverride(matSkin)  render.SetColorModulation(70/255, 116/255, 0.12) end  function CLASS:PostPlayerDraw(pl)  render.ModelMaterialOverride()  render.SetColorModulation(1, 1, 1) end  function CLASS:BuildBonePositions(pl) end