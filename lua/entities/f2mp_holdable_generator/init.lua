AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

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

function ENT:GetType()
	return self.type or "GENERATOR"
end

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
	for resource,amount in pairs(self.inputRates) do 	-- Check for resources
		if (resources[resource] or 0) < amount then
			enough = false
			break
		end
	end
	for characteristic,limits in pairs(self.requiredCharacteristics) do 	-- Check for characteristics (wind? water?)
		local charac = self:GetEnvCharacteristic(characteristic)
		if charac < limits.min or charac > limits.max then
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

function ENT:Think()
	if CurTime() - self.lastSeqReset > 1 then
		self.lastSeqReset = CurTime()
		if not self.holder then self.runnable = false end
		local sequence
		if self.runnable then
			if not self.sound:IsPlaying() then self.sound:Play() end
			if self:GetSkin() == 1 then self:SetSkin(2) end
			sequence = self.animationOn
		else
			if self.sound:IsPlaying() then self.sound:Stop() end
			if self:GetSkin() == 2 then self:SetSkin(1) end
			sequence = self.animationIdle
		end
		self:ResetSequence(self:LookupSequence(sequence))
		self:SetPlaybackRate(1)
	end
	self:NextThink(CurTime())
	return true
end
