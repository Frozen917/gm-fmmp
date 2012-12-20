TOOL.Mode       = "fmp_debug_tool"
TOOL.Category   = "Debugging Tools"
TOOL.Name       = "Debug Tool"
TOOL.Tab        = "FMP"


-- CLIENT
if CLIENT then
    language.Add("Tool.fmp_debug_tool.name", "Debug Tool" )
    language.Add("Tool.fmp_debug_tool.desc", "Useful for debugging!" )
elseif SERVER then
-- SERVER

	function TOOL:RightClick(trace)
		local ent = trace.Entity
		if ent and ent:GetType() == "CONTAINER" then
			self:GetOwner():ChatPrint(tostring(ent))
			for k,v in pairs(ent.resources) do
				self:GetOwner():ChatPrint(string.format("\t%s : %d / %d (at %d/sec)",string.upper(k), v.amount, v.maxamount, v.flow))
			end
		end
	end
	
	
end