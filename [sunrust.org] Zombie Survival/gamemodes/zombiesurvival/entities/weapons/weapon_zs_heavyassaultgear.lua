AddCSLuaFile()  SWEP.PrintName = "Heavy Assault Gear" SWEP.Description = "Significantly reduces damage taken while blocking and can block projectiles."  if CLIENT then  SWEP.ViewModelFlip = false  SWEP.ViewModelFOV = 55   SWEP.ShowViewModel = false  SWEP.ShowWorldModel = false   SWEP.VElements = {  ["handle+"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "ValveBiped.Bip01_L_Forearm", rel = "shield", pos = Vector(6.505, -4.529, 3.382), angle = Angle(100.456, 10.519, 0), size = Vector(0.163, 0.115, 0.234), color = Color(70, 70, 70, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["handle"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "ValveBiped.Bip01_L_Forearm", rel = "shield", pos = Vector(-1.907, -2.941, 2.663), angle = Angle(76.897, 10.314, 0), size = Vector(0.182, 0.143, 0.27), color = Color(70, 70, 70, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["shield+++++"] = { type = "Model", model = "models/props_c17/metalladder001.mdl", bone = "ValveBiped.Bip01_L_Forearm", rel = "shield", pos = Vector(0, 3.693, 0.799), angle = Angle(90, -90, 0), size = Vector(0.264, 0.372, 0.148), color = Color(60, 75, 97, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },  ["machete"] = { type = "Model", model = "models/props_c17/gravestone001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.471, 1.49, 2.207), angle = Angle(-178.402, -83.958, 172.276), size = Vector(0.194, 0.064, 0.123), color = Color(90, 90, 90, 255), surpresslightning = false, material = "models/props_pipes/valvewheel001_skin2", skin = 0, bodygroup = {} },  ["machete+"] = { type = "Model", model = "models/props_docks/channelmarker_gib01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "machete", pos = Vector(0, 0.296, -17.227), angle = Angle(180, -90, 0), size = Vector(0.259, 0.025, 0.407), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },  ["shield+"] = { type = "Model", model = "models/props_c17/playground_swingset_seat01a.mdl", bone = "ValveBiped.Bip01_L_Forearm", rel = "shield", pos = Vector(0, 18.079, -1.428), angle = Angle(0, 0, 0), size = Vector(0.99, 2.872, 1.717), color = Color(60, 75, 97, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },  ["machete++"] = { type = "Model", model = "models/props_phx/gears/rack9.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "machete", pos = Vector(0, 1.692, -8.03), angle = Angle(180, 180, 90), size = Vector(0.061, 0.13, 0.522), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },  ["shield++"] = { type = "Model", model = "models/props_c17/playground_swingset_seat01a.mdl", bone = "ValveBiped.Bip01_L_Forearm", rel = "shield", pos = Vector(0, -22.851, 0), angle = Angle(0, 0, 0), size = Vector(0.99, 0.623, 1.717), color = Color(60, 75, 97, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },  ["shield++++"] = { type = "Model", model = "models/props_borealis/borealis_door001a.mdl", bone = "ValveBiped.Bip01_L_Forearm", rel = "shield", pos = Vector(10.602, -11.714, 2.561), angle = Angle(-67.6, 0, -90), size = Vector(0.846, 0.231, 0.28), color = Color(60, 75, 97, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },  ["shield"] = { type = "Model", model = "models/props_c17/playground_swingset_seat01a.mdl", bone = "ValveBiped.Bip01_L_Forearm", rel = "", pos = Vector(4.368, -4.863, -3.556), angle = Angle(-9.455, 0.284, 89.954), size = Vector(0.97, 2.872, 1.717), color = Color(60, 75, 97, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },  ["shield+++"] = { type = "Model", model = "models/props_borealis/borealis_door001a.mdl", bone = "ValveBiped.Bip01_L_Forearm", rel = "shield", pos = Vector(-10.603, -11.714, 2.561), angle = Angle(-112.403, 0, -90), size = Vector(0.846, 0.231, 0.28), color = Color(60, 75, 97, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} }  }   SWEP.WElements = {  ["handle+"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(6.505, -4.529, 3.382), angle = Angle(100.456, 10.519, 0), size = Vector(0.163, 0.115, 0.234), color = Color(70, 70, 70, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["handle"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(-1.907, -2.941, 2.663), angle = Angle(76.897, 10.314, 0), size = Vector(0.182, 0.143, 0.27), color = Color(70, 70, 70, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["machete+"] = { type = "Model", model = "models/props_docks/channelmarker_gib01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "machete", pos = Vector(0, 0.296, -17.227), angle = Angle(180, -90, 0), size = Vector(0.259, 0.025, 0.407), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },  ["shield+"] = { type = "Model", model = "models/props_c17/playground_swingset_seat01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(0, 18.079, -1.428), angle = Angle(0, 0, 0), size = Vector(0.99, 2.872, 1.717), color = Color(60, 75, 97, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },  ["machete++"] = { type = "Model", model = "models/props_phx/gears/rack9.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "machete", pos = Vector(0, 1.692, -8.03), angle = Angle(180, 180, 90), size = Vector(0.061, 0.13, 0.522), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },  ["shield++"] = { type = "Model", model = "models/props_c17/playground_swingset_seat01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(0, -22.851, 0), angle = Angle(0, 0, 0), size = Vector(0.99, 0.623, 1.717), color = Color(60, 75, 97, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },  ["shield+++"] = { type = "Model", model = "models/props_borealis/borealis_door001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(-10.603, -11.714, 2.561), angle = Angle(-112.403, 0, -90), size = Vector(0.846, 0.231, 0.28), color = Color(60, 75, 97, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },  ["machete"] = { type = "Model", model = "models/props_c17/gravestone001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.575, 1.511, 0.845), angle = Angle(-2.235, 110.86, 4.534), size = Vector(0.194, 0.064, 0.123), color = Color(90, 90, 90, 255), surpresslightning = false, material = "models/props_pipes/valvewheel001_skin2", skin = 0, bodygroup = {} },  ["shield++++"] = { type = "Model", model = "models/props_borealis/borealis_door001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(10.602, -11.714, 2.561), angle = Angle(-67.6, 0, -90), size = Vector(0.846, 0.231, 0.28), color = Color(60, 75, 97, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },  ["shield+++++"] = { type = "Model", model = "models/props_c17/metalladder001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(0, 3.693, 0.799), angle = Angle(90, -90, 0), size = Vector(0.264, 0.372, 0.148), color = Color(60, 75, 97, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },  ["shield"] = { type = "Model", model = "models/props_c17/playground_swingset_seat01a.mdl", bone = "ValveBiped.Bip01_L_Forearm", rel = "", pos = Vector(2.691, -5.79, 2.957), angle = Angle(1.434, 9.06, 144.324), size = Vector(0.97, 2.872, 1.717), color = Color(60, 75, 97, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} }  }   SWEP.WElementsDropped = {  ["handle+"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(6.505, -4.529, 3.382), angle = Angle(100.456, 10.519, 0), size = Vector(0.163, 0.115, 0.234), color = Color(70, 70, 70, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["machete"] = { type = "Model", model = "models/props_c17/gravestone001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.775, 1.394, 0.847), angle = Angle(-2.235, 110.86, 4.534), size = Vector(0.194, 0.064, 0.123), color = Color(90, 90, 90, 255), surpresslightning = false, material = "models/props_pipes/valvewheel001_skin2", skin = 0, bodygroup = {} },  ["machete+"] = { type = "Model", model = "models/props_docks/channelmarker_gib01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "machete", pos = Vector(0, 0.296, -17.227), angle = Angle(180, -90, 0), size = Vector(0.259, 0.025, 0.407), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },  ["shield+"] = { type = "Model", model = "models/props_c17/playground_swingset_seat01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(0, 18.079, -1.428), angle = Angle(0, 0, 0), size = Vector(0.99, 2.872, 1.717), color = Color(60, 75, 97, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },  ["machete++"] = { type = "Model", model = "models/props_phx/gears/rack9.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "machete", pos = Vector(0, 1.692, -8.03), angle = Angle(180, 180, 90), size = Vector(0.061, 0.13, 0.522), color = Color(165, 165, 165, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },  ["shield++"] = { type = "Model", model = "models/props_c17/playground_swingset_seat01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(0, -22.851, 0), angle = Angle(0, 0, 0), size = Vector(0.99, 0.623, 1.717), color = Color(60, 75, 97, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },  ["shield"] = { type = "Model", model = "models/props_c17/playground_swingset_seat01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.424, -2.552, 2.957), angle = Angle(-4.834, 16.478, 84.448), size = Vector(0.97, 2.872, 1.717), color = Color(60, 75, 97, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },  ["handle"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(-1.907, -2.941, 2.663), angle = Angle(76.897, 10.314, 0), size = Vector(0.182, 0.143, 0.27), color = Color(70, 70, 70, 255), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["shield++++"] = { type = "Model", model = "models/props_borealis/borealis_door001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(10.602, -11.714, 2.561), angle = Angle(-67.6, 0, -90), size = Vector(0.846, 0.231, 0.28), color = Color(60, 75, 97, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },  ["shield+++++"] = { type = "Model", model = "models/props_c17/metalladder001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(0, 3.693, 0.799), angle = Angle(90, -90, 0), size = Vector(0.264, 0.372, 0.148), color = Color(60, 75, 97, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },  ["shield+++"] = { type = "Model", model = "models/props_borealis/borealis_door001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(-10.603, -11.714, 2.561), angle = Angle(-112.403, 0, -90), size = Vector(0.846, 0.231, 0.28), color = Color(60, 75, 97, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} }  }   SWEP.ViewModelBoneMods = {  ["ValveBiped.Bip01_L_Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -51.473, 0) },  ["ValveBiped.Bip01_L_Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -92.187, 0) },  ["ValveBiped.Bip01_L_Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 34.062, 0) },  ["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-33.37, -73.085, 58.103) },  ["ValveBiped.Bip01_L_Finger42"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -136.961, 0) },  ["ValveBiped.Bip01_L_Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 10.699, 0) },  ["ValveBiped.Bip01_L_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-28.775, 2.098, -76.968) },  ["ValveBiped.Bip01_L_Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -38.375, 0) },  ["ValveBiped.Bip01_L_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -45, 0) },  ["ValveBiped.Bip01_L_Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -83.612, 0) },  ["ValveBiped.Bip01_L_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-11.103, -32.778, 34.841) },  ["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0.769, -2.987, -0.709) },  ["ValveBiped.Bip01_L_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -31.598, 0) },  ["ValveBiped.Bip01_L_Finger12"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -95.276, 0) },  ["ValveBiped.Bip01_L_Finger32"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -90.584, 0) },  ["ValveBiped.Bip01_L_Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(10.597, -35.71, 14.869) },  ["ValveBiped.Bip01_L_Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -27.734, 0) },  ["ValveBiped.Bip01_L_Finger22"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -102.306, 0) },  ["ValveBiped.Bip01_L_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-11.731, 11.744, 5.59) }  } end  SWEP.Base = "weapon_zs_basemelee"  SWEP.ViewModel = "models/weapons/c_stunstick.mdl" SWEP.WorldModel = "models/weapons/w_crowbar.mdl" SWEP.UseHands = true  SWEP.MeleeDamage = 123 SWEP.MeleeRange = 58 SWEP.MeleeSize = 1.3  SWEP.Primary.Delay = 1.2  SWEP.WalkSpeed = SPEED_SLOWEST  SWEP.SwingRotation = Angle(12, -20, 7) SWEP.SwingOffset = Vector(2, -3, 0) SWEP.SwingTime = 0.55 SWEP.SwingHoldType = "grenade"  SWEP.HitDecal = "Manhackcut" SWEP.HitAnim = ACT_VM_MISSCENTER  SWEP.BlockRotation = Angle(-10, -70, 10) SWEP.BlockOffset = Vector(16, 4, 0) SWEP.BlockHoldType = "melee2"  SWEP.BlockReduction = 0 SWEP.ShieldBlock = true SWEP.BashAdd = 305  SWEP.Stability = 160  SWEP.Tier = 4  SWEP.AllowQualityWeapons = true  SWEP.StaminaUsage = 0.25  GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.1, 1) GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_BLOCK_STAB, 10, 1) GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Red Sun' Explosive Assault Gear", "Causes an explosion on block, reduced stamina, reduced damage", function(wept)  wept.MeleeDamage = wept.MeleeDamage * 0.92  wept.Stability = wept.Stability / 2  wept.OnBlockedAttack = function(self, attacker, damage, dmginfo)  local owner = self:GetOwner()  local pos = owner:WorldSpaceCenter() + (attacker:GetPos() - owner:GetPos()):GetNormalized() * math.min(owner:GetPos():Distance(attacker:GetPos()), 72)   local effectdata = EffectData()  effectdata:SetOrigin(pos)  util.Effect("explosion_redsun", effectdata)   timer.Simple(0, function()             util.BlastDamagePlayer(self, owner, pos, 65, wept.MeleeDamage * 0.65, DMG_ALWAYSGIB, 0.96, {[owner] = true})         end)  end   if CLIENT then  wept.VElements["machete"].color = Color(170, 0, 50)  wept.VElements["machete+"].color = Color(255, 180, 180)  wept.VElements["machete++"].color = Color(255, 180, 180)  wept.VElements["shield"].color = Color(50, 50, 50)  wept.VElements["shield+"].color = Color(95, 0, 22)  wept.VElements["shield++"].color = Color(50, 50, 50)  wept.VElements["shield+++"].color = Color(95, 0, 22)  wept.VElements["shield++++"].color = Color(95, 0, 22)  wept.VElements["shield+++++"].color = Color(95, 0, 22)   wept.WElements["machete"].color = Color(170, 0, 50)  wept.WElements["machete+"].color = Color(255, 180, 180)  wept.WElements["machete++"].color = Color(255, 180, 180)  wept.WElements["shield"].color = Color(50, 50, 50)  wept.WElements["shield+"].color = Color(95, 0, 22)  wept.WElements["shield++"].color = Color(50, 50, 50)  wept.WElements["shield+++"].color = Color(95, 0, 22)  wept.WElements["shield++++"].color = Color(95, 0, 22)  wept.WElements["shield+++++"].color = Color(95, 0, 22)   wept.WElementsDropped["machete"].color = Color(170, 0, 50)  wept.WElementsDropped["machete+"].color = Color(255, 180, 180)  wept.WElementsDropped["machete++"].color = Color(255, 180, 180)  wept.WElementsDropped["shield"].color = Color(50, 50, 50)  wept.WElementsDropped["shield+"].color = Color(95, 0, 22)  wept.WElementsDropped["shield++"].color = Color(50, 50, 50)  wept.WElementsDropped["shield+++"].color = Color(95, 0, 22)  wept.WElementsDropped["shield++++"].color = Color(95, 0, 22)  wept.WElementsDropped["shield+++++"].color = Color(95, 0, 22)   local VNewElements = {  ["shield+++++++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(10.968, -12.308, 1.6), angle = Angle(-67.788, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield+++++++++++++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(-10.969, 1.838, 1.6), angle = Angle(-112.213, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(0, 24.225, -0.401), angle = Angle(-90, 90, 0), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield+++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(0, 17.333, -0.401), angle = Angle(-90, 90, 0), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield++++++++++++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(-10.969, -5.237, 1.6), angle = Angle(-112.213, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield++++++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(10.968, -19.296, 1.6), angle = Angle(-67.788, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield++++++++++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(-10.969, -19.296, 1.6), angle = Angle(-112.213, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield+++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(0, 30.965, -0.401), angle = Angle(-90, 90, 0), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield+++++++++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(10.968, 1.838, 1.6), angle = Angle(-67.788, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield++++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(10.232, 24.225, 1.768), angle = Angle(-66.172, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(-10.233, 24.225, 1.768), angle = Angle(-113.829, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield+++++++++++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(-10.969, -12.308, 1.6), angle = Angle(-112.213, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield+++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(10.232, 17.333, 1.768), angle = Angle(-66.172, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(10.232, 10.491, 1.768), angle = Angle(-66.172, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(-10.233, 10.491, 1.768), angle = Angle(-113.829, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield+++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(-10.233, 30.965, 1.768), angle = Angle(-113.829, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield++++++++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(10.968, -5.237, 1.6), angle = Angle(-67.788, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield+++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(-10.233, 17.333, 1.768), angle = Angle(-113.829, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(0, 10.491, -0.401), angle = Angle(-90, 90, 0), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield+++++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(10.232, 30.965, 1.768), angle = Angle(-66.172, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  }   local WNewElements = {  ["shield+++++++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(10.968, -12.308, 1.6), angle = Angle(-67.788, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield+++++++++++++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(-10.969, 1.838, 1.6), angle = Angle(-112.213, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(0, 24.225, -0.401), angle = Angle(-90, 90, 0), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield+++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(0, 17.333, -0.401), angle = Angle(-90, 90, 0), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield++++++++++++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(-10.969, -5.237, 1.6), angle = Angle(-112.213, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield++++++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(10.968, -19.296, 1.6), angle = Angle(-67.788, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield++++++++++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(-10.969, -19.296, 1.6), angle = Angle(-112.213, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield+++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(0, 30.965, -0.401), angle = Angle(-90, 90, 0), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield+++++++++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(10.968, 1.838, 1.6), angle = Angle(-67.788, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield++++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(10.232, 24.225, 1.768), angle = Angle(-66.172, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(-10.233, 24.225, 1.768), angle = Angle(-113.829, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield+++++++++++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(-10.969, -12.308, 1.6), angle = Angle(-112.213, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield+++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(10.232, 17.333, 1.768), angle = Angle(-66.172, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(10.232, 10.491, 1.768), angle = Angle(-66.172, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(-10.233, 10.491, 1.768), angle = Angle(-113.829, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield+++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(-10.233, 30.965, 1.768), angle = Angle(-113.829, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield++++++++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(10.968, -5.237, 1.6), angle = Angle(-67.788, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield+++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(-10.233, 17.333, 1.768), angle = Angle(-113.829, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(0, 10.491, -0.401), angle = Angle(-90, 90, 0), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["shield+++++++++++++++++"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "shield", pos = Vector(10.232, 30.965, 1.768), angle = Angle(-66.172, 0, -90), size = Vector(0.18, 0.125, 0.057), color = Color(130, 0, 19, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  }   table.Add(wept.VElements, VNewElements)  table.Add(wept.WElements, WNewElements)  table.Add(wept.WElementsDropped, WNewElements)  end  end).CollectiveName = "Explosive"  function SWEP:PlaySwingSound()  self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(85, 90)) end  function SWEP:PlayHitSound()  self:EmitSound("ambient/machines/slicer"..math.random(4)..".wav", 75, math.random(90, 95)) end  function SWEP:PlayHitFleshSound()  self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav", 75, math.Rand(95, 105), nil, CHAN_AUTO) end 