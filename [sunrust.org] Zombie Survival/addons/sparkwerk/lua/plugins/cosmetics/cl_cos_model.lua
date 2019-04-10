local COSMETIC = {}

COSMETIC.ValidProperties = {
    Bone = true,
    Model = true,
    Position = true,
    PositionOffset = true,
    Angles = true,
    Color = true,
    Alpha = true,
    UsePlayerColor = true,
    UseWeaponColor = true,
    Brightness = true,
    Fullbright = true,
    Material = true,
    Translucent = true,
    Size = true,
    Scale = true,
    DoubleFace = true
}

function COSMETIC:Draw()
    if not IsValid(self.Entity) then
        return
    end

    if self.LuaDraw then
        self.Entity:RenderOverride(true)
    else
        self.Entity:DrawModel()
    end
end

function COSMETIC:SetDraw(draw)
    if IsValid(self.Entity) then
        self.Entity:SetNoDraw(not draw)
    end
end

function COSMETIC:SetAlpha(alpha)
    alpha = alpha or self.Alpha

    local self_alpha_factor = 1

    if not self.LuaDraw then
        self_alpha_factor = self.Properties.Alpha or 1
    end

    local new_alpha = 255

    local curcol = Color(255,255,255)
    if IsValid(self.Entity) then curcol = self.Entity:GetColor() end

    local new_rendermode = RENDERMODE_TRANSALPHA

    if alpha == 255 then
        new_rendermode = self.Properties.Translucent and RENDERMODE_TRANSALPHA or RENDERMODE_NORMAL
        new_alpha = self_alpha_factor * 255
    else
        new_rendermode = RENDERMODE_TRANSALPHA
        new_alpha = (self_alpha_factor * (alpha / 255)) * 255
    end

    self.Alpha = alpha

    if not IsValid(self.Entity) then return end

    self.Entity:SetRenderMode(new_rendermode)
    self.Entity:SetColor(ColorAlpha(curcol, new_alpha))
end

function COSMETIC:SetParent(parent, newmodel)
    if not IsValid(self.Entity) then return end

    local data  = self.Properties
    local model = self.Entity

    local bone_correction = Cosmetics.GetCorrection(parent, data.Bone)
    local bone = Cosmetics.BoneShort[data.Bone or "head"]

    if bone_correction then
        bone = bone_correction.name or bone
    end

    local boneid
    if bone then
        boneid = parent:LookupBone(bone)
    end

    -- if certain models are parented to a bone with FollowBone,
    -- that player model enters a weird out of sync state, and any models
    -- parented to it with FollowBone will have laggy movement.
    -- this flag prevents that from happening as a workaround
    model:AddEFlags(EFL_SETTING_UP_BONES)
    model:FollowBone(NULL, 0)

    if boneid then
        model:FollowBone(parent, boneid)
    else
        -- no bone
        model:SetParent(parent)
    end

    -- if there is no new model, no need to reload the matrix
    if not newmodel then return end

    -- global costume scale (aligned with owner)
    local global_scale = Vector(1,1,1)

    if IsValid(self.CosmeticOwner) then
        global_scale = global_scale * self.CosmeticOwner:GetModelScale()
    end

    -- for propagating parent scale bone corrections
    -- 'inherits' from parent scales
    local bone_scale = parent.CosBoneScale or Vector(1, 1, 1)

    local posrotmat = Matrix() -- for position/rotation only
    local scalemat = Matrix()  -- for scale only

    if bone_correction then
        posrotmat:Translate(bone_correction.t)
        posrotmat:Rotate(bone_correction.r)
        if bone_correction.s then
            -- temp workaround: current logic doesn't support
            -- asymmetric scaling, so make it all symmetric
            -- by averaging the x/y/z scales
            local avg = (bone_correction.s.x + bone_correction.s.y + bone_correction.s.z) / 3
            bone_scale = bone_scale * avg
        end
    end

    posrotmat:Scale(bone_scale)
    posrotmat:Translate(data.Position)
    posrotmat:Rotate(data.Angles or Angle(0, 0, 0))
    posrotmat:Scale(global_scale)
    posrotmat:Translate(data.PositionOffset or Vector(0, 0, 0))
    posrotmat:Rotate(data.AngleOffset or Angle(0, 0, 0))

    scalemat:Scale(global_scale)
    scalemat:Scale((data.Scale or Vector(1, 1, 1)) * (data.Size or 1))
    scalemat:Scale(bone_scale)

    model.Matrix = scalemat
    model.CosBoneScale = bone_scale

    model:SetLocalPos(posrotmat:GetTranslation())
    model:SetLocalAngles(posrotmat:GetAngles())

    model:EnableMatrix("RenderMultiply", scalemat)
end

-- to get 1:1 visual fidelity with the pac3 renderer,
-- if any of these properties are set, we need to use a manual draw hook
local luadraw_properties = {
    Brightness = true,
    Fullbright = true,
    DoubleFace = true,
    Material = true,
    Color = true,
    UsePlayerColor = true,
    UseWeaponColor = true,
}

