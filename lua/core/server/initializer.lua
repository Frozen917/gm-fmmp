local Initializer = {}

function Initializer.GeneratePlanets()
	local planets = ents.FindByClass("logic_case")
	for i=1,#planets do
		local keys = planets[i]:GetKeyValues()
		if keys["Case01"] == "planet" or keys["Case01"] == "planet2" then
			local name = "planet" .. i
			local ngravity = tonumber(keys["Case03"])
			local radius = tonumber(keys["Case02"])
			local pos = planets[i]:GetPos()
			local resources = {}
			resources["oxygen"] = tonumber(keys["Case09"])
			resources["co2"] = tonumber(keys["Case10"])
			resources["nitrogen"] = tonumber(keys["Case11"])
			local characteristics = {ents_gravity = ngravity, players_gravity = ngravity, wind=1, noclip=1 }
			Universe.CreateEnvironment(name, radius, pos, resources, characteristics, true)
			print("New planet added: " .. name)
		end
	end
end
hook.Add("InitPostEntity", "GeneratePlanets", Initializer.GeneratePlanets)