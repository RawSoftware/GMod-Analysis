local MC = Cosmetics.ModelCorrections

function Cosmetics.AddCorrection(...)
    local args = {...}
    -- last arg is the correction
    local correction = args[#args]

    table.remove(args, #args)

    for _, model in pairs(args) do
        local modelf = "models/"..model..".mdl"
        MC[modelf] = correction
    end
end

local ent_GetModel = FindMetaTable("Entity").GetModel

function Cosmetics.GetGlobalCorrection(ply)
    local ext_correction = hook.Run("CosmeticsOverrideCorrection", ply)
    local correction = ext_correction or Cosmetics.ModelCorrections[ent_GetModel(ply)]
    local bone_correction = correction and correction["all"]

    return bone_correction
end

function Cosmetics.GetCorrection(ply, bone, realbone)
    local bone_full = Cosmetics.BoneShort[bone or "head"]

    if realbone then
        bone_full = bone
    end

    local ext_correction
    if ply:IsPlayer() then
        ext_correction = hook.Run("CosmeticsOverrideCorrection", ply)
    end

    local correction = ext_correction or Cosmetics.ModelCorrections[ent_GetModel(ply)]

    local bone_correction = correction and correction[bone_full]

    return bone_correction
end

function Cosmetics.GetCorrectedBonePos(ply, bone_name)
    local bone_correction = Cosmetics.GetCorrection(ply, bone_name, true)

    local boffset = Vector(0)

    if bone_correction then
        bone_name = bone_correction.name or bone_name
        boffset = bone_correction.t
    end

    local boneid = ply:LookupBone(bone_name)
    local bonepos = ply:GetPos()
    if boneid then
        bonepos = ply:GetBonePosition(boneid)
    end

    return bonepos + boffset
end

local AddC = Cosmetics.AddCorrection

-- breen is standard
-- all offsets are in relation to him

AddC("player/zelpa/stalker",
{["all"] = {
    NoDraw = true
}})

AddC("dav0r/hoverball",
{["all"] = {
    NoDraw = true
}})

AddC("player/group03/male_02",
     "player/group03m/male_02",
     "player/group03/male_01",
     "player/group03/male_03",
     "player/group01/male_03",
     "player/group01/male_05",
     "player/group03/male_08",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.7,-0.5,-0.1),
    r = Angle(0,0,0)
}})

AddC("player/group02/male_02",
     "player/group01/male_02",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.23,-0.853,-0.249),
    r = Angle(0,5.194,0),
    s = Vector(1.02,1.02,1.02)
}})

AddC("player/group03/male_02",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.474,-0.429,-0.195),
    r = Angle(0,2.277,0),
    s = Vector(1.08,1.08,1.08)
}})

AddC("player/group03m/male_03",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.484,-0.77,-0.31),
    r = Angle(0,5.508,0)
}})

AddC("player/combine_soldier_prisonguard",
     "player/combine_soldier",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(2.412,2.114,-0.134),
    r = Angle(0,-9.177,0)
}})

AddC("player/group01/male_04",
     "player/group01/male_09",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.3,-0.9,-0.1),
    r = Angle(0,10,0),
    s = Vector(1.05,1.05,1.05)
}})

AddC("player/group03/male_09",
"player/group03m/male_09",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.413,-0.648,-0.17),
    r = Angle(0,6.324,0),
    s = Vector(1.058,1.058,1.058)
}})

AddC("player/group01/male_07",
     "player/group03m/male_05",
     "player/group03/male_05",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.3,-0.154,0.037),
    r = Angle(0,0,0)
}})

AddC("player/group03m/male_07",
     "player/group03/male_07",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.154,-0.248,-0.08),
    r = Angle(0,3.003,0),
    s = Vector(1.05,1.06,1.00)
}})

AddC("player/group02/male_08",
"player/group01/male_08",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.117,0.07,-0.063),
    r = Angle(0,2.277,0),
    s = Vector(1.05,1.08,1.08)
}})

AddC("player/group03m/male_08",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.3,0.1,0.037),
    r = Angle(0,0,0),
    s = Vector(1.05,1.05,1.05)
}})

AddC("player/group01/female_05",
     "player/group03/female_01",
     "player/group03m/female_01",
     "player/group01/female_06",
     "player/group03m/female_06",
     "player/group03/female_06",
     "player/group01/female_03",
     "player/group03m/female_03",
     "player/group01/female_04",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.007,-0.318,0.001),
    r = Angle(0,0,0)
}})

