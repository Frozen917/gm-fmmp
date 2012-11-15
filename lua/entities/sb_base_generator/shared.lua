ENT.Type 			= "anim"
ENT.Base 			= "sb_base_holdable"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= false
ENT.AdminSpawnable	= false


STATUS_ON = 1
STATUS_OFF = 0


function ENT:Initialize(child)
	self.BaseClass:Initialize(child)
	child.status = STATUS_OFF
	if SERVER then
		self.ServerSideInit(child)
	end
end


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