ENT.Type = "anim" ENT.Base = "prop_baseoutlined"  ENT.NoNails = true  function ENT:HumanHoldable(pl)  return pl:KeyDown(GAMEMODE.UtilityKey) end  function ENT:SetInventoryItemType(type, level)  local invdata = GAMEMODE.ZSInventoryItemData[type]   if not invdata then return end  local droppedeles = invdata.DroppedEles      self:SetModel(istable(droppedeles) and "models/weapons/w_grenade.mdl" or droppedeles)  self:PhysicsInit(SOLID_VPHYSICS)   self:SetDTString(0, type)  self:SetDTInt(0, level or 0)   return true end  function ENT:GetInventoryItemType()  return self:GetDTString(0) end  function ENT:GetInventoryItemLevel()  return self:GetDTInt(0) end