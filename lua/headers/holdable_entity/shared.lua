ENT.implementation = { "fmp_entity", "rd_entity" }
include("headers/headers.lua")

ENT.addInitFunction(function(self)
	self.slotSize = -1
	self.heightOffset = 0
	self.holdAngle = Angle(0, 0, 0)
end)

function ENT:GetSlotSize()
	return self.slotSize
end

function ENT:GetHoldAngle()
	return self.holdAngle
end
