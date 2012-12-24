ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true

ENT.AutomaticFrameAdvance = true 

ENT.implementation = { "generator_entity" }
ENT.DeviceName = "Small Wind Turbine"
include("headers/headers.lua")



ENT.addInitFunction(function(self)
	self.slotSize = 1
	self.holdAngle = Angle(90, 0, 0)
	self.outputRates = 
	{
		energy = 100
	}
end)

