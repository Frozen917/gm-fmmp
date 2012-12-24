ENT.implementation = { "fmp_entity" }
include("headers/headers.lua")

ENT.addInitFunction(function(self)
	self.runnable = false
	self.enabled = false
	self.inputRates = {}
	self.outputRates = {}
	self.name = ""
end)

function ENT:Runnable()
	return self.runnable
end

function ENT:Running()
end

function ENT:GetDeviceName()
	return self.name
end

function ENT:SetDeviceName(name)
	self.name = name or ""
end
