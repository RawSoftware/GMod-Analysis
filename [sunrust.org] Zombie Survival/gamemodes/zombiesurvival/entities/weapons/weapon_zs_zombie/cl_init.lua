include("shared.lua")  SWEP.ViewModelFOV = 85 SWEP.DrawCrosshair = false  function SWEP:OnRemove()     self:SCKOnRemove() end  function SWEP:ViewModelDrawn()     self:SCKViewModel() end  function SWEP:Reload() end  function SWEP:DrawWorldModel() end SWEP.DrawWorldModelTranslucent = SWEP.DrawWorldModel  function SWEP:DrawHUD()     if GetConVar("crosshair"):GetInt() ~= 1 then return end     self:DrawCrosshairDot()         if GAMEMODE.CooldownRingDisplay then         self:DrawCooldowns()     end end  local ringSize = 0 local ringSpacing = 0 local ringValDistance local cooldown local cooldownMaximum local color function SWEP:DrawCooldowns()     local ring_x = ScrW() * 0.5     local ring_y = ScrH() * 0.5     local screenscale = BetterScreenScale()       ringSize = 4 * GAMEMODE.CooldownRingSize     ringSpacing = 1 + GAMEMODE.CooldownRingSpacing     ringValDistance = (ringSpacing * (ringSize + (50 + ringSize))) * screenscale               local ringStart = (ringSpacing * (19 + GAMEMODE.CooldownRingSize)) * screenscale     local ringLength = (ringSpacing * (21 + ringSize)) * screenscale     cooldown = self:GetNextPrimaryFire() - CurTime()     cooldownMaximum = self.Primary.Delay     color = GAMEMODE.CooldownRingPrimaryColor         if cooldown ~= math.huge and cooldownMaximum ~= math.huge then          self:DrawCooldownRing(ring_x, ring_y, ringStart, ringLength, cooldown, cooldownMaximum, color, ringValDistance * -1 )     end         ringSpacing = ringSpacing * ringSpacing               ringStart = (ringSpacing * (23 + (4 * GAMEMODE.CooldownRingSize))) * screenscale     ringLength = (ringSpacing * (ringSize + (24 + ringSize))) * screenscale     cooldown = self:GetNextSecondaryFire() - CurTime()     cooldownMaximum = self.Secondary.Delay     color = GAMEMODE.CooldownRingSecondaryColor         if cooldown ~= math.huge and cooldownMaximum ~= math.huge then          self:DrawCooldownRing(ring_x, ring_y, ringStart, ringLength, cooldown, cooldownMaximum, color, ringValDistance )     end end  local ringTexture = surface.GetTextureID("vgui/white") function SWEP:DrawCooldownRing(x, y, ringStart, ringLength, valCurrent, valMaximum, ringColour, xValue)     if valMaximum and valCurrent > 0 then         local screenscale = BetterScreenScale()          local vertextable = {{}}         local steps = 0 + math.Round((valCurrent / valMaximum) * 36 )         local ringx = x         local ringy = y         ringstart = 19 * screenscale         ringlength = 20 * screenscale                 if AngDiff then             ringx = ringx + (AngDiff.x/1.5 or 0)             ringy = ringy - (AngDiff.y/1.5 or 0)         end                 local function lengthdirx(length, dir)             return length*math.cos(math.rad(dir))         end                 local function lengthdiry(length, dir)             return length*math.sin(math.rad(dir))         end                 surface.SetTexture( ringTexture )         surface.SetDrawColor( ringColour )                 if steps > 0 then             for k=1, steps do                       vertextable = {}                 vertextable[1] = {}                 vertextable[2] = {}                 vertextable[3] = {}                 vertextable[4] = {}                 vertextable[1]["x"] = ringx+lengthdirx(ringStart,(k-1)*10-90)                 vertextable[1]["y"] = ringy+lengthdiry(ringStart,(k-1)*10-90)                 vertextable[1]["u"] = 0                 vertextable[1]["v"] = 0                 vertextable[2]["x"] = ringx+lengthdirx(ringLength,(k-1)*10-90)                 vertextable[2]["y"] = ringy+lengthdiry(ringLength,(k-1)*10-90)                 vertextable[2]["u"] = 1                 vertextable[2]["v"] = 0                 vertextable[3]["x"] = ringx+lengthdirx(ringLength,k*10-90)                 vertextable[3]["y"] = ringy+lengthdiry(ringLength,k*10-90)                 vertextable[3]["u"] = 0                 vertextable[3]["v"] = 1                 vertextable[4]["x"] = ringx+lengthdirx(ringStart,k*10-90)                 vertextable[4]["y"] = ringy+lengthdiry(ringStart,k*10-90)                 vertextable[4]["u"] = 1                 vertextable[4]["v"] = 1                 surface.DrawPoly( vertextable )                     end         end                     if GAMEMODE.CooldownRingValueDisplay then             draw.SimpleText(math.Round(valCurrent,1), "ZSHUDFontSmallest", x + xValue, y, ringColour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)         end     end end  function SWEP:DrawWeaponSelection(x, y, w, h, alpha)     self:BaseDrawWeaponSelection(x, y, w, h, alpha) end 