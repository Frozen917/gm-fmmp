AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function ENT:Setup(type)
	local settings = Devices.GetRegisteredHolders()[type]
	self.slots = {}
	for _,slot in pairs(settings.slots) do
		table.insert(self.slots, Slot.New(self, unpack(slot)))
	end
	self.plugs = {}
	for i,plug in pairs(settings.plugs) do
		table.insert(self.plugs, Plug.New(self, i, unpack(plug)))
	end
	self:SetModel(settings.model)
	self.DeviceName = settings.name
end

function ENT:GetType()
	return self.type or "HOLDER"
end

function ENT:OnRemove()
	ResourceDistribution.RemoveDevice(self)
end

function ENT:Extract(eGenerator)
	for i,v in ipairs(self:GetSlots()) do
		if v:GetGenerator() == eGenerator and not v:IsWorking() then
			v:Extract()
		end
	end
end

function ENT:GetSlots()
	return self.slots
end

function ENT:GetSlotByPos(vRelativePos)
	for i,v in ipairs(self:GetSlots()) do
		if v:GetPos():Distance(vRelativePos) <= v:GetRadius() then
			return v
		end
	end
end

function ENT:PhysicsCollide(colData, collider)
	local generator = colData.HitEntity
	if generator:IsValid() and not generator:IsWorld() and generator.GetSlotSize != nil then
		local slot = self:GetSlotByPos(self:WorldToLocal(colData.HitPos))
		if slot != nil and slot:IsFree() and generator:GetSlotSize() == slot:GetSize() then
			local generatorCenter = generator:LocalToWorld(generator:OBBCenter())
			local generatorPlug = generator:LocalToWorld(generator:OBBCenter() - Vector(0, 0, 1)*(generator:OBBMaxs() - generator:OBBMins()).z/2)
			local generatorAngle = Util.AngleBetweenVectors(slot:GetNormal(), self:WorldToLocal(generatorCenter)-self:WorldToLocal(generatorPlug))
			if generatorAngle < self.angleSensibility then
				slot:Grab(generator)
			end
		end
	end
end

function ENT:Think()
	for i,v in ipairs(self:GetSlots()) do
		if v:IsWorking() then
			v:DoWork()
		elseif v:GetGenerator() != nil and not v:GetGenerator():IsValid() then
			v:Cancel()
		elseif v:GetGenerator() != nil and not v:GetWeld():IsValid() then
			v:Extract()
		end
	end
	self:NextThink(CurTime())
	return true
end

function ENT:ProcessResources()
	-- Compute what slot need what
	local needed = {}
	for index,slot in ipairs(self:GetSlots()) do
		if slot:GetGenerator() then
			needed[index] = {}
			for resource,amount in pairs(slot:GetGenerator():GetNeeds()) do
				needed[index][resource] = amount
			end
		end
	end

	-- Compute total resources needed and compute splitting coefficients
	local consume = {}
	local splitting = {}
	for _,resources in pairs(needed) do
		for resource,amount in pairs(resources) do
			consume[resource] = (consume[resource] or 0) + amount
			splitting[resource] = (splitting[resource] or 0) + 1
		end
	end

	-- Retrieve these resources
	local cache = {}
	for _,plug in ipairs(self:GetPlugs()) do
		if plug:IsPlugged() then
			local connected = plug:GetOtherPlug():GetEntity()
			for resource,amount in pairs(consume) do
				if connected:GetType() != "CONTAINER" then
					cache[resource] = (cache[resource] or 0) + connected:TakeResource(resource, amount - (cache[resource] or 0))
				end
			end
		end
	end

	-- Now run the generators
	for index,slot in ipairs(self:GetSlots()) do
		if slot:GetGenerator() then
			local resources = {}
			local runnable = true
			for resource,amount in pairs(needed[index]) do -- Split the resources between generators
				if slot:GetGenerator():GetType() == "GENERATOR" then
					if (cache[resource] or 0) >= amount then
						resources[resource] = amount
					else
						runnable = false
					end
				elseif slot:GetGenerator():GetType() == "CONTAINER" then	-- May have some loss here... need a fix!
					resources[resource] = (cache[resource] or 0)/splitting[resource]
				else
					runnable = false
				end
			end
			slot:GetGenerator():Run(resources)
			for resource,amount in pairs(resources) do 	-- Consume the resources if the device ran, reduce the splitting
				if runnable then
					cache[resource] = (cache[resource] or 0) - amount
				end
				splitting[resource] = splitting[resource] - 1
			end
		end
	end
end

-- TODO: Limitation with flow! Now the limitation is for 1 request
function ENT:TakeResource(resource, amount)
	-- Take and distribute the resources
	local taken = 0
	for _,slot in ipairs(self:SortSlots()) do
		if not slot:IsFree() then
			taken = taken + slot:GetGenerator():TakeResource(resource, math.max(0, amount - taken))
		end
	end
	return taken
end

function ENT:SortSlots()
	-- Sort to equilibrate resources in the slots
	local sorted = {}
	for _,slot in ipairs(self:GetSlots()) do
		local generator = slot:GetGenerator()
		if generator then
			table.insert(sorted, 1, slot)
			local position = 1
			local quantity = generator:GetCachedResource(resource)
			for index,item in ipairs(sorted) do
				if quantity < item:GetGenerator():GetCachedResource(resource) then
					position = index
				end
			end
			if position != 1 then
				table.remove(sorted, 1)
				table.insert(sorted, position, slot)
			end
		end
	end
	return sorted
end

function ENT:AskResource(resource)
	local available = 0
	for _,slot in ipairs(self:GetSlots()) do
		if not slot:IsFree() then
			available = available + slot:GetGenerator():AskResource(resource)
		end
	end
	return available
end

function ENT:GetType()
	local type = self.type
	for _,slot in pairs(self:GetSlots()) do
		if slot:GetGenerator() then
			if type == self.type then
				type = slot:GetGenerator():GetType()
			elseif type != slot:GetGenerator():GetType() then
				type = self.type
				break
			end
		end
	end
	return type
end
