AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:ServerSideInit()
	self.holder = nil
	self.lastuse = CurTime()
	self:SetUseType(SIMPLE_USE)
end

function ENT:Use()
	self.enabled = not self.enabled
	if CurTime() - self.lastuse < 0.5 then
		if self.holder != nil then
			if self.holder:IsValid() then
				self.holder:Extract(self)
			else
				self.holder = nil
			end
		end
	end
	self.lastuse = CurTime()
end

function ENT:SetHolder(eHolder)
	self.holder = eHolder
end

function ENT:GetCachedResource(resource)
	if self:GetType() == "GENERATOR" then
		return self.outputRates[resource] or 0
	elseif self:GetType() == "CONTAINER" then
		local cache = self.resources[resource]
		if cache then
			return cache.amount
		else
			return 0
		end
	end
end
