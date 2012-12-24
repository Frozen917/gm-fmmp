ENT.implementation = { "fmp_entity", "rd_entity", "pluggable_entity" }
include("headers/headers.lua")

ENT.addInitFunction(function(self)
	self.type = "HOLDER"
end)
