ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true

ENT.implementation = { "generator_entity" }
ENT.DeviceName = "Large Deuterium Generator"
include("headers/headers.lua")

ENT.addInitFunction(function(self)
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
end)
