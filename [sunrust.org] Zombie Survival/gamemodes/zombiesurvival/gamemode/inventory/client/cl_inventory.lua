GM.ZSInventory = {} GM.ZSInventoryTrinketLevel = {}  INVCAT_TRINKETS = 1 INVCAT_COMPONENTS = 2  local meta = FindMetaTable("Player") function meta:GetInventoryItems()     return GAMEMODE.ZSInventory end  function meta:HasInventoryItem(item)     return GAMEMODE.ZSInventory[item] and GAMEMODE.ZSInventory[item] > 0 end  function meta:GetTrinketItemLevel(item)     return self:HasInventoryItem(item) and GAMEMODE.ZSInventoryTrinketLevel[item] end  net.Receive("zs_inventoryitem", function()     local item = net.ReadString()     local count = net.ReadInt(5)     local trinket_level = net.ReadUInt(3)      local prevcount = GAMEMODE.ZSInventory[item]             or 0     local prevlevel = GAMEMODE.ZSInventoryTrinketLevel[item] or 0      GAMEMODE.ZSInventory[item]  = count     GAMEMODE.ZSInventoryTrinketLevel[item]  = trinket_level      if GAMEMODE.InventoryMenu and GAMEMODE.InventoryMenu:IsValid() then         local itempan  = GAMEMODE.InventoryMenu.Buttons[item]          if itempan and prevlevel ~= trinket_level and count >= 1 then             itempan.Quality = trinket_level         else             if count > prevcount then                 GAMEMODE:InventoryAddGridItem(item, GAMEMODE:GetInventoryItemType(item))             else                 GAMEMODE:InventoryRemoveGridItem(item)             end         end     end      if MySelf and MySelf:IsValid() then         MySelf:ApplyTrinkets()     end end)  net.Receive("zs_wipeinventory", function()     GAMEMODE.ZSInventory = {}      if GAMEMODE.InventoryMenu and GAMEMODE.InventoryMenu:IsValid() then         GAMEMODE:InventoryWipeGrid()     end      MySelf:ApplyTrinkets() end)  local function TryCraftWithComponent(me)     net.Start("zs_trycraft")         net.WriteString(me.Item)         net.WriteString(me.WeaponCraft)     net.SendToServer() end  function GM:ShowNextTrinketInventoryInfo(viewer, sweptable, item, quality)     local screenscale = BetterScreenScale()      local next_assoc_skill = self:GetItemAssociatedSkill(item, quality + 1)     local next_skill       = next_assoc_skill.Skill      if next_skill then         local size = 384          viewer.ViewerTitleNext:SetText(next_skill and next_skill.Name)         viewer.ViewerTitleNext:MoveBelow(viewer.ViewerTitle, size * screenscale)         viewer.ViewerTitleNext:SizeToContents()         viewer.ViewerTitleNext:CenterHorizontal()         viewer.ViewerTitleNext:PerformLayout()         viewer.ViewerTitleNext:SetTextColor(self.WeaponQualityColors[quality + 1].Upg)          local desc_key_next = "Description" .. self:GetAffixOfQuality(0, quality + 1)         local desc_text_next = sweptable[desc_key_next] or ""          viewer.ViewerDescriptionNext:MoveBelow(viewer.ViewerTitleNext, 20)         viewer.ViewerDescriptionNext:SetText(desc_text_next)          viewer.NextTrinketUpg:CenterHorizontal(0.2)         viewer.NextTrinketUpg:MoveBelow(viewer.ViewerTitle, (size/1.7 + 8) * screenscale)          viewer.NextTrinketButton:CenterHorizontal(0.6)         viewer.NextTrinketButton:MoveBelow(viewer.ViewerTitle, (size/1.7 + 12) * screenscale)          viewer.NextTrinketCost:SetText(GAMEMODE:GetTrinketUpgradeScrap(sweptable, quality + 2, MySelf) .. " Scrap")         viewer.NextTrinketCost:SizeToContents()         viewer.NextTrinketCost:CenterHorizontal(0.6)         viewer.NextTrinketCost:MoveBelow(viewer.NextTrinketButton, 12 * screenscale)     end end  local function ItemPanelDoClick(self)     local item = self.Item     if not item then return end      local category, sweptable = self.Category     if category == INVCAT_WEAPONS then         sweptable = weapons.Get(item)     else         sweptable = GAMEMODE.ZSInventoryItemData[item]     end      local viewer = GAMEMODE.m_InvViewer     local screenscale = BetterScreenScale()      if self.On then         if viewer and viewer:IsValid() then             viewer:SetVisible(false)         end          self.On = false          GAMEMODE.InventoryMenu.LastClicked = nil         GAMEMODE.InventoryMenu.SelInv = false         GAMEMODE:DoAltSelectedItemUpdate()         return     else         for _, v in pairs(self:GetParent():GetChildren()) do             v.On = false         end         self.On = true          GAMEMODE.InventoryMenu.LastClicked = self         GAMEMODE.InventoryMenu.SelInv = item         GAMEMODE:DoAltSelectedItemUpdate()     end      GAMEMODE:CreateInventoryInfoViewer()      local quality     = self.Quality     local assoc_skill = GAMEMODE:GetItemAssociatedSkill(item, quality)     local skill       = assoc_skill.Skill     local item_data   = assoc_skill.ItemData      viewer = GAMEMODE.m_InvViewer     viewer.ViewerTitle:SetText(skill and skill.Name or item_data.PrintName)     viewer.ViewerTitle:SetTextColor(quality == 0 and COLOR_WHITE or GAMEMODE.WeaponQualityColors[quality].Upg)     viewer.ViewerTitle:PerformLayout()      local desc_key = "Description" .. (skill and quality and GAMEMODE:GetAffixOfQuality(0, quality) or "")     local desctext = sweptable[desc_key] or ""      viewer.ViewerDescription:SetText(desctext)      if category == INVCAT_WEAPONS then         viewer.ModelPanel:SetModel(sweptable.WorldModel)         local mins, maxs = viewer.ModelPanel.Entity:GetRenderBounds()         viewer.ModelPanel:SetCamPos(mins:Distance(maxs) * Vector(1.15, 0.75, 0.5))         viewer.ModelPanel:SetLookAt((mins + maxs) / 2)         viewer.ModelBackground:SetVisible(true)          if sweptable.NoDismantle then             desctext = desctext .. "\nCannot be dismantled for scrap."         end          viewer.ViewerDescription:MoveBelow(viewer.ModelBackground, 8)         viewer.ViewerDescription:SetFont("ZSBodyTextFont")          local canammo = false         if sweptable.Primary then             local ammotype = sweptable.Primary.Ammo             if GAMEMODE.AmmoToPurchaseNames[ammotype] then                 canammo = true             end         end          if canammo and GAMEMODE.AmmoNames[string.lower(sweptable.Primary.Ammo)] then             viewer.ViewerAmmoType:SetText(GAMEMODE.AmmoNames[string.lower(sweptable.Primary.Ammo)])             viewer.ViewerAmmoType:PerformLayout()         else             viewer.ViewerAmmoType:SetText("")         end     else         viewer.ModelPanel:SetModel("")         viewer.ModelBackground:SetVisible(false)          viewer.ViewerDescription:MoveBelow(viewer.ViewerTitle, 20)         viewer.ViewerDescription:SetFont("ZSBodyTextFontBig")          viewer.ViewerAmmoType:SetText("")          local next_trinket = skill and quality <= 2          viewer.ViewerTitleNext:SetVisible(next_trinket)         viewer.ViewerDescriptionNext:SetText("")          viewer.NextTrinketUpg:SetVisible(next_trinket)         viewer.NextTrinketCost:SetVisible(next_trinket)         viewer.NextTrinketButton:SetVisible(next_trinket)         viewer.NextTrinketButton.DoClick = function() RunConsoleCommand("zs_upgraderemantle", item) end          if next_trinket then             GAMEMODE:ShowNextTrinketInventoryInfo(viewer, sweptable, item, quality)         end     end      GAMEMODE:ViewerStatBarUpdate(viewer, category ~= INVCAT_WEAPONS, sweptable)      for i = 1, 3 do         local crab, cral = viewer.m_CraftBtns[i][1], viewer.m_CraftBtns[i][2]          crab:SetVisible(false)         cral:SetVisible(false)     end      local assembles = {}     for k,v in pairs(GAMEMODE.Assemblies) do         if v[1] == item then             assembles[v[2]] = k         end     end      local count = 0     for k,v in pairs(assembles) do         count = count + 1          local crab, cral = viewer.m_CraftBtns[count][1], viewer.m_CraftBtns[count][2]         local iitype = GAMEMODE:GetInventoryItemType(k) ~= -1          crab.Item = item         crab.WeaponCraft = k         crab.DoClick = TryCraftWithComponent         crab:SetPos(viewer:GetWide() / 2 - crab:GetWide() / 2, (viewer:GetTall() - 33 * screenscale) - (count - 1) * 33 * screenscale)         crab:SetVisible(true)          cral:SetText((iitype and GAMEMODE.ZSInventoryItemData[k] or weapons.Get(k)).PrintName)         cral:SetPos(crab:GetWide() / 2 - cral:GetWide() / 2, crab:GetTall() * 0.5 - cral:GetTall() * 0.5)         cral:SetContentAlignment(5)         cral:SetVisible(true)     end      if item_data.ConsoleCommand then         count = count + 1          local crab, cral = viewer.m_CraftBtns[count][1], viewer.m_CraftBtns[count][2]          crab.DoClick = function()             RunConsoleCommand(item_data.ConsoleCommand, item)         end         crab:SetPos(viewer:GetWide() / 2 - crab:GetWide() / 2, (viewer:GetTall() - 33 * screenscale) - (count - 1) * 33 * screenscale)         crab:SetVisible(true)          cral:SetText("Claim")         cral:SetPos(crab:GetWide() / 2 - cral:GetWide() / 2, crab:GetTall() * 0.5 - cral:GetTall() * 0.5)         cral:SetContentAlignment(5)         cral:SetVisible(true)     end      if not item_data.ConsoleCommand and count > 0 then         viewer.m_CraftWith:SetPos(viewer:GetWide() / 2 - viewer.m_CraftWith:GetWide() / 2, (viewer:GetTall() - 33 * screenscale) - 33 * count * screenscale)         viewer.m_CraftWith:SetContentAlignment(5)         viewer.m_CraftWith:SetVisible(true)     else         viewer.m_CraftWith:SetVisible(false)     end end  local categorycolors = {     [INVCAT_TRINKETS] = {COLOR_MIDGRAY, COLOR_DARKGRAY},     [INVCAT_COMPONENTS] = {COLOR_BLUE, COLOR_DARKBLUE} }  function GM:GetItemAssociatedSkill(item, quality)     local item_data     = self.ZSInventoryItemData[item]     local skill_indexes = item_data.SkillIndexes      local index         = skill_indexes and skill_indexes[1 + quality]     local skill         = index and self.Skills[index]      return {         Skill = skill,         ItemData = item_data     } end  local colBG = Color(10, 10, 10, 252) local colBGH = Color(200, 200, 200, 5) local function ItemPanelPaint(self, w, h)     local quality     = self.Quality     local assoc_skill = GAMEMODE:GetItemAssociatedSkill(self.Item, quality)     local skill       = assoc_skill.Skill     local item_data   = assoc_skill.ItemData      local cols =    quality and quality >= 1 and (                         (self.Depressed or self.On) and GAMEMODE.WeaponQualityColors[quality].Upg or                         GAMEMODE.WeaponQualityColors[quality].UpgDark                     ) or                         (self.Depressed or self.On) and categorycolors[self.Category][1] or                         categorycolors[self.Category][2]      draw.RoundedBox(2, 0, 0, w, h, cols)     draw.RoundedBox(2, 2, 2, w - 4, h - 4, colBG)     if self.On or self.Hovered then         draw.RoundedBox(2, 2, 2, w - 4, h - 4, colBGH)          if self.Hovered then             local title = GAMEMODE.InventoryMenu.Title              title:SetText(skill and skill.Name or item_data.PrintName)             title:SizeToContents()             title:CenterHorizontal()         end     end      return true end  function GM:CreateInventoryInfoViewer()     if self.m_InvViewer and self.m_InvViewer:IsValid() then         self.m_InvViewer:SetVisible(true)         return     end      local leftframe = self.InventoryMenu     local viewer = vgui.Create("DFrame")      local screenscale = BetterScreenScale()      viewer:SetDeleteOnClose(false)     viewer:SetTitle(" ")     viewer:SetDraggable(true)     if viewer.btnClose and viewer.btnClose:IsValid() then viewer.btnClose:SetVisible(false) end     if viewer.btnMinim and viewer.btnMinim:IsValid() then viewer.btnMinim:SetVisible(false) end     if viewer.btnMaxim and viewer.btnMaxim:IsValid() then viewer.btnMaxim:SetVisible(false) end      viewer:SetSize(leftframe:GetWide() / 1.25, leftframe:GetTall())     viewer:MoveRightOf(leftframe, 32)     viewer:MoveAbove(leftframe, -leftframe:GetTall())     self.m_InvViewer = viewer      self:CreateItemViewerGenericElems(viewer)     self:CreateNextTrinketElements(viewer)      local craftbtns = {}     for i = 1, 3 do         local craftb = vgui.Create("DButton", viewer)         craftb:SetText("")         craftb:SetSize(viewer:GetWide() / 1.15, 27 * screenscale)         craftb:SetVisible(false)          local namelab = EasyLabel(craftb, "...", "ZSBodyTextFont", COLOR_WHITE)         namelab:SetWide(craftb:GetWide())         namelab:SetVisible(false)          craftbtns[i] = {craftb, namelab}     end     viewer.m_CraftBtns = craftbtns      local craftwith = EasyLabel(viewer, "Craft With...", "ZSBodyTextFontBig", COLOR_WHITE)     craftwith:SetSize(viewer:GetWide() / 1.15, 27 * screenscale)     craftwith:SetVisible(false)     viewer.m_CraftWith = craftwith end  local col_trans = Color(150, 150, 150, 75)  local ammo_viewer_think = function(me)     if me.StartChecking and RealTime() < me.StartChecking then return end     me.StartChecking = RealTime() + 0.2      local screenscale = BetterScreenScale()      for type, panel in pairs(me.AmmoCounts) do         local count = MySelf:GetAmmoCount(type)          panel:SetText(count)         panel:SizeToContents()         panel:CenterHorizontal(0.64)         panel:SetColor(count > 0 and COLOR_WHITE or col_trans)          me.AmmoBtns[type][1]:SetVisible(count > 0)         me.AmmoBtns[type][2]:SetVisible(count > 0)     end      local inventory_menu = GAMEMODE.InventoryMenu      me:SetSize(inventory_menu:GetWide() / 3, inventory_menu:GetTall())     me:MoveLeftOf(inventory_menu, 32 * screenscale)     me:MoveBelow(inventory_menu, -inventory_menu:GetTall()) end  local function DropDoClick(self)     RunConsoleCommand("zsdropammo", self.Type) end  local function GiveDoClick(self)     RunConsoleCommand("zsgiveammo", self.Type) end  local function GiveWeapon()     if GAMEMODE.HumanMenuLockOn then         RunConsoleCommand("zsgiveweapon", GAMEMODE.HumanMenuLockOn:EntIndex(), GAMEMODE.InventoryMenu.SelInv)     end end local function GiveWeaponClip()     if GAMEMODE.HumanMenuLockOn then         RunConsoleCommand("zsgiveweaponclip", GAMEMODE.HumanMenuLockOn:EntIndex(), GAMEMODE.InventoryMenu.SelInv)     end end local function DropWeapon()     RunConsoleCommand("zsdropweapon", GAMEMODE.InventoryMenu.SelInv) end local function EmptyClip()     RunConsoleCommand("zsemptyclip") end local function DismantleWeapon()     RunConsoleCommand("zs_dismantle", GAMEMODE.InventoryMenu.SelInv) end  function GM:CreateAmmoViewer()     if self.AmmoViewer and self.AmmoViewer:IsValid() then         self.AmmoViewer:SetVisible(true)         return     end      local leftframe = self.InventoryMenu     local viewer = vgui.Create("DFrame")      local screenscale = BetterScreenScale()      viewer:SetDeleteOnClose(false)     viewer:SetTitle(" ")     viewer:SetDraggable(false)     if viewer.btnClose and viewer.btnClose:IsValid() then viewer.btnClose:SetVisible(false) end     if viewer.btnMinim and viewer.btnMinim:IsValid() then viewer.btnMinim:SetVisible(false) end     if viewer.btnMaxim and viewer.btnMaxim:IsValid() then viewer.btnMaxim:SetVisible(false) end      viewer:SetSize(leftframe:GetWide() / 3, leftframe:GetTall())     viewer:MoveLeftOf(leftframe, 32 * screenscale)     viewer:MoveBelow(leftframe, -leftframe:GetTall())     self.AmmoViewer = viewer      viewer.AmmoIndicators = {}     viewer.AmmoCounts = {}     viewer.AmmoBtns = {}      local ammo_indicator_order = {         "pistol", "buckshot", "smg1", "ar2", "357", "pulse", "xbowbolt", "impactmine", "chemical", "gaussenergy", "battery", "scrap"     }      for _, type in pairs(ammo_indicator_order) do         local icon_size = 44 * screenscale          local btn = vgui.Create("DButton", viewer)         btn:SetText("")         btn:SetSize(icon_size, icon_size)         btn.Paint = function(me, x, y)             if type == MySelf.ResupplyChoice then                 surface.SetDrawColor(140, 230, 140, math.abs(math.sin(CurTime() * 2)) * 70)                 surface.DrawRect(0, 0, icon_size, icon_size)             end              if me.Hovered then                 local title = leftframe.Title                  title:SetText(self.AmmoNames[type])                 title:SizeToContents()                 title:CenterHorizontal()             end         end         btn.DoClick = function()             if MySelf.ResupplyChoice == type then                 MySelf.ResupplyChoice = nil             else                 MySelf.ResupplyChoice = type             end             RunConsoleCommand("zs_resupplyammotype", MySelf.ResupplyChoice or "default")         end          if viewer.AmmoIndicators[#viewer.AmmoIndicators] then             btn:MoveBelow(viewer.AmmoIndicators[#viewer.AmmoIndicators], 12 * screenscale)         else             local x, _ = btn:GetPos()             btn:SetPos(x, 12 * screenscale)         end         btn:CenterHorizontal(0.2)          local dropbtn = vgui.Create("DImageButton", viewer)         dropbtn:SetImage("icon16/arrow_down.png")         dropbtn:SizeToContents()         dropbtn:SetTooltip("Drop")         dropbtn.DoClick = DropDoClick         dropbtn.Type = type          local givebtn = vgui.Create("DImageButton", viewer)         givebtn:SetImage("icon16/user_go.png")         givebtn:SizeToContents()         givebtn:SetTooltip("Give")         givebtn.DoClick = GiveDoClick         givebtn.Type = type          local ammo_num = EasyLabel(viewer, "0", "ZSHUDFontSmaller", COLOR_WHITE)         ammo_num:SetContentAlignment(5)         if viewer.AmmoIndicators[#viewer.AmmoIndicators] then             ammo_num:MoveBelow(viewer.AmmoIndicators[#viewer.AmmoIndicators], (self:TypewriterFont() and 22 or 18) * screenscale)             dropbtn:MoveBelow(viewer.AmmoIndicators[#viewer.AmmoIndicators], 16 * screenscale)             givebtn:MoveBelow(viewer.AmmoIndicators[#viewer.AmmoIndicators], 36 * screenscale)         else             local x, _ = ammo_num:GetPos()             ammo_num:SetPos(x, (self:TypewriterFont() and 22 or 18) * screenscale)             dropbtn:SetPos(x, 16 * screenscale)             givebtn:SetPos(x, 36 * screenscale)         end         ammo_num:CenterHorizontal(0.55)         dropbtn:CenterHorizontal(0.92)         givebtn:CenterHorizontal(0.92)          local img = vgui.Create("DImage", btn)         local killicon_table = killicon.Get(self.AmmoIcons[type])          img:SetImage(killicon_table[1])         if killicon_table[2] then             img:SetImageColor(killicon_table[2])         end         img:SetSize(icon_size, icon_size)          btn.Image = img         viewer.AmmoCounts[type] = ammo_num         viewer.AmmoBtns[type] = {dropbtn, givebtn}         viewer.AmmoIndicators[#viewer.AmmoIndicators + 1] = btn     end      viewer.Think = ammo_viewer_think end  function GM:InventoryAddGridItem(item, category)     local screenscale = BetterScreenScale()      local grid = self.InventoryMenu.Grid     local buttons = self.InventoryMenu.Buttons      local is_trinkets = category == INVCAT_TRINKETS      local itempan = vgui.Create("DButton")     itempan:SetText("")     itempan:SetSize(90 * screenscale, 90 * screenscale)     itempan.Paint = ItemPanelPaint     itempan.DoClick = ItemPanelDoClick     itempan.DoRightClick = function()         local menu = DermaMenu(itempan)         menu:AddOption("Drop", function() RunConsoleCommand("zsdropweapon", item) end)         menu:AddOption("Give", function()             local lockon = GAMEMODE.HumanMenuLockOn             if lockon then                 RunConsoleCommand("zsgiveweapon", lockon:EntIndex(), item)             end         end)         menu:Open()     end     itempan.Item = item     itempan.Category = category     itempan.Quality = MySelf:GetTrinketItemLevel(item)      grid:AddItem(itempan)     grid:SortByMember("Category")      local mdlframe = vgui.Create("DPanel", itempan)     mdlframe:SetSize((is_trinkets and 56 or 76) * screenscale, (is_trinkets and 56 or 42) * screenscale)     mdlframe:Center()     mdlframe:SetMouseInputEnabled(false)     mdlframe.Paint = function() end      if is_trinkets then         buttons[item] = itempan     end      local icon =  is_trinkets and self.TrinketCategoryIcons[GAMEMODE.ZSInventoryItemData[item].Category]                     or "weapon_zs_craftables"      local kitbl = killicon.Get(icon)     if kitbl then         self:AttachKillicon(kitbl, itempan, mdlframe, nil, nil)     end end  function GM:InventoryRemoveGridItem(item)     local grid = self.InventoryMenu.Grid     local buttons = self.InventoryMenu.Buttons      for k, v in pairs(grid:GetChildren()) do         if v.Item == item then             grid:RemoveItem(v)             buttons[item] = nil             break         end     end     grid:SortByMember("Category")      if self.InventoryMenu.SelInv == item then         if self.m_InvViewer and self.m_InvViewer:IsValid() and self.InventoryMenu.SelInv then             self.m_InvViewer:SetVisible(false)         end          self.InventoryMenu.SelInv = nil         self:DoAltSelectedItemUpdate()     end end  function GM:InventoryWipeGrid()     local grid = self.InventoryMenu.Grid      self.InventoryMenu.Buttons = {}     for k, v in pairs(grid:GetChildren()) do         grid:RemoveItem(v)     end      if self.m_InvViewer and self.m_InvViewer:IsValid() then         self.m_InvViewer:SetVisible(false)     end      self.InventoryMenu.SelInv = nil     self:DoAltSelectedItemUpdate() end  function GM:OpenInventory()     if self.InventoryMenu and self.InventoryMenu:IsValid() then         self.InventoryMenu:SetVisible(true)          if self.m_InvViewer and self.m_InvViewer:IsValid() and self.InventoryMenu.SelInv then             self.m_InvViewer:SetVisible(true)         end          if self.AmmoViewer and self.AmmoViewer:IsValid() then             self.AmmoViewer:SetVisible(true)         end         return     end      local screenscale = BetterScreenScale()     local wid, hei = math.max(400, math.min(ScrW(), 400) * screenscale), math.min(ScrH(), 686) * screenscale      local frame = vgui.Create("DFrame")     frame:SetSize(wid, hei)     frame:CenterHorizontal(0.52)     frame:CenterVertical(0.42)     frame:SetDeleteOnClose(false)     frame:SetTitle(" ")     frame:SetDraggable(true)      if frame.btnClose and frame.btnClose:IsValid() then frame.btnClose:SetVisible(false) end     if frame.btnMinim and frame.btnMinim:IsValid() then frame.btnMinim:SetVisible(false) end     if frame.btnMaxim and frame.btnMaxim:IsValid() then frame.btnMaxim:SetVisible(false) end      self.InventoryMenu = frame      local topspace = vgui.Create("DPanel", frame)     topspace:SetWide(wid - 16)      local title = EasyLabel(topspace, "Inventory", "ZSHUDFontSmall", COLOR_WHITE)     title:CenterHorizontal()     frame.Title = title      local _, y = title:GetPos()     topspace:SetTall(y + title:GetTall() + 2)     topspace:AlignTop(8)     topspace:CenterHorizontal()      local icon_size = 96 * screenscale      local itemframe = vgui.Create("DScrollPanel", frame)     itemframe:SetSize(frame:GetWide() * 0.95, frame:GetTall() * 0.6675)     itemframe:MoveBelow(topspace, 16)     itemframe:SetPadding(0)           itemframe:CenterHorizontal()     itemframe.Paint = function(me, xx, yy)     end      local invgrid = vgui.Create("DGrid", itemframe)     invgrid:SetSize(wid - 16 * screenscale, frame:GetTall() - itemframe:GetTall() - icon_size)           invgrid:SetCols(4)     invgrid:SetColWide(icon_size + (invgrid:GetWide() - icon_size * 4) / 3)     invgrid:SetRowHeight(icon_size)     frame.Grid = invgrid      frame.Buttons = {}      for item, count in pairs(self.ZSInventory) do         if count > 0 then             for i = 1, count do                 self:InventoryAddGridItem(item, self:GetInventoryItemType(item))             end         end     end     invgrid:SortByMember("Category")      self:CreateAmmoViewer()      local font_hei = draw.GetFontHeight("ZSHUDFontSmall") - (self.ZSFont == 0 and 0 or self.ZSFont == 2 and 0 or 6)      local bottom_width = icon_size * 2      local btns_panel = vgui.Create("DPanel", frame)     btns_panel:SetSize(frame:GetWide() - 16, bottom_width - 8)     btns_panel:SetPos(8, frame:GetTall()-bottom_width - 8)     btns_panel:SetPaintBackground(false)      local selecteditemtitle = EasyLabel(btns_panel, "Selected Item", "ZSHUDFontSmall", color_white)     selecteditemtitle:SetContentAlignment(5)     selecteditemtitle:CenterHorizontal()     frame.SelectedTop = selecteditemtitle      local selecteditemlabel = EasyLabel(btns_panel, "Fists", "ZSHUDFontSmaller", color_white)     selecteditemlabel:SetContentAlignment(5)     selecteditemlabel:CenterHorizontal()     selecteditemlabel:MoveBelow(selecteditemtitle, self.ZSFont == 0 and 4 or self.ZSFont == 2 and 0 or -10)     frame.SelectedItemLabel = selecteditemlabel      local fmbtn = vgui.Create("DButton", btns_panel)     fmbtn:SetFont("ZSHUDFontSmall")     fmbtn:SetText("Change Fire Mode")     fmbtn:SetSize((btns_panel:GetWide() - 8 * screenscale) / 1, font_hei - 4 * screenscale)     fmbtn:MoveBelow(selecteditemlabel, 4)     fmbtn.DoClick = function() RunConsoleCommand("zs_firemode") end      local gwbtn = vgui.Create("DButton", btns_panel)     gwbtn:SetFont("ZSHUDFontSmall")     gwbtn:SetText("Give")     gwbtn:SetSize((btns_panel:GetWide() - 8 * screenscale) / 2, font_hei - 4 * screenscale)     gwbtn:MoveBelow(fmbtn, 4)     gwbtn.DoClick = GiveWeapon      local gw5btn = vgui.Create("DButton", btns_panel)     gw5btn:SetFont("ZSHUDFontSmallest")     gw5btn:SetText("Give with 5 Clips")     gw5btn:SetSize((btns_panel:GetWide() - 8 * screenscale) / 2, font_hei - 4 * screenscale)     gw5btn:MoveBelow(fmbtn, 4)     gw5btn:MoveRightOf(gwbtn, 4)     gw5btn.DoClick = GiveWeaponClip      local drpbtn = vgui.Create("DButton", btns_panel)     drpbtn:SetFont("ZSHUDFontSmall")     drpbtn:SetText("Drop")     drpbtn:SetSize((btns_panel:GetWide() - 8 * screenscale) / 2, font_hei - 4 * screenscale)     drpbtn:MoveBelow(gwbtn, 4)     drpbtn.DoClick = DropWeapon      local embtn = vgui.Create("DButton", btns_panel)     embtn:SetFont("ZSHUDFontSmaller")     embtn:SetText("Empty Clip")     embtn:SetSize((btns_panel:GetWide() - 8 * screenscale) / 2, font_hei - 4 * screenscale)     embtn:MoveBelow(gwbtn, 4)     embtn:MoveRightOf(drpbtn, 4)     embtn.DoClick = EmptyClip      local dibtn = vgui.Create("DButton", btns_panel)     dibtn:SetFont("ZSHUDFontSmall")     dibtn:SetText("Dismantle")     dibtn:SetSize((btns_panel:GetWide() - 8 * screenscale) / 1, font_hei - 4 * screenscale)     dibtn:MoveBelow(drpbtn, 4)     dibtn.DoClick = DismantleWeapon      frame.DismantleButton = dibtn      frame:MakePopup() end 