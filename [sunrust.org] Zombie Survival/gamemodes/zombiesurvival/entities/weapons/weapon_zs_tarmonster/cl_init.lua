include("shared.lua") function SWEP:ViewModelDrawn()  render.ModelMaterialOverride(0)  render.SetColorModulation(1, 1, 1) end  local matSheet = Material("models/flesh") function SWEP:PreDrawViewModel(vm)  render.ModelMaterialOverride(matSheet)  render.SetColorModulation(0.175, 0.125, 0.125) end 