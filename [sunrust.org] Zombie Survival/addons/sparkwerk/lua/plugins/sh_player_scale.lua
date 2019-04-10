if CLIENT then
    net.Receive("player_scale", function()
        local pl = net.ReadEntity()
        local scale = net.ReadFloat()
        SetPlayerScale(pl, scale)
    end)
end

if SERVER then
    util.AddNetworkString("player_scale")

    hook.Add("PlayerSpawn", "PlayerScale", function(ply)
        if ply.scale_persistent and ply.local_scale then
            timer.Simple(0, function() SetPlayerScale(ply, ply.local_scale) end)
            return
        end

        if ply.local_scale then
            SetPlayerScale(ply, 1)
        end
    end)

    local function chat_func(ply, cmd, args)
        local scale = tonumber(args.scale)
        if not scale then
            ply:ChatPrint("Error - Enter a valid number for scale")
            return
        end

        if args.persistent == "yes" then
            args.player.scale_persistent = true
        else
            args.player.scale_persistent = nil
        end

        SetPlayerScale(args.player, scale)
    end

    chatcmd.Add({
        name = "scale",
        cat  = "admin - utility",
        func = chat_func,
        args = {{"scale", 1}, {"p:player", "<self>"}, {"persistent", "no"}},
        help = "Scale size of a player",
        perm = "superadmin"
    })
end

function SetPlayerScale(ply, scale)
    -- scale of 0 just crashes the client instantly
    -- scale of 0.03 is about the lowest you can go
    -- without glitchy jumping/movement
    -- hull gets people stuck beyond 1.2x-ish
    scale = math.Clamp(scale, 0.03, 1.3)

    local transition_time = 1

    ply:SetHull(Vector(-16,-16,0)*scale,Vector(16,16,72)*scale)
    ply:SetHullDuck(Vector(-16,-16,0)*scale, Vector(16,16,36)*scale)

    ply:SetStepSize(18*scale)

    ply:SetViewOffset(Vector(0,0,64)*scale)
    ply:SetViewOffsetDucked(Vector(0,0,28)*scale)

    ply:SetModelScale(scale, transition_time)

    ply:SetSpeedMultiplier(math.pow(scale,1/1.5))
    ply:SetJumpMultiplier(math.pow(scale,1/4))

    ply.local_scale = scale

    if scale == 1 then
        ply:ResetHull()
        ply.local_scale = nil
    end

    if CLIENT and ply == LocalPlayer() then
        if scale < 1 then
            hook.Add("RenderScene", "MiniFixZNear", ZNearFix)
        else
            hook.Remove("RenderScene", "MiniFixZNear")
        end
    end

    if SERVER then
        net.Start("player_scale")
            net.WriteEntity(ply)
            net.WriteFloat(scale)
        net.Broadcast()
    end

    timer.Simple(transition_time, function()
        hook.Run("SetModelScale", ply, scale)
    end)
end

if CLIENT then
    function ZNearFix(origin,angles,fov)
        local v = {}
        v.drawhud = true
        v.drawmonitors = true
        v.dopostprocess = true
        v.znear = 3*LocalPlayer().local_scale

        cam.Start3D(EyePos(), EyeAngles(), nil, 0, 0, ScrW(), ScrH(), nil,nil)
            render.RenderView( v )
        cam.End3D()

        return true
    end
end
