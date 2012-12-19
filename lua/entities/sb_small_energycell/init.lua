AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:ServerSideInit()
	self:SetModel("models/mandrac/lgm/energycell_s.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
end

function ENT:SpawnFunction(spawner, trace)
	local entity = ents.Create("sb_small_energycell")
	entity:SetPos(trace.HitPos + trace.HitNormal*26) 
    entity:Spawn()
    entity:Activate()
	undo.Create("Energy_Cell")
		undo.AddEntity(entity)
		undo.SetPlayer(spawner)
		undo.SetCustomUndoText("Undone Small Energy Cell")
	undo.Finish()
end