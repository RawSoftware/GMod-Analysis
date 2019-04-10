local cvar_emotes     = CreateClientConVar("spark_emotes", "1", true, false, "Enable or disable emotes locally.")
local cvar_emotes_log = CreateClientConVar("spark_emotes_log", "0", true, false, "Enable or disable emote logging locally.")

local function GetEmoteSoundscript(entindex)
    return entindex .. "_emote"
end

local function GetEmoteSoundFile(emote)
    local snds = emote.Sounds
    local snd = isstring(snds) and snds or table.Random(snds)
    return snd
end

gameevent.Listen("entity_killed")
hook.Add("entity_killed", "SR.CancelEmote", function(data)
    local eidx = data.entindex_killed
    local ply = Entity(eidx)
    if not IsValid(ply) then return end
    ply:StopSound(GetEmoteSoundscript(eidx))
end)

net.Receive("SR.Emote", function()
    local ply = net.ReadEntity()
    if not IsValid(ply) then return end
    local id  = net.ReadInt(32)
    local pitch = net.ReadInt(32)
    local nolog = net.ReadBool()

    if sparkchat.IgnoreList[ply:SteamID()] then return end

    local emote = SparkWerk.EmotesByID[id]

    if not emote then return end

    if cvar_emotes_log:GetInt() == 1 and emote.Chat and not nolog then
        MsgC("[Emote] " .. ply:SteamID() .. "|" .. ply:Nick() .. ": " .. emote.text .. "\n")
    end

    if cvar_emotes:GetInt() == 0 then return end

    local snd = GetEmoteSoundFile(emote)

    local sndscript = GetEmoteSoundscript(ply:EntIndex())

    sound.Add({
        name    = sndscript,
        channel = CHAN_VOICE,
        volume  = 1.0,
        level   = 80,
        pitch   = { pitch, pitch },
        sound   = snd
    })

    ply:EmitSound(sndscript, 75, 100, 1, CHAN_VOICE)
end)

function SparkWerk.OpenEmoteList()
    local Root = vgui.Create("DFrame")
    Root:SetSkin("sunrust")
    Root:SetSize(600, 800)
    Root:Center()
    Root:SetTitle("Emote List")
    Root:MakePopup()

    local List = Root:Add("DListView") List:Dock(FILL)
    List:AddColumn("Emote trigger phrase")

    for id, emote in ipairs(SparkWerk.EmotesByID) do
        List:AddLine(emote.text).Emote = emote
    end

    List.OnRowSelected = function(panel, row_index, row)
        surface.PlaySound(GetEmoteSoundFile(row.Emote))
    end
end
