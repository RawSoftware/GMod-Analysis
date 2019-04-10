local sparkchat = sparkchat

if sparkchat.box then
    if IsValid(sparkchat.box.Parts.Root) then
        sparkchat.box.Parts.Root:Close()
    end
end

sparkchat.box = {}
local chatbox = sparkchat.box
chatbox.Parts = {}

sparkchat.cvar_chat_hide = CreateClientConVar("spark_chat_hide", "0", true, false, "Prevent visual display of chat")
cvars.AddChangeCallback("spark_chat_hide", function(name, old, new)
end)

chatbox.Default = {
    x = ScrW()*0.04,
    y = ScrH()*0.40,
    w = ScrW()*0.40,
    h = ScrH()*0.29
}

local BlurMat = Material("pp/blurscreen")

local function DrawBlurredRect(p,w,h)
    surface.SetDrawColor(0, 0, 0, 160)
    draw.RoundedBoxEx(12, 0, 0, w, h, Color(17, 17, 34, 160), true, true, true, true)

    surface.SetMaterial(BlurMat)
    BlurMat:Recompute()

    local absw,absh = p:LocalToScreen(0,0)

    for i = 1, 3 do
        BlurMat:SetFloat("$blur", i*0.5)
        BlurMat:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(-absw, -absh, ScrW(), ScrH())
    end
end

local function DrawDarkerBg(p,w,h)
    surface.SetDrawColor(17, 17, 34, 180)
    draw.RoundedBoxEx(8, 0, 0, w, h, Color(17, 17, 34, 180), false, false, true, true)
end

local function DrawDarkBg(p,w,h)
    surface.SetDrawColor(17, 17, 34, 90)
    draw.RoundedBoxEx(8, 0, 0, w, h, Color(17, 17, 34, 90), true, true, false, false)
end

local function SavePositionData(x, y, w, h)
    LocalPlayer():SetPData("sparkwerk_chat_x", x)
    LocalPlayer():SetPData("sparkwerk_chat_y", y)
    LocalPlayer():SetPData("sparkwerk_chat_w", w)
    LocalPlayer():SetPData("sparkwerk_chat_h", h)
end

local function GetSize()
    if chatbox.Size then
        return chatbox.Size.x,
               chatbox.Size.y,
               chatbox.Size.w,
               chatbox.Size.h
    else
        return chatbox.Default.x,
               chatbox.Default.y,
               chatbox.Default.w,
               chatbox.Default.h
    end
end

hook.Add("InitPostEntity", "sparkchat.load_chat_size", function()
    chatbox.Size = {}
    chatbox.Size.x = LocalPlayer():GetPData("sparkwerk_chat_x", chatbox.Default.x)
    chatbox.Size.y = LocalPlayer():GetPData("sparkwerk_chat_y", chatbox.Default.y)
    chatbox.Size.w = LocalPlayer():GetPData("sparkwerk_chat_w", chatbox.Default.w)
    chatbox.Size.h = LocalPlayer():GetPData("sparkwerk_chat_h", chatbox.Default.h)

    if IsValid(chatbox.Parts.Root) then
        chatbox.Parts.Root:SetSize(chatbox.Size.w, chatbox.Size.h)
        chatbox.Parts.Root:SetPos(chatbox.Size.x, chatbox.Size.y)
    end
end)

concommand.Add("sparkwerk_reset_chatbox", function()
    if IsValid(chatbox.Parts.Root) then
        chatbox.Parts.Root:SetSize(chatbox.Default.w, chatbox.Default.h)
        chatbox.Parts.Root:SetPos(chatbox.Default.x, chatbox.Default.y)
    end

    SavePositionData(chatbox.Default.x,
                     chatbox.Default.y,
                     chatbox.Default.w,
                     chatbox.Default.h)
end)

local function AddChatboxPart(self, panel, name)
    self.Parts[name] = panel
end

