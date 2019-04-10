AddCSLuaFile()

SparkWerkGMI = {}

local function LoadGamemode()
    local gm_path = "gamemodes/" .. engine.ActiveGamemode()

    if file.Exists("lua/" .. gm_path, "GAME") then
        print("[SparkWerk Gamemode Interface] Loading gamemode configuration for " .. gm_path)

        local files, dirs = file.Find(gm_path .. "/*", "LUA")
        for _, f in pairs(files) do
            local type = string.sub(f, 1, 2)
            local fpath = gm_path .. "/" .. f
            if type == "sv" and SERVER then
                include(fpath)
            elseif type == "sh" then
                AddCSLuaFile(fpath)
                include(fpath)
            elseif type == "cl" then
                AddCSLuaFile(fpath)
                if CLIENT then include(fpath) end
            end
        end
    end
end

if SERVER then
    LoadGamemode()
else
    hook.Add("Initialize", "ClientLoadSGI", LoadGamemode)
end
