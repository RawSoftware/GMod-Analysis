
sui = {}
sui.Debug = false

function sui.GetRelativePosition(panel, other_panel)
    local px, py = other_panel:GetPos()
    px, py = other_panel:GetParent():LocalToScreen(px, py)
    px, py = panel:GetParent():ScreenToLocal(px, py)
    return px, py
end

--[[
    Align a panel's vertical center to the vertical center of another panel
    They do not need to be siblings. This will only affect Y position.
    Works similar to http://wiki.garrysmod.com/page/Panel/MoveAbove
     _________                                  _____________
    |         |                                |             |
    |         |                |               |             |
----|---------|------< vertical center >-------|-------------|----
    |  panel  |                |               | other_panel |
    |_________|                                |_____________|
  ]]
function sui.MoveToVerticalCenter(panel, other_panel)
    local _, py = sui.GetRelativePosition(panel, other_panel)
    local sx, _ = panel:GetPos()
    panel:SetPos(sx, py + (other_panel:GetTall() / 2) - (panel:GetTall() / 2))
end

--[[
    Same as MoveToVerticalCenter, but for horizontal center instead.
  ]]
function sui.MoveToHorizontalCenter(panel, other_panel)
    local px, _ = sui.GetRelativePosition(panel, other_panel)
    local _, sy = panel:GetPos()
    panel:SetPos(px + (other_panel:GetWide() / 2) - (panel:GetWide() / 2), sy)
end

function sui.BuildCategory(parent)
    local category_builder =
    sui.Build("DPanel", parent)
        :DockPadding(0, 0, 0, 0)
        :Set("Paint", nil)

    return category_builder
end

local editor_meta

--[[
    Helper for editing an existing vgui panel. Usage:
        sui.Edit(panel)
            :SetSize(100, 100)
            :MoreStuff()
            :Etc()
  ]]
function sui.Edit(tab)
    local editor = {Panel = tab}
    setmetatable(editor, editor_meta)
    return editor
end

--[[
    Helper for building a new vgui panel. Usage:
        sui.Build("panel name", parent)
            :SetupStuff()
            :MoreSetupStuff()
            (...)
            :Build()

    Build() will return the built panel. In debug mode, it must be called last or an error will be thrown next frame.
  ]]
function sui.Build(...)
    local panel = vgui.Create(...)
    local editor = sui.Edit(panel)

    if sui.Debug then
        local build_stack = debug.traceback()
        timer.Simple(0, function()
            if not editor.Built then
                error("panel builder for '" .. tostring(panel) .. "' did not get :Build() called on it. " .. build_stack)
            end
        end)
    end

    return editor
end

editor_meta = {
    __index = function(table, key)
        local panel = rawget(table, "Panel")

        assert(panel, "Attempt to build unknown panel")
        assert(not string.find(key, "Get"), "Attempt to call Get function on panel builder")

        if key == "Built" then
            return rawget(table, "Built")
        end

        if key == "Build" then
            table.Built = true
            return function()
                return panel
            end
        end

        if key == "Set" then
            return function(tab, key, value)
                tab.Panel[key] = value
                return tab
            end
        end

        local panel_func = panel[key]

        return function(tab, ...)
            panel_func(panel, ...)
            return tab
        end
    end
}
