AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.addInitFunction(function(self)
	self:SetModel("models/mandrac/lgm/gassplitter.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
end)

function ENT:SpawnFunction(spawner, trace)
	local entity = ents.Create("sb_oxygen_filter")
	entity:SetPos(trace.HitPos + trace.HitNormal*26) 
    entity:Spawn()
    entity:Activate()
	undo.Create("Oxygen_Filter")
		undo.AddEntity(entity)
		undo.SetPlayer(spawner)
		undo.SetCustomUndoText("Undone Oxygen Filter")
	undo.Finish()
end