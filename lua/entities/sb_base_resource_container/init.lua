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
		needs[resource] = math.min(amounts.maxamount - amounts.amount, amounts.flow)
	end
	return needs
end

function ENT:Run(resources)
	for resource,amounts in pairs(self.resources) do
		self.resources[resource].amount = self.resources[resource].amount + math.min(resources[resource] or 0, math.min(amounts.maxamount - amounts.amount, amounts.flow))
	end
end

function ENT:TakeResource(resource, amount)
	if not self.resources[resource] then return 0 end
	local possessed = self.resources[resource].amount or 0
	amount = math.min(amount, self.resources[resource].flow or 0)
	if possessed < amount then
		self.resources[resource].amount = 0
		return possessed
	else
		self.resources[resource].amount = possessed - amount
		return amount
	end
end

function ENT:AskResource(resource)
	if not self.resources[resource] then return 0 end
	return math.min(self.resources[resource].flow or 0, self.resources[resource].amount or 0)
end