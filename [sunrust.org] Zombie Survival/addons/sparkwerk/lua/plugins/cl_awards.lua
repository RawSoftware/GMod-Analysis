Awards = {}

net.Receive("Awards.Own", function()
    local awards = net.ReadTable()
    Awards.MyAwards = awards
end)

function Awards.GetMyAwards()
    return Awards.MyAwards or {}
end
