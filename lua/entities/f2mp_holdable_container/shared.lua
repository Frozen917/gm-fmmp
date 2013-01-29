ENT.Type 			= "anim"
ENT.Base 			= "f2mp_base_rd"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= false
ENT.AdminSpawnable	= false

function ENT:Initialize()
	if SERVER then
		self.holder = nil
		self.slotSize = -1
		self.heightOffset = 0
		self.holdAngle = Angle(0, 0, 0)
	end
	self.resources = {}
	self.type = "CONTAINER"
end

function ENT:GetSlotSize()
	return self.slotSize
end

function ENT:GetHoldAngle()
	return self.holdAngle
end
