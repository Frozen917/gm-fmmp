AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.angleSensibility = 15

function ENT:ServerSideInit()
	self.slots = {}
	self.type = "HOLDER"
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

function ENT:TakeResource(resource, amount)
	local taken = 0
	for _,slot in ipairs(self:GetSlots()) do
		if not slot:IsFree() then
			taken = taken + slot:GetGenerator():TakeResource(resource, math.max(0, amount - taken))
		end
	end
	return taken
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
		if slot:GetGenerator() != nil then
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