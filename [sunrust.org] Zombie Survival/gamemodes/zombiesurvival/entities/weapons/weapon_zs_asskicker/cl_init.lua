include("shared.lua")  function SWEP:PreDrawViewModel(vm)  render.SetBlend(0) end  function SWEP:PostDrawViewModel(vm)  render.SetBlend(1) end 