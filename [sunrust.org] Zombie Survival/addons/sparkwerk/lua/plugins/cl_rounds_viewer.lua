local function WinRow(p, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(0, 115, 184))
end

local function LoseRow(p, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(0, 114, 0))
end

function SparkWerk.OpenRoundsViewer(data)
    local win = sui.Build("DFrame")
        :SetSize(800, 500)
        :Center()
        :SetTitle("Rounds (past 25)")
        :Build()

    local list = sui.Build("DListView", win)
        :Dock(FILL)
        :SetSortable(false)
        :AddColumn("Start")
        :AddColumn("Map")
        :AddColumn("Duration")
        :AddColumn("End Wave")
        :AddColumn("Avg Points")
        :AddColumn("Start Pop")
        :AddColumn("Win")
        :Build()

    list.Columns[1]:SetWidth(100)
    list.Columns[2]:SetWidth(150)
    list.Columns[3]:SetWidth(40)
    list.Columns[4]:SetWidth(50)
    list.Columns[5]:SetWidth(70)

    for k, v in ipairs(data) do
        local start_time = os.date("%b %d %I:%M %p", v.start_time)
        local duration = os.date("!%M:%S", (v.end_time or v.start_time) - v.start_time)

        local win
        if v.win == 1 then
            win = "WON"
        elseif v.win == 0 then
            win = ""
        else
            win = "NO CONTEST"
        end

        local end_wave
        if string.find(v.map_name, "_obj_") then
            end_wave = ""
        else
            end_wave = v.end_wave
        end

        local line = list:AddLine(
            start_time,
            v.map_name,
            duration,
            end_wave,
            v.avg_points or 0,
            v.start_pop,
            win)

        if v.win == 1 then
            line.Paint = WinRow
        end
    end

    win:SetSkin("sunrust")
    win:MakePopup()
end

net.Receive("SR.RoundData", function(len)
    local data = net.ReadTable()
    SparkWerk.OpenRoundsViewer(data)
end)
