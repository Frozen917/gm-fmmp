ENT.Type 			= "anim"
ENT.Base 			= "sb_base_generator"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true

ENT.AutomaticFrameAdvance = true 

function ENT:Initialize()
	self.BaseClass:Initialize(self)
	if SERVER then
		self:ServerSideInit()
	end
	self.slotSize = 1
	self.holdAngle = Angle(90, 0, 0)
	self.outputRates = 
	{
		energy = 100
	}
	self:SetDeviceName("Small Wind Turbine")
end

