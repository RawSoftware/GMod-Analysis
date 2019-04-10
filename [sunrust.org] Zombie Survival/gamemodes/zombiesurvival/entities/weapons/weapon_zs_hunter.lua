AddCSLuaFile()  SWEP.PrintName = "'Hunter' Rifle" SWEP.Description = "Fires special large caliber rounds. The reloading time is slow but it packs a powerful punch." SWEP.Slot = 3 SWEP.SlotPos = 0  if CLIENT then  SWEP.ViewModelFlip = false  SWEP.ViewModelFOV = 60   SWEP.HUD3DBone = "v_weapon.awm_parent"  SWEP.HUD3DPos = Vector(-1.25, -3.5, -16)  SWEP.HUD3DAng = Angle(0, 0, 0)  SWEP.HUD3DScale = 0.02 end  SWEP.Base = "weapon_zs_base"  SWEP.HoldType = "ar2"  SWEP.ViewModel = "models/weapons/cstrike/c_snip_awp.mdl" SWEP.WorldModel = "models/weapons/w_snip_awp.mdl" SWEP.UseHands = true  SWEP.ReloadSound = Sound("weapons/awp/awp_clipout.wav") SWEP.Primary.Sound = Sound("weapons/awp/awp1.wav") SWEP.Primary.Damage = 105 SWEP.Primary.NumShots = 1 SWEP.Primary.Delay = 1.75 SWEP.ReloadDelay = SWEP.Primary.Delay  SWEP.Primary.ClipSize = 5 SWEP.Primary.Automatic = true SWEP.Primary.Ammo = "357" SWEP.Primary.DefaultClip = 15  SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN  SWEP.ConeMax = 5.75 SWEP.ConeMin = 0  SWEP.IronSightsPos = Vector(5.015, -8, 2.52) SWEP.IronSightsAng = Vector(0, 0, 0)  SWEP.WalkSpeed = SPEED_SLOWER  SWEP.Tier = 3  SWEP.TracerName = "AR2Tracer"  SWEP.OverkillFactor = 0.2  SWEP.FireAnimSpeed = 0.75  SWEP.ReloadSpeed = 0.9  SWEP.FireModes = 2 SWEP.FireModeNames = {"Full-Zoom", "Half-Zoom"} SWEP.FireModeNames3D = {"FULL", "HALF"}  GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_RELOAD_SPEED, 0.09, 1) GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_CLIP_SIZE, 1) GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.06) GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Eruptor' Explosive Rifle", "Uses twice as much ammo, overkill damage is dealt as an explosion, loses damage resist penetration. Deals slightly more damage.", function(wept)  wept.Primary.ClipSize = 10     wept.Primary.Damage = wept.Primary.Damage * 1.1  wept.RequiredClip = 2  wept.Taper = 0.94  wept.Radius = 72     wept.ResistanceAmmoAs = "pistol"   wept.OverkillFactor = nil   wept.OnZombieKilled = function(self, zombie, total, dmginfo)  local killer = self:GetOwner()  local minushp = math.min(400, -zombie:Health())  if killer:IsValid() and minushp > 10 then  local pos = zombie:GetPos()   timer.Simple(0.03, function()  util.BlastDamagePlayer(killer:GetActiveWeapon(), killer, pos, self.Radius, minushp, DMG_ALWAYSGIB, self.Taper)  end)   local effectdata = EffectData()  effectdata:SetOrigin(pos)  util.Effect("explosion_redsun", effectdata, true, true)  end  end end).CollectiveName = "Explosive" local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 2, "'Thrasher' Birdshot Rifle", "Fires a spread of less accurate shots that deal more total damage, retains some damage resist penetration", function(wept)  wept.Primary.Damage = wept.Primary.Damage / 5  wept.Primary.NumShots = 6  wept.ConeMax = 4.5     wept.ConeMin = 2.5     wept.ResistanceAmmoAs = "pistol"     wept.OverkillFactor = nil     wept.BulletCallback = nil     wept.AmmoTrinketOverride = 1.5 end) branch.CollectiveName = "Birdshot" branch.Colors = {Color(160, 170, 220), Color(110, 120, 170), Color(90, 100, 150), Color(70, 80, 130)}  function SWEP:EmitFireSound()  self:EmitSound("weapons/awp/awp1.wav", 80, math.random(124, 134), 1, CHAN_WEAPON) end  function SWEP:IsScoped()  return self:GetIronsights() and self.fIronTime and self.fIronTime + 0.25 <= CurTime() end  function SWEP.BulletCallback(attacker, tr, dmginfo)  local effectdata = EffectData()  effectdata:SetOrigin(tr.HitPos)  effectdata:SetNormal(tr.HitNormal)  util.Effect("hit_hunter", effectdata) end  function SWEP:FireModeChanged(fm)     fm = tonumber(fm)     self.IronsightsMultiplier = fm == 1 and 0.55 or 0.25 end  function SWEP:PlayFireModeSwitchSound(fm)     fm = tonumber(fm)     if CLIENT then         if fm == 1 then             surface.PlaySound("weapons/zoom/zoom_soundtest.wav")         else             surface.PlaySound("weapons/zoom/zoom_soundtest2.wav")         end     end end  if CLIENT then  SWEP.IronsightsMultiplier = 0.25   function SWEP:GetViewModelPosition(pos, ang)  if GAMEMODE.DisableScopes then return end   if self:IsScoped() then  return pos + ang:Up() * 256, ang  end   return self.BaseClass.GetViewModelPosition(self, pos, ang)  end   function SWEP:DrawHUDBackground()  if GAMEMODE.DisableScopes then return end   if self:IsScoped() then  self:DrawRegularScope()  end  end end 