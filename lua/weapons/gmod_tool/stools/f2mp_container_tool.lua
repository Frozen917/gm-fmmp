TOOL.Mode       = "f2mp_container_tool"
TOOL.Category   = "F2MP GameMode"
TOOL.Name       = "Container Tool"
TOOL.Tab 		= "F2MP"


TOOL.ClientConVar["type"] = "sb_small_energycell"
TOOL.ClientConVar["freeze"] = "0"
TOOL.ClientConVar["autohold"] = "0"

-- CLIENT
if CLIENT then
    language.Add("Tool.f2mp_container_tool.name", "Container Tool" )
    language.Add("Tool.f2mp_container_tool.desc", "Create a container!" )
    language.Add("Tool.f2mp_container_tool.0", "Left click to create a container")

	function TOOL.BuildCPanel(CPanel)
		CPanel:AddControl("Header", { Text = "Container Tool", Description = "Spawns a container" })
		local panel = vgui.Create("DPanel", CPanel)
		panel:SetSize(CPanel:GetWide() - 20, 30)
		CPanel:AddItem(panel)
		
		local checkbox = vgui.Create("DCheckBoxLabel", CPanel)
			checkbox:SetText("Freeze ?")
			checkbox:SetConVar("f2mp_container_tool_freeze")
			checkbox:SizeToContents()
			CPanel:AddItem(checkbox)
			
		local checkbox2 = vgui.Create("DCheckBoxLabel", CPanel)
			checkbox2:SetText("Autohold ?")
			checkbox2:SetConVar("f2mp_container_tool_autohold")
			checkbox2:SizeToContents()
			CPanel:AddItem(checkbox2)
		
		local image = vgui.Create("DImage", panel)
		image:SetImage("generators/gui/selection")
		image:SetSize(150, 150)
		image:SetVisible(false)
		
		local x, y = 0, 0
		for typ,container in pairs(Devices.GetRegisteredContainers()) do
			panel:SetTall(panel:GetTall() + 150)
			local spawnIcon = vgui.Create("DModelPanel", panel)
			spawnIcon:SetPos(x, y)
			spawnIcon:SetSize(150, 150)
			spawnIcon:SetCamPos(Vector(170, 170, 0))
			spawnIcon:SetFOV(80)
			spawnIcon:SetLookAt(Vector(0, 0, 0))
			spawnIcon:SetToolTip(container.name)
			spawnIcon:SetModel(container.model)
			spawnIcon.DoClick = function(icon)
				image:SetPos(icon:GetPos())
				image:SetVisible(true)
				RunConsoleCommand("f2mp_container_tool_type", typ)
			end
			
			local lbl = vgui.Create("DLabel", panel)
			lbl:SetText(container.name)
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
		local spawnFunc = Util.GetStoredMember("f2mp_holdable_container", "SpawnFunction")
		if spawnFunc then
			local entity = spawnFunc(Util.GetStoredEntity("f2mp_holdable_container"), self:GetOwner(), trace, self:GetClientInfo("freeze") == "1", typ)
			if self:GetClientInfo("autohold") == "1" then
				local holder = trace.Entity
				if holder and holder.type == "HOLDER" then
					local found = false
					local distance = -1
					local nearest = nil
					for _,slot in ipairs(holder:GetSlots()) do
						if ( distance == -1 or holder:WorldToLocal(trace.HitPos):Distance(slot:GetPos()) < distance) and slot:GetGenerator() == nil and slot:GetSize() == entity:GetSlotSize() then
							distance = holder:WorldToLocal(trace.HitPos):Distance(slot:GetPos())
							nearest = slot
							found = true
						end
					end
					if nearest then
						nearest:Grab(entity)
					end
				end
			end
		else
			self:GetOwner():PrintMessage(HUD_PRINTTALK, "Unable to find a valid spawn function")
			return false
		end
	end
	return true
end

