GM.WeaponQualityModifiers = {} GM.DeployFunctions = {} GM.WeaponQualities = {     {         Upg = "Sturdy",         Ref = "Tuned",         DamageMultiplier = 1.09     },     {         Upg = "Honed",         Ref = "Modified",         DamageMultiplier = 1.19     },     {         Upg = "Perfected",         Ref = "Reformed",         DamageMultiplier = 1.35     } } GM.WeaponQualityColors = {     {         Upg   = Color(235, 235, 115),         UpgDark  = Color(122, 115, 60),         Ref      = Color(172, 219, 105),         RefDark  = Color(85, 105, 55),     },     {         Upg   = Color(50, 90, 175),         UpgDark  = Color(25, 45, 85),         Ref      = Color(35, 110, 145),         RefDark  = Color(15, 55, 75),     },     {         Upg   = Color(160, 95, 235),         UpgDark  = Color(80, 45, 120),         Ref      = Color(252, 100, 100),         RefDark  = Color(120, 50, 50),     } }  WEAPON_MODIFIER_MIN_SPREAD = 1 WEAPON_MODIFIER_MAX_SPREAD = 2 WEAPON_MODIFIER_FIRE_DELAY = 3   WEAPON_MODIFIER_RELOAD_SPEED = 4 WEAPON_MODIFIER_CLIP_SIZE = 5 WEAPON_MODIFIER_MELEE_RANGE = 6 WEAPON_MODIFIER_MELEE_SIZE = 7 WEAPON_MODIFIER_MELEE_IMPACT_DELAY = 8 WEAPON_MODIFIER_PROJECTILE_VELOCITY = 9 WEAPON_MODIFIER_SHORT_TEAM_HEAT = 10 WEAPON_MODIFIER_SHOT_COUNT = 11 WEAPON_MODIFIER_BULLET_PIERCES = 12 WEAPON_MODIFIER_MAXIMUM_MINES = 13 WEAPON_MODIFIER_MAX_DISTANCE = 14 WEAPON_MODIFIER_AURA_RADIUS = 15 WEAPON_MODIFIER_RECOIL = 16 WEAPON_MODIFIER_DAMAGE = 17 WEAPON_MODIFIER_HEALRANGE = 18 WEAPON_MODIFIER_HEALCOOLDOWN = 19 WEAPON_MODIFIER_BUFF_DURATION = 20 WEAPON_MODIFIER_LEG_DAMAGE = 21 WEAPON_MODIFIER_REPAIR = 22 WEAPON_MODIFIER_TURRET_SPREAD = 23 WEAPON_MODIFIER_HEALING = 24 WEAPON_MODIFIER_HEADSHOT_MULTI = 25 WEAPON_MODIFIER_MELEE_KNOCK = 26 WEAPON_MODIFIER_BACKSTAB_RATIO = 27 WEAPON_MODIFIER_TURRET_DELAY = 28 WEAPON_MODIFIER_BLOCK_STAB = 29 WEAPON_MODIFIER_KNOCKBACK = 30 WEAPON_MODIFIER_CULL = 31 WEAPON_MODIFIER_HEALING_HARVEST_RATE = 32 WEAPON_MODIFIER_CLIP_USAGE = 33 WEAPON_MODIFIER_RADIUS = 34 WEAPON_MODIFIER_STAMINA_USAGE = 35 WEAPON_MODIFIER_PROJECTILE_FREQ = 36 WEAPON_MODIFIER_PIERCE_DAMAGE = 37 WEAPON_MODIFIER_MAX_STACKS = 38 WEAPON_MODIFIER_MAX_DAMAGE = 39 WEAPON_MODIFIER_ACID_MUL = 40 WEAPON_MODIFIER_FIRE_MUL = 41 WEAPON_MODIFIER_ICE_MUL = 42  local index = 1 function GM:AddWeaponQualityModifier(id, name, displayraw, vartable)     local datatab = {Name = name, DisplayRaw = displayraw, VarTable = vartable}     self.WeaponQualityModifiers[id] = datatab      index = index + 1      return datatab end  function GM:SetPrimaryWeaponModifier(swep, modifier, amount)     swep.PrimaryRemantleModifier = {Modifier = modifier, Amount = amount} end  function GM:AttachWeaponModifier(swep, modifier, amount, qualitystart)     if not swep.AltRemantleModifiers then swep.AltRemantleModifiers = {} end      local datatab = {Amount = amount, QualityStart = qualitystart or 2}     swep.AltRemantleModifiers[modifier] = datatab end  function GM:AttachWeaponModifierToBranch(branch, modifier, amount, qualitystart)     if not branch.AltRemantleModifiers then branch.AltRemantleModifiers = {} end      local datatab = {Amount = amount, QualityStart = qualitystart or 2}     branch.AltRemantleModifiers[modifier] = datatab end  function GM:AddNewRemantleBranch(swep, no, printname, desc, branchfunc)     if not swep.Branches then swep.Branches = {} end      local datatab = {PrintName = printname, Desc = desc, BranchFunc = branchfunc}     swep.Branches[no] = datatab      return datatab end  function GM:AddNewDeployableFunction(deploy_class, deploy_branch_index, key_funcs)     if not self.DeployFunctions[deploy_class] then         self.DeployFunctions[deploy_class] = {}     end     if not self.DeployFunctions[deploy_class][deploy_branch_index] then         self.DeployFunctions[deploy_class][deploy_branch_index] = {}     end      for key, func in pairs(key_funcs) do         self.DeployFunctions[deploy_class][deploy_branch_index][key] = func     end end  function GM:CallDeployableFunction(ent, class, deploy_branch_index, key_func)     local deploy_fcs = self.DeployFunctions[class]     if deploy_fcs then         local branch_func = deploy_fcs[deploy_branch_index]         if branch_func then             local opt_key_func = branch_func[key_func]              return opt_key_func and opt_key_func(ent)         end     end end  GM:AddWeaponQualityModifier(WEAPON_MODIFIER_MIN_SPREAD,  "Minimum Spread",  false,  {ConeMin = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_MAX_SPREAD, "Maximum Spread",  false,  {ConeMax = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_FIRE_DELAY, "Fire Delay",  false,  {Delay = true}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_RELOAD_SPEED, "Reload Speed",   false,  {ReloadSpeed = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_CLIP_SIZE, "Clip Size",  true,  {ClipSize = true}).ReqClip = true GM:AddWeaponQualityModifier(WEAPON_MODIFIER_MELEE_RANGE, "Melee Range",  false,  {MeleeRange = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_MELEE_SIZE, "Melee Size",  false,  {MeleeSize = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_MELEE_IMPACT_DELAY, "Melee Impact Delay",  false,  {SwingTime = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_PROJECTILE_VELOCITY, "Projectile Velocity",  false,  {ProjVelocity = true}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_SHORT_TEAM_HEAT, "Short Term Heat",  false,  {HeatBuildShort = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_SHOT_COUNT, "Shot Count",  true,  {NumShots = true}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_BULLET_PIERCES, "Bullet Pierces",  true,  {Pens = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_MAXIMUM_MINES, "Maximum Mines",  true,  {MaxMines = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_MAX_DISTANCE, "Maximum Distance",  false,  {MaxRange = false, MaxDistance = true}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_AURA_RADIUS, "Aura Detection Radius",  false,  {AuraRange = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_RECOIL, "Recoil",  false,  {Recoil = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_DAMAGE, "Damage",  false,  {Damage = true, MeleeDamage = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_HEALRANGE, "Heal Range",  false,  {HealRange = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_HEALCOOLDOWN, "Healing Cooldown",  false,  {Delay = true}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_BUFF_DURATION, "Buff Duration",  false,  {BuffDuration = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_LEG_DAMAGE, "Slow Strength",  false,  {LegDamage = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_REPAIR, "Repair Strength",  false,  {Repair = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_TURRET_SPREAD, "Turret Bullet Spread",  false,  {TurretSpread = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_HEALING, "Healing Amount",  false,  {Heal = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_HEADSHOT_MULTI, "Headshot Damage Bonus",  false,  {HeadshotMulti = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_MELEE_KNOCK, "Knockback",  false,  {MeleeKnockBack = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_BACKSTAB_RATIO, "Backstab Multiplier",  false,  {BackstabRatio = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_TURRET_DELAY, "Activation Delay",  false,  {TurretFireRate = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_BLOCK_STAB,     "Block Stability",      false,  {Stability = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_KNOCKBACK, "Self Knockback",  false,  {Knockback = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_CULL, "Culling Percent",  false,  {Cull = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_HEALING_HARVEST_RATE,     "Harvest Rate",             false,  {HarvestRatio = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_CLIP_USAGE,                 "Clip Usage",               true,  {RequiredClip = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_RADIUS,                     "Radius",                   false,  {Radius = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_STAMINA_USAGE,              "Stamina Usage",            false,  {StaminaUsage = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_PROJECTILE_FREQ,            "Projectile Frequency",     false,  {ProjectileFrequency = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_PIERCE_DAMAGE,              "Pierce Damage",            false,  {PenTaper = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_MAX_STACKS,                 "Maximum Stacks",           true,  {MaxStacks = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_MAX_DAMAGE,                 "Maximum Damage Multiplier",false,  {MaximumDamage = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_ACID_MUL,                   "Acid Duration",            false,  {CorrosionMul = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_FIRE_MUL,                   "Ignite Duration",          false,  {IgniteMul = false}) GM:AddWeaponQualityModifier(WEAPON_MODIFIER_ICE_MUL,                    "Ice Slow",                 false,  {IceSlowMul = false})  local function ApplyWeaponModifier(modinfo, wept, datatab, remantledescs, i)     local displayed = false     local mtbl, basestat, newstat, qfactor      for var, isprimary in pairs(modinfo.VarTable) do         mtbl = isprimary and wept.Primary or wept         if mtbl[var] then             qfactor = math.max(0, i - (datatab.QualityStart - 1))             basestat = mtbl[var]             newstat = basestat + datatab.Amount * qfactor              mtbl[var] = newstat              if not displayed and qfactor > 0 then                 local ispos = datatab.Amount > 0 and "+" or ""                 local statincdesc = not modinfo.DisplayRaw and (((math.Round(newstat/basestat, 2)-1) * 100).. "% ")                     or ((datatab.Amount * qfactor / (modinfo.ReqClip and wept.RequiredClip or 1)).. " ")                  table.insert(remantledescs, ispos .. statincdesc .. modinfo.Name)                 displayed = true             end         end     end end  local base_variant_color = Color(160, 180, 215) local function CreateQualityKillicon(oldc, newc, i, b, cols)     local kitbl = killicon.Get(oldc)     if kitbl then         local kifunc = #kitbl == 2 and killicon.Add or killicon.AddFont         local nkitbl = table.Copy(kitbl)         nkitbl[#kitbl] =  cols and cols[i+1] or                             i == 0 and base_variant_color or                             GAMEMODE.WeaponQualityColors[i][b and "Ref" or "Upg"]         kifunc(newc, unpack(nkitbl))     end end  function GM:CreateWeaponOfQuality(i, orig, quality, classname, branch)     orig.RemantleDescs[branch and branch.No or 0][i] = {}                  local wept = weapons.Get(classname)     local remantledescs = orig.RemantleDescs[branch and branch.No or 0][i]      local upg_name  = quality and quality.Upg     local ref_name  = quality and quality.Ref     local base_dmg_mul  = quality and quality.DamageMultiplier      wept.BaseQuality = classname     wept.QualityTier = i > 0 and i or nil     wept.Branch = branch and branch.No      local prefix =  not quality and "" or                     branch and branch.NewNames and branch.NewNames[i] or                     wept.RemantleNames and wept.RemantleNames[i] or                     branch and ref_name or                     upg_name      if wept.PrintName then         local weapon_name = branch and branch.PrintName or wept.PrintName          wept.PrintName = prefix..(quality and " " or "")..weapon_name     end      if quality and not (branch and branch.NoRemantleBonus) then         local real_mul = 1 + ((base_dmg_mul - 1) * (branch and branch.DamageScaling or wept.DamageScaling or 1))          if wept.PrimaryRemantleModifier then             local primod = wept.PrimaryRemantleModifier              ApplyWeaponModifier(self.WeaponQualityModifiers[primod.Modifier], wept, {Amount = primod.Amount, QualityStart = 1}, remantledescs, i)         else             if wept.Primary and wept.Primary.Damage then                 wept.Primary.Damage = wept.Primary.Damage * real_mul             end             if wept.MeleeDamage then                 wept.MeleeDamage = wept.MeleeDamage * real_mul             end              table.insert(remantledescs, "+" .. ((real_mul-1) * 100) .. "% " .. "Damage")         end          local alt_modifiers = branch and branch.AltRemantleModifiers or wept.AltRemantleModifiers         if alt_modifiers then             for modifier, datatab in pairs(alt_modifiers) do                 if modifier == "BaseClass" then continue end                    test = branch and branch.AltRemantleModifiers                  ApplyWeaponModifier(self.WeaponQualityModifiers[modifier], wept, datatab, remantledescs, i)             end         end     end      if branch and branch.BranchFunc then         table.insert(remantledescs, 1, branch.Desc)          branch.BranchFunc(wept)          wept.Description = branch.Desc     end      local newclass = self:GetWeaponClassOfQuality(classname, i, branch and branch.No)     if CLIENT then         CreateQualityKillicon(branch and branch.Killicon or classname, newclass, i, branch and branch.No, branch and branch.Colors)     end      local regscriptent = function(class, cbk, prefix)         local newent = self:GetWeaponClassOfQuality(class, i, branch and branch.No)         local afent = scripted_ents.Get((prefix or "") .. class)         if cbk then cbk(afent, newent) end          scripted_ents.Register(afent, (prefix or "") .. newent)         return newent     end      if quality or (branch and branch.BranchFunc) then         if wept.DeployClass then             wept.DeployClass = regscriptent(wept.DeployClass, function(ent, newcl)                 if CLIENT then                     CreateQualityKillicon(wept.DeployClass, newcl, i, branch and branch.No, branch and branch.Colors)                 end                  ent.BaseDeployClass = wept.DeployClass                  if self.DeployableInfo[wept.DeployClass] then                     self:AddDeployableInfo(newcl, prefix .. (quality and " " or "") .. self.DeployableInfo[wept.DeployClass].Name, "")                 end             end)              if wept.AmmoIfHas then                 local newammo = self:GetWeaponClassOfQuality(wept.Primary.Ammo, i, branch and branch.No)                  game.AddAmmoType({name = newammo})                 wept.Primary.Ammo = newammo             end              if wept.Channel then                 table.insert(self.ChannelsToClass[wept.Channel], wept.DeployClass)             end         end          if wept.GhostStatus then wept.GhostStatus = regscriptent(wept.GhostStatus, function(ent)             local ghostent = self:GetWeaponClassOfQuality(ent.GhostEntity, i, branch and branch.No)             ent.GhostEntity = ghostent             ent.GhostWeapon = newclass         end, "status_") end     end      weapons.Register(wept, newclass) end  function GM:CreateWeaponQualities()     local allweapons = weapons.GetList()     local classname      for _, t in ipairs(allweapons) do         classname = t.ClassName          if string.sub(classname, 1, 14) == "weapon_zs_base" then             continue         end          local wept = weapons.Get(classname)         if wept and wept.AllowQualityWeapons then             local orig = weapons.GetStored(classname)             orig.RemantleDescs = {}             orig.RemantleDescs[0] = {}              if orig.Branches then                 for no, tbl in pairs(orig.Branches) do                     orig.RemantleDescs[no] = {}                     local ntbl = table.Copy(tbl)                     ntbl.No = no                      self:CreateWeaponOfQuality(0, orig, nil, classname, ntbl)                 end             end              for i, quality in ipairs(self.WeaponQualities) do                 self:CreateWeaponOfQuality(i, orig, quality, classname)                  if orig.Branches then                     for no, tbl in pairs(orig.Branches) do                         local ntbl = table.Copy(tbl)                         ntbl.No = no                          self:CreateWeaponOfQuality(i, orig, quality, classname, ntbl)                     end                 end             end         end     end end  function GM:GetAffixOfQuality(branch, quality)     return "_" .. string.char(113 + (branch or 0)) .. quality end  function GM:GetWeaponClassOfQuality(classname, quality, branch)     return classname .. self:GetAffixOfQuality(branch, quality) end  local function fold_tb_x(tb, x)     local c = 0     for i, val in ipairs(tb) do         if i > x then break end          c = c + val     end      return c end  function GM:GetDismantleScrap(wtbl, invitem, pl)     local itier = wtbl.Tier     local inv_scrap_scaling = wtbl.ScrapScaling and fold_tb_x(wtbl.ScrapScaling, 1 + (pl:GetTrinketItemLevel(invitem) or 0)) or                               GAMEMODE.ScrapValsTrinkets[itier or 1]      local baseval = invitem and inv_scrap_scaling or GAMEMODE.ScrapVals[itier or 1]      local quatier = wtbl.QualityTier     local adj = 0     if quatier and not invitem then         adj = self:GetUpgradeScrap(wtbl, quatier, pl) * (1 - (pl.ScrapDiscount or 1))     end      local qu = (quatier or 0) + 1     local basicvalue = (baseval * GAMEMODE.DismantleMultipliers[qu]) - ((quatier or itier) and 0 or 1) - adj      local is_inventory_div = invitem and 2 or 1     local non_inv_dismantle = qu == 1 and wtbl.DismantleDiv      return math.floor((basicvalue * (not itier and wtbl.IsMelee and 0.75 or 1)) / (non_inv_dismantle or is_inventory_div)) end  function GM:GetUpgradeScrap(wtbl, qualitychoice, pl)     local itier = wtbl.Tier      return math.ceil(self.ScrapVals[itier or 1] * qualitychoice * (not itier and wtbl.IsMelee and 0.85 or 1) * (pl.ScrapDiscount or 1)) end  function GM:GetTrinketUpgradeScrap(item_data, quality, pl)     return math.ceil(item_data.ScrapScaling[quality] * (pl.ScrapDiscount or 1)) end  GM.PointsToScrapRatio = 70 / 32  function GM:PointsToScrap(points)     return points / self.PointsToScrapRatio end  function GM:ScrapToPoints(scrap)     return scrap * self.PointsToScrapRatio end 