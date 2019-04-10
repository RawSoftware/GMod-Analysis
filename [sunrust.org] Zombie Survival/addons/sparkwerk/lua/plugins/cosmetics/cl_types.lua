
Cosmetics.Types = {}

function Cosmetics.RegisterType(name, tab)
    Cosmetics.Types[name] = tab
    tab.__index = tab
end

function Cosmetics.CreateType(name, properties, owner, parent, create)
    local new_cosmetic = {
        Properties = properties.self,
        Parent     = parent
    }

    local type = Cosmetics.Types[name]

    if not type then
        type = Cosmetics.Types["group"]
    end

    setmetatable(new_cosmetic, type)

    for property_name, property_data in pairs(new_cosmetic.Properties) do
        new_cosmetic[property_name] = property_data
    end

    local defaults = new_cosmetic.DefaultProperties
    if defaults then
        for property_name, property_data in pairs(defaults) do
            new_cosmetic[property_name] = new_cosmetic[property_name] or property_data
        end
    end

    if create then
        if not IsValid(owner) then
            ErrorNoHalt("Player invalid but hat created!\n")
            return new_cosmetic
        end

        new_cosmetic:Create(owner)
        new_cosmetic:SetParent(parent, true)
    end

    return new_cosmetic
end
