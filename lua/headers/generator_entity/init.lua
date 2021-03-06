ENT.addInitFunction(function(self)
	self:SetSkin(1)
	self.resourceCache = {}
	self.outputCounter = {}
	self.sound = nil
	ResourceDistribution.AddDevice(self)
end)

function ENT:OnRemove()
	ResourceDistribution.RemoveDevice(self)
	if self.sound then
		self.sound:Stop()
	end
end

function ENT:ProcessResources()
	self:BroadcastResources()
	self:UpdateSkin()
	if not self.holder then
		self.runnable = false
		self.enabled = false
	end
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
	self:UpdateSkin()
end

function ENT:TakeResource(resource, amount)
	if not self.enabled or not self.resourceCache[resource] then return 0 end
	if self.resourceCache[resource] > amount then
		self.resourceCache[resource] = self.resourceCache[resource] - amount
		self.outputCounter[resource] = (self.outputCounter[resource] or 0) + amount
		return amount
	else
		local consumed = self.resourceCache[resource]
		self.resourceCache[resource] = 0
		self.outputCounter[resource] = (self.outputCounter[resource] or 0) + consumed
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
		self:SetNetworkedInt(resource, self.outputCounter[resource] or 0)
	end
	self.outputCounter = {}
end

function ENT:UpdateSkin()
	if self.runnable and self.enabled and self:GetSkin() == 1 then
		self:SetSkin(2)
	elseif (not self.runnable or not self.holder) and self:GetSkin() == 2 then
		self:SetSkin(1)
	end
end
