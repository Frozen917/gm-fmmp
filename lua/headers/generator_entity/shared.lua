ENT.implementation = { "fmp_entity", "rd_entity", "holdable_entity" }
include("headers/headers.lua")

function ENT:GetResourceInputRate(sResource)
	return self.inputRates[sResource] or 0
end

function ENT:GetResourceOutputRate(sResource)
	return self.outputRates[sResource] or 0
end

function ENT:GetResourceInputRates()
	return self.inputRates
end

function ENT:GetResourceOutputRates()
	return self.outputRates
end

function ENT:GetStatus()
	return self.status
end

function ENT:SetStatus(nStatus)
	self.status = nStatus
end
