AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:ServerSideInit()
	ResourceDistribution.AddDevice(self)
end

function ENT:OnRemove()
	ResourceDistribution.RemoveDevice(self)
end

function ENT:ProcessResources()
	self.resourceCache = {}
	local status = self.enabled
	local devices = {}
	local hasResource = true
	for k,v in pairs(self.inputRates) do
		local plugs = {}
		local amount = 0
		for i,p in ipairs(self:GetPlugs()) do
			if p:IsPlugged() then
				local remoteAmount = p:GetOtherPlug():GetEntity():CacheResource(k)
				if amount + remoteAmount > v then
					remoteAmount = v - amount
				end
				if remoteAmount > 0 then
					table.insert(plugs, { p, k, remoteAmount })
				end
				amount = amount + remoteAmount
			end
		end
		if amount == v then
			table.insert(devices, plugs)
		else
			hasResource = false
		end
	end
	if hasResource then
		for i,v in ipairs(devices) do
			for j,p in ipairs(v) do
				p[1]:GetOtherPlug():GetEntity():TakeResource(p[2], p[3])
			end
		end
	end
	self.runnable = hasResource
	self.enabled = self.runnable and self.enabled
	if status != self.enabled then
		self:UpdateStatus()
	end
end

function ENT:UpdateStatus()
end