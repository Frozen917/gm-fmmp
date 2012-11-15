ENT.Type 			= "anim"
ENT.Base 			= "sb_base_holdable"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= false
ENT.AdminSpawnable	= false



function ENT:Initialize(child)
	self.BaseClass:Initialize(child)
	child.resources = {}
end


function ENT:GetResourceAmount(sResource)
	if self.resources[sResource] then
		return self.resources.amount or 0
	else
		return 0
	end
end

function ENT:GetResourceMaxAmount(sResource)
	if self.resources[sResource] then
		return self.resources.maxamount or 0
	else
		return 0
	end
end

function ENT:AddResource(sResource, nAmount)
	local am = self:GetResourceAmount(sResource)
	local amm = self:GetResourceMaxAmount(sResource)
	if am < amm then
		if am + nAmount > amm then
			nAmount = amm - am			
		end
		self.resources[sResource].amount = am + nAmount
		return nAmount
	else
		return 0
	end
end


function ENT:DrainResource(sResource, nAmount)
	local am = self:GetResourceAmount(sResource)
	if am > nAmount then
		if am - nAmount < 0 then
			nAmount = am		
		end
		self.resources[sResource].amount = am - nAmount
		return nAmount
	else
		return 0
	end
end