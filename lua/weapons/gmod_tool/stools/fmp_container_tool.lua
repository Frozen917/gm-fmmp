TOOL.Mode       = "fmp_container_tool"
TOOL.Category   = "FMP GameMode"
TOOL.Name       = "Container Tool"
TOOL.Tab 		= "FMP"


TOOL.ClientConVar["ent"] = "sb_small_energycell"
TOOL.ClientConVar["freeze"] = "0"
TOOL.ClientConVar["autohold"] = "0"


local allowedClasses = {}

local function RegisterContainer(sName, sClass, sModel)
	list.Add("FMPContainers", {name = sName, ent = sClass, model = sModel })
	table.insert(allowedClasses, sClass)
end
-- CLIENT
if CLIENT then
    language.Add("Tool.fmp_container_tool.name", "Container Tool" )
    language.Add("Tool.fmp_container_tool.desc", "Create a container!" )
    language.Add("Tool.fmp_container_tool.0", "Left click to create a container")
	
	
	
end

RegisterContainer("Small Energy Cell", "sb_small_energycell", "models/mandrac/lgm/energycell_s.mdl")
RegisterContainer("Small Oxygen Tank", "sb_small_oxygentank", "models/mandrac/lgm/gascan.mdl")



if CLIENT then
	local function paintOutlined(object)
		local x,y = object:GetPos()
		draw.RoundedBox(2, x, y, object:GetWide(), object:GetTall(), Color(25, 25, 25))
		local bgcolor
		if object.GetBackgroundColor then
			bgcolor = object:GetBackgroundColor()
		else
			bgcolor = Color(255, 255, 255)
		end
		draw.RoundedBox(2, x + 2, y + 2, object:GetWide() - 4, object:GetTall() - 4, bgcolor)
		object:originalPaint()
	end


	
	
	function TOOL.BuildCPanel(CPanel)
		CPanel:AddControl("Header", { Text = "Container Tool", Description = "Spawns a container" })
		local panel = vgui.Create("DPanel", CPanel)
		panel:SetSize(CPanel:GetWide() - 20, 30)
		CPanel:AddItem(panel)
		
		local checkbox = vgui.Create("DCheckBoxLabel", CPanel)
			checkbox:SetText("Freeze ?")
			checkbox:SetConVar("fmp_container_tool_freeze")
			checkbox:SizeToContents()
			CPanel:AddItem(checkbox)
			
		local checkbox2 = vgui.Create("DCheckBoxLabel", CPanel)
			checkbox2:SetText("Autohold ?")
			checkbox2:SetConVar("fmp_container_tool_autohold")
			checkbox2:SizeToContents()
			CPanel:AddItem(checkbox2)
		
		local image = vgui.Create("DImage", panel)
		image:SetImage("generators/gui/selection")
		image:SetSize(150, 150)
		image:SetVisible(false)
		
		local x, y = 0, 0
		for _,v in ipairs(list.Get("FMPContainers")) do
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
				RunConsoleCommand("fmp_container_tool_ent", v.ent)
			end
			
			local lbl = vgui.Create("DLabel", panel)
			lbl:SetText(v.name)
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
		local className = self:GetClientInfo("ent")
		if table.HasValue(allowedClasses, className) then
				--local ent = scripted_ents.GetStored(className).t
				local spawnFunc = Util.GetStoredMember(className, "SpawnFunction")
				if spawnFunc then
					local entity = spawnFunc(Util.GetStoredEntity(className), self:GetOwner(), trace, self:GetClientInfo("freeze") == "1")
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
				
			return true
		else
			self:GetOwner():PrintMessage(HUD_PRINTTALK, className.." is not a valid container!")
			return false
		end
	end
	return true
end
