ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= false
ENT.AdminSpawnable	= false

function ENT:Initialize()
	if SERVER then
		self:SetUseType(SIMPLE_USE)
		self:SetSkin(1)
		self.holder = nil
		self.lastuse = CurTime()
		self.runnable = false
		self.enabled = false
	end
	self.inputRates = {}
	self.outputRates = {}
	self.name = ""
	self.resourceType = ""
	self.type = "FILTER"
	self.slotSize = -1
	self.heightOffset = 0
	self.holdAngle = Angle(0, 0, 0)
end

function ENT:GetDeviceName()
	return self.name
end

function ENT:SetDeviceName(name)
	self.name = name or ""
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
