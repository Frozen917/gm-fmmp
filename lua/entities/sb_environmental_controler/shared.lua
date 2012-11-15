ENT.Type 			= "anim"
ENT.Base 			= "sb_base_pluggable"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true

ENT.AutomaticFrameAdvance = true 

function ENT:Initialize()
	self.BaseClass:Initialize(self)
	self.inputRates = {energy=200}
	table.insert(self:GetPlugs(), Plug.New(self, 1, Vector(0.65815246105194,-210.2809753418,-42.927421569824), Vector(0,-1,0), Angle(0,-90,0)))
	table.insert(self:GetPlugs(), Plug.New(self, 2, Vector(0.65815246105194,-210.2809753418,-30.927421569824), Vector(0,-1,0), Angle(0,-90,0)))
	if SERVER then
		self:ServerSideInit()
	end
end
