AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:ServerSideInit()
	self:SetSkin(1)
	ResourceDistribution.AddDevice(self)
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

function ENT:ProcessResources()
	self.resourceCache = {}
	local status = self.enabled
	if self.holder == nil or not self.holder:IsValid() then
		return
	end
	local hasResource = true
	for k,v in pairs(self.inputRates) do
		if self.holder:CacheResource(k) < v then
			hasResource = false
		end
	end
	if hasResource then
		for k,v in pairs(self.inputRates) do
			self.holder:TakeResource(k, v)
		end
		for k,v in pairs(self.outputRates) do
			self.resourceCache[k] = v
		end
	end
	self.runnable = hasResource
	self.enabled = self.runnable and self.enabled
	if status != self.enabled then
		self:UpdateStatus()
	end
end

function ENT:OnRemove()
	ResourceDistribution.RemoveDevice(self)
end

function ENT:UpdateStatus()
end
