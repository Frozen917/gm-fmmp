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
	amount = math.min(amount, self.resources[resource].flow)
	if self.resources[resource].amount < amount then
		local consumed = self.resources[resource].amount
		self.resources[resource].amount = 0
		return consume
	else
		self.resources[resource].amount = self.resources[resource].amount - amount
		return amount
	end
end

function ENT:AskResource(resource)
	return math.min(self.resources[resource].flow, self.resources[resource].amount)
end