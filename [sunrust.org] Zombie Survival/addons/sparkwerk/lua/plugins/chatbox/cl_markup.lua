local sparkchat = sparkchat
local cvar_chat_emotes = CreateClientConVar("spark_chat_emotes", "1", true, false, "Enable or disable chat emotes locally.")

local col_white = Color(255,255,255)

sparkchat.markup_formats =
{
    color = {
        self_arg = { type = "color",  default = Color(255,255,255) },
        alpha    = { type = "number", default = 1 }
    },
    flash = {
        self_arg = { type = "string", default = "pulse"},
        rate     = { type = "number", default = 4},
        colors   = { type = "color_list", default = {Color(255,255,255), Color(0,0,0)}}
    }
}

local function MarkupFormat(markup)
    return sparkchat.markup_formats[markup]
end

local function parse_color_arg(arg)
    local r,g,b = unpack(string.Explode(",",arg))

    r = tonumber(r) or col_white.r
    g = tonumber(g) or col_white.g
    b = tonumber(b) or col_white.b

    return Color(r,g,b)
end

sparkchat.markup_argproc =
{
    ["color"] = parse_color_arg,
    ["color_list"] = function(arg)
        local cols = string.Explode("|", arg)

        local colorlist = {}

        for _,col in pairs(cols) do
            table.insert(colorlist, parse_color_arg(col))
        end

        return colorlist
    end,
    ["number"] = function(arg) return tonumber(str) or 1 end,
    ["string"] = function(arg) return arg end
}

local function GetArgProcFunc(type)
    return sparkchat.markup_argproc[type]
end

-- parses string in the form "name=name_arg argname1=argarg1 argname2=argarg2"
function sparkchat.parse_tag(tag_text)
    local all_mark = string.Explode(" ", tag_text)

    local name, self_argument = unpack(string.Explode("=", all_mark[1]))
    table.remove(all_mark, 1)

    local arguments = {}

    -- take string like "A=B X=Y" and tableize it
    -- so we have a table in the form {A=B, X=Y}
    if #all_mark > 0 then
        for _,markarg in pairs(all_mark) do
            local param, arg = unpack(string.Explode("=",markarg))
            if param and arg then arguments[param] = arg end
        end
    end

    arguments.self_arg = self_argument

    local format = MarkupFormat(name)
    local formatted

    -- create formatted version; only look at parameters
    -- which have been defined for this markup, ignore others
    if format then
        formatted = {}
        for param_name, param_info in pairs(format) do
            if arguments[param_name] then
                formatted[param_name] = GetArgProcFunc(param_info.type)(arguments[param_name])
            else
                -- no argument specified, use default
                formatted[param_name] = param_info.default
            end
        end
    end

    return {
        name = name,
        args = formatted or arguments,
        raw_text = tag_text
    }
end

local function add_text_section(sections, text, is_marked)
    if not text or text == "" then return end
    if #sections > 0 and not sections[#sections].tag then
        sections[#sections].content = sections[#sections].content .. text
    else
        table.insert(sections, {content = text})
    end
end

local function markupize(msg)
    local max_markups = 100

    local sections = {}

    while string.len(msg) > 0 and max_markups ~= 0 do
        local mark_start, mark_end, mark_str = string.find(msg, "<(.-)>")

        if mark_str then
            -- find corresponding tag
            local after_mark = string.sub(msg, mark_end + 1)
            local before_mark = string.sub(msg, 1, mark_start - 1)

            local markup_tag = sparkchat.parse_tag(mark_str)
            local end_mark = "</".. markup_tag.name ..">"

            local emark_start, emark_end, emark_str = string.find(after_mark, end_mark)

            if not emark_start then
                emark_start, emark_end, emark_str = string.find(after_mark, "</>")
            end

            if emark_end then
                -- all text from mark_end to emark_start is apart of the markup
                local contents = string.sub(after_mark, 1, emark_start-1)
                local before_contents = string.sub(msg, 1, mark_start-1)
                local after_contents = string.sub(after_mark, emark_end+1)

                add_text_section(sections, before_contents)
                table.insert(sections, {content = contents, tag = markup_tag})

                msg = after_contents
            else
                add_text_section(sections, string.sub(msg, 1, mark_end))
                msg = string.sub(msg, mark_end+1)
            end
        else
            -- no more markup
            add_text_section(sections, msg)
            msg = ""
        end
        max_markups = max_markups - 1
    end

    return sections
end

local function tokenize(msg, markup)
    local tokens = {}
    local max_tokens = 100
    local parsed_tokens = 3
    local chat_emotes = cvar_chat_emotes:GetInt() == 1

    while string.len(msg) > 0 and max_tokens ~= 0 do
        local token_start, token_end, token_str = string.find(msg, "<(.-)>")

        if not token_start then -- if no <> try ::s
            token_start, token_end, token_str = string.find(msg, ":(.-):")
        end

        if token_str then
            local token_lbracket = string.sub(msg, token_start, token_start)
            local token_rbracket = string.sub(msg, token_end, token_end)
            -- split string into characters before the token and characters after
            local before_tok = string.sub(msg, 1, token_start - 1)
            local after_tok = string.sub(msg, token_end + 1)

            if string.len(before_tok) > 0 then
                table.insert(tokens, {name = "(text)", args = {before_tok}, markup=markup})
            end

            local token_formatted = sparkchat.parse_tag(token_str)
            token_formatted.markup = markup

            local name = token_formatted.name

            if sparkchat.tags[token_formatted.name] and parsed_tokens ~= 0 and (chat_emotes or name == "avatar" and parsed_tokens == 3) then
                table.insert(tokens, token_formatted)
                msg = after_tok

                parsed_tokens = parsed_tokens - 1
            else
                -- no tag exists: treat this as text, including initial ":"
                table.insert(tokens, {name = "(text)", args={token_lbracket..token_str}, markup=markup})
                -- insert ":" at back for the rest of our message
                -- incase it belongs to a future ":
                msg = token_rbracket .. after_tok
            end
        else
            -- no more tokens remain in the message, treat rest as text
            table.insert(tokens, {name = "(text)", args = {msg}, markup=markup})
            msg = "" -- terminate loop
        end

        max_tokens = max_tokens - 1
    end

    return tokens
end

function sparkchat.parse(raw_input)
    local markup_sections = markupize(raw_input)

    local tokens = {}

    for _,section in pairs(markup_sections) do
        if section.tag and section.tag.name == "noparse" then
            table.insert(tokens, {name = "(text)", args = {section.content}})
        else
            local sec_tokens = tokenize(section.content, section.tag)
            table.Add(tokens, sec_tokens)
        end
    end

    return tokens
end
