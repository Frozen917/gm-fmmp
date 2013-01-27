ENT.Type 			= "anim"
ENT.Base 			= "sb_base_holdable_filter"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true

ENT.DeviceName = "Oxygen Filter"

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	if SERVER then
		self:SetModel("models/mandrac/lgm/gassplitter.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
	end
	self.slotSize = 1
	self.holdAngle = Angle(90, 0, 0)
	self.resourceType = "oxygen"
end
