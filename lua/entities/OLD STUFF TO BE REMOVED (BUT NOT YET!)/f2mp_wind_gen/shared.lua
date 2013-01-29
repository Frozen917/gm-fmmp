ENT.Type 			= "anim"
ENT.Base 			= "sb_base_holdable_generator"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true

ENT.AutomaticFrameAdvance = true 

ENT.DeviceName = "Small Wind Turbine"

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	if SERVER then
		self:SetModel("models/mandrac/lgm/wind_turbine.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self.lastSeqReset = CurTime()
		self.environments = Universe.GetEntityEnvironments(self)
		self.sound = CreateSound(self, "ambient/machines/machine3.wav")
		self.enabled = true
	end
	self.slotSize = 1
	self.holdAngle = Angle(90, 0, 0)
	self.outputRates = 
	{
		energy = 100
	}
end

