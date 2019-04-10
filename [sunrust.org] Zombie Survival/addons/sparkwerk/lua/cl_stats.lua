Stats = {}

Stats.Ranks = {}
Stats.StatNames = {}
Stats.MyRanks = {}

net.Receive("Stats.SendRanks", function()
    local tabname = net.ReadString()
    local statname = net.ReadString()
    local ranks = net.ReadTable()

    Stats.Ranks[tabname] = Stats.Ranks[tab] or {}
    Stats.Ranks[tabname][statname] = ranks

    hook.Run("StatsGetRanks", tabname, statname, ranks)
end)

net.Receive("Stats.GetMyRank", function()
    local cat = net.ReadString()
    local stat = net.ReadString()
    local rank = net.ReadInt(32)
    local amt = net.ReadString()

    Stats.MyRanks[cat] = Stats.MyRanks[cat] or {}

    Stats.MyRanks[cat][stat] = {rank = rank, value = amt}

    hook.Run("StatsGetMine", cat, stat, rank, amt)
end)

net.Receive("Stats.TransferStatNames", function()
    local cat = net.ReadString()
    local names = net.ReadTable()
    Stats.StatNames[cat] = names

    hook.Run("StatsGetNames", cat, names)
end)

local function PaintMyRow(p, w, h)
    draw.RoundedBox( 0, 0, 0, w, h, Color( 100, 100, 200 ) )
end

local function PopulateStat(list, alias, name)
    if not Stats.Ranks[alias] then return false end
    if not Stats.Ranks[alias][name] then return false end
    list:Clear()

    for rank, info in pairs(Stats.Ranks[alias][name].Data) do
        steamworks.RequestPlayerInfo(info.SteamID64, function(name)
            if not IsValid(list) then return end
            local line = list:AddLine(info.rank, name, string_comma_value(info.stat or "0"))

            if info.SteamID64 == LocalPlayer():SteamID64() then
                line.Paint = PaintMyRow
            else
                line.OnRightClick = function()
                    gui.OpenURL("http://steamcommunity.com/profiles/" .. info.SteamID64)
                end
            end

            list:SortByColumn(1)
        end)
    end

    return true
end

local function PopulateMyStat(list, alias, name)
    if not Stats.MyRanks[alias] then return false end
    local mystatinfo = Stats.MyRanks[alias][name]
    if not mystatinfo then return false end

    local line = list:AddLine(mystatinfo.rank, LocalPlayer():Nick(), string_comma_value(mystatinfo.value))
    line.Paint = PaintMyRow
end

local function RequestRanks(alias, stat)
    net.Start("Stats.RequestRanks")
        net.WriteString(alias)
        net.WriteString(stat)
    net.SendToServer()
end

local function AddStatPanel(category, name, pname)
    local list = vgui.Create("DListView")
    list.StatName = name
    list:Dock(FILL)
    list:SetSortable(false)
    list:AddColumn("Rank")
    list:AddColumn("Player Name")
    list:AddColumn(pname)

    if not PopulateStat(list, category, name) then
        RequestRanks(category, name)

        hook.Add("StatsGetRanks", tostring(list), function(tabname, stat, ranks)
            if not IsValid(list) then return end
            if tabname == category and stat == name then
                PopulateStat(list, category, name)
            end
        end)
    end

    if not PopulateMyStat(list, category, name) then
        hook.Add("StatsGetMine", tostring(list), function(tabname, stat, rank, value)
            if not IsValid(list) then return end
            if tabname == category and stat == name then
                PopulateMyStat(list, category, name)
            end
        end)
    end

    return list
end

local function MakeStatWindow(category, name, pname)
    local win = vgui.Create("DFrame")
    win:SetSize(500,500)
    win:Center()
    win:SetTitle(pname)

    local list = AddStatPanel(category, name, pname)
    list:SetParent(win)
    win:SetSkin("sunrust")
    win:MakePopup()
end

local function SetupList(cat, list)
    for _, statinfo in pairs(Stats.StatNames[cat]) do
        local name, prettyname = unpack(statinfo)
        local line = list:AddLine(prettyname)
        line.StatCat  = cat
        line.StatName = name
        line.StatPrettyName = prettyname
    end
end

local function MakeMainWindow(cat)
    local win = vgui.Create("DFrame")
    win:SetSize(500,500)
    win:Center()
    win:SetTitle("Rankings (" .. cat .. ")")
    win:SetSkin("sunrust")

    local list = vgui.Create("DListView", win)
    list:Dock(FILL)
    list:AddColumn("Stat Name (Click to open window)")
    list:SetSortable(false)

    list.OnRowSelected = function(pan, index, rowpan)
        MakeStatWindow(rowpan.StatCat, rowpan.StatName, rowpan.StatPrettyName)
    end

    if #Stats.StatNames > 0 then
        SetupList(cat, list)
    else
        net.Start("Stats.RequestStatNames")
            net.WriteString(cat)
        net.SendToServer()

        hook.Add("StatsGetNames", tostring(win), function(cat, names)
            if not IsValid(win) then return end
            SetupList(cat, list)
            win:SetSkin("sunrust")
            win:MakePopup()
        end)
    end
end

concommand.Add("topranks_zs", function()
    if engine.ActiveGamemode() ~= "zombiesurvival" then return end
    MakeMainWindow("zs")
end)
