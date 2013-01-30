ENT.Type 			= "anim"
ENT.Base 			= "f2mp_base_rd"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= false
ENT.AdminSpawnable	= false

ENT.AutomaticFrameAdvance = true

function ENT:Setup(type)
	local settings = Devices.GetRegisteredGenerators()[type]
	self.animationOn = settings.animationOn
	self.animationIdle = settings.animationIdle
	self.sound = settings.sound
	self.requiredCharacteristics = settings.requiredCharacteristics
	self.inputRates = settings.inputRates
	self.outputRates = settings.outputRates
	self.slotSize = settings.slotSize
	self.holdAngle = settings.holdAngle
	self.deviceClass = type
	self.DeviceName = settings.name
	self:SetModel(settings.model)
end

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	if SERVER then
		self.resourceCache = {}
		self.outputCounter = {}
		self.holder = nil
		self.lastSeqReset = CurTime()
		self.sound = CreateSound(self, self.sound)
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
