local meta = FindMetaTable("Weapon")  function meta:DrawWeaponCrosshair()  if GetConVar("crosshair"):GetInt() ~= 1 then return end   self:DrawCrosshairCross()  self:DrawCrosshairDot() end  local ironsightscrosshair = CreateClientConVar("zs_ironsightscrosshair", "0", true, false):GetBool() cvars.AddChangeCallback("zs_ironsightscrosshair", function(cvar, oldvalue, newvalue)  ironsightscrosshair = tonumber(newvalue) == 1 end)    local matGrad = Material("VGUI/gradient-r") local function DrawLine(x, y, rot)  local thickness = GAMEMODE.CrosshairThickness  local length = GAMEMODE.CrosshairLength   rot = 270 - rot  surface.SetMaterial(matGrad)  surface.SetDrawColor(0, 0, 0, GAMEMODE.CrosshairColor.a)  surface.DrawTexturedRectRotated(x, y, 14 * length, math.max(4 * thickness, 2 + 2 * thickness), rot)  surface.SetDrawColor(GAMEMODE.CrosshairColor)  surface.DrawTexturedRectRotated(x, y, 12 * length, 2 * thickness, rot) end  local baserot = 0 function meta:DrawCrosshairCross()  local x = ScrW() * 0.5  local y = ScrH() * 0.5   local ironsights = self.GetIronsights and self:GetIronsights()   local cone = GAMEMODE.FixedCrosshair and 0.4 or self:GetCone()   if cone <= 0 or ironsights and not ironsightscrosshair then return end   cone = ScrH() * 0.0003125 * cone  cone = cone * 90 / (GAMEMODE.FixedCrosshair and 90 or MySelf:GetFOV())  local midarea = 40 * cone   baserot = GAMEMODE.CrosshairOffset   local ang = Angle(0, 0, baserot)  for i=0, 359, 360 / GAMEMODE.CrosshairLines do  ang.roll = baserot + i  local p = ang:Up() * (midarea + (GAMEMODE.CrosshairSpacing or 0))  DrawLine(math.Round(x + p.y), math.Round(y + p.z), ang.roll)  end end  function meta:DrawCrosshairDot()  local x = ScrW() * 0.5  local y = ScrH() * 0.5  local thickness = GAMEMODE.CrosshairThickness  local size = 4 * thickness  local hsize = size/2   surface.SetDrawColor(GAMEMODE.CrosshairColor2)  surface.DrawRect(x - hsize, y - hsize, size, size)  surface.SetDrawColor(0, 0, 0, GAMEMODE.CrosshairColor2.a)  surface.DrawOutlinedRect(x - hsize, y - hsize, size, size)   if GAMEMODE.LastOTSBlocked and MySelf:Team() == TEAM_HUMAN and GAMEMODE:UseOverTheShoulder() then  GAMEMODE:DrawCircle(x, y, 8, COLOR_RED)  end end  local matScope = Material("zombiesurvival/scope") function meta:DrawRegularScope()  local scrw, scrh = ScrW(), ScrH()  local size = math.min(scrw, scrh)  surface.SetMaterial(matScope)  surface.SetDrawColor(255, 255, 255, 255)  surface.DrawTexturedRect((scrw - size) * 0.5, (scrh - size) * 0.5, size, size)  surface.SetDrawColor(0, 0, 0, 255)  if scrw > size then  local extra = (scrw - size) * 0.5  surface.DrawRect(0, 0, extra, scrh)  surface.DrawRect(scrw - extra, 0, extra, scrh)  end  if scrh > size then  local extra = (scrh - size) * 0.5  surface.DrawRect(0, 0, scrw, extra)  surface.DrawRect(0, scrh - extra, scrw, extra)  end end  local texGradientU = Material("vgui/gradient-u") local texGradientD = Material("vgui/gradient-d") local texGradientR = Material("vgui/gradient-r") function meta:DrawFuturisticScope()  local scrw, scrh = ScrW(), ScrH()  local size = math.min(scrw, scrh)  local hw,hh = scrw * 0.5, scrh * 0.5  local screenscale = BetterScreenScale()  local gradsize = math.ceil(size * 0.14)  local line = 38 * screenscale   for i=0,6 do  local rectsize = math.floor(screenscale * 44) + i * math.floor(130 * screenscale)  local hrectsize = rectsize * 0.5  surface.SetDrawColor(0,145,255,math.max(35,25 + i * 30)/2)  surface.DrawOutlinedRect(hw-hrectsize,hh-hrectsize,rectsize,rectsize)  end  if scrw > size then  local extra = (scrw - size) * 0.5  for i=0,12 do  surface.SetDrawColor(0,145,255, math.max(10,255 - i * 21.25)/2)  surface.DrawLine(hw,i*line,hw,i*line+line)  surface.DrawLine(hw,scrh-i*line,hw,scrh-i*line-line)  surface.DrawLine(i*line+extra,hh,i*line+line+extra,hh)  surface.DrawLine(scrw-i*line-extra,hh,scrw-i*line-line-extra,hh)  end  surface.SetDrawColor(0, 0, 0, 255)  surface.DrawRect(0, 0, extra, scrh)  surface.DrawRect(scrw - extra, 0, extra, scrh)  end  if scrh > size then  local extra = (scrh - size) * 0.5  for i=0,12 do  surface.SetDrawColor(0,145,255, math.max(10,255 - i * 21.25)/2)  surface.DrawLine(hw,i*line+extra,hw,i*line+line+extra)  surface.DrawLine(hw,scrh-i*line-extra,hw,scrh-i*line-line-extra)  surface.DrawLine(i*line,hh,i*line+line,hh)  surface.DrawLine(scrw-i*line,hh,scrw-i*line-line,hh)  end  surface.SetDrawColor(0, 0, 0, 255)  surface.DrawRect(0, 0, scrw, extra)  surface.DrawRect(0, scrh - extra, scrw, extra)  end   surface.SetMaterial(texGradientU)  surface.SetDrawColor(0,0,0,255)  surface.DrawTexturedRect((scrw - size) * 0.5, (scrh - size) * 0.5, size, gradsize)  surface.SetMaterial(texGradientD)  surface.DrawTexturedRect((scrw - size) * 0.5, scrh - (scrh - size) * 0.5 - gradsize, size, gradsize)  surface.SetMaterial(texGradientR)  surface.DrawTexturedRect(scrw - (scrw - size) * 0.5 - gradsize, (scrh - size) * 0.5, gradsize, size)  surface.DrawTexturedRectRotated((scrw - size) * 0.5 + gradsize / 2, (scrh - size) * 0.5 + size / 2, gradsize, size, 180) end  function meta:BaseDrawWeaponSelection(x, y, wide, tall, alpha)  local ammotype1 = self:ValidPrimaryAmmo()  local ammotype2 = self:ValidSecondaryAmmo()         local ki = killicon.Get(self:GetClass())  local cols = ki and ki[#ki] or ""   if ki and #ki == 3 then  draw.SimpleText(ki[2], ki[1] .. "ws", x + wide * 0.5, y + tall * 0.5 + 18 * BetterScreenScale(), Color(cols.r, cols.g, cols.b, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)  elseif ki then  local material = Material(ki[1])  local wid, hei = material:Width(), material:Height()   surface.SetMaterial(material)  surface.SetDrawColor(cols.r, cols.g, cols.b, alpha )  surface.DrawTexturedRect(x + wide * 0.5 - wid * 0.5, y + tall * 0.5 - hei * 0.5, wid, hei)  end   draw.SimpleTextBlur(self:GetPrintName(), "ZSHUDFontSmaller", x + wide * 0.5, y + tall * 0.15, COLOR_RED, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)   if ammotype1 then  local total = self:GetPrimaryAmmoCount()  local inclip = self:Clip1()  if inclip >= 0 then  if self.Primary and self.Primary.ClipSize and self.Primary.ClipSize == 1 then  draw.SimpleTextBlur("["..total.."]", "ZSHUDFontSmaller", x + wide * 0.05, y + tall * 0.8, total == 0 and COLOR_RED or color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM_REAL)  else  draw.SimpleTextBlur("["..inclip.." / ".. total - inclip .."]", "ZSHUDFontSmaller", x + wide * 0.05, y + tall * 0.8, total == 0 and COLOR_RED or inclip == 0 and COLOR_YELLOW or color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM_REAL)  end  end  end   if ammotype2 then  local total = self:GetSecondaryAmmoCount()  local inclip = self:Clip2()  if inclip >= 0 then  if self.Secondary and self.Secondary.ClipSize and self.Secondary.ClipSize == 1 then  draw.SimpleTextBlur("["..total.."]", "ZSHUDFontSmaller", x + wide * 0.95, y + tall * 0.8, total == 0 and COLOR_RED or color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM_REAL)  else  draw.SimpleTextBlur("["..inclip.." / ".. total - inclip .."]", "ZSHUDFontSmaller", x + wide * 0.95, y + tall * 0.8, total == 0 and COLOR_RED or inclip == 0 and COLOR_YELLOW or color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM_REAL)  end  end  end   return true end  local function empty() end function meta:HideWorldModel()  self:DrawShadow(false)  self.DrawWorldModel = empty  self.DrawWorldModelTranslucent = empty end  local function HiddenViewModel(self, pos, ang)  return pos + ang:Forward() * -256, ang end function meta:HideViewModel()  self.GetViewModelPosition = HiddenViewModel end  function meta:SaveAsSCKFile(text)  local wep = self  if text == "" then return end   local save_data = {}      save_data.v_models = table.Copy(wep.VElements)  save_data.w_models = table.Copy(wep.WElements)  save_data.v_bonemods = table.Copy(wep.ViewModelBoneMods)  save_data.ViewModelFlip = wep.ViewModelFlip  save_data.ViewModel = wep.ViewModel  save_data.CurWorldModel = wep.WorldModel  save_data.ViewModelFOV = wep.ViewModelFOV  save_data.HoldType = wep.HoldType  save_data.IronSightsEnabled = true  save_data.IronSightsPos, save_data.IronSightsAng = wep.IronSightsPos, wep.IronSightsAng  save_data.ShowViewModel = wep.ShowViewModel  save_data.ShowWorldModel = wep.ShowWorldModel   local filename = "swep_construction_kit/"..text..".txt"   local succ, val = pcall(glon.encode, save_data)  if (not succ or not val) then LocalPlayer():ChatPrint("Failed to encode settings!") return end   file.Write(filename, val)  LocalPlayer():ChatPrint("Saved file \""..text.."\"!") end   function CustomBoneMerge(ent, bonecount, bone_table)  if not bone_table then return end   local pl = ent:GetParent()   if pl and pl:IsValid() then   for i=0, bonecount do   local name = ent:GetBoneName( i )   if not name then continue end   if bone_table[ name ] then   local v = bone_table[ name ]   local bone = i  local bone_pl = pl:LookupBone( v.bone )   if bone and bone_pl then   local m = ent:GetBoneMatrix( bone )  local m_pl = pl:GetBoneMatrix( bone_pl )   if m and m_pl then   m:SetTranslation( m_pl:GetTranslation() )  m:SetAngles( m_pl:GetAngles() )   if v.add then  m:Translate( v.add )  end  if v.rot then  m:Rotate( v.rot )  end  if v.sc then  m:SetScale( v.sc )  end   ent:SetBoneMatrix( bone, m )   for _, ch in pairs( ent:GetChildBones( bone ) ) do   local ch_name = ent:GetBoneName( ch )   if not bone_table[ ch_name ] then   local m2 = ent:GetBoneMatrix( ch )  if m2 then  m2:SetTranslation( m:GetTranslation() )  m2:SetAngles( m:GetAngles() )  ent:SetBoneMatrix( ch, m2 )  end  end   end   end   end  else   local m = ent:GetBoneMatrix( i )  local m_p = ent:GetBoneMatrix( ent:GetBoneParent( i ) )  if m then  if m_p then  m:SetTranslation( m_p:GetTranslation() )  m:SetAngles( m_p:GetAngles() )  ent:SetBoneMatrix( i, m )  else   m:SetScale( vector_origin )  ent:SetBoneMatrix( i, m )   end  end   end  end  end end  function CustomBoneMergeMatching(ent, bonecount, adjustments_table)   local pl = ent:GetParent()   if pl and pl:IsValid() then   for i=0, bonecount do   local name = ent:GetBoneName( i )   if not name then continue end   local bone = i  local bone_pl = pl:LookupBone( name )   if bone then   local m = ent:GetBoneMatrix( bone )   if bone_pl then   local m_pl = pl:GetBoneMatrix( bone_pl )   if m and m_pl then   m:SetTranslation( m_pl:GetTranslation() )  m:SetAngles( m_pl:GetAngles() )   if adjustments_table and adjustments_table[ name ] then   local v = adjustments_table[ name ]   if v.add then  m:Translate( v.add )  end  if v.rot then  m:Rotate( v.rot )  end  if v.sc then  m:SetScale( v.sc )  end   if v.move_to then  local m_to = ent:GetBoneMatrix( v.move_to )  if m_to then  m:SetTranslation( m_to:GetTranslation() )  end  end   end   ent:SetBoneMatrix( bone, m )   end  else   if i == 0 then   local root = pl:GetBoneMatrix( 0 )   if root then   m:SetTranslation( root:GetTranslation() )   if adjustments_table and adjustments_table[ name ] then   local v = adjustments_table[ name ]   if v.add then  m:Translate( v.add )  end  if v.rot then  m:Rotate( v.rot )  end  if v.sc then  m:SetScale( v.sc )  end   if v.move_to then  local m_to = ent:GetBoneMatrix( v.move_to )  if m_to then  m:SetTranslation( m_to:GetTranslation() )  end  end   end    ent:SetBoneMatrix( i, m )   end   else   local m_p = ent:GetBoneMatrix( ent:GetBoneParent( i ) )  if m then   if m_p then  m:SetTranslation( m_p:GetTranslation() )  m:SetAngles( m_p:GetAngles() )   if adjustments_table and adjustments_table[ name ] then   local v = adjustments_table[ name ]   if v.add then  m:Translate( v.add )  end  if v.rot then  m:Rotate( v.rot )  end  if v.sc then  m:SetScale( v.sc )  end   if v.move_to then  local m_to = ent:GetBoneMatrix( v.move_to )  if m_to then  m:SetTranslation( m_to:GetTranslation() )  end  end   end   ent:SetBoneMatrix( i, m )   else  m:SetScale( vector_origin )  ent:SetBoneMatrix( i, m )  end  end  end  end   end   end  end end