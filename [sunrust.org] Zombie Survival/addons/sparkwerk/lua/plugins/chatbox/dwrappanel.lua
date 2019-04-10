local PANEL = {}

PANEL.Rows = {}
PANEL.ActiveRow = {}
PANEL.ActiveRow.Panel = nil
PANEL.ActiveRow.RemainingWidth = nil
PANEL.ActiveRow.CurrentHeight = 0
PANEL.ColdRowVisible = false
PANEL.RowHotTime = 10
PANEL.HistoryLength = 200 -- rows

function PANEL:RemoveRow(idx)
    if IsValid(self.Rows[idx]) then
        self.Rows[idx]:Remove()
    end
    table.remove(self.Rows, idx)
end

function PANEL:MakeNewRow()
    local row = vgui.Create("DPanel", self)
    local totw,_ = self:GetSize()
    row:SetSize(totw, 1)
    row:Dock(TOP)
    row.Paint = function() end

    local hot_time = sparkchat.cvar_chat_hide:GetInt() ~= 1 and self.RowHotTime or 0
    timer.Simple(hot_time, function()
        if not IsValid(row) then return end
        row.Cold = true
        if not self.ColdRowVisible then
            for _,child in pairs(row:GetChildren()) do
                child:SetVisible(false)
            end
        end
    end)

    if #self.Rows >= self.HistoryLength then
        self:RemoveRow(1)
    end

    table.insert(self.Rows, row)
    return row
end

function PANEL:MakeSpacer(w, h)
    local space = vgui.Create("DPanel", self)
      space:SetSize(w, h)
      space:Dock(TOP)
      space.Paint = function() end
end

local function GetTextSize(text, font)
    surface.SetFont(font)
    return surface.GetTextSize(text)
end

local function MakeCopiedText(text, existing)
    local cur_font = existing:GetFont()
    local w,h = GetTextSize(text, cur_font)

    local texlab = vgui.Create("DLabel")
    texlab:SetSize(w, h)
    texlab:Dock(LEFT)
    texlab:SetText(text)
    texlab:SetSelectable(true)
    texlab:SetFont(cur_font)
    texlab:SetColor(existing:GetTextColor())

    return {panel = texlab, w = w, h = h}
end

local function GetWordSplitIndex(word, font, split_length)
    local character_count = 0
    local character_length = 0

    for char in string.gmatch(word, ".") do
        local length = GetTextSize(char, font)
        local after_add_length = character_length + length

        if after_add_length > split_length then
            -- this char would make us not fit
            return character_count - 2
        end

        character_count = character_count + 1
        character_length = after_add_length
    end

    error("word can't be split")
end

local function SplitPanel(panel, remaining_length, line_length)
    local font = panel.panel:GetFont()
    local text = panel.panel:GetText()

    local max_wrap_length, _ = GetTextSize("abdcefghijklmnop", font)
    max_wrap_length = math.min(max_wrap_length, line_length)

    if GetTextSize(string.sub(text, 1, 1), font) == 0 then
        -- not even the first character fits
        return
    end

    local words = string.Explode(" ", text)
    local character_count = 0
    local character_length = 0

    local space_size = GetTextSize(" ", font)

    for _, word in pairs(words) do
        local length = GetTextSize(word, font)

        local after_add_length = character_length + length + space_size

        if after_add_length > remaining_length then
            -- this word would make us not fit
            if length >= max_wrap_length then
                character_count = character_count + GetWordSplitIndex(text, font, remaining_length - character_length + 1)
            end
            break
        end

        character_count = character_count + string.len(word) + 1
        character_length = after_add_length
    end

    local first_half = string.sub(text, 1, character_count)
    local second_half = "    " .. string.sub(text, character_count + 1)

    panel.panel:SetText(first_half)
    panel.w, panel.h = GetTextSize(first_half, font)

    return MakeCopiedText(second_half, panel.panel)
end

function PANEL:SetRowHotTime(time)
    self.RowHotTime = time
end

function PANEL:SetColdRowVisible(visible)
    self.ColdRowVisible = visible

    for k,pan in pairs(self.Rows) do
        if pan.Cold then
            for _,child in pairs(pan:GetChildren()) do
                child:SetVisible(visible)
            end
        end
    end
end

function PANEL:AddPanels(panel_list)
    local all_panels = panel_list

    local panel_idx = 1
    local imax = 1

    local canvas_width , _ = self:GetSize()

    while panel_idx ~= #all_panels+1 do
        if not self.ActiveRow.Panel then self:NewActiveRow() end
        local row = self.ActiveRow.Panel

        local tot_width, max_height = row:GetSize()
        max_height = self.ActiveRow.CurrentHeight

        while panel_idx ~= #all_panels+1 do
            local cur_panel = all_panels[panel_idx]
            local is_label = cur_panel.panel:GetClassName() == "Label"

            -- clamp panel size if it's not text and too big for the chat
            if not is_label then
                if cur_panel.w > canvas_width then
                    cur_panel.panel:SetSize(canvas_width, canvas_width)
                    cur_panel.w = canvas_width
                    cur_panel.h = canvas_width
                end
            end

            local rem_after_cur = self.ActiveRow.RemainingWidth - cur_panel.w
            local split_label = false

            if rem_after_cur < 0 then
                if not is_label then
                    self:BreakRow()
                    break
                end

                -- we can break into another panel if this is a label (text)
                local second_half = SplitPanel(cur_panel, self.ActiveRow.RemainingWidth, canvas_width)
                if not second_half then
                    return
                end

                if second_half then
                    table.insert(all_panels, panel_idx+1, second_half)
                    -- re eval remaining width
                    rem_after_cur = self.ActiveRow.RemainingWidth - cur_panel.w
                    split_label = true
                else
                    -- couldn't split string
                    self:BreakRow()
                    break
                end
            end

            if cur_panel.h > max_height then max_height = cur_panel.h end
            tot_width = tot_width + cur_panel.w

            cur_panel.panel:SetParent(row)
            self.ActiveRow.RemainingWidth = rem_after_cur
            panel_idx = panel_idx + 1

            if split_label then
                self:BreakRow()
                break
            end
        end

        self.ActiveRow.CurrentHeight = max_height

        row:SetSize(tot_width, max_height)
        row:InvalidateChildren()

        for _,pan in pairs(row:GetChildren()) do
            pan:InvalidateLayout()

            for _,child in pairs(pan:GetChildren()) do
                child:Center()
            end
        end

        imax = imax + 1
        if imax > 100 then print("WARNING: Text processing too much. Breaking to prevent infinite loop.") break end
    end
end

function PANEL:NewActiveRow()
    self.ActiveRow.Panel = self:MakeNewRow()
    self.ActiveRow.RemainingWidth,_ = self:GetCanvas():GetSize()
    self.ActiveRow.CurrentHeight = 0
end

function PANEL:Init()
    self:GetCanvas():SetMinimumSize(250)
end

function PANEL:BreakRow()
    self.ActiveRow.Panel = nil
    self.ActiveRow.RemainingWidth = nil
    self.ActiveRow.CurrentHeight = 0
end

function PANEL:GetActiveRow()
    if not self.ActiveRow.Panel then
        self:NewActiveRow()
    end

    return self.ActiveRow.Panel
end

derma.DefineControl("DWrapPanel", "Canvas with wordwrap capabilities for arbitrary panels", PANEL, "DScrollPanel")
