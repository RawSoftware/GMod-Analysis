surface.CreateFont("TitleBar", {
    font = "Trebuchet MS",
    size = 15 * (ScrH()/720),
    weight = 400,
    antialias = true,
    shadow = false,
    extended = true,
    outline = false
})

surface.CreateFont("MapImagePanelTitle", {
    font = "Trebuchet MS",
    size = 25 * (ScrH()/720),
    weight = 700,
    antialias = true,
    shadow = false,
    extended = true,
    outline = false
})

surface.CreateFont("MapBar", {
    font         = "Arial",
    size         = 15,
    weight         = 700,
    antialias     = true,
})

surface.CreateFont("MapDesc", {
    font         = "Tahoma",
    size         = 12,
    weight         = 400,
    antialias     = true,
})

surface.CreateFont("MapName", {
    font         = "Tahoma",
    size         = 17,
    weight         = 700,
    antialias     = true,
    italic        = true,
})

surface.CreateFont("MapVotes", {
    font         = "HalfLife2",
    size         = 17,
    weight       = 900,
    antialias    = true,
    shadow       = false,
    extended     = true,
    outline      = false
})

surface.CreateFont("MapVotesLocked", {
    font         = "Arial",
    size         = 17,
    weight       = 900,
    antialias    = true,
    shadow       = false,
    extended     = true,
    outline      = false
})

local sparkwerk_mapvotingmenu = 0

local function EasyLabel(parent, text, font, textcolor)
	local dpanel = vgui.Create("DLabel", parent)
	if font then
		dpanel:SetFont(font or "DefaultFont")
	end
	dpanel:SetText(text)
	dpanel:SizeToContents()
	if textcolor then
		dpanel:SetTextColor(textcolor)
	end
	dpanel:SetKeyboardInputEnabled(false)
	dpanel:SetMouseInputEnabled(false)

	return dpanel
end

SparkWerk.TopMaps = {}
SparkWerk.LockedMaps = {}

local vote = 0
local winner
local lastclick = 0

net.Receive("sparkwerk_openmapvote", function()
    SparkWerk:RetrieveMaps()
end)

net.Receive("sparkwerk_green_maps", function()
    for i = 1, SparkWerk.RecommendedGreenMaps do
        local file_name = net.ReadString()

        SparkWerk.TopMaps[file_name] = true
    end
end)

net.Receive("sparkwerk_locked_maps", function()
    local locked = net.ReadTable()

    for fn, left in pairs(locked) do
        SparkWerk.LockedMaps[fn] = left
    end
end)

net.Receive("sparkwerk_map_vote_winner", function()
    winner = net.ReadString()
    surface.PlaySound("npc/scanner/combat_scan5.wav")
end)

net.Receive("sparkwerk_map_voting_started", function()
    voting_started = CurTime()
end)

SparkWerk.MapWorth = {}

net.Receive("sparkwerk_map_vote_count", function()
    local mapfn = net.ReadString()
    local value = net.ReadInt(16)

    SparkWerk.MapWorth[mapfn] = value
end)

function SparkWerk:RetrieveMaps()
    http.Fetch("http://142.44.142.152/" .. SparkWerk.VoteMapListFile(), function(body, _, __, code)
        if code <= 303 then
            SparkWerk.MapInfo = util.JSONToTable(body)
            SparkWerk:MakeVoteMap()
        else
            ErrorNoHalt(string.format("[RetrieveMaps] Failed to retrieve map list from server! Error code: %d. Tell a developer on the discord.", code))
        end
    end, function()
        ErrorNoHalt("[RetrieveMaps] Failed to retrieve map list from server! Tell a developer on the discord.")
    end)
end

