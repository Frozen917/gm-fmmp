ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true

ENT.implementation = { "container_entity" }
ENT.DeviceName = "Small Energy Cell"
include("headers/headers.lua")

ENT.addInitFunction(function(self)
	self.slotSize = 1
	self.holdAngle = Angle(90, 0, 0)
	self.resources["energy"] = { amount = 0, maxamount = 60000, flow = 100 }
end)