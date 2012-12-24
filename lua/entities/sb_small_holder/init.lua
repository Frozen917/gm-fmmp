AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local angleTolerance = 30

ENT.addInitFunction(function(self)
	self:SetModel("models/mandrac/lgm/genholder_small_single.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	table.insert(self.slots, Slot.New(
		self,
		1,
		Vector(0, 0, 39.76),
		Vector(0, 0, 1),
		15,
		0.4,
		0
	))
end)
