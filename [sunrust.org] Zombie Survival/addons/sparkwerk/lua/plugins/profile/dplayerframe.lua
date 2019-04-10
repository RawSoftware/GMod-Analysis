local PANEL = {}
PANEL.ViewAngles = Angle(0)
PANEL.ViewHeadOffset = Vector(0,0,0)
PANEL.ViewPanOffset  = Vector(0,0,0)
PANEL.ViewTargetDistance = 64
PANEL.IsDragging = false
PANEL.IsZooming  = false
PANEL.IsPanning  = false

PANEL.mx = 0
PANEL.my = 0

function PANEL:Init()
    self.PlayerInfo = {}
    self.Costumes = {}
end

function PANEL:OnMouseWheeled(delta)
    self:AdjustZoom(-delta)
end

function PANEL:AdjustZoom(delta)
    local increment = (delta * math.abs(delta)) * (self.ViewTargetDistance / 64)
    self.ViewTargetDistance = math.Clamp(self.ViewTargetDistance + increment, 32, 512)
end

function PANEL:AdjustPan(deltax, deltay)
    local base_offset = self.ViewPanOffset
    local ang = self.ViewAngles
    local xdir = ang:Right()
    local ydir = ang:Up()

    self.ViewPanOffset = self.ViewPanOffset + (xdir * deltax * 0.02)
    self.ViewPanOffset = self.ViewPanOffset + (ydir * deltay * 0.02)
end

function PANEL:GetMouseChange()
	local x, y = input.GetCursorPos()

	local dx = (x - (self.mx or 0)) * FrameTime() * 200
	local dy = (y - (self.my or 0)) * FrameTime() * 200

	local centerx, centery = self.mstartx, self.mstarty

	self.mx = centerx
	self.my = centery

	return dx, dy
end

function PANEL:OnMousePressed(key)
    self:MouseCapture(true)
    self:SetCursor("blank")
	self.mstartx, self.mstarty = input.GetCursorPos()

    if key == MOUSE_LEFT then
        self.IsDragging = true
    end

    if key == MOUSE_RIGHT then
        self.IsPanning = true
    end

    self:GetMouseChange()
end

function PANEL:OnMouseReleased(key)
    if key == MOUSE_LEFT then
        self.IsDragging = false
    end
    if key == MOUSE_RIGHT then
        self.IsPanning = false
    end

    if not (self.IsDragging or self.IsPanning) then
        self:SetCursor("")
        self:MouseCapture(false)
        if self.mx and self.my then
            input.SetCursorPos(self.mx, self.my)
        end
        self.mx = 0
        self.my = 0
    end
end

function PANEL:UpdatePreviewCam()
    local curMousePosX, curMousePosY = gui.MousePos()

    local mx, my = self:GetMouseChange()

    if self.IsDragging or self.IsPanning then
        input.SetCursorPos(self.mx , self.my)
    end

    local MousePosDiffX = mx
    local MousePosDiffY = my

    if self.IsDragging then
        self.ViewAngles = self.ViewAngles + Angle(-MousePosDiffY / 10, -MousePosDiffX / 10, 0)
    end

    if self.IsZooming then
        self:AdjustZoom(MousePosDiffY / 20)
    end

    if self.IsPanning then
        self:AdjustPan(MousePosDiffX, MousePosDiffY)
    end

    local offset = self.ViewAngles:Forward() * self.ViewTargetDistance
    local origin = self.ViewHeadOffset + self.Entity:GetPos() + offset + self.ViewPanOffset
    local angs = Angle(0)
    angs:Set(self.ViewAngles)
    angs:RotateAroundAxis(angs:Up(), 180)

    self:SetCamPos(origin)
    self:SetLookAng(angs)
end

function PANEL:SetSequences(intro, idle)
    local intro_sequence = intro
    local idle_sequence  = idle

    local sequence_id, sequence_duration = self.Entity:LookupSequence(intro_sequence)
    local idle_sequence_id, idle_sequence_duration = self.Entity:LookupSequence(idle_sequence)

    if sequence_duration == 0 then
        sequence_id = 0
    end

    if idle_sequence_duration == 0 then
        idle_sequence_id = 0
    end

    self.Entity:SetSequence(sequence_id)

    -- most sequences, when played to their full duration, will
    -- transition to T-pos or some default pose. this cutoff length is to stop the animation
    -- before it starts that transition
    local sequence_garbage_cutoff = 0.666

    timer.Simple(sequence_duration - sequence_garbage_cutoff, function()
        if not IsValid(self.Entity) then
            return
        end

        self.Entity:SetSequence(idle_sequence_id)
    end)
end

function PANEL:OnRemove()
    for _, cos in pairs(self.Costumes) do
        Cosmetics.RemoveCostume(cos)
    end
end

function PANEL:AddCostume(name)
    table.insert(self.Costumes, Cosmetics.EquipEntity(self.Entity, name))
end

function PANEL:ResetCostume(costume_names)
    for _, costume in pairs(self.Costumes) do
        Cosmetics.RemoveCostume(costume)
    end

    table.Empty(self.Costumes)

    for _, costume_name in pairs(costume_names) do
        if costume_name then
            self:AddCostume(costume_name)
        end
    end
end

function PANEL:SetPlayerInfo(info)
    self.PlayerInfo = info
    self:SetModel(info.Model)

    self.Entity.GetPlayerColor = function()
        return self.PlayerInfo.PlayerColor or Vector(1, 1, 1)
    end

    self.Entity.GetWeaponColor = function()
        return self.PlayerInfo.WeaponColor or Vector(1, 1, 1)
    end

    self:ResetCostume(info.CostumeNames)

    self.Entity.RenderOverride = function()
        if not IsValid(self.Entity) then return end
        self.Entity:DrawModel()
        Cosmetics.Draw(self.Costumes, self.Entity)
    end

    self.Entity:SetAngles(Angle(0, 0, 0))
    self:SetLookAt(Vector(0, 0, 40))
    self:SetCamPos(Vector(70, 0, 60))
    self:SetFOV(50)

    self.LayoutEntity = function(pan, ent)
        self.Entity:SetEyeTarget(Vector(60, 0, 60))
        self:RunAnimation()
        self:UpdatePreviewCam()
    end

    self.ViewHeadOffset = Cosmetics.GetCorrectedBonePos(self.Entity, "ValveBiped.Bip01_Head1") - self.Entity:GetPos()
end

derma.DefineControl("DPlayerFrame", "Player preview frame", PANEL, "DModelPanel")
