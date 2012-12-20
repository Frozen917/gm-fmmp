AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:ServerSideInit()
	self:SetUseType(SIMPLE_USE)
end

function ENT:Use()
	self.enabled = not self.enabled
end

function ENT:TakeResource(resource, amount)
	return 0
end

function ENT:AskResource(resource)
	return 0
end

function ENT:GetType()
	return self.type or "UNKNOWN"
end