local function ShouldLuaDraw(hat)
    for name, data in pairs(hat) do
        if luadraw_properties[name] then
            return true
        end
    end

    return false
end

local render_SetColorModulation = render.SetColorModulation
local render_SetBlend = render.SetBlend
local render_CullMode = render.CullMode
local render_ModelMaterialOverride = render.ModelMaterialOverride
local render_SuppressEngineLighting = render.SuppressEngineLighting
local render_SetShadowsDisabled = render.SetShadowsDisabled
local render_EnableClipping = render.EnableClipping
local render_PushCustomClipPlane = render.PushCustomClipPlane
local render_PopCustomClipPlane = render.PopCustomClipPlane

local entmeta = FindMetaTable("Entity")
local ent_GetColor = entmeta.GetColor
local ent_GetModel = entmeta.GetModel
local ent_DrawModel = entmeta.DrawModel

local mat_white = Material("models/debug/debugwhite")

function COSMETIC:AddClipPlane(position, normal)
    self.ClipPlanes = self.ClipPlanes or {}
    table.insert(self.ClipPlanes, {position = position, normal = normal})

    if not self.LuaDraw then
        self:SetupLuaDraw()
    end
end

function COSMETIC:SetupLuaDraw()
    local properties = self.Properties
    local csmod      = self.Entity
    local owner      = self.CosmeticOwner

    local col = Vector(1,1,1)

    if properties.UsePlayerColor then     col = owner:GetPlayerColor()
    elseif properties.UseWeaponColor then col = owner:GetWeaponColor()
    elseif properties.Color then          col = Vector(properties.Color.r/255, properties.Color.g/255, properties.Color.b/255)
    end

    local bright = properties.Brightness or 1
    local fb     = properties.Fullbright
    local df     = properties.DoubleFace
    local mat    = properties.Material and Material(properties.Material) or nil
    local alpha  = properties.Alpha or 1

    local colx = col.x * bright
    local coly = col.y * bright
    local colz = col.z * bright

    csmod.RenderOverride = function(lighting_override)
        local hatalpha = ent_GetColor(csmod).a

        render_SetColorModulation(colx, coly, colz)
        render_SetBlend(hatalpha/255 * alpha)

        if not lighting_override then
            render_SuppressEngineLighting(fb and true or false)
        end

        if hatalpha < 200 and mat then
            render_ModelMaterialOverride(mat_white)
            render_SetColorModulation(0, 0, 0)
            render_SetShadowsDisabled(true)
        else
            render_ModelMaterialOverride(mat)
        end

        local oldclip

        if self.ClipPlanes then
            oldclip = render_EnableClipping(true)

            for _, plane in pairs(self.ClipPlanes) do
                local rawpos = plane.position + plane.normal:Forward()

                local position = csmod:LocalToWorld(rawpos * (csmod.CosBoneScale or Vector(1,1,1)))
                local normal   = csmod:LocalToWorldAngles(plane.normal)
                local distance = normal:Forward():Dot(position)

                render_PushCustomClipPlane(normal:Forward(), distance)
            end
        end

        if df then
            render_CullMode(MATERIAL_CULLMODE_CW)
            ent_DrawModel(csmod)
            render_CullMode(MATERIAL_CULLMODE_CCW)
        end

        ent_DrawModel(csmod)

        if self.ClipPlanes then
            for _, _ in pairs(self.ClipPlanes) do
                render_PopCustomClipPlane()
            end

            render_EnableClipping(oldclip)
        end

        render_SetShadowsDisabled(false)
        render_ModelMaterialOverride()
        if not lighting_override then
            render_SuppressEngineLighting(false)
        end
        render_SetColorModulation(1,1,1)
        render_SetBlend(1)
    end

    self.LuaDraw = true
end

function COSMETIC:Create(owner)
    util.PrecacheModel(self.Properties.Model)

    self.CosmeticOwner = owner
    self.Entity = ClientsideModel(self.Properties.Model)
    self.Alpha  = 255

    local parent     = self.Parent
    local properties = self.Properties
    local csmod      = self.Entity

    if not IsValid(csmod) then
        ErrorNoHalt("Clientside entity immediately NULL!\n")
        return
    end

    if properties.Translucent then
        csmod:SetRenderMode(RENDERMODE_TRANSALPHA)
    end

    if properties.Material then
        csmod:SetMaterial(properties.Material)
    end

    if ShouldLuaDraw(properties) then
        self:SetupLuaDraw()
    end

    local ownerinfo = owner.HatInfo and owner:HatInfo() or {}
    local nodraw  = ownerinfo.CosmeticsNoDraw or false
    local alpha   = ownerinfo.CosmeticsAlpha or 255

    self:SetAlpha(alpha)
    csmod:SetNoDraw(nodraw)

    csmod.HatTable = self
end

function COSMETIC:Remove()
    if IsValid(self.Entity) then
        self.Entity:Remove()
    end

    self.Entity = nil
end

Cosmetics.RegisterType("model", COSMETIC)
