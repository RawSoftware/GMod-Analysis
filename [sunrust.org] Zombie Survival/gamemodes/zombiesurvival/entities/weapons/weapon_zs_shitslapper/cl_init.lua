include("shared.lua")  SWEP.WElements = {  ["glow1+++"] = { type = "Sprite", sprite = "effects/yellowflare", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(-10.856, 2.628, 75.259), size = { x = 7.635, y = 7.635 }, color = Color(255, 255, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},  ["chunk++"] = { type = "Model", model = "models/gibs/antlion_gib_large_3.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(-6.647, 3.65, 0.361), angle = Angle(11.461, 11.369, -12.851), size = Vector(0.616, 0.616, 0.616), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/zombie_fast/fast_zombie_sheet", skin = 0, bodygroup = {} },  ["chunk+++"] = { type = "Model", model = "models/weapons/w_bugbait.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(8.223, -0.389, -1.216), angle = Angle(11.461, -49.454, -12.851), size = Vector(3.336, 3.336, 3.336), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/zombie_fast/fast_zombie_sheet", skin = 0, bodygroup = {} },  ["glow1++"] = { type = "Sprite", sprite = "effects/yellowflare", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(-10.856, -1.866, 75.238), size = { x = 7.635, y = 7.635 }, color = Color(255, 255, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},  ["chunk+"] = { type = "Model", model = "models/gibs/antlion_gib_large_3.mdl", bone = "ValveBiped.Bip01_L_UpperArm", rel = "", pos = Vector(7.789, -1.125, 0), angle = Angle(-128.226, 9.131, -3.679), size = Vector(0.615, 0.615, 0.615), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/zombie_fast/fast_zombie_sheet", skin = 0, bodygroup = {} },  ["hands"] = { type = "Model", model = "models/weapons/c_arms_cstrike.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(1.883, 6.449, -47.161), angle = Angle(5.843, -90, 17.531), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/zombie_fast/fast_zombie_sheet", skin = 0, bodygroup = {}, bonemerge = true },  ["glow1"] = { type = "Sprite", sprite = "effects/redflare", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(-10.856, -1.463, 75.317), size = { x = 27.18, y = 27.18 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},  ["glow1+"] = { type = "Sprite", sprite = "effects/redflare", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(-10.856, 2.835, 75.317), size = { x = 27.18, y = 27.18 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},  ["body"] = { type = "Model", model = "models/gibs/fast_zombie_torso.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(-58.711, -10.843, -1.801), angle = Angle(170.516, 74.29, 91.693), size = Vector(1.5, 1.5, 1.12), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },  ["chunk++++"] = { type = "Model", model = "models/weapons/w_bugbait.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(3.367, 3.24, -5.522), angle = Angle(11.461, -99.893, -12.851), size = Vector(4.334, 4.334, 4.334), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/zombie_fast/fast_zombie_sheet", skin = 0, bodygroup = {} },  ["chunk"] = { type = "Model", model = "models/gibs/antlion_gib_large_3.mdl", bone = "ValveBiped.Bip01_R_UpperArm", rel = "", pos = Vector(8.515, -1.012, 0.822), angle = Angle(37.547, -5.586, 23.808), size = Vector(0.55, 0.55, 0.372), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/zombie_fast/fast_zombie_sheet", skin = 0, bodygroup = {} } }  SWEP.ShowWorldModel = false  function SWEP:DrawWorldModel()  self:SCKWorldModel() end