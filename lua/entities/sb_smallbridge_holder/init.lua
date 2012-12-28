AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local angleTolerance = 30

ENT.addInitFunction(function(self)
	self:SetModel("models/mandrac/lgm/genholder_sw.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	table.insert(self.slots, Slot.New(
		self,
		3,
		Vector(45.2, -56.3, -10.2),
		Vector(0, -1, 0),
		40,
		0.4
	))
	table.insert(self.slots, Slot.New(
		self,
		3,
		Vector(-45.2, -56.3, -10.2),
		Vector(0, -1, 0),
		40,
		0.4
	))
	self.type = "HOLDER"
end)
