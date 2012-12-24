ENT.implementation = { "fmp_base", "rd_entity", "holdable_entity" }
include("headers/headers.lua")

ENT.addInitFunction(function (self)
	self.resourceType = ""
end)
