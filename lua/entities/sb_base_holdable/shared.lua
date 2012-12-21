ENT.Type 			= "anim"
ENT.Base 			= "sb_base_rd"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= false
ENT.AdminSpawnable	= false


STATUS_ON = 1
STATUS_OFF = 0


function ENT:Initialize(child)
	self.BaseClass:Initialize(child)
	child.slotSize = -1
	child.heightOffset = 0
	child.holdAngle = Angle()
	if SERVER then
		self.ServerSideInit(child)
	end
end

function ENT:GetSlotSize()
	return self.slotSize
end

function ENT:GetHoldAngle()
	return self.holdAngle
end