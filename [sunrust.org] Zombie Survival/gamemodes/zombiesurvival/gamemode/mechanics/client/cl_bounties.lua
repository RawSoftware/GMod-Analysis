GM.BountyProgress = 0 net.Receive("zs_bountyprogress", function(length)     GAMEMODE.BountyProgress = net.ReadInt(16)      if IsValid(GAMEMODE.DemiBar) then         if GAMEMODE.BountyProgress > 0 then             GAMEMODE.DemiBar:SetVisible(true)         elseif GAMEMODE.BountyProgress == 0 then             GAMEMODE.DemiBar:SetVisible(false)         end     end end)