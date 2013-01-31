ENT.Type 			= "anim"
ENT.Base 			= "f2mp_base_rd"
ENT.Category 		= "FMP GameMode"

ENT.Spawnable 		= false
ENT.AdminSpawnable	= false

function ENT:Setup(typ)
	local settings = Devices.GetRegisteredHolders()[typ]
	self.slots = {}
	for _,slot in pairs(settings.slots) do
		table.insert(self.slots, Slot.New(self, unpack(slot)))
	end
	self.plugs = {}
	for i,plug in pairs(settings.plugs) do
		table.insert(self.plugs, Plug.New(self, i, unpack(plug)))
	end
	self:SetModel(settings.model)
	self.deviceClass = typ
	self.DeviceName = settings.name
	self.hooks = settings.hooks
end

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	if SERVER then
		self.angleSensibility = 25
		ResourceDistribution.AddDevice(self)
	end
	self.type = "HOLDER"
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
