ENT.Type 			= "anim"
ENT.Base 			= "sb_base_holder"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true

ENT.DeviceName = "SmallBridge 2x Large Holder - SW"

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	if SERVER then
		self:SetModel("models/mandrac/lgm/genholder_sw.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		table.insert(self.slots, Slot.New(
			self,
			3,
			Vector(45.2, -56.3, -10.2),
			Vector(0, -1, 0),
			40,
			0.4
		))
		table.insert(self.slots, Slot.New(
			self,
			3,
			Vector(-45.2, -56.3, -10.2),
			Vector(0, -1, 0),
			40,
			0.4
		))
		self.type = "HOLDER"
	end
	table.insert(self.plugs, Plug.New(self, 1, Vector(-78.401016235352,-55.906661987305,-48.207065582275), Vector(0,-1,0), Angle(0,-90,0)))
	table.insert(self.plugs, Plug.New(self, 2, Vector(76.658271789551,-55.906215667725,-48.028030395508), Vector(0,-1,0), Angle(0,-90,0)))
end
