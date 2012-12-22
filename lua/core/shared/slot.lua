Slot = {}
Slot.__index = Slot

function Slot.New(eParent, nSize, vGrabPos, vNormal, nRadius, nSpeed, nRoll)
	local slot = {}
	setmetatable(slot, Slot)
	slot.entity = eParent
	slot.size = nSize
	slot.position = vGrabPos
	slot.normal = vNormal
	slot.radius = nRadius
	slot.speed = nSpeed
	slot.working = false
	slot.generator = nil
	slot.progression = 0
	slot.mass = 0
	slot.weld = nil
	slot.nocollide = nil
	slot.offset = 0
	slot.roll = nRoll
	return slot
end

function Slot:GetEntity()
	return self.entity
end

function Slot:GetSize()
	return self.size
end

function Slot:GetPos()
	return self.position
end

function Slot:GetNormal()
	return self.normal
end

function Slot:GetRadius()
	return self.radius
end

function Slot:GetGenerator()
	return self.generator
end

function Slot:GetWeld()
	return self.weld
end

function Slot:IsFree()
	return self.generator == nil and not self.working
end

function Slot:GetLength(slot)
	if slot.size == 1 then
		return 39
	elseif slot.size == 2 then
		return -1
	elseif slot.size == 3 then
		return 151.23
	else
		return -1
	end
end

function Slot:PlaySound()
	sound.Play("weapons/sentry_upgrading_steam" .. Util.RandInt(1, 5) .. ".wav", self.entity:LocalToWorld(self.position))
end

-- Taken from Divran's NoCollide Remover
function Slot:RemoveNoCollide()
	for i,v in ipairs(constraint.FindConstraints(self.generator, "NoCollide")) do
		if (v.Ent2 == self.generator and v.Ent1 == self.entity) or (v.Ent1 == self.generator and v.Ent2 == self.entity) then
			v.Constraint:Input("EnableCollisions", nil, nil, nil)
			v.Constraint:Remove()
			v = nil
		end
	end
end

function Slot:Grab(eGenerator)
	self.generator = eGenerator
	self.generator:SetHolder(self.entity)
	self.working = true
	self.progression = 0
	self.direction = 1
	constraint.NoCollide(self.entity, self.generator, 0, 0)
	self.offset = (self.generator:WorldToLocal(self.generator:GetPos()) - (self.generator:OBBCenter() - Vector(0, 0, 0.5)*(self.generator:OBBMaxs() - self.generator:OBBMins()) - Vector(0, 0, self.generator.heightOffset))).z
	self:PlaySound()
end

function Slot:GrabDone()
	self.working = false
	self.weld = constraint.Weld(self.entity, self.generator, 0, 0, 0, false)
	self.generator:GetPhysicsObject():EnableMotion(true)
	self.mass = self.generator:GetPhysicsObject():GetMass()
	self.generator:GetPhysicsObject():SetMass(1)
	self:PlaySound()
end

function Slot:Extract()
	self.working = true
	self.direction = -1
	if self.weld != nil and self.weld:IsValid() then
		self.weld:Remove()
	end
	self:PlaySound()
end

function Slot:ExtractDone()
	self:RemoveNoCollide()
	self.generator:GetPhysicsObject():SetMass(self.mass)
	self.generator.holder = nil
	self:Cancel()
	self:PlaySound()
end

function Slot:Cancel()
	self.working = false
	self.progress = 0
	self.weld = nil
	if self.generator != nil and self.generator:IsValid() then
		self.generator:GetPhysicsObject():SetMass(self.mass)
	end
	self.mass = 0
	self.generator = nil
end

function Slot:IsWorking()
	return self.working
end

function Slot:DoWork()
	if self.generator and self.generator:IsValid() then
		self.generator:GetPhysicsObject():EnableMotion(false)
		local angle = self.normal:Angle() + self.generator:GetHoldAngle()
		angle:RotateAroundAxis(self.normal, self.roll)
		self.generator:SetAngles(self.entity:LocalToWorldAngles(angle))
		self.progression = self.progression + self.speed*self.direction
		self.generator:SetPos(self.entity:LocalToWorld(	self.position						-- slot position
														+ self.normal*self.offset			-- generator offset
														- self.normal*self.progression))	-- movement
		if self.progression >= self:GetLength(self) then
			self:GrabDone()
		elseif self.progression <= -self:GetLength(self)*0.1 then
			self:ExtractDone()
		end
	else
		self:Cancel()
	end
end
