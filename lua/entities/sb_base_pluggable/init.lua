AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:ServerSideInit()
	self.type = "DEVICE"
end

function ENT:UpdateStatus()
end