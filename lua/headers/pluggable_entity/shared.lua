ENT.implementation = { "fmp_entity", "rd_entity" }
include("headers/headers.lua")

ENT.addInitFunction(function(self)
	self.plugs = {}
	self.type = "DEVICE"
end)

function ENT:GetFreePlug(vClosest)	-- Local to entity
	local plug = nil
	for i=1,#self:GetPlugs() do
		if not self.plugs[i]:IsPlugged() then
			if plug == nil then plug = self.plugs[i]
			else
				if self.plugs[i]:GetPos():Distance(vClosest) < plug:GetPos():Distance(vClosest) then
					plug = self.plugs[i]
				end
			end
		end
	end
	return plug
end

function ENT:GetPlugByID(nIndex)
	for i=1,#self.plugs do
		if self.plugs[i]:GetID() == nIndex then
			return self.plugs[i]
		end
	end
end

function ENT:GetPlugs()
	return self.plugs
end
