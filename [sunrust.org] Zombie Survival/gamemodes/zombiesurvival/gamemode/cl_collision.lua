local List_CollisionGroups = {} local List_CollisionFlags = {} local NW2VarFunc = {     ["f"] = function(e,x) List_CollisionFlags[e] = x end,     ["g"] = function(e,x) List_CollisionGroups[e] = x end,     ["l"] = function(e,x) e:Turn_FL(x == true) end, } function GM:EntityNetworkedVarChanged(ent, name, oldval, newval)     local f = NW2VarFunc[name]     if f then         f(ent,newval)     end end  local vec = Vector local ScanRadius = 256 local bit_band = bit.band local timer_Create = timer.Create local trace_mask = CONTENTS_EMPTY local util_TraceHull = util.TraceHull local flag = DT_PLAYER_AND_ENTITY_INT_COLLISION_FLAG local group = DT_PLAYER_AND_ENTITY_INT_COLLISION_GROUP local tr_sc = {ignoreworld = true, mask = trace_mask, mins = -vec(ScanRadius, ScanRadius, ScanRadius), maxs = vec(ScanRadius, ScanRadius, ScanRadius)} local function UpdateCollisionFilter(ent)     if IsValid(ent) and (ent:IsPlayer() or ent:IsPhysicsProp() or ent.EntityDeployable) then                   if rawget(List_CollisionGroups, ent) ~= ent:GetDTInt(group) then             List_CollisionGroups[ent] = ent:GetDTInt(group)         elseif rawget(List_CollisionFlags, ent) ~= ent:GetDTInt(flag) then             List_CollisionFlags[ent] = ent:GetDTInt(flag)         end     end end  timer_Create("ZS_UpdateCollisionClient", 2, 0, function()     if IsValid(MySelf) then         tr_sc.start = MySelf:GetPos()         tr_sc.endpos = MySelf:GetPos()         tr_sc.filter = UpdateCollisionFilter          util_TraceHull(tr_sc)     end end)  function GM:ShouldCollide(enta, entb)  local ga, gb, fa, fb = rawget(List_CollisionGroups, enta), rawget(List_CollisionGroups, entb), rawget(List_CollisionFlags, enta), rawget(List_CollisionFlags, entb)  return not ga or not gb or not fa or not fb or bit_band(ga, fb) ~= 0 or bit_band(gb, fa) ~= 0 end