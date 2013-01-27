ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= false
ENT.AdminSpawnable	= false

function ENT:Initialize()
	if SERVER then
		self:SetUseType(SIMPLE_USE)
		self:SetSkin(1)
		self.enabled = false
		self.runnable = false
		self.holder = nil
		self.lastuse = CurTime()
	end
	self.slotSize = -1
	self.heightOffset = 0
	self.holdAngle = Angle(0, 0, 0)
	self.resources = {}
	self.type = "CONTAINER"
end

function ENT:GetSlotSize()
	return self.slotSize
end

function ENT:GetHoldAngle()
	return self.holdAngle
end