AddC("player/group03/female_04",
     "player/group03m/female_04",
     "player/group03/female_03",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(-0.281,-0.612,-0.029),
    r = Angle(0,2.277,0),
    s = Vector(1.04,1.04,1.04)
}})

AddC("player/p2_chell",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(-0.6,-0.38,-0.115),
    r = Angle(0,8.128,0),
    s = Vector(1.06,1.06,1.06)
}})

AddC("player/group03m/female_02",
     "player/group01/female_02",
     "player/group03m/female_05",
     "player/group01/female_01",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(-0.2,-0.818,0.001),
    r = Angle(0,0,0)
}})

AddC("player/group03m/male_06",
     "player/group01/male_01",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(1.006,-0.758,-0.04),
    r = Angle(0,0,0),
    s = Vector(1.03,1.03,1.03)
}})

AddC("player/group03m/male_01",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.297,-0.85,-0.175),
    r = Angle(0,4.784,0),
    s = Vector(1.06,1.08,1.06)
}})

AddC("player/group03/male_04",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(1.006,0,-0.175),
    r = Angle(0,0,0),
    s = Vector(1.07,1.07,1.07)
}})

AddC("player/group02/male_04",
     "player/group03m/male_04",
     "player/group03/male_03",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.697,-0.588,-0.177),
    r = Angle(0,5.194,0),
    s = Vector(1.02,1.02,1.02)
}})

AddC("player/group01/male_06",
     "player/group02/male_06",
     "player/group03/male_06", -- imperfect
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.2,-1.2,-0.1),
    r = Angle(0,5,0),
    s = Vector(1.08,1.08,1.08)
}})

AddC("player/group03/female_02",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(-0.405, -0.8, -0.11),
    r = Angle(0,3,0)
}})

AddC("player/gman_high",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(1.4,0,-0.015),
    r = Angle(0,0,0),
    s = Vector(1.03, 1.03, 1.03)
}})

AddC("player/alyx",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(-0.2,0.5,0),
    r = Angle(0,0,0),
    s = Vector(1.06,1.06,1.06)
}})

AddC("player/kleiner",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.5,0.3,-0.2),
    r = Angle(0,0,0),
    s = Vector(1.04,1.04,1.04)
}})

AddC("player/odessa",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.511,-0.589,-0.059),
    r = Angle(0,0,0)
}})

AddC("player/barney",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(-0.1,-0.148,0.006),
    r = Angle(0,0,0),
    s = Vector(1.12,1.12,1.12)
}})

AddC("player/police",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(-0.1,-0.148,-0.2),
    r = Angle(0,7.5,0),
    s = Vector(1.13,1.13,1.13)
}})

AddC("player/police_fem",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(-0.7,-0.948,-0.2),
    r = Angle(0,7.5,0),
    s = Vector(1.02,1.02,1.02)
}})


AddC("player/magnusson",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(-1.2,0,-0.2),
    r = Angle(0,0,0),
    s = Vector(1.07,1.07,1.09)
}})

AddC("player/phoenix",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(2.078,-0.07,-0.15),
    r = Angle(0,0,0),
    s = Vector(1.1,1.1,1.1)
}})

AddC("player/leet",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(2.3,-0.4,0),
    r = Angle(0,0,0),
    s = Vector(1.125,1.125,1.125)
}})

AddC("player/swat",
     "player/urban",
     "player/riot",
     "player/gasmask",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(1.1,-0.348,0.006),
    r = Angle(0,0,0),
    s = Vector(1.34,1.34,1.34) -- this might be annoyingly big. not sure how else to do it
}})

AddC("player/guerilla",
     "player/arctic",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(2.078,0.2,-0.09),
    r = Angle(0,0,0),
    s = Vector(1.1,1.1,1.1)
}})

AddC("player/hostage/hostage_01",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.441,-0.149,-0.1),
    r = Angle(0,2.277,0),
    s = Vector(1.03,1.0,1.04)
}})

AddC("player/hostage/hostage_02",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.693,-1.04,-0.191),
    r = Angle(0,2.277,0),
    s = Vector(1.1,1.1,1.1)
}})

AddC("player/hostage/hostage_03",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.231,-0.004,-0.005),
    r = Angle(0,2.277,0),
    s = Vector(1.04,1.06,1.04)
}})

AddC("player/hostage/hostage_04",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.243,-0.989,-0.171),
    r = Angle(0,5,0),
    s = Vector(1.02,1.02,1.02)
}})

