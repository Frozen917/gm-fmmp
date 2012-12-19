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
	ResourceDistribution.AddDevice(self)
end

function ENT:OnRemove()
	self.BaseClass.OnRemove(self)
	Universe.RemoveEnvironment(self.generated)
	ResourceDistribution.RemoveDevice(self)
	self.sound:Stop()
end

function ENT:Think()
	if self:Runnable() and self.enabled then
		if not self.generated then
			self:UpdateStatus()
		end
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

function ENT:ProcessResources()
	if not self.enabled then return end
	local hasResource = true
	local resourceCounter = {}

	-- Check resources available
	for _,plug in ipairs(self:GetPlugs()) do
		if plug:IsPlugged() then
			for resource,_ in pairs(self.inputRates) do
				resourceCounter[resource] = (resourceCounter[resource] or 0) + plug:GetOtherPlug():GetEntity():AskResource(resource)				
			end
		end
	end

	-- Check if enough resources are available
	for resource,amount in pairs(self.inputRates) do
		if resourceCounter[resource] < amount then
			hasResource = false
		end
	end

	-- Consume resources
	if hasResource then
		local resourceDone = {}
		for _,plug in ipairs(self:GetPlugs()) do
			if plug:IsPlugged() then
				for resource,amount in pairs(self.inputRates) do
					resourceDone[resource] = plug:GetOtherPlug():GetEntity():TakeResource(resource, math.max(0, amount - (resourceDone[resource] or 0)))
				end
			end
		end
	end

	self.runnable = hasResource
	self.enabled = self.runnable and self.enabled
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
