
sparkchat = {}

sparkchat.data = {}
sparkchat.data.current_color = Color(255,255,255)
sparkchat.data.max_image_size = 48

include"cl_fonts.lua"


function sparkchat:SetDefaultColor(col)
    sparkchat.data.current_color = col
end

function sparkchat:GetDefaultColor()
    return sparkchat.data.current_color
end

function sparkchat:SetMaxImageSize(size)
    sparkchat.data.max_image_size = size or 48
end

include"cl_tags.lua"
include"cl_markup.lua"
include"dwrappanel.lua"
include"dframeimproved.lua"
include"demberdisplay.lua"
include"dlabelpulse.lua"
include"dimagerotate.lua"
include"cl_chatbox.lua"

net.Receive("sw_printchat", function()
    local tbl = net.ReadTable()
    table.insert(tbl, 1, Color(255, 255, 255))

    chat.AddText(true, unpack(tbl))
end)
