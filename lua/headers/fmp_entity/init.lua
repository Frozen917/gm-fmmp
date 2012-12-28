function ENT:OnSpawn(spawner, trace, frozen)

end

function ENT:SpawnFunction(spawner, trace, frozen)
	local ent = ents.Create(self.ClassName)

	local a = trace.HitNormal:Angle() 
	a.pitch = a.pitch + 90

	ent:SetPos(trace.HitPos + trace.HitNormal)
	ent:Spawn()
	ent:Activate()
	ent:PhysWake()
	if frozen and ent:GetPhysicsObject():IsValid() then
		ent:GetPhysicsObject():EnableMotion(false)
	end
	local min = ent:OBBMins()
	ent:SetPos( trace.HitPos - trace.HitNormal * min.z )
	
	ent:SetAngles( a )
	local txt = string.gsub(self.DeviceName, " ", "_")
	undo.Create(txt)
		undo.AddEntity(ent)
		undo.SetPlayer(spawner)
		undo.SetCustomUndoText("Undone " .. self.DeviceName)
	undo.Finish()
	self:OnSpawn(spawner, trace, frozen)
	
	return ent
end