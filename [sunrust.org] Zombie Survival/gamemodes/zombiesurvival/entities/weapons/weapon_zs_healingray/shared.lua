SWEP.PrintName = "'Rejuvenator' Healing Ray" SWEP.Description = "Locks on to humans and heals them to full, discharging medical ammo along a ray."  SWEP.Base = "weapon_zs_base"  SWEP.HoldType = "physgun"  SWEP.ViewModel = "models/weapons/c_physcannon.mdl" SWEP.WorldModel = "models/weapons/w_physics.mdl" SWEP.ShowViewModel = false SWEP.ShowWorldModel = false SWEP.UseHands = true  SWEP.Primary.Delay = 0.1  SWEP.Primary.ClipSize = 30 SWEP.Primary.Automatic = true SWEP.Primary.Ammo = "Battery" GAMEMODE:SetupDefaultClip(SWEP.Primary)  SWEP.ConeMax = 0 SWEP.ConeMin = 0  SWEP.Tier = 4 SWEP.MaxStock = 3  SWEP.HealRange = 300 SWEP.Heal = 3.5 SWEP.HasMedicalAura = true  SWEP.WalkSpeed = SPEED_SLOWER SWEP.FireAnimSpeed = 0.24  SWEP.HideStat = {     Damage = true,     ResistanceAmmoAs = true,     ConeMax = true,     ConeMin = true }  local math_min = math.min local math_Round = math.Round local table_sort = table.sort local util_Effect = util.Effect local util_TraceLine = util.TraceLine local WorldVisibleTrace = {mask = MASK_SOLID_BRUSHONLY} local function WorldVisible(posa, posb)    WorldVisibleTrace.start = posa  WorldVisibleTrace.endpos = posb  return not util_TraceLine(WorldVisibleTrace).Hit end  GAMEMODE:SetPrimaryWeaponModifier(SWEP, WEAPON_MODIFIER_HEALRANGE, 100, 1) GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_HEALING, 0.2, 1) GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Lifebreather' Multi Ray", "Heals multiple targets in short bursts", function(wept)  wept.StopHealing = function(self)  self:SetNextPrimaryFire(CurTime() + 15)  self:EmitSound("items/medshotno1.wav", 75, 60)  self.ChargeSound:Stop()  end   wept.Heal = wept.Heal * 5.5/3.5  wept.Think = function(self)  self.BaseClass.Think(self)  end   wept.PrimaryAttack = function(self)  if not self:CanPrimaryAttack() then return end   local owner = self:GetOwner()  local pos = owner:GetPos()  local radius = wept.HealRange  local use_sound = false  local counter = 0  local team_players = team.GetPlayers(TEAM_HUMAN)      table_sort(team_players, function(a, b)  return owner:WorldSpaceCenter():DistToSqr(a:WorldSpaceCenter()) < owner:WorldSpaceCenter():DistToSqr(b:WorldSpaceCenter())  end)   for _, test in pairs(team_players) do  if owner ~= test then  local nearest = test:NearestPoint(pos)  if test:IsValidLivingPlayer() and test:IsPlayer() and WorldVisible(pos, nearest) and gamemode.Call("PlayerCanBeHealed", test) then  local friends_only  local zs_friends  if CLIENT then  friends_only = GAMEMODE.FriendOnlyHeal  zs_friends = GAMEMODE.ZSFriends[test:SteamID()]  end  if SERVER then  friends_only = owner:GetInfo("zs_friendonlyheal") ~= "0"  zs_friends = owner.ZSFriends[test]  end  if owner:WorldSpaceCenter():DistToSqr(test:WorldSpaceCenter()) < (radius ^ 2) and self:GetCombinedPrimaryAmmo() > 0 and (friends_only and zs_friends or not friends_only) then  counter = counter + 1  owner:HealPlayer(test, math_min(self:GetCombinedPrimaryAmmo(), math_Round(wept.Heal / counter, 2)))   if counter <= 3 then  self:TakeAmmo()  end  self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)   use_sound = true   local effectdata = EffectData()  effectdata:SetOrigin(test:WorldSpaceCenter())  effectdata:SetFlags(3)  effectdata:SetEntity(self)  effectdata:SetAttachment(1)  util_Effect("tracer_healray", effectdata)   if counter > 4 then  break  end  end  elseif test:IsValid() then  self:StopHealing()  end  end  end   self:SetNextPrimaryFire(CurTime() + 2)   if use_sound then  self:EmitSound("items/medshot4.wav", 75, 80)  end  end   wept.CanPrimaryAttack = function(self)  if self:GetPrimaryAmmoCount() <= 0 then  return false  end   if self:GetOwner():IsHolding() or self:GetOwner():GetBarricadeGhosting() then return false end   return self:GetNextPrimaryFire() <= CurTime()  end   wept.VElements = {  ["egon_base+++++++++++"] = { type = "Model", model = "models/props_wasteland/laundry_washer001a.mdl", bone = "Base", rel = "egon_base", pos = Vector(1, 3, 4), angle = Angle(140, -90, 0), size = Vector(0.017, 0.017, 0.129), color = Color(196, 234, 244, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },  ["egon_base++++++"] = { type = "Model", model = "models/props_phx/misc/iron_beam2.mdl", bone = "Base", rel = "egon_base", pos = Vector(1.5, -4, -2), angle = Angle(-17.532, 90, 0), size = Vector(0.119, 0.119, 0.119), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_stunstick/v_stunstick_diffuse", skin = 0, bodygroup = {} },  ["egon_base+"] = { type = "Model", model = "models/props_phx/construct/metal_wire_angle360x2.mdl", bone = "Base", rel = "egon_base", pos = Vector(10, 0.2, 0), angle = Angle(90, 0, 0), size = Vector(0.07, 0.07, 0.17), color = Color(89, 100, 99, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["egon_base++++++++++"] = { type = "Model", model = "models/props_wasteland/laundry_washer001a.mdl", bone = "Base", rel = "egon_base", pos = Vector(1, 3, 4), angle = Angle(140, -90, 0), size = Vector(0.018, 0.018, 0.1), color = Color(139,0,0), surpresslightning = false, material = "phoenix_storms/camera", skin = 1, bodygroup = {} },  ["egon_base+++"] = { type = "Model", model = "models/props_c17/factorymachine01.mdl", bone = "Base", rel = "egon_base", pos = Vector(7, 0, -3.1), angle = Angle(180, 90, 0), size = Vector(0.039, 0.079, 0.054), color = Color(142, 142, 142, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },  ["egon_base+++++++++"] = { type = "Model", model = "models/props_wasteland/laundry_washer001a.mdl", bone = "Base", rel = "egon_base", pos = Vector(1, 3, 4), angle = Angle(140, -90, 0), size = Vector(0.025, 0.025, 0.059), color = Color(105,105,105), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["egon_base+++++"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "Base", rel = "egon_base", pos = Vector(-6.909, 0.2, 0), angle = Angle(90, 0, 0), size = Vector(0.07, 0.07, 0.2), color = Color(89, 100, 99, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["egon_base"] = { type = "Model", model = "models/props_wasteland/laundry_washer003.mdl", bone = "Base", rel = "", pos = Vector(0.699, 1, -7.792), angle = Angle(90, -90, 0), size = Vector(0.2, 0.1, 0.1), color = Color(87, 95, 110, 255), surpresslightning = false, material = "phoenix_storms/indenttiles_1-2", skin = 0, bodygroup = {} },  ["egon_base++"] = { type = "Model", model = "models/props_c17/factorymachine01.mdl", bone = "Base", rel = "egon_base", pos = Vector(7, 0, 2), angle = Angle(0, 90, 0), size = Vector(0.039, 0.079, 0.05), color = Color(142, 142, 142, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} }  }   wept.WElements = {  ["egon_base+++++++++++"] = { type = "Model", model = "models/props_wasteland/laundry_washer001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "egon_base", pos = Vector(1, 3, 4), angle = Angle(140, -90, 0), size = Vector(0.017, 0.017, 0.129), color = Color(196, 234, 244, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },  ["egon_base++++++"] = { type = "Model", model = "models/props_phx/misc/iron_beam2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "egon_base", pos = Vector(1.5, -4, -2), angle = Angle(-17.532, 90, 0), size = Vector(0.119, 0.119, 0.119), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_stunstick/v_stunstick_diffuse", skin = 0, bodygroup = {} },  ["egon_base+"] = { type = "Model", model = "models/props_phx/construct/metal_wire_angle360x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "egon_base", pos = Vector(10, 0.2, 0), angle = Angle(90, 0, 0), size = Vector(0.07, 0.07, 0.17), color = Color(89, 100, 99, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["egon_base++++++++++"] = { type = "Model", model = "models/props_wasteland/laundry_washer001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "egon_base", pos = Vector(1, 3, 4), angle = Angle(140, -90, 0), size = Vector(0.018, 0.018, 0.1), color = Color(139,0,0), surpresslightning = false, material = "phoenix_storms/camera", skin = 1, bodygroup = {} },  ["egon_base+++"] = { type = "Model", model = "models/props_c17/factorymachine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "egon_base", pos = Vector(7, 0, -3.1), angle = Angle(180, 90, 0), size = Vector(0.039, 0.079, 0.054), color = Color(142, 142, 142, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },  ["egon_base"] = { type = "Model", model = "models/props_wasteland/laundry_washer003.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9, 2, -5.6), angle = Angle(0, 0, -160), size = Vector(0.2, 0.1, 0.1), color = Color(87, 95, 110, 255), surpresslightning = false, material = "phoenix_storms/indenttiles_1-2", skin = 0, bodygroup = {} },  ["egon_base+++++"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "egon_base", pos = Vector(-6.909, 0.2, 0), angle = Angle(90, 0, 0), size = Vector(0.07, 0.07, 0.2), color = Color(89, 100, 99, 255), surpresslightning = false, material = "phoenix_storms/cube", skin = 0, bodygroup = {} },  ["egon_base+++++++++"] = { type = "Model", model = "models/props_wasteland/laundry_washer001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "egon_base", pos = Vector(1, 3, 4), angle = Angle(140, -90, 0), size = Vector(0.025, 0.025, 0.059), color = Color(105,105,105), surpresslightning = false, material = "phoenix_storms/metal_plate", skin = 0, bodygroup = {} },  ["egon_base++"] = { type = "Model", model = "models/props_c17/factorymachine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "egon_base", pos = Vector(7, 0, 2), angle = Angle(0, 90, 0), size = Vector(0.039, 0.079, 0.05), color = Color(142, 142, 142, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} }  } end).CollectiveName = "Lifebreather"  function SWEP:Initialize()  self.BaseClass.Initialize(self)   self.ChargeSound = CreateSound(self, "items/medcharge4.wav") end  function SWEP:Holster()  self.ChargeSound:Stop()   return self.BaseClass.Holster(self) end  function SWEP:OnRemove()  self.ChargeSound:Stop() end  function SWEP:PrimaryAttack()  if not self:CanPrimaryAttack() then return end   local owner = self:GetOwner()   local trtbl = owner:CompensatedPenetratingMeleeTrace(self.HealRange, 2, nil, nil, true)  local ent  local friends_only  local zs_friends  for _, tr in pairs(trtbl) do  local test = tr.Entity  if test and test:IsValidLivingHuman() and gamemode.Call("PlayerCanBeHealed", test) then  ent = test   break  end  end   if ent then  if CLIENT then  friends_only = GAMEMODE.FriendOnlyHeal  zs_friends = GAMEMODE.ZSFriends[ent:SteamID()]  end  if SERVER then  friends_only = owner:GetInfo("zs_friendonlyheal") ~= "0"  zs_friends = owner.ZSFriends[ent]  end  end   if friends_only and not zs_friends then return end  if not ent or self:GetDTEntity(10):IsValid() then return end   self:SetDTEntity(10, ent)  self:SetNextPrimaryFire(CurTime() + 1)  self:EmitSound("items/medshot4.wav", 75, 80) end  function SWEP:CanPrimaryAttack()  if self:GetPrimaryAmmoCount() <= 0 then  return false  end   if self:GetOwner():IsHolding() or self:GetOwner():GetBarricadeGhosting() or self:GetDTEntity(10):IsValid() then return false end   return self:GetNextPrimaryFire() <= CurTime() end  function SWEP:Reload() end  function SWEP:Think()  self.BaseClass.Think(self)   self:CheckHealRay() end  function SWEP:StopHealing()  self:SetDTEntity(10, NULL)  self:SetNextPrimaryFire(CurTime() + 0.75)  self:EmitSound("items/medshotno1.wav", 75, 60)  self.ChargeSound:Stop() end  function SWEP:TakeAmmo()  self:TakeCombinedPrimaryAmmo(2) end  function SWEP:CheckHealRay()  local ent = self:GetDTEntity(10)  local owner = self:GetOwner()   if ent:IsValidLivingHuman() and gamemode.Call("PlayerCanBeHealed", ent) and owner:KeyDown(IN_ATTACK) and  ent:WorldSpaceCenter():DistToSqr(owner:WorldSpaceCenter()) <= self.HealRange * self.HealRange and self:GetCombinedPrimaryAmmo() > 0 then   if CurTime() > self:GetDTFloat(10) then  owner:HealPlayer(ent, math.min(self:GetCombinedPrimaryAmmo(), self.Heal))  self:TakeAmmo()  self:SetDTFloat(10, CurTime() + 0.36)  self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)   local effectdata = EffectData()  effectdata:SetOrigin(ent:WorldSpaceCenter())  effectdata:SetFlags(3)  effectdata:SetEntity(self)  effectdata:SetAttachment(1)  util.Effect("tracer_healray", effectdata)  end   self.ChargeSound:PlayEx(1, 70)  elseif ent:IsValid() then  self:StopHealing()  end end 