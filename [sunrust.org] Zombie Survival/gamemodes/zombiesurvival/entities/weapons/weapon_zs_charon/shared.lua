SWEP.PrintName = "'Charon' Repeating Crossbow" SWEP.Description = "A rapid firing crossbow. Can score headshots if the bolt lands near the top of the head, dealing a bit more damage."  SWEP.Base = "weapon_zs_baseproj"  SWEP.HoldType = "crossbow"  SWEP.ViewModel = "models/weapons/c_crossbow.mdl" SWEP.WorldModel = "models/weapons/w_crossbow.mdl" SWEP.UseHands = true  SWEP.CSMuzzleFlashes = false  SWEP.Primary.Sound = Sound("weapons/crossbow/fire1.wav") SWEP.Primary.Delay = 0.4 SWEP.Primary.Automatic = true SWEP.Primary.Damage = 68  SWEP.Primary.ClipSize = 8 SWEP.Primary.Ammo = "XBowBolt" SWEP.Primary.DefaultClip = 40  SWEP.WalkSpeed = SPEED_SLOW SWEP.Tier = 3  SWEP.ReloadDelay = 2.8 SWEP.Recoil = 2  SWEP.ConeMax = 3.5 SWEP.ConeMin = 3.25  SWEP.NextZoom = 0  SWEP.OverkillFactor = 0.3  SWEP.Primary.ProjVelocity = 1300  GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.03) GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_CLIP_SIZE, 1, 1) GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_PROJECTILE_VELOCITY, 150, 1) GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Styx' Repeating Crossbow", "Increases the rate of fire, clip size, but decreases accuracy, reload speed and damage", function(wept)  wept.Primary.ClipSize = math.floor(wept.Primary.ClipSize * 1.25)  wept.Primary.Delay = wept.Primary.Delay * 0.65  wept.Primary.Damage = wept.Primary.Damage * 0.75  wept.Primary.Projectile = "projectile_arrow_sli"   wept.ConeMax = wept.ConeMax * 1.2  wept.ConeMin = wept.ConeMin * 1.2  wept.ReloadSpeed = wept.ReloadSpeed * 0.85 end).CollectiveName = "Styx"  local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 2, "'Zealot' Bounty Tri-Bow", "Triple loaded crossbow that deals extra damage to zombies near walls, increased damage near the head, and gains bounties from slain zombies.", function(wept)     wept.Primary.ClipSize = 3     wept.Primary.Delay = wept.Primary.Delay * 2.5     wept.Primary.Damage = wept.Primary.Damage * 1.25     wept.ConeMax = wept.ConeMax * 0.2     wept.ConeMin = wept.ConeMin * 0.2     wept.Primary.ProjVelocity = wept.Primary.ProjVelocity * 1.5     wept.Primary.Projectile = "projectile_arrow_bount"      wept.HUD3DBone = "root"     wept.HUD3DPos = Vector(-1.6, -1.4, -6)     wept.HUD3DAng = Angle(0, 0, 0)     wept.HUD3DScale = 0.016      wept.ViewModel = "models/weapons/x_annabelle.mdl"     wept.WorldModel = "models/weapons/w_pistol.mdl"      wept.ReloadSpeed = wept.ReloadSpeed * 1.25     wept.ReloadDelay = 2.8      wept.HoldType = "shotgun"     wept.ViewModelFOV = 67.527638190955      wept.Taper = nil     wept.Radius = nil      wept.VElements = {         ["base+++"] = { type = "Model", model = "models/props_c17/lampshade001a.mdl", bone = "ValveBiped.Gun", rel = "base+", pos = Vector(-7.676, 0, -3), angle = Angle(90, 0, 180), size = Vector(0.3, 0.3, 1), color = Color(35, 35, 35, 255), surpresslightning = false, material = "models/props_canal/canal_bridge_railing_01c", skin = 0, bodygroup = {} },         ["base+++++++++++++"] = { type = "Model", model = "models/props_c17/furniturefridge001a.mdl", bone = "ValveBiped.Gun", rel = "base+", pos = Vector(17.181, 0, -0.559), angle = Angle(100, 0, 0), size = Vector(0.1, 0.129, 0.15), color = Color(85, 62, 70, 255), surpresslightning = false, material = "models/gibs/metalgibs/metal_gibs", skin = 0, bodygroup = {} },         ["base++"] = { type = "Model", model = "models/props_c17/playground_swingset_seat01a.mdl", bone = "ValveBiped.Gun", rel = "base+", pos = Vector(12.909, 0, -3), angle = Angle(8.182, 0, 0), size = Vector(0.5, 0.25, 1.2), color = Color(29, 24, 19, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },         ["base+++++++"] = { type = "Model", model = "models/props_c17/tools_wrench01a.mdl", bone = "ValveBiped.Gun", rel = "base+", pos = Vector(-14, 0, 5), angle = Angle(180, 90, 90), size = Vector(1.2, 0.379, 3), color = Color(185, 185, 185, 255), surpresslightning = false, material = "models/gibs/metalgibs/metal_gibs", skin = 0, bodygroup = {} },         ["base+"] = { type = "Model", model = "models/props_wasteland/controlroom_monitor001b.mdl", bone = "root", rel = "", pos = Vector(1, -1.0, -12.635), angle = Angle(95, 0, 90), size = Vector(1, 0.1, 0.15), color = Color(49, 52, 27, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },         ["base++++++++++++"] = { type = "Model", model = "models/props_c17/canister02a.mdl", bone = "ValveBiped.Gun", rel = "base+", pos = Vector(-7.901, -3, -4.5), angle = Angle(-71.584, 19.909, 40.57), size = Vector(0.029, 0.029, 0.239), color = Color(40, 40, 40, 255), surpresslightning = false, material = "models/props_c17/metalladder003", skin = 0, bodygroup = {} },         ["base+++++++++++"] = { type = "Model", model = "models/props_c17/canister02a.mdl", bone = "ValveBiped.Gun", rel = "base+", pos = Vector(-8, 3, -4.5), angle = Angle(-71.948, 19.87, 0), size = Vector(0.029, 0.029, 0.239), color = Color(40, 40, 40, 255), surpresslightning = false, material = "models/props_c17/metalladder003", skin = 0, bodygroup = {} },         ["base++++"] = { type = "Model", model = "models/props_c17/lampshade001a.mdl", bone = "ValveBiped.Gun", rel = "base+", pos = Vector(-7.676, -1.5, 0), angle = Angle(90, 0, 180), size = Vector(0.3, 0.3, 1), color = Color(35, 35, 35, 255), surpresslightning = false, material = "models/props_canal/canal_bridge_railing_01c", skin = 0, bodygroup = {} },         ["base++++++"] = { type = "Model", model = "models/props_c17/canister_propane01a.mdl", bone = "ValveBiped.Gun", rel = "base+", pos = Vector(-6.676, 0, -1), angle = Angle(90, 0, 180), size = Vector(0.2, 0.2, 0.1), color = Color(49, 44, 32, 255), surpresslightning = false, material = "rubber", skin = 0, bodygroup = {} },         ["base++++++++"] = { type = "Model", model = "models/props_c17/tools_wrench01a.mdl", bone = "ValveBiped.Gun", rel = "base+", pos = Vector(-14, -4, -5), angle = Angle(45.583, 90, 90), size = Vector(1.2, 0.379, 3), color = Color(185, 185, 185, 255), surpresslightning = false, material = "models/gibs/metalgibs/metal_gibs", skin = 0, bodygroup = {} },         ["base"] = { type = "Model", model = "models/props_wasteland/prison_padlock001a.mdl", bone = "ValveBiped.Gun", rel = "base+", pos = Vector(3.635, 0.518, 1.597), angle = Angle(0, 90, -66.624), size = Vector(0.8, 0.6, 0.6), color = Color(49, 34, 19, 255), surpresslightning = false, material = "models/gibs/metalgibs/metal_gibs", skin = 3, bodygroup = {} },         ["base+++++++++"] = { type = "Model", model = "models/props_c17/tools_wrench01a.mdl", bone = "ValveBiped.Gun", rel = "base+", pos = Vector(-14, 4, -5), angle = Angle(-45.584, 90, 90), size = Vector(1.2, 0.379, 3), color = Color(185, 185, 185, 255), surpresslightning = false, material = "models/gibs/metalgibs/metal_gibs", skin = 0, bodygroup = {} },         ["base++++++++++"] = { type = "Model", model = "models/props_c17/canister02a.mdl", bone = "ValveBiped.Gun", rel = "base+", pos = Vector(-8.5, 0.2, 4), angle = Angle(0, 90, 120.402), size = Vector(0.029, 0.029, 0.239), color = Color(40, 40, 40, 255), surpresslightning = false, material = "models/props_c17/metalladder003", skin = 0, bodygroup = {} },         ["base+++++"] = { type = "Model", model = "models/props_c17/lampshade001a.mdl", bone = "ValveBiped.Gun", rel = "base+", pos = Vector(-7.676, 1.5, 0), angle = Angle(90, 0, 180), size = Vector(0.3, 0.3, 1), color = Color(35, 35, 35, 255), surpresslightning = false, material = "models/props_canal/canal_bridge_railing_01c", skin = 0, bodygroup = {} }     }      wept.WElements = {         ["base+++"] = { type = "Model", model = "models/props_c17/lampshade001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base+", pos = Vector(-7.676, 0, -3), angle = Angle(90, 0, 180), size = Vector(0.3, 0.3, 1), color = Color(35, 35, 35, 255), surpresslightning = false, material = "models/props_canal/canal_bridge_railing_01c", skin = 0, bodygroup = {} },         ["base+++++++++++++"] = { type = "Model", model = "models/props_c17/furniturefridge001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base+", pos = Vector(17.181, 0, -0.559), angle = Angle(100, 0, 0), size = Vector(0.1, 0.129, 0.15), color = Color(85, 62, 70, 255), surpresslightning = false, material = "models/gibs/metalgibs/metal_gibs", skin = 0, bodygroup = {} },         ["base++"] = { type = "Model", model = "models/props_c17/playground_swingset_seat01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base+", pos = Vector(12.909, 0, -3), angle = Angle(8.182, 0, 0), size = Vector(0.5, 0.25, 1.2), color = Color(29, 24, 19, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },         ["base+++++++"] = { type = "Model", model = "models/props_c17/tools_wrench01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base+", pos = Vector(-14, 0, 5), angle = Angle(180, 90, 90), size = Vector(1.2, 0.379, 3), color = Color(125, 125, 65, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },         ["base+"] = { type = "Model", model = "models/props_wasteland/controlroom_monitor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(16.104, 0, -6.792), angle = Angle(10.519, 180, 0), size = Vector(1, 0.1, 0.15), color = Color(49, 52, 27, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },         ["base+++++"] = { type = "Model", model = "models/props_c17/lampshade001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base+", pos = Vector(-7.676, 1.5, 0), angle = Angle(90, 0, 180), size = Vector(0.3, 0.3, 1), color = Color(35, 35, 35, 255), surpresslightning = false, material = "models/props_canal/canal_bridge_railing_01c", skin = 0, bodygroup = {} },         ["base++++++++"] = { type = "Model", model = "models/props_c17/tools_wrench01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base+", pos = Vector(-14, -4, -5), angle = Angle(45.583, 90, 90), size = Vector(1.2, 0.379, 3), color = Color(125, 125, 65, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },         ["base++++"] = { type = "Model", model = "models/props_c17/lampshade001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base+", pos = Vector(-7.676, -1.5, 0), angle = Angle(90, 0, 180), size = Vector(0.3, 0.3, 1), color = Color(35, 35, 35, 255), surpresslightning = false, material = "models/props_canal/canal_bridge_railing_01c", skin = 0, bodygroup = {} },         ["base++++++"] = { type = "Model", model = "models/props_c17/canister_propane01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base+", pos = Vector(-6.676, 0, -1), angle = Angle(90, 0, 180), size = Vector(0.2, 0.2, 0.1), color = Color(49, 44, 32, 255), surpresslightning = false, material = "rubber", skin = 0, bodygroup = {} },         ["base+++++++++"] = { type = "Model", model = "models/props_c17/tools_wrench01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base+", pos = Vector(-14, 4, -5), angle = Angle(-45.584, 90, 90), size = Vector(1.2, 0.379, 3), color = Color(125, 125, 65, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },         ["base+++++++++++"] = { type = "Model", model = "models/props_c17/canister02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base+", pos = Vector(-8, 3, -4.5), angle = Angle(-71.948, 19.87, 0), size = Vector(0.029, 0.029, 0.239), color = Color(40, 40, 40, 255), surpresslightning = false, material = "models/props_c17/metalladder003", skin = 0, bodygroup = {} },         ["base"] = { type = "Model", model = "models/props_wasteland/prison_padlock001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base+", pos = Vector(3.635, 0.518, 1.597), angle = Angle(0, 90, -66.624), size = Vector(0.8, 0.6, 0.6), color = Color(49, 34, 19, 255), surpresslightning = false, material = "models/gibs/metalgibs/metal_gibs", skin = 3, bodygroup = {} },         ["base++++++++++"] = { type = "Model", model = "models/props_c17/canister02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base+", pos = Vector(-8.5, 0.2, 4), angle = Angle(0, 90, 120.402), size = Vector(0.029, 0.029, 0.239), color = Color(40, 40, 40, 255), surpresslightning = false, material = "models/props_c17/metalladder003", skin = 0, bodygroup = {} },         ["base++++++++++++"] = { type = "Model", model = "models/props_c17/canister02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base+", pos = Vector(-7.901, -3, -4.5), angle = Angle(-71.584, 19.909, 40.57), size = Vector(0.029, 0.029, 0.239), color = Color(40, 40, 40, 255), surpresslightning = false, material = "models/props_c17/metalladder003", skin = 0, bodygroup = {} }     }      wept.ViewModelBoneMods = {  ["ValveBiped.Bip01_L_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 3, 0) }  }   function wept:SendWeaponAnimation()  self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)  self:GetOwner():GetViewModel():SetPlaybackRate(self.FireAnimSpeed)   if IsFirstTimePredicted() then  timer.Simple(0.3, function()  if IsValid(self) then  self:SendWeaponAnim(ACT_SHOTGUN_PUMP)  self:GetOwner():GetViewModel():SetPlaybackRate(self.FireAnimSpeed * 0.45)   if CLIENT and self:GetOwner() == MySelf then  self:EmitSound("weapons/zs_1887/1887_lever.wav", 65, 60, 0.5, CHAN_AUTO)  end  end  end)  end  end      wept.EmitFireSound = function(self)         self:EmitSound("weapons/galil/galil-1.wav", 75, math.random(210, 225), 0.6)         self:EmitSound("weapons/crossbow/fire1.wav", 75, math.random(71, 75), 1, CHAN_WEAPON+20)     end      function wept:SendReloadAnimation()     end      wept.Zealot = true end) branch.CollectiveName = "Zealot" branch.NewNames = {"Blessed", "Holy", "Saintly"} GAMEMODE:AttachWeaponModifierToBranch(branch, WEAPON_MODIFIER_FIRE_DELAY, -0.035) GAMEMODE:AttachWeaponModifierToBranch(branch, WEAPON_MODIFIER_RELOAD_SPEED, 0.06, 1) GAMEMODE:AttachWeaponModifierToBranch(branch, WEAPON_MODIFIER_PROJECTILE_VELOCITY, 150, 1)  function SWEP:PrimaryAttack()  if not self:CanPrimaryAttack() then return end  self:SetNextPrimaryFire(CurTime() + self:GetFireDelay())   self:EmitFireSound()  self:TakeAmmo()  self:ShootBullets(self.Primary.Damage, self.Primary.NumShots, self:GetCone())  self.IdleAnimation = CurTime() + self:SequenceDuration()   self:SetShootTime(CurTime()) end  function SWEP:EmitReloadSound()  if IsFirstTimePredicted() then  self:EmitSound("weapons/crossbow/bolt_load"..math.random(2)..".wav", 50, 100, 1, CHAN_AUTO)  self:EmitSound("weapons/crossbow/reload1.wav")  end end  function SWEP:SendWeaponAnimation()  self:SendWeaponAnim(ACT_VM_FIDGET)  self:GetOwner():GetViewModel():SetPlaybackRate(self.FireAnimSpeed)  timer.Simple(self.Primary.Delay/3.5, function()  if IsValid(self) then  self:SendWeaponAnim(ACT_VM_IDLE)  self:GetOwner():GetViewModel():SetPlaybackRate(6)  end  end) end  function SWEP:SendReloadAnimation() end  function SWEP:ProcessReloadEndTime()  local reloadspeed = self.ReloadSpeed * self:GetReloadSpeedMultiplier()  self:SetReloadFinish(CurTime() + self.ReloadDelay / reloadspeed) end  function SWEP:SetShootTime(time)  self:SetDTFloat(8, time) end  function SWEP:GetShootTime()  return self:GetDTFloat(8) end  util.PrecacheSound("weapons/crossbow/bolt_load1.wav") util.PrecacheSound("weapons/crossbow/bolt_load2.wav") util.PrecacheSound("weapons/sniper/sniper_zoomin.wav") util.PrecacheSound("weapons/sniper/sniper_zoomout.wav") 