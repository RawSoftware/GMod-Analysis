local PANEL = {}  PANEL.StatusPanels = {}  function PANEL:Init()     self:DockMargin(0, 0, 0, 0)     self:DockPadding(0, 0, 0, 0)      self.StatusPanels = {}      for _, statusdisp in pairs(GAMEMODE.StatusDisplays) do         status = vgui.Create("ZSStatus", self)         status:SetAlpha(240)         status:SetColor(statusdisp.Color)         status:SetMemberName(statusdisp.Name)         status.GetMemberValue = statusdisp.ValFunc         status.MemberMaxValue = statusdisp.Max         status.Icon = statusdisp.Icon         status.GetSecondaryValue = statusdisp.Secondary         status:Dock(LEFT)          table.insert(self.StatusPanels, status)     end      self:ParentToHUD()     self:InvalidateLayout() end  function PANEL:PerformLayout()     local w = 0     for _, child in pairs(self:GetChildren()) do         w = w + child:GetWide()     end      self:SetSize(w, BetterScreenScale() * 400)      self:AlignLeft(math.max(0, ScrW() * GAMEMODE.StatusBarX))     self:CenterVertical(GAMEMODE.StatusBarY) end  function PANEL:Think()     if MySelf then         for _, panel in pairs(self.StatusPanels) do             panel:StatusThink(MySelf)         end     end end  vgui.Register("ZSStatusArea", PANEL, "Panel")  PANEL = {}  PANEL.MemberValue = 0 PANEL.LerpMemberValue = 0 PANEL.MemberMaxValue = 100 PANEL.NextStatusThink = 0 PANEL.MemberName = "Unnamed"  function PANEL:SetColor(col) self.m_Color = col end function PANEL:GetColor() return self.m_Color end function PANEL:SetMemberName(n) self.MemberName = n end function PANEL:GetMemberName() return self.MemberName end  function PANEL:Init()     self:SetColor(Color(255, 255, 255))     self:SetTall(BetterScreenScale() * 68)     self:SetWide(BetterScreenScale() * 50) end  local P_Meta = FindMetaTable("Panel") local P_GetTable = P_Meta.GetTable  function PANEL:StatusThink(lp)     local p_tb = P_GetTable(self)      if p_tb.NextStatusThink >= CurTime() then return end     if p_tb.LerpMemberValue <= 0 then         p_tb.NextStatusThink = CurTime() + 0.25     end      if p_tb.GetMemberValue then         p_tb.MemberValue = self:GetMemberValue(lp) or p_tb.MemberValue     end     if p_tb.GetMemberMaxValue then         p_tb.MemberMaxValue = self:GetMemberMaxValue(lp) or p_tb.MemberMaxValue     end      if p_tb.GetSecondaryValue then         p_tb.SecondaryValue = self:GetSecondaryValue(lp)     end      if p_tb.MemberValue > p_tb.LerpMemberValue then         p_tb.LerpMemberValue = p_tb.MemberValue     elseif p_tb.MemberValue < p_tb.LerpMemberValue then         p_tb.LerpMemberValue = math.Approach(p_tb.LerpMemberValue, p_tb.MemberValue, FrameTime() * 30)     end      if p_tb.MemberValue < 0.1 and self:GetWide() ~= 0 then         self:SetWide(0)         self:GetParent():InvalidateLayout()     elseif p_tb.MemberValue > 0.1 and self:GetWide() == 0 then         self:SetWide(BetterScreenScale() * 50)         self:GetParent():InvalidateLayout()     end end  local texDownEdge = surface.GetTextureID("gui/gradient_down") function PANEL:Paint(w, h)     local value = self.LerpMemberValue     if value <= 0 then return end      local col = self:GetColor()     local max = self.MemberMaxValue      local y = 0      y = y + draw.GetFontHeight("ZSBodyTextFont")     h = h - y      local boxsize = 42 * BetterScreenScale()      surface.SetDrawColor(col.r * 0.8, col.g * 0.8, col.b * 0.8, col.a * 0.75)     surface.SetTexture(texDownEdge)     surface.DrawTexturedRect(w/2 - boxsize/2, h/2 - boxsize/2, boxsize, boxsize)     surface.SetDrawColor(col.r * 0.8, col.g * 0.8, col.b * 0.8, col.a * 0.3)     surface.DrawRect(w/2 - boxsize/2, h/2 - boxsize/2, boxsize, boxsize)      local perc = function(add) return math.Clamp((value - max * add) / (max * 0.25), 0, 1) end      if self.Icon then         surface.SetMaterial(self.Icon)         surface.SetDrawColor(col.r * 0.6 + 100, col.g * 0.6 + 100, col.b * 0.6 + 100, col.a * 0.8)         surface.DrawTexturedRect(w/2 - boxsize/2, h/2 - boxsize/2, boxsize, boxsize)     end      surface.SetDrawColor(col)     surface.DrawRect(         w/2 + boxsize/2,         h/2 + boxsize/2 - (boxsize + 2) * perc(0.75),         2,         math.ceil((boxsize + 2) * perc(0.75))     )     surface.DrawRect(         w/2 - boxsize/2,         h/2 + boxsize/2,         (boxsize + 2) * perc(0.5),         2     )     surface.DrawRect(         w/2 - boxsize/2 - 2,         h/2 - boxsize/2,         2,         (boxsize + 2) * perc(0.25)     )     surface.DrawRect(         w/2 + boxsize/2 + 2 - (boxsize + 4) * perc(0),         h/2 - boxsize/2 - 2,         math.ceil((boxsize + 2) * perc(0)),         2     )      local t1 = math.ceil(value)     draw.SimpleText(t1, "ZSHUDFontSmall", w / 2, y + h / 2 - boxsize/2 + 5, color_white_alpha230, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)      if GAMEMODE.StatusShortName then         local short_name = string.upper(string.sub(self.MemberName, 0, 4))         draw.SimpleText(short_name, "ZSHUDFontSmallest", w / 2, y + h / 2 + boxsize/2.35, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)     end      if self.SecondaryValue then         draw.SimpleText(self.SecondaryValue, "ZSHUDFontSmaller", w / 2, y + h / 2 - boxsize, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)     end end  vgui.Register("ZSStatus", PANEL, "Panel") 