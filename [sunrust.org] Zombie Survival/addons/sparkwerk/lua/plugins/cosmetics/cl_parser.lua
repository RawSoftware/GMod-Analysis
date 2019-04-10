Cosmetics.CostumeFolder = "gamemodes/srcostumes/"

function Cosmetics.Load(data)
    local hat_tbl = luadata.Decode(data)
    if hat_tbl[1] then hat_tbl = hat_tbl[1] end
    return hat_tbl
end

function Cosmetics.LoadAll(cosfolder)
    local files, _ = file.Find(cosfolder .. "*", "GAME")

    for _, fname in pairs(files) do
        local costume_str = file.Read(cosfolder .. fname, "GAME")
        local costume = Cosmetics.Load(costume_str)
        local namenotxt = string.sub(fname,1,-5)

        costume.compactname = namenotxt
        Cosmetics.Costumes[namenotxt] = costume
	end

	print(string.format("[SW] Loaded %s costumes.", #files))
end

Cosmetics.LoadAll(Cosmetics.CostumeFolder)
--Cosmetics.LoadAll("data/srcostumes/")

Cosmetics.BoneShort = -- list from PAC3
{
	["pelvis"] = "ValveBiped.Bip01_pelvis",
	["spine"] = "ValveBiped.Bip01_spine",
	["spine 2"] = "ValveBiped.Bip01_spine1",
	["spine 3"] = "ValveBiped.Bip01_spine2",
	["spine 4"] = "ValveBiped.Bip01_spine4",
	["neck"] = "ValveBiped.Bip01_Neck1",
	["head"] = "ValveBiped.Bip01_Head1",
	["right clavicle"] = "ValveBiped.Bip01_r_clavicle",
	["right upper arm"] = "ValveBiped.Bip01_r_upperarm",
	["right upperarm"] = "ValveBiped.Bip01_r_upperarm",
	["right forearm"] = "ValveBiped.Bip01_r_forearm",
	["right hand"] = "ValveBiped.Bip01_r_hand",
	["left clavicle"] = "ValveBiped.Bip01_l_clavicle",
	["left upper arm"] = "ValveBiped.Bip01_l_upperarm",
	["left upperarm"] = "ValveBiped.Bip01_l_upperarm",
	["left forearm"] = "ValveBiped.Bip01_l_forearm",
	["left hand"] = "ValveBiped.Bip01_l_hand",
	["right thigh"] = "ValveBiped.Bip01_r_thigh",
	["right calf"] = "ValveBiped.Bip01_r_calf",
	["right foot"] = "ValveBiped.Bip01_r_foot",
	["right toe"] = "ValveBiped.Bip01_r_toe0",
	["left thigh"] = "ValveBiped.Bip01_l_thigh",
	["left calf"] = "ValveBiped.Bip01_L_Calf",
	["left foot"] = "ValveBiped.Bip01_l_foot",
	["left toe"] = "ValveBiped.Bip01_l_toe0",
}
