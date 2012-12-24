if not ENT.loadedHeaders then
	ENT.loadedHeaders = {}
end

if headers then
	print("WARNING! Some headers may not have been loaded")
end
local headers = {}

for _,header in ipairs(ENT.implementation) do
	table.insert(headers, header)
end

for _,header in ipairs(headers) do
	if not ENT.loadedHeaders[header] then
		include("headers/" .. header .. "/shared.lua")
		if SERVER then
			include("headers/" .. header .. "/init.lua")
		elseif CLIENT then
			include("headers/".. header .. "/cl_init.lua")
		end
		ENT.loadedHeaders[header] = true
	end
end
