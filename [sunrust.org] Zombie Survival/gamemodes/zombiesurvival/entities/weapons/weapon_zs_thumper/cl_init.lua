include("shared.lua")  SWEP.ViewModelFlip = false SWEP.ViewModelFOV = 50  SWEP.HUD3DBone = "ValveBiped.Bip01_R_Hand" SWEP.HUD3DPos = Vector(4.102, 3.89, -3.373) SWEP.HUD3DAng = Angle(0, 90, -43.284) SWEP.HUD3DScale = 0.015  SWEP.ShowViewModel = false SWEP.ShowWorldModel = false  SWEP.Slot = 4 SWEP.SlotPos = 0  SWEP.VElements = {  ["grenade"] = { type = "Model", model = "models/Items/AR2_Grenade.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "tube", pos = Vector(-5.625, 0, -0.904), angle = Angle(3.065, 0, 0), size = Vector(0.5, 0.93, 0.93), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["grenade_ej"] = { type = "Model", model = "models/Items/AR2_Grenade.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "tube", pos = Vector(-5.625, 0, -0.904), angle = Angle(3.065, 0, 0), size = Vector(0.5, 0.93, 0.93), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["base+++++++++++++"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "v_weapon.g3sg1_Parent", rel = "base", pos = Vector(-2.089, 0.232, -0.036), angle = Angle(90, 180, 168.729), size = Vector(0.971, 0.773, 0.405), color = Color(165, 115, 90, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} },  ["base++++++++++"] = { type = "Model", model = "models/gibs/helicopter_brokenpiece_03.mdl", bone = "v_weapon.g3sg1_Parent", rel = "base", pos = Vector(-8.167, 1.784, -0.12), angle = Angle(180, -15.268, -152.859), size = Vector(0.143, 0.128, 0.125), color = Color(165, 115, 90, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} },  ["flipsight"] = { type = "Model", model = "models/props_wasteland/interior_fence003e.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "tube", pos = Vector(2.453, -2.212, 0), angle = Angle(0, 0, 0), size = Vector(0.185, 0.09, 0.018), color = Color(145, 145, 145, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },  ["box_sight"] = { type = "Model", model = "models/props_junk/cardboard_box001a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "flipsight", pos = Vector(0, 1.972, 0), angle = Angle(0, 0, 0), size = Vector(0.013, 0.046, 0.093), color = Color(145, 145, 145, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },  ["tube_latch_top"] = { type = "Model", model = "models/PHXtended/bar1x45a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "tube", pos = Vector(-3.757, -0.778, 0.388), angle = Angle(-90, 90, 0), size = Vector(0.128, 0.081, 0.104), color = Color(145, 145, 145, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },  ["base"] = { type = "Model", model = "models/XQM/panel360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.137, 1.914, -3.273), angle = Angle(-44.092, -8.388, -95.351), size = Vector(0.847, 0.05, 0.046), color = Color(145, 145, 145, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },  ["tube"] = { type = "Model", model = "models/props_pipes/concrete_pipe001a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(7.885, -0.137, 0), angle = Angle(0, 0, 0), size = Vector(0.155, 0.027, 0.027), color = Color(145, 145, 145, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },  ["trigger"] = { type = "Model", model = "models/gibs/manhack_gib06.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0.135, 1.355, 0.125), angle = Angle(0, 166.578, 0), size = Vector(0.149, 0.209, 2.364), color = Color(145, 145, 145, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },  ["tube_under+"] = { type = "Model", model = "models/props_phx/construct/wood/wood_boardx1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "tube", pos = Vector(2.378, 1.924, 0), angle = Angle(0, 0, -90), size = Vector(0.115, 0.277, 0.402), color = Color(165, 115, 90, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} },  ["box_sight+"] = { type = "Model", model = "models/props_junk/cardboard_box001a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "flipsight", pos = Vector(0, -0.843, 0), angle = Angle(0, 0, 0), size = Vector(0.013, 0.008, 0.093), color = Color(145, 145, 145, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },  ["tube_under"] = { type = "Model", model = "models/props_phx/construct/wood/wood_boardx1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(3.44, 1.773, 0), angle = Angle(0, 0, -90), size = Vector(0.172, 0.277, 0.402), color = Color(145, 145, 145, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },  ["tube_latch_top+"] = { type = "Model", model = "models/PHXtended/bar1x.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0.277, -0.917, 0.386), angle = Angle(-90, 90, 0), size = Vector(0.128, 0.017, 0.104), color = Color(145, 145, 145, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },  ["guard"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(-0.027, 1.036, -0.401), angle = Angle(0, -93.317, 0), size = Vector(0.059, 0.05, 0.103), color = Color(145, 145, 145, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },  ["tube_SIGHT"] = { type = "Model", model = "models/Mechanics/roboticslarge/g1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "tube", pos = Vector(8.317, -1.185, 0), angle = Angle(90, 0, 0), size = Vector(0.008, 0.026, 0.029), color = Color(145, 145, 145, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },  ["grenade_hand"] = { type = "Model", model = "models/Items/AR2_Grenade.mdl", bone = "ValveBiped.Bip01_L_Finger01", rel = "", pos = Vector(1.618, -2.073, -1.627), angle = Angle(-15.966, 72.051, 2.029), size = Vector(0.5, 0.93, 0.93), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }, }  SWEP.WElements = {  ["tube_SIGHT"] = { type = "Model", model = "models/Mechanics/roboticslarge/g1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "tube", pos = Vector(8.317, -1.185, 0), angle = Angle(90, 0, 0), size = Vector(0.009, 0.026, 0.03), color = Color(145, 145, 145, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },  ["base+++++++++++++"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-2.089, 0.233, -0.035), angle = Angle(90, 180, 168.729), size = Vector(0.971, 0.773, 0.405), color = Color(165, 115, 90, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} },  ["base++++++++++"] = { type = "Model", model = "models/gibs/helicopter_brokenpiece_03.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-8.167, 1.784, -0.12), angle = Angle(180, -15.268, -152.859), size = Vector(0.144, 0.129, 0.125), color = Color(165, 115, 90, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} },  ["flipsight"] = { type = "Model", model = "models/props_wasteland/interior_fence003e.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "tube", pos = Vector(2.453, -2.212, 0), angle = Angle(0, 0, 0), size = Vector(0.185, 0.09, 0.019), color = Color(145, 145, 145, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },  ["box_sight+"] = { type = "Model", model = "models/props_junk/cardboard_box001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "flipsight", pos = Vector(0, -0.843, 0), angle = Angle(0, 0, 0), size = Vector(0.013, 0.008, 0.093), color = Color(145, 145, 145, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },  ["tube_latch_top"] = { type = "Model", model = "models/PHXtended/bar1x45a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "tube", pos = Vector(-3.756, -0.778, 0.389), angle = Angle(-90, 90, 0), size = Vector(0.129, 0.081, 0.104), color = Color(145, 145, 145, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },  ["base"] = { type = "Model", model = "models/XQM/panel360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.606, 0.549, -3.764), angle = Angle(-13.783, -1.583, -90), size = Vector(0.848, 0.05, 0.046), color = Color(145, 145, 145, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },  ["tube"] = { type = "Model", model = "models/props_pipes/concrete_pipe001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(7.885, -0.137, 0), angle = Angle(0, 0, 0), size = Vector(0.155, 0.027, 0.027), color = Color(145, 145, 145, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },  ["trigger"] = { type = "Model", model = "models/gibs/manhack_gib06.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0.135, 1.355, 0.125), angle = Angle(0, 166.578, 0), size = Vector(0.149, 0.209, 2.364), color = Color(145, 145, 145, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },  ["tube_under+"] = { type = "Model", model = "models/props_phx/construct/wood/wood_boardx1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "tube", pos = Vector(2.378, 1.924, 0), angle = Angle(0, 0, -90), size = Vector(0.116, 0.277, 0.402), color = Color(165, 115, 90, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} },  ["tube_latch_top+"] = { type = "Model", model = "models/PHXtended/bar1x.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0.277, -0.916, 0.386), angle = Angle(-90, 90, 0), size = Vector(0.129, 0.017, 0.104), color = Color(145, 145, 145, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },  ["tube_under"] = { type = "Model", model = "models/props_phx/construct/wood/wood_boardx1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(3.44, 1.773, 0), angle = Angle(0, 0, -90), size = Vector(0.172, 0.277, 0.402), color = Color(145, 145, 145, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },  ["box_sight"] = { type = "Model", model = "models/props_junk/cardboard_box001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "flipsight", pos = Vector(0, 1.972, 0), angle = Angle(0, 0, 0), size = Vector(0.013, 0.046, 0.093), color = Color(145, 145, 145, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },  ["guard"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-0.026, 1.036, -0.401), angle = Angle(0, -93.316, 0), size = Vector(0.059, 0.05, 0.103), color = Color(145, 145, 145, 255), surpresslightning = false, material = "phxtended/metal", skin = 0, bodygroup = {} },  ["BLACKED"] = { type = "Model", model = "models/XQM/panel360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "tube", pos = Vector(8.661, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.041, 0.041, 0.041), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} } }  SWEP.ViewModelBoneMods = {  ["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(-3.639, 6.868, -2.768), angle = Angle(0, 0, 0) },  ["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-10.87, -8.582, 5.317) },  ["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-13.45, 1.84, 7.414), angle_reload = Angle(-4.725, 12.461, -63.902) },  ["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-31.209, 0, 0), angle_reload = Angle(-34.674, 11.873, -14.827) },  ["ValveBiped.Bip01_R_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), pos_reload = Vector(0.171, 1.194, -0.105), angle_reload = Angle(0, 4.932, 0) },   ["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), pos_reload = Vector(1.425, -1.188, -2.781), angle = Angle(0, 0, 0) },  ["ValveBiped.Bip01_L_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }, }  for k, v in pairs( SWEP.ViewModelBoneMods ) do  if v.pos and v.angle then  SWEP.ViewModelBoneMods[ k ].def_pos = Vector( v.pos.x, v.pos.y, v.pos.z )  SWEP.ViewModelBoneMods[ k ].def_angle = Angle( v.angle.p, v.angle.y, v.angle.r )  end end  for k, v in pairs( SWEP.VElements ) do  if v and string.find( k, "grenade" ) then  SWEP.VElements[ k ].def_pos = Vector( v.pos.x, v.pos.y, v.pos.z )  SWEP.VElements[ k ].def_angle = Angle( v.angle.p, v.angle.y, v.angle.r )  SWEP.VElements[ k ].hide = true  end end  local math_random = math.random  function SWEP:DoShellInsertion( duration )   local vm = self:GetOwner():GetViewModel()  local dur = vm:SequenceDuration() / math.max( vm:GetPlaybackRate(), 0.1 )   self.ShellInsertDuration = duration or dur * 0.85   self.ShellInsertTime = CurTime() + self.ShellInsertDuration  local shell_hand = self.VElements and self.VElements["grenade_hand"]  if shell_hand then  shell_hand.hide = false  end end  function SWEP:DoShellEjection( duration )  self.ShellEjectDuration = duration or 0.4  self.ShellEjectTime = CurTime() + self.ShellEjectDuration    if not self.ShellEjectionTable then  self.ShellEjectionTable = {}  end   self.ShellEjectionTable[1] = { pos = VectorRand() * math_random( -2, 2 ), ang = Angle( math_random( -6, 6 ), math_random( -6, 6 ), math_random( -6, 6 ) ) }  end  function SWEP:ForceShellEjection()     self:DoShellEjection()     self:EmitSound("weapons/grenade_launcher1.wav", 70, math.random(235, 245), 1, CHAN_WEAPON + 1)     self.DrawSmoke = 0     self.ShouldEject = false end  function SWEP:FireAnimationEvent( pos, ang, event, options )     if event == 20 then         if self.ShouldEject then             self:ForceShellEjection()         end         return true     end end  local reloadlerp = 0 local lerp_vector = LerpVector local lerp_angle = LerpAngle  local vec_forward = Vector( 1, 0, 0 ) local vec_right = Vector( 0, 1, 0 )  function SWEP:PreDrawViewModel(vm)  self.BaseClass.PreDrawViewModel(self, vm)   if self:IsReloading() then  reloadlerp = math.min(1, reloadlerp + RealFrameTime() * 2)  elseif reloadlerp > 0 then  reloadlerp = math.max(0, reloadlerp - RealFrameTime() * 3)  end   self.ReloadLerp = reloadlerp   if self.ReloadLerp and self.ViewModelBoneMods then  for k, v in pairs( self.ViewModelBoneMods ) do  if v and v.def_pos and v.pos_reload then  v.pos = lerp_vector( self.ReloadLerp, v.def_pos, v.pos_reload )  end  if v and v.def_angle and v.angle_reload then  v.angle = lerp_angle( self.ReloadLerp, v.def_angle, v.angle_reload )  end  end  end     local ang = self.VElements["tube"].angle  local reload = self:IsReloading()  local shell_eject = self.ShellEjectTime and ( self.ShellEjectTime - 0.1 ) >= CurTime()  local is_firing = self.FireAnimationTime and ( self.FireAnimationTime - 0.4 ) >= CurTime()   ang.yaw = math.Approach(ang.yaw, ( reload and -23 ) or ( shell_eject and -23 ) or 0, RealFrameTime() * ( shell_eject and 500 or 200 ) )      if self.ViewModelBoneMods then  local arm = self.ViewModelBoneMods["ValveBiped.Bip01_L_Forearm"]  if arm then  arm.angle.p = math.Approach(arm.angle.p, is_firing and -5 or 0, RealFrameTime() * ( is_firing and 10 or 300 ) )  arm.angle.y = math.Approach(arm.angle.y, is_firing and 6.5 or 0, RealFrameTime() * ( is_firing and 10 or 300 ) )  end  end   if self.VElements then   self.ShellEjectTime = self.ShellEjectTime or 0  self.ShellInsertTime = self.ShellInsertTime or 0   local shell = self.VElements["grenade"]  local shell_ej = self.VElements["grenade_ej"]  local shell_hand = self.VElements["grenade_hand"]   local shell_delta_ej = 0  local shell_delta = 0   if self.ShellEjectTime ~= 0 and self.ShellEjectionTable then   if self.ShellEjectTime >= CurTime() then  shell_delta_ej = math.Clamp( 1 - ( self.ShellEjectTime - CurTime() ) / ( self.ShellEjectDuration or 0.3 ), 0, 1 )  shell_delta_ej = shell_delta_ej ^ 1.5   shell_ej.pos = lerp_vector( shell_delta_ej, shell_ej.def_pos, shell_ej.def_pos + vec_forward * -35 + vec_right * ( shell_delta_ej * 23 ) + self.ShellEjectionTable[1].pos * shell_delta_ej )  shell_ej.angle = lerp_angle( shell_delta_ej, shell_ej.def_angle, shell_ej.def_angle + self.ShellEjectionTable[1].ang * shell_delta_ej )  shell_ej.hide = false   shell.hide = true   if self.DrawSmoke and self.DrawSmoke <= CurTime() and shell_delta_ej <= 0.7 then  self.DrawSmoke = CurTime() + 0.05   local smoke = self.VElements["tube"].modelEnt  if smoke then  local smoke_ang = smoke:GetAngles()  local pos = smoke:GetPos() - smoke_ang:Forward() * 17 + smoke_ang:Right() * 3  local emitter = ParticleEmitter( pos )   for i=1, math.random( 3, 9 ) do  local particle = emitter:Add("particles/smokey", pos + VectorRand()*1)  particle:SetVelocity(smoke_ang:Forward() * -1 * math.random( 1, 30 ) )  particle:SetDieTime(math.Rand(0.4, 0.8))  particle:SetStartSize(1)  particle:SetEndSize(3)  particle:SetStartAlpha(230)  particle:SetEndAlpha(0)  particle:SetRoll(math.Rand(0, 360))  particle:SetColor(70, 70, 70)  particle:SetAirResistance(15)  end   emitter:Finish() emitter = nil collectgarbage("step", 64)  end  end   else  self.ShellEjectTime = 0  shell_ej.hide = true  end  end   if self.ShellInsertTime ~= 0 then  if self.ShellInsertTime >= CurTime() and self.ShellInsertDuration then  shell_delta = math.Clamp( 1 - ( self.ShellInsertTime - CurTime() ) / self.ShellInsertDuration, 0, 1 )  shell_delta = shell_delta ^ 1.5   shell.pos = lerp_vector( shell_delta, shell.def_pos + vec_forward * -3.2, shell.def_pos )   if shell_delta >= 0.25 then  shell.hide = false  shell_hand.hide = true  end   else  self.ShellInsertTime = 0  end  end  end end 