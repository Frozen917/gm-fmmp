ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true

ENT.implementation = { "filter_entity" }
include("headers/headers.lua")

ENT.addInitFunction(function(self)
	self.slotSize = 1
	self.holdAngle = Angle(90, 0, 0)
	self.resourceType = "oxygen"
	self:SetDeviceName("Oxygen Filter")
end)
