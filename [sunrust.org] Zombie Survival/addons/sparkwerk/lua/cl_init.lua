--
include('cl_vgui.lua')
include('cl_chat.lua')
include('cl_currency.lua')
include("cl_derma_sunrust.lua")
include('cl_stats.lua')
include('cl_webmaterial.lua')
include('dwebimage.lua')

gameevent.Listen("player_disconnect")

net.Receive("SR.PlayerConnect", function()
    local name = net.ReadString()
    local userid = net.ReadInt(32)
    hook.Run("SR.PlayerConnect", name, userid)
end)


local function HandleBotAvatar(panel, player)
    local fakeid = player:GetNW2String("FakeAvatarSteamID")
    panel:SetSteamID(fakeid)

    hook.Add("EntityNetworkedVarChanged", tostring(panel), function(ent, name, old, new)
        if not IsValid(panel) then return end
        if name ~= "FakeAvatarSteamID" or ent ~= player then return end
        panel:SetSteamID(new)
    end)
end

local old_vgui_create = vgui.Create

vgui.Create = function(name, parent)
    local panel = old_vgui_create(name, parent)
    if name == "AvatarImage" then
        local oldset = panel.SetPlayer
        panel.SetPlayer = function(panel, player)
            if IsValid(player) and player:IsBot() then
                HandleBotAvatar(panel, player)
                return
            end
            oldset(panel, player)
        end
    end
    return panel
end

hook.Add("InitPostEntity", "SparkWerk.SendSprayInfo", function()
    local spray_texture_name = GetConVar("cl_logofile"):GetString()
    local spray = file.Read(spray_texture_name, "GAME")

    if spray then
        local header = SparkWerk.ParseVTFHeader(spray)
        local crc = util.CRC(spray)

        net.Start("SparkWerk.SprayInfo")
            net.WriteString(crc)
            net.WriteInt(header.flags or 0, 32)
            net.WriteInt(header.frames or 1, 32)
        net.SendToServer()
    end
end)

concommand.Add("spark_redirect_me", function()
    LocalPlayer():ConCommand('connect 142.44.142.152:27016')
end)
