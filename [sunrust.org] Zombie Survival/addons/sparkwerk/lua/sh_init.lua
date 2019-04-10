AddCSLuaFile()

print("Sparkwerk - Starting")

SparkWerk = {}

SparkWerk.MaxChatLength = 256

SparkWerk.Color = {
    SunrustOrange    = Color(255, 82, 0),
    SunrustBlue      = Color(17, 17, 34),
    SunrustLightBlue = Color(20, 20, 41)
}

include("lib/luadata.lua")
include("sh_chat.lua")
include("sh_plugin.lua")
include("sh_permissions.lua")
include("sh_util.lua")
include("extensions/sh_player.lua")
include("sh_members.lua")

if SERVER then
    AddCSLuaFile("lib/luadata.lua")
    AddCSLuaFile('cl_vgui.lua')
    AddCSLuaFile("cl_init.lua")
    AddCSLuaFile("cl_chat.lua")
    AddCSLuaFile("cl_currency.lua")
    AddCSLuaFile("cl_derma_sunrust.lua")
    AddCSLuaFile('cl_stats.lua')
    AddCSLuaFile('cl_webmaterial.lua')
    AddCSLuaFile('dwebimage.lua')
    include("sv_init.lua")
end

if CLIENT then
    include("cl_init.lua")
end

-- load plugins last as they have dependencies
-- on core files
SparkWerk.LoadPlugins()

hook.Run("SparkWerkPostInitialize")
