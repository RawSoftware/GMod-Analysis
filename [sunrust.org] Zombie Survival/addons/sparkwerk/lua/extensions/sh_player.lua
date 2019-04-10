AddCSLuaFile()

if not SparkWerk.ExtendOverride then
    local Player = FindMetaTable("Player")

    SetWalkSpeedOld = Player.SetWalkSpeed
    Player.SetWalkSpeed = function(self, speed)
        self.WalkSpeed = speed
        SetWalkSpeedOld(self, speed * (self.SpeedMultiply or 1))
    end

    SetRunSpeedOld = Player.SetRunSpeed
    Player.SetRunSpeed = function(self, speed)
        self.RunSpeed = speed
        SetRunSpeedOld(self, speed * (self.SpeedMultiply or 1))
    end

    function Player:SetSpeedMultiplier(mult)
        self.SpeedMultiply = mult
        SetWalkSpeedOld(self, (self.WalkSpeed or self:GetWalkSpeed()) * mult)
        SetRunSpeedOld(self, (self.RunSpeed or self:GetRunSpeed()) * mult)
    end

    SetJumpPowerOld = Player.SetJumpPower
    Player.SetJumpPower = function(self, power)
        self.JumpPower = power
        SetJumpPowerOld(self, power * (self.JumpMultiply or 1))
    end

    function Player:SetJumpMultiplier(mult)
        self.JumpMultiply = mult
        SetJumpPowerOld(self, (self.JumpPower or self:GetJumpPower()) * mult)
    end
end

SparkWerk.ExtendOverride = true
