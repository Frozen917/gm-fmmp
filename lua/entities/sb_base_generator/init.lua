AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:ServerSideInit()
	self:SetSkin(1)
	ResourceDistribution.AddDevice(self)
	self.resourceCache = {}
	self.type = "GENERATOR"
end

function ENT:OnRemove()
	ResourceDistribution.RemoveDevice(self)
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
	else
		self:Toggle()
	end
	self.lastuse = CurTime()
end

function ENT:Toggle()
	if self.enabled and self:Runnable() then
		self:SetSkin(2)
	else
		self:SetSkin(1)
	end
end

function ENT:TakeResource(resource, amount)
	if not self.enabled or not self.resourceCache[resource] then return 0 end
	if self.resourceCache[resource] > amount then
		self.resourceCache[resource] = self.resourceCache[resource] - amount
		return amount
	else
		local consumed = self.resourceCache[resource]
		self.resourceCache[resource] = 0
		return consumed
	end
end

function ENT:ProcessResources()
	if self.enabled then
		for k,v in pairs(self.outputRates) do
			self.resourceCache[k] = v
		end
	end
end