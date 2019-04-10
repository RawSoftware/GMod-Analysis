sparkchat.fonts = {
    large = {
        font = "Tahoma",
        size = 27 * (ScrH()/1080),
        weight = 100,
        antialias = true,
        shadow = true,
        extended = true,
        outline = false
    },
    eChat_18 = {
        font = "Tahoma",
        size = 20 * (ScrH()/1080),
        weight = 0,
        antialias = true,
        shadow = true,
        extended = true,
        outline = false
    },
    thin = {
        font = "Tahoma",
        size = 20 * (ScrH()/1080),
        weight = 0,
        antialias = true,
        shadow = true,
        extended = true,
        outline = false
    },
    fat = {
        font = "Tahoma",
        size = 20 * (ScrH()/1080),
        weight = 700,
        antialias = true,
        shadow = true,
        extended = true,
        outline = false
    },
    fat14 = {
        font = "Tahoma",
        size = 14 * (ScrH()/1080),
        weight = 700,
        antialias = true,
        shadow = true,
        extended = true,
        outline = false
    },
    thinplus = {
        font = "Tahoma",
        size = 24 * (ScrH()/1080),
        weight = 0,
        antialias = true,
        shadow = true,
        extended = true,
        outline = false
    },
    fatplus = {
        font = "Tahoma",
        size = 24 * (ScrH()/1080),
        weight = 700,
        antialias = true,
        shadow = true,
        extended = true,
        outline = false
    },
    chunky = {
        font = "Tahoma",
        size = 32 * (ScrH()/1080),
        weight = 700,
        antialias = true,
        shadow = true,
        extended = true,
        outline = false
    }
}

for fname, ftable in pairs(sparkchat.fonts) do
    surface.CreateFont(fname, ftable)
end

local default_font = "thin"
sparkchat.data.current_font  = default_font

function sparkchat:ValidFont(font)
    return sparkchat.fonts[font] ~= nil
end

function sparkchat:GetFont()
    return sparkchat.data.current_font
end

function sparkchat:GetFontSize(text)
    surface.SetFont(sparkchat:GetFont())
    return surface.GetTextSize(text)
end

function sparkchat:SetFont(font)
    if not sparkchat:ValidFont(font) then
        if sparkchat.box and IsValid(sparkchat.box.Root) then
            chat.AddText(true, string.format(":icon=error: Chatbox does not support the given font '%s'.", font))
        end

        return false
    end

    sparkchat.data.current_font = font
    return true
end

do
    local user_font = CreateClientConVar("sparkwerk_chat_font", default_font, true, false):GetString()
    if not sparkchat:ValidFont(user_font) then
        RunConsoleCommand("sparkwerk_chat_font", default_font)
    else
        sparkchat:SetFont(user_font)
    end
end

cvars.AddChangeCallback("sparkwerk_chat_font", function(cvar, oldvalue, newvalue)
    local did_set = sparkchat:SetFont(newvalue)
    if not did_set then
        if sparkchat:ValidFont(oldvalue) then
            RunConsoleCommand("sparkwerk_chat_font", oldvalue)
        else
            RunConsoleCommand("sparkwerk_chat_font", default_font)
        end
    end
end)
