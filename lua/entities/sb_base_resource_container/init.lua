AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:ServerSideInit()
	self.type = "CONTAINER"
	self:SetSkin(1)
end

function ENT:GetNeeds()
	local needs = {}
	for resource,amounts in pairs(self.resources) do
		local delta = amounts.maxamount - amounts.amount
		if delta > 0 then
			needs[resource] = math.min(, amounts.flow)
		end
	end
	return needs
end

function ENT:Run(resources)
	for resource,amounts in pairs(self.resources) do
		self.resources[resource].amount = self.resources[resource].amount + math.min(resources[resource] or 0, math.min(amounts.maxamount - amounts.amount, amounts.flow))
	end
	self:UpdateSkin()
end

function ENT:TakeResource(resource, amount)
	if not self.resources[resource] then return 0 end
	local possessed = self.resources[resource].amount or 0
	amount = math.min(amount, self.resources[resource].flow or 0)
	if possessed < amount then
		self.resources[resource].amount = 0
		self:UpdateSkin()
		return possessed
	else
		self.resources[resource].amount = possessed - amount
		self:UpdateSkin()
		return amount
	end
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