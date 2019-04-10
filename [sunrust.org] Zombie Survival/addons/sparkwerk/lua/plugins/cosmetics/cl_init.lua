Cosmetics = {}
Cosmetics.Costumes = {}
Cosmetics.ModelCorrections = Cosmetics.ModelCorrections or {}
Cosmetics.OwnedCostumes = {}

Cosmetics.Players = {}

include("cl_parser.lua")
include("cl_types.lua")
include("cl_cosmetics.lua")
include("cl_events.lua")
include("cl_cos_model.lua")
include("cl_cos_group.lua")
include("cl_cos_clip.lua")
include("cl_cos_particles.lua")
include("cl_cos_effect.lua")
include("cl_cos_bone.lua")

game.AddParticles("particles/skull_flame.pcf")
