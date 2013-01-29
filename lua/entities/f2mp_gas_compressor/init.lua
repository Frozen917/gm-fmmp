AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function ENT:SpawnFunction(spawner, trace)
	local entity = ents.Create("sb_gas_compressor")
	entity:SetPos(trace.HitPos + trace.HitNormal*23) 
    entity:Spawn()
    entity:Activate()
	undo.Create("SmallBridge_Generator_holder")
		undo.AddEntity(entity)
		undo.SetPlayer(spawner)
		undo.SetCustomUndoText("Undone SmallBridge Generator Holder")
	undo.Finish()
end

function ENT:ProcessResources()
	local holdable1 = self:GetSlots()[1]:GetGenerator()
	local holdable2 = self:GetSlots()[2]:GetGenerator()
	if (not holdable1 or holdable1:GetType() != "FILTER") and (not holdable2 or holdable2:GetType() != "FILTER") then return end

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

		-- Distribute gas
		local gas1 = nil
		local gas2 = nil
		if holdable1 and holdable1:GetType() == "FILTER" then
			gas1 = holdable1:GetFilterType()
			print(gas1)
		end
		if holdable2 and holdable2:GetType() == "FILTER" then
			gas2 = holdable2:GetFilterType()
			print(gas2)
		end
		local resources = {}
		if gas1 and holdable2 and holdable2:GetType() == "CONTAINER" and holdable2.resources[gas1] then
			resources[gas1] = self.outputRates["generic"]
			holdable2:Run(resources)
		elseif gas2 and holdable1 and holdable1:GetType() == "CONTAINER" and holdable1.resources[gas2] then
			resources[gas2] = self.outputRates["generic"]
			holdable1:Run(resources)
		elseif holdable1 and holdable1:GetType() == "FILTER" then
			self.resourceCache[holdable1:GetFilterType()] = self.outputRates["generic"]
		elseif holdable2 and holdable2:GetType() == "FILTER" then
			self.resourceCache[holdable2:GetFilterType()] = self.outputRates["generic"]
		elseif holdable1 and holdable1:GetType() == "FILTER" and holdable2 and holdable2:GetType() == "FILTER" then
			self.resourceCache[holdable1:GetFiltreType()] = self.outputRates["generic"]/2
			self.resourceCache[holdable2:GetFiltreType()] = self.outputRates["generic"]/2
		end
	end

	self.runnable = hasResource
	self.enabled = self.runnable and self.enabled
end

function ENT:TakeResource(resource, amount)
	-- Take and distribute the resources
	local taken = 0
	for _,slot in ipairs(self:SortSlots()) do
		if not slot:IsFree() then
			taken = taken + slot:GetGenerator():TakeResource(resource, math.max(0, amount - taken))
		end
	end
	local missing = math.max(0, amount - taken)
	if missing > 0 then
		if missing <= (self.resourceCache[resource] or 0) then
			taken = taken + missing
			self.resourceCache[resource] = self.resourceCache[resource] - missing
		else
			taken = taken + (self.resourceCache[resource] or 0)
			self.resourceCache[resource] = 0
		end
	end
	return taken
end

function ENT:GetType()
	return "GENERATOR"
end