function chatbox:Make()
    local x, y, w, h = GetSize()

    local Root = sui.Build("DFrameImproved")
        :SetPos(x, y)
        :SetSize(w, h)
        :SetTitle("")
        :SetDraggable(true)
        :SetSizable(true)
        :ShowCloseButton(false)
        :Set("PaintVisible", DrawBlurredRect)
        :DockPadding(4, 4, 4, 4)
        :Set("Paint", function(pan, w, h)
            DrawBlurredRect(pan, w, h)
        end)
        :Build()

    local OldMouseReleased = Root.OnMouseReleased
    Root.OnMouseReleased = function(pan)
        local x, y = pan:GetPos()
        local w, h = pan:GetSize()
        SavePositionData(x, y, w, h)
        OldMouseReleased(pan)
    end

    AddChatboxPart(self, Root, "Root")

    local _, h = sparkchat:GetFontSize("|")
    local EntryBg = sui.Build("DPanel", Root)
        :SetSize(75, h)
        :Dock(BOTTOM)
        :DockPadding(8, 0, 0, 0)
        :Set("PaintVisible", DrawDarkerBg)
        :Build()

    AddChatboxPart(self, EntryBg, "EntryBg")

    local SayLabel = (function()
        local p = vgui.Create("DLabel", EntryBg)
        p:SetFont(sparkchat:GetFont())
        p:SetText("All: ")
        p:Dock(LEFT)
        p:SetColor(Color(100, 100, 100))
        p:SizeToContents()
        p.OnToggle = function(pan, visible)
            pan:SetFont(sparkchat:GetFont())
            pan:SetVisible(visible)
        end
        return p
    end)()
    AddChatboxPart(self, SayLabel, "EntryLabel")

    local Entry = (function()
        local p = vgui.Create("DTextEntry", EntryBg)
        p:Dock(FILL)
        p:SetText("")
        p:SetTabbingDisabled(true)
        p:SetDrawBackground(false)
        p:SetHighlightColor(SparkWerk.Color.SunrustOrange)
        p:SetCursorColor(SparkWerk.Color.SunrustOrange)
        p:SetFocusTopLevel(true)
        p:SetHistoryEnabled(true)

        local OldKeyCode = p.OnKeyCodeTyped
        p.OnKeyCodeTyped = function(pan, code)
            OldKeyCode(pan, code)

            if code == KEY_ESCAPE then
                chatbox:SetFocus(false)
                gui.HideGameUI()
            end
        end
        p.OnToggle = function(pan, visible)
            if visible then
                pan:SetFontInternal(sparkchat:GetFont())
                pan:SetTextColor(Color(255, 255, 255))
                pan:RequestFocus()
            else
                pan:SetText("")
            end
        end
        p.OnEnter = function()
            local input = p:GetText()

            chatbox:SetFocus(false)

            if input == "" then return end
            if string.len(input) > SparkWerk.MaxChatLength then
                input = string.sub(input, 1, SparkWerk.MaxChatLength)
            end

            p:AddHistory(input)

            net.Start("sw_player_chat")
                net.WriteBool(self.MessageMode == "team")
                net.WriteString(input)
            net.SendToServer()
        end
        return p
    end)()
    AddChatboxPart(self, Entry, "Entry")

    local FontSelectBack = (function()
        local p = vgui.Create("DPanel", Root)
        p:SetSize(1, 19)
        p:Dock(TOP)
        p.Paint = function() end
        p:DockPadding(0, 0, 0, 3)
        return p
    end)()

    -- local FontSelection = (function()
    --     local p = vgui.Create("DComboBox", FontSelectBack)
    --     p:SetSize(100*(ScrH()/1440),30)
    --     p:Dock(RIGHT)
    --     p:SetValue(sparkchat.data.current_font)

    --     for fname,_ in pairs(sparkchat.fonts) do
    --         p:AddChoice(fname)
    --     end

    --     p.OnToggle = function(pan, visible)
    --         pan:SetVisible(visible)
    --     end

    --     p.OnSelect = function(pan, idx, val)
    --         RunConsoleCommand("sparkwerk_chat_font", val)
    --         timer.Simple(0.01, function()
    --             self:SetFocus(false)
    --             self:SetFocus(true)
    --             self.Parts.EntryLabel:SizeToContents()
    --         end)
    --     end
    --     return p
    -- end)()
    -- AddChatboxPart(self, FontSelection, "FontSel")

    local display = vgui.Create("DEmberDisplay", FontSelectBack)
    AddChatboxPart(self, display.IconPanel, "CurrencyIcon")
    AddChatboxPart(self, display.CurrencyPanel, "CurrencyText")
    display:Dock(LEFT)
    
    local Settings = (function()
        local p = vgui.Create("DImageButton", FontSelectBack)
        p:Dock(RIGHT)
        p:SetImage("sparkwerk/cog")
        p:Center()
        p:SetSize(16, 16)
        p:SetColor(SparkWerk.Color.SunrustOrange)
        p:SetVisible(true)
        p.OnToggle = function(pan, visible)
            pan:SetVisible(visible)
        end
        p.DoClick = function()
            SparkWerk:MakeOptionsMenu()
        end
        return p
    end)()
    AddChatboxPart(self, Settings, "SettingsButton")
 --[[

    local Help = (function()
        local p = vgui.Create("DImageButton", FontSelectBack)
        p:Dock(RIGHT)
        p.Paint = nil
        p:SetImage("icon16/help.png")
        p:Center()
        p:SetKeepAspect(true)
        p:SetStretchToFit(false)
        p:SizeToContents()
        p:SetColor(Color(255,255,255))
        p.PaintVisible = function() end
        p.DoClick = function() end
        p.OnToggle = function(pan, visible)
            pan:SetVisible(visible)
        end
        return p
    end)()
    AddChatboxPart(self, Help, "HelpButton")
]]

    local Canvas = (function()
        local p = vgui.Create("DWrapPanel", Root)
        p:Dock(FILL)
        p:GetCanvas():DockPadding(2, 2, 2, 2)
        p:SetSize(w,h)
        p.PaintVisible = DrawDarkBg
        return p
    end)()
    AddChatboxPart(self, Canvas, "Canvas")

    local vbar = Canvas:GetVBar()
    vbar.PaintVisible         = vbar.Paint
    vbar.btnGrip.PaintVisible = vbar.btnGrip.Paint
    vbar.btnUp.PaintVisible   = vbar.btnUp.Paint
    vbar.btnDown.PaintVisible = vbar.btnDown.Paint
    AddChatboxPart(self, vbar, "VBar")
    AddChatboxPart(self, vbar.btnGrip, "VBar_Grip")
    AddChatboxPart(self, vbar.btnUp  , "VBar_Up")
    AddChatboxPart(self, vbar.btnDown, "VBar_Dn")

    Root:MakePopup()
    Root:InvalidateLayout(true)
    Root:InvalidateChildren(true)
    SayLabel:Center()
    Root:SetMouseInputEnabled(false)
    Root:SetKeyboardInputEnabled(false)

    for _, part in pairs(self.Parts) do
        part:SetSkin("sunrust")
    end

    self:SetFocus(false)

    local cw,ch = Canvas:GetSize()
    Canvas:MakeSpacer(cw,ch)
    self:ScrollToBottom()
