AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:ServerSideInit()
	ResourceDistribution.AddDevice(self)
	self:SetSkin(1)
end

function ENT:OnRemove()
	ResourceDistribution.RemoveDevice(self)
end

function ENT:ProcessResources()
	if not self.holder then return end
	for _,plug in ipairs(self.holder:GetPlugs()) do
		if plug:IsPlugged() then
			for resource,amounts in pairs(self.resources) do
				local currentAmount = amounts.amount
				local maxAmount = amounts.maxamount
				local flow = amounts.flow
				self.resources[resource].amount = currentAmount + (plug:GetOtherPlug():GetEntity():TakeResource(resource, math.min(maxAmount - currentAmount, amounts.flow)) or 0)
			end
		end
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