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
	return self.type or "CONTAINER"
end

function ENT:GetNeeds()
	local needs = {}
	for resource,amounts in pairs(self.resources) do
		local delta = amounts.maxamount - amounts.amount
		if delta > 0 then
			needs[resource] = math.min(delta, amounts.flow)
		end
	end
	return needs
end

function ENT:Run(resources)
	for resource,amounts in pairs(self.resources) do
		self.resources[resource].amount = self.resources[resource].amount + math.min(resources[resource] or 0, math.min(amounts.maxamount - amounts.amount, amounts.flow))
	end
	self:UpdateSkin()
	self:BroadcastResources()
end

function ENT:TakeResource(resource, amount)
	if not self.resources[resource] then return 0 end
	local possessed = self.resources[resource].amount or 0
	local consumed = 0
	amount = math.min(amount, self.resources[resource].flow or 0)
	if possessed < amount then
		self.resources[resource].amount = 0
		consumed = possessed
	else
		self.resources[resource].amount = possessed - amount
		consumed = amount
	end
	self:UpdateSkin()
	self:BroadcastResources()
	return consumed
end

function ENT:AskResource(resource)
	if not self.resources[resource] then return 0 end
	return math.min(self.resources[resource].flow or 0, self.resources[resource].amount or 0)
end

function ENT:GetCachedResource(resource)
	local cache = self.resources[resource]
	if cache then
		return cache.amount
	else
		return 0
	end
end

function ENT:BroadcastResources()
	for resource,amounts in pairs(self.resources) do
		self:SetNetworkedInt(resource, amounts.amount)
	end
end

function ENT:UpdateSkin()
	local skin = self:GetSkin()
	local charged = false
	for resource,amounts in pairs(self.resources) do
		if amounts.amount > 0 then
			charged = true
		end
	end
	if charged and skin == 1 then
		self:SetSkin(2)
	elseif not charged and skin == 2 then
		self:SetSkin(1)
	end
end
