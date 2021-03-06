ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true

ENT.implementation = { "holder_entity" }
ENT.DeviceName = "Generic 1x Small Holder"
include("headers/headers.lua")

ENT.addInitFunction(function (self)
	table.insert(self.plugs, Plug.New(self, 1, Vector(-24.688917160034,0,7.911262512207), Vector(-1,0,0), Angle(-180,0,180)))
	table.insert(self.plugs, Plug.New(self, 2, Vector(24.688917160034,0,7.911262512207), Vector(1,0,0), Angle(-180,180,180)))
	table.insert(self.plugs, Plug.New(self, 3, Vector(0,-24.682241439819,7.911262512207), Vector(0,-1,0), Angle(-180,90,180)))
	table.insert(self.plugs, Plug.New(self, 4, Vector(0,24.682241439819,7.911262512207), Vector(0,1,0), Angle(-180,-90,180)))
end)
