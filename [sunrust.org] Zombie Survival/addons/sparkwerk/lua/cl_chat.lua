net.Receive("ChatHelp", function( l )
    local tbl = net.ReadTable() or {}

    MsgN("\n--- Help ---\n")
    MsgN("Arguments in [] are optional. To see defualt arguments type !help [cmd]")
    MsgN("Only commands you have permission for are visible here.")

    local longest = 0
    local grouped = {}

    for name, cmd in pairs(tbl) do
        local arghelp = ""
        if cmd.args then arghelp = " " .. chatcmd.FormatArgs(cmd.args) end
        cmd.combined_help = "  " .. name .. arghelp

        local slen = string.len(cmd.combined_help)
        if slen > longest then longest = slen end

        if not grouped[cmd.cat] then grouped[cmd.cat] = {} end
        table.insert(grouped[cmd.cat], cmd)
    end

    longest = longest + 1
    for group, cmds in pairs(grouped) do
        MsgN("\n" .. string.upper(group) .. " \n")
        for name, cmd in pairs(cmds) do
            local padding = longest - string.len(cmd.combined_help)
            MsgN(cmd.combined_help .. " " .. string.rep(".", padding) .. " " .. tostring(cmd.help))
        end
    end
end)
