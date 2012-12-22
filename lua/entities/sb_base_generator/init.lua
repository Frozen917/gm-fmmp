AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:ServerSideInit()
	self:SetSkin(1)
	self.resourceCache = {}
	self.type = "GENERATOR"
end

function ENT:GetNeeds()
	if not self.enabled then return {} end
	local needs = {}
	for resource,amount in pairs(self.inputRates) do
		needs[resource] = amount
	end
	return needs
end

function ENT:Run(resources)
	self:BroadcastResources()
	local enough = true
	for resource,amount in pairs(self.inputRates) do
		if (resources[resource] or 0) < amount then
			enough = false
			break
		end
	end
	if enough then
		for resource,amount in pairs(self.outputRates) do
			self.resourceCache[resource] = amount
		end
	end
	self.runnable = enough
	self.enabled = enough and self.enabled
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

function ENT:AskResource(resource)
	if not self.enabled or not self.resourceCache[resource] then return 0 end
	return self.resourceCache[resource]
end

function ENT:GetCachedResource(resource)
	if self:GetType() == "GENERATOR" then
		return self.outputRates[resource] or 0
	end
end

function ENT:BroadcastResources()
	for resource,amount in pairs(self.outputRates) do
		self:SetNetworkedInt(resource, amount - (self.resourceCache[resource] or 0))
	end
end
