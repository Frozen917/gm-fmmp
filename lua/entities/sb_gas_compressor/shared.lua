ENT.Type 			= "anim"
ENT.Base 			= "sb_base_holder"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true

ENT.DeviceName 		= "Gas Compressor"

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	if SERVER then
		self:SetModel("models/mandrac/lgm/compressor.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self.resourceCache = {}

		table.insert(self.slots, Slot.New(
			self,
			1,
			Vector(48.4833984375,0.041036151349545,-9.5582443237305),
			Vector(1, 0, 0),
			15,
			0.4,
			90
		))
		table.insert(self.slots, Slot.New(
			self,
			1,
			Vector(-48.4833984375,-0.043010577559471,-9.5570426940918),
			Vector(-1, 0, 0),
			15,
			0.4,
			90
		))
	end
	self.inputRates = { energy = 50 }
	self.outputRates = { generic = 2000 }
	table.insert(self.plugs, Plug.New(self, 1, Vector(-0.075926847755909,-20.314468383789,-13.356286048889), Vector(0,-1,0), Angle(0,-90,-180)))
	table.insert(self.plugs, Plug.New(self, 2, Vector(-0.21118253469467,20.31443977356,-13.183825492859), Vector(0,1,0), Angle(0,90,-180)))
end
