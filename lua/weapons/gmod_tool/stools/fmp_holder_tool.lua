TOOL.Mode       = "fmp_holder_tool"
TOOL.Category   = "FMP GameMode"
TOOL.Name       = "Holder Tool"
TOOL.Tab 		= "FMP"


TOOL.ClientConVar["ent"] = "sb_small_holder"
TOOL.ClientConVar["freeze"] = "0"



local allowedClasses = {}

local function RegisterHolder(sName, sClass, sModel)
	list.Add("FMPHolders", {name = sName, ent = sClass, model = sModel })
	table.insert(allowedClasses, sClass)
end
-- CLIENT
if CLIENT then
    language.Add("Tool.fmp_holder_tool.name", "Holder Tool" )
    language.Add("Tool.fmp_holder_tool.desc", "Create a holder!" )
    language.Add("Tool.fmp_holder_tool.0", "Left click to create a holder")
	
	
	
end

RegisterHolder("Generic 1x Small Holder", "sb_small_holder", "models/mandrac/lgm/genholder_small_single.mdl")
RegisterHolder("Smallbridge 8x Small Holder - SW", "sb_smallbridge_multi_holder", "models/mandrac/lgm/genholder_small_sw.mdl")
RegisterHolder("SmallBridge 2x Large Holder - SW", "sb_smallbridge_holder", "models/mandrac/lgm/genholder_sw.mdl")


if CLIENT then

	function TOOL.BuildCPanel(CPanel)
		CPanel:AddControl("Header", { Text = "Holder Tool", Description = "Spawns a holder" })
		local panel = vgui.Create("DPanel", CPanel)
		panel:SetSize(CPanel:GetWide() - 20, 30)
		CPanel:AddItem(panel)
		
		local checkbox = vgui.Create("DCheckBoxLabel", CPanel)
			checkbox:SetText("Freeze ?")
			checkbox:SetConVar("fmp_holder_tool_freeze")
			checkbox:SizeToContents()
			CPanel:AddItem(checkbox)
		
		local image = vgui.Create("DImage", panel)
		image:SetImage("generators/gui/selection")
		image:SetSize(150, 150)
		image:SetVisible(false)
		
		local x, y = 0, 0
		for _,v in ipairs(list.Get("FMPHolders")) do
			panel:SetTall(panel:GetTall() + 150)
			local spawnIcon = vgui.Create("DModelPanel", panel)
			spawnIcon:SetPos(x, y)
			spawnIcon:SetSize(150, 150)
			spawnIcon:SetCamPos(Vector(170, 170, 0))
			spawnIcon:SetFOV(80)
			spawnIcon:SetLookAt(Vector(0, 0, 0))
			spawnIcon:SetToolTip(v.name)
			spawnIcon:SetModel(v.model)
			spawnIcon.DoClick = function(icon)
				image:SetPos(icon:GetPos())
				image:SetVisible(true)
				RunConsoleCommand("fmp_holder_tool_ent", v.ent)
			end
			
			local lbl = vgui.Create("DLabel", panel)
			lbl:SetText(v.name)
			lbl:SetTall(50)
			lbl:SetPos(x + 170, y + 25)
			lbl:SetWrap(true)
			
			y = y + 160
		end
	end
end
-- SHARED
function TOOL:LeftClick(trace)
	if SERVER then
		local className = self:GetClientInfo("ent")
		if table.HasValue(allowedClasses, className) then
				local spawnFunction = Util.GetStoredMember(className, "SpawnFunction")
				spawnFunction(Util.GetStoredEntity(className), self:GetOwner(), trace, self:GetClientInfo("freeze") == "1")
			return true
		else
			self:GetOwner():PrintMessage(HUD_PRINTTALK, className.." is not a valid holder!")
			return false
		end
	end
	return true
end
