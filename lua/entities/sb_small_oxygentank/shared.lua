ENT.Type 			= "anim"
ENT.Base 			= "sb_base_resource_container"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true


function ENT:Initialize()
	self.BaseClass:Initialize(self)
	if SERVER then
		self:ServerSideInit()
	end
	self:SetDeviceName("Small Oxygen Tank")
	self.slotSize = 1
	self.holdAngle = Angle(90, 0, 0)
	self.resources["oxygen"] = { amount = 0, maxamount = 60000, flow = 100 }
end