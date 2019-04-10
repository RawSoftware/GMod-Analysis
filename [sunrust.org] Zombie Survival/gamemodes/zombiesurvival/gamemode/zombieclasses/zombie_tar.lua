CLASS.Base = "zombie"  CLASS.Name = "Tar Zombie" CLASS.TranslationName = "class_zombie_tar" CLASS.Description = "description_zombie_tar" CLASS.Help = "controls_zombie_tar"  CLASS.Wave = 0 CLASS.Unlocked = false CLASS.Hidden = true  CLASS.Health = 200 CLASS.Speed = 150 CLASS.Revives = false  CLASS.Points = CLASS.Health/GM.HumanoidZombiePointRatio CLASS.Cat = ZCLASSCAT_SUPPORT  CLASS.SWEP = "weapon_zs_zombie_tar"  function CLASS:PlayPainSound(pl)  pl:EmitSound("npc/zombie/zombie_pain"..math.random(6)..".wav", 75, math.random(87, 92))   pl.NextPainSound = CurTime() + .5   return true end  function CLASS:PlayDeathSound(pl)  pl:EmitSound("npc/zombie/zombie_die"..math.random(3)..".wav", 70, math.random(87, 92))   return true end  if SERVER then  function CLASS:ReviveCallback(pl, attacker, dmginfo)  return false end  function CLASS:ProcessDamage(pl, dmginfo)  return false end  function CLASS:OnKilled(pl, attacker, inflictor, suicide, headshot, dmginfo, assister)  if suicide then return end   local pos = pl:WorldSpaceCenter()   local effectdata = EffectData()  effectdata:SetOrigin(pos)  util.Effect("explosion_tar", effectdata)   util.BlastDamageEx(pl, pl, pos, 105, 3, DMG_GENERIC, 0.7, {[pl] = true})   local ent = ents.Create("env_tar")  if ent:IsValid() then  ent:SetPos(pos)  ent:Spawn()  end   return true end  end  if not CLIENT then return end  CLASS.Icon = "zombiesurvival/killicons/zombie" CLASS.IconColor = Color(40, 40, 40)  local matTar = CreateMaterial("tarzombie", "VertexLitGeneric", {  ["$basetexture"] = "models/Zombie_Classic/Zombie_Classic_sheet",  ["$normalmapalphaenvmapmask"] = 1,  ["$bumpmap"] = "models/flesh_nrm",  ["$halflambert"] = 1,  ["$phong"] = 1,  ["$phongboost"] = 1,  ["$phongfresnelranges"] = "[1 2.5 5]",  ["$phongexponent"] = 50 })  function CLASS:PrePlayerDraw(pl)  render.ModelMaterialOverride(matTar)  render.SetColorModulation(25/255, 25/255, 25/255) end  function CLASS:PostPlayerDraw(pl)  render.ModelMaterialOverride()  render.SetColorModulation(1, 1, 1) end 