end

local active_steamid

function chatbox:SetActiveSteamID(sid)
    active_steamid = sid
end

local active_markup

function chatbox:SetActiveMarkup(markup)
    active_markup = markup
end

function chatbox:ScrollToBottom()
    timer.Simple(0.001, function()
        local _,h = self.Parts.Canvas:GetCanvas():GetSize()
        self.Parts.VBar:AnimateTo(h, 0.15, 0, -5)
    end)
end

hook.Add("InitPostEntity", "sparkwerk.chat_scroll_bottom", function()
    if IsValid(chatbox.Parts.Root) then
        timer.Simple(2, function()
            chatbox:ScrollToBottom()
        end)
    end
end)

local function MakeChatBox()
    if not IsValid(chatbox.Parts.Root) then
        chatbox:Make()
    end
end

function chatbox:AddPanels(panels)
    self.Parts.Canvas:AddPanels(panels)

    local _,canvas_h = self.Parts.Canvas:GetCanvas():GetSize()
    local _,window_h = self.Parts.Canvas:GetSize()

    if not self.Focused or (canvas_h - self.Parts.VBar:GetScroll()) == window_h then
        self:ScrollToBottom()
    end
end

function chatbox:AddTextNoParse(Text)
    MakeChatBox()

    local panels = sparkchat.MakePanels{ {name = "(text)", args = {Text}} }
    self:AddPanels(panels)
end

function chatbox:AddText(Text)
    MakeChatBox()

    local tokens = sparkchat.parse(Text)

    -- before turning tokens into panels, edit them according
    -- to current global settings
    for _,tok in pairs(tokens) do
        if active_steamid and tok.name == "avatar" and not tok.args.self_arg then
            tok.args.self_arg_override = active_steamid
        end

        if active_markup and tok.name == "(text)" and not tok.markup then
            tok.markup = active_markup
        end
    end

    self:AddPanels(sparkchat.MakePanels(tokens))

    return tokens
