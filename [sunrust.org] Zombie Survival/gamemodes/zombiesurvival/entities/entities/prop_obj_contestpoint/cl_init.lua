include("shared.lua")  ENT.RenderGroup = RENDERGROUP_TRANSLUCENT  function ENT:Initialize()  self:DrawShadow(false)   self:SetModelScaleVector(Vector(1, 1, 1) * self.ModelScale)      self.AmbientSound2 = CreateSound(self, "ambient/atmosphere/corridor.wav")      self.StartPos = self:GetPos()     self.Parts = {}      self:SetRenderBounds(Vector(-64, -64, -64), Vector(64, 64, 64)) end  local pitches = {     [1] = 70,     [2] = 150,     [3] = 70 }  function ENT:Think()  if EyePos():DistToSqr(self:GetPos()) <= 250000 then  self.AmbientSound2:PlayEx(1, pitches[self:GetCapturePointType()] or 70)  else  self.AmbientSound2:Stop()  end end  function ENT:OnRemove()  self.AmbientSound2:Stop()      self:ClearParts() end  local use_real_appearance = true local indexes_to_func = {     [1] = "DrawArkOfAdonis",     [2] = "DrawElderGodsLockbox",     [3] = "DrawBloodCrucible",     [4] = "DrawBrokenSigil", }  local matBeam = Material("trails/physbeam", "smooth") local colRing = Color(80, 200, 70) local matSheet = Material("models/flesh") function ENT:DrawTranslucent()     local curtime = CurTime()      if use_real_appearance then         local draw_func = self[indexes_to_func[self:GetCapturePointType()]]         if draw_func then             draw_func(self)              render.SetBlend(0)             self:DrawModel()             render.SetBlend(1)              local ringsize = self.Radius             local beamsize = 40             local up = self:GetUp()             local ang = self:GetForward():Angle()             ang.yaw = curtime * 180 % 360             local ringpos = self:GetPos() + up * 16              local ca = 0.2             colRing.g = 255 * ca             colRing.b = 255 * ca             colRing.r = 255 * ca              render.SetMaterial(matBeam)             render.StartBeam(24)             for i=1, 24 do                 render.AddBeam(ringpos + ang:Forward() * ringsize, beamsize, beamsize, colRing)                 ang:RotateAroundAxis(up, 20)             end             render.EndBeam()                          return         end     end      if math.random(5) == 1 then         self:SetPos(self.StartPos + VectorRand() * 13)                  self:SetModelScaleVector(Vector(1, 1, 1) * self.ModelScale * math.Rand(0.95, 1.1))     else         self:SetPos(self.StartPos)     end      local flesh = math.random(2) == 1      render.ModelMaterialOverride(flesh and matSheet)     render.SetBlend(flesh and 0.75 or 0.3)     render.SetColorModulation(1, 0.75, 1)     self:DrawModel()     render.SetColorModulation(1, 1, 1)     render.SetBlend(1)     render.ModelMaterialOverride() end  function ENT:ClearParts()     for _, v in ipairs(self.Parts) do         v:Remove()     end          self.Parts = {} end  function ENT:InitArkOfAdonisParts()     local cmodel = ClientsideModel("models/props_trainstation/trainstation_ornament002.mdl")     if cmodel:IsValid() then         cmodel:SetPos(self:LocalToWorld(Vector(-12, 12, 0)))         cmodel:SetAngles(self:LocalToWorldAngles(Angle(0, 0, 0)))         cmodel:SetSolid(SOLID_NONE)         cmodel:SetMoveType(MOVETYPE_NONE)         cmodel:SetColor(Color(22, 30, 40))         cmodel:SetParent(self)         cmodel:SetOwner(self)         cmodel:SetMaterial("models/shiny")         matrix = Matrix()         matrix:Scale(Vector(0.4, 0.4, 4.5))         cmodel:EnableMatrix( "RenderMultiply", matrix )          cmodel:Spawn()          self.Parts[#self.Parts + 1] = cmodel     end      cmodel = ClientsideModel("models/props_trainstation/trainstation_ornament002.mdl")     if cmodel:IsValid() then         cmodel:SetPos(self:LocalToWorld(Vector(12, -12, 0)))         cmodel:SetAngles(self:LocalToWorldAngles(Angle(0, 0, 0)))         cmodel:SetSolid(SOLID_NONE)         cmodel:SetMoveType(MOVETYPE_NONE)         cmodel:SetColor(Color(22, 30, 40))         cmodel:SetParent(self)         cmodel:SetOwner(self)         cmodel:SetMaterial("models/shiny")         matrix = Matrix()         matrix:Scale(Vector(0.4, 0.4, 4.5))         cmodel:EnableMatrix( "RenderMultiply", matrix )          cmodel:Spawn()          self.Parts[#self.Parts + 1] = cmodel     end      cmodel = ClientsideModel("models/props_combine/combinethumper002.mdl")     if cmodel:IsValid() then         cmodel:SetPos(self:LocalToWorld(Vector(-12, 7, 0)))         cmodel:SetAngles(self:LocalToWorldAngles(Angle(0, 45, 0)))         cmodel:SetSolid(SOLID_NONE)         cmodel:SetMoveType(MOVETYPE_NONE)         cmodel:SetColor(Color(52, 60, 90))         cmodel:SetParent(self)         cmodel:SetOwner(self)         matrix = Matrix()         matrix:Scale(Vector(0.5, 0.8, 0.2))         cmodel:EnableMatrix( "RenderMultiply", matrix )          cmodel:Spawn()          self.Parts[#self.Parts + 1] = cmodel     end      cmodel = ClientsideModel("models/props_lab/eyescanner.mdl")     if cmodel:IsValid() then         cmodel:SetPos(self:LocalToWorld(Vector(-2, -8, 10)))         cmodel:SetAngles(self:LocalToWorldAngles(Angle(0, -135, 0)))         cmodel:SetSolid(SOLID_NONE)         cmodel:SetMoveType(MOVETYPE_NONE)         cmodel:SetColor(Color(30, 40, 80))         cmodel:SetParent(self)         cmodel:SetOwner(self)         matrix = Matrix()         matrix:Scale(Vector(1.6, 1.6, 1.6))         cmodel:EnableMatrix( "RenderMultiply", matrix )          cmodel:Spawn()          self.Parts[#self.Parts + 1] = cmodel     end end  function ENT:InitElderGodsLockbox()     local cmodel = ClientsideModel("models/props_phx/construct/metal_tube.mdl")     if cmodel:IsValid() then         cmodel:SetPos(self:LocalToWorld(Vector(0, 0, 0)))         cmodel:SetAngles(self:LocalToWorldAngles(Angle(0, 0, 0)))         cmodel:SetSolid(SOLID_NONE)         cmodel:SetMoveType(MOVETYPE_NONE)         cmodel:SetColor(Color(35, 31, 60))         cmodel:SetParent(self)         cmodel:SetOwner(self)         cmodel:SetMaterial("models/props_pipes/guttermetal01a")         matrix = Matrix()         matrix:Scale(Vector(1, 1, 1))         cmodel:EnableMatrix( "RenderMultiply", matrix )          cmodel:Spawn()          self.Parts[#self.Parts + 1] = cmodel     end      cmodel = ClientsideModel("models/props_phx/construct/metal_plate1.mdl")     if cmodel:IsValid() then         cmodel:SetPos(self:LocalToWorld(Vector(0, 0, 48)))         cmodel:SetAngles(self:LocalToWorldAngles(Angle(0, 0, 0)))         cmodel:SetSolid(SOLID_NONE)         cmodel:SetMoveType(MOVETYPE_NONE)         cmodel:SetColor(Color(65, 31, 20))         cmodel:SetParent(self)         cmodel:SetOwner(self)         cmodel:SetMaterial("models/props_pipes/guttermetal01a")         matrix = Matrix()         matrix:Scale(Vector(1, 1, 0.4))         cmodel:EnableMatrix( "RenderMultiply", matrix )          cmodel:Spawn()          self.Parts[#self.Parts + 1] = cmodel     end      cmodel = ClientsideModel("models/hunter/blocks/cube025x025x025.mdl")     if cmodel:IsValid() then         cmodel:SetPos(self:LocalToWorld(Vector(12, 12, 80)))         cmodel:SetAngles(self:LocalToWorldAngles(Angle(0, 0, 0)))         cmodel:SetSolid(SOLID_NONE)         cmodel:SetMoveType(MOVETYPE_NONE)         cmodel:SetColor(Color(65, 31, 65))         cmodel:SetParent(self)         cmodel:SetOwner(self)         cmodel:SetMaterial("models/props_pipes/guttermetal01a")         matrix = Matrix()         matrix:Scale(Vector(0.5, 0.5, 0.5))         cmodel:EnableMatrix( "RenderMultiply", matrix )          cmodel:Spawn()          self.Parts[#self.Parts + 1] = cmodel     end      cmodel = ClientsideModel("models/hunter/blocks/cube025x025x025.mdl")     if cmodel:IsValid() then         cmodel:SetPos(self:LocalToWorld(Vector(-12, -12, 64)))         cmodel:SetAngles(self:LocalToWorldAngles(Angle(0, 0, 0)))         cmodel:SetSolid(SOLID_NONE)         cmodel:SetMoveType(MOVETYPE_NONE)         cmodel:SetColor(Color(65, 31, 65))         cmodel:SetParent(self)         cmodel:SetOwner(self)         cmodel:SetMaterial("models/props_pipes/guttermetal01a")         matrix = Matrix()         matrix:Scale(Vector(0.5, 0.5, 0.5))         cmodel:EnableMatrix( "RenderMultiply", matrix )          cmodel:Spawn()          self.Parts[#self.Parts + 1] = cmodel     end      cmodel = ClientsideModel("models/props_phx/construct/metal_plate1.mdl")     if cmodel:IsValid() then         cmodel:SetPos(self:LocalToWorld(Vector(0, 0, 40)))         cmodel:SetAngles(self:LocalToWorldAngles(Angle(0, 0, 0)))         cmodel:SetSolid(SOLID_NONE)         cmodel:SetMoveType(MOVETYPE_NONE)         cmodel:SetColor(Color(11, 11, 11))         cmodel:SetParent(self)         cmodel:SetOwner(self)         cmodel:SetMaterial("models/props_c17/FurnitureMetal001a")         matrix = Matrix()         matrix:Scale(Vector(0.9, 0.9, 0.4))         cmodel:EnableMatrix( "RenderMultiply", matrix )          cmodel:Spawn()          self.Parts[#self.Parts + 1] = cmodel     end      for i = 1, 4 do         local vec_base = Vector(0, 0, 0)          local spread = 22.5          vec_base.x = i % 2 == 0 and spread or -spread         vec_base.y = (i == 1 or i == 2) and -spread or spread          cmodel = ClientsideModel("models/props_trainstation/trainstation_post001.mdl")         if cmodel:IsValid() then             cmodel:SetPos(self:LocalToWorld(vec_base))             cmodel:SetAngles(self:LocalToWorldAngles(Angle(0, 0, 0)))             cmodel:SetSolid(SOLID_NONE)             cmodel:SetMoveType(MOVETYPE_NONE)             cmodel:SetColor(Color(50, 40, 60))             cmodel:SetParent(self)             cmodel:SetOwner(self)             cmodel:SetMaterial("phoenix_storms/cube")             matrix = Matrix()             matrix:Scale(Vector(1, 1, 0.83))             cmodel:EnableMatrix( "RenderMultiply", matrix )              cmodel:Spawn()              self.Parts[#self.Parts + 1] = cmodel         end     end      for i = 1, 2 do         cmodel = ClientsideModel("models/props_c17/gravestone003a.mdl")         if cmodel:IsValid() then             cmodel:SetPos(self:LocalToWorld(Vector(0, i == 1 and 23 or -23, 22)))             cmodel:SetAngles(self:LocalToWorldAngles(Angle(0, 90, 0)))             cmodel:SetSolid(SOLID_NONE)             cmodel:SetMoveType(MOVETYPE_NONE)             cmodel:SetColor(Color(70, 30, 30))             cmodel:SetParent(self)             cmodel:SetOwner(self)             cmodel:SetMaterial("phoenix_storms/bluemetal")             matrix = Matrix()             matrix:Scale(Vector(1, 1.1, 1.1))             cmodel:EnableMatrix( "RenderMultiply", matrix )              cmodel:Spawn()              self.Parts[#self.Parts + 1] = cmodel         end     end end  function ENT:InitBloodCrucible()     local cmodel = ClientsideModel("models/props_c17/fountain_01.mdl")     if cmodel:IsValid() then         cmodel:SetPos(self:LocalToWorld(Vector(0, 0, 0)))         cmodel:SetAngles(self:LocalToWorldAngles(Angle(0, 0, 0)))         cmodel:SetSolid(SOLID_NONE)         cmodel:SetMoveType(MOVETYPE_NONE)         cmodel:SetColor(Color(50, 61, 50))         cmodel:SetParent(self)         cmodel:SetOwner(self)         cmodel:SetMaterial("models/props_pipes/guttermetal01a")         matrix = Matrix()         matrix:Scale(Vector(0.45, 0.45, 0.4))         cmodel:EnableMatrix( "RenderMultiply", matrix )          cmodel:Spawn()          self.Parts[#self.Parts + 1] = cmodel     end      cmodel = ClientsideModel("models/props_phx/construct/metal_angle360.mdl")     if cmodel:IsValid() then         cmodel:SetPos(self:LocalToWorld(Vector(0, 0, 50.35)))         cmodel:SetAngles(self:LocalToWorldAngles(Angle(0, 0, 0)))         cmodel:SetSolid(SOLID_NONE)         cmodel:SetMoveType(MOVETYPE_NONE)         cmodel:SetColor(Color(180, 10, 20))         cmodel:SetParent(self)         cmodel:SetOwner(self)         cmodel:SetMaterial("models/antlion/antlion_innards")         matrix = Matrix()         matrix:Scale(Vector(0.5, 0.5, 0.1))         cmodel:EnableMatrix( "RenderMultiply", matrix )          cmodel:Spawn()          self.Parts[#self.Parts + 1] = cmodel     end      for i = 1, 4 do         local vec_base = Vector(0, 0, -10)          local spread = 34.5          vec_base.x = i == 2 and spread or i == 4 and -spread or 0         vec_base.y = i == 1 and spread or i == 3 and -spread or 0          cmodel = ClientsideModel("models/props_c17/pottery07a.mdl")         if cmodel:IsValid() then             cmodel:SetPos(self:LocalToWorld(vec_base))             cmodel:SetAngles(self:LocalToWorldAngles(Angle(0, i % 2 == 0 and 0 or 90, 0)))             cmodel:SetSolid(SOLID_NONE)             cmodel:SetMoveType(MOVETYPE_NONE)             cmodel:SetColor(Color(60, 70, 60))             cmodel:SetParent(self)             cmodel:SetOwner(self)             cmodel:SetMaterial("models/props_pipes/guttermetal01a")             matrix = Matrix()             matrix:Scale(Vector(0.7, 0.7, 2.65))             cmodel:EnableMatrix( "RenderMultiply", matrix )              cmodel:Spawn()              self.Parts[#self.Parts + 1] = cmodel         end     end end  local matLightning = Material("trails/electric") function ENT:DrawArkOfAdonis()     if #self.Parts == 0 then         self:InitArkOfAdonisParts()          self.AmbientSound2 = CreateSound(self, "ambient/machines/combine_shield_touch_loop1.wav")     end      local r = math.random(-2, 2)      local pos1 = self:LocalToWorld(Vector(-12, 12, 100 + r)) + VectorRand() * 1     local pos2 = self:LocalToWorld(Vector(12, -12, 100 + r)) + VectorRand() * 1      render.SetMaterial(matLightning)     render.DrawBeam(pos1, pos2, 3, 0, 8, COLOR_PURPLE)     render.DrawBeam(pos1, pos2, 24, 0, 2, Color(200, 0, 200, 40)) end  local rot_value = 0 local ang = Angle(0, 0, 0) function ENT:DrawElderGodsLockbox()     if #self.Parts == 0 then         self:InitElderGodsLockbox()          self.AmbientSound2 = CreateSound(self, "ambient/atmosphere/corridor.wav")     end      local top = self.Parts[2]      local speed = rot_value % 90      rot_value = rot_value + FrameTime() * (0.1 + speed * 3)      ang.y = rot_value     top:SetAngles(self:LocalToWorldAngles(ang))      local cube_one = self.Parts[3]     local cube_two = self.Parts[4]      local cube_pos_one = self:LocalToWorld(Vector(12, 12, 80 + math.sin(CurTime()) * 10))     local cube_pos_two = self:LocalToWorld(Vector(-12, -12, 72 + math.cos(CurTime()) * 10))      cube_one:SetPos(cube_pos_one)     cube_two:SetPos(cube_pos_two)      local emitter = ParticleEmitter(self:GetPos())     emitter:SetNearClip(24, 32)      for i = 1, 2 do         local part_pos = i == 1 and cube_pos_one or cube_pos_two          for j = 1, 5 do             local particle = emitter:Add("effects/fire_embers"..math.random(1, 3), part_pos + VectorRand())             particle:SetDieTime(math.Rand(0.6, 0.7))             particle:SetStartSize(1)             particle:SetEndSize(math.random(4, 7))             particle:SetStartAlpha(255)             particle:SetEndAlpha(0)             particle:SetGravity(Vector(0, 0, 50))             particle:SetRoll(math.Rand(0, 360))             particle:SetStartLength(1)             particle:SetEndLength(math.random(3, 5))             particle:SetColor(55, 255, 155)             particle:SetRollDelta(math.Rand(-1.5, 1.5))         end     end      emitter:Finish() end  local vec_flame = Vector(0, 0, 58) function ENT:DrawBloodCrucible()     if #self.Parts == 0 then         self:InitBloodCrucible()          self.AmbientSound2 = CreateSound(self, "ambient/fire/fire_med_loop1.wav")     end      local pos = self:GetPos()      for i = 1, 4 do         local spread = 34.5          vec_flame.x = i == 2 and spread or i == 4 and -spread or 0         vec_flame.y = i == 1 and spread or i == 3 and -spread or 0          local emitter = ParticleEmitter(pos)         emitter:SetNearClip(24, 32)          for j = 1, 10 do             local particle = emitter:Add("effects/fire_embers"..math.random(1, 3), pos + vec_flame + VectorRand())             particle:SetDieTime(math.Rand(0.4, 0.5))             particle:SetStartSize(1)             particle:SetEndSize(math.random(4, 7))             particle:SetStartAlpha(255)             particle:SetEndAlpha(0)             particle:SetGravity(Vector(0, 0, 60))             particle:SetRoll(math.Rand(0, 360))             particle:SetStartLength(4)             particle:SetEndLength(math.random(5, 12))             particle:SetColor(255, 255, 160)             particle:SetRollDelta(math.Rand(-1.5, 1.5))         end          emitter:Finish()     end end