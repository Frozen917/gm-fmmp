ENT.Type 			= "anim"
ENT.Base 			= "f2mp_base_rd"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= false
ENT.AdminSpawnable	= false

function ENT:Setup(type)
	local settings = Devices.GetRegisteredContainers()[type]
	self.resources = settings.resources
	self.holdAngle = settings.holdAngle
	self.slotSize = settings.slotSize
	self:SetModel(settings.model)
	self.DeviceName = settings.name
end

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	if SERVER then
		self.holder = nil
	end
	self.type = "CONTAINER"
end

function ENT:GetSlotSize()
	return self.slotSize
end

function ENT:GetHoldAngle()
	return self.holdAngle
end
