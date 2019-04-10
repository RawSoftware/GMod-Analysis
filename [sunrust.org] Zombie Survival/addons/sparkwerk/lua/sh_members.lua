AddCSLuaFile()

Members = {}
Members.Groups = {}
Members.GroupsByID = {}
Members.MEMBER_NONE = 0
Members.MEMBER_DONATOR = 1

function Members.AddGroup(id, info)
    info.ID = id
    Members.Groups[info.Name] = info
    Members.GroupsByID[id] = info
end

function Members.GetGroup(name)
    local group = Members.Groups[name]
    if not group then
        error("Invalid member group specified")
        return
    end

    return group
end

Members.AddGroup(Members.MEMBER_DONATOR,
{
    Name                = "donator",
    VotingMultiplier    = 2,
    ShopPriceMultiplier = 0.75,
})

if CLIENT then
    function Members.GetMyLevel()
        return LocalPlayer():GetNWInt("member_level", 0)
    end

    function Members.GetMyGroup()
        return Members.GroupsByID[Members.GetMyLevel()] or {}
    end
end

hook.Add("IsSpecialPerson", "Members.SpecialImage", function(ply, image)
	local img, tooltip

    if ply:IsMod() then
        img = "icon16/shield.png"
        tooltip = "Mod"

        if ply:IsSuperAdmin() then
            tooltip = "Super Admin"
        elseif ply:IsAdmin() then
            tooltip = "Admin"
        end
    elseif ply:GetNWInt("member_level", 0) > 0 then
        img = "sparkwerk/sr-16"
        tooltip = "Donator"
    end

    if img then
        if CLIENT then
            image:SetImage(img)
            image:SetTooltip(tooltip)
        end

        return true
    end
end)
