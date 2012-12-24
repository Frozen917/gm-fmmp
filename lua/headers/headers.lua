if not ENT.loadedHeaders then
	ENT.loadedHeaders = {}
end

for _,header in pairs(ENT.implementation) do
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
