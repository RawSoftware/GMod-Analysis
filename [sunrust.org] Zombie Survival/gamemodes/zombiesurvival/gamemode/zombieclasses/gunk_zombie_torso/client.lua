include("shared.lua")  local render_SetColorModulation = render.SetColorModulation local render_ModelMaterialOverride = render.ModelMaterialOverride  CLASS.Icon = "zombiesurvival/killicons/torso" CLASS.IconColor = Color(80, 80, 80)  local matSkin = Material("models/flesh") function CLASS:PrePlayerDraw(pl)  render_ModelMaterialOverride(matSkin)  render_SetColorModulation(0.175, 0.125, 0.125) end  function CLASS:PostPlayerDraw(pl)  render_ModelMaterialOverride()  render_SetColorModulation(1, 1, 1) end 