local current_map_file_name = nil
function SparkWerk.GetMapImage(map_panel, file_name)
    current_map_file_name = file_name
    local map_image_url = "http://sunrust.org" .. SparkWerk.MapImagesDirectory() .. file_name .. ".jpg"

    map_panel:SetVisible(true)
    map_panel.Image:SetVisible(false)
    map_panel.LoadingIndicator:SetVisible(true)

    webmaterial.Get(map_image_url, "map_images", function(material)
        local votemap_visible = SparkWerk.VoteMap and SparkWerk.VoteMap:IsVisible()
        if file_name ~= current_map_file_name or not votemap_visible then
            return
        end

        if not material then
            map_panel.LoadingIndicator:SetVisible(false)
            return
        end

        map_panel.Image:SetMaterial(material)

        map_panel:SetVisible(true)
        map_panel.Image:SetVisible(true)
        map_panel.LoadingIndicator:SetVisible(false)
    end)
end

local function BetterScreenScale()
	return math.max(ScrH() / 1080, 0.851)
end

local grey = Color(160, 160, 160, 255)
function SparkWerk:MakeVoteMap()
    if self.VoteMap then
        local menu = self.VoteMap

        menu:SetVisible(true)
        menu:MakePopup()
        return
    end

    if not SparkWerk.MapInfo then
        return
    end

    local wid, hei = math.min(ScrW(), 650) * 1, math.min(ScrH(), 850) * 1

    local y = 4

    local frame = vgui.Create("DFrame")
    frame:SetDeleteOnClose(false)
    frame:SetSize(wid, hei)
    frame:SetTitle(" ")
    frame:Center()

    local frame_x, frame_y = frame:GetPos()

    local diff_from_one = math.max(0, (1 - BetterScreenScale()) / 0.15)

    frame:SetPos(frame_x - 160 * diff_from_one, frame_y)
    frame:SetSkin("sunrust")
    -- frame.Paint = function()
    --     draw.RoundedBox( 16, 0, 0, wid + 2, hei, Color(10,10,10,240))
    --     draw.RoundedBoxEx( 16, 0, 0, wid + 2, 32, Color(20,20,20,170), true, true, false, false)
    -- end

    local label = EasyLabel(frame, "VoteMap", "TitleBar", color_white)
    label:SetPos(wid * 0.5 - label:GetWide() * 0.5, y)
    y = y + label:GetTall() + 32

    self.VoteMap = frame

    local itemframe = vgui.Create("DScrollPanel", frame)
    itemframe:SetSize(wid - 24, hei - y - 12)
    itemframe:SetPos(16, y)

    local rowheight = 48

    local grid = vgui.Create("DGrid", itemframe)
    grid:SetCols(2)
    grid:SetColWide(wid/2.1)
    grid:SetRowHeight(rowheight + 16)

    local map_side_panel = vgui.Create("DPanel")
    map_side_panel:SetSize(512, 512)
    map_side_panel:MoveRightOf(frame, 16)
    map_side_panel:SetSkin("sunrust")

    frame_y = frame:GetTall()

    map_side_panel:MoveBelow(frame, -frame_y)
    map_side_panel:SetVisible(false)

    local map_name_label = EasyLabel(map_side_panel, "VoteMap", "MapImagePanelTitle", color_white)
    map_name_label:CenterVertical(0.1)
    map_name_label:CenterHorizontal(0.5)
    map_side_panel.Name = map_name_label

    local map_loading_panel = EasyLabel(map_side_panel, "Loading preview...", "MapName", grey)
    map_loading_panel:Center()
    map_side_panel.LoadingIndicator = map_loading_panel

    local map_image_panel =
    sui.Build("DImage", map_side_panel)
        :SetKeepAspect(true)
        :SetSize(512, 288)
        :Center()
        :Build()

    map_side_panel.Image = map_image_panel

    frame.OnClose = function(me)
        map_side_panel:SetVisible(false)
    end

    local bottomhei = 18
    local tophei = 24

    local function AddButtonToVoteGrid(file_name, map_data, top)
        local btn = vgui.Create("DButton", frame)
        btn:SetText("")
        btn:SetSize(280, rowheight)
        btn.Paint = function() end
        btn.DoClick = function()
            if lastclick < CurTime() - 2 and not winner then
                lastclick = CurTime()
                surface.PlaySound("buttons/lightswitch2.wav")

                vote = file_name
                RunConsoleCommand("sparkwerk_mapvote", file_name)
            end
        end

        local locked = SparkWerk.LockedMaps[file_name]

        local view = vgui.Create("DPanel", btn)
        view:SetSize(btn:GetWide(), btn:GetTall())
        view.Paint = function(me, width, height)
            local is_winner = winner and file_name == winner
            local alpha =
                winner and is_winner and 90 or
                winner and 10 or
                top and 30 or
                locked and 30 or
                30

            draw.RoundedBox( 8, 0, 0, width, height, Color(
                    locked and 200 or (not winner and top or is_winner) and 40 or 40,
                    (not winner and top or is_winner) and 90 or 40,
                    40,
                    alpha
                )
            )
            draw.RoundedBoxEx( 8, 0, 0, width, tophei, Color(200,200,200,11), true, true, false, false)
            draw.RoundedBoxEx( 8, 0, 0 + height - bottomhei, width, bottomhei, Color(200,200,200,11), false, false, true, true)

            local votes = SparkWerk.MapWorth[file_name] or 0
            surface.SetDrawColor(240, 150, 30, 90)
            surface.DrawRect(0, 0 + tophei, width * math.min(1, votes/350), 4)

            local title_color = Color(
                top and 130 or 195,
                top and 230 or 195,
                top and 130 or 195
            )

            draw.SimpleText(map_data.title, "MapName", 8, tophei/2, title_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

            local locked_font = locked and "MapVotesLocked" or "MapVotes"
            local locked_text = locked and (locked == 0 and "Locked" or (locked .. " Maps Left"))

            draw.SimpleText(locked and locked_text or tostring(votes), locked_font, width - 20, height - bottomhei/2, Color(255, locked and 100 or 255, locked and 100 or 255,200), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
            draw.SimpleText(file_name, "MapDesc", 20, height - bottomhei/2, Color(255,255,255,190), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

            if map_data.Bots then
                draw.SimpleText("Bots", "MapDesc", width - 20, tophei/2, Color(255,255,75,190), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
            end

            if btn.Hovered then
                draw.RoundedBox( 8, 0, 0, width, height, Color(240,70,40,15))

                if not SparkWerk.CurrentlyHoveredMap or SparkWerk.CurrentlyHoveredMap ~= btn then
                    SparkWerk.CurrentlyHoveredMap = btn
                    SparkWerk.GetMapImage(map_side_panel, file_name)

                    map_side_panel.Name:SetText(map_data.title)
                    map_side_panel.Name:SizeToContents()
                    map_side_panel.Name:CenterVertical(0.1)
                    map_side_panel.Name:CenterHorizontal(0.5)
                end
            end
        end
        view:SetMouseInputEnabled(false)

        grid:AddItem(btn)
    end

    local stored_top_info = {}
    for map_name, _ in pairs(SparkWerk.TopMaps) do
        stored_top_info[map_name] = SparkWerk.MapInfo[map_name]
        SparkWerk.MapInfo[map_name] = nil
    end

    for file_name, map_data in pairs(stored_top_info) do
        AddButtonToVoteGrid(file_name, map_data, true)
    end

    local not_locked = {}
    for file_name, map_data in pairs(SparkWerk.MapInfo) do
        if not SparkWerk.LockedMaps[file_name] then
            not_locked[#not_locked + 1] = {file_name, map_data}
        end
    end
    table.sort(not_locked, function(a, b)
        return b[2].title > a[2].title
    end)
    for _, data in ipairs(not_locked) do
        AddButtonToVoteGrid(data[1], data[2])
    end

    for file_name, map_data in pairs(SparkWerk.MapInfo) do
        if SparkWerk.LockedMaps[file_name] then
            AddButtonToVoteGrid(file_name, map_data)
        end
    end

    frame:MakePopup()
end

function SparkWerk.MakeMapVoteMenu(x, y, no, fn)
    if not fn then return end

    local mx = gui.MouseX()
    local my = gui.MouseY()
    local hov = false
    local wid, hei = 256, 46

    if (mx > x) and (mx < (x+wid)) and (my > y) and (my < (y+hei)) then
        hov = true

        if input.IsMouseDown(MOUSE_LEFT) and lastclick < CurTime() - 2 and winner == 0 then
            lastclick = CurTime()
            surface.PlaySound( "buttons/lightswitch2.wav" )

            vote = no
            RunConsoleCommand("sparkwerk_mapvote", no)
        end
    end

    local bottomhei = 18
    local tophei = 24

    draw.RoundedBox( 8, x, y, wid, hei, (winner == 0 or winner == no) and Color(60,60,60,7) or Color(60,140,130,6))
    draw.RoundedBoxEx( 8, x, y, wid, tophei, (winner == 0 or winner == no) and Color(200,200,200,11) or Color(200,170,160,7), true, true, false, false)
    draw.RoundedBoxEx( 8, x, y + hei - bottomhei, wid, bottomhei, (winner == 0 or winner == no) and Color(200,200,200,11) or Color(200,170,160,7), false, false, true, true)

    local votes = tonumber(SparkWerk.MapWorth[no])

    surface.SetDrawColor(70, 200, 70, 100)
    surface.DrawRect(x, y + tophei, wid * math.min(1, votes/350), 4)

    if hov then draw.RoundedBox( 8, x, y, wid, hei, Color(150,220,50,10)) end

    if vote == no and winner == 0 then draw.RoundedBox( 8, x, y, wid, hei, Color(120,250,120,4)) end

    draw.SimpleText(votes, "MapVotes", x + wid - 20, y + hei - bottomhei/2, Color(255,255,255,200), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    draw.SimpleText(fn, "MapDesc", x + 20, y + hei - bottomhei/2, Color(255,255,255,100), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

    if topfourmaps[no][4] then
        draw.SimpleText("Bots", "MapDesc", x + wid - 20, y + tophei/2, Color(255,255,155,100), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    end
end

function SparkWerk:MapVoteScreen()
    if sparkwerk_mapvotingmenu != 1 then return end

    local w = 600
    local h = 700
    local x = (ScrW()/2)-(w/2)
    local y = (ScrH()/2)-(h/2)

    local close_w, close_h = 32, 24
    local close_x, close_y = x+w-close_w, y

    local mx = gui.MouseX()
    local my = gui.MouseY()
    if (mx > close_x) and (mx < (close_x+close_w)) and (my > close_y) and (my < (close_y+close_h)) and input.IsMouseDown(MOUSE_LEFT) then
        sparkwerk_mapvotingmenu = 0
        gui.EnableScreenClicker(false)
    end

    draw.RoundedBox( 16, x, y, w, h, Color(10,10,10,240))
    draw.RoundedBoxEx( 16, x, y, w, 32, Color(20,20,20,170), true, true, false, false)

    draw.RoundedBoxEx( 16, close_x, close_y, close_w, close_h, Color(80,20,20,230), false, true, false, false)

    draw.SimpleText("Map Voting", "TitleBar", x + w/2, y + 2, Color(255,255,255,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    local dift = CurTime() - starttime

    timeleft = math.floor(30 - dift)
    timeleftwin = math.floor(35 - dift)

    local pillwidth = 240

    if voting_started then
        draw.RoundedBox( 8, x + w/2 - pillwidth/2, y + h - 41, 240, 16, Color(20,20,20,180))

        if timeleft > -1 then
            draw.SimpleText("Time to vote: " .. tonumber(timeleft) .. " seconds", "MapVotes", x + w/2, y + h - 32, Color(255,255,255,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        else
            draw.SimpleText("Next map in: " .. tonumber(timeleftwin) .. " seconds", "MapVotes", x + w/2, y + h - 32, Color(255,255,255,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end

    for i=1, SparkWerk.RecommendedGreenMaps do
        local spacer = i-1

        SparkWerk.MakeMapVoteMenu(x+20+(spacer % 2) * 304, y+40+math.floor(spacer / 2)*64, i, topfourmaps[i][1])
    end
end
