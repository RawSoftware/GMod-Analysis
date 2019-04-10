AddCSLuaFile()

function TimeToEnglish(delta)
    delta = math.max(0, delta)

    local strTime = ""
    if delta < 60 then
        strTime = math.Round(delta, 2) .." seconds"
    elseif delta < 3600 then
        strTime = math.Round(delta / 60, 2) .." minutes"
    elseif delta < 86400 then
        strTime = math.Round(delta / 3600, 2) .." hours"
    else
        strTime = math.Round(delta / 86400, 2) .." days"
    end

    return strTime
end

local function IsNameMatch( ply, str, caller )
    if str == "*" then
        return true
    elseif str == "@" and ply:IsAdmin() then
        return true
    elseif str == "!@" and not ply:IsAdmin() then
        return true
    elseif str == "^" and ply == caller then
        return true
    elseif str == "!^" and ply ~= caller then
        return true
    elseif string.match( str, "STEAM_[0-5]:[0-9]:[0-9]+" ) then
        return ply:SteamID() == str
    elseif string.Left( str, 1 ) == "\"" and string.Right( str, 1 ) == "\"" then
        return ply:Nick() == string.sub( str, 2, #str - 1 )
    else
        return string.lower( ply:Nick() ) == string.lower( str ) or string.find( string.lower( ply:Nick() ), string.lower( str ), nil, true )
    end
end

function SparkWerk.FindPlayer(name, def, caller)
    local matches = {}

    if not name or #name == 0 then
        matches[1] = def
    else
        if ( type( name ) ~= "table" ) then name = { name } end
        local name2 = table.Copy( name )

        for _, ply in ipairs( player.GetAll() ) do
            for _, pm in ipairs( name2 ) do
                if ( IsNameMatch( ply, pm, caller ) and not table.HasValue( matches, ply ) ) then table.insert( matches, ply ) end
            end
        end
    end

    return matches
end

if SERVER then
    util.AddNetworkString("SWPlayerReady")
    net.Receive("SWPlayerReady", function(len, ply)
        if ply.Ready then return end
        ply.Ready = true
        hook.Run("SWPlayerReady", ply)
    end)
else
    hook.Add("InitPostEntity", "sparkwerk.local_player_ready", function()
        net.Start("SWPlayerReady")
        net.SendToServer()
    end)
end

function string_comma_value(amount)
    local formatted = amount
    while true do
      formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
      if (k==0) then
        break
      end
    end
    return formatted
end

local spawning_count = 0
local spawning = {}

local function AddSpawning(userid)
    if spawning[userid] then return end

    spawning_count = spawning_count + 1
    spawning[userid] = true
end

local function RemoveSpawning(userid)
    if not spawning[userid] then return end

    spawning_count = spawning_count - 1
    spawning[userid] = nil
end

gameevent.Listen("player_connect")
hook.Add("player_connect", "SparkWerk.AddSpawning", function(data)
    if data.bot == 1 then return end
    AddSpawning(data.userid)
end)

hook.Add("PlayerInitialSpawn", "SparkWerk.RemoveSpawning", function(ply)
    RemoveSpawning(ply:UserID())
end)

gameevent.Listen("player_disconnect")
hook.Add("player_disconnect", "SparkWerk.RemoveSpawning", function(data)
    RemoveSpawning(data.userid)
end)

function SparkWerk.GetNumClients()
    return spawning_count + #player.GetAll()
end

local sizes = {
    ["char"] = 1,
    ["int"] = 4,
    ["short"] = 2,
    ["float"] = 4,
}

-- https://developer.valvesoftware.com/wiki/Valve_Texture_Format
local vtf_7_2_header_chunk_meta = {
    {type = "char",  name = "signature", count =  4},
    {type = "int",   name = "version", count =  2},
    {type = "int",   name = "headerSize"},
    {type = "short", name = "width"},
    {type = "short", name = "height"},
    {type = "int",   name = "flags"},
    {type = "short", name = "frames"},
    {type = "short", name = "firstFrame"},
    {type = "char",  name = "padding0", count = 4},
    {type = "float", name = "reflectivity", count =  3},
    {type = "char",  name = "padding1", count =  4},
    {type = "float", name = "bumpmapScale"},
    {type = "int",   name = "highResImageFormat"},
    {type = "char",  name = "mipmapCount"},
    {type = "int",   name = "lowResImageFormat"},
    {type = "char",  name = "lowResImageWidth"},
    {type = "char",  name = "lowResImageHeight"},
}

function SparkWerk.ParseVTFHeader(vtf_data)
    if not vtf_data then
        return
    end

    -- formatted end result table
    local chunks_data = {}

    local byte_count = 0
    local value_data = 0
    local values_array = {}
    local chunk_index = 1

    for b in string.gmatch(vtf_data, ".") do
        local chunk_meta = vtf_7_2_header_chunk_meta[chunk_index]

        local chunk_type_byte_count = sizes[chunk_meta.type]
        local chunk_byte_count = (chunk_meta.count or 1) * chunk_type_byte_count

        value_data = value_data + bit.lshift(string.byte(b), byte_count * 8)
        byte_count = byte_count + 1

        if byte_count % chunk_type_byte_count == 0 then
            -- completed reading a chunk value
           table.insert(values_array, value_data)
           value_data = 0
        end

        if byte_count == chunk_byte_count then
            -- completed reading a chunk
            chunks_data[chunk_meta.name] = #values_array > 1 and values_array or values_array[1]

            values_array = {}
            byte_count = 0
            chunk_index = chunk_index + 1
        end

        if chunk_index > #vtf_7_2_header_chunk_meta then
            break
        end
    end

    return chunks_data
end
