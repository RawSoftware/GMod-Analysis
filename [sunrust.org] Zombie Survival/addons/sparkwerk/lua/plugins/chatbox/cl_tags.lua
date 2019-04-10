local sparkchat = sparkchat

local function GetTextSize(text)
    surface.SetFont(sparkchat.data.current_font)
    return surface.GetTextSize(text)
end

local function MakeNewText(text, markup)
    local w,h = GetTextSize(text)

    local col = sparkchat.data.current_color

    local texlab
    if markup and markup.name == "flash" then
        local args = markup.args
        local mode = args.self_arg

        texlab = vgui.Create("DLabelPulse")
        texlab:SetMode(mode)
        texlab:SetPeriod(args.rate)
        texlab:SetColors(args.colors)
    else
        texlab = vgui.Create("DLabel")
    end

      texlab:SetSize(w, h)
      texlab:SetText(text)
      texlab:SetSelectable(true)
      texlab:SetFont(sparkchat.data.current_font)
      texlab:SetSelectionCanvas(true)
      texlab:SetSelectable(true)

    local color = sparkchat.data.current_color

    if markup and markup.name == "color" then
        color = markup.args.self_arg
    end

    texlab:SetColor(color)

    return {panel = texlab, w = w, h = h, col = color}
end

local function Scale1080(w, h)
    return w * (ScrH()/1080),
           h * (ScrH()/1080)
end

local function SizeTokenImage(args, w, h, min, max, no_res_scaling)
    local token_height = h

    if args.size then
        token_height = tonumber(args.size) or 64
    end

    token_height = math.Clamp(token_height, min, max)
    -- to maintain image aspect ratio, base width on the clamped height
    local token_width = token_height * (w / h)

    -- also enforce a width limit for wider emotes
    token_width = math.Clamp(token_width, min, max * 2.5)
    token_height = token_width * (h / w)

    if not no_res_scaling then
        token_width, token_height = Scale1080(token_width, token_height)
    end

    return token_width, token_height
end

local col_white = Color(255,255,255)

local function MakeImage(token, noscale)
    local args = token.args
    local mat = args.mat
    local w,h = SizeTokenImage(args, mat:Width(), mat:Height(), 10, sparkchat.data.max_image_size, noscale)

    local img_frame = vgui.Create("DPanel")
    img_frame:SetSize(w, h)
    img_frame:SetTooltip(token.raw_text)
    img_frame.Paint = function() end

    local img = vgui.Create("DImageRotate", img_frame)
    img:SetSize(w, h)
    img:SetMaterial(mat)
    img:SetKeepAspect(true)
    img:SetRotation(tonumber(args.rot) or 0)
    img:SetRotationRate(tonumber(args.rotrate) or 0)

    if args.transrate then
        local trans_u, trans_v = unpack(string.Explode(",", args.transrate))
        trans_u = tonumber(trans_u) or 0
        trans_v = tonumber(trans_v) or 0
        img:SetTranslationRate(trans_u, trans_v)
    end

    if args.trans then
        local trans_u, trans_v = unpack(string.Explode(",", args.trans))
        trans_u = tonumber(trans_u) or 0
        trans_v = tonumber(trans_v) or 0
        img:SetTranslation(trans_u, trans_v)
    end

    if args.scale then
        local scale_x, scale_y = unpack(string.Explode(",", args.scale))
        scale_x = math.Clamp(tonumber(scale_x) or 1, -5, 5)
        scale_y = math.Clamp(tonumber(scale_y) or 1, -5, 5)
        img:SetScale(scale_x, scale_y)
    end

    if args.shear then
        local shear_u, shear_v = unpack(string.Explode(",", args.shear))
        shear_u = tonumber(shear_u) or 0
        shear_v = tonumber(shear_v) or 0
        img:SetShear(shear_u, shear_v)
    end

    img:Center()

    if args.color then
        local r,g,b = unpack(string.Explode(",",args.color))

        r = tonumber(r) or col_white.r
        g = tonumber(g) or col_white.g
        b = tonumber(b) or col_white.b

        img:SetImageColor(Color(r,g,b))
    end

    return {panel = img_frame, w = w, h = h}
end

