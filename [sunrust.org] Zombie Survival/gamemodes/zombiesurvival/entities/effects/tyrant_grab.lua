EFFECT.LifeTime = 1.2 EFFECT.Offsets = {} EFFECT.Chain = {}    EFFECT.ChainBits = 15  function EFFECT:Init(data)   self.Ent = data:GetEntity()  self.EntOwner = Entity( math.Round( data:GetRadius() ) )    self.DieTime = RealTime() + self.LifeTime    self:SetModel( "models/props_wasteland/rockgranite03a.mdl" )  self:SetModelScale( 0.3, 0 )  self:SetMaterial("!sigil_blue")    if self.Ent and self.Ent:IsValid() then  self:SetParent( self.Ent )  self.Ent:EmitSound( "physics/concrete/boulder_impact_hard"..math.random(4)..".wav", 70, math.random( 120, 130 ) )  end    for i=1, 10 do   local vec_r = VectorRand() * math.random( 45, 60 )  vec_r.z = math.random( -25, 20 )  self.Offsets[ i ] = { vec =  vec_r, ang = VectorRand():Angle(), scale = math.Rand(0.3, 0.5) }  end    for i=1, self.ChainBits do   local vec_r = VectorRand() * math.random( 10, 80 )  self.Chain[ i ] = { vec =  vec_r, ang = VectorRand():Angle(), scale = math.Rand(0.07, 0.3) }  end    end  function EFFECT:Think()  return RealTime() < self.DieTime end   local vec_up = vector_up function EFFECT:Render()    if self.Ent and self.Ent:IsValid() and self.EntOwner and self.EntOwner:IsValid() and self.Offsets and self.Chain then    local origin = self.Ent:LocalToWorld( self.Ent:OBBCenter() )  local origin_owner = self.EntOwner:GetShootPos()    self:SetRenderBoundsWS( origin, origin_owner )     local pos, ang = self.EntOwner:GetBonePosition( 16 )  if pos and ang then  origin_owner = pos  end    local delta = math.Clamp( ( self.DieTime - RealTime() ) / self.LifeTime, 0, 1 )  local reverse_delta = 1 - delta    for i=1, 10 do    if self.Offsets[ i ] then    local tbl = self.Offsets[ i ]    self:SetupBones()    local new_vec = tbl.vec * math.Clamp( delta ^ 10, 0.15, 1 )  new_vec.z = tbl.vec.z    self:SetPos( origin + new_vec )  self:SetAngles( tbl.ang )  self:SetModelScale( tbl.scale * ( 1 - delta ^ 10 )  )    render.SetBlend( delta <= 0.1 and ( delta/0.1 ) or 1 )  self:DrawModel()  render.SetBlend(1)  end    end       local dist = origin:Distance( origin_owner )  local normal = ( origin - origin_owner ):GetNormal()    for i=1, self.ChainBits do    local tbl = self.Chain[ i ]    self:SetupBones()    local new_vec = tbl.vec * math.Clamp( delta ^ i, 0.15, 1 )  local pos = origin_owner + normal * ( i * dist / self.ChainBits )    self:SetPos( pos + new_vec )  self:SetAngles( tbl.ang )  self:SetModelScale( tbl.scale * ( 1 - delta ^ i )  )    render.SetBlend( delta <= 0.1 and ( delta/0.1 ) or 1 )  self:DrawModel()  render.SetBlend(1)  end   end   end