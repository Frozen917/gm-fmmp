AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.angleSensibility = 15

function ENT:ServerSideInit()
	self.slots = {}
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
	local status = self.enabled
	self.resourceCache = {}
	local devices = {}
	local hasResource = true
	local adjustedInputRates = {}
	for k,v in pairs(self.inputRates) do
		adjustedInputRates[k] = v
	end
	for i,v in ipairs(self:GetSlots()) do
		if v:GetGenerator() != nil then
			for k,a in pairs(v:GetGenerator().inputRates) do
				adjustedInputRates[k] = (adjustedInputRates[k] or 0) + a
			end
		end
	end
	for k,v in pairs(adjustedInputRates) do
		local plugs = {}
		local amount = 0
		for i,p in ipairs(self:GetPlugs()) do
			if p:IsPlugged() then
				local remoteAmount = p:GetOtherPlug():GetEntity():CacheResource(k)
				if amount + remoteAmount > v then
					remoteAmount = v - amount
				end
				if remoteAmount > 0 then
					table.insert(plugs, { p, k, remoteAmount })
				end
				amount = amount + remoteAmount
			end
		end
		if amount == v then
			table.insert(devices, plugs)
		else
			hasResource = false
		end
	end
	local resources = {}
	if hasResource then
		for i,r in ipairs(devices) do
			for j,p in ipairs(r) do
				p[1]:GetOtherPlug():GetEntity():TakeResource(p[2], p[3])
				resources[p[2]] = (resources[p[2]] or 0) + p[3]
			end
		end
	end
	self.resourceCache = resources
	for i,v in ipairs(self:GetSlots()) do -- Shouldn't work if the holder's input rates are not satisfied
		local generator = v:GetGenerator()
		if generator != nil then
			for k,a in pairs(generator.outputRates) do
				if generator:TakeResource(k, a) then
					resources[k] = (resources[k] or 0) + a
				end
			end
		end
	end
	self.resourceCache = resources
	self.runnable = hasResource
	self.enabled = self.runnable and self.enabled
	if status != self.enabled then
		self:UpdateStatus()
	end
end