ENT.Type 			= "anim"
ENT.Base 			= "f2mp_base_rd"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= false
ENT.AdminSpawnable	= false

ENT.DeviceName = "Gas Filter"

function ENT:Initialize()
	if SERVER then
		self.holder = nil
	end
	self.resourceType = "gas"
	self.type = "FILTER"
	self.slotSize = -1
	self.heightOffset = 0
	self.holdAngle = Angle(0, 0, 0)
end

function ENT:GetFilterType()
	return self.resourceType
end

function ENT:GetSlotSize()
	return self.slotSize
end

function ENT:GetHoldAngle()
	return self.holdAngle
end
