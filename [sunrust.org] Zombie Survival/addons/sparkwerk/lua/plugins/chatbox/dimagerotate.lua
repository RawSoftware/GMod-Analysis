local Name        = "DImageRotate"
local BaseName    = "DImage"
local Description = "Rotating image"

local PANEL = {}
PANEL.Rotation = 0
PANEL.RotationRate = 0

local triangles = {
    {
        {x = 0, y = 0, u = 0, v = 0},
        {x = 1, y = 0, u = 1, v = 0},
        {x = 1, y = 1, u = 1, v = 1}
    },
    {
        {x = 1, y = 1, u = 1, v = 1},
        {x = 0, y = 1, u = 0, v = 1},
        {x = 0, y = 0, u = 0, v = 0}
    }
}

function PANEL:Init()
    self.Triangles = table.Copy(triangles)
    self.Transform = Matrix()
    self.TransformUV = Matrix()
    self.ScrollAmount = {u = 0, v = 0}
    self.ScrollRate = {u = 0, v = 0}
    self.Shear = {u = 0, v = 0}
    self:SetScale(1, 1)
end

function PANEL:OnSizeChanged(w, h)
    self:ApplyTransform()
end

function PANEL:Paint(w, h)
    surface.SetMaterial(self:GetMaterial())
    surface.SetDrawColor(self:GetImageColor())
    for _, tri in ipairs(self.Triangles) do
        surface.DrawPoly(tri)
    end
end

function PANEL:Think()
    if self.RotationRate == 0 and self.ScrollRate.u == 0 and self.ScrollRate.v == 0 then
        return
    end

    self.Rotation = self.Rotation + (RealFrameTime() * self.RotationRate)
    self.Rotation = self.Rotation % 360

    self.ScrollAmount.u = self.ScrollAmount.u + (RealFrameTime() * self.ScrollRate.u)
    self.ScrollAmount.v = self.ScrollAmount.v + (RealFrameTime() * self.ScrollRate.v)
    self:ApplyTransform()
end

function PANEL:ApplyTransform()
    local transform_uv = self.TransformUV
    local transform = self.Transform

    transform:Identity()
    transform:Rotate(Angle(0, self.Rotation, 0))
    transform:Scale(self.Scale)

    transform_uv:SetField(1, 2, self.Shear.u)
    transform_uv:SetField(2, 1, self.Shear.v)

    local w, h = self:GetSize()

    for tri_index, tri in ipairs(triangles) do
        for vert_index, default_vertex in ipairs(tri) do
            local initial_pos = Vector((default_vertex.x - 0.5) * w,
                                       (default_vertex.y - 0.5) * h)
            local initial_uv =  Vector((default_vertex.u - 0.5),
                                       (default_vertex.v - 0.5))
            local transformed_pos = transform * initial_pos
            local transformed_uv = transform_uv * initial_uv

            local vertex = self.Triangles[tri_index][vert_index]
            vertex.x = (transformed_pos.x) + w / 2
            vertex.y = (transformed_pos.y) + h / 2
            vertex.u = (transformed_uv.x + 0.5) + self.ScrollAmount.u
            vertex.v = (transformed_uv.y + 0.5) + self.ScrollAmount.v
        end
    end
end

function PANEL:SetRotation(degrees)
    self.Rotation = math.fmod(degrees, 360)
    self:ApplyTransform()
end

function PANEL:SetTranslation(u, v)
    self.ScrollAmount.u = math.Clamp(u, -2, 2)
    self.ScrollAmount.v = math.Clamp(v, -2, 2)
    self:ApplyTransform()
end

function PANEL:SetTranslationRate(u, v)
    self.ScrollRate.u = math.Clamp(u, -2, 2)
    self.ScrollRate.v = math.Clamp(v, -2, 2)
    self:ApplyTransform()
end

function PANEL:SetScale(x, y)
    self.Scale = Vector(x, y, 0)
    self:ApplyTransform()
end

function PANEL:SetShear(u, v)
    self.Shear.u = math.Clamp(u, -0.9, 0.9)
    self.Shear.v = math.Clamp(v, -0.9, 0.9)
    self:ApplyTransform()
end

local max_rotation_rate = 360
function PANEL:SetRotationRate(degrees_per_second)
    self.RotationRate = math.Clamp(degrees_per_second, -max_rotation_rate, max_rotation_rate)
end

vgui.Register(Name, PANEL, BaseName)
