ENT.Type 			= "anim"
ENT.Base 			= "sb_base_holdable_container"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true

ENT.DeviceName = "Small Energy Cell"

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	if SERVER then
		self:SetModel("models/mandrac/lgm/energycell_s.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
	end
	self.slotSize = 1
	self.holdAngle = Angle(90, 0, 0)
	self.resources["energy"] = { amount = 0, maxamount = 60000, flow = 100 }
end
