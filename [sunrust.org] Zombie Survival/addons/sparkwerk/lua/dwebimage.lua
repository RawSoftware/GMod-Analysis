local Name        = "DWebImage"
local BaseName    = "DImageRotate"
local Description = "Web based image"

local PANEL = {}

function PANEL:SetURL(url)
    webmaterial.Get(url, "web_images", function(material)
        self:SetMaterial(material)
    end)
    self.URL = url
end

vgui.Register(Name, PANEL, BaseName)
