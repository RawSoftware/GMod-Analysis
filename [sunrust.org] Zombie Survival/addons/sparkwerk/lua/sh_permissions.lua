AddCSLuaFile()

local Player = FindMetaTable("Player")

SparkWerk.UserGroups = {}

local orange_flash_markup = {
    name = "flash",
    args = {
        self_arg = "pulse",
        rate = 2,
        colors = {Color(255,191,0), Color(255,191,0), Color(255,0,0), Color(255,93,0)}
    }
}

local purple_flash_markup = {
    name = "flash",
    args = {
        self_arg = "pulse",
        rate = 2,
        colors = {Color(191,0,255), Color(255,0,191), Color(200,0,200), Color(93,0,255)}
    }
}

local rainbow_markup = {
    name = "flash",
    args = {
        self_arg = "hsv",
        rate = 10
    }
}

SparkWerk.UserGroups["superadmin"] = {
    name = "Super Administrator",
    tag = "(SR)",
    tagcolor = Color(192, 128, 0),
    markup = rainbow_markup
}

SparkWerk.UserGroups["admin"] = {
    name = "Administrator",
    tag = "(SR)",
    tagcolor = Color(74, 218, 122),
    markup = orange_flash_markup
}

SparkWerk.UserGroups["moderator"] = {
    name = "Moderator",
    tag = "(SR)",
    tagcolor = Color(74, 218, 122),
    markup = purple_flash_markup
}

SparkWerk.UserGroups["navmesher"] = {
    name = "Navmesher",
    tag = "",
    tagcolor = Color(74, 218, 122),
    markup = purple_flash_markup
}

SparkWerk.UserGroups["guest"] = {name = "Guest"}

function Player:GetGroupTable()
    return SparkWerk.UserGroups[self:GetUserGroup()] or SparkWerk.UserGroups["guest"]
end

function Player:IsMod()
    return self:IsAdmin() or self:GetUserGroup() == "moderator"
end

function Player:IsNavmesher()
    return self:IsSuperAdmin() or self:GetUserGroup() == "navmesher"
        or (self:SteamID() == "STEAM_0:0:26828435" and self:IsAdmin()) -- temp for Prof. Dru until better group system is in place
end

function Player:IsWinky()
    return self:IsMod() or self:GetUserGroup() == "winky"
end

function Player:GetRankTitle()
    local ranktitle = self:GetGroupTable().name
    if ranktitle ~= "Guest" then return ranktitle end

    return "Guest"
end

function Player:HasPermission(perm_name)
    if not perm_name             then return true end
    if perm_name == "superadmin" then return self:IsSuperAdmin() end
    if perm_name == "admin"      then return self:IsAdmin() end
    if perm_name == "mod"        then return self:IsMod() end
    if perm_name == "navmesher"  then return self:IsNavmesher() end
    if perm_name == "navadmin"   then return self:IsNavmesher() or self:IsAdmin() end
    if perm_name == "winky"      then return self:IsWinky() end

    return false -- in case someone added a perm but forgot to add handling here, prevent anyone from using it
end

if CLIENT then
    function Player:GetTag()
        return self:GetGroupTable().tag, self:GetGroupTable().tagcolor, self:GetGroupTable().markup
    end
end
