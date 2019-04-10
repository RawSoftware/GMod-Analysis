local PLUGIN = {}

PLUGIN.Name = "Player Spray Indicator"
PLUGIN.Author = "Jammie Dodger"

SparkWerk:RegisterPlugin(PLUGIN)

if SERVER then
    util.AddNetworkString("PlayerSprayString")

    hook.Add("PlayerSpray", "SparkWerk.SprayProtection", function(ply)
        if not ply:IsMod() then
            SparkWerk.LogLine("<Player Sprayed> "..ply:Nick())
        end

        net.Start("PlayerSprayString")
            net.WriteEntity(ply)
            net.WriteVector(ply:GetEyeTraceNoCursor().HitPos)
        net.Broadcast()
    end)
end

if CLIENT then
    local player_sprays = {}

    net.Receive("PlayerSprayString", function( length, client )
        player_sprays[ net.ReadEntity():EntIndex() ] = net.ReadVector()
    end)

    hook.Add("HUDPaint", "SparkWerk.ShowSprayName", function()
        for entid, position in pairs( player_sprays ) do
            if position:Distance( LocalPlayer():GetEyeTrace().HitPos ) < 32 and LocalPlayer():GetPos():Distance(LocalPlayer():GetEyeTrace().HitPos) < 200 then
                draw.SimpleText( "Sprayed by:", "fatplus", 10, ScrH() / 2, Color( 255, 255, 255 ), 0, 1 )
                draw.SimpleText( Entity(entid):IsValid() and Entity(entid):Nick() or "Unknown", "fatplus", 10, (ScrH() / 2)+17, Color( 255, 255, 255 ), 0, 1 )

                break
            end
        end
    end)
end
