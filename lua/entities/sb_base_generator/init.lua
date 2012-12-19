AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:ServerSideInit()
	self:SetSkin(1)
end

function ENT:Use()
	self.enabled = not self.enabled
	if CurTime() - self.lastuse < 0.5 then
		if self.holder != nil then
			if self.holder:IsValid() then
				self.holder:Extract(self)
			else
				self.holder = nil
			end
		end
	else
		self:Toggle()
	end
	self.lastuse = CurTime()
end

function ENT:Toggle()
	if self.enabled and self:Runnable() then
		self:SetSkin(2)
	else
		self:SetSkin(1)
	end
end

function ENT:TakeResource(resource, amount)
	if not self.enabled then return end
	if (self.outputRates[resource] > amount) then
		return amount
	else
		return self.outputRates[resource]
	end
end