AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function ENT:Think()
	if CurTime() - self.lastSeqReset > 1 then
		self.lastSeqReset = CurTime()
		local sequence
		if self:GetEnvCharacteristic("wind") > 0 then
			if not self.sound:IsPlaying() then self.sound:Play() end
			sequence = "on"
			self.enabled = true
		else
			if self.sound:IsPlaying() then self.sound:Stop() end
			sequence = "idle"
			self.enabled = false
		end
		self:ResetSequence(self:LookupSequence(sequence))
		self:SetPlaybackRate(1)
	end
	self:NextThink(CurTime())
	return true
end

function ENT:Use()
	if CurTime() - self.lastuse < 0.5 then
		if self.holder != nil then
			if self.holder:IsValid() then
				self.holder:Extract(self)
			else
				self.holder = nil
			end
		end
	end
	self.lastuse = CurTime()
end
