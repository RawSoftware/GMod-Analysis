local PANEL = {}

local modes = {
    hsv = true,
    pulse = true
}

PANEL.Mode = "pulse"
PANEL.Period = 1 -- seconds
PANEL.Offset = 0
PANEL.PulseBetween = {Color(255,255,255), Color(0,0,0)}
PANEL.PulseCurrentIdx = 1
PANEL.PulseNextIdx = 2
PANEL.PulseCurrentFrac = 0

function PANEL:SetPeriod(period)
    period = math.Clamp(period, 1, 60)
    self.Period = period
    self.Offset = ((RealTime() * 360) / self.Period) % 360
end

function PANEL:SetMode(mode)
    if not modes[mode] then mode = "pulse" end
    self.Mode = mode
end

function PANEL:SetColors(colors)
    if not colors then return end

    if #colors == 1 then
        table.insert(colors, Color(0,0,0))
    end
    self.PulseBetween = colors
end

function PANEL:Think()
    if self.Mode == "hsv" then
        local hue = ( ((RealTime() * 360) / self.Period) - self.Offset ) % 360
        local col = HSVToColor(hue, 1, 1)
        self:SetFGColor( col.r, col.g, col.b, col.a )
        return
    end

    if self.Mode == "pulse" then
        local pulse_from = self.PulseBetween[self.PulseCurrentIdx]
        local pulse_to   = self.PulseBetween[self.PulseNextIdx]

        local r = Lerp(self.PulseCurrentFrac, pulse_from.r, pulse_to.r)
        local g = Lerp(self.PulseCurrentFrac, pulse_from.g, pulse_to.g)
        local b = Lerp(self.PulseCurrentFrac, pulse_from.b, pulse_to.b)

        self:SetFGColor(r, g, b, 255)
        self.PulseCurrentFrac = self.PulseCurrentFrac + (RealFrameTime() * #self.PulseBetween / self.Period)

        if self.PulseCurrentFrac >= 1 then
            self.PulseCurrentFrac = self.PulseCurrentFrac - 1
            self.PulseCurrentIdx = ((self.PulseCurrentIdx) % #self.PulseBetween) + 1
            self.PulseNextIdx = ((self.PulseNextIdx) % #self.PulseBetween) + 1
        end
    end
end

derma.DefineControl("DLabelPulse", "Pulsing text", PANEL, "DLabel")
