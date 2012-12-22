ENT.Type 			= "anim"
ENT.Base 			= "sb_base_holder"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true

function ENT:Initialize()
	self.BaseClass:Initialize(self)
	table.insert(self.plugs, Plug.New(self, 1, Vector(-60.783207, -111.510254, -25.141457), Vector(0,-1,0), Angle(0,-90,180)))
	table.insert(self.plugs, Plug.New(self, 2, Vector(60.783207, -111.510254, -25.141457), Vector(0,-1,0), Angle(0,-90,180)))
	table.insert(self.plugs, Plug.New(self, 3, Vector(-60.783207, 111.510254, -25.141457), Vector(0,1,0), Angle(0,90,180)))
	table.insert(self.plugs, Plug.New(self, 4, Vector(60.783207, 111.510254, -25.141457), Vector(0,1,0), Angle(0,90,180)))
	self.holdAngle = Angle(-289.983, 90, 20)
	if SERVER then
		self:ServerSideInit()
	end
	self:SetDeviceName("SmallBridge 8x Small Holder - SW")
end
