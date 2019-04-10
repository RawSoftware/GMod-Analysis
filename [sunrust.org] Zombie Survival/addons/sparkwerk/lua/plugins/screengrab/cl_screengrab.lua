local function InitiateScreengrab()
    hook.Add("PostRender", "SparkWerk.DoScreengrab", function()
        hook.Remove("PostRender", "SparkWerk.DoScreengrab")

        local imgw = math.min(ScrW(), 1920)
        local imgh = math.min(ScrH(), 1080)

        local rtdownscale = GetRenderTargetEx("SparkWerk.ScreengrabDownscale", imgw, imgh, RT_SIZE_NO_CHANGE, MATERIAL_RT_DEPTH_NONE, 0, 0, IMAGE_FORMAT_DEFAULT)
        render.CopyRenderTargetToTexture(rtdownscale)

        render.PushRenderTarget(rtdownscale)
        local data = render.Capture({
            format = "jpeg",
            quality = 50,
            h = ScrH(),
            w = ScrW(),
            x = 0,
            y = 0,
        })
        render.PopRenderTarget()

        SparkWerk.SendScreenGrab(data)
    end)
end

net.Receive("RequestScreengrab", function(lene, ply)
    InitiateScreengrab()
end)

local cur_chunks = {}

net.Receive("ScreengrabChunk", function(lene, ply)
    local len = net.ReadInt(32)
    local data = net.ReadData(len)

    table.insert(cur_chunks, data)
end)

net.Receive("FinishScreengrab", function(lene, ply)
    local final_img_data = table.concat(cur_chunks, "")
    cur_chunks = {}

    local tim = os.time()
    local imgname = "sr_captures/ScreenGrab" .. tim .. ".jpg"

    file.CreateDir("sr_captures")

    local f = file.Open(imgname, "wb", "DATA")
    f:Write(final_img_data)
    f:Close()

    local mat = Material("data/" .. imgname)

    local frame = vgui.Create("DFrame")
    frame:SetSize(ScrW(), ScrH())
    frame:Center()
    frame:SetTitle("Screen Grab")

    local img_holder = vgui.Create("DPanel", frame)
    img_holder:Dock(FILL)

    local img = vgui.Create("DImage", img_holder)
    img:Dock(FILL)
    img:SetPos(0,0)
    img:SetMaterial(mat)
    img:SizeToContents()
    img:Center()

    frame:MakePopup()
end)
