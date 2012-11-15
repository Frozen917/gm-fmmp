AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:SpawnFunction(spawner, trace)
	local entity = ents.Create("sb_environmental_controler")
	entity:SetPos(trace.HitPos + trace.HitNormal*56) 
    entity:Spawn()
    entity:Activate()
	undo.Create("Environmental Controler")
		undo.AddEntity(entity)
		undo.SetPlayer(spawner)
		undo.SetCustomUndoText("Undone Environmental Controler")
	undo.Finish()
end

function ENT:ServerSideInit()
	self:SetModel("models/mandrac/lgm/lifesupport_l.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self.sound = CreateSound(self, Sound("ambient/underground.wav"))
	self.lastSeqReset = CurTime()
end

function ENT:OnRemove()
	self.BaseClass.OnRemove(self)
	Universe.RemoveEnvironment(self.generated)
	self.sound:Stop()
end

function ENT:Think()
	if self:Runnable() and self.enabled then
		self.generated:SetPos(self:GetPos())
	end
	if self:Runnable() and self.enabled and CurTime() - self.lastSeqReset > 0.5 then
		self.lastSeqReset = CurTime()
		self:ResetSequence(self:LookupSequence("on"))
	end
	self:NextThink(CurTime())
	return true
end

function ENT:Use()
	self.enabled = not self.enabled
	self:UpdateStatus()
end

function ENT:UpdateStatus()
	if self:Runnable() and self.enabled then
		self.generated = Universe.CreateEnvironment(nil, 500, self:GetPos(), {oxygen=100}, {ents_gravity = -1, players_gravity = 1, wind = -1, noclip = -1})
		self.sound:Play()
	else
		Universe.RemoveEnvironment(self.generated)
		self.sound:Stop()
		self:ResetSequence(self:LookupSequence("idle"))
	end
end
