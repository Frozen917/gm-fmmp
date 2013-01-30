ENT.Type 			= "anim"
ENT.Base 			= "f2mp_base_rd"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= false
ENT.AdminSpawnable	= false

function ENT:Setup(type)
	local settings = Devices.GetRegisteredGenerators()[type]
	self.inputRates = settings.inputRates
	self.outputRates = settings.outputRates
	self.slotSize = settings.slotSize
	self.holdAngle = settings.holdAngle
	self:SetModel(settings.model)
	self.deviceClass = type
	self.DeviceName = settings.name
end

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	if SERVER then
		self.resourceCache = {}
		self.outputCounter = {}
		self.holder = nil
		--ResourceDistribution.AddDevice(self)
	end
	self.type = "GENERATOR"
end

function ENT:GetSlotSize()
	return self.slotSize
end

function ENT:GetHoldAngle()
	return self.holdAngle
end
