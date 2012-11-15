ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= false
ENT.AdminSpawnable	= false

function ENT:Initialize(child)
	child.runnable = false
	child.enabled = false
	child.inputRates = {}
	child.outputRates = {}
	child.resourceCache = {}
	if SERVER then
		self.ServerSideInit(child)
	end
end

function ENT:Runnable()
	return self.runnable
end

function ENT:Running()
end