local PlayersClientJoined = {}

net.Receive("SendPlayersTable", function(len)
    PlayersClientJoined = net.ReadTable()
    PrintTable(PlayersClientJoined)
end)

net.Receive("spectate", function()
    local target = net.ReadEntity()
    local enable = net.ReadBool()

    if not enable then
        if not LocalPlayer().spectate_entity then return end
        hook.Remove("CalcView", "spec")
        LocalPlayer().spectate_entity = nil
        chat.AddText(true, ":icon=shield: You have stopped spectating ", target)
        return
    end

    LocalPlayer().spectate_entity = target

    hook.Add("CalcView", "spec", function(ply, pos, angles, fov)
        local view = {}

        view.origin = target:EyePos()
        view.angles = target:EyeAngles()
        view.fov = fov
        view.drawviewer = true

        return view
    end)

    chat.AddText(true, ":icon=shield: You are now spectating ", target)
end)
