ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true

ENT.implementation = { "container_entity" }
include("headers/headers.lua")

ENT.addInitFunction(function(self)
	self:SetDeviceName("Small Oxygen Tank")
	self.slotSize = 1
	self.holdAngle = Angle(90, 0, 0)
	self.heightOffset = 1.4531505584715
	self.resources["oxygen"] = { amount = 0, maxamount = 60000, flow = 2000 }
end)