Universe = {}
Environments = {}
Space = Environment.New("space")

function Universe.GetEntityEnvironments(ent)
	local inEnvironments = {}
	for i=1,#Environments do
		local environment = Environments[i]
		local distance = ent:GetPos():Distance(environment:GetPos())
		if distance < environment:GetRadius() then
			table.insert(inEnvironments, {distance, environment})
		end
	end
	table.sort(inEnvironments, function(a,b) return a[1]<b[1] end)
	local envs = {}
	for i,v in ipairs(inEnvironments) do table.insert(envs, v[2]) end
	table.insert(envs, Space)
	return envs
end

function Universe.GetEnvironment(name)
	if name == "space" then return Space end
	for i=1,#Environments do
		local environment = Environments[i]
		if environment:GetName() == name then return environment end
	end
end

function Universe.SetGravityOnEnt(entity)
	if entity:IsPlayer() then
		local gravity = entity:GetEnvCharacteristic("players_gravity")
		if gravity == 0 then 
			entity:SetGravity(0.000001)
		else
			entity:SetGravity(gravity)
		end
	else
		local gravity = entity:GetEnvCharacteristic("ents_gravity")
		if gravity == 0 then
			entity:GetPhysicsObject():EnableGravity(false)
		else 
			entity:GetPhysicsObject():EnableGravity(true)
		end
	end
end

function Universe.CreateEnvironment(...)
	local environment = Environment.New(...)
	table.insert(Environments, environment)
	return environment
end

function Universe.RemoveEnvironment(environment)
	for i=1,#Environments do
		if environment == Environments[i] then
			table.remove(Environments, i)
		end
	end
end

function Universe.UpdateGravityOnEnt(entity)
	Universe.SetGravityOnEnt(entity)
end
hook.Add("EntityEnteredNewEnvironment", "SimulateEntsGravity", Universe.UpdateGravityOnEnt)
