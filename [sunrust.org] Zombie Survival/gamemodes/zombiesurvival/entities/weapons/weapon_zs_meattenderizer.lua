AddCSLuaFile()  SWEP.PrintName = "Meat Tenderizer" SWEP.Description = "A slow swinging meat tenderizer with not much special about it apart from the fact it's a culinary tool."  if CLIENT then  SWEP.ViewModelFOV = 70  SWEP.ShowViewModel = false  SWEP.ShowWorldModel = false   SWEP.VElements = {  ["spikes2"] = { type = "Model", model = "models/props_phx/mechanics/slider1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "sledgetop", pos = Vector(-0.051, -5.915, -0.113), angle = Angle(0, 0, -90), size = Vector(0.076, 1.013, 0.356), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },  ["spikes2+"] = { type = "Model", model = "models/props_phx/mechanics/slider1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "sledgetop", pos = Vector(-0.047, 5.934, 0.104), angle = Angle(0, 0, 90), size = Vector(0.076, 1.013, 0.356), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },  ["sledgetop"] = { type = "Model", model = "models/props_junk/cardboard_box001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.466, 2.184, -13.969), angle = Angle(0, 90, -5.652), size = Vector(0.196, 0.326, 0.284), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },  ["spikes"] = { type = "Model", model = "models/props_phx/mechanics/slider1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "sledgetop", pos = Vector(-0.087, -5.854, 0), angle = Angle(-90, 90, 0), size = Vector(0.059, 0.95, 0.374), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },  ["spikes+"] = { type = "Model", model = "models/props_phx/mechanics/slider1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "sledgetop", pos = Vector(-0.04, 5.888, 0), angle = Angle(90, 90, 0), size = Vector(0.059, 0.95, 0.374), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },  ["sledge"] = { type = "Model", model = "models/weapons/w_sledgehammer.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.203, 1.284, 9.852), angle = Angle(180, 0, 0), size = Vector(0.759, 0.759, 0.759), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }  }  SWEP.WElements = {  ["top"] = { type = "Model", model = "models/props_junk/cardboard_box001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "sledge", pos = Vector(0, 0, 26.433), angle = Angle(90, 90, 0), size = Vector(0.196, 0.305, 0.284), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },  ["spikes1++"] = { type = "Model", model = "models/props_phx/mechanics/slider1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "sledge", pos = Vector(-5.422, -0.069, 26.549), angle = Angle(0, -90, 90), size = Vector(0.059, 0.95, 0.374), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },  ["spikes1+++"] = { type = "Model", model = "models/props_phx/mechanics/slider1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "sledge", pos = Vector(5.407, -0.069, 26.538), angle = Angle(0, 90, 90), size = Vector(0.059, 0.95, 0.374), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },  ["spikes1"] = { type = "Model", model = "models/props_phx/mechanics/slider1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "sledge", pos = Vector(-5.487, 0, 26.361), angle = Angle(90, -90, 90), size = Vector(0.076, 1.011, 0.356), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },  ["spikes1+"] = { type = "Model", model = "models/props_phx/mechanics/slider1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "sledge", pos = Vector(5.535, 0.126, 26.361), angle = Angle(90, 90, 90), size = Vector(0.076, 1.011, 0.356), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },  ["sledge"] = { type = "Model", model = "models/weapons/w_sledgehammer.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.203, 1.284, 4.852), angle = Angle(180, 0, 0), size = Vector(0.759, 0.759, 0.759), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }  } end  SWEP.Base = "weapon_zs_basemelee"  SWEP.HoldType = "melee2"  SWEP.DamageType = DMG_CLUB  SWEP.ViewModel = "models/weapons/c_sledgehammer/c_sledgehammer.mdl" SWEP.WorldModel = "models/weapons/w_crowbar.mdl" SWEP.UseHands = true  SWEP.MeleeDamage = 127 SWEP.MeleeRange = 65 SWEP.MeleeSize = 3.55 SWEP.MeleeKnockBack = 240  SWEP.Primary.Delay = 0.9  SWEP.Tier = 4  SWEP.WalkSpeed = SPEED_SLOW  SWEP.SwingRotation = Angle(20, 0, -30) SWEP.SwingOffset = Vector(0, -30, -10) SWEP.SwingTime = 0.3 SWEP.SwingHoldType = "melee"  SWEP.BlockRotation = Angle(-5, 40, -70) SWEP.BlockOffset = Vector(-6, 14, 3)  SWEP.Stability = 80 SWEP.BlockReduction = 0.35  SWEP.AllowQualityWeapons = true SWEP.Culinary = true  SWEP.StaminaUsage = 0.20  GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MELEE_IMPACT_DELAY, -0.1, 1) GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.1, 1) GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_STAMINA_USAGE, -0.007, 1) GAMEMODE:AddNewRemantleBranch(SWEP, 1, "Meat Pulverizer", "Reduced damage but has a chance to gain agility boosts on kill", function(wept)  wept.MeleeDamage = wept.MeleeDamage * 0.8   wept.OnZombieKilled = function(self, zombie, total, dmginfo)  local killer = self:GetOwner()  if zombie:IsValidLivingZombie() and math.random(3) == 1 then  killer:GiveStatus("buff_agility", 14)  end  end end).CollectiveName = "Pulverizer"  function SWEP:PlaySwingSound()  self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(25, 35)) end  function SWEP:PlayHitSound()  self:EmitSound("physics/metal/metal_canister_impact_hard"..math.random(3)..".wav", 75, math.Rand(70, 74)) end  function SWEP:PlayHitFleshSound()  self:EmitSound("physics/flesh/flesh_impact_hard"..math.random(2, 3)..".wav", 75, math.Rand(80, 84)) end 