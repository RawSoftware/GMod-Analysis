AddCSLuaFile()

chatcmd = {}

chatcmd.ChatTable = {}

function chatcmd.GetTable()
    return chatcmd.ChatTable
end

function chatcmd.Add(chat_cmd)
    chatcmd.ChatTable[chat_cmd.name] = chat_cmd
end

function chatcmd.Remove(chat_cmd)
    chatcmd.ChatTable[chat_cmd] = nil
end

local function GetPlayerCmdTime(p, name)
    p.ChatCmdTime = p.ChatCmdTime or {}
    return p.ChatCmdTime[name] or 0
end

local function SetPlayerCmdTime(p, name, time)
    p.ChatCmdTime = p.ChatCmdTime or {}
    p.ChatCmdTime[name] = time
end

local function FindPlayer(ply, ply_str)
    if ply_str == "<self>" then return {ply} end

    if string.sub(ply_str,1,2) == "u:" then
        if string.len(ply_str) <= 2 then return {} end

        local id = tonumber(string.sub(ply_str, 3))
        if not id then return {} end

        for k,pl in pairs(player.GetAll()) do
            if pl:UserID() == id then
                return {pl}
            end
        end

        return {}
    end

    return SparkWerk.FindPlayer(ply_str)
end

-- functions which run on argument if its format has a tag (ie p:argument)
local tag_preproc = {
    -- player
    ['p'] = function(invoker, arg)
        local targets = FindPlayer(invoker, arg)
        if #targets > 1 then
            local names = {}
            for k,v in pairs(targets) do table.insert(names, v:Name() .. " (userid: " .. v:UserID() .. ")") end
            invoker:ChatPrint("Error - Players " .. table.concat(names, ", ") .. " match your search but exactly one is required. Use u:<userid> as player name.")
            return
        elseif #targets == 0 then
            invoker:ChatPrint("Error - No player matches your search.")
            return
        end

        return targets[1]
    end,
    -- time duration
    ['d'] = function(invoker, arg)
        local mult = 1 -- multiple of minutes

        local endchar = string.sub(arg, -1)

        if not tonumber(endchar) then
            if     endchar == 'h' then mult = 60 -- hours
            elseif endchar == 'd' then mult = 1440 -- days
            else   invoker:ChatPrint("Error - invalid time length token.") return end
            arg = string.sub(arg, 1, -2)
        end

        arg = tonumber(arg)
        if not arg then invoker:ChatPrint("Error - invalid number specified.") return end

        return arg * mult
    end,
    -- number
    ['n'] = function(invoker, arg)
        arg = tonumber(arg)
        if not arg then invoker:ChatPrint("Error - invalid number specified.") return end
        return arg
    end
}

local function GetFormattedArgs(args_raw, args_format, pl)
    if not args_format or #args_format == 0 then return {} end

    local formatted = {}
    local i=1

    local end_idx =  #args_format
    local past_end_idx = end_idx + 1

    while args_raw[past_end_idx] do
        args_raw[end_idx] = args_raw[end_idx] .. " " .. args_raw[past_end_idx]
        table.remove(args_raw, past_end_idx)
    end

    for _,arg_format in pairs(args_format) do
        local tag,name

        local split = string.Split(arg_format[1], ':')
        if #split == 2 then tag = split[1] name = split[2]
        else name = split[1] end

        local default = arg_format[2]
        local arg = args_raw[i] or default

        local preprocessor = tag_preproc[tag]

        if arg ~= true and preprocessor then
            arg = preprocessor(pl, arg)
            if not arg then return end
        end

        formatted[name] = arg
        last_valid_arg = name
        i = i + 1
    end

    return formatted
end

local function GetMissingArgs(args)
    local missing = {}
    for k,v in pairs(args) do
        if v == true then table.insert(missing, k) end
    end

    if #missing == 0 then return nil end

    return missing
end

function chatcmd.Run(p, name, args)
    local chat_cmd = chatcmd.ChatTable[name]

    if not chat_cmd then
        p:ChatPrint("Unknown chat command " .. name .. ". Please see !help.")
        return false
    end

    if not p:HasPermission(chat_cmd.perm) then
        p:ChatPrint("Error - You have the wrong permissions.")
        return false
    end

    local cmd_time = GetPlayerCmdTime(p, name)
    local cur_time = os.time()

    if cmd_time > cur_time then
        p:ChatPrint("You must wait " .. (cmd_time - cur_time) .. " more seconds to use " .. name .. ".")
        return false
    end

    local args_fixed = GetFormattedArgs(args, chat_cmd.args, p)
    if not args_fixed then return false end
    local missing_args = GetMissingArgs(args_fixed)

    if missing_args then
        p:ChatPrint("Error - missing required arguments: " .. table.concat(missing_args, ", "))
        return false
    end

    chat_cmd.func(p, name, args_fixed)
    SetPlayerCmdTime(p, name, cur_time + (chat_cmd.cooldown or 0))

    return true
end

function chatcmd.FormatArgs(args, show_defaults)
    if not args or #args == 0 then return nil end

    local pretty = ""
    for k,v in pairs(args) do
        if v[2] == true then
            pretty = pretty .. " "..v[1]..""
        else
            if show_defaults then
                pretty = pretty .. " ["..v[1].."="..v[2].."]"
            else
                pretty = pretty .. " ["..v[1].."]"
            end
        end
    end

    return string.Trim(pretty)
end

if SERVER then
    util.AddNetworkString("ChatHelp")

    local function ChatHelp(ply, cmd, args)
        if args.chat_command_name ~= "" then
            local chat_cmd = chatcmd.GetTable()[args.chat_command_name]

            if chat_cmd then
                if ply:HasPermission(chat_cmd.perm) then
                    --if chat_cmd.arghelp then arghelp = " " .. chat_cmd.arghelp end
                    ply:ChatPrint("Help: " .. chat_cmd.help)
                    ply:ChatPrint("Usage: " .. chat_cmd.name .. " ".. (chatcmd.FormatArgs(chat_cmd.args, true) or ""))
                else
                    ply:ChatPrint("Help: You do not have permission to use " .. args.chat_command_name .. ".")
                end
            else
                ply:ChatPrint("Help: Error - command " .. args.chat_command_name .. " does not exist.")
            end

            return
        end

        local tbl = {}

        for k, v in SortedPairs(chatcmd.GetTable()) do
            if ply:HasPermission(v.perm) then
                tbl[k] = { cat = v.cat or "misc", args = v.args, help = v.help }
            end
        end

        net.Start("ChatHelp")
            net.WriteTable(tbl)
        net.Send(ply)

        ply:ChatPrint("A list of chat commands you have access to has been printed to your console.")
    end

    chatcmd.Add({
        name    = "help",
        func    = ChatHelp,
        args    = {{"chat_command_name", ""}},
        help    = "Chat command help"
    })
end
