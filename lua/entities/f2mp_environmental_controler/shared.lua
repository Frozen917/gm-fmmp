ENT.Type 			= "anim"
ENT.Base 			= "f2mp_base_rd"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true

ENT.AutomaticFrameAdvance = true 
ENT.DeviceName = "Environmental Controler"

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	if SERVER then
		self:SetModel("models/mandrac/lgm/lifesupport_l.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self.sound = CreateSound(self, Sound("ambient/underground.wav"))
		self.lastSeqReset = CurTime()
		ResourceDistribution.AddDevice(self)
	end
	self.inputRates = {energy=200}
	table.insert(self:GetPlugs(), Plug.New(self, 1, Vector(0.65815246105194,-210.2809753418,-42.927421569824), Vector(0,-1,0), Angle(0,-90,0)))
	table.insert(self:GetPlugs(), Plug.New(self, 2, Vector(0.65815246105194,-210.2809753418,-30.927421569824), Vector(0,-1,0), Angle(0,-90,0)))
end
