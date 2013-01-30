AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function ENT:SpawnFunction(spawner, trace, frozen, typ)
	local ent = ents.Create(self.ClassName)

	ent:SetDeviceClass(typ)
	
	ent:Setup(typ)
	
	ent:PhysicsInit(SOLID_VPHYSICS)
	ent:SetMoveType(MOVETYPE_VPHYSICS)
	ent:SetSolid(SOLID_VPHYSICS)
	ent:SetPos(trace.HitPos + trace.HitNormal)
	ent:Spawn()
	ent:Activate()
	ent:PhysWake()
	if frozen and ent:GetPhysicsObject():IsValid() then
		ent:GetPhysicsObject():EnableMotion(false)
	end
	local min = ent:OBBMins()
	ent:SetPos( trace.HitPos - trace.HitNormal * min.z )
	
	local a = trace.HitNormal:Angle() 
	a.pitch = a.pitch + 90
	ent:SetAngles( a )
	
	local txt = string.gsub(ent.DeviceName, " ", "_")
	undo.Create(txt)
		undo.AddEntity(ent)
		undo.SetPlayer(spawner)
		undo.SetCustomUndoText("Undone " .. ent.DeviceName)
	undo.Finish()
	
	return ent
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
