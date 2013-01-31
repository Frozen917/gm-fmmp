ENT.Type 			= "anim"
ENT.Base 			= "sb_base_holdable_generator"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true

ENT.DeviceName = "Large Deuterium Generator"

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	if SERVER then
		self:SetModel("models/mandrac/lgm/deuterium_gen.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
	end
	self.slotSize = 3
	self.holdAngle = Angle(90, -90, -90)
	self.inputRates = 
	{
		energy = 20
		--deuterium = 100
	}
	self.outputRates = 
	{
		energy = 500
	}
end