AddCSLuaFile()

local pairs = pairs
local MsgN = MsgN
local file = file

SparkWerk.PluginsDir = "plugins/"
SparkWerk.Plugins = {}

function SparkWerk.LoadPlugins()
    local pluginsdir = SparkWerk.PluginsDir

    local files, folders = file.Find(pluginsdir .. "*", "LUA")

    for _,filename in pairs(files) do
        local prefix = string.sub(filename, 1, 2)
        local filepath = pluginsdir .. filename

        if prefix == "sh" then
            include(filepath)
            if SERVER then AddCSLuaFile(filepath) end
        elseif prefix == "sv" then
            if SERVER then include(filepath) end
        elseif prefix == "cl" then
            if SERVER then AddCSLuaFile(filepath) end
            if CLIENT then include(filepath) end
        end
    end

    for _,foldername in pairs(folders) do
        local predir = pluginsdir .. foldername
        local shared = predir .. "/shared.lua"
        local client = predir .. "/cl_init.lua"
        local server = predir .. "/init.lua"

        if SERVER then
            if file.Exists(shared, "LUA") then
                include(shared)
                AddCSLuaFile(shared)
            end
            if file.Exists(server, "LUA") then
                include(server)
                AddCSLuaFile(server)
            end
            if file.Exists(client, "LUA") then AddCSLuaFile(client) end
        else
            if file.Exists(shared, "LUA") then include(shared) end
            if file.Exists(client, "LUA") then include(client) end
        end
    end
end

function SparkWerk:RegisterPlugin(PLUGIN)
    self.Plugins[PLUGIN.Name] = PLUGIN
end

function SparkWerk:GetPlugin( name )
    if self.Plugins[name] then
        return self.Plugins[name]
    else
        return nil
    end
end
