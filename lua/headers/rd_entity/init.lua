ENT.addInitFunction(function(self)
	self:SetUseType(SIMPLE_USE)
	self.runnable = false
	self.enabled = false
end)

function ENT:Use()
	self.enabled = not self.enabled
end

function ENT:TakeResource(resource, amount)
	return 0
end

function ENT:AskResource(resource)
	return 0
end

function ENT:GetCachedResource(resource)
	return self:AskResource(resource)
end

function ENT:GetType()
	return self.type or "UNKNOWN"
end
