include("cl_corrections.lua")
Cosmetics.EquippedCostumes = {}

CreateClientConVar("spark_cosmetics", "1", true, true, "Enable or disable cosmetics.")

local ent_GetModel = FindMetaTable("Entity").GetModel

local function MakePlayerHatTable(userid)
    if Cosmetics.Players[userid] then return end

    Cosmetics.Players[userid] = {}
    local info = Cosmetics.Players[userid]

    info.Enabled = false
    info.CosmeticsAlpha = 255
    info.CosmeticsDrawOverride = false
    info.CosmeticsNoDraw = false
    info.Costumes = {}

    return info
end

local function GetPlayerHats(userid)
    if not Cosmetics.Players[userid] then
        return MakePlayerHatTable(userid)
    end

    return Cosmetics.Players[userid]
end

function Cosmetics.PlayerInfo(userid)
    return GetPlayerHats(userid)
end

local mPlayer = FindMetaTable("Player")
function mPlayer:HatInfo()
    return GetPlayerHats(self:UserID())
end

local function DoOnCosmetic(hat, func, parentent)
    if hat.self then func(hat.self, parentent) end

    for _, child in pairs(hat.children) do
        if hat.self and IsValid(hat.self.Entity) then
            DoOnCosmetic(child, func, hat.self.Entity)
        else
            DoOnCosmetic(child, func, parentent)
        end
    end
end

local function DoOnAllCosmeticsTable(costumes, func, parent)
    for _, cost in pairs(costumes) do
        DoOnCosmetic(cost, func, parent)
    end
end

local function DoOnAllCosmetics(userid, func, initialparent)
    local plinfo = GetPlayerHats(userid)
    if not plinfo then return end

    initialparent = initialparent or Player(userid)

    DoOnAllCosmeticsTable(plinfo.Costumes, func, initialparent)
end


local function DeleteHatEntities(costumetbl)
    DoOnCosmetic(costumetbl, function(hat)
        hat:Remove()
    end)
end

function Cosmetics.RemoveCostume(costumetbl)
    DeleteHatEntities(costumetbl)
end

local function DeletePlayerHats(userid, entsonly)
    DoOnAllCosmetics(userid, function(hat)
        hat:Remove()
    end)

    if entsonly then return end

    Cosmetics.Players[userid] = nil
end

hook.Add("SR.PlayerConnect", "Cosmetics.SetupPlayer", function(name, userid)
    MakePlayerHatTable(userid)
    --print("[COSMETICS DEBUG] player connect: " .. data.userid)
end)

hook.Add("player_disconnect", "Cosmetics.RemovePlayer", function(data)
    DeletePlayerHats(data.userid)
    --print("[COSMETICS DEBUG] player disconnect: " .. data.userid)
end)

function Cosmetics.Draw(costumes, parent)
    DoOnAllCosmeticsTable(costumes, function(costume)
        if costume.Properties.Translucent ~= true then
            costume:Draw()
        end
    end, parent)
    DoOnAllCosmeticsTable(costumes, function(costume)
        if costume.Properties.Translucent then
            costume:Draw()
        end
    end, parent)
end

function Cosmetics.ReParent(owner, target, nomdlchange)
    if not IsValid(owner) then return end
    if not IsValid(target) then return end

    local userid = owner:UserID()

    local info = GetPlayerHats(userid)

    if info.Enabled then
        DoOnAllCosmetics(userid, function(hat, parent) -- todo: heirarchy problem
            hat:SetParent(parent, not nomdlchange)
        end, target)
    end

    if nomdlchange then return end

    local correction = Cosmetics.GetGlobalCorrection(owner)

    if correction and correction.NoDraw then
        Cosmetics.SetDraw(userid, false, true)
    else
        Cosmetics.SetDraw(userid, nil, false)
    end
end

local do_draw_local
local override_local_draw = false

local function UpdateLocalDraw(dodraw, overridedraw)
    if override_local_draw then return end

    local lp = LocalPlayer()
    if not IsValid(lp) then return end

    local dodraw_new = lp:ShouldDrawLocalPlayer()

    if do_draw_local ~= dodraw_new or do_draw_local == nil then
        do_draw_local = dodraw_new
        Cosmetics.SetDraw(lp:UserID(), dodraw_new)
    end
end

function Cosmetics.SetDraw(userid, shoulddraw, override)
    local info = GetPlayerHats(userid)

    if override ~= nil then
        if Player(userid) == LocalPlayer() then
            do_draw_local = shoulddraw
            override_local_draw = shoulddraw
        end

        info.CosmeticsDrawOverride = override or nil
    elseif info.CosmeticsDrawOverride then
        return
    end

    info.CosmeticsNoDraw = not shoulddraw

    if shoulddraw == nil then return end
    if not info.Enabled then return end

    DoOnAllCosmetics(userid, function(hat)
        hat:SetDraw(shoulddraw)
    end)
end


function Cosmetics.SetAlpha(userid, alpha)
    local info = GetPlayerHats(userid)

    info.CosmeticsAlpha = alpha
    if not info.Enabled then return end

    DoOnAllCosmetics(userid, function(hat)
        hat:SetAlpha(alpha)
    end)
end

function Cosmetics.IsEquipped(userid, cosname)
    local info = GetPlayerHats(userid)
    return info.Costumes[cosname] and true or false
end

local function CreateHatInstance(properties, parent, owner, create)
    local instance = {}

    instance.self     = Cosmetics.CreateType(properties.self.ClassName, properties, owner, parent, create)
    instance.children = {}

    local newparent = parent

    if instance.self and IsValid(instance.self.Entity) then
        newparent = instance.self.Entity
    end

    for _, child in pairs(properties.children) do
        local child_instance = CreateHatInstance(child, newparent, owner, create)
        table.insert(instance.children, child_instance)
    end

    return instance
end

function Cosmetics.EquipEntity(ent, cosname)
    local costume = Cosmetics.Costumes[cosname]
    if not costume then
        error("Invalid cosmetic name " .. cosname)
        return
    end

    local instance = CreateHatInstance(costume, ent, ent, true)

    DoOnCosmetic(instance, function(component)
        component:SetDraw(false)
    end)

    return instance
end

function Cosmetics.Equip(userid, cosname)
    local costume = Cosmetics.Costumes[cosname]
    if not costume then return end

    local info = GetPlayerHats(userid)
    local pl = Player(userid)

    if info.Costumes[cosname] then Cosmetics.UnEquip(userid, cosname) end

    info.Costumes[cosname] = CreateHatInstance(costume, pl, pl, info.Enabled)

    if pl == LocalPlayer() then
        Cosmetics.EquippedCostumes[cosname] = true
        do_draw_local = nil
    else
        Cosmetics.SetDraw(userid, true)
    end
end

function Cosmetics.UnEquip(userid, costume)
    local info = GetPlayerHats(userid)
    if not info.Costumes[costume] then return end

    if info.Enabled then
        DeleteHatEntities(info.Costumes[costume])
    end

    info.Costumes[costume] = nil

    local player = Player(userid)
    if IsValid(player) and player == LocalPlayer() then
        Cosmetics.EquippedCostumes[costume] = nil
    end
end

function Cosmetics.UnEquipAll(userid)
    local info = GetPlayerHats(userid)

    if info.Enabled then
        for name, cos in pairs(info.Costumes) do
            DeleteHatEntities(cos)
        end
    end

    info.Costumes = {}
end

function Cosmetics.Disable(ply)
    if not IsValid(ply) then return false end

    local userid = ply:UserID()

    DeletePlayerHats(userid, true) -- delete hat entities but keep bookkeeping
    GetPlayerHats(userid).Enabled = false

    return true
end

function Cosmetics.Enable(ply)
    if not IsValid(ply) then return false end -- prevent enabling on invalid players

    local userid = ply:UserID()
    local plinfo = GetPlayerHats(userid)

    if plinfo.Enabled then return false end -- already enabled

    plinfo.Enabled = true

    DoOnAllCosmetics(userid, function(hat, parent)
        -- re-enabling
        hat:Remove()
        hat:Create(ply)
        hat:SetParent(parent, true)
    end)

    if ply == LocalPlayer() then
        do_draw_local = nil
    else
        Cosmetics.SetDraw(userid, true)
    end

    return true
end

function Cosmetics.LocalOwnCostume(name)
    return Cosmetics.OwnedCostumes[name] or false
end

function Cosmetics.LocalIsEquipped(name)
    return Cosmetics.EquippedCostumes[name] or false
end

function Cosmetics.SetEnabled(enable)
    if Cosmetics.Enabled == enable then return end
    Cosmetics.Enabled = enable

    hook.Run("OnCosmeticsToggle", enable)

    if enable then
        hook.Add("Think", "Cosmetics.CheckForSelfDraw", UpdateLocalDraw)
        for _, ply in pairs(player.GetAll()) do
            Cosmetics.Enable(ply)
        end
    else
        hook.Remove("Think", "Cosmetics.CheckForSelfDraw")
        for _, ply in pairs(player.GetAll()) do
            Cosmetics.Disable(ply)
        end
    end
end

local function HandlePlayerRespawn(data)
    local userid = data.userid
    local ply = Player(userid)

    if ply ~= LocalPlayer() then
        Cosmetics.SetDraw(userid, false)
    end

    timer.Simple(RealFrameTime(), function()
        if IsValid(ply) then Cosmetics.ReParent(ply, ply) end

        if ply ~= LocalPlayer() then
            Cosmetics.SetDraw(userid, true)
        end
    end)
end

gameevent.Listen("player_spawn")
hook.Add("player_spawn", "Cosmetics.SetModel", HandlePlayerRespawn)

hook.Add("SetModelScale", "Cosmetics.ScaleChanged", function(ply, scale)
    if IsValid(ply) then Cosmetics.ReParent(ply, ply) end
end)

gameevent.Listen("entity_killed")
hook.Add("entity_killed", "Cosmetics.KillHide", function(data)
    local ply = Entity(data.entindex_killed)
    if not IsValid(ply) then return end
    if not ply:IsPlayer() then return end

    Cosmetics.SetDraw(ply:UserID(), false)
end)

net.Receive("sw_equip_costume", function()
    local userid = net.ReadInt(32)
    local name = net.ReadString()

    hook.Run("OnCosmeticEquip", userid, name, true)
    Cosmetics.Equip(userid, name)
end)

net.Receive("sw_unequip_costume", function()
    local userid = net.ReadInt(32)
    local name = net.ReadString()

    hook.Run("OnCosmeticEquip", userid, name, false)
    Cosmetics.UnEquip(userid, name)
end)

net.Receive("sw_own_costume", function()
    local name = net.ReadString()

    Cosmetics.OwnedCostumes[name] = true
    hook.Run("OnCosmeticOwn", name)
end)

cvars.AddChangeCallback("spark_cosmetics", function(name, old, new)
    Cosmetics.SetEnabled(new == "1")
end)

timer.Simple(0, function()
    Cosmetics.SetEnabled(cvars.Number("spark_cosmetics") == 1)
end)