end

function chatbox:SetFocus(focus)
    if focus == true then
        self.Focused = true
        self.Parts.Root:SetMouseInputEnabled(true)
        self.Parts.Root:SetKeyboardInputEnabled(true)

        local _,h = sparkchat:GetFontSize("|gq^W")

        self.Parts.EntryBg:SetSize(75, h)
        self.Parts.Canvas:SetColdRowVisible(true)

        for _, panel in pairs(self.Parts) do
            if panel.PaintVisible then
                panel.Paint = panel.PaintVisible
            end
            if panel.OnToggle then
                panel:OnToggle(true)
            end
        end
    else
        self.Focused = false
        self.Parts.Root:SetMouseInputEnabled(false)
        self.Parts.Root:SetKeyboardInputEnabled(false)
        self.Parts.Canvas:SetColdRowVisible(false)

        for _, panel in pairs(self.Parts) do
            if panel.PaintVisible then
                panel.Paint = nil
            end
            if panel.OnToggle then
                panel:OnToggle(false)
            end
        end
    end
end

function chatbox:SetMessageMode(mode)
    if mode == "all" then
        self.Parts.EntryLabel:SetText("All: ")
    elseif mode == "team" then
        self.Parts.EntryLabel:SetText("Team: ")
    end

    self.MessageMode = mode
    self.Parts.EntryLabel:SizeToContents()
end

function chatbox:LineBreak()
    self.Parts.Canvas:BreakRow()
end

net.Receive("sw_chat", function()
    local ply  = net.ReadEntity()
    local msg  = net.ReadString()
    local team = net.ReadBool()

    local isdead = IsValid(ply) and not ply:Alive() or false

    if IsValid(ply) and sparkchat.IgnoreList[ply:SteamID()] then return end

    hook.Run("OnPlayerChat", ply, msg, team, isdead)
end)

hook.Add("HUDShouldDraw", "sparkchat.hide_default", function(name)
    if name == "CHudChat" then return false end
end)

hook.Add("PlayerBindPress", "sparkchat.open_chatbox", function(ply, bind, pressed)
    if string.sub(bind, 1, 11) == "messagemode" then
        MakeChatBox()

        if bind == "messagemode" then
            chatbox:SetMessageMode("all")
        elseif bind == "messagemode2" then
            chatbox:SetMessageMode("team")
        end

        chatbox:SetFocus(true)
        return true
    end
end)

hook.Add( "player_disconnect", "sparkchat.disconnect", function(data)
    MakeChatBox()

    if not IsValid(LocalPlayer()) then return end
    if not LocalPlayer():IsMod() then return end

	local name   = data.name
	local reason = data.reason
    local msg_suffix = " disconnect: <color=255,55,25>" .. reason .. "</color>"

    chatbox:AddText(":icon=shield: ")
    sparkchat:SetDefaultColor(Color(200, 255, 0))
    MsgC(Color(255, 0, 0), "(" .. data.networkid .. ") " .. data.name)
    chatbox:AddText("(" .. data.networkid .. ") <noparse>" .. data.name .. "</noparse>")
    sparkchat:SetDefaultColor(Color(255, 255, 255))
    chatbox:AddText(msg_suffix)
    MsgC(Color(255, 0, 0), " disconnect", Color(255,255,255), ": " .. reason .. "\n")
    chatbox:LineBreak()
end)

hook.Add("SR.PlayerConnect", "sparkchat.connect", function(name, userid)
    MakeChatBox()

    sparkchat:SetDefaultColor(Color(200, 255, 0))
    chatbox:AddText(":icon=user size=16: <noparse>" .. name .. "</noparse>")
    sparkchat:SetDefaultColor(Color(255, 255, 255))
    chatbox:AddText(" has joined the game")
    chatbox:LineBreak()
end)

local function PrintNameChangeInConsole(player_index, text)
    local parts = {"Name Change"}

    local ply = Entity(player_index)
    if IsValid(ply) then
        table.insert(parts, ply:SteamID())
    end

    MsgC(string.format("[%s] %s\n", table.concat(parts, "|"), text))
end

hook.Add("ChatText", "sparkchat.joinleave", function(index, name, text, type)
    MakeChatBox()

    if type == "joinleave" then return true end

    if type ~= "chat" then
        sparkchat:SetDefaultColor(Color(255, 255, 255))
        if type == "namechange" then
            PrintNameChangeInConsole(index, text)
        else
            chatbox:AddText(text)
        end

        chatbox:LineBreak()
        return true
    end
end)

