AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.addInitFunction(function(self)
	self:SetModel("models/mandrac/lgm/wind_turbine.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self.lastSeqReset = CurTime()
	self.environments = Universe.GetEntityEnvironments(self)
	self.sound = CreateSound(self, "ambient/machines/machine3.wav")
	self.enabled = true
end)

function ENT:SpawnFunction(spawner, trace)
	local entity = ents.Create("sb_wind_gen")
	entity:SetPos(trace.HitPos + trace.HitNormal*90) 
    entity:Spawn()
    entity:Activate()
	undo.Create("Wind_Turbine")
		undo.AddEntity(entity)
		undo.SetPlayer(spawner)
		undo.SetCustomUndoText("Undone Wind Turbine")
	undo.Finish()
end

function ENT:Think()
	if CurTime() - self.lastSeqReset > 1 then
		self.lastSeqReset = CurTime()
		local sequence
		if self:GetEnvCharacteristic("wind") > 0 then
			if not self.sound:IsPlaying() then self.sound:Play() end
			sequence = "on"
			self.enabled = true
		else
			if self.sound:IsPlaying() then self.sound:Stop() end
			sequence = "idle"
			self.enabled = false
		end
		self:ResetSequence(self:LookupSequence(sequence))
		self:SetPlaybackRate(1)
	end
	self:NextThink(CurTime())
	return true
end

function ENT:Use()
	if CurTime() - self.lastuse < 0.5 then
		if self.holder != nil then
			if self.holder:IsValid() then
				self.holder:Extract(self)
			else
				self.holder = nil
			end
		end
	end
	self.lastuse = CurTime()
end
