ENT.Type 			= "anim"
ENT.Base 			= "sb_base_filter"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true


function ENT:Initialize()
	self.BaseClass:Initialize(self)
	if SERVER then
		self:ServerSideInit()
	end
	self.slotSize = 1
	self.holdAngle = Angle(90, 0, 0)
	self.resourceType = "oxygen"
	self:SetDeviceName("Oxygen Filter")
end