local function PrintPlayer(data, con_output)
    local ply  = data.Player
    local name = data.Name
    local col  = data.Team and team.GetColor(data.Team) or Color(255, 255, 255)

    if (not isbool(ply)) and IsValid(ply) then
        chatbox:SetActiveSteamID(ply:SteamID())
        name = ply:Nick()
        col  = GAMEMODE:GetTeamColor(ply) or col
    else
        chatbox:SetActiveSteamID(data.SteamID)
    end

    chatbox:AddText(":avatar size=" .. (data.AvatarSize or 32) .. ": ")

    local donator_prefix = ""
    if (not isbool(ply)) and IsValid(ply) and data.PrintTitle then
        local tag, tagcolor, markup = ply:GetTag()
        if tag then
            if tagcolor then sparkchat:SetDefaultColor(tagcolor) end
            if markup then chatbox:SetActiveMarkup(markup) end

            chatbox:AddText(tag .. " ")
            chatbox:SetActiveMarkup(nil)
        end

        if ply:GetNWInt("member_level", 0) > 0 then
            donator_prefix = ":sunrust: "
        end
    end

    local teamcol = Color(col.r, col.g, col.b, 255)

    sparkchat:SetDefaultColor(teamcol)

    chatbox:AddText(donator_prefix)
    chatbox:AddTextNoParse(name)
    sparkchat:SetDefaultColor(Color(255, 255, 255))

    table.insert(con_output, teamcol)
    table.insert(con_output, name)
    table.insert(con_output, Color(255, 255, 255))
end

local function PrintText(text, con_output, filter_con_output)
    local tokens = chatbox:AddText(text)

    if not filter_con_output then
        table.insert(con_output, text)
        return
    end

    local prev_non_text = false

    for _, tok in pairs(tokens) do
        if tok.name == "(text)" then
            local txt = tok.args[1]

            if prev_non_text and string.sub(txt, 1, 1) == " " then
                txt = string.sub(txt, 2)
            end

            table.insert(con_output, txt)
            prev_non_text = false
        else
            prev_non_text = true
        end
    end
end

local function PrintColor(obj, con_output)
    local col = Color(obj.r, obj.g, obj.b, obj.a)
    sparkchat:SetDefaultColor(col)
    table.insert(con_output, col)
end

function chat.AddText(...)
    local args = {...}
    local filter_con_output = false

    if isbool(args[1]) then
        table.remove(args, 1)
        filter_con_output = true
    end

    MakeChatBox()

    local con_output = {}

    for k, obj in pairs(args) do
        if     isstring(obj)                    then PrintText(obj, con_output, filter_con_output)
        elseif istable(obj) and obj.Player      then PrintPlayer(obj, con_output)
        elseif istable(obj) and obj.ImageSize   then sparkchat:SetMaxImageSize(obj.ImageSize)
        elseif istable(obj)                     then PrintColor(obj, con_output)
        elseif isentity(obj) and obj:IsPlayer() then PrintPlayer({Player = obj, PrintTitle = true}, con_output)
        end
    end

    chatbox:SetActiveSteamID(nil)
    chatbox:LineBreak()
    sparkchat:SetMaxImageSize()
    sparkchat:SetDefaultColor(Color(255, 255, 255))

    table.insert(con_output, "\n")
    MsgC(Color(255, 255, 255), unpack(con_output))
end

sparkchat.IgnoreList = {}
sparkchat.IgnoreFile = "sparkignore.txt"

hook.Add("Initialize", "LoadIgnoreList", function()
	if file.Exists(sparkchat.IgnoreFile, "DATA") then
		sparkchat.IgnoreList = util.JSONToTable(file.Read(sparkchat.IgnoreFile)) or {}
	end
end)

local function SaveIgnoreList()
	file.Write(sparkchat.IgnoreFile, util.TableToJSON(sparkchat.IgnoreList))
end

function sparkchat.AddIgnoredPlayer(id)
	sparkchat.IgnoreList[id] = true

	SaveIgnoreList()
end

function sparkchat.RemoveIgnoredPlayer(id)
	if sparkchat.IgnoreList[id] then
		sparkchat.IgnoreList[id] = nil

		SaveIgnoreList()
	end
end