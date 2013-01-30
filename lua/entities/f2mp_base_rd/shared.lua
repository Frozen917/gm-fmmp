ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= true
ENT.AdminSpawnable	= true

ENT.DeviceName = "Unknown Device"

function ENT:SetupDataTables()
	self:NetworkVar( "String", 0, "DeviceClass")
end

function ENT:Initialize()
	if SERVER then
		self:SetUseType(SIMPLE_USE)
		self:SetSkin(1)
		self.lastuse = CurTime()
		self.enabled = false
		self.runnable = false
	elseif CLIENT then
		self:Setup(self:GetDeviceClass())
	end
	
end

function ENT:GetDeviceName()
	return self.DeviceName
end

function ENT:SetDeviceName(name)
	self.DeviceName = name or ""
end
