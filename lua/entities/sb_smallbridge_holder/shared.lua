ENT.Type 			= "anim"
ENT.Base 			= "sb_base_holder"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true

function ENT:Initialize()
	self.BaseClass:Initialize(self)
	table.insert(self.plugs, Plug.New(self, 1, Vector(-78.401016235352,-55.906661987305,-48.207065582275), Vector(0,-1,0), Angle(0,-90,0)))
	table.insert(self.plugs, Plug.New(self, 2, Vector(76.658271789551,-55.906215667725,-48.028030395508), Vector(0,-1,0), Angle(0,-90,0)))

	if SERVER then
		self:ServerSideInit()
	end
	self:SetDeviceName("SmallBridge 2x Large Holder - SW")
end
