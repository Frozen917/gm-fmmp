ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= false
ENT.AdminSpawnable	= false

function ENT:Initialize()
	if SERVER then
		self:SetUseType(SIMPLE_USE)
		self:SetSkin(1)
		self.resourceCache = {}
		self.outputCounter = {}
		self.sound = nil
		self.enabled = false
		self.runnable = false
		self.holder = nil
		self.lastuse = CurTime()
		ResourceDistribution.AddDevice(self)
	end
	self.type = "GENERATOR"
	self.slotSize = -1
	self.heightOffset = 0
	self.holdAngle = Angle(0, 0, 0)
end
