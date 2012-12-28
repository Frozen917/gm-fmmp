ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true

ENT.implementation = { "holder_entity" }
include("headers/headers.lua")

ENT.addInitFunction(function(self)
	self.inputRates = { energy = 50 }
	self.outputRates = { generic = 2000 }
	table.insert(self.plugs, Plug.New(self, 1, Vector(-0.075926847755909,-20.314468383789,-13.356286048889), Vector(0,-1,0), Angle(0,-90,-180)))
	table.insert(self.plugs, Plug.New(self, 2, Vector(-0.21118253469467,20.31443977356,-13.183825492859), Vector(0,1,0), Angle(0,90,-180)))
	self:SetDeviceName("Gas Compressor")
end)
