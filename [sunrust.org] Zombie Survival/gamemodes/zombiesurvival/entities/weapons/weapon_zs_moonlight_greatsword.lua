AddCSLuaFile() local BaseClass = baseclass.Get("weapon_zs_basemelee")  SWEP.PrintName = "Moonlight Greatsword" SWEP.Description = "Can cleave through multiple zombies in one swing or unleash a piercing wave of energy."  if CLIENT then     SWEP.ViewModelFOV = 50     SWEP.ShowViewModel = false     SWEP.ShowWorldModel = false      SWEP.VElements = {         ["bottom"] = { type = "Model", model = "models/Mechanics/robotics/a1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "HANDLE", pos = Vector(0.026, 0, -0.88), angle = Angle(91.926, 0, 0), size = Vector(0.09, 0.245, 0.245), color = Color(255, 255, 245, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },         ["guard+"] = { type = "Model", model = "models/mechanics/solid_steel/crossbeam_4.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "HANDLE", pos = Vector(0, 0, 15.237), angle = Angle(0, 45, 0), size = Vector(0.165, 0.165, 0.087), color = Color(255, 255, 245, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },         ["HANDLE"] = { type = "Model", model = "models/props_trainstation/trainstation_column001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.095, 1.45, 8.263), angle = Angle(-174.702, -13.648, 0), size = Vector(0.129, 0.129, 0.059), color = Color(255, 255, 245, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },         ["metalbase"] = { type = "Model", model = "models/mechanics/roboticslarge/claw_guide2l.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "HANDLE", pos = Vector(0, 0, 16.589), angle = Angle(-90, 90, 0), size = Vector(0.02, 0.057, 0.039), color = Color(255, 255, 245, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },         ["sword+"] = { type = "Model", model = "models/props_phx/misc/flakshell_big.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "HANDLE", pos = Vector(0, 0, 16.926), angle = Angle(0, 0, 0), size = Vector(0.239, 0.039, 1.159), color = Color(0, 208, 255, 255), surpresslightning = false, material = "models/effects/comball_sphere", skin = 0, bodygroup = {} },         ["guard"] = { type = "Model", model = "models/props_docks/dock01_cleat01a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "HANDLE", pos = Vector(0, 0, 15.494), angle = Angle(0, 0, 0), size = Vector(0.402, 0.18, 0.115), color = Color(255, 255, 245, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },         ["sword"] = { type = "Model", model = "models/props_phx/misc/flakshell_big.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "HANDLE", pos = Vector(0, 0, 16.926), angle = Angle(0, 0, 0), size = Vector(0.232, 0.035, 1.149), color = Color(0, 120, 140, 255), surpresslightning = false, material = "models/props_wasteland/rockcliff02A", skin = 0, bodygroup = {} }     }     SWEP.DVElements = SWEP.VElements      SWEP.WElements = {         ["bottom"] = { type = "Model", model = "models/Mechanics/robotics/a1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "HANDLE", pos = Vector(0.026, 0, -0.88), angle = Angle(91.926, 0, 0), size = Vector(0.09, 0.245, 0.245), color = Color(255, 255, 245, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },         ["guard+"] = { type = "Model", model = "models/mechanics/solid_steel/crossbeam_4.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "HANDLE", pos = Vector(0, 0, 15.237), angle = Angle(0, 45, 0), size = Vector(0.165, 0.165, 0.087), color = Color(255, 255, 245, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },         ["HANDLE"] = { type = "Model", model = "models/props_trainstation/trainstation_column001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.061, 0.768, 9.281), angle = Angle(174.462, 17.018, 2.726), size = Vector(0.129, 0.129, 0.059), color = Color(255, 255, 245, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },         ["sword+"] = { type = "Model", model = "models/props_phx/misc/flakshell_big.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "HANDLE", pos = Vector(0, 0, 16.926), angle = Angle(0, 0, 0), size = Vector(0.243, 0.037, 1.159), color = Color(0, 208, 255, 255), surpresslightning = false, material = "models/effects/comball_sphere", skin = 0, bodygroup = {} },         ["sword"] = { type = "Model", model = "models/props_phx/misc/flakshell_big.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "HANDLE", pos = Vector(0, 0, 16.926), angle = Angle(0, 0, 0), size = Vector(0.232, 0.035, 1.149), color = Color(0, 120, 140, 255), surpresslightning = false, material = "models/props_wasteland/rockcliff02A", skin = 0, bodygroup = {} },         ["metalbase"] = { type = "Model", model = "models/mechanics/roboticslarge/claw_guide2l.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "HANDLE", pos = Vector(0, 0, 16.589), angle = Angle(-90, 90, 0), size = Vector(0.02, 0.057, 0.039), color = Color(255, 255, 245, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },         ["guard"] = { type = "Model", model = "models/props_docks/dock01_cleat01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "HANDLE", pos = Vector(0, 0, 15.494), angle = Angle(0, 0, 0), size = Vector(0.402, 0.18, 0.115), color = Color(255, 255, 245, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} }     }     SWEP.DWElements = SWEP.WElements end  SWEP.Base = "weapon_zs_basemelee"  SWEP.HoldType = "melee2"  SWEP.DamageType = DMG_DISSOLVE  SWEP.ViewModel = "models/weapons/c_crowbar.mdl" SWEP.WorldModel = "models/weapons/w_crowbar.mdl" SWEP.UseHands = true  SWEP.MeleeDamage = 138 SWEP.MeleeRange = 75 SWEP.MeleeSize = 3.5 SWEP.MeleeKnockBack = 170  SWEP.Primary.Delay = 1.4  SWEP.Tier = 5  SWEP.WalkSpeed = SPEED_SLOWEST  SWEP.SwingRotation = Angle(30, -20, 10) SWEP.SwingOffset = Vector(0, -30, 0) SWEP.SwingTime = 0.85 SWEP.SwingHoldType = "melee"  SWEP.SwingTimeSecondary = 1.5  SWEP.BlockRotation = Angle(0, 20, -60) SWEP.BlockOffset = Vector(-5, 7, 10)  SWEP.Stability = 60 SWEP.BlockReduction = 0.5  SWEP.Cleave = true SWEP.CleaveTaper = 0.65  SWEP.AllowQualityWeapons = true  SWEP.ChargeDamageMulti = 1.5 SWEP.ChargeSpeed = 700 SWEP.ChargeCooldown = 7 SWEP.ChargeComponent = "sword+"  SWEP.StaminaUsage = 0.3  GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.125) GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_STAMINA_USAGE, -0.01)  function SWEP:PlaySwingSound()     self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(50, 60)) end  function SWEP:PlayHitSound()     self:EmitSound("weapons/melee/golf club/golf_hit-0"..math.random(4)..".ogg", math.random(71, 80))     self:EmitSound("ambient/machines/slicer"..math.random(4)..".wav", 75, math.random(70, 78), nil, CHAN_AUTO) end  function SWEP:PlayHitFleshSound()     self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav", 75, math.Rand(86, 90), nil, CHAN_AUTO) end  function SWEP:Initialize()     self.BaseClass.Initialize(self)      self.ChargeSound = CreateSound(self, "ambient/levels/labs/machine_ring_resonance_loop1.wav") end  SWEP.ChargeProjectile = "projectile_moonlight" function SWEP:OnHeavy()     local owner = self:GetOwner()     if not owner:CooldownReady("Moonlight") then return end     owner:AddNewCooldown("Moonlight", self.ChargeCooldown)      if SERVER then         local light = ents.Create(self.ChargeProjectile)         if light:IsValid() then             light:SetPos(owner:GetShootPos())             light:SetAngles(owner:EyeAngles())             light:SetOwner(owner)             light.ProjDamage = self.MeleeDamage * self.ChargeDamageMulti * (owner.ProjectileDamageMul or 1)             light.ProjSource = self             light.Team = owner:Team()             light:Spawn()              local phys = light:GetPhysicsObject()             if phys:IsValid() then                 phys:Wake()                  local angle = owner:GetAimVector():Angle()                 angle:RotateAroundAxis(angle:Forward(), math.Rand(0, 360))                  phys:SetVelocityInstantaneous(angle:Forward() * self.ChargeSpeed)             end         end     end      if self.ChargeEmitSound then         self:ChargeEmitSound()     end end  function SWEP:Think()     if self:GetOwner():CooldownReady("Moonlight") and (self:IsHeavy() or self:IsWinding()) then         local charge = math.Clamp(self:IsWinding() and 0.3 or (1 - (self:GetSwingEnd() - CurTime())), 0, 1)         self.ChargeSound:PlayEx(1, math.min(255, 20 + charge * 50))     else         self.ChargeSound:Stop()     end      BaseClass.Think(self) end  function SWEP:DrawWorldModel()     self.BaseClass.DrawWorldModel(self)      if self.ChargeComponent ~= "sword+" then return end      local timecharge = (1 - (self:GetSwingEnd() - CurTime())) * 3      local rdelta = 1 + timecharge     local tab = self.WElements[self.ChargeComponent]      tab.color = self:IsHeavy() and Color(0, 230, 195, 255) or self.DWElements[self.ChargeComponent].color     tab.size = self:IsHeavy() and Vector(0.243 * rdelta, 0.037, 1.159) or self.DWElements[self.ChargeComponent].size      local owner = self:GetOwner()     if owner:IsValid() and not owner.ShadowMan then          local boneindex = owner:LookupBone("valvebiped.bip01_r_hand")         if boneindex then             local pos, ang = owner:GetBonePosition(boneindex)             if pos and self:IsHeavy() then                 rdelta = math.min(0.5, timecharge/1.5)                  local force = rdelta * 30                 local resist = force * 0.5                  pos = pos + ang:Up() * -1 * math.random(5, 55)                  local curvel = owner:GetVelocity() * 0.5                 local emitter = ParticleEmitter(pos)                 emitter:SetNearClip(24, 48)                  for i=1, math.min(16, math.ceil(FrameTime() * 100)) do                     local particle = emitter:Add("sprites/light_glow02_add", pos)                     particle:SetVelocity(curvel + VectorRand():GetNormalized() * force)                     particle:SetDieTime(rdelta * 2)                     particle:SetStartAlpha(rdelta * 125 + 15)                     particle:SetEndAlpha(0)                     particle:SetStartSize(rdelta * 10 + 4)                     particle:SetEndSize(0)                     particle:SetColor(70 + rdelta * 200, 150 + rdelta * 200, 130 + rdelta * 200)                     particle:SetAirResistance(resist)                 end                 emitter:Finish() emitter = nil collectgarbage("step", 64)             end         end     end end 