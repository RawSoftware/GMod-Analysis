if CLIENT then
    local function PaintExpired(p, w, h, color)
        draw.RoundedBox( 0, 0, 0, w, h, color )
    end

    local pun_colors = {
        ban           = Color(255,0,0),
        ballpit       = Color(255,255,0),
        chat_mute     = Color(0,128,255),
        voice_mute    = Color(128,0,255),
        spray_ban     = Color(255, 82, 0),
        nest_ban      = Color(255, 162, 120),
        rubber_hammer = Color(0,255,255),
    }

    local function OpenPunishmentEditor(puns)
        local h = ScrH() * 0.8
        local w = ScrW() * 0.6

        local menu = vgui.Create("DFrame")
        menu:SetSkin("sunrust")
        menu:SetSize(w,h)
        menu:SetTitle("Punishments Editor")
        menu:SetDraggable(true)
        menu:SetSizable(true)
        menu:Center()

        local punish_list = vgui.Create("DListView", menu)
        punish_list:Dock(FILL)
        punish_list:SetMultiSelect(false)
        punish_list:AddColumn("Player Name")
        punish_list:AddColumn("SteamID")
        punish_list:AddColumn("Punishment Type")
        punish_list:AddColumn("Admin Name")
        punish_list:AddColumn("Reason")
        punish_list:AddColumn("Expires")
        punish_list:AddColumn("Time Left")

        for _,pun in pairs(puns) do
            local expires      = tonumber(pun.Expires)
            local timeleft     = expires - os.time()
            local expires_str  = (expires == 0) and "Never" or os.date("%x at %I:%M%p", expires)
            local timeleft_str = (expires == 0) and "Forever" or TimeToEnglish(timeleft)

            local line = punish_list:AddLine(pun.Name, util.SteamIDFrom64(pun.SteamID64), pun.Type, pun.AdminName, pun.Reason, expires_str, timeleft_str)
            line.Columns[3]:SetTextColor(pun_colors[pun.Type])

            if expires ~= 0 and os.time() > expires then
                for k,v in pairs(line.Columns) do
                    v:SetTextColor(Color(180,180,180))
                end
                line.Columns[7]:SetText("Expired")
            end
        end

        menu:MakePopup()

        punish_list.OnRowRightClick = function(lst, index, pnl)
            local steamid = pnl:GetColumnText(2)
            local type = pnl:GetColumnText(3)

            local submenu = DermaMenu()

            local rem = submenu:AddOption("Remove..",function()
                net.Start("UnPunish")
                    net.WriteString(puns[index].SteamID64)
                    net.WriteString(type)
                net.SendToServer()
                punish_list:RemoveLine(index)
            end)

            rem:SetIcon("icon16/cross.png")

            submenu:Open()
        end
    end

    local punishments = {}
    net.Receive("SparkWerkPunishmentsDone", function()
        OpenPunishmentEditor(punishments)
        punishments = {}
    end)

    net.Receive("SparkWerkPunishmentsPage", function()
        local num_punish  = net.ReadInt(32)
        for i = 1, num_punish do
            local entry = {}
            entry.SteamID64   = net.ReadString()
            entry.Name        = net.ReadString()
            entry.Type        = net.ReadString()
            entry.AdminName   = net.ReadString()
            entry.Reason      = net.ReadString()
            entry.Expires     = net.ReadString()
            table.insert(punishments, entry)
        end
    end)
end

if SERVER then
    util.AddNetworkString("SparkWerkPunishmentsPage")
    util.AddNetworkString("SparkWerkPunishmentsDone")
    util.AddNetworkString("UnPunish")

    net.Receive("UnPunish", function(l, ply)
        if not ply:IsMod() then return end

        local sid64 = net.ReadString()
        local type = net.ReadString()

        local entry = SparkWerk.RemovePunishment(sid64, type, true)
        if not entry then return end

        PrintAdminAction(ply, " has undone a " .. type .. " on ", Color(255, 82, 0), entry.Name)

        local msg = ":negative_squared_cross_mark: " .. ply:Name() .. " has undone a " .. type .. " on " .. entry.Name
        discord.PostToChannel("game_servers_info", msg)
    end)

    chatcmd.Add({
        name = "punishview",
        cat  = "admin - punish",
        help = "Opens the punishments editor",
        perm = "mod",
        func = function(ply, cmd, args)
            local cur_page = 0
            local page_amount = 0

            for i, entry in ipairs(SparkWerk.Punishments) do
                if page_amount == 0 then
                    net.Start("SparkWerkPunishmentsPage")
                    net.WriteInt(math.min(100, #SparkWerk.Punishments - i + 1), 32)
                end

                net.WriteString(entry.SteamID64)
                net.WriteString(entry.Name or "None")
                net.WriteString(entry.Type)
                net.WriteString(entry.AdminName)
                net.WriteString(entry.Reason or "None")
                net.WriteString(entry.Expires or "0")

                page_amount = page_amount + 1

                if i == #SparkWerk.Punishments or page_amount == 100 then
                    net.Send(ply)
                    page_amount = 0
                end
            end

            net.Start("SparkWerkPunishmentsDone")
            net.Send(ply)
        end
    })
end
