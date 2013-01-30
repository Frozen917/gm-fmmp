TOOL.Mode       = "fmp_holder_tool"
TOOL.Category   = "F2MP GameMode"
TOOL.Name       = "Holder Tool"
TOOL.Tab 		= "F2MP"


TOOL.ClientConVar["type"] = "sb_small_holder"
TOOL.ClientConVar["freeze"] = "0"

-- CLIENT
if CLIENT then
    language.Add("Tool.fmp_holder_tool.name", "Holder Tool" )
    language.Add("Tool.fmp_holder_tool.desc", "Create a holder!" )
    language.Add("Tool.fmp_holder_tool.0", "Left click to create a holder")
	
	
	
end

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
		for typ,holder in pairs(Devices.GetRegisteredHolders()) do
			panel:SetTall(panel:GetTall() + 150)
			local spawnIcon = vgui.Create("DModelPanel", panel)
			spawnIcon:SetPos(x, y)
			spawnIcon:SetSize(150, 150)
			spawnIcon:SetCamPos(Vector(170, 170, 0))
			spawnIcon:SetFOV(80)
			spawnIcon:SetLookAt(Vector(0, 0, 0))
			spawnIcon:SetToolTip(holder.name)
			spawnIcon:SetModel(holder.model)
			spawnIcon.DoClick = function(icon)
				image:SetPos(icon:GetPos())
				image:SetVisible(true)
				RunConsoleCommand("fmp_holder_tool_type", typ)
			end
			
			local lbl = vgui.Create("DLabel", panel)
			lbl:SetText(holder.name)
			lbl:SetTall(50)
			lbl:SetPos(x + 170, y + 25)
			lbl:SetWrap(true)
			
			y = y + 155
		end
	end
end
-- SHARED
function TOOL:LeftClick(trace)
	if SERVER then
		local typ = self:GetClientInfo("type")
		local spawnFunction = Util.GetStoredMember("f2mp_holder", "SpawnFunction")
		if spawnFunction then
			local entity = spawnFunction(Util.GetStoredEntity("f2mp_holder"), self:GetOwner(), trace, self:GetClientInfo("freeze") == "1")
			entity:Setup(typ)
		else
			self:GetOwner():PrintMessage(HUD_PRINTTALK, "Unable to find a valid spawn function")
			return false
		end
	end
	return true
end
