ENT.implementation = { "fmp_entity", "rd_entity", "holdable_entity" }
include("headers/headers.lua")

ENT.addInitFunction(function(self)
	self.type = "GENERATOR"
end)
