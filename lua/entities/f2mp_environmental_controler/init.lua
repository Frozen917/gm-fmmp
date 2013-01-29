AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function ENT:OnRemove()
	self.BaseClass.OnRemove(self)
	Universe.RemoveEnvironment(self.generated)
	ResourceDistribution.RemoveDevice(self)
	self.sound:Stop()
end

function ENT:Think()
	if self.runnable and self.enabled then
		self.generated:SetPos(self:GetPos())
		if CurTime() - self.lastSeqReset > 0.5 then
			self.lastSeqReset = CurTime()
			self:ResetSequence(self:LookupSequence("on"))
		end
	elseif self.generated then
		self:UpdateStatus()
	end
	self:NextThink(CurTime())
	return true
end

function ENT:Use()
	self.enabled = not self.enabled
	self:UpdateStatus()
end

function ENT:GetFreePlug(vClosest)	-- Local to entity
	local plug = nil
	for i=1,#self:GetPlugs() do
		if not self.plugs[i]:IsPlugged() then
			if plug == nil then plug = self.plugs[i]
			else
				if self.plugs[i]:GetPos():Distance(vClosest) < plug:GetPos():Distance(vClosest) then
					plug = self.plugs[i]
				end
			end
		end
	end
	return plug
end

function ENT:GetPlugByID(nIndex)
	for i=1,#self.plugs do
		if self.plugs[i]:GetID() == nIndex then
			return self.plugs[i]
		end
	end
end

function ENT:GetPlugs()
	return self.plugs
end

function ENT:ProcessResources()
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
		if (resourceCounter[resource] or 0) < amount then
			hasResource = false
		end
	end

	-- Consume resources
	if hasResource and self.enabled and self.runnable then
		local resourceDone = {}
			for _,plug in ipairs(self:GetPlugs()) do
			if plug:IsPlugged() then
				for resource,amount in pairs(self.inputRates) do
					resourceDone[resource] = plug:GetOtherPlug():GetEntity():TakeResource(resource, math.max(0, amount - (resourceDone[resource] or 0)))
				end
			end
		end

		-- Take as mush oxygen as possible
		local goal = self.generated:GetVolume()*0.21 - self.generated:GetResource("oxygen")
		local oxygen = 0
		if goal > 0 then
			for _,plug in ipairs(self:GetPlugs()) do
				if plug:IsPlugged() then
					local taken = plug:GetOtherPlug():GetEntity():TakeResource("oxygen", math.max(0, goal-oxygen))
					oxygen = oxygen + taken
					self.generated:Fill("oxygen", taken)
				end
			end
		end
	end

	self.runnable = hasResource
	self.enabled = self.runnable and self.enabled
end

function ENT:UpdateStatus()
	if self.runnable and self.enabled then
		self.generated = Universe.CreateEnvironment(nil, 500, self:GetPos(), {oxygen=0}, {ents_gravity = -1, players_gravity = 1, wind = -1, noclip = -1})
		self.sound:Play()
		self.lastSeqReset = CurTime()
		self:ResetSequence(self:LookupSequence("on"))
	else
		Universe.RemoveEnvironment(self.generated)
		self.generated = nil
		self.lastSeqReset = 0
		self.sound:Stop()
		self:ResetSequence(self:LookupSequence("idle"))
	end
end
