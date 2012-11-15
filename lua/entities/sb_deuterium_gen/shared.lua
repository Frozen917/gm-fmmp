ENT.Type 			= "anim"
ENT.Base 			= "sb_base_generator"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true


function ENT:Initialize()
	self.BaseClass:Initialize(self)
	if SERVER then
		self:ServerSideInit()
	end
	self.slotSize = 3
	self.holdAngle = Angle(90, -90, -90)
	self.inputRates = 
	{
		energy = 20
		--deuterium = 100
	}
	self.outputRates = 
	{
		energy = 500
	}
end
