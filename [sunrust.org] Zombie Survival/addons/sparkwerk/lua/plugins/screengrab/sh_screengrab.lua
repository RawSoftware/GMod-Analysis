local chunk_size = 64000 -- bytes

function SparkWerk.SendScreenGrab(data, ply)
    timer.Create("SendingScreengrabFor".. (SERVER and ply:SteamID64() or "Server"), 0.1, math.ceil(string.len(data)/chunk_size), function()
        local curchunk = string.sub(data, 1, chunk_size)
        local curlen = string.len(curchunk)

        if SERVER then net.Start("ScreengrabChunk")
        else net.Start("ScreengrabChunkSV") end
            net.WriteInt(curlen, 32)
            net.WriteData(curchunk, curlen)
        if SERVER then net.Send(ply)
        else net.SendToServer() end

        data = string.sub(data, chunk_size + 1)

        if data == "" then
            if SERVER then
                net.Start("FinishScreengrab")
                net.Send(ply)
            else
                net.Start("FinishScreengrabSV")
                net.SendToServer()
            end
        end
    end)
end
