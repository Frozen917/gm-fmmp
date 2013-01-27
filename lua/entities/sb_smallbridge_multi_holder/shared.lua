ENT.Type 			= "anim"
ENT.Base 			= "sb_base_holder"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true

ENT.DeviceName = "SmallBridge 8x Small Holder - SW"

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	if SERVER then
		self:SetModel("models/mandrac/lgm/genholder_small_sw.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		-- RIGHT
		table.insert(self.slots, Slot.New(
			self,
			1,
			Vector(-53.572681427002,84.017471313477,-8.349513053894),
			Vector(0.34175047278404,0,0.93979072570801),
			15,
			0.4,
			90
		))
		table.insert(self.slots, Slot.New(
			self,
			1,
			Vector(-53.58349609375,28.173332214355,-8.3456010818481),
			Vector(0.34174245595932,0,0.9397936463356),
			15,
			0.4,
			90
		))
		table.insert(self.slots, Slot.New(
			self,
			1,
			Vector(-53.4814453125,-27.600107192993,-8.3826904296875),
			Vector(0.34174245595932,0,0.9397936463356),
			15,
			0.4,
			90
		))
		table.insert(self.slots, Slot.New(
			self,
			1,
			Vector(-53.43408203125,-83.405281066895,-8.3999395370483),
			Vector(0.34174245595932,0,0.9397936463356),
			15,
			0.4,
			90
		))	
		
		-- LEFT
		table.insert(self.slots, Slot.New(
			self,
			1,
			Vector(53.39990234375,84.172355651855,-8.2872142791748),
			Vector(-0.34174197912216,0,0.93979382514954),
			15,
			0.4,
			90
		))
		table.insert(self.slots, Slot.New(
			self,
			1,
			Vector(53.618789672852,28.331449508667,-8.207615852356),
			Vector(-0.34174236655235,0,0.9397936463356),
			15,
			0.4,
			90
		))
		table.insert(self.slots, Slot.New(
			self,
			1,
			Vector(53.688945770264,-27.442905426025,-8.1821985244751),
			Vector(-0.34174197912216,0,0.93979382514954),
			15,
			0.4,
			90
		))
		table.insert(self.slots, Slot.New(
			self,
			1,
			Vector(53.83154296875,-83.233894348145,-8.1303071975708),
			Vector(-0.34174197912216,0,0.93979382514954),
			15,
			0.4,
			90
		))
	end
	table.insert(self.plugs, Plug.New(self, 1, Vector(-60.783207, -111.510254, -25.141457), Vector(0,-1,0), Angle(0,-90,180)))
	table.insert(self.plugs, Plug.New(self, 2, Vector(60.783207, -111.510254, -25.141457), Vector(0,-1,0), Angle(0,-90,180)))
	table.insert(self.plugs, Plug.New(self, 3, Vector(-60.783207, 111.510254, -25.141457), Vector(0,1,0), Angle(0,90,180)))
	table.insert(self.plugs, Plug.New(self, 4, Vector(60.783207, 111.510254, -25.141457), Vector(0,1,0), Angle(0,90,180)))
end
