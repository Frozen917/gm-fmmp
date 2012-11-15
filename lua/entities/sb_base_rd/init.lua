AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:ServerSideInit()
	self:SetUseType(SIMPLE_USE)
end

function ENT:Use()
	self.enabled = not self.enabled
end

function ENT:CacheResource(sResource)
	return self.resourceCache[sResource] or 0
end

function ENT:TakeResource(sResource, nAmount)
	local cacheAmount = self:CacheResource(sResource)
	if cacheAmount >= nAmount then
		self.resourceCache[sResource] = self.resourceCache[sResource] - nAmount
		return true
	end
	return false
end
