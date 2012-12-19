ENT.Type 			= "anim"
ENT.Base 			= "sb_base_holdable"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= false
ENT.AdminSpawnable	= false



function ENT:Initialize(child)
	self.BaseClass:Initialize(child)
	child.resources = {}
	if SERVER then
		self.ServerSideInit(child)
	end
end
