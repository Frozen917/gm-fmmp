ENT.Type 			= "anim"
ENT.Base 			= "sb_base_rd"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= false
ENT.AdminSpawnable	= false


function ENT:Initialize(child)
	self.BaseClass:Initialize(child)
	child.plugs = {}
	if SERVER then
		self.ServerSideInit(child)
	end
end

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
