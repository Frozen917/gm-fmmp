AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


function ENT:ServerSideInit()
	self:SetModel("models/mandrac/lgm/deuterium_gen.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
end

function ENT:SpawnFunction(spawner, trace)
	local entity = ents.Create("sb_deuterium_gen")
	entity:SetPos(trace.HitPos + trace.HitNormal*76) 
    entity:Spawn()
    entity:Activate()
	undo.Create("Large_Deuterium_Generator")
		undo.AddEntity(entity)
		undo.SetPlayer(spawner)
		undo.SetCustomUndoText("Undone Large Deuterium Generator")
	undo.Finish()
end