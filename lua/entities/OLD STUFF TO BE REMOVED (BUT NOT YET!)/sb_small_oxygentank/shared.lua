ENT.Type 			= "anim"
ENT.Base 			= "sb_base_holdable_container"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true

ENT.DeviceName = "Small Oxygen Tank"

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	if SERVER then
		self:SetModel("models/mandrac/lgm/gascan.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
	end
	self.slotSize = 1
	self.holdAngle = Angle(90, 0, 0)
	self.heightOffset = 1.4531505584715
	self.resources["oxygen"] = { amount = 0, maxamount = 60000, flow = 2000 }
	self.resources["nitrogen"] = { amount = 0, maxamount = 60000, flow = 2000 }
	self.resources["CO2"] = { amount = 0, maxamount = 60000, flow = 2000 }
end