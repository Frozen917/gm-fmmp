AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function ENT:SpawnFunction(spawner, trace, frozen)
	local ent = ents.Create(self.ClassName)
	local a = trace.HitNormal:Angle() 
	a.pitch = a.pitch + 90
	ent:Spawn()
	ent:Activate()
	local min = ent:OBBMins()
	ent:SetPos( trace.HitPos - trace.HitNormal * (min.z+1) )
	ent:SetAngles( a )
	local txt = string.gsub(self.DeviceName, " ", "_")
	undo.Create(txt)
		undo.AddEntity(ent)
		undo.SetPlayer(spawner)
		undo.SetCustomUndoText("Undone " .. self.DeviceName)
	undo.Finish()
end

function ENT:Use()
	self.enabled = not self.enabled
end

function ENT:TakeResource(resource, amount)
	return 0
end

function ENT:AskResource(resource)
	return 0
end

function ENT:GetCachedResource(resource)
	return self:AskResource(resource)
end

function ENT:GetType()
	return self.type or "UNKNOWN"
end
