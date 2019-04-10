
local function CreateFont(name, tab)
    surface.CreateFont(name, tab)
--  tab.blursize = 3
--  surface.CreateFont(name .. "blur", tab)
end

local function FontScale(size)
    return math.max(size * (ScrW() / 1280), 8)
end

local font_name = "Philosopher"

CreateFont("largeshop", {
    font = font_name,
    size = FontScale(16),
    weight = 600,
    antialias = true,
    extended = false,
    outline = false
})

CreateFont("hugeshop", {
    font = font_name,
    size = FontScale(27),
    weight = 800,
    antialias = true,
    extended = false,
    outline = false
})

CreateFont("humungoshop", {
    font = font_name,
    size = FontScale(35),
    weight = 200,
    antialias = true,
    extended = false,
    outline = false
})

CreateFont("smallshop", {
    font = font_name,
    size = FontScale(10),
    weight = 0,
    antialias = true,
    shadow = true,
    outline = false
})

CreateFont("tinyshop", {
    font = font_name,
    size = FontScale(8),
    weight = 0,
    antialias = true,
    shadow = true,
    outline = false
})
