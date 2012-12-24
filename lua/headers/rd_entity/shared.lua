ENT.implementation = { "fmp_entity" }
include("headers/headers.lua")

ENT.addInitFunction(function(self)
	self.inputRates = {}
	self.outputRates = {}
	self.name = ""
end)

function ENT:GetDeviceName()
	return self.name
end

function ENT:SetDeviceName(name)
	self.name = name or ""
end
