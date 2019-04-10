local function HandlePlayerAlphaChanged(pl, blend)
    if not IsValid(pl) then return end
    local userid = pl:UserID()

    if blend < 1 then
        Cosmetics.SetAlpha(userid, blend * 100)
    else
        Cosmetics.SetAlpha(userid, 255)
    end

    if blend == 0 then
        Cosmetics.SetDraw(userid, false)
    else
        Cosmetics.SetDraw(userid, true)
    end
end

hook.Add("PlayerAlphaChanged", "Cosmetics.AlphaChange", HandlePlayerAlphaChanged)

-- when player goes out of PVS, bone parenting is reset
-- so check for when they come into pvs again to re-parent
-- also if their hats are null, remake their costumes
local function HandleIntoPVSReParent(ply, shouldtransmit)
    if not ply:IsPlayer() then return end
    if not IsValid(ply) then return end

    local userid = ply:UserID()

    Cosmetics.SetDraw(userid, shouldtransmit)

    if not shouldtransmit then return end
    if not Cosmetics.Enabled then return end

    if not Cosmetics.PlayerInfo(userid).Enabled then
        --print("[COSMETICS DEBUG] Player entering PVS for first time: ".. tostring(ply))
        -- this player's costumes are not enabled (yet) - enable them
        Cosmetics.Enable(ply)
    end

    Cosmetics.ReParent(ply, ply)
end

hook.Add("NotifyShouldTransmit", "Cosmetics.IntoPVSReParent", HandleIntoPVSReParent)

local function HandlePlayerToCorpse(ply, ragdoll)
    if not IsValid(ply) then return end
    if not ply:IsPlayer() then return end
    if not IsValid(ragdoll) then return end

    local userid = ply:UserID()

    Cosmetics.ReParent(ply, ragdoll)
    Cosmetics.SetDraw(userid, true)
    Cosmetics.SetAlpha(userid, 255)

    if ply == LocalPlayer() then
        Cosmetics.SetDraw(userid, true, true)
    end

    ragdoll:CallOnRemove("Cosmetics.CorpseToPlayer", function()
        if ply == LocalPlayer() then
            Cosmetics.SetDraw(userid, false, false)
        end

        if not Cosmetics.Enabled then return end
        Cosmetics.ReParent(ply, ply)
    end)
end

hook.Add("OnCosmeticsToggle", "Cosmetics.HandleToggle", function(enabled)
    if enabled then
        hook.Add("CreateClientsideRagdoll", "Cosmetics.PlayerToCorpse", HandlePlayerToCorpse)
    else
        hook.Remove("CreateClientsideRagdoll", "Cosmetics.PlayerToCorpse")
    end
end)
