SWEP.PrintName = "'Impaler' Crossbow" SWEP.Description = "This ancient weapon can easily skewer groups of zombies."  SWEP.Base = "weapon_zs_baseproj" local BaseClass = baseclass.Get("weapon_zs_baseproj")  SWEP.HoldType = "crossbow"  SWEP.ViewModel = "models/weapons/c_crossbow.mdl" SWEP.WorldModel = "models/weapons/w_crossbow.mdl" SWEP.UseHands = true  SWEP.CSMuzzleFlashes = false  SWEP.Primary.Sound = Sound("weapons/crossbow/fire1.wav") SWEP.Primary.Delay = 1.0 SWEP.Primary.Automatic = true SWEP.Primary.Damage = 98  SWEP.Primary.ClipSize = 1 SWEP.Primary.Ammo = "XBowBolt" SWEP.Primary.DefaultClip = 15  SWEP.SecondaryDelay = 0.25  SWEP.WalkSpeed = SPEED_SLOWER  SWEP.Tier = 5  SWEP.ConeMax = 2.5 SWEP.ConeMin = 1.2  SWEP.NextZoom = 0  SWEP.ReloadSpeed = 0.75    SWEP.AmmoTrinketOverride = 0.33  SWEP.Pierces = 99  SWEP.CorrosionMul = 1  GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_RELOAD_SPEED, 0.04, 1) local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Crucifier' Acid Crossbow", "Shoots a piercing bolt that deals less piercing damage but explodes into acid where it lands.", function(wept)  wept.Primary.Damage = wept.Primary.Damage * 0.7  if SERVER then  wept.EntModify = function(self, ent)  ent:SetDTBool(0, true)             ent.CorrosionMul = self.CorrosionMul  end  end end) branch.Colors = {Color(210, 250, 90), Color(160, 200, 40), Color(145, 185, 25), Color(100, 150, 10)} branch.CollectiveName = "Crucifier" GAMEMODE:AttachWeaponModifierToBranch(branch, WEAPON_MODIFIER_RELOAD_SPEED, 0.03, 1) GAMEMODE:AttachWeaponModifierToBranch(branch, WEAPON_MODIFIER_ACID_MUL, 0.07, 1)  branch = GAMEMODE:AddNewRemantleBranch(SWEP, 2, "'Avelyn' Multi Crossbow", "Bursts 3 bolts that do not pierce, but deal high damage and can headshot for a little extra damage.", function(wept)  wept.HUD3DBone = "v_weapon.Glock_Slide"  wept.HUD3DPos = Vector(1, 0, -1)  wept.HUD3DAng = Angle(90, 0, -10)   wept.ViewModel = "models/weapons/cstrike/c_pist_glock18.mdl"  wept.WorldModel = "models/weapons/w_pistol.mdl"   wept.ShowViewModel = false  wept.ShowWorldModel = false   wept.ViewModelFOV = 49  wept.ViewModelFlip = false   wept.Primary.BurstShots = 3  wept.Primary.Delay = 0.8  wept.Primary.ClipSize = 3  wept.Primary.Damage = wept.Primary.Damage * 1.05  wept.ReloadSpeed = wept.ReloadSpeed * 0.6   wept.Slot = 3  wept.SlotPos = 0      wept.Pierces = nil   wept.Primary.Projectile = "projectile_arrow_base"  wept.Primary.ProjVelocity = 1200      wept.AmmoTrinketOverride = 1      wept.FireModes = 2     wept.FireModeNames = {"3-Bolt Burst", "Single Bolt"}     wept.FireModeNames3D = {"BRST", "SNGL"}   wept.VElements = {  ["t2_xbow+++++++++++"] = { type = "Model", model = "models/props_c17/lampfixture01a.mdl", bone = "v_weapon.Glock_Parent", rel = "t2_xbow", pos = Vector(3, 0, -2), angle = Angle(0, 0, 0), size = Vector(0.4, 0.15, 0.15), color = Color(156, 103, 92, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },  ["t2_xbow++"] = { type = "Model", model = "models/weapons/w_pist_p228.mdl", bone = "v_weapon.Glock_Parent", rel = "t2_xbow", pos = Vector(-0.201, 0, -5.7), angle = Angle(0, 180, 0), size = Vector(0.699, 0.86, 0.899), color = Color(72, 37, 6, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },  ["t2_xbow+++++++"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025c.mdl", bone = "v_weapon.Glock_Parent", rel = "t2_xbow", pos = Vector(-10, 0, -1), angle = Angle(0, 0, 0), size = Vector(0.079, 0.189, 0.039), color = Color(255, 178, 148, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} },  ["t2_xbow+"] = { type = "Model", model = "models/props_wasteland/prison_flourescentlight002b.mdl", bone = "v_weapon.Glock_Parent", rel = "t2_xbow", pos = Vector(-6.753, 0, -0.301), angle = Angle(90, 90, 0), size = Vector(0.449, 0.43, 0.25), color = Color(137, 89, 67, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} },  ["t2_xbow+++++"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025c.mdl", bone = "v_weapon.Glock_Parent", rel = "t2_xbow", pos = Vector(-6, 0, -1.5), angle = Angle(0, 0, 0), size = Vector(0.079, 0.159, 0.039), color = Color(255, 178, 148, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} },  ["t2_xbow++++++++++"] = { type = "Model", model = "models/props_pipes/pipe02_straight01_long.mdl", bone = "v_weapon.Glock_Parent", rel = "t2_xbow", pos = Vector(-14, 0, -0.5), angle = Angle(0, 0, 0), size = Vector(0.009, 0.38, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder003", skin = 0, bodygroup = {} },  ["t2_xbow+++"] = { type = "Model", model = "models/props_c17/lampfixture01a.mdl", bone = "v_weapon.Glock_Parent", rel = "t2_xbow", pos = Vector(-6, 0, -4), angle = Angle(-90, 0, 0), size = Vector(0.2, 0.1, 0.2), color = Color(156, 103, 92, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },  ["t2_xbow+++++++++"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025c.mdl", bone = "v_weapon.Glock_Parent", rel = "t2_xbow", pos = Vector(-14, 0, -0.5), angle = Angle(0, 0, 0), size = Vector(0.079, 0.209, 0.039), color = Color(255, 178, 148, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} },  ["t2_xbow++++"] = { type = "Model", model = "models/props_c17/metalladder001.mdl", bone = "v_weapon.Glock_Parent", rel = "t2_xbow", pos = Vector(-19, 0, -1.5), angle = Angle(0, 90, 92), size = Vector(0.2, 0.05, 0.119), color = Color(105, 77, 59, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} },  ["t2_xbow++++++++"] = { type = "Model", model = "models/props_pipes/pipe02_straight01_long.mdl", bone = "v_weapon.Glock_Parent", rel = "t2_xbow", pos = Vector(-10, 0, -1), angle = Angle(0, 0, 0), size = Vector(0.009, 0.35, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder003", skin = 0, bodygroup = {} },  ["t2_xbow"] = { type = "Model", model = "models/props_wasteland/laundry_cart001.mdl", bone = "v_weapon.Glock_Parent", rel = "", pos = Vector(2.5, -3.201, 0.649), angle = Angle(-3, -17, -79), size = Vector(0.059, 0.012, 0.025), color = Color(198, 150, 115, 255), surpresslightning = false, material = "models/weapons/v_crowbar/head_uvw", skin = 0, bodygroup = {} },  ["t2_xbow++++++"] = { type = "Model", model = "models/props_pipes/pipe02_straight01_long.mdl", bone = "v_weapon.Glock_Parent", rel = "t2_xbow", pos = Vector(-6.2, 0, -1.4), angle = Angle(0, 0, 0), size = Vector(0.009, 0.3, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder003", skin = 0, bodygroup = {} }  }   wept.WElements = {  ["t2_xbow+++++++++++"] = { type = "Model", model = "models/props_c17/lampfixture01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "t2_xbow", pos = Vector(3, 0, -2), angle = Angle(0, 0, 0), size = Vector(0.4, 0.15, 0.15), color = Color(156, 103, 92, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },  ["t2_xbow++"] = { type = "Model", model = "models/weapons/w_pist_p228.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "t2_xbow", pos = Vector(-0.201, 0, -5.7), angle = Angle(0, 180, 0), size = Vector(0.699, 0.86, 0.899), color = Color(72, 37, 6, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },  ["t2_xbow+++++++"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "t2_xbow", pos = Vector(-10, 0, -1), angle = Angle(0, 0, 0), size = Vector(0.079, 0.189, 0.039), color = Color(255, 178, 148, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} },  ["t2_xbow+"] = { type = "Model", model = "models/props_wasteland/prison_flourescentlight002b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "t2_xbow", pos = Vector(-6.753, 0, -0.301), angle = Angle(90, 90, 0), size = Vector(0.449, 0.43, 0.25), color = Color(137, 89, 67, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} },  ["t2_xbow+++++"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "t2_xbow", pos = Vector(-6, 0, -1.5), angle = Angle(0, 0, 0), size = Vector(0.079, 0.159, 0.039), color = Color(255, 178, 148, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} },  ["t2_xbow+++"] = { type = "Model", model = "models/props_c17/lampfixture01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "t2_xbow", pos = Vector(-6, 0, -4), angle = Angle(-90, 0, 0), size = Vector(0.2, 0.1, 0.2), color = Color(156, 103, 92, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },  ["t2_xbow++++++"] = { type = "Model", model = "models/props_pipes/pipe02_straight01_long.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "t2_xbow", pos = Vector(-5.5, 0, -1.4), angle = Angle(0, 1.169, 0), size = Vector(0.009, 0.28, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder003", skin = 0, bodygroup = {} },  ["t2_xbow++++"] = { type = "Model", model = "models/props_c17/metalladder001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "t2_xbow", pos = Vector(-19, 0, -1.5), angle = Angle(0, 90, 92), size = Vector(0.2, 0.05, 0.119), color = Color(105, 77, 59, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} },  ["t2_xbow"] = { type = "Model", model = "models/props_wasteland/laundry_cart001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.199, 0, -5.5), angle = Angle(0, 180, 180), size = Vector(0.059, 0.012, 0.025), color = Color(198, 150, 115, 255), surpresslightning = false, material = "models/weapons/v_crowbar/head_uvw", skin = 0, bodygroup = {} },  ["t2_xbow++++++++++"] = { type = "Model", model = "models/props_pipes/pipe02_straight01_long.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "t2_xbow", pos = Vector(-14, 0, -0.5), angle = Angle(0, 1.169, 0), size = Vector(0.009, 0.379, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder003", skin = 0, bodygroup = {} },  ["t2_xbow++++++++"] = { type = "Model", model = "models/props_pipes/pipe02_straight01_long.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "t2_xbow", pos = Vector(-10, 0, -1), angle = Angle(0, 1.169, 0), size = Vector(0.009, 0.34, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder003", skin = 0, bodygroup = {} },  ["t2_xbow+++++++++"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "t2_xbow", pos = Vector(-14, 0, -0.5), angle = Angle(0, 0, 0), size = Vector(0.079, 0.209, 0.039), color = Color(255, 178, 148, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} }  }   function wept:PrimaryAttack()  if not self:CanPrimaryAttack() then return end  local fm = self:GetFireMode()   self:SetNextPrimaryFire(CurTime() + self:GetFireDelay(fm == 1 and 2.55 or 1))  self:EmitFireSound()   if fm == 1 then  self:TakeAmmo()  self:ShootBullets(self.Primary.Damage, self.Primary.NumShots, self:GetCone())  else  self:SetNextShot(CurTime())  self:SetShotsLeft(self.Primary.BurstShots)  end   self.IdleAnimation = CurTime() + self:SequenceDuration()  end   function wept:Think()  BaseClass.Think(self)   local shotsleft = self:GetShotsLeft()  if shotsleft > 0 and CurTime() >= self:GetNextShot() then  self:SetShotsLeft(shotsleft - 1)  self:SetNextShot(CurTime() + self:GetFireDelay(6))   if self:Clip1() > 0 and self:GetReloadFinish() == 0 then  self:EmitFireSound()  self:TakeAmmo()  self:ShootBullets(self.Primary.Damage, self.Primary.NumShots, self:GetCone())   self.IdleAnimation = CurTime() + self:SequenceDuration()  else  self:SetShotsLeft(0)  end  end  end      function wept:Holster()         if self:GetShotsLeft() > 0 then             return false         end          return BaseClass.Holster(self)     end      function wept:CanReload()         if self:GetShotsLeft() > 0 then             return false         end          return BaseClass.CanReload(self)     end   function wept:SetNextShot(nextshot)  self:SetDTFloat(5, nextshot)  end   function wept:GetNextShot()  return self:GetDTFloat(5)  end   function wept:SetShotsLeft(shotsleft)  self:SetDTInt(1, shotsleft)  end   function wept:GetShotsLeft()  return self:GetDTInt(1)  end   function wept:SendReloadAnimation()  self:SendWeaponAnim(ACT_VM_DRAW)  end   function wept:EmitReloadSound()  if IsFirstTimePredicted() then  self:EmitSound("weapons/crossbow/reload1.wav", 70, 110)  end  end   function wept:EmitReloadFinishSound()  if IsFirstTimePredicted() then  self:EmitSound("weapons/galil/galil_boltpull.wav", 70, 110)  end  end   function wept:EmitFireSound()  self:EmitSound("weapons/crossbow/fire1.wav", 70, 120, 0.7)  self:EmitSound("weapons/crossbow/bolt_skewer1.wav", 70, 193, 0.7, CHAN_AUTO)  end   wept.PlayFireModeSwitchSound = function(self, fm)      fm = tonumber(fm)      if CLIENT then          if fm == 1 then              surface.PlaySound("weapons/crossbow/hit1.wav")          else           for i=0, 2 do               timer.Simple(i * 0.1, function() surface.PlaySound("weapons/crossbow/hit1.wav") end)              end          end      end  end end) branch.CollectiveName = "Avelyn" branch.Killicon = "weapon_zs_avelyn" branch.Colors = {Color(210, 200, 190), Color(160, 150, 140), Color(145, 125, 115), Color(100, 80, 70)}  function SWEP:EmitReloadSound()  if IsFirstTimePredicted() then  self:EmitSound("weapons/crossbow/bolt_load"..math.random(2)..".wav", 65, 100, 0.9, CHAN_WEAPON + 21)  self:EmitSound("weapons/crossbow/reload1.wav", 65, 100, 0.9, CHAN_WEAPON + 22)  end end  function SWEP:IsScoped()  return self:GetIronsights() and self.fIronTime and self.fIronTime + 0.25 <= CurTime() end  util.PrecacheSound("weapons/crossbow/bolt_load1.wav") util.PrecacheSound("weapons/crossbow/bolt_load2.wav") 