AddC("player/combine_super_soldier",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(3.137,1.89,-0.053),
    r = Angle(0,0,0),
    s = Vector(1.07,1.07,1.07)
}})

AddC("player/eli",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(-0.09,-0.4,-0.007),
    r = Angle(0,9.517,0)
}})

AddC("player/monk",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.15,-0.1,-0.2),
    r = Angle(0,9.517,0),
    s = Vector(1.09,1.09,1.09)
}})

AddC("player/charple",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(-0.6,0.5,0), --Vector(0.15,-0.1,-0.2),
    r = Angle(0,9.517,0),
    s = Vector(0.87,0.87,0.87)
}})

-- ZS models

AddC("player/zombie_classic_hbfix",
     "player/zombie_classic",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(-3.302,-0.699,1.326),
    r = Angle(0, 180, 0),
    name = "ValveBiped.HC_Head_Bone"
}})

AddC("player/zombie_fast",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.211,-0.4,-0.023),
    r = Angle(0.052, 55.402, -0.08),
    s = Vector(0.85,0.85,0.85)
}})

AddC("player/zombie_lacerator2",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(-0.929,-3.295,-0.125),
    r = Angle(-1.509, 34.152, -2.283)
}})

AddC("player/skeleton",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(1.222,-0.317,0.022),
    r = Angle(-0.066, 9.434, -0.108)
}})

AddC("player/zombie_soldier",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(-3,0,0),
    r = Angle(0,0,0)
}})

AddC("zombie/poison",
{["ValveBiped.Bip01_Head1"] = {
    name = "ValveBiped.Bip01_Spine4",
    t = Vector(5.535,-0.025,-0.307),
    r = Angle(75.224, -179.996, 90)
}})

AddC("zombie/fast",
{["ValveBiped.Bip01_Head1"] = {
    name = "ValveBiped.HC_BodyCube",
    t = Vector(-0.298,-0.486,-6.151),
    r = Angle(-51.297, 102.633, -121.93)
}})

AddC("headcrabclassic",
{["ValveBiped.Bip01_Head1"] = {
    name = "HeadcrabClassic.HeadControl",
    t = Vector(0.122,2.14,-0.091),
    r = Angle(2.62,55.241,-0.276),
    s = Vector(0.75,0.75,0.75)
}})

AddC("headcrab", -- fast headcrab
{["ValveBiped.Bip01_Head1"] = {
    name = "HCfast.chest",
    t = Vector(0,0,0),
    r = Angle(-65.055,97.468,-89.999),
    s = Vector(0.75,0.75,0.75)
}})

AddC("headcrabblack",
{["ValveBiped.Bip01_Head1"] = {
    name = "HCblack.torso",
    t = Vector(0,0,0),
    r = Angle(-65.055,97.468,-89.999),
    s = Vector(0.75,0.75,0.75)
}})

AddC("crow",
{["ValveBiped.Bip01_Head1"] = {
    name = "Crow.Head",
    t = Vector(0.4,0.15,-0.091),
    r = Angle(2.62,95,-0.276),
    s = Vector(0.25,0.25,0.25)
}})

AddC("vinrax/player/doll_player",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(3,0.5,-0.5),
    r = Angle(0,0,0),
    s = Vector(2.3,2.2,2.3)
}})

AddC("antlion",
{["ValveBiped.Bip01_Head1"] = {
    name = "Antlion.Head_Bone",
    t = Vector(-3.9,0.877,0.6),
    r = Angle(0,86.303,-180),
    s = Vector(1.538,1.538,1.538)
}})

AddC("player/fatty/fatty",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.847,-0.105,0),
    r = Angle(0,11.227,0.001),
    s = Vector(1.07,1.07,1.07)
}})

AddC("player/corpse1",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0.705,-0.553,0.009),
    r = Angle(-0.55,3.383,-0.032)
}})

AddC("zombie/classic_legs",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(0,-5,0),
    r = Angle(0, 90, -90),
    name = "ValveBiped.Bip01_Pelvis",
    s = Vector(1.2,1.2,1.2)
}})

AddC("gibs/fast_zombie_legs",
{["ValveBiped.Bip01_Head1"] = {
    t = Vector(5,-2,-4),
    r = Angle(-5, 165, 0),
    name = "ValveBiped.Bip01_R_Thigh",
    s = Vector(1.2,1.2,1.2)
}})
