AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


local angleTolerance = 30

function ENT:SpawnFunction(spawner, trace)
	local entity = ents.Create("sb_small_holder")
	entity:SetPos(trace.HitPos + trace.HitNormal*23) 
    entity:Spawn()
    entity:Activate()
	undo.Create("SmallBridge_Generator_holder")
		undo.AddEntity(entity)
		undo.SetPlayer(spawner)
		undo.SetCustomUndoText("Undone SmallBridge Generator Holder")
	undo.Finish()
end

function ENT:ServerSideInit()
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
		90
	))
end