local function MakeAvatar(tok)
    local w, h = SizeTokenImage(tok.args, 48, 48, 10, sparkchat.data.max_image_size)

    local img_frame = vgui.Create("DPanel")
    img_frame:SetSize(w, h)
    img_frame.Paint = function() end
    img_frame:DockPadding(1, 1, 1, 1)

    local avatar = vgui.Create("AvatarImage", img_frame)
    avatar:SetSize(w-2, h-2)
    avatar:Center()

    if tok.args.self_arg_override then
        local sid64 = util.SteamIDTo64(tok.args.self_arg_override)
        avatar:SetSteamID(sid64, 64)
    elseif tok.args.self_arg then
        local ingame_player = player.GetBySteamID(tok.args.self_arg)

        if ingame_player and ingame_player:IsValid() and ingame_player:IsPlayer() then
            avatar:SetPlayer(ingame_player, 64)
            local sid64 = util.SteamIDTo64(tok.args.self_arg)
            avatar:SetSteamID(sid64, 64)
        end
    else
        avatar:SetPlayer(LocalPlayer(), 64)
    end

    return {panel = img_frame, w = w, h = h}
end

local function MakeEmberDisplay(tok)
    local background =
    sui.Build("DPanel")
        :SetSize(w, h)
        :Set("Paint", nil)
        :DockPadding(1, 1, 1, 1)
        :Build()

    local ember_display =
    sui.Build("DEmberDisplay", background)
        :SetMySize(14)
        :Build()

    local amount = tonumber(tok.args.self_arg)

    if amount then
        amount = math.Clamp(math.Round(amount), 0, 1e8)
        ember_display:SetAmount(amount)
    else
        ember_display:SetAmount(0)
        ember_display:SetDisplayVisible(false)
    end

    ember_display:SizeToChildren(true, true)
    ember_display:Center()

    background:SizeToChildren(true, true)

    local w, h = ember_display:GetSize()
    return {panel = background, w = w, h = h}
end

local default_icon = Material("materials/icon16/cross.png")
local sunrust_icon = Material("sparkwerk/sr-16")
local ember_icon = Material("sparkwerk/ember-64")

local function MakeIcon(tok)
    local icon = tok.args.self_arg or "cross"

    local mat = Material("materials/icon16/" .. icon .. ".png")

    if not mat:IsError() then tok.args.mat = mat
    else tok.args.mat = default_icon
    end

    return MakeImage(tok, true)
end

local function MakeSunrustIcon(tok)
    tok.args.mat = sunrust_icon
    return MakeImage(tok, true)
end

sparkchat.internal_tags =
{
    ["(image)"]  = MakeImage,
    ["(text)"] = function(token) return MakeNewText(table.concat(token.args, " "), token.markup) end,
}

sparkchat.tags =
{
    ["icon"]     = MakeIcon,
    ["sunrust"]  = MakeSunrustIcon,
    ["avatar"]   = MakeAvatar,
    ["ember"]    = MakeEmberDisplay,
}

function SparkWerk.LoadChatEmotes()
    local chatemote_path = "materials/sparkwerk/chat_emote"

    local files, _ = file.Find(chatemote_path .. "/*.png", "GAME")

    for _, f in pairs(files) do
        local mat        = Material(chatemote_path .. "/" .. f, "smooth nocull noclamp")
        local name_nopng = string.sub(f, 1, -5)

        sparkchat.tags[name_nopng] = {"(image)", mat = mat}
    end
end

SparkWerk.LoadChatEmotes()

local function GetTagMaker(token)
    do
        local tag_int = sparkchat.internal_tags[token.name]
        if tag_int then return tag_int end
    end

    local tag = sparkchat.tags[token.name]

    if istable(tag) then
        -- alias tag
        for k,v in pairs(tag) do
            if k ~= 1 then
                token.args[k] = v
            end
        end

        local master_tag = tag[1]
        tag = sparkchat.internal_tags[master_tag] or sparkchat.tags[master_tag]
    end

    return tag
end

function sparkchat.MakePanels(tokens)
    local tag_panels = {}

    for k,tok in pairs(tokens) do
        local tag_maker = GetTagMaker(tok)
        local tag_panel = tag_maker(tok)
        tag_panel.panel:Dock(LEFT)

        table.insert(tag_panels, tag_panel)
    end

    return tag_panels
end
