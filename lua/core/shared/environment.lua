Environment = {}
Environment.__index = Environment

function Environment.New(sName, nRadius, vPosition, tResources, tCharacteristics, bIsplanet)
	local env = {}
	setmetatable(env, Environment)
	env.name = sName or "env" .. CurTime()*10^12
	env.radius = nRadius or 0
	env.position = vPosition or Vector(0, 0, 0)
	
	env.characteristics = tCharacteristics or {}
	env.characteristics.players_gravity = env.characteristics.players_gravity or 0
	env.characteristics.ents_gravity = env.characteristics.ents_gravity or 0
	env.characteristics.temperature = env.characteristics.temperature or 0
	
	env.isplanet = bIsplanet or false
	env.volume = math.floor((4/3)*math.pi*(env.radius^3)/100)
	env.resources = tResources or {}
	for k,v in pairs(env.resources) do
		env.resources[k] = math.floor(env.volume*((env.resources[k] or 0)/100))
	end
	return env
end

function Environment:GetTemperature()
	return self:GetCharacteristic("temperature")
end

function Environment:GetCharacteristic(sCharac)
	
	return self.characteristics[sCharac] or 0
end

function Environment:SetCharacteristic(sCharac, value)
	self.characteristics[sCharac] = value
end

function Environment:GetRadius()
	return self.radius
end

function Environment:GetPos()
	return self.position
end

function Environment:IsViable()
	return self:GetResourcePercentage("oxygen") > 20 --and self:GetTemperature() > 268.15 FIX MEH
end

function Environment:GetVolume()
	return self.volume
end

function Environment:GetResource(resource)
	
	return self.resources[resource] or 0
end

function Environment:GetResourcePercentage(resource)
	return ((self.resources[resource] or 0)/self.volume)*100
end

function Environment:Drain(resource, amount)
	self.resources[resource] = (self.resources[resource] or 0) - amount
end

function Environment:Fill(resource, amount)
	self:Drain(resource, -amount)
end

function Environment:SetPos(position)
	self.position = position
end

function Environment:GetName()
	return self.name
end

function Environment:IsPlanet()
	return self.isplanet
end
