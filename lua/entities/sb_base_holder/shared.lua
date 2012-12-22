ENT.Type 			= "anim"
ENT.Base 			= "sb_base_pluggable"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= false
ENT.AdminSpawnable	= false


local posSensibility = 40
local angleSensibility = 15
local moveSpeed = 0.4


function ENT:Initialize(child)
	self.BaseClass:Initialize(child)
	if SERVER then
		self.ServerSideInit(child)
	end
end
