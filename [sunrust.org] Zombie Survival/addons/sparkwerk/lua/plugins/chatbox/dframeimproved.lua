local PANEL = {}
-- this is mostly copypaste with small modifications of the dpanel source
-- so you can resize it from any corner and drag from any point

PANEL.lblTitleHeight = 20

local function TwoPointsToDimension(x1, y1, x2, y2)
    local y = math.min(y1, y2)
    local x = math.min(x1, x2)
    local w = math.max(x1, x2) - x
    local h = math.max(y1, y2) - y

    return x,y,w,h
end

function PANEL:GetCorner(x, y)
    local at_l = x < ( self.x + 20 )
    local at_r = x > ( self.x + self:GetWide() - 20 )
    local at_u = y < ( self.y + 20 )
    local at_d = y > ( self.y + self:GetTall() - 20 )

    if (at_r and at_d) or (at_l and at_u) then return "sizenwse" end
    if (at_l and at_d) or (at_r and at_u) then return "sizenesw" end
end

function PANEL:OnMousePressed()
    if self.m_bSizable then
        local mx, my = gui.MouseX(), gui.MouseY()
        local at_l = mx < ( self.x + 20 )                    and 1 or 0
        local at_r = mx > ( self.x + self:GetWide() - 20 )   and 1 or 0
        local at_u = my < ( self.y + 20 )                    and 1 or 0
        local at_d = my > ( self.y + self:GetTall() - 20 ) and 1 or 0

        if (at_l + at_r + at_u + at_d) == 2 then
            self.Sizing = {}
            self.Sizing.CornerCusor = self:GetCorner(mx, my)

            if at_l > 0 then
                self.Sizing.x1 = self.x
                self.Sizing.x2 = self.x + self:GetWide()
            end

            if at_r > 0 then
                self.Sizing.x1 = self.x + self:GetWide()
                self.Sizing.x2 = self.x
            end

            if at_u > 0 then
                self.Sizing.y1 = self.y
                self.Sizing.y2 = self.y + self:GetTall()
            end

            if at_d > 0 then
                self.Sizing.y1 = self.y + self:GetTall()
                self.Sizing.y2 = self.y
            end

            self.Sizing.MouseXOffset = self.Sizing.x1 - mx
            self.Sizing.MouseYOffset = self.Sizing.y1 - my

            self:MouseCapture(true)
            return
        end
    end

    local my = gui.MouseY()
    if not self:GetDraggable() then return end

    self.Dragging = { gui.MouseX() - self.x, gui.MouseY() - self.y }
    self:MouseCapture( true )
    return
end

function PANEL:Think()
	local mousex = math.Clamp( gui.MouseX(), 1, ScrW() - 1 )
	local mousey = math.Clamp( gui.MouseY(), 1, ScrH() - 1 )

	if self.Dragging then
		local x = mousex - self.Dragging[1]
		local y = mousey - self.Dragging[2]

		-- Lock to screen bounds if screenlock is enabled
		if self:GetScreenLock() then

			x = math.Clamp( x, 0, ScrW() - self:GetWide() )
			y = math.Clamp( y, 0, ScrH() - self:GetTall() )

		end

		self:SetPos(x, y)
	end

    if self.Sizing then
        local x1 = self.Sizing.MouseXOffset + mousex
        local y1 = self.Sizing.MouseYOffset + mousey

        local x2 = self.Sizing.x2
        local y2 = self.Sizing.y2

        local x,y,w,h = TwoPointsToDimension(x1, y1, x2, y2)

		if w < self.m_iMinWidth  then w = self.m_iMinWidth  elseif w > ScrW() - x and self:GetScreenLock() then w = ScrW() - x end
		if h < self.m_iMinHeight then h = self.m_iMinHeight elseif h > ScrH() - y and self:GetScreenLock() then h = ScrH() - y end

        self:SetSize(w, h)
        self:SetPos(x, y)
		self:SetCursor(self.Sizing.CornerCusor)
		return
    end

    local corner = self:GetCorner(mousex, mousey)

	if self.Hovered and self.m_bSizable and corner then
		self:SetCursor(corner)
		return
    end

    if self.Hovered and self:GetDraggable() then
		self:SetCursor( "sizeall" )
		return
	end

	self:SetCursor( "arrow" )

	-- Don't allow the frame to go higher than 0
	if ( self.y < 0 ) then
		self:SetPos( self.x, 0 )
	end
end

function PANEL:PerformLayout()

	local titlePush = 0

	if ( IsValid( self.imgIcon ) ) then

		self.imgIcon:SetPos( 5, 5 )
		self.imgIcon:SetSize( 16, 16 )
		titlePush = 16

	end

	self.btnClose:SetPos( self:GetWide() - 31 - 4, 0 )
	self.btnClose:SetSize( 31, 24 )

	self.btnMaxim:SetPos( self:GetWide() - 31 * 2 - 4, 0 )
	self.btnMaxim:SetSize( 31, 24 )

	self.btnMinim:SetPos( self:GetWide() - 31 * 3 - 4, 0 )
	self.btnMinim:SetSize( 31, 24 )

	self.lblTitle:SetPos( 8 + titlePush, 2 )
	self.lblTitle:SetSize( self:GetWide() - 25 - titlePush, self.lblTitleHeight )

end

derma.DefineControl("DFrameImproved", "DFrame with better sizing and moving capabilities", PANEL, "